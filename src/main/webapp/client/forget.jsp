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
</head>
<body>
<div class="page-head-div">
	<div class="page-head">
		<a href="javascript:history.go(-1);">
			<div class="page-head-left am-icon-mail-reply"></div>
		</a>
		<div class="page-head-title">找回密码</div>
	</div>
</div>

<!--登录DIV-->
<div class="forget">
	<div class="forget-div">
		<div class="fgt-phone">
			<input type="text" class="fgt-phone-int" id="phone" placeholder="请输入您的手机号码" onblur="checkPhone()"/>
			<img src="img/ok.png" class="regP1" />
			<img src="img/no.png" class="regP2" />
		</div>
		<div class="fgt-yzm"><input type="text" class="fgt-yzm-int" placeholder="输入验证码" /><input id="btnSendCode" onclick="sendMessage()" class="fgt-get-yzm" type="button" value="获取验证码" /></div>
		<div class="fgt-new"><input type="text" class="fgt-phone-int fgt-new-int" placeholder="设置新密码"/></div>
		<div class="fgt-help">* 6-12位数字或者大小写字母</div>
		<div class="fgt-btn"><button>重置密码</button></div>
	</div>
</div>
<!--短信发送提升弹出框-->
<div class="alert-div-msg">
	<div class="alert-gwc">
		<div class="alert-gwc-cd">系统提示<span class="alert-close">×</span></div>
		<div class="alert-gwc-text">短信已发至号码<span class="setPhone"></span>，有效时间为10分钟，如非本人操作请勿泄漏。</div>
		<div class="alert-gwc-btn"><span class="gwc-btn-ok">确定</span></div>
	</div>
</div>
<style>
.alert-div-msg{display:none;width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.40);position: fixed;top: 0px;}
</style>

<script type="text/javascript">
var InterValObj; //timer变量，控制时间
var count = 4; //间隔函数，1秒执行
var curCount;//当前剩余秒数

function sendMessage() {
	var phone = /^0?1[3|4|5|7|8][0-9]\d{8}$/;//手机号
	var phones = document.getElementById('phone').value.trim();
	if ($(".regP1").is(":hidden") && $(".regP2").is(":visible")) {
		$(".alert-gwc-text").text("请输入正确的手机号码！")
		$(".alert-div-msg").show();
		return false;
	}
	if($("#phone").val() == ""){
		$(".alert-gwc-text").text("手机号码不得为空！")
		$(".alert-div-msg").show();
		return false;
	}
	curCount = count;
	//设置button效果，开始计时
	$("#btnSendCode").attr("disabled", "true");
	$("#btnSendCode").css("background-color","#CCCCCC")
	$(".alert-div-msg").show();
	$(".alert-gwc-text").text("短信已发至号码 "+$("#phone").val()+"，有效时间为10分钟，如非本人操作请勿泄漏。")
	$("#btnSendCode").val( + curCount + "秒再获取");
	InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
}
$(".gwc-btn-ok").on("click",function(){
	$("[class*='alert-div-']").hide();
});
$(".alert-close").on("click",function(){
	$("[class*='alert-div-']").hide();
});

//重置密码成功提示框
$(".fgt-btn button").on("click",function(){
	$(".alert-div-msg").show();
	$(".alert-gwc-text").text("密码重置成功！");
});

//timer处理函数
function SetRemainTime() {
	if (curCount == 0) {                
		window.clearInterval(InterValObj);//停止计时器
		$("#btnSendCode").removeAttr("disabled");//启用按钮
		$("#btnSendCode").val("重新发送");
		$("#btnSendCode").css("background-color","#2982ba")
	}
	else {
		curCount--;
		$("#btnSendCode").val( + curCount + "秒再获取");
	}
}
</script>
<script>
// 校验手机号码
function checkPhone(){
  var phone = /^0?1[3|4|5|7|8][0-9]\d{8}$/;//手机号
  var phones = document.getElementById('phone').value.trim();
  if (phone.test(phones)) {
      $(".regP1").show();
      $(".regP2").hide();
   }else{
      $(".regP1").hide();
      $(".regP2").show();
   };
}
</script>
</body>
</html>
</html>