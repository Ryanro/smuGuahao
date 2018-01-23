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
</script>
</head>
<body style="width: 100%; height: 100%;">
  <form id="infosForm" method="post" action="${pageContext.request.contextPath}/ScheduleServlet?method=save">
    <!-- 当前是哪个医生的排诊信息  -->
    <input type="hidden" value="${scheduledata.doctor.id}" name="id" />
    <span style="color: red;">${tip}</span>
	<table class="table table-bordered" style="float: right;">
		<tr>
			<td>医生姓名:${scheduledata.doctor.name }</td>
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
							上午 <input type="checkbox" name="morning_${stat.index}" /> 下午 <input
							type="checkbox" name="after_${stat.index}" /> 晚上 <input name="night_${stat.index}" type="checkbox" />
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"5\")}">
							上午 <input type="checkbox" name="morning_${stat.index}" /> 下午 <input
							type="checkbox" name="after_${stat.index}" /> 晚上 <input name="night_${stat.index}" type="checkbox" />
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"1\")}">
							上午 <input  name="morning_${stat.index}" type="checkbox" checked/> 下午 <input
							type="checkbox" name="after_${stat.index}" /> 晚上 <input  name="night_${stat.index}" type="checkbox" />
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"2\")}">
						上午 <input name="morning_${stat.index}" type="checkbox" checked/> 下午 <input
							name="after_${stat.index}" type="checkbox" checked/> 晚上 <input name="night_${stat.index}" type="checkbox" />
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"3\")}">
						上午 <input  name="morning_${stat.index}" type="checkbox" checked/> 下午 <input
							name="after_${stat.index}" type="checkbox" checked/> 晚上 <input name="night_${stat.index}" type="checkbox" checked/>
					</c:if>
					 <c:if test="${ work.work_timer.equals(\"4\")}">
					上午 <input  name="morning_${stat.index}" type="checkbox" checked/> 下午 <input
							name="after_${stat.index}" type="checkbox"/> 晚上 <input name="night_${stat.index}" type="checkbox" checked/>
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"6\") }">
						上午 <input  name="morning_${stat.index}" type="checkbox" /> 下午 <input
							name="after_${stat.index}" type="checkbox" checked/> 晚上 <input name="night_${stat.index}" type="checkbox" />
					</c:if>
					 <c:if test="${ work.work_timer.equals(\"7\") }">
							上午 <input  name="morning_${stat.index}"  type="checkbox" /> 下午 <input
							name="after_${stat.index}" type="checkbox" checked/> 晚上 <input name="night_${stat.index}" type="checkbox" checked/>
					</c:if> 
					<c:if test="${ work.work_timer.equals(\"8\")}">
						上午 <input  name="morning_${stat.index}" type="checkbox" /> 下午 <input
							name="after_${stat.index}" type="checkbox" /> 晚上 <input name="night_${stat.index}" type="checkbox" checked/>
					</c:if>
					<!-- 排诊信息  -->
					&nbsp;&nbsp; 接诊数量: 
					  <input type="text"  style="width: 29px;" value="${work.num}" name="num_${stat.index }"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div align="center">
		<button type="submit"  class="btn btn-primary">保存排诊信息</button>
	</div>
</form>
</body>
</html>

