package org.fkjava.smuGuahao.action;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.service.GuahaoService;
import org.fkjava.smuGuahao.service.impl.GuahaoServiceImpl;

/**
 * Servlet implementation class LoginServlet
 */
//@WebServlet("/LoginServlet")
//public class LoginServlet extends HttpServlet {
//	
//	/**
//	 * 
//	 */
//	private static final long serialVersionUID = 1L;
//	// 得到业务层对象
//	private GuahaoService guahaoService = new GuahaoServiceImpl();
//	private HttpServletRequest request;
//	private HttpServletResponse response;
//	
//	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		this.request=request;
//		this.response=response;
//		String method=request.getParameter("method");
//		if("getLoginJsp".equals(method)) {
//			getLoginJsp();
//		}else if("login".equals(method)) {
//			login();
//		}
//	}
@WebServlet("/LoginServlet")
//用模版
public class LoginServlet extends BaseServlet {
	@Override
	protected void requestSon() {
		 if("getLoginJsp".equals(method)){
			 getLoginJsp();
		 }else if("login".equals(method)){
			 login();
		 }
	}	
	
	private void login() {
		try {
			//接受登录的三个参数 调用业务层处理业务
			 String userId = request.getParameter("userId");
			 String passWord = request.getParameter("passWord");
			 String vcode = request.getParameter("vcode");
			 
			 Map<String, Object> result = guahaoService.login(userId,passWord,vcode,request.getSession());
			 //judge the result of the login
			 if((int)result.get("code") == 0) {
				 // login successful
				 request.getRequestDispatcher("/WEB-INF/jsp/main.jsp").forward(request, response);
			 }else {
				 //login failed 
				 String msg = result.get("msg")+"";
				 request.setAttribute("msg", msg);
				 request.setAttribute("userId", userId);
				 request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void getLoginJsp() {
		//请求转发
		try {
			request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
		} catch (Exception e) {
 			e.printStackTrace();
		};
		
	}
	

}
