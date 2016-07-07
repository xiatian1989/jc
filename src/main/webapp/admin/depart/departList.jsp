<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	function altRows(id) {
		if (document.getElementsByTagName) {

			var table = document.getElementById(id);
			var rows = table.getElementsByTagName("tr");

			for (i = 0; i < rows.length; i++) {
				if (i % 2 == 0) {
					rows[i].className = "evenrowcolor";
				} else {
					rows[i].className = "oddrowcolor";
				}
			}
		}
	}

	window.onload = function() {
		altRows('alternatecolor');
	}
	
	function addDepartBefore(){
		
		var button = $("#alternatecolor tr:last td:last input:first")
		if(button) {
			if(button.val()=="确定"){
				alert("请逐条添加数据！")
				return;
			}
		}
		var html="<option value=''></option>";
		$.ajax({   
		    url:'${pageContext.request.contextPath}/departListtoJson',   
		    type:'post',   
		    async : false, //默认为true 异步   
		    success:function(obj){
		    	if(obj.length>0) {
		    		for ( var i = 0; i < obj.length; i++) {
		    			html = html+ ("<option value=\"" + obj[i].id+"&" +obj[i].nodePath+"&"+obj[i].departNo+"&"+obj[i].isleaf+
		    					"\">" + obj[i].departName+ "</option>");
		    		}
		    	}
		    }
		});
		
		var count = $("#alternatecolor tr:last th:eq(1)").html();
		if(!count) {
			count = $("#alternatecolor tr:last td:eq(1)").html();
		}
		if(count=='序号'){
			var newRow = "<td><input type='checkbox'></td><tr><td>1</td><td><input type='text' value='' disabled='disabled'></td><td><input type='text' value=''></td><td><input type='text' value='' disabled='disabled'></td><td><select>"+
				html	
			+"</select></td><td><select><option>启用</option><option>禁用</option></select></td><td><input type='button' value='确定' onclick='addDepart()'/></td></tr>";
		}else{
			count =  parseInt(count)+1;
			var newRow = "<tr><td><input type='checkbox'></td><td>"+count+"</td><td><input type='text' value='' disabled='disabled'></td><td><input type='text' value=''></td><td><input type='text' value='' disabled='disabled'></td><td><select>"+
				html	
			+"</select></td><td><select><option>启用</option><option>禁用</option></select></td><td><input type='button' value='确定' onclick='addDepart()'/></td></tr>";
		}
		$("#alternatecolor tr:last").after(newRow);
	}
	
	function addDepart(){
		
		debugger;
		var departName = $("#alternatecolor tr:last td:eq(3) input").val();
		var parentMessage = $("#alternatecolor tr:last td:eq(5) select").val();
		var statusText = $("#alternatecolor tr:last td:eq(6) select").val();
		if(departName == ''){
			alert("请输入用户名称！")
			$("#alternatecolor tr:last td:eq(3) input").focus().select();
			return;
		}
		var status =true;
		if(statusText=="禁用") {
			status=false
		}
		var pid="";
		var parentNo="";
		var nodepath="";
		var isleaf="";
		if(parentMessage !=''){
			var arr=parentMessage.split('&')
			pid = arr[0];
			nodepath=arr[1];
			parentNo=arr[2]
			isleaf=arr[3]
		}
		$.ajax({   
		    url:'${pageContext.request.contextPath}/addDepart',   
		    type:'post',   
		    data:'depart.departName='+departName+"&depart.status="+status+"&depart.parentNo="+parentNo+"&depart.nodePath="+nodepath,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('添加失败');   
		    },   
		    success:function(msg){
		    	if(msg.result=="success") {
		    		if(pid !="" && isleaf=="true"){
		    			var dataForUpdate ="depart.id="+pid+"&depart.isleaf="+false;
		    			updateDepart(dataForUpdate,true);
		    		}else{
		    			window.location.href="${pageContext.request.contextPath}/departList";
		    		}
		    		
		    	}else{
		    		alert('添加失败'); 
		    	}
		    }
		});
		
	}
	
	function disabledDepart(id,isLeaf){
		if(!isLeaf) {
			alert("该部门有子部门，不能禁用！");
			return;
		}
		$("#"+id+" td:eq(6) span").html("禁用");
		$("#disabledButton"+id).hide();
		$("#enabledButton"+id).show();
		var data = 'depart.id='+id+"&depart.status="+false;
		updateDepart(data,false);
	}
	
	function enabledDepart(id){
		$("#"+id+" td:eq(6) span").html("启用");
		$("#disabledButton"+id).show();
		$("#enabledButton"+id).hide();
		var data = 'depart.id='+id+"&depart.status="+true;
		updateDepart(data,false);
	}
	
	function updateDepart(data,flag){
		$.ajax({   
		    url:'${pageContext.request.contextPath}/updateDepart',   
		    type:'post',   
		    data:data,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('更新失败');   
		    },   
		    success:function(msg){
		    	if(msg.result=="success") {
		    		if(flag) {
			    		window.location.href="${pageContext.request.contextPath}/departList";
		    		}
		    	}else{
		    		alert('更新失败'); 
		    	}
		    }
		});
	}
	
	function deleteDepart(id) {
		$.ajax({   
		    url:'${pageContext.request.contextPath}/deleteDepart',   
		    type:'post',   
		    data:'id='+id,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('删除失败');   
		    },   
		    success:function(msg){
		    	if(msg.result=="success") {
		    		window.location.href="${pageContext.request.contextPath}/departList";
		    	}else{
		    		alert('删除失败'); 
		    	}
		    }
		});
	}
	function editDepartBefore(id){
		
		$("#disabledButton"+id).hide();
		$("#enabledButton"+id).hide();
		$("#editButton"+id).hide();
		$("#deleteButton"+id).hide();
		$("#OKButton"+id).show();
		var departNo = $("#"+id+" td:eq(2)").html().trim();
		$("#"+id+" td:eq(3) input").removeAttr("disabled");
		$("#"+id+" td:eq(6)").html("<select><option>启用</option><option>禁用</option></select>");
		var html="<select>";
		$.ajax({   
		    url:'${pageContext.request.contextPath}/departListtoJsonForUpdate',   
		    type:'post', 
		    data:"departNo="+departNo,   
		    async : false, //默认为true 异步   
		    success:function(obj){
		    	if(obj.length>0) {
		    		for ( var i = 0; i < obj.length; i++) {
		    			html = html+ ("<option value=\"" + obj[i].id+"&" +obj[i].nodePath+"&"+obj[i].departNo+"&"+obj[i].isleaf+
		    					"\">" + obj[i].departName+ "</option>");
		    			if(i == 0) {
		    				html = html+"<option value=''></option>"
		    			}
		    		}
		    	}
		    }
		});
		$("#"+id+" td:eq(5)").html(html+"</select>");
	}
	
	function editDepart(id){
		var departName = $("#"+id+" td:eq(3) input").val();
		var parentMessage = $("#"+id+" td:eq(5) select").val();
		var oldParentNo = $("#"+id+" td:eq(4)").html().trim();
		var departNo = $("#"+id+" td:eq(2)").html().trim();
		var statusText = $("#"+id+" td:eq(6) select").val();
		var status =true;
		if(statusText=="禁用") {
			status=false
		}
		var pid="";
		var parentNo="";
		var nodepath="";
		var isleaf="";
		if(parentMessage !=''){
			var arr=parentMessage.split('&')
			pid = arr[0];
			nodepath=arr[1];
			parentNo=arr[2]
			isleaf=arr[3]
		}
		
		var data="";
		if(parentNo == oldParentNo) {
			data = 'depart.id='+id+'&depart.departName='+departName+"&depart.status="+status+'&depart.departNo='+departNo;
		} else {
			data = 'depart.id='+id+'&depart.departName='+departName+"&depart.status="+status+"&depart.parentNo="+parentNo+"&depart.nodePath="+nodepath+'&depart.departNo='+departNo;
		}
		
		updateDepart(data,true);
	}
	
	function checkUniqName(id,object) {
		var departName = $("#"+id+" td:eq(3) input").val();
		var olddepartName = $("#"+id+" td:eq(3) input").attr("title");
		if(departName == olddepartName) {
			return;
		}
		
		$.ajax({   
		    url:'${pageContext.request.contextPath}/checkOrganizationName',   
		    type:'post',   
		    data:'name='+organizationName,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('部门名称已经存在！');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="failed") {
		    		
		    		alert('部门名称已经存在！');
		    		$(object).focus().select();
		    	}
		    }
		});
	}
	
