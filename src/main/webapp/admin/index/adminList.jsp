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
	
	function disabledAdmin(id,flag) {
		if(flag) {
			alert("超级管理员不可以禁用！");
		}
	}
	
	function deleteAdmin(id,flag){
		if(flag) {
			alert("超级管理员不可以删除！");
		}
	}
	$(function() {
		$("#dialog-form").dialog({
			autoOpen : false,
			height : 300,
			width : 350,
			modal : true,
			buttons : {
				"OK" : function() {
					
				},
				Cancel : function() {
					$(this).dialog("close");
				}
			}

		});
		$("#addAdmin").button().click(function() {
			$("#dialog-form").dialog("open");
		});
	});
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
	<button id="addAdmin">添加管理员</button>
	<table class="altrowstable" id="alternatecolor">
		<tr>
			<th>序号</th>
			<th>组织名称</th>
			<th>管理员名称</th>
			<th>管理员类别</th>
			<th>管理员状态</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${adminList }" var="admin" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>
					<c:if test="${admin.organization != null }">
						${admin.organization.organizationName}
					</c:if>
				</td>
				<td>
					${admin.username}
				</td>
				<td>
					<c:choose>
						<c:when test="${admin.level}">
							<span>超级管理员</span>
						</c:when>
						<c:otherwise>
							<span>普通管理员</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${admin.status}">
							<span>启用</span>
						</c:when>
						<c:otherwise>
							<span>禁用</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${admin.status}">
							<input type="button" value="禁用" onclick="disabledAdmin('${admin.id}','${admin.level}')" id="disabledButton${admin.id}"/>
						</c:when>
						<c:otherwise>
							<input type="button" value="启用" onclick="enabledAdmin('${admin.id}')" id="enabledButton${admin.id}"/>
						</c:otherwise>
					</c:choose>
					<input type="button" value="编辑" onclick="editAdminBefore('${admin.id}')" id="editButton${admin.id}"/>
					<input type="button" value="删除" onclick="deleteAdmin('${admin.id}','${admin.level}')" id="deleteButton${admin.id}"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	
    <div id="dialog-form" title="创建新用户">
	 	<form action="" method="post" onsubmit="return checkInput();">
			<table width=100%>
				<tbody>
					<tr>
						<td class=“left” width=40% align="right"><label for="t1">姓
								名：</label></td>
						<td class="right"><input type="text" id="t1" name="Name"></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right"><label
							for="Password1">密 码：</label></td>
						<td class="right"><input id="Password1" type="password"
							name="Password" /></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right">地 区：</td>
						<td><select id="selc" name="place">
								<option value="quanzhou">泉州</option>
								<option value="xiamen">厦门</option>
								<option value="zhangzhou">漳州</option>
						</select></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right"><label for="txtarea">简
								介：</label></td>
						<td><textarea id="txtarea"></textarea></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>