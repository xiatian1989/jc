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

	function newTemplet() {

		$('#dlg').dialog('open').dialog('setTitle', '添加模板');
		$('#fm').form('clear');
		url = "${pageContext.request.contextPath}/addTemplet"
		fillDepart();
		fillLeader();
		model="add";
	}

	function editTemplet() {

		var selRow = $('#dg').datagrid('getSelections');
		if (selRow.length == 1) {
			$('#dlg').dialog('open').dialog('setTitle', '编辑模板');
			$('#fm').form('clear');
			$('#fm').form('load', selRow[0]);
			if (selRow[0].type) {
				$("#type").val("1")
			} else {
				$("#type").val("0")
			}
			if(selRow[0].status) {
				$("#status").val("1")
			} else {
				$("#status").val("0")
			}
			url = "${pageContext.request.contextPath}/updateTemplet"
		} else {
			$.messager.alert("提示", "请选择要编辑的一行数据！", "info");
		}
		model="update";
	}
	
	function saveTemplet() {

		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if (!flag) {
					return flag;
				}
				var type = $("#type").val();
				var status = $("#status").val();

				if (type = "" || type == null) {
					$.messager.alert('提示','请选择模板类型！','info');
					return false;
				}
				if (status = "" || status == null) {
					$.messager.alert('提示','请选择模板状态！','info');
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

	function destroyTemplet() {

		var row = $('#dg').datagrid('getSelections');
		if (row.length>0) {
			$.messager.confirm(
				'Confirm',
				'你确定删除选择的模板吗?',
				function(r) {
					if (r) {
						var id = "";
						for (var i = 0; i < row.length; i++) {
							id = id + row[i].id + ","
						}
						$.ajax({
							url : '${pageContext.request.contextPath}/deleteTemplet',
							type : 'post',
							data : 'id=' + id,
							async : false, //默认为true 异步   
							success : function(msg) {
								if (msg.result == "success") {
									$('#dg').datagrid('reload');
								} else {
									$.messager.alert('错误',msg.errorMsg,'error');
								}
							}
						});
					}
				});
		} else {
			$.messager.alert("提示", "请选择要删除的数据！", "info");
		}
	}

	function cancel() {
		$('#fm').form('clear');
		$('#dlg').dialog('close');
	}

	function doSearch() {
		var column = $("#column").val();
		var value =  $("#key").val();
		if(column == "type") {
			value = $("#param").val();
		}

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
			rownumbers : true,
			selectOnCheck : true,
			pageSize : 10,
			pageList : [ 5, 10, 15 ],
			url : '${pageContext.request.contextPath}/templetList',

			columns : [ [ {
				field : 'ck',
				checkbox : true,
				width : '30'
			}, {
				title : '模板标题',
				field : 'templettitle',
				width : 80,
			}, {
				title : '关键字',
				field : 'keyword',
				width : 100,
			}, {
				title : '描述',
				field : 'description',
				width : 140,
			}, {
				title : '创建时间',
				field : 'createtime',
				width : 90,
			}, {
				title : '更新时间',
				field : 'updatetime',
				width : 90,
			}, {
				title : '类型',
				field : 'type',
				width : 40,
				formatter : function(value, row, index) {
					if (value) {
						return '人事考核';
					} else {
						return '问卷';
					}
				}
			}, {
				title : '状态',
				field : 'status',
				width : 30,
				formatter : function(value, row, index) {
					if (value) {
						return '启用';
					} else {
						return '禁用';
					}
				}
			}, {
				title : '操作',
				field : 'id',
				width : 90,
				formatter : function(value, row, index) {
					return '<a href="javaScript:void(0)" onClick="openView('+"'"+value+"'"+')">预览模板</a>&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/SystemManage/templetDetailList.jsp?value='+value+'" target="mainContent">编辑模板详情</a>';
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

	function checkUniqName(){
		var templettitle =  $("#templettitle").val();
		$.ajax({   
		    url:'${pageContext.request.contextPath}/checkTempletNameUnique',   
		    type:'post',   
		    data:'name='+templettitle,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="failed") {
		    		$.messager.alert('警告','模板标题已经存在!','warning',function(){
		    			$("#userno").focus().select();
		    		});
		    	}
		    }
		});
	}
	function changeColumn() {
		var column = $("#column").val();
		if (column == 'type') {
			$("#param").show();
			$("#key").hide();
		} else {
			$("#key").show();
			$("#param").hide();
		}
	}
	
	function openView(templetId){
		$('#win').window('open');
		$('#win').window('refresh', '${pageContext.request.contextPath}/templetPreview?templetId='+templetId);
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
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newTemplet()">添加模板</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editTemplet()">编辑模板</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyTemplet()">删除模板</a>
		<div style="float:right;">
			<select id="column" name="column" onchange="changeColumn()">
				<option value="templetTitle">模板标题</option>
				<option value="keyWord">关键字</option>
				<option value="description">描述信息</option>
				<option value="type">类型</option>
			</select>
			<input type="text" id="key" name="key" value="请输入查询值" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<select id="param" name="param" style="display: none">
				<option value=1>人事考核</option>
				<option value=0>问卷</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
		
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 380px; height: 360px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=120>模板标题：</td>
					<td style="height: 28px" width=210>
						<input id=templettitle style="width: 190px" name=templettitle class="easyui-validatebox" required="true" onchange="checkUniqName()">
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>关键词：</td>
					<td style="height: 28px" width=210>
					<input id=keyword
						style="width: 195px;height:80px" name=keyword class="easyui-textbox"  data-options="multiline:true" required="true">
					</td>
				</tr>
				<tr>
					<td style="height: 50px" width=120>描述：</td>
					<td style="height: 50px" width=210><input id=description
						style="width: 195px;height:80px" name=description class="easyui-textbox"  data-options="multiline:true" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>类型：</td>
					<td style="height: 28px">
						<select id="type" name="type" style="width:195px;">
							<option value="0">问卷</option>
							<option value="1">人事考核</option>
						</select>
					</td>
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
	<div id="win" class="easyui-window" title="模板预览" style="width:800px;height:460px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true">
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="saveTemplet()">保存</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancel();">取消</a>
	</div>
</body>
</html>