</script>
<style type="text/css">
table.altrowstable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-width: 1px;
	border-color: #a9c6c9;
	border-collapse: collapse;
}

table.altrowstable th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}

table.altrowstable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
	text-align: center;
}

.oddrowcolor {
	background-color: #d4e3e5;
}

.evenrowcolor {
	background-color: #c3dde0;
}
.page {
	PADDING-RIGHT: 3px;
	PADDING-LEFT: 3px;
	PADDING-BOTTOM: 3px;
	MARGIN: 3px;
	PADDING-TOP: 3px;
	TEXT-ALIGN: center
}

a {
	position: relative;
	text-decoration: none;
	border-bottom: 1px dotted #ccc;
	padding-bottom: 5px;
}

a em {
	display: none;
	position: absolute;
	padding: 5px;
	border: 1px solid #ccc;
	left: 20px;
	top: 30px;
	width: 60px;
}

a:hover {
	border-bottom: 1px solid #ccc;
}

a:hover em {
	display: block;
}
</style>
</head>
<body>
	<input type="button" value="添加部门" onclick="addDepartBefore()"/>
	<table class="altrowstable" id="alternatecolor" width="100%">
		<tr>
			<th></th>
			<th width="100px">序号</th>
			<th>部门编号</th>
			<th>部门名称</th>
			<th>父部门编号</th>
			<th>父部门名称</th>
			<th>状态</th>
			<th width="150px">操作</th>
		</tr>
		<c:forEach items="${page.list }" var="depart" varStatus="status">
			<tr id="${depart.id}">
				<td><input type="checkbox" alt="${depart.id}"></td>
				<td>${status.index+1}</td>
				<td>
					${depart.departNo}
				</td>
				<td>
					<input type="text" value="${depart.departName}" disabled="disabled" title="${depart.departName}" onblur="checkUniqName('${depart.id}',this)" style="width:99%;word-break:break-all"/>
				</td>
				<td>
					${depart.parentNo}
				</td>
				<td>
					${depart.parentName}
				</td>
				<td>
					<c:choose>
						<c:when test="${depart.status}">
							<span>启用</span>
						</c:when>
						<c:otherwise>
							<span>禁用</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${depart.status}">
								<input type="button" value="禁用" onclick="disabledDepart('${depart.id}',${depart.isleaf})" id="disabledButton${depart.id}"/>
							<input type="button" value="启用" onclick="enabledDepart('${depart.id}')" id="enabledButton${depart.id}" style="display:none"/>
						</c:when>
						<c:otherwise>
							<input type="button" value="启用" onclick="enabledDepart('${depart.id}')" id="enabledButton${depart.id}"/>
							<input type="button" value="禁用" onclick="disabledDepart('${depart.id}',${depart.isleaf})" id="disabledButton${depart.id}" style="display:none"/>
						</c:otherwise>
					</c:choose>
					<input type="button" value="编辑" onclick="editDepartBefore('${depart.id}')" id="editButton${depart.id}"/>
					<input type="button" value="删除" onclick="deleteDepart('${depart.id}')" id="deleteButton${depart.id}"/>
					<input type="button" value="确定" onclick="editDepart('${depart.id}')" style="display: none" id="OKButton${depart.id}"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="page">
		<span style="padding-right:10px;">总记录数为${page.total},共${page.pages}页</span>
		<c:choose>
			<c:when test="${page.pageNum == 1}">
				<a>上一页</a>
			</c:when>
			<c:otherwise>
				<a href="departList?pageNum=${page.pageNum - 1}">上一页</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${pages != 1}">
			<c:forEach var="pageIndex" begin="1" end="${page.pages}">
				<c:choose>
					<c:when test="${page.pageNum == pageIndex}">
						<a>${pageIndex}</a>
					</c:when>
					<c:otherwise>
						<a href="departList?pageNum=${pageIndex}">${pageIndex}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		<c:choose>
			<c:when test="${page.pageNum == page.pages}">
					<a>下一页</a>
				</c:when>
				<c:otherwise>
					<a href="departList?pageNum=${page.pageNum+1}">下一页</a>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>