package org.fkjava.smuGuahao.action;


import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.dto.User;
import org.fkjava.smuGuahao.service.GuahaoService;
import org.fkjava.smuGuahao.service.impl.GuahaoServiceImpl;
import org.fkjava.smuGuahao.utils.Constants;
import org.fkjava.smuGuahao.utils.PageModel;

/**
 * Servlet implementation class DoctorServlet
 */
@WebServlet("/DoctorServlet")
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
			int pageSize = 0 ;
			try {
				pageIndex = Integer.valueOf(request.getParameter("pageIndex"));
			} catch (Exception e) {
				System.out.println("当前没有传输页码");
			}	
			try {
				pageSize = Integer.valueOf(request.getParameter("pageSize"));
			} catch (Exception e) {
			}
			PageModel pageModel = new PageModel();
			pageModel.setPageIndex(pageIndex);
			// 得到当前Session中的用户对象 
			User user = (User) request.getSession().getAttribute(Constants.USER_SESSION);
			//如果该用户有设置
			Integer pageSizeUser = user.getPageSize();			
			//用户没有选择展示数量
			if(pageSize == 0) {
				//如果该用户曾经没有选择过或者选择了"3",一页展示三个
				if(pageSizeUser == null ||  pageSizeUser == 3 ){							
					// 更新每页展示的数量 
					pageModel.setPageSize(3);
				}else if(pageSizeUser == 6) {
					pageModel.setPageSize(6);
				}else{
					pageModel.setPageSize(9);
				}
			}else {//用户选择了选项
				//判断选项和上次是否一样
				if(pageSize == Integer.valueOf(pageSizeUser)) {
					//如果一样,更新每页展示的数量 
					pageModel.setPageSize(Integer.valueOf(pageSizeUser));					
				}else {
					// 更新每页展示的数量 
					pageModel.setPageSize(pageSize);
					//更新数据库
					user.setPageSize(pageSize);
					guahaoService.setNewPageSize(user);					
				}
				
			}
				
			// 可能要接收两个参数 
			String name = request.getParameter("name"); // 医生姓名
			//System.out.println(name);
			String partCode = request.getParameter("partCode"); // 科室编号 
			//System.out.println(partCode);
			Doctor doctor = new Doctor();
			doctor.setName(name);
			Part part = new Part();
			part.setPartCode(partCode);
			doctor.setPart(part);
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


