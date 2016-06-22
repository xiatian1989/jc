<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	
	function addOrganization() {
		var newRow = "<tr><td>新行第一列</td><td>新行第二列</td><td>新行第三列</td><td>新行第四列</td><td>新行第五列</td></tr>";
		$("#alternatecolor tr:last").after(newRow);
		
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
	<input type="button" value="添加组织" onclick="addOrganization()" id="addOrganization">
	<table class="altrowstable" id="alternatecolor">
		<tr>
			<th>组织名称</th>
			<th>组织状态</th>
			<th>操作</th>
		</tr>
		<c:forEach items="organizationList" var="Organization">
			<tr>
				<td><input type="text" value="${Organization.organizationName}"></td>
				<td>
					<c:choose>
						<c:when test="${Organization.status==1}">
							<span>启用</span>
						</c:when>
						<c:otherwise>
							<span>禁用</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${Organization.status==1}">
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