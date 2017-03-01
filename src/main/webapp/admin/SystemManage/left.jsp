<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${pageContext.request.contextPath}/js/jquery.js"></script>

<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
})	
</script>


</head>

<body style="background:#f0f9fd;">
	<div class="lefttop"><span></span>导航</div>
    
    <dl class="leftmenu">
        
    <dd>
    <div class="title">
    <span><img src="${pageContext.request.contextPath}/images/leftico01.png" /></span>系统初始化操作
    </div>
    	<ul class="menuson">
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/SystemManage/adminList.jsp" target="rightFrame">账号管理</a><i></i></li>
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/SystemManage/templetList.jsp" target="rightFrame">模板管理</a><i></i></li>          
        </ul>    
    </dd>
    
    <dd>
    <div class="title">
    <span><img src="${pageContext.request.contextPath}/images/leftico01.png" /></span>基础信息管理
    </div>
    	<ul class="menuson">
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/DataManage/departList.jsp" target="rightFrame">部门管理</a><i></i></li>
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/DataManage/userList.jsp" target="rightFrame">人员管理</a><i></i></li>
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/DataManage/papertList.jsp" target="rightFrame">问卷管理</a><i></i></li>
        </ul>    
    </dd>
    
    <dd>
    <div class="title">
    <span><img src="${pageContext.request.contextPath}/images/leftico01.png" /></span>测评部署管理
    </div>
    	<ul class="menuson">
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/EvaluationManage/planList.jsp" target="rightFrame">测评计划管理</a><i></i></li>
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/EvaluationManage/relationList.jsp" target="rightFrame">测评关系管理</a><i></i></li>
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/EvaluationManage/planListForTestType.jsp" target="rightFrame">测评方式管理</a><i></i></li>
          <li class="active"><cite></cite><a href="${pageContext.request.contextPath}/admin/EvaluationManage/smsList.jsp" target="rightFrame">测评短信管理</a><i></i></li>
        </ul>    
    </dd> 
    
    <dd>
    <div class="title">
    <span><img src="${pageContext.request.contextPath}/images/leftico01.png" /></span>测评状态监控
    </div>
    	<ul class="menuson">
        <li><cite></cite><a href="${pageContext.request.contextPath}/admin/allPlanStatus" target="rightFrame">测评状态监控</a><i></i></li>
        </ul>    
    </dd>
    
    <dd>
    <div class="title">
    <span><img src="${pageContext.request.contextPath}/images/leftico01.png" /></span>测评结果确认
    </div>
    	<ul class="menuson">
        <li><cite></cite><a href="${pageContext.request.contextPath}/admin/ResultManage/resultList.jsp" target="rightFrame">测评答卷管理</a><i></i></li>
        <li><cite></cite><a href="${pageContext.request.contextPath}/admin/ResultManage/planListForMakeSure.jsp" target="rightFrame">测评结果发布</a><i></i></li>        
        </ul>    
    </dd>
    
    <dd>
    <div class="title">
    <span><img src="${pageContext.request.contextPath}/images/leftico01.png" /></span>测评查询分析
    </div>
    	<ul class="menuson">
        <li><cite></cite><a href="${pageContext.request.contextPath}/admin/ResultManage/resultSearch.jsp" target="rightFrame">结果查询</a><i></i></li>
        <li><cite></cite><a href="${pageContext.request.contextPath}/admin/initResultExportSearch" target="rightFrame">结果导出</a><i></i></li>        
        </ul>    
    </dd>    
    
    </dl>
    
</body>
</html>

