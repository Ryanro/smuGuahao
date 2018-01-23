package org.fkjava.smuGuahao.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.dto.Register;
import org.fkjava.smuGuahao.dto.Schedule;
import org.fkjava.smuGuahao.dto.User;
import org.fkjava.smuGuahao.utils.Constants;
import org.fkjava.smuGuahao.utils.DateUtils;
import org.fkjava.smuGuahao.utils.PageModel;
import org.fkjava.smuGuahao.vo.ScheduleData;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends BaseServlet {
	@Override
	protected void requestSon() {
		if("list".equals(method)){
			list();
		}else if("addRegister".equals(method)){
			addRegister();
		}else if("save".equals(method)){
			save();
		}
	}
	private void save() {
		try {
			Register register = new Register();
			int doctorId = Integer.valueOf(request.getParameter("id"));
			register.setDoctorId(doctorId);
			User user = (User) request.getSession().getAttribute(Constants.USER_SESSION);
			int userId=user.getId();
			register.setUserId(userId);		
			String[] date1 = request.getParameterValues("box");
			String date2 = date1[0];
			String date = date2.substring(0,4)+date2.substring(5,7)+date2.substring(8,10);
			System.out.println(date);
			register.setDate(date);
			guahaoService.addNewRegister(register);
			guahaoService.decnum(date,doctorId);
			request.setAttribute("tip", "挂号成功！");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("tip", "挂号失败！");
		}
		
		addRegister();
		
	}
	private void addRegister() {
		try {
			String id = request.getParameter("id"); 
			String methodId = request.getParameter("methodId"); 
			Doctor doctor = guahaoService.getDocById(id);
			// 这个医生从第八天开始的排诊信息 
			List<ScheduleData> scheduleDatas = guahaoService.loadDocscheduleDatas(doctor,"update".equals(methodId)?DateUtils.getFutureSevenDates():DateUtils.get2FutureSevenDates(),null);
			request.setAttribute("scheduledata", scheduleDatas.get(0));
			request.getRequestDispatcher("/WEB-INF/jsp/register/addRegister.jsp")
			.forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	private void list() {
		try {
			int pageIndex = 0 ;
			int pageSize = 5 ;
			try {
				pageIndex = Integer.valueOf(request.getParameter("pageIndex"));
			} catch (Exception e) {
				System.out.println("当前没有传输页码");
			}	
			PageModel pageModel = new PageModel();
			pageModel.setPageIndex(pageIndex);
			pageModel.setPageSize(pageSize);			
			String name = request.getParameter("name");
			String partCode = request.getParameter("partCode");
			Doctor doctor = new Doctor() ;
			doctor.setName(name);
			Part part = new Part();
			part.setPartCode(partCode);
			doctor.setPart(part);
			List<Part> parts  = guahaoService.findAllParts();
			request.setAttribute("parts", parts);
			request.setAttribute("dates", DateUtils.getFutureSevenDates());
			List<ScheduleData> scheduleDatas = guahaoService.loadDocscheduleDatas(doctor,DateUtils.getFutureSevenDates(),pageModel);
			request.setAttribute("scheduleDatas", scheduleDatas);
			request.setAttribute("pageModel", pageModel);
			request.getRequestDispatcher("/WEB-INF/jsp/register/register.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}