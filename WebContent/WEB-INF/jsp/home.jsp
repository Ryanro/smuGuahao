 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html> 
<html lang="en"> 
<head> 
    <meta charset="utf-8"> 
    <title>工作台</title> 
	<!-- 导入css样式 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyUI/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyUI/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/easyUI/easyui.css">
</head> 
<body >
	     <div class="container">
	      <div class="row info-content">
		 	<form id="updateSelfForm" class="form-horizontal" method="post" action="HomeServlet?method=update"  style="margin-top: 20px;">
				<div class="form-group">
					<label class="col-sm-2 control-label">登录名称</label>
					<div class="col-sm-3">
						<button class="btn" style="background: #11a9e2;color: #ffffff;" disabled="disabled" type="button">
						  ${user_session.loginName} <span class="badge"></span>
						</button>
						<br/><br/>			
					</div>
					<label class="col-sm-2 control-label">用户姓名</label>
					<div class="col-sm-3">
						<input type="text" id="name" name="name" value="${user.name}"  class="form-control" placeholder="请输入您的电子邮件">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">性别</label>
					<div class="col-sm-3">
						<select name="sex" id="sex" class="btn btn-default" >
							<c:choose>
								<c:when test="${user.sex == 1}">
									<option value="1" int id=user1.getId();>男</option>
									<option value="2">女</option>
								</c:when>
								<c:otherwise>
									<option value="1">男</option>
									<option value="2" selected="selected">女</option>
								</c:otherwise>
							</c:choose>
							
							
						</select>
						<br/><br/>	
					</div>
					<label class="col-sm-2 control-label">家庭地址</label>
					<div class="col-sm-3">
						<input id="address" name="address"  type="text" value="${user.address}" class="form-control" placeholder="请输入您的家庭地址">
					</div>
				</div>
					<div class="form-group">
					
					<label class="col-sm-2 control-label">邮箱</label>
					<div class="col-sm-3">
						<input id="email" name="email"  type="text" value="${user.email}" class="form-control" placeholder="请输入您的电子邮件">
						<br/><br/>	
					</div>
				</div>
					<div class="form-group">
			
					<label class="col-sm-2 control-label">手机</label>
					<div class="col-sm-3">
						<input id="phone" name="phone" type="text" value="${user.phone}" class="form-control" placeholder="请输入您的手机">
					</div>
				
				
					
					
				</div>
				<center>
				<span style="color: #ff0000;">${msg}</span>
				</center>
				<div class="form-group">
					<label class="col-sm-2 control-label"></label>
					<div class="col-sm-3">
						 <button type="submit" id="btn_submit"  class="btn btn-info">提交修改</button>
					</div>
				</div>
		 	 </form>
		    </div>
		</div>
 
</body> 
</html>
