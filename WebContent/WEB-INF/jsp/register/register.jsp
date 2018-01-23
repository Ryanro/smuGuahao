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
<link rel="StyleSheet" href="${pageContext.request.contextPath}/resources/dtree/dtree.css" type="text/css" />
<script type="text/javascript">
$(function(){
	
	 var trs = $("tr[id^='dataTr_']");
	 var boxs =  $("input[id^='dataBox_']");
	$("#checkAll").click(function(){
		 // 定位所有的单选，如果全选按钮选中了单选也应该选中 反之
		 boxs.attr("checked",this.checked);
		 trs.trigger("mouseover").trigger("mouseout");
	});
	
		 // 为所有的单选按钮绑定点击事件 ， 如果所有的单选都被选中了，全选也应该选中 反之
		 boxs.click(function(event){
			// 取消事件的传播
			event.stopPropagation();
			// 获取界面上所有选中的按钮对象 ：筛选器 
			var checkedBoxs = boxs.filter(":checked");
			$("#checkAll").attr("checked",checkedBoxs.length == boxs.length);
		 });
	 
		 // 为所有的行绑定鼠标覆盖和离开事件 
		
		 trs.hover(function(){
			 $(this).css("backgroundColor","#dddddd");
		 },function(){
			 // 如果离开行的时候，选中了 颜色不要消失 
			 var id = this.id.replace("dataTr_","dataBox_");
			 if(!$("#"+id).attr("checked")){
				$(this).css("backgroundColor","#ffffff");
			 }
		 }).click(function(){
			  // 获取当前点击的这一行的id , 然后替换成这行对应的按钮的id 
			  var id = this.id.replace("dataTr_","dataBox_");
			  $("#"+id).trigger("click");
		 });
		 
	$("#update,#addRegister").click(function(){
		
		 // 获取选中的医生　
		 var checkedBoxs = $("input[id^='dataBox_']").filter(":checked");
		 if(checkedBoxs.length == 1){
			 // 弹出一个排诊的输入框 ：展示当前医生 ，展示下一个未来七天的排诊信息
			 $('#myModal').modal() ;
			 // 加载一个排诊界面 
			 $("#guahao").attr("src","${pageContext.request.contextPath}/RegisterServlet?method=addRegister&methodId="+this.id+"&id="+$(checkedBoxs).val());
		 }else{
			 $.messager.alert("错误提示","请选择一个需要发布排诊信息的医生","error");
		 }
		
	});
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
	});
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/dtree/dtree.js"></script>
</head>

