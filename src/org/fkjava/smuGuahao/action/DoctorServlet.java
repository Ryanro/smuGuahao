package org.fkjava.smuGuahao.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.service.GuahaoService;
import org.fkjava.smuGuahao.service.impl.GuahaoServiceImpl;
import org.fkjava.smuGuahao.utils.PageModel;

/**
 * Servlet implementation class DoctorServlet
 */
@WebServlet("/DoctorServlet")
//public class DoctorServlet extends HttpServlet {
//	// 得到业务层对象
//	private GuahaoService guahaoService = new GuahaoServiceImpl();
//	private HttpServletRequest request;
//	private HttpServletResponse response;
//	
//	@Override
//	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		this.request=request;
//		this.response=response; 
//		String method = request.getParameter("method");
//		 if("list".equals(method)) {
//			 list();
//		 }
//	}
public class DoctorServlet extends BaseServlet {
	@Override
	protected void requestSon() {
		if ("list".equals(method)) {
			list();
		}else if("delete".equals(method)){
			delete();
		}
	}

	private void delete() {
		try {
			String id = request.getParameter("id");
			guahaoService.deleteDocById(id);
			// 删除完成以后要重新回查医生信息界面（回查）
			list();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void list() {
		//查询所有的医生信息展示到医生界面
		try {			
			// 开始分页查询：默认分第一页查询，有可能接收其他要求
			int pageIndex = 0 ;
			try {
				pageIndex = Integer.valueOf(request.getParameter("pageIndex"));
			} catch (Exception e) {
				System.out.println("当前没有传输页码");
			}						
			PageModel pageModel = new PageModel();
			pageModel.setPageIndex(pageIndex);
						
			// 可能要接收两个参数 
			String name = request.getParameter("name"); // 医生姓名
			String partCode = request.getParameter("partCode"); // 科室编号 
			Doctor doctor = new Doctor();
			doctor.setName(name);
			doctor.setPartCode(partCode);
			List<Doctor> doctors = guahaoService.findAllDocs(doctor,pageModel);
			List<Part> parts  = guahaoService.findAllParts();
			request.setAttribute("doctor", doctor);
			request.setAttribute("parts", parts);
			request.setAttribute("doctors", doctors);
			request.setAttribute("pageModel", pageModel);
			request.getRequestDispatcher("/WEB-INF/jsp/doctor/doctor.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
