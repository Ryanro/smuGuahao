<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL 
 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>挂号系统-医生管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
<!-- 导入bootStrap的库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/easyUI/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/easyUI/easyui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/blockUI/jquery.blockUI.js"></script>
<style type="text/css">
.thumbnail:hover {
	border: 1px solid #11a9e2;
	background: #dddddd;
}
</style>
<script type="text/javascript">
	function deleteById(id){
		// 根据医生的编号删除对应的医生信息 
		// 提示:
		$.messager.confirm('删除医生信息', '您确认要删除该信息吗?', function(r){
			if (r){
				// 删除信息 ，并且在某条件删除某信息后回到的页面依旧在该条件下
				window.location = "${pageContext.request.contextPath }/DoctorServlet?method=delete&id="+id
						+"&name=${doctor.name}&partCode=${doctor.partCode}";
					
			}
		});
	}
	
	$(function(){
		// 如果第一页,那么首页和上一页禁用 
		if("${pageModel.pageIndex}" == 1){
			$("#first,#pre").addClass("disabled");
		}
		if("${pageModel.pageIndex}" == "${pageModel.pageCount}"){
			$("#next,#last").addClass("disabled");
		}
		
		// 给下拉框绑定一个点击切换事件 
		$("#partCode").change(function(){
			 // 立即出发查询 :立即提交整个表单
			 $(".form-horizontal").submit();
		});
		
		// 绑定一个按键事件，监听回车键即可
 		$(document).keydown(function(event){
 			if(event.keyCode == 13){
 				// 触发登录 
 				$(".form-horizontal").trigger("click");
 			}
 		});
 	// 页面切换事件 
		$("#changePageSize").change(function(){
			window.location = "${pageContext.request.contextPath }/DoctorServlet?method=list&pageSize="+this.value
			+"&name=${doctor.name}&partCode=${doctor.partCode}";
		});
		
		$("#changePageSize").val("${pageModel.pageSize}");
	});
	
</script>
</head>
<body style="width: 98%; height: 100%;">

		<!-- 工具按钮区 -->
		<form class="form-horizontal"
			action="${pageContext.request.contextPath }/DoctorServlet?method=list"
			method="post" style="padding-left: 10px;">
			<table class="table-condensed">
				<tbody>
					<tr>
						<td><input name="name" type="text" class="form-control"
							placeholder="医生姓名" value="${doctor.name}"></td>
						<td><select class="btn btn-default" placeholder="部门"
							id="partCode" name="partCode"  >
								<option value="">==请选择科室==</option>
								<c:forEach items="${parts}" var="part">
								//保留上次点击的科室于对话框 
									<c:if test="${doctor.partCode == part.partCode}">
										<option selected="selected" value="${part.partCode}">${part.name }</option>
									</c:if>
									<c:if test="${doctor.partCode != part.partCode}">
										<option  value="${part.partCode}">${part.name }</option>
									</c:if>
								</c:forEach>
						</select></td>
						<td>
						<td>
							<button type="submit" id="selectUser" class="btn btn-info">
								<span class="glyphicon glyphicon-search"></span>&nbsp;查询
							</button> <a id="addDoc" class="btn btn-success"><span
								class="glyphicon glyphicon-plus"></span>&nbsp;添加</a>

						</td>
					</tr>
				</tbody>
			</table>
		</form>
		  <div class="row">
			<c:forEach items="${doctors}" var="doc">
				<div class="col-md-4 col-lg-4">
					<span class="thumbnail" id="doc_${ doc.id}" style="padding: 12px;"> <a
						class="label label-danger" href="javascript:deleteById(${doc.id});">删除</a> <!-- javascript:deleteById 增加一层校验，用动态脚本来写  -->
						<img width="150" height="200" src="<c:url value="/images/doctor/${doc.image }"/>" alt="...">
						<p style="height: 20px; overflow: hidden; text-align: center;">${doc.name}</p>
						<p style="height: 50px; text-shadow: black;">
							<span>${doc.info}</span>
						</p> </a>
					</span>
				</div>
			</c:forEach>
		</div>
		
		<center>
		<div class="row" >
		   <!-- 分页标签 -->
		   <nav>
			  <ul class="pagination">
			    <li id="first">
			      <a href="${pageContext.request.contextPath }/DoctorServlet?method=list&pageIndex=1&name=${doctor.name}&partCode=${doctor.partCode}">首页</a>
			    </li>
			    <li id="pre"><a href="${pageContext.request.contextPath }/DoctorServlet?method=list&pageIndex=${pageModel.pageIndex - 1}&name=${doctor.name}&partCode=${doctor.partCode}">上一页</a></li>
			    <li id="next"><a href="${pageContext.request.contextPath }/DoctorServlet?method=list&pageIndex=${pageModel.pageIndex+1}&name=${doctor.name}&partCode=${doctor.partCode}">下一页</a></li>
			    <li id="last">
			      <a href="${pageContext.request.contextPath }/DoctorServlet?method=list&pageIndex=${pageModel.pageCount}&name=${doctor.name}&partCode=${doctor.partCode}">
			              尾页
			      </a>
			    </li>
			    <li>
			      <a>
			        <select id="changePageSize" style="height: 20px;">
							<option value="3">3</option>
							<option value="6">6</option>
							<option value="9">9</option>
					</select>
					</a>
			    </li>
			     <li>
			     <a>总数据量${pageModel.totalCount}，当前<span style="color: red;">${pageModel.pageIndex}</span>/${pageModel.pageCount}</a>
			    </li>
			  </ul>
			</nav>
		</div>
		</center>
</body>
</html>