<body style="width:100%;height:100%;">
    <!-- 工具按钮区 -->
		<form class="form-horizontal"
			action="${pageContext.request.contextPath }/RegisterServlet?method=list"
			method="post" >
			<table class="table-condensed">
				<tbody>
					<tr>
						<td><input name="name" type="text" class="form-control"
							placeholder="医生姓名" value="${doctor.name}"></td>
						<td><select class="btn btn-default" placeholder="部门"
							id="partCode" name="partCode"  >
								<option value="">==请选择科室==</option>
								<c:forEach items="${parts}" var="part">
									<c:if test="${doctor.part.partCode == part.partCode}">
										<option selected="selected" value="${part.partCode}">${part.name}</option>
									</c:if>
									<c:if test="${doctor.part.partCode != part.partCode}">
										<option  value="${part.partCode}">${part.name}</option>
									</c:if>
								</c:forEach>
						</select></td>
						<td>
						<td>
							<button type="submit" id="selectUser" class="btn btn-info">
								<span class="glyphicon glyphicon-search"></span>&nbsp;查询
							</button> <a   id="addRegister" class="btn btn-success"><span
								class="glyphicon glyphicon-plus"></span>&nbsp;挂号</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	    <div class="table-responsive">
	    <table class="table table-bordered" style="float: right;">
					<thead>
						<tr style="font-size: 12px;" align="center">
							<th style="text-align: center;"><input type="checkbox"  id="checkAll"/></th>
							<th style="text-align: center;">医生名称</th>
							<th style="text-align: center;">科室名称</th>
							<c:forEach items="${dates}" var="date">
								<th style="text-align: center;color: red;">${date}</th>
							</c:forEach>
						</tr>
					</thead>
				  <c:forEach items="${scheduleDatas}" var="data" varStatus="stat">
				        <tr align="center" id="dataTr_${stat.index}">
							<td><input value="${data.doctor.id}"  type="checkbox" name="box" id="dataBox_${stat.index}" /></td>
							<td>${data.doctor.name}</td>
							<td>${data.doctor.part.name.replaceAll("-","")}</td>
							<c:forEach items="${data.workInfos}" var="work">
							     <c:if test="${ work.work_timer == null }">
							          <td>
									<div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-danger">未排诊</button>
									</div>
											</td>
							     </c:if>
							     <c:if test="${ work.work_timer.equals(\"5\")}">
							          <td>
									<div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-danger">休息</button>
									</div>
								</td>
							     </c:if>
							      <c:if test="${ work.work_timer.equals(\"1\")}">
							       <td>
							        <div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">上午<span class="badge">${work.num }</span></button>
									</div>
							         </td>
							     </c:if>
							      <c:if test="${ work.work_timer.equals(\"2\")}">
							       <td>
							         <div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">上午</button>
									  <button type="button" class="btn btn-success">下午<span class="badge">${work.num }</span></button>
									</div>
							          </td>
							     </c:if>
							      <c:if test="${ work.work_timer.equals(\"3\")}">
							       <td>
							        <div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">上午</button>
									  <button type="button" class="btn btn-success">下午</button>
									  <button type="button" class="btn btn-success">晚上<span class="badge">${work.num }</span></button>
									</div>
							           </td>
							     </c:if>
							      <c:if test="${ work.work_timer.equals(\"4\")}">
							       <td>
							        <div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">上午</button>
									  <button type="button" class="btn btn-success">晚上<span class="badge">${work.num }</span></button>
									</div>
							          </td>
							     </c:if>
							      <c:if test="${ work.work_timer.equals(\"6\") }">
							       <td>
 									<div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">下午<span class="badge">${work.num }</span></button>
									</div>							          </td>
							     </c:if>
							     <c:if test="${ work.work_timer.equals(\"7\") }">
							      <td>
							        <div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">下午</button>
									  <button type="button" class="btn btn-success">晚上<span class="badge">${work.num }</span></button>
									</div>
							           </td>
							     </c:if>
							      <c:if test="${ work.work_timer.equals(\"8\")}">
							       <td>
							         <div class="btn-group btn-group-xs" role="group" aria-label="...">
									  <button type="button" class="btn btn-success">晚上<span class="badge">${work.num }</span></button>
									</div>
							          </td>
							     </c:if>
							</c:forEach>
						</tr>
				    </c:forEach>
		</table>
	    </div>
	    
	    <!-- 发布排诊信息的界面  -->
		<div class="modal fade" id="myModal" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">挂号</h4>
					</div>
					<div class="modal-body" >
						 <!-- 放置排诊内容的区域  -->
						 <iframe frameborder="0" width="100%" height="270px" id="guahao" >
						    </iframe>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<center>
		<div class="row" >
		   <!-- 分页标签 -->
		   <nav>
			  <ul class="pagination">
			    <li id="first">
			      <a href="${pageContext.request.contextPath }/RegisterServlet?method=list&pageIndex=1&name=${doctor.name}&partCode=${doctor.part.partCode}">首页</a>
			    </li>
			    <li id="pre"><a href="${pageContext.request.contextPath }/RegisterServlet?method=list&pageIndex=${pageModel.pageIndex - 1}&name=${doctor.name}&partCode=${doctor.part.partCode}">上一页</a></li>
			    <li id="next"><a href="${pageContext.request.contextPath }/RegisterServlet?method=list&pageIndex=${pageModel.pageIndex+1}&name=${doctor.name}&partCode=${doctor.part.partCode}">下一页</a></li>
			    <li id="last">
			      <a href="${pageContext.request.contextPath }/RegisterServlet?method=list&pageIndex=${pageModel.pageCount}&name=${doctor.name}&partCode=${doctor.part.partCode}">
			              尾页
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

