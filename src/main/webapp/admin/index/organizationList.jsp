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
	
	function addOrganizationBefore() {
		var button = $("#alternatecolor tr:last td:last input:first")
		if(button) {
			if(button.val()=="确定"){
				alert("请逐条添加数据！")
				return;
			}
		}
		var count = $("#alternatecolor tr:last th:first").html();
		if(!count) {
			count = $("#alternatecolor tr:last td:first").html()
		}
		if(count=='序号'){
			var newRow = "<tr><td>1</td><td><input type='text' value=''></td><td><select><option>启用</option><option>禁用</option></select></td><td><input type='button' value='确定' onclick='addOrganization()'/></td></tr>";
		}else{
			count =  parseInt(count)+1
			var newRow = "<tr><td>"+count+"</td><td><input type='text' value=''></td><td><select><option>启用</option><option>禁用</option></select></td><td><input type='button' value='确定' onclick='addOrganization()'/></td></tr>";
		}
		$("#alternatecolor tr:last").after(newRow);
	}
	
	function addOrganization(){
		var organizationName = $("#alternatecolor tr:last td:eq(1) input").val();
		var statusText = $("#alternatecolor tr:last td:eq(2) select").val();
		if(organizationName == ''){
			alert("请输入用户名称！")
			$("#alternatecolor tr:last td:eq(1) input").focus().select();
			return;
		}
		var status =true;
		if(statusText=="禁用") {
			status=false
		}
		
		$.ajax({   
		    url:'${pageContext.request.contextPath}/addOrganization',   
		    type:'post',   
		    data:'organization.organizationName='+organizationName+"&organization.status="+status,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('添加失败');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="success") {
		    		window.location.href="${pageContext.request.contextPath}/organizationList";
		    	}else{
		    		alert('添加失败'); 
		    	}
		    }
		});
		
	}
	
	function disabledOrganization(id){
		$("#"+id+" td:eq(2) span").html("禁用");
		$("#disabledButton"+id).hide();
		$("#enabledButton"+id).show();
		var data = 'organization.id='+id+"&organization.status="+false;
		updateOrganization(data,false);
	}
	
	function enabledOrganization(id){
		$("#"+id+" td:eq(2) span").html("启用");
		$("#disabledButton"+id).show();
		$("#enabledButton"+id).hide();
		var data = 'organization.id='+id+"&organization.status="+true;
		updateOrganization(data,false);
	}
	
	function updateOrganization(data,flag){
		$.ajax({   
		    url:'${pageContext.request.contextPath}/updateOrganization',   
		    type:'post',   
		    data:data,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('更新失败');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="success") {
		    		if(flag) {
			    		window.location.href="${pageContext.request.contextPath}/organizationList";
		    		}
		    	}else{
		    		alert('更新失败'); 
		    	}
		    }
		});
	}
	
	function deleteOrganization(id) {
		$.ajax({   
		    url:'${pageContext.request.contextPath}/deleteOrganization',   
		    type:'post',   
		    data:'id='+id,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('删除失败');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="success") {
		    		window.location.href="${pageContext.request.contextPath}/organizationList";
		    	}else{
		    		alert('删除失败'); 
		    	}
		    }
		});
	}
	function editOrganizationBefore(id){
		$("#disabledButton"+id).hide();
		$("#enabledButton"+id).hide();
		$("#editButton"+id).hide();
		$("#deleteButton"+id).hide();
		$("#OKButton"+id).show();
		$("#"+id+" td:eq(1) input").removeAttr("disabled");
		$("#"+id+" td:eq(2)").html("<select><option>启用</option><option>禁用</option></select>");
	}
	
	function editOrganization(id){
		var organizationName = $("#"+id+" td:eq(1) input").val();
		var statusText = $("#"+id+" td:eq(2) select").val();
		var status =true;
		if(statusText=="禁用") {
			status=false
		}
		var data = 'organization.id='+id+"&organization.status="+status+"&organization.organizationName="+organizationName;
		updateOrganization(data,true);
	}
	
	function checkUniqName(id,object) {
		var organizationName = $("#"+id+" td:eq(1) input").val();
		var oldOrganizationName = $("#"+id+" td:eq(1) input").attr("title");
		if(organizationName == oldOrganizationName) {
			return;
		}
		
		$.ajax({   
		    url:'${pageContext.request.contextPath}/checkOrganizationName',   
		    type:'post',   
		    data:'name='+organizationName,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('用户名已经存在！');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="failed") {
		    		
		    		alert('用户名已经存在！');
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
	<div>
		<button onclick="addOrganizationBefore()" id="addOrganization">添加用户</button>
	</div>
	<table class="altrowstable" id="alternatecolor" width="100%">
		<tr>
			<th width="100px">序号</th>
			<th>用户名称</th>
			<th width="100px">用户状态</th>
			<th width="150px">操作</th>
		</tr>
		<c:forEach items="${page.list }" var="organization" varStatus="status">
			<tr id="${organization.id}">
				<td>${status.index+1 }</td>
				<td><input type="text" value="${organization.organizationName}"  disabled="disabled" title="${organization.organizationName}" onblur="checkUniqName('${organization.id}',this)" style="width:99%;word-break:break-all"/></td>
				<td>
					<c:choose>
						<c:when test="${organization.status}">
							<span>启用</span>
						</c:when>
						<c:otherwise>
							<span>禁用</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${organization.status}">
							<input type="button" value="禁用" onclick="disabledOrganization('${organization.id}')" id="disabledButton${organization.id}"/>
							<input type="button" value="启用" onclick="enabledOrganization('${organization.id}')" id="enabledButton${organization.id}" style="display:none"/>
						</c:when>
						<c:otherwise>
							<input type="button" value="启用" onclick="enabledOrganization('${organization.id}')" id="enabledButton${organization.id}"/>
							<input type="button" value="禁用" onclick="disabledOrganization('${organization.id}')" id="disabledButton${organization.id}" style="display:none"/>
						</c:otherwise>
					</c:choose>
					<input type="button" value="编辑" onclick="editOrganizationBefore('${organization.id}')" id="editButton${organization.id}"/>
					<input type="button" value="删除" onclick="deleteOrganization('${organization.id}')" id="deleteButton${organization.id}"/>
					<input type="button" value="确定" onclick="editOrganization('${organization.id}')" style="display: none" id="OKButton${organization.id}"/>
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
				<a href="organizationList?pageNum=${page.pageNum - 1}">上一页</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${pages != 1}">
			<c:forEach var="pageIndex" begin="1" end="${page.pages}">
				<c:choose>
					<c:when test="${page.pageNum == pageIndex}">
						<a>${pageIndex}</a>
					</c:when>
					<c:otherwise>
						<a href="organizationList?pageNum=${pageIndex}">${pageIndex}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		<c:choose>
			<c:when test="${page.pageNum == page.pages}">
					<a>下一页</a>
				</c:when>
				<c:otherwise>
					<a href="organizationList?pageNum=${page.pageNum+1}">下一页</a>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>