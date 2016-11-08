<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>人事测评管理系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/demo/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
<style type="text/css">
	ul, li {
		list-style: none;
	}
	a{
		display: block;
		font-weight: bold;
		font-size:16px!important;
		height: 36px;
		line-height: 36px;
		position: relative;
	}
</style>
<script type="text/javascript">
	function setalign(align){
		$('a.easyui-menubutton').menubutton({
			menuAlign: align
		})
	}
	$(function(){
	    $('#logOut').bind('click', function(){
	    	window.location.href="${pageContext.request.contextPath}/adminLogout";
	    });
	});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:46px;background:#B3DFDA;padding-top:8px;padding-left:8px;padding-right:8px" >
		<div style="float:left;font-size: 16px;font-weight: bolder;">
			人事测评管理系统
		</div>
		<a href="#" class="easyui-menubutton" data-options="menu:'#mm3',iconCls:'icon-man'" style="float:right;">${Admin.username}</a>
		<div id="mm3">
			<div>修改资料</div>
			<div id="logOut">安全退出</div>
		</div>
	</div>
	<div data-options="region:'west',split:true,title:'系统目录'" style="width:200px">
		<div id="aa" class="easyui-accordion">
			<div title="系统用户初始化" data-options="iconCls:'icon-tip'" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/admin/SystemManage/adminList.jsp" target="mainContent">账号管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/DataManage/departList.jsp" target="mainContent">模板管理</a>
				</div>
			</div>
			<div title="信息管理" data-options="iconCls:'icon-tip'" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/admin/DataManage/departList.jsp" target="mainContent">部门管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">人员管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">问卷管理</a>
				</div>
			</div>
			<div title="测评管理" data-options="iconCls:'icon-tip'" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">测评计划管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">测评关系管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">测评方式管理</a>
				</div>
			</div>
			<div title="推送与监控" data-options="iconCls:'icon-tip'" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">短信推送</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">短信查询</a>
				</div>
			</div>
			<div title="统计分析" data-options="iconCls:'icon-tip',collapsed:false" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">答卷管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">结果生成</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">统计分析</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/organizationList" target="mainContent">结果导出</a>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;">south region</div>
	<div data-options="region:'center'">
		<iframe src="${pageContext.request.contextPath}/admin/SystemManage/systemInfo.jsp" scrolling="auto" width="100%"  height="99%" style="border: 0" name="mainContent"></iframe>
	</div>
</body>
</html>