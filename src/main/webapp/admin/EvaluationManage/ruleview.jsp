<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<table id="dg" width="100%" data-options="striped:true">
		<thead>
			<tr>
				<th>范围</th><th>描述</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${rule.first}~满分</td><td>${rule.firstname}</td>
			</tr>
			<tr>
				<td>${rule.second}~${rule.first}</td><td>${rule.secondname}</td>
			</tr>
			<tr>
				<td>${rule.third}~${rule.second}</td><td>${rule.thirdname}</td>
			</tr>
			<c:if test="${rule.forth != null && rule.forthname != null}">
				<tr>
					<td>${rule.forth}~${rule.third}</td><td>${rule.forthname}</td>
				</tr>
			</c:if>
			<c:if test="${rule.fifth != null && rule.fifthname != null}">
				<tr>
					<td>${rule.forth}~${rule.fifth}</td><td>${rule.fifthname}</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>