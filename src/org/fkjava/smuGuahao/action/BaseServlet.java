package org.fkjava.smuGuahao.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.service.GuahaoService;
import org.fkjava.smuGuahao.service.impl.GuahaoServiceImpl;

/**
 * @Author Ryan
 * @Date 2018年1月2日下午7:52:01 
 * Servlet的通用模板
 */
public abstract class BaseServlet extends HttpServlet  {
	// 得到业务层对象 
	protected GuahaoService guahaoService = new GuahaoServiceImpl();
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected String method ;
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.request = request;
		this.response = response;
		request.setCharacterEncoding("UTF-8");
		method = request.getParameter("method");
		// 剩下的代码交给子类来处理，定义一个抽象方法
		requestSon();
	}

	protected abstract void requestSon();
		
}
