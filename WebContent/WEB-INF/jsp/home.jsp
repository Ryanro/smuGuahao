 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		 	<form id="updateSelfForm" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/identity/user/updateSelf.jspx"  style="margin-top: 20px;">
				<div class="form-group">
					<label class="col-sm-2 control-label">登录名称</label>
					<div class="col-sm-3">
						<button class="btn" style="background: #11a9e2;color: #ffffff;" disabled="disabled" type="button">
						  ${user_session.loginName} <span class="badge"></span>
						</button>				
					</div>
					<label class="col-sm-2 control-label">用户姓名</label>
					<div class="col-sm-3">
						<input type="text" id="name" name="name" value="${user_session.name}"  class="form-control" placeholder="请输入您的电子邮件">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">性别</label>
					<div class="col-sm-3">
						<select name="sex" id="sex" class="btn btn-default" >
							<option value="1">男</option>
							<option value="2">女</option>
						</select>
					</div>
					<label class="col-sm-2 control-label">部门</label>
					<div class="col-sm-3">
						<select id="deptSelect" name="dept.id" class="btn btn-default" id="deptSelect" name="dept.id"></select>
					</div>
				</div>
					<div class="form-group">
					<label class="col-sm-2 control-label">职位</label>
					<div class="col-sm-3">
						<select id="jobSelect" name="job.code" class="btn btn-default" id="jobSelect" name="job.code"></select>	
					</div>
					<label class="col-sm-2 control-label">邮箱</label>
					<div class="col-sm-3">
						<input id="email" name="email"  type="text" value="${email}" class="form-control" placeholder="请输入您的电子邮件">
					</div>
				</div>
					<div class="form-group">
					<label class="col-sm-2 control-label">电话</label>
					<div class="col-sm-3">
						<input id="tel" name="tel" type="text" value="${tel}" class="form-control" placeholder="请输入您的电子邮件">
					</div>
					<label class="col-sm-2 control-label">手机</label>
					<div class="col-sm-3">
						<input id="phone" name="phone" type="text" value="${phone}" class="form-control" placeholder="请输入您的电子邮件">
					</div>
				</div>
					<div class="form-group">
					<label class="col-sm-2 control-label">问题</label>
					<div class="col-sm-3">
						<select name="question" class="btn btn-default"
						 id="question">
							<option value="1">您的生日</option>
							<option value="2">您的出生地</option>
							<option value="3">您母亲的名字</option>
						</select>
					</div>
					<label class="col-sm-2 control-label">答案</label>
					<div class="col-sm-3">
						<input id="answer" name="answer"  value="${answer}" type="text" class="form-control" placeholder="请输入您的电子邮件">
					</div>
				</div>	
				
					<div class="form-group">
					<label class="col-sm-2 control-label">QQ号码</label>
					<div class="col-sm-3">
						<input id="qqNum" name="qqNum" value="${qqNum }" type="text" class="form-control" placeholder="请输入您的电子邮件">
					</div>
					
				</div>
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
