package org.fkjava.smuGuahao.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;

import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.utils.Constants;
import org.fkjava.smuGuahao.utils.DateUtils;
import org.fkjava.smuGuahao.utils.PageModel;

import org.fkjava.smuGuahao.vo.ScheduleData;
import org.fkjava.smuGuahao.vo.WorkInfo;

@WebServlet("/ScheduleServlet")
public class ScheduleServlet extends BaseServlet {
	@Override
	protected void requestSon() {
		if("list".equals(method)){
			list();
		}else if("addSchedule".equals(method)){
			addSchedule();
		}else if("save".equals(method)){
			save();
		}
	}

	private void save() {
		try {
			// 
			ScheduleData scheduleData = new ScheduleData();
			String id = request.getParameter("id");
			Doctor doc = new Doctor();
			doc.setId(Integer.valueOf(id));
			scheduleData.setDoctor(doc);
			// 日期 工作状态  接诊数量 
			System.out.println(id); 
			// 七天的信息 
			List<WorkInfo> workInfos = new ArrayList<>();
			scheduleData.setWorkInfos(workInfos);
			for(int i = 0 ; i < 7 ; i++ ){
				String date = request.getParameter("date_"+i);
				String num = request.getParameter("num_"+i);
				String morning = request.getParameter("morning_"+i);
				String after = request.getParameter("after_"+i);
				String night = request.getParameter("night_"+i);
				System.out.println(morning);
				WorkInfo workInfo = new WorkInfo() ;
				workInfo.setDate(DateUtils.getDateEEE(date));
				workInfo.setNum(Integer.valueOf(num));
				workInfo.setWork_timer(Constants.getWorkTimerStatus(morning, after, night));
				workInfos.add(workInfo);
			}
			guahaoService.saveScheduleData(scheduleData);
			request.setAttribute("tip", "排诊成功！");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("tip", "排诊失败！");
		}
		addSchedule();
		
	}

	private void addSchedule() {
		try {
			String id = request.getParameter("id"); 
			String methodId = request.getParameter("methodId"); 
			Doctor doctor = guahaoService.getDocById(id);
			// 这个医生从第八天开始的排诊信息 
			List<ScheduleData> scheduleDatas = guahaoService.loadDocscheduleDatas(doctor,"update".equals(methodId)?DateUtils.getFutureSevenDates():DateUtils.get8FutureSevenDates(),null);
			request.setAttribute("scheduledata", scheduleDatas.get(0));
			request.getRequestDispatcher("/WEB-INF/jsp/schedule/addSchedule.jsp")
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
			request.getRequestDispatcher("/WEB-INF/jsp/schedule/schedule.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}












