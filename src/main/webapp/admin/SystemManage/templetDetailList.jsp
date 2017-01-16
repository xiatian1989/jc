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

	function newQuestion() {

		$('#dlg').dialog('open').dialog('setTitle', '添加题目');
		$('#fm').form('clear');
		url = "${pageContext.request.contextPath}/admin/addTempletDetail"
		model="add";
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/getTempletDetailNo',
			type : 'post',
			async : false, //默认为true 异步   
			success : function(msg) {
				$("#questionno").val(msg.total);
			}
		});
	}

	function editQuestion() {

		var selRow = $('#dg').datagrid('getSelections');
		if (selRow.length == 1) {
			$('#dlg').dialog('open').dialog('setTitle', '编辑题目');
			$('#fm').form('clear');
			$('#fm').form('load', selRow[0]);
			if (selRow[0].issuggest) {
				$("#issuggest").val("1")
			} else {
				$("#issuggest").val("0")
			}
			url = "${pageContext.request.contextPath}/admin/updateTempletDetail"
		} else {
			$.messager.alert("提示", "请选择要编辑的一行数据！", "info");
		}
		model="update";
	}

	function saveQuestion() {

		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if (!flag) {
					return flag;
				}
				var issuggest = $("#issuggest").val();
				if(issuggest) {
					return true;
				}else{
					$.messager.alert("提示", "请选择是否添加建议选项！", "info");
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

	function destroyQuestion() {

		var row = $('#dg').datagrid('getSelections');
		if (row.length>0) {
			$.messager.confirm(
				'Confirm',
				'你确定删除选择的题目吗?',
				function(r) {
					if (r) {
						var id = "";
						for (var i = 0; i < row.length; i++) {
							id = id + row[i].id + ","
						}
						$.ajax({
							url : '${pageContext.request.contextPath}/admin/deleteTempletDetails',
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
		} else {
			$.messager.alert("提示", "请选择要删除的数据！", "info");
		}
	}

	function cancel() {
		$('#fm').form('clear');
		$('#dlg').dialog('close');
	}

	function doSearch() {
		var value =  $("#key").val();

		if (value == "请输入题目名称") {
			value = "";
		}
		$('#dg').datagrid('load', {
			value : value,
		});
	}

	$(function() {
		var templetId = GetQueryString("value");
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
			url : '${pageContext.request.contextPath}/admin/templetDetailList?templetId='+templetId,
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true,
				width : '30'
			}, {
				title : '题号',
				field : 'questionno',
				width : 30,
			}, {
				title : '题目',
				field : 'question',
				width : 260,
			}] ],
			columns : [ [{
				title : '选项A',
				field : 'optiona',
				width : 120,
			}, {
				title : '分数',
				field : 'optionascore',
				width : 30,
			}, {
				title : '选项B',
				field : 'optionb',
				width : 120,
			}, {
				title : '分数',
				field : 'optionbscore',
				width : 30,
			}, {
				title : '选项C',
				field : 'optionc',
				width : 120,
			}, {
				title : '分数',
				field : 'optioncscore',
				width : 30,
			}, {
				title : '选项D',
				field : 'optiond',
				width : 120,
			}, {
				title : '分数',
				field : 'optiondscore',
				width : 30,
			}, {
				title : '选项E',
				field : 'optione',
				width : 100,
			}, {
				title : '分数',
				field : 'optionescore',
				width : 30,
			}, {
				title : '选项F',
				field : 'optionf',
				width : 120,
			}, {
				title : '分数',
				field : 'optionfscore',
				width : 30,
			} , {
				title : '是否添加建议项',
				field : 'issuggest',
				width : 90,
				formatter : function(value, row, index) {
					if (value) {
						return '是';
					} else {
						return '否';
					}
				}
			}  ] ],
			pagination : true,
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
			}
		});
	});
	
	
	function GetQueryString(name)
	{
	     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	     var r = window.location.search.substr(1).match(reg);
	     if(r!=null)return  unescape(r[2]); return null;
	}

	function upload() {

		$('#uploadExcel').form(
				'submit',
				{
					url : '${pageContext.request.contextPath}/admin/uploadExcelForTempletDetail',
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

	function importQuestion() {
		$('#dlgForUpload').dialog('open').dialog('setTitle', '导入学生');
		$('#uploadExcel').form('clear');
		$('#dg').datagrid('reload');
	}
	function exportQuestion() {
		var url = "${pageContext.request.contextPath}/exportExcelForTempletDetail";
		window.open(url);
	}
	function checkUniqName(){
		var question =  $("#question").val();
		$.ajax({   
		    url:'${pageContext.request.contextPath}/admin/checkTempletDetailNameUnique',   
		    type:'post',   
		    data:'name='+question,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="failed") {
		    		$.messager.alert('警告','题目已经存在!','warning',function(){
		    			$("#question").focus().select();
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
<table id="dg" title="题目列表">
		
	</table>
	<div id="toolbar">
		<a href="${pageContext.request.contextPath}/admin/SystemManage/templetList.jsp" class="easyui-linkbutton" iconCls="icon-back" plain="true">返回</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newQuestion()">添加题目</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editQuestion()">编辑题目</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyQuestion()">删除题目</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="importQuestion()">导入题目</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="exportQuestion()">导出题目</a>
		<div style="float:right;">
			<input type="text" id="key" name="key" value="请输入题目名称" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
		
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 460px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=120>题号：</td>
					<td style="height: 28px" width=210>
						<input id=questionno style="width: 190px" name=questionno class="easyui-validatebox" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>题目：</td>
					<td style="height: 28px" width=210><input id=question
						style="width: 195px;height:80px" name=question class="easyui-textbox"  data-options="multiline:true" required="true"  onchange="checkUniqName()"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>选项A：</td>
					<td style="height: 28px" width=210><input id=optiona
						style="width: 190px" name=optiona class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px">选项A分数：</td>
					<td style="height: 28px" width=210><input id=optionascore style="width: 190px" class="easyui-validatebox" name=optionascore required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>选项B：</td>
					<td style="height: 28px" width=210><input id=optionb
						style="width: 190px" name=optionb class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px">选项B分数：</td>
					<td style="height: 28px" width=210><input id=optionbscore style="width: 190px" class="easyui-validatebox" name=optionbscore required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>选项C：</td>
					<td style="height: 28px" width=210><input id=optionc
						style="width: 190px" name=optionc class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px">选项C分数：</td>
					<td style="height: 28px" width=210><input id=optioncscore style="width: 190px" name=optioncscore class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>选项D：</td>
					<td style="height: 28px" width=210><input id=optiond
						style="width: 190px" name=optiond class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px">选项D分数：</td>
					<td style="height: 28px" width=210><input id=optiondscore style="width: 190px" name=optiondscore class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>选项E：</td>
					<td style="height: 28px" width=210><input id=optione
						style="width: 190px" name=optione ></td>
				</tr>
				<tr>
					<td style="height: 28px">选项E分数：</td>
					<td style="height: 28px" width=210><input id=optionescore style="width: 190px" name=optionescore></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>选项F：</td>
					<td style="height: 28px" width=210><input id=optionf
						style="width: 190px" name=optionf></td>
				</tr>
				<tr>
					<td style="height: 28px">选项F分数：</td>
					<td style="height: 28px" width=210><input id=optionfscore style="width: 190px" name=optionfscore></td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>是否添加建议项：</td>
					<td style="height: 28px">
						<select id="issuggest" name="issuggest" style="width:195px;" >
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="saveQuestion()">保存</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancel();">取消</a>
	</div>
	
	<div id="dlgForUpload" class="easyui-dialog"
		style="width: 410px; height: 200px; padding: 10px 20px" closed="true" buttons="#dlg-buttonsdlgForUpload">
		<form method="post" enctype="multipart/form-data" id="uploadExcel" style="margin-top:20px">
			 导入数据之前，请先<a href="${pageContext.request.contextPath}/templet/templetDetail.xls">下载模板</a>
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