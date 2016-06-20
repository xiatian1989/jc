<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>人事测评管理系统</title>
</head>
<FRAMESET frameSpacing="0" rows="80,*">
	<FRAME name="top" src="${pageContext.request.contextPath}/admin/index/top.jsp" frameBorder="0" noResize scrolling="no">
	<FRAMESET frameSpacing="0"  cols="220,*">
		<FRAME name="menu" src="${pageContext.request.contextPath}/admin/index/menu.jsp"  noResize>
		<FRAME name=“main” src="${pageContext.request.contextPath}/admin/index/main.jsp" >
	</FRAMESET>
	<NOFRAMES>
		<p>
            This page requires frames, but your browser does not support them.</p>
    </NOFRAMES>
</FRAMESET>
</html>