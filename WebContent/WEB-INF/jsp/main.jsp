<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>医院挂号系统</title>
<link href="${pageContext.request.contextPath}/css/base.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/platform.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/easyUI/easyui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/easyUI/jquery.easyui.min.js"></script>
<!-- <script type="text/javascript" src="js/menu.js"></script> -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/main.js"></script>
<script type="text/javascript">
	$(function() {
		$('#tt').tabs(
				{
					tabHeight : 40,
					onSelect : function(title, index) {
						var currentTab = $('#tt').tabs("getSelected");
						if (currentTab.find("iframe")
								&& currentTab.find("iframe").size()) {
							currentTab.find("iframe").attr("src",
									currentTab.find("iframe").attr("src"));
						}
					}
				});
	})

	// 写一个方法往easyUI中添加面板 
	function addPanel(id, url, name) {
		name = name.replace(/-/g, "");
		// 判断之前是否已经存在该面板存在就不创建新的面板 
		var exist = $('#tt').tabs('exists', name);
		if (exist) {
			// 已经存在就将该面板选中  exist
			$('#tt').tabs('select', name);
			var currentTab = $('#tt').tabs('getTab', name);
			// 刷新一下界面 
			if (currentTab.find("iframe") && currentTab.find("iframe").size()) {
				currentTab.find("iframe").attr("src",
						currentTab.find("iframe").attr("src"));
			}
		} else {
			$('#tt')
					.tabs(
							'add',
							{
								id : id,
								title : name,
								content : '<div style="width:100%;height:100%;"><iframe class="page-iframe" src="${pageContext.request.contextPath}'
										+ url
										+ '" frameborder="no"   border="no" height="100%" width="100%" scrolling="auto"></iframe></div>',
								closable : true
							});
		}
	}

	$(window).resize(function() {
		$('.tabs-panels').height($("#pf-page").height() - 46);
		$('.panel-body').height($("#pf-page").height() - 76)
	}).resize();

	var page = 0, pages = ($('.pf-nav').height() / 70) - 1;

	if (pages === 0) {
		$('.pf-nav-prev,.pf-nav-next').hide();
	}
	$(document).on('click', '.pf-nav-prev,.pf-nav-next', function() {

		if ($(this).hasClass('disabled'))
			return;
		if ($(this).hasClass('pf-nav-next')) {
			page++;
			$('.pf-nav').stop().animate({
				'margin-top' : -70 * page
			}, 200);
			if (page == pages) {
				$(this).addClass('disabled');
				$('.pf-nav-prev').removeClass('disabled');
			} else {
				$('.pf-nav-prev').removeClass('disabled');
			}
		} else {
			page--;
			$('.pf-nav').stop().animate({
				'margin-top' : -70 * page
			}, 200);
			if (page == 0) {
				$(this).addClass('disabled');
				$('.pf-nav-next').removeClass('disabled');
			} else {
				$('.pf-nav-next').removeClass('disabled');
			}

		}
	})

	function exit() {
		// 触发系统退出 
		window.location = "${pageContext.request.contextPath}/LogoutServlet";
	}
</script>

</head>
<body>
	<div class="container">
		<div id="pf-hd">
			<div class="pf-logo"">
				<img
					src="${pageContext.request.contextPath}/images/main/main_logo.png"
					alt="logo">
			</div>

			<div class="pf-nav-wrap">
				<div class="pf-nav-ww">
					<ul class="pf-nav">

					</ul>
				</div>

			</div>



			<div class="pf-user">
				<div class="pf-user-photo">
					<img style="width: 40px; height: 40px;"
						src="${pageContext.request.contextPath}/images/main/xlei.jpg"
						alt="">
				</div>
				<h4 class="pf-user-name ellipsis">徐磊</h4>
				<i class="iconfont xiala">&#xe607;</i>

				<div class="pf-user-panel">
					<ul class="pf-user-opt">
						<li><a href="javascript:;"> <i class="iconfont">&#xe60d;</i>
								<span class="pf-opt-name">用户信息</span>
						</a></li>
						<li id="exit"><a href="javascript:exit();"> <i
								class="iconfont">&#xe60e;</i> <span class="pf-opt-name">退出</span>
						</a></li>
					</ul>
				</div>
			</div>

		</div>

		<div id="pf-bd">
			<div id="pf-sider">
				<h2 class="pf-model-name">
					<span class="iconfont">&#xe64a;</span> <span class="pf-name">挂号系统</span>
					<span class="toggle-icon"></span>
				</h2>
				<!-- 展示系统左侧权限树  -->
				<ul class="sider-nav" id="sider-nav">
					<li><a href="javascript:;"> <span
							class="iconfont sider-nav-icon">&#xe611;</span> <span
							class="sider-nav-title">医院挂号系统</span> <i class="iconfont">&#xe642;</i>
					</a>
						<ul class="sider-nav-s">
							<li><a
								href="javascript:addPanel('0001' ,'/DoctorServlet?method=list','医生管理');">医生管理</a></li>
							<li><a
								href="javascript:addPanel('0002' ,'/PartServlet?method=list','科室管理');">科室管理</a></li>
							<li><a
								href="javascript:addPanel('0003' ,'/ScheduleServlet?method=list','排诊管理');">排诊管理</a></li>
							<li><a
								href="javascript:addPanel('0004' ,'/RegisterServlet?method=list','挂号管理');">挂号管理</a></li>
						</ul></li>
				</ul>
			</div>

			<!-- 面板 -->
			<div id="pf-page">
				<div class="easyui-tabs" id="tt" style="width: 100%; height: 100%;">
					<div title="当前用户" id="user" style="padding: 10px 5px 5px 10px;">
						<iframe class="page-iframe"
							src="${pageContext.request.contextPath}/HomeServlet?method=list" frameborder="no"
							border="no" height="100%" width="100%" scrolling="auto"></iframe>
					</div>
				</div>
			</div>
		</div>

		<div id="pf-ft">
			<div class="system-name">
				<i class="iconfont">&#xe6fe;</i> <span>智能办公平台&nbsp;v1.0</span>
			</div>
			<div class="copyright-name">
				<span>Copyright&nbsp;©&nbsp;2015&nbsp;-&nbsp;2016&nbsp;疯狂软件-分享知识，传递希望&nbsp;版权所有</span>
				<i class="iconfont">&#xe6ff;</i>
			</div>
		</div>
	</div>
</body>
</html>
