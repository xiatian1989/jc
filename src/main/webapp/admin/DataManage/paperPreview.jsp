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
	<c:forEach items="${paperDetails }" var="paperDetail">
		${paperDetail.questionno }:${paperDetail.question }
		<p>
		&nbsp;&nbsp;<input type="radio" disabled="disabled">A:${paperDetail.optiona }&nbsp;&nbsp;
		<input type="radio" disabled="disabled">B:${paperDetail.optionb }&nbsp;&nbsp;
		<input type="radio" disabled="disabled">C:${paperDetail.optionc }&nbsp;&nbsp;
		<input type="radio" disabled="disabled">D:${paperDetail.optiond }&nbsp;&nbsp;
		<c:if test="${paperDetail.optione != null && paperDetail.optione != '' }">
			<input type="radio" disabled="disabled">E:${paperDetail.optione }&nbsp;&nbsp;
		</c:if>
		<c:if test="${paperDetail.optionf != null && paperDetail.optionf != ''}">
			<input type="radio" disabled="disabled">F:${paperDetail.optionf }&nbsp;&nbsp;
		</c:if>
		<c:if test="${paperDetail.issuggest}">
			建议：<input type="text" disabled="disabled">
		</c:if>
		<p>
	</c:forEach>
</body>
</html>