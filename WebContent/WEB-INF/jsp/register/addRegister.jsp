<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="StyleSheet"
	href="${pageContext.request.contextPath}/resources/dtree/dtree.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/dtree/dtree.js"></script>
<script type="text/javascript">
$(function(){
	$("#update,#addRegister").click(function(){
		
		 // 获取选中的医生　
		 var checkedBoxs = $("input[id^='box']").filter(":checked");
		 var msg="";
		 if(checkedBoxs.length != 1 | checkedBoxs.length == 0){			 						 
			 var msg="请选择唯一的时间！";			 
		 }
		 if(msg != "") {
				// 弹出错误提示，结束程序 
				//easyUI框架
				$.messager.alert('提示',msg,'error');
				return ;
			}
		 $("#infosForm").submit();
		
	});
	
	
});
</script>
</head>
<body style="width: 100%; height: 100%;">
  <form id="infosForm" method="post" action="${pageContext.request.contextPath }/RegisterServlet?method=save">
    <!-- 当前是哪个医生的排诊信息  -->
    <input type="hidden" value="${scheduledata.doctor.id}" name="id" />
    <span style="color: red;">${tip}</span>
	<table class="table table-bordered" style="float: right;" >
		<tr>
			<td>医生姓名:${scheduledata.doctor.name}</td>
		</tr>
		<tr>
			<td>所属科室:${scheduledata.doctor.part.name.replaceAll("-","") }</td>
		</tr>
		<c:forEach items="${scheduledata.workInfos }" var="work" varStatus="stat">
		   <!-- 哪天 -->
		    <input type="hidden" value="${work.dateStr}" name="date_${stat.index}" />
			<tr>
				<td>${work.dateStr}: 
				    <c:if test="${ work.work_timer == null }">

						<div class="btn-group btn-group-xs" role="group" aria-label="...">
							<button type="button" class="btn btn-danger">休息</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>

					</c:if> 
					<c:if test="${ work.work_timer.equals(\"5\")}">
							<div class="btn-group btn-group-xs" role="group" aria-label="...">
								<button type="button" class="btn btn-danger">休息</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</div>
								
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"1\")}">
							 <div class="btn-group btn-group-xs" role="group" aria-label="...">
								<button type="button" class="btn btn-success">上午</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"2\")}">
						<div class="btn-group btn-group-xs" role="group" aria-label="...">
							<button type="button" class="btn btn-success">上午</button>
							<button type="button" class="btn btn-success">下午 </button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"3\")}">
						<div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">上午</button>
									  <button type="button" class="btn btn-success">下午</button>
									  <button type="button" class="btn btn-success">晚上 </button>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
					</c:if>
					 <c:if test="${ work.work_timer.equals(\"4\")}">
					<div class="btn-group btn-group-xs" role="group" aria-label="...">
						<button type="button" class="btn btn-success">上午</button>
						<button type="button" class="btn btn-success">晚上 </button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"6\") }">
						<div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">下午 </button>
									  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
					</c:if>
					 <c:if test="${ work.work_timer.equals(\"7\") }">
							<div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">下午</button>
									  <button type="button" class="btn btn-success">晚上 </button>
									  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"8\")}">
						<div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">晚上 </button>
									  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</c:if>
					<!-- 排诊信息  -->
					余号数:
					<c:choose>
					<c:when test="${ work.num==0}">
					<input type="text"  readonly="readonly" style="width: 29px;" value="${work.num}" name="num_${stat.index }"/>
					 
					</c:when>
					<c:otherwise>
					<input type="text"  readonly="readonly" style="width: 29px;" value="${work.num}" name="num_${stat.index }"/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input value="${work.dateStr}" type="checkbox" id="box" name="box" />
					</c:otherwise>
					</c:choose>
					
					
					  
				</td>
			</tr>
		</c:forEach>
	
	</table>
	<div align="center">
		<button  id="addRegister" type="button"  class="btn btn-primary">确认</button>
	</div>
</form>
</body>
</html>

