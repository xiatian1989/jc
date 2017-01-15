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

	$(function() {
		$("#planId").val(getQueryString("planId"));
		
		$('#dg').datagrid({
			nowrap : false,
			idField : 'id',
			striped : true,
			fit : false,
			singleSelect : true,
			rownumbers : false,
			selectOnCheck : false,
			pageSize : 10,
			pageList : [ 5, 10, 15 ],
			url : '${pageContext.request.contextPath}/admin/resultListForExport?planId='+$("#planId").val(),

			columns : [ [ {
				title : '测评计划名称',
				field : 'plantitle',
				width : 80,
			},{
				title : '测评试卷名称',
				field : 'papertitle',
				width : 80,
			}, {
				title : '被测评对象',
				field : 'betestedobject',
				width : 60,
			}, {
				title : '平均得分',
				field : 'score',
				width : 60,
			}, {
				title : '综合评价',
				field : 'result',
				width : 60,
			} ] ],
			fitColumns : true,
			pagination : true,
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
			}
		});
		
	});

	function exportResult() {
		var url = "${pageContext.request.contextPath}/admin/exportExcelForResult?planId="+$("#planId").val();
		window.open(url);
	}
	function getQueryString(name) { 
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
		var r = window.location.search.substr(1).match(reg); 
		if (r != null){
			return unescape(r[2]); 
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
<input type="text" id="planId" style="display: none">
<table id="dg" title="结果列表">
		
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="exportResult()">导出结果</a>
	</div>
</body>
</html>