package org.fkjava.smuGuahao.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.service.GuahaoService;
import org.fkjava.smuGuahao.service.impl.GuahaoServiceImpl;

/**
 * Servlet implementation class PartServlet
 */
@WebServlet("/PartServlet")

public class PartServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 得到业务层对象
	private GuahaoService guahaoService = new GuahaoServiceImpl();

	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		//通过业务层查询所有科室
		List<Part> parts = guahaoService.findAllParts();
		//打印出来
		System.out.println(parts);
		
		
	}

}