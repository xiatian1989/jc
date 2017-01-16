<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>错误提示</title>
 <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/css/style1.css" type="text/css" />
</head>
<body>
<div class="controller">
    <div class="objects"> 
    <!-- text area -->
    <div class="text-area rotate">
    <p class="error">错误提示</p>
    <p class="details">${errorMsg }</p> 
    </div>
</body>
</html>