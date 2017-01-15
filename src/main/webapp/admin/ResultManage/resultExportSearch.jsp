<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
	<title>学费管理系统</title>
	<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/demo/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
	<style>
	html, body {
		margin: 0;
		padding: 0
	}
	.panel{
		font-size: 14px!important;
	}
	.right {
		margin-right: 15px;
	}
</style>
	<script>
		function search(){
			var planId = $("#planId").val();
			window.location.href="${pageContext.request.contextPath}/admin/ResultManage/resultExport.jsp?planId="+planId;
		}
	</script>
</head>
<body>
	<div id="header" class="easyui-panel" title="查询条件" style="height:70px;text-align: center; line-height:40px;">
		<select id="planId">
			<c:forEach items="${plans}" var="plan">
				<option value="${plan.id}">${plan.plantitle}</option>
			</c:forEach>
		</select>
		<input type="button" value="搜索" onclick="search()"> 
	</div>
</body>
</html>