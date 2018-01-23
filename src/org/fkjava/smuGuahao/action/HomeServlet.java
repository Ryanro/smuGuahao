package org.fkjava.smuGuahao.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.dto.User;
import org.fkjava.smuGuahao.utils.Constants;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends BaseServlet {
	protected void requestSon() {
		if ("list".equals(method)) {
			list();
		}else if("update".equals(method)){
			update();
		}
	}
       
  
    
    private void update() {
    	try {
			Integer sex= Integer.valueOf(request.getParameter("sex"));
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String name = request.getParameter("name");
			String address = request.getParameter("address");
			// 得到当前Session中的用户对象 
			User user = (User) request.getSession().getAttribute(Constants.USER_SESSION);
			user.setAddress(address);
			user.setSex(sex);
			user.setEmail(email);
			user.setPhone(phone);
			user.setName(name);
			guahaoService.UpdateMessage(user);
			
			request.setAttribute("msg", "更新成功！");
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "更新失败！");
		}
    			list();
	}



	private void list() {
    		try {
    			User user1 = (User) request.getSession().getAttribute(Constants.USER_SESSION);
    			int id=user1.getId();
    			User user = new User();
    			user = guahaoService.SelectMessagebyId(id); 
    			request.setAttribute("user", user);
			request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);			
			} catch (Exception e) {
				
				e.printStackTrace();
			}		
	}
}



	