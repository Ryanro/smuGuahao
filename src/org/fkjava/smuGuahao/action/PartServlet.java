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

public class PartServlet extends BaseServlet {

	@Override
	protected void requestSon() {
		if("list".equals(method)){
			list();
		}else if("delete".equals(method)){
			delete();
		}else if("save".equals(method)){
			save();
		}
	}

	private void save() {
		try {
			// 接收科室名称，备注 
			String name = request.getParameter("name");
			String remark = request.getParameter("remark");
			// 缺少编号 
			String parentCode = request.getParameter("parentCode");
			// 下一个最大儿子节点编号 
			String code = guahaoService.getNextSonCode(parentCode);
			
			Part part = new Part();
			part.setName(name);
			part.setRemark(remark);
			part.setPartCode(code);
			
			guahaoService.save(part);
			request.setAttribute("tip", "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("tip", "添加失败");
		}
		list();
		
	}

	private void delete() {
		try {
			// 拿到需要删除的科室编号信息 
			// 0001,0002,0003
			String ids = request.getParameter("ids");
			// 调用业务层删除科室编号 
			guahaoService.deletePartsByCode(ids);
			request.setAttribute("tip", "删除成功");
		} catch (Exception e) {
			request.setAttribute("tip", "删除失败了");
			e.printStackTrace();
		}
		list();
	}

	private void list() {
		try {
			
			List<Part> parts = guahaoService.findAllParts();
			request.setAttribute("parts", parts);
			
			// 查询子科室 : 根据传输过来的父节点编号 
			String parentCode = request.getParameter("parentCode");
			parentCode = parentCode == null ? "" : parentCode ;
			List<Part> sonParts = guahaoService.findAllParts(parentCode);
			String parentName = guahaoService.findNameByCode(parentCode);
			request.setAttribute("sonParts", sonParts);
			parentName = parentName==null||"".equals(parentName)?"一级科室":parentName;
			request.setAttribute("parentName", parentName);
			request.setAttribute("parentCode", parentCode);
			//System.out.println(parts);
			request.getRequestDispatcher("/WEB-INF/jsp/part/part.jsp")
			.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
