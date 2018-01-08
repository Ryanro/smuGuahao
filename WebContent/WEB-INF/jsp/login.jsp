<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en"> 
<head> 
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>捷途软件--智能办公</title> 
     <link href="${pageContext.request.contextPath}/css/base.css" rel="stylesheet">
     <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
     <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/jquery-1.11.0.min.js"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyUI/jquery.easyui.min.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyUI/easyui-lang-zh_CN.js"></script>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/easyUI/easyui.css">
	<!-- 动态脚本语言：JavaScript/Jquery -->
	<Script type="text/javascript">
	//等整个html文档加载完成以后,再为验证码图片绑定点击事件，进行切换
		$(function()	{
			//定位验证码
			$("#vimg").click(function(){
				//让当前点击的验证码去重新请求一次验证码
				//去掉浏览器缓存，尾部带不同的参数(根据当前时间的不同而改变)
				$(this).attr("src","${pageContext.request.contextPath}/createCode.action?time="+new Date().getTime());
			}).mouseover(function(){ //鼠标触碰到验证码时鼠标自动变成手型
				$(this).css("cursor","pointer") 
			});
			
			// 绑定一个按键事件，监听回车键即可
     		$(document).keydown(function(event){
     			if(event.keyCode == 13){
     				// 触发登录 
     				$("#login_id").trigger("click");
     			}
     		});
			
			//为登录按钮绑定点击事件（信息为空不能登录）
			 $("#login_id").click(function(){
				 //提取登录的参数作校验
				 var userId = $("#userId").val();
				 var password = $("#password").val();
				 var vcode = $("#vcode").val();
				 //正则表达式校验
				 //定义一个变量存储最终校验结果
				 var msg="";
				 if(!/^\w{5,}$/.test(userId)){
					 msg = "请输入五个字符以上的用户名"
				 }else if(!/^\w{6,}$/.test(password)){
	     				msg = "请输入6个字符以上的密码";
	     			}else if(!/^\w{4}$/.test(vcode)){
	     				msg = "请输入4个字符的验证码";
	     			}
				 if(msg != "") {
	     				// 弹出错误提示，结束程序 
	     				//easyUI框架
	     				$.messager.alert('登录提示',msg,'error');
	     				return ;
	     			}
				// 开始登录了
	     			// 提交表单
	     			$("#loginForm").submit();
			 })
			
		});
	
	</Script>

</head> 


<body>
	<div class="login-hd">
		<div class="left-bg"></div>
		<div class="right-bg"></div>
		<div class="hd-inner">
			<span class="logo"></span>
			<span class="split"></span>
			<span class="sys-name">医院挂号系统</span>
		</div>
	</div>
	<div class="login-bd">
		<div class="bd-inner">
			<div class="inner-wrap">
				<div class="lg-zone">
					<div class="lg-box">
						<div class="panel-heading" style="background-color: #11a9e2;">
							<h3 class="panel-title" style="color: #FFFFFF;font-style: italic;">用户登陆</h3>
						</div>
						<form id="loginForm" action="LoginServlet?method=login" method="post">
						   <div class="form-horizontal" style="padding-top: 20px;padding-bottom: 30px; padding-left: 20px;">
								
								<div class="form-group" style="padding: 5px;">
									<div class="col-md-11">
										<input class="form-control" value="${userId}" id="userId" name="userId" type="text" placeholder="账号/邮箱">
									</div>
								</div>
				
								<div class="form-group" style="padding: 5px;">
									<div class="col-md-11">
										<input  class="form-control"  id="password" name="passWord" type="password" placeholder="请输入密码">
									</div>
								</div>
				
								<div class="form-group" style="padding: 5px;">
									<div class="col-md-11">
										<div class="input-group">
										<input class="form-control " id="vcode" name="vcode" type="text" placeholder="验证码">
										<span class="input-group-addon" id="basic-addon2"><img class="check-code" id="vimg" alt="" src="${pageContext.request.contextPath}/createCode.action"></span>
										</div>
									</div>
								</div>
							<span style="color: #ff0000;">${msg}</span>
						</div>
							<div class="tips clearfix">
											<label><input type="checkbox" checked="checked">记住用户名</label>
											<a href="javascript:;" class="register">忘记密码？</a>
										</div>
							<div class="enter">
								<a href="javascript:;" id="login_id" class="purchaser" >登录</a>
								<a href="javascript:;" class="supplier" onClick="javascript:window.location='main.html'">重 置</a>
							</div>
							
						</form>
					</div>
				</div>
				<div class="lg-poster"></div>
			</div>
	</div>
	</div>
	<div class="login-ft">
		<div class="ft-inner">
			<div class="about-us">
				<a href="javascript:;">关于我们</a>
				<a href="javascript:;">法律声明</a>
				<a href="javascript:;">服务条款</a>
				<a href="javascript:;">联系方式</a>
			</div>
			<div class="address">
			地址：广州市天河区车陂大岗路4号,沣宏大厦3011
			&nbsp;邮编：510000&nbsp;&nbsp;
			Copyright&nbsp;©&nbsp;2015&nbsp;-&nbsp;2016&nbsp;疯狂软件-分享知识，传递希望&nbsp;版权所有</div>
			<div class="other-info">
			建议使用火狐、谷歌浏览器，不建议使用IE浏览器！</div>
		</div>
	</div>
</body> 
</html>
<script type="text/javascript">

</script>