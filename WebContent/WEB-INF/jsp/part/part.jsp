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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/dtree/dtree.js"></script>
</head>
<body class="easyui-layout" style="width:100%;height:100%;">
   
   <div data-options="region:'west'" title="科室树" style="width:20%;padding:10px;">
	 <script type="text/javascript">
	 
	 
	    // 创建一棵树
		d = new dTree('d',"${pageContext.request.contextPath}/resources/dtree/");
//          自己的id  父节点id   自己的名称   请求地址
// 	    d.add(id,     pid,      name,       url )
		d.add(0,-1,'全部科室',"${pageContext.request.contextPath}/PartServlet?method=list") ;
        // 加入科室信息
        <c:forEach items="${parts}" var="part">
            var pid = "${part.partCode}".length <=4 ? 0 : "${part.partCode}".substring(0, "${part.partCode}".length - 4);
            d.add("${part.partCode}",pid,"${part.name.replaceAll('-','')}" , "${pageContext.request.contextPath}/PartServlet?method=list&parentCode=${part.partCode}");
	    </c:forEach>
	    document.write(d);    
	    
	    // 等文档加载完成以后为界面添加动态效果 
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
	   			// 获取界面上所有选中的按钮对象 ：jquery中的 筛选器 
	   			var checkedBoxs = boxs.filter(":checked");
	   			$("#checkAll").attr("checked",checkedBoxs.length == boxs.length);
	   		 });
	    	 
	   		 // 为所有的行绑定鼠标覆盖和离开事件 
	   		
	   		 trs.hover(function(){
	   			 $(this).css("backgroundColor","#dddddd");  //鼠标覆盖
	   		 },function(){ //鼠标离开
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
	   		 
	   		 
	   		 // 给删除科室绑定点击事件 Jquery 
	   		 $("#deletePart").click(function(){
	   			 
	   			var checkedBoxs = boxs.filter(":checked");
			    // 判断用户是否选中了要删除的科室 没有选中提示选中 
			    if(checkedBoxs.length > 0){
			    	$.messager.confirm('删除科室信息', '您确认要删除该科室吗?', function(r){
		   				if (r){
		   					// 删除信息 
		   					// 提取用户选中的科室编号 
		   					// 获取界面上所有选中的按钮对象 ：筛选器 
// 		   		   			for(var i = 0 ; i < checkedBoxs.length ; i++ ){
// 		   		   				alert(checkedBoxs[i].value);
// 		   		   			}
		   					//checkedBoxs = [按钮1 ,按钮2 , 按钮3]
		   					//               this -->
		   					var ids = checkedBoxs.map(function(){
		   						return this.value ;
		   					});
		   					// alert(ids.get()); 
		   					window.location = "${pageContext.request.contextPath }/PartServlet?method=delete&ids="+ids.get()
							  +"&parentCode=${parentCode}" ;
		   					
		   				}
		   			});
			    }else{
			    	$.messager.alert("删除提示","请选择需要删除的科室","error");
			    }
	   		 });
	   		 
	   		 // 保存科室绑定点击 
	   		 $("#savePart").click(function(){
				// 提取科室名称和备注
				var name = $("#name").val();
				var remark = $("#remark").val(); 
				// 参数校验 
				var msg = "" ;
				if(name == null || name =="" ){
					$.messager.alert("添加科室","请输入科室名称","error");
					return ;
				}
				// 提交到后台 
				window.location = "${pageContext.request.contextPath }/PartServlet?method=save&name="+name+"&remark="+remark
				  +"&parentCode=${parentCode}" ; ;
	   		 });
	   		 
	   		 //给所有行绑定右键点击事件
	   		var code ;
	   		trs.bind('contextmenu',function(e){
				e.preventDefault(); // 取消事件的默认形式
				$('#mm').menu('show', {
					left: e.pageX,
					top: e.pageY
				});
	   			var id = this.id.replace("dataTr_","dataBox_");
				// 拿到编号 
		    	code = $("#"+id).val();
			});
	   		
	   		$("#deleteByCode").click(function(){
	   			window.location = "${pageContext.request.contextPath }/PartServlet?method=delete&ids="+code
				  +"&parentCode=${parentCode}" ;
	   		});
	   		 
	    });
	   		 
	    
	</script>
  </div>
  
  
	<div data-options="region:'center'" title="科室:&nbsp;<span style='color:red;'>${parentName.replaceAll('-','')}</span>" >
	     <div style="padding: 5px;">
				<a  id="addPart" data-toggle="modal" data-target="#myModal" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加</a>
				<a  id="deletePart" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;删除</a>
				<span style="color: red;">${tip }</span>
			</div>
	    <table class="table table-bordered" style="float: right;">
					<thead>
						<tr style="font-size: 12px;" align="center">
							<th style="text-align: center;"><input type="checkbox"  id="checkAll"/></th>
							<th style="text-align: center;">编号</th>
							<th style="text-align: center;">名称</th>
							<th style="text-align: center;">描述</th>
						</tr>
					</thead>
					  <c:forEach items="${sonParts}" var="part" varStatus="stat">
				        <tr align="center" id="dataTr_${stat.index}">
							<td><input value="${part.partCode}" type="checkbox"  name="box" id="dataBox_${stat.index}" /></td>
							<td>${part.partCode}</td>
							<td>${part.name.replaceAll("-","")}</td>
							<td>${part.remark}</td>
						</tr>
				    </c:forEach>
		</table>
		
		
		<!-- 右键菜单 -->	
	<div id="mm" class="easyui-menu" style="width:120px;">
		<div id="deleteByCode">删除</div>
		<div>修改</div>
		<div>Exit</div>
	</div>
		
		
		    <!-- 添加科室的界面  -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">添加科室</h4>
					</div>
					<div class="modal-body">
						<!-- 表单：输入框 -->
						<table class="table-condensed" width="90%" height="100%">
							<tbody>
								<tr>
									<td align="center"><label>上级科室:<label></td>
									<td>${parentName.replaceAll('-','')}</td>
								</tr>
								<tr>
									<td align="center"><label>科室名称:<label></td>
									<td><input type="text" id="name" name="name"
										class="form-control" placeholder="请输入科室名称"></td>
								</tr>
								<tr>
									<td align="center"><label>备注:<label></td>
									<td><textarea type="text" id="remark" name="remark"
											class="form-control" placeholder="请输入科室备注"></textarea></td>
								</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" id="savePart" class="btn btn-primary">保存科室</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

