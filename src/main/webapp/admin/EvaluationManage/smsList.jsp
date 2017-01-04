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
	function doSearch() {
		if (value == "请输入测评人") {
			value = "";
		}
		$('#dg').datagrid('load', {
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
			url : '${pageContext.request.contextPath}/smsList',

			columns : [ [ {
				field : 'ck',
				checkbox : true,
				width : '30'
			}, {
				title : '测评计划',
				field : 'plantitle',
				width : 80,
			}, {
				title : '测评人',
				field : 'testPerson',
				width : 100,
			}, {
				title : '被测评对象',
				field : 'testObject',
				width : 140,
			}, {
				title : '是否已发送',
				field : 'isuse',
				width : 90,
				formatter : function(value, row, index) {
					if (value) {
						return '已发送';
					} else {
						return '未发送';
					}
				}
			}, {
				title : '短信发送时间',
				field : 'createtime',
				width : 90,
			}] ],
			fitColumns : true,
			pagination : true,
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
			}
		});
	});
	function sendMessage(){
		var row = $('#dg').datagrid('getSelections');
		if (row.length>0) {
				var id = "";
				for (var i = 0; i < row.length; i++) {
					id = id +","+ row[i].id;
				}
				$.ajax({
					url : '${pageContext.request.contextPath}/sendMessage',
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
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sendMessage()">发送短信</a>
		<div style="float:right;">
			<input type="text" id="key" name="key" value="请输入测评人" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
</body>
</html>