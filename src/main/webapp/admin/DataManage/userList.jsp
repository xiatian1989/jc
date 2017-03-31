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

	function newUser() {

		$('#dlg').dialog('open').dialog('setTitle', '添加人员');
		$('#fm').form('clear');
		url = "${pageContext.request.contextPath}/admin/addUser"
		fillDepart();
		fillLeader();
		model="add";
	}

	function editUser() {

		var selRow = $('#dg').datagrid('getSelections');
		if (selRow.length == 1) {
			$('#dlg').dialog('open').dialog('setTitle', '编辑人员');
			$('#fm').form('clear');
			$('#fm').form('load', selRow[0]);
			fillDepart();
			fillLeader();
			if (selRow[0].sex) {
				$("#sex").val("1")
			} else {
				$("#sex").val("0")
			}
			if(selRow[0].status) {
				$("#status").val("1")
			} else {
				$("#status").val("0")
			}
			$("#password").val("")
			$("#departNo option").each(function(){
				if($(this).text()==selRow[0].departName)  
                    $(this).attr("selected", "selected"); 
			});
			$("#leaderNo option").each(function(){
				if($(this).text()==selRow[0].leaderName)  
                    $(this).attr("selected", "selected"); 
			});
			url = "${pageContext.request.contextPath}/admin/updateUser"
		} else {
			$.messager.alert("提示", "请选择要编辑的一行数据！", "info");
		}
		model="update";
	}
	
	function fillDepart(){
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/getDeparts',
			type : 'post',
			async : false, //默认为true 异步   
			success : function(objs) {
				$("#departNo").empty();
				for(var i =0;i<objs.length;i++) {
					$("#departNo").append("<option value='"+objs[i].departNo+"'>"+objs[i].departName+"</option>");
				}
			}
		});
	}
	
	function fillLeader(){
		var departNo = $("#departNo").val();
		var userno = $("#userno").val();
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/getUsersByDepartNo',
			type : 'post',
			data : 'departNo='+departNo,
			async : false, //默认为true 异步   
			success : function(objs) {
				$("#leaderNo").empty();
				$("#leaderNo").append("<option value=''></option>");
				for(var i =0;i<objs.length;i++) {
					if(userno != objs[i].userno) {
						$("#leaderNo").append("<option value='"+objs[i].userno+"'>"+objs[i].truename+"</option>");
					}
				}
			}
		});
	}

	function saveUser() {

		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if (!flag) {
					return flag;
				}
				var sex = $("#sex").val();
				var status = $("#status").val();

				if (sex = "" || sex == null) {
					$.messager.alert('提示','请选择人员性别！','info');
					return false;
				}
				if (status = "" || status == null) {
					$.messager.alert('提示','请选择人员状态！','info');
					return false;
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
				var obj = jQuery.parseJSON(result);
				if (obj.result == "success") {
					$('#dlg').dialog('close');
					$('#dg').datagrid('reload');
				} else {
					$.messager.alert('错误', obj.errorMsg, 'error');
				}
			}
		});
	}

	function destroyUser() {

		var row = $('#dg').datagrid('getSelections');
		if (row.length>0) {
			$.messager
					.confirm(
							'Confirm',
							'你确定删除选择的人员吗?',
							function(r) {
								if (r) {
									var id = "";
									for (var i = 0; i < row.length; i++) {
										id = id + row[i].id + ","
									}
									$.ajax({
										url : '${pageContext.request.contextPath}/admin/deleteUser',
										type : 'post',
										data : 'id=' + id,
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

	function doSearch() {
		var column = $("#column").val();
		var value =  $("#key").val();

		if (value == "请输入查询值") {
			value = "";
		}
		$('#dg').datagrid('load', {
			column : column,
			value : value,
		});
	}

	$(function() {
		$('#dg').datagrid({
			nowrap : false,
			idField : 'id',
			striped : true,
			fit : false,
			singleSelect : false,
			rownumbers : false,
			selectOnCheck : true,
			pageSize : 10,
			pageList : [ 5, 10, 15 ],
			url : '${pageContext.request.contextPath}/admin/userList',

			columns : [ [ {
				field : 'ck',
				checkbox : true,
				width : 30,
				align:'center',
			}, {
				title : '部门名称',
				field : 'departName',
				width : 80,
				align:'center',
			}, {
				title : '姓名',
				field : 'truename',
				width : 60,
				align:'center',
			}, {
				title : '用户编号',
				field : 'userno',
				width : 60,
				align:'center',
			}, {
				title : '上级领导',
				field : 'leaderName',
				width : 60,
				align:'center',
			}, {
				title : '性别',
				field : 'sex',
				width : 30,
				align:'center',
				formatter : function(value, row, index) {
					if (value) {
						return '女';
					} else {
						return '男';
					}
				}
			}, {
				title : '手机号码',
				field : 'phone',
				width : 80,
				align:'center',
		/* 	}, {
				title : '微信号',
				field : 'webchat',
				width : 80,
				align:'center', */
			}, {
				title : '创建时间',
				field : 'createtime',
				width : 100,
				align:'center',
			}, {
				title : '状态',
				field : 'status',
				width : 50,
				align:'center',
				formatter : function(value, row, index) {
					if (value) {
						return '启用';
					} else {
						return '禁用';
					}
				}
			} ] ],
			fitColumns : true,
			pagination : true,
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
			}
		});
	});

	function upload() {

		$('#uploadExcel').form(
				'submit',
				{
					url : '${pageContext.request.contextPath}/admin/uploadExcelForUser',
					onSubmit : function() {
						var fileName = $("#uploadFile").val();
						if (fileName == "") {
							$.messager.alert('错误', "请选择上传文件！", 'error');
							return false;
						} else if (fileName.split(".")[1] != 'xls') {
							$.messager.alert('错误', "请选择xls文件！", 'error');
							return false;
						}
					},
					success : function(result) {
						var obj = jQuery.parseJSON(result);
						if (obj.result == "success") {
							$.messager.alert('Success', '已经成功导入' + obj.count
									+ '条数据!', 'info');
							$('#dlgForUpload').dialog('close');
							$('#dg').datagrid('reload');
						} else {
							$.messager.alert('错误', obj.errorMsg, 'error');
						}
					}
				});
	}

	function importUser() {
		$('#dlgForUpload').dialog('open').dialog('setTitle', '导入学生');
		$('#uploadExcel').form('clear');
		$('#dg').datagrid('reload');
	}
	function exportUser() {
		var url = "${pageContext.request.contextPath}/admin/exportExcelForUser";
		window.open(url);
	}
	function checkUniqNo(){
		var userno =  $("#userno").val();
		$.ajax({   
		    url:'${pageContext.request.contextPath}/admin/checkUserNoUnique',   
		    type:'post',   
		    data:'userNo='+userno,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="failed") {
		    		$.messager.alert('警告','用户编号已经存在!','warning',function(){
		    			$("#userno").focus().select();
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
<table id="dg" title="人员列表">
		
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加人员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑人员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除人员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="importUser()">导入人员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="exportUser()">导出人员</a>
		<div style="float:right;">
			<select id="column" name="column">
				<option value="depart_No">部门名称</option>
				<option value="trueName">姓名</option>
				<option value="userno">用户编号</option>
				<option value="leader_No">上级领导</option>
				<option value="sex">性别</option>
				<option value="phone">电话号码</option>
				<option value="wechat">微信号</option>
			</select>
			<input type="text" id="key" name="key" value="请输入查询值" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
		
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 420px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=120>部门：</td>
					<td style="height: 28px" width=210>
						<select id="departNo" name="departNo" style="width:195px;" onchange="fillLeader()">
						</select>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>姓名：</td>
					<td style="height: 28px" width=210><input id=truename
						style="width: 190px" name=truename class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>用户编号：</td>
					<td style="height: 28px" width=210><input id=userno
						style="width: 190px" name=userno class="easyui-validatebox" required="true" onchange="checkUniqNo()"></td>
				</tr>
				<tr>
					<td style="height: 28px">密码：</td>
					<td style="height: 28px" width=210><input id=password style="width: 190px"
						type=password name=password></td>
				</tr>
				<tr>
					<td style="height: 28px">确认密码：</td>
					<td style="height: 28px" width=210><input id=repassword style="width: 190px"
						type=password name=repassword></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>上级领导：</td>
					<td style="height: 28px" width=210>
						<select id="leaderNo" name="leaderNo" style="width:195px;">
						</select>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>性别：</td>
					<td style="height: 28px">
						<select id="sex" name="sex" style="width:195px;">
							<option value="1">女</option>
							<option value="0">男</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>电话号码：</td>
					<td style="height: 28px" width=210><input id=phone
						style="width: 190px" name=phone class="easyui-validatebox" required="true" validType="length[11,11]"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>微信号：</td>
					<td style="height: 28px" width=210><input id=webchat
						style="width: 190px" name=webchat class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>状态：</td>
					<td style="height: 28px">
						<select id="status" name="status" style="width:195px;" >
							<option value="1">启用</option>
							<option value="0">禁用</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="saveUser()">保存</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancel();">取消</a>
	</div>
	
	<div id="dlgForUpload" class="easyui-dialog"
		style="width: 410px; height: 200px; padding: 10px 20px" closed="true" buttons="#dlg-buttonsdlgForUpload">
		<form method="post" enctype="multipart/form-data" id="uploadExcel" style="margin-top:20px">
			 导入数据之前，请先<a href="${pageContext.request.contextPath}/templet/user.xls">下载模板</a>
			  <p>
			  <p>
     		  <input type="file" name="fileUpload" style="width:100%" id="uploadFile"/>
        </form>
	</div>
	
	<div id="dlg-buttonsdlgForUpload">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="upload()">上传</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlgForUpload').dialog('close')">取消</a>
	</div>
</body>
</html>