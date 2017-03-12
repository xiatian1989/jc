<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎人事测评管理系统</title>
<link href="${pageContext.request.contextPath}/css/amazeui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css" />
<script language="JavaScript"
	src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/public.js"
	type="text/javascript"></script>
<style type="text/css">
</style>
<script type="text/javascript">
function IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone",
                "SymbianOS", "Windows Phone",
                "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}

function submitBefore(){
	var submitFlag = true;
	
/* 	$("#RequiredFieldtxtName").hide();
	$("#RequiredFieldtxtPwd").hide();
	$("#RequiredFieldtxtCode").hide();
	$("#message").html(""); */
	
	if($("#username").val() ==""){
		submitFlag =  false;
	}
	if($("#password").val() ==""){
		submitFlag =  false;
	}
	/* if($("#txtcode").val() =="") {
		$("#RequiredFieldtxtCode").show();
		submitFlag =  false;
	} */
	
	return submitFlag;
}
</script>
</head>
<body>
<div class="page-head-div">
	<div class="page-head">	
		<div class="page-head-title"><img src="${pageContext.request.contextPath}/images/logo.png"></div>
	</div>
</div>
<!--登录DIV-->
<div class="log">
	<div class="log-div">
    <form action="${pageContext.request.contextPath}/client/userLogin" method="post" id="form1" onsubmit="return submitBefore()">
		<div class="log-logo"><img src="${pageContext.request.contextPath}/images/hezuo.png" /></div>
		<div class="log-name"><input type="text" class="log-names" id="username" placeholder="请输入用户名" name="username" /></div>
		<div class="log-pwd"><input type="password" id ="username" class="log-pwds" placeholder="请输入密码" name="password"/></div>
		<div class="log-btn"><input type="submit" class="btn-style-01" value="&nbsp;&nbsp;&nbsp;&nbsp;登录/绑定&nbsp;&nbsp;&nbsp;&nbsp;" /></form></div></form>
		<div class="log-forget"><a href="${pageContext.request.contextPath}/client/forget.jsp">忘记密码？</a></div>
	</div>
</div>
<div class="version">
	<div>版权所有： @公司</div>
</div>
</body>
</html>