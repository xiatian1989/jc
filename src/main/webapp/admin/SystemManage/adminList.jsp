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
<script type="text/javascript">
	$(function(){
		$('#dg').datagrid({
			nowrap: false,
			idField:'id',
			striped: true,
			fit: false,
			singleSelect:true,
			rownumbers:false,
			selectOnCheck:true,
			pageSize:10,
	        pageList:[5,10,15],
			url:'${pageContext.request.contextPath}/adminList',
			columns: [ [ 
			{
				title : '用户名',
				field : 'username',
				width : 100,
			}, {
				title : '角色',
				field : 'level',
				width : 100,
				formatter: function(value,row,index){
					if(value) {
						return '超级管理员';
					}else{
						return '管理员';
					}
				}
			}, {
				title : '状态',
				field : 'status',
				width : 100,
				formatter: function(value,row,index){
					if(!value) {
						return '禁用';
					}else{
						return '启用';
					}
				}
			}] ],
			fitColumns:true,
			pagination:true,
			toolbar: '#toolbar',
			onLoadSuccess:function(){  
	          $('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
	       } 
		});
	});
	
	function doSearch() {
		param = $("#key").val();
		if (param == "请输入管理员账号") {
			param ="";
		}
		  $('#dg').datagrid('load',{  
			  param: param, 
	       });  
	}
	
	function newAdmin() {
		$("#username").removeAttr("readonly")
/* 		$("#level").removeAttr("disabled") */
		$('#dlg').dialog('open').dialog('setTitle', '添加管理员');
		$('#fm').form('clear');
		url = "${pageContext.request.contextPath}/addAdmin"
		model="add";
		$("#mode").val("add");
	}

	function editAdmin() {
		
		var selRow = $('#dg').datagrid('getSelected');
		if (selRow) { 
			$('#dlg').dialog('open').dialog('setTitle', '编辑管理员');
			$('#fm').form('clear');
			$('#fm').form('load', selRow);
			url = "${pageContext.request.contextPath}/updateAdmin"
			model="update";
			
			$("#username").attr("readonly", "readonly")
			$("#status").removeAttr("disabled")
/* 			$("#level").attr("disabled", "disabled") */
			$("#mode").val("update");
			$("#password").val("");
			if(selRow.level){
				/* $("#level").val("1") */
				$("#status").attr("disabled", "disabled")
			}
			if(selRow.status){
				$("#status").val("1")
			}else if(!selRow.status){
				$("#status").val("0")
			}
		}

	}

	function saveAdmin() {

		$('#fm').form('submit',{
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if(!flag) {
					return flag;
				}
				if(model=="add") {
					var password = $("#password").val();
					var repassword = $("#repassword").val();
					
					if(password==""){
						$.messager.alert('提示','请输入密码!','info');
						return false;
					}
					if(password != repassword) {
						$.messager.alert('提示','两次输入密码不匹配！','info');
						return false;
					}
				}else if(model=="update") {
					var password = $("#password").val();
					var repassword = $("#repassword").val();
					if(password != repassword) {
						$.messager.alert('提示','两次输入密码不匹配！','info');
						return false;
					}
				}
			},
			success : function(result) {
				var msg = jQuery.parseJSON(result);
				if (msg.result == "success") {
					$('#dlg').dialog('close');
					$('#dg').datagrid('reload');
				} else {
					$.messager.alert('错误',msg.errorMsg,'error');
				}
			}
		});
	}

	function destroyAdmin() {
		
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			if(row.level){
				$.messager.alert('警告','超级管理员不能删除!','warning');
				return;
			}
			$.messager
					.confirm(
							'Confirm','你确定删除选择的管理员吗?',
							function(r) {
								if (r) {
									var id =row.id;
									$.ajax({
											url : '${pageContext.request.contextPath}/deleteAdmin',
											type : 'post',
											data : 'id='
													+ id,
											async : false, //默认为true 异步   
											success : function(msg) {
												if (msg.result == "success") {
													$('#dg').datagrid('reload');
												} else {
													$.messager.alert('错误',obj.errorMsg,'error');
												}
											}
										});
								}
							});
		}
	}

	function cancel() {
		$('#fm').form('clear');
		$('#dlg').dialog('close');
	}
	
	function checkUniqName(){
		if($("#mode").val()=='update'){
			return;
		}
		var username = $("#username").val();
		$.ajax({   
		    url:'${pageContext.request.contextPath}/checkAdminName',   
		    type:'post',   
		    data:'name='+username,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="failed") {
		    		$.messager.alert('警告','用户名已经存在!','warning',function(){
		    			$("#username").focus().select();
		    		});
		    	}
		    }
		});
	}
</script>
<style type="text/css">
	body{
		padding:0px;
	}
</style>
</head>
<body>
	<input type="text" id="mode" style="display:none">
	<table id="dg" title="管理员列表">
		
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newAdmin()">添加管理员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editAdmin()">编辑管理员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyAdmin()">删除管理员</a>
		<div style="float:right;">
			<input type="text" id="key" name="key" value="请输入管理员账号" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog"
		style="width: 280px; height: 230px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=80>用户名：</td>
					<td style="height: 28px" width=150>
						<input id=username
							style="width: 130px" name=username class="easyui-validatebox" required="true" onblur="checkUniqName()">
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
<!-- 				<tr>
					<td style="height: 28px">角色：</td>
					<td style="height: 28px">
						<select id="level" name="level" style="width: 137px">
							<option value="0">管理员</option>
							<option value="1">超级管理员</option>
						</select>
					</td>
				</tr> -->
				<tr>
					<td style="height: 28px">状态：</td>
					<td style="height: 28px">
						<select id="status" name="status" style="width: 137px">
							<option value="0">禁用</option>
							<option value="1">启用</option>
						</select>
					</td>
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
</body>
</html>