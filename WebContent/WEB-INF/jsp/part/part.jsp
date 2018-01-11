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
<link rel="StyleSheet" href="${pageContext.request.contextPath}/resources/dtree/dtree.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/dtree/dtree.js"></script>
</head>
<body class="easyui-layout" style="width:100%;height:100%;">
   
   <div data-options="region:'west'" title="科室树" style="width:20%;padding:10px;">
	 <script type="text/javascript">
	 
	 
	    // 创建一科树
		d = new dTree('d',"${pageContext.request.contextPath}/resources/dtree/");
//              自己的id  父节点id   自己的名称   请求地址
// 	    d.add(id,     pid,      name,    url )
		d.add(0,-1,'全部科室',"${pageContext.request.contextPath}/part?method=list") ;
        // 加入科室信息
        <c:forEach items="${parts}" var="part">
            var pid = "${part.partCode}".length <=4 ? 0 : "${part.partCode}".substring(0, "${part.partCode}".length - 4);
            d.add("${part.partCode}",pid,"${part.name.replaceAll('-','')}" , "${pageContext.request.contextPath}/part?method=list&parentCode=${part.partCode}");
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
	   		 
	    });
	    
	</script>
  </div>
  
  
	<div data-options="region:'center'" title="科室:&nbsp;<span style='color:red;'>${parentName}</span>" >
	     <div style="padding: 5px;">
				<a  id="addPart" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加</a>
				<a  id="deletePart" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;删除</a>
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
							<td><input type="checkbox" name="box" id="dataBox_${stat.index}" /></td>
							<td>${part.partCode}</td>
							<td>${part.name.replaceAll("-","")}</td>
							<td>${part.remark}</td>
						</tr>
				    </c:forEach>
		</table>
	</div>
</body>
</html>

