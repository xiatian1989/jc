<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎人事测评管理系统</title>
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet" type="text/css" />
<script language="JavaScript"
	src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/cloud.js"
	type="text/javascript"></script>
<style type="text/css">
</style>
<script type="text/javascript">
/* 	function refreshCode(obj){
		var day = new Date();
		var t = day.getTime();
		obj.src="${pageContext.request.contextPath}/admin/code?t="+t;
	} */
	
	function submitBefore(){
		var submitFlag = true;
		
	/* 	$("#RequiredFieldtxtName").hide();
		$("#RequiredFieldtxtPwd").hide();
		$("#RequiredFieldtxtCode").hide();
		$("#message").html(""); */
		
		if($("#txtName").val() ==""){
			submitFlag =  false;
		}
		if($("#txtPwd").val() ==""){
			submitFlag =  false;
		}
		/* if($("#txtcode").val() =="") {
			$("#RequiredFieldtxtCode").show();
			submitFlag =  false;
		} */
		
		return submitFlag;
	}
	
	$(function(){
	    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
		$(window).resize(function(){  
	    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	    })  
	});  
	
</script>
</head>
<body
	style="background-color:#1c77ac; background-image:url(${pageContext.request.contextPath}/images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">



	<div id="mainBody">
		<div id="cloud1" class="cloud"></div>
		<div id="cloud2" class="cloud"></div>
	</div>


<!-- 	<div class="logintop">
		<span>欢迎登录人事测评管理平台</span>
		<ul>
			<li><a href="#">帮助</a></li>
			<li><a href="#">关于</a></li>
		</ul>
	</div> -->

	<div class="loginbody">

		<span class="systemlogo"></span>

		<div class="loginbox">
			<form action="${pageContext.request.contextPath}/admin/adminLogin" method="post" id="form1" onsubmit="return submitBefore()">
				<ul>
					<li><input name="txtName" type="text" class="loginuser" value="admin" onclick="JavaScript:this.value=''" /></li>
					<li><input name="txtPwd" type="password" class="loginpwd" value="password" onclick="JavaScript:this.value=''" /></li>
					<li><input name="" type="submit" class="loginbtn" value="登录"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="reset" class="loginbtn" value="重置"/></li>
				</ul>
			</form>
		</div>
	</div>
	<div class="loginbm">
		版权所有 2016 <a href="#">公司</a>
	</div>


</body>
</html>