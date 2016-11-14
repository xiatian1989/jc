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

		var role = $("#loginRole").val();
		if (role != "0" && role != "1") {
			$.messager.alert('警告', '你没有权限进行该操作!', 'warning');
			return;
		}

		$('#dlg').dialog('open').dialog('setTitle', '添加学生');
		$('#fm').form('clear');
		url = "${pageContext.request.contextPath}/addStudent"
	}

	function editUser() {

		var role = $("#loginRole").val();
		if (role != "0") {
			$.messager.alert('警告', '你没有权限进行该操作!', 'warning');
			return;
		}

		var selRow = $('#dg').datagrid('getSelections');
		if (selRow.length == 1) {
			$('#dlg').dialog('open').dialog('setTitle', '编辑用户');
			$('#fm').form('clear');
			$('#fm').form('load', selRow[0]);
			if (!selRow[0].isdrop) {
				$("#isdrop").val("0")
			} else {
				$("#isdrop").val("1")
			}
			if (!selRow[0].isjoin) {
				$("#isjoin").val("0")
			} else {
				$("#isjoin").val("1")
			}
			if (!selRow[0].iskeep) {
				$("#iskeep").val("0")
			} else {
				$("#iskeep").val("1")
			}
			url = "${pageContext.request.contextPath}/updateStudent"
		} else {
			$.messager.alert("提示", "请选择要编辑的一行数据！", "info");
		}

	}

	function saveUser() {

		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if (!flag) {
					return flag;
				}
				var isdrop = $("#isdrop").val();
				var isjoin = $("#isjoin").val();
				var iskeep = $("#iskeep").val();

				if (isdrop = "" || isdrop == null) {
					alert("请选择是否离校！")
					return false;
				}
				if (isjoin = "" || isjoin == null) {
					alert("请选择是否入伍！")
					return false;
				}
				if (iskeep = "" || iskeep == null) {
					alert("请选择是否保留学籍！")
					return false;
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

		var role = $("#loginRole").val();
		if (role != "0") {
			$.messager.alert('警告', '你没有权限进行该操作!', 'warning');
			return;
		}

		var row = $('#dg').datagrid('getSelections');
		if (row) {
			$.messager
					.confirm(
							'Confirm',
							'你确定删除选择的学生吗?',
							function(r) {
								if (r) {
									var id = "";
									for (var i = 0; i < row.length; i++) {
										id = id + row[i].id + ","
									}
									$
											.ajax({
												url : '${pageContext.request.contextPath}/deleteStudentById',
												type : 'post',
												data : 'id=' + id,
												async : false, //默认为true 异步   
												success : function(msg) {
													var obj = jQuery
															.parseJSON(msg);
													if (obj.result == "success") {
														$('#dg').datagrid(
																'reload');
														;
													} else {
														$.messager.alert('错误',
																obj.errorMsg,
																'error');
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
		var param = "";
		if (column == 'isDrop' || column == 'isJoin' || column == 'isKeep') {
			param = $("#param").val();
		} else {
			param = $("#key").val();
		}

		if (param == "请输入查询值") {
			param = "";
		}
		$('#dg').datagrid('load', {
			column : column,
			param : param,
		});
	}

	function changeColumn() {
		var column = $("#column").val();
		if (column == 'isDrop' || column == 'isJoin' || column == 'isKeep') {
			$("#param").show();
			$("#key").hide();
		} else {
			$("#key").show();
			$("#param").hide();
		}
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
			url : '${pageContext.request.contextPath}/studentList',

			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true,
				width : '30'
			}, {
				title : '学号',
				field : 'studentno',
				width : 80,
			}, {
				title : '姓名',
				field : 'truename',
				width : 60,
			}, {
				title : '身份证号',
				field : 'idcard',
				width : 138,
			}, {
				title : '银行账号',
				field : 'accout',
				width : 138,
			}, {
				title : '年级',
				field : 'grade',
				width : 40,
			}, {
				title : '系部',
				field : 'college',
				width : 100,
			}, {
				title : '专业',
				field : 'profession',
				width : 100,
			}, {
				title : '班级',
				field : 'classname',
				width : 80,
			}, {
				title : '寝室编号',
				field : 'hotelno',
				width : 60,
			} ] ],
			columns : [ [ {
				title : '是否离校',
				field : 'isdrop',
				width : 50,
				formatter : function(value, row, index) {
					if (value) {
						return '是';
					} else {
						return '否';
					}
				}
			}, {
				title : '离校时间',
				field : 'droptime',
				width : 60,
			}, {
				title : '是否入伍',
				field : 'isjoin',
				width : 50,
				formatter : function(value, row, index) {
					if (value) {
						return '是';
					} else {
						return '否';
					}
				}
			}, {
				title : '是否保留学籍',
				field : 'iskeep',
				width : 70,
				formatter : function(value, row, index) {
					if (value) {
						return '是';
					} else {
						return '否';
					}
				}
			}, {
				title : '备注',
				field : 'remarks',
				width : 50,
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
					url : '${pageContext.request.contextPath}/uploadExcel',
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

		var role = $("#loginRole").val();
		if (role != "0" && role != "1") {
			$.messager.alert('警告', '你没有权限进行该操作!', 'warning');
			return;
		}

		$('#dlgForUpload').dialog('open').dialog('setTitle', '导入学生');
		$('#uploadExcel').form('clear');
	}
	function exportUser() {
		var url = "${pageContext.request.contextPath}/exportExcel";
		window.open(url);
	}
</script>
<style type="text/css">
	body{
		padding:0px;
	}
</style>
</head>
<body>
<table id="dg" title="职员列表">
		
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加职员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑职员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除职员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="importUser()">导入职员</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="exportUser()">导出职员</a>
		<div style="float:right;">
			<select id="column" name="column">
				<option value="studentNo">学号</option>
				<option value="trueName">姓名</option>
				<option value="idCard">身份证号</option>
				<option value="accout">银行账号</option>
				<option value="grade">年级</option>
				<option value="college">系部</option>
				<option value="profession">专业</option>
				<option value="className">班级</option>
				<option value="hotelno">寝室编号</option>
				<option value="isDrop">是否离校</option>
				<option value="isJoin">是否入伍</option>
				<option value="isKeep">是否保留学籍</option>
			</select>
			<input type="text" id="key" name="key" value="请输入查询值" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
		
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 420px; height: 540px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=120>学号：</td>
					<td style="height: 28px" width=210><input id=studentno
						style="width: 190px" name=studentno class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>姓名：</td>
					<td style="height: 28px" width=210><input id=truename
						style="width: 190px" name=truename class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>身份证号：</td>
					<td style="height: 28px" width=210><input id=idcard
						style="width: 190px" name=idcard class="easyui-validatebox" validType="length[17,18]" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>银行账号：</td>
					<td style="height: 28px" width=210><input id=accout
						style="width: 190px" name=accout class="easyui-validatebox" validType="length[15,22]"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>年级：</td>
					<td style="height: 28px" width=210><input id=grade
						style="width: 190px" name=grade class="easyui-validatebox" validType="length[4,4]" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>系部：</td>
					<td style="height: 28px" width=210><input id=college
						style="width: 190px" name=college class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>专业：</td>
					<td style="height: 28px" width=210><input id=profession
						style="width: 190px" name=profession class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>班级：</td>
					<td style="height: 28px" width=210><input id=classname
						style="width: 190px" name=classname class="easyui-validatebox"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>寝室编号：</td>
					<td style="height: 28px" width=210><input id=hotelno
						style="width: 190px" name=hotelno class="easyui-validatebox"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>是否离校：</td>
					<td style="height: 28px">
						<select id="isdrop" name="isdrop" style="width:195px;">
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>离校时间：</td>
					<td style="height: 28px" width=210><input id=droptime
						style="width: 195px" name=droptime class="easyui-datebox" data-options="formatter:myformatter,parser:myparser"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>是否入伍：</td>
					<td style="height: 28px">
						<select id="isjoin" name="isjoin" style="width:195px;">
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>是否保留学籍：</td>
					<td style="height: 28px">
						<select id="iskeep" name="iskeep" style="width:195px;" >
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>备注：</td>
					<td style="height: 28px" width=210><input id=remarks
						style="width: 190px" name=remarks class="easyui-validatebox"></td>
				</tr>
			</table>
		</form>
		
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="saveUser()">Save</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancel();">Cancel</a>
	</div>
	
	<div id="dlgForUpload" class="easyui-dialog"
		style="width: 410px; height: 200px; padding: 10px 20px" closed="true" buttons="#dlg-buttonsdlgForUpload">
		<form method="post" enctype="multipart/form-data" id="uploadExcel" style="margin-top:20px">
			 导入数据之前，请先<a href="${pageContext.request.contextPath}/templet/student.xls">下载模板</a>
			  <p>
			  <p>
     		  <input type="file" name="fileUpload" style="width:100%" id="uploadFile"/>
        </form>
	</div>
	
	<div id="dlg-buttonsdlgForUpload">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="upload()">Upload</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlgForUpload').dialog('close')">Cancel</a>
	</div>
</body>
</html>