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
		line-height: 36px;
		position: relative;
	}
	.panel-title{
		font-weight: bold!important;
		font-size:16px!important;
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
	    	window.location.href="${pageContext.request.contextPath}/admin/adminLogout";
	    });
	});
	
	function editAdmin() {
		$('#dlg').dialog('open').dialog('setTitle', '编辑资料');
		$('#fm').form('clear');
		url = "${pageContext.request.contextPath}/updateAdmin"
		$("#username").attr("readonly", "readonly")
		$("#username").val($.trim($("#adminName").text()));
		$("#id").val($("#adminId").val());
		$("#password").val("");
	}
	
	function saveAdmin() {
		$('#fm').form('submit',{
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if(!flag) {
					return flag;
				}
				var password = $("#password").val();
				var repassword = $("#repassword").val();
				if(password != repassword) {
					$.messager.alert('提示','两次输入密码不匹配！','info');
					return false;
				}
			},
			success : function(result) {
				var msg = jQuery.parseJSON(result);
				if (msg.result == "success") {
					$('#dlg').dialog('close');
				} else {
					$.messager.alert('错误',msg.errorMsg,'error');
				}
			}
		});
	}
	
	function cancel() {
		$('#fm').form('clear');
		$('#dlg').dialog('close');
	}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:46px;background:#B3DFDA;padding-top:8px;padding-left:8px;padding-right:8px" >
		<div style="float:left;font-size: 16px;font-weight: bolder;">
			人事测评管理系统
		</div>
		<input type="text" id="adminId" value="${Admin.id }" style="display: none">
		<a href="#" class="easyui-menubutton" data-options="menu:'#mm3',iconCls:'icon-man'" style="float:right;" id="adminName">${Admin.username}</a>
		<div id="mm3">
			<div onclick="editAdmin()">修改资料</div>
			<div id="logOut">安全退出</div>
		</div>
	</div>
	<div data-options="region:'west',split:true,title:'系统目录'" style="width:200px">
		<div id="aa" class="easyui-accordion">
			<div title="系统初始操作" data-options="iconCls:'icon-tip'" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/admin/SystemManage/adminList.jsp" target="mainContent">账号管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/SystemManage/templetList.jsp" target="mainContent">模板管理</a>
				</div>
			</div>
			<div title="基础信息管理" data-options="iconCls:'icon-tip'" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/admin/DataManage/departList.jsp" target="mainContent">部门管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/DataManage/userList.jsp" target="mainContent">人员管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/DataManage/papertList.jsp" target="mainContent">问卷管理</a>
				</div>
			</div>
			<div title="测评部署管理" data-options="iconCls:'icon-tip'" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/admin/EvaluationManage/planList.jsp" target="mainContent">测评计划管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/EvaluationManage/relationList.jsp" target="mainContent">测评关系管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/EvaluationManage/planListForTestType.jsp" target="mainContent">测评方式管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/EvaluationManage/smsList.jsp" target="mainContent">测评短信管理</a>
				</div>
			</div>
			<div title="测评状态监控" data-options="iconCls:'icon-tip',collapsed:false" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/admin/allPlanStatus" target="mainContent">测评状态监控</a>
				</div>
			</div>
			<div title="测评结果确认" data-options="iconCls:'icon-tip',collapsed:false" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				<div>
					<a href="${pageContext.request.contextPath}/admin/ResultManage/resultList.jsp" target="mainContent">测评答卷管理</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/ResultManage/planListForMakeSure.jsp" target="mainContent">测评结果发布</a>
				</div>
			</div>
			<div title="测评查询分析" data-options="iconCls:'icon-tip',collapsed:false" style="text-align: center;line-height: 22px;Letter-spacing: 8px;">
				
				<div>
					<a href="${pageContext.request.contextPath}/admin/ResultManage/resultSearch.jsp" target="mainContent">结果查询</a>
				</div>
				<div>
					<a href="${pageContext.request.contextPath}/admin/initResultExportSearch" target="mainContent">结果导出</a>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;text-align: center;"><p>Copyright ©2017</div>
	<div data-options="region:'center'">
		<iframe src="${pageContext.request.contextPath}/admin/SystemManage/welcome.jsp" scrolling="auto" width="100%"  height="99%" style="border: 0" name="mainContent"></iframe>
		<div id="dlg" class="easyui-dialog"
			style="width: 280px; height: 210px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
			
			<form id="fm" method="post">
				<input id=id name=id  style="display:none">
				<table>
					<tr>
						<td style="height: 28px" width=80>用户名：</td>
						<td style="height: 28px" width=150>
							<input id=username
								style="width: 130px" name=username class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td style="height: 28px">密码：</td>
						<td style="height: 28px"><input id=password style="width: 130px"
							type=password name=password></td>
					</tr>
					<tr>
						<td style="height: 28px">确认密码：</td>
						<td style="height: 28px"><input id=repassword style="width: 130px"
							type=password name=repassword></td>
					</tr>
				</table>
			</form>
			
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				onclick="saveAdmin()">保存</a>
			<a href="#" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="cancel();">取消</a>
		</div>
	</div>
</body>
</html>