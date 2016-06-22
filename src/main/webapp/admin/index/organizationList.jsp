<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
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
			var newRow = "<tr><td>1</td><td><input type='text' value=''></td><td><select><option>启用</option><option>禁用</option></select></td><td><input type='button' value='确定' onclick='addOrganization()'></td></tr>";
		}else{
			count =  parseInt(count)+1
			var newRow = "<tr><td>"+count+"</td><td><input type='text' value=''></td><td><select><option>启用</option><option>禁用</option></select></td><td><input type='button' value='确定' onclick='addOrganization()'></td></tr>";
		}
		$("#alternatecolor tr:last").after(newRow);
	}
	
	function addOrganization(){
		var organizationName = $("#alternatecolor tr:last td:eq(1)").text();
		var statusText = $("#alternatecolor tr:last td:eq(2)").text();
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
		    	if(msg.result=="success") {
		    		window.location.href=='"${pageContext.request.contextPath}/organizationList"';
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
}

.oddrowcolor {
	background-color: #d4e3e5;
}

.evenrowcolor {
	background-color: #c3dde0;
}
</style>
</head>
<body>
	<input type="button" value="添加组织" onclick="addOrganizationBefore()" id="addOrganization">
	<table class="altrowstable" id="alternatecolor">
		<tr>
			<th>序号</th>
			<th>组织名称</th>
			<th>组织状态</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${organizationList }" var="organization" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td><input type="text" value="${organization.organizationName}" id="${organization.id}" disabled="disabled"></td>
				<td>
					<c:choose>
						<c:when test="${organization.status}">
							<span>启用${organization.status}</span>
						</c:when>
						<c:otherwise>
							<span>禁用${organization.status}</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${organization.status}">
							<input type="button" value="禁用">
						</c:when>
						<c:otherwise>
							<input type="button" value="启用">
						</c:otherwise>
					</c:choose>
					<input type="button" value="编辑">
					<input type="button" value="删除">
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>