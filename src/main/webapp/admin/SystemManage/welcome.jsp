<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script>
/*获取当前时间及当前时间加N分钟后的时间*/
function CurentTime(addtime)   
{   
    var now = new Date();    
    var year = now.getFullYear();       //年   
    var month = now.getMonth() + 1;     //月   
    var day = now.getDate();            //日

    var hh = now.getHours(); //时
    var mm = (now.getMinutes() + addtime) % 60;  //分
    if ((now.getMinutes() + addtime) / 60 > 1) {
        hh += Math.floor((now.getMinutes() + addtime) / 60);
    }
     
    var clock = year + "-";   
     
    if(month < 10)   
        clock += "0";   
     
    clock += month + "-";   
     
    if(day < 10)   
        clock += "0";   
         
    clock += day + " ";   
     
    if(hh < 10)   
        clock += "0";   
         
    clock += hh + ":";   
    if (mm < 10) clock += '0';   
    clock += mm;   
    return(clock);
}
$(function(){
	var now = CurentTime(0);
	$("#now").text("现在时间："+now);
	
	var now1 = new Date(),
	hour = now1.getHours()
	
	if(hour < 6){$("#time").text("凌晨好！")} 
	else if (hour < 9){$("#time").text("早上好！")} 
	else if (hour < 12){$("#time").text("上午好！")} 
	else if (hour < 14){$("#time").text("中午好！")} 
	else if (hour < 17){$("#time").text("下午好！")} 
	else if (hour < 19){$("#time").text("傍晚好！")} 
	else if (hour < 22){$("#time").text("晚上好！")} 
	else {$("#time").text("夜里好！")} 
});

</script>
</head>


<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="${pageContext.request.contextPath}/admin/SystemManage/welcome.jsp" target="rightFrame">首页</a></li>
    </ul>
    </div>
    
    <div class="mainindex">
    
    
    <div class="welinfo">
    <span><img src="${pageContext.request.contextPath}/images/sun.png" alt="天气" /></span>
    <b>${Admin.username}<span id="time"></span>，欢迎使用人事测评管理系统</b>
    <a href="${pageContext.request.contextPath}/admin/SystemManage/adminList.jsp" target="rightFrame">帐号设置</a>
    </div>
    
     <div class="welinfo">
    <span><img src="${pageContext.request.contextPath}/images/time.png" alt="时间" /></span>
    <i><span id="now"></span></i>
    </div>
</body>

</html>