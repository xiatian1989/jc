<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/demo/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
<style type="text/css">
	body{
		padding:0px;
	}
</style>
</head>
<body>
	<c:forEach items="templetDetails" var="templetDetail">
		${templetDetail.questionno }:${templetDetail.question }
		<p>
		A:${templetDetail.optiona }&nbsp;&nbsp;
		B:${templetDetail.optionb }&nbsp;&nbsp;
		C:${templetDetail.optionc }&nbsp;&nbsp;
		<c:if test="${templetDetail.optiond != null }">
			D:${templetDetail.optiond }&nbsp;&nbsp;
		</c:if>
		<c:if test="${templetDetail.optione != null }">
			E:${templetDetail.optione }&nbsp;&nbsp;
		</c:if>
		<c:if test="${templetDetail.optionf != null }">
			F:${templetDetail.optionf }&nbsp;&nbsp;
		</c:if>
		<p>
	</c:forEach>
</body>
</html>