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
			url:'${pageContext.request.contextPath}/relationList',
			columns: [ [ 
			{
				title : '计划名',
				field : 'plantitle',
				width : 100,
			},{
				title : '测评人',
				field : 'testperson',
				width : 60,
			},{
				title : '被测评对象',
				field : 'betestedobject',
				width : 60,
			}, {
				title : '被测评是否是人',
				field : 'isperson',
				width : 100,
				
			},{
				title : '是否完成',
				field : 'isfinish',
				width : 100,
			},{
				title : '是否支持短信考试',
				field : 'issupportsms',
				width : 100,
			},{
				title : '创建时间',
				field : 'createtime',
				width : 100,
			},{
				title : '状态',
				field : 'status',
				width : 100,
			},{
				title : '操作',
				field : 'createtime',
				width : 100,
			}] ],
			fitColumns:true,
			pagination:true,
			toolbar: '#toolbar',
			onLoadSuccess:function(){  
	          $('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
	       } 
		});
	});
	
	function newRelation() {
	}


	function destroyRelation() {
		
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			var isfinish = row.isfinish;
			if(isfinish) {
				$.messager.alert('错误',"测评计划已经结束,不能删除",'error');
				return;
			}
			var beginTime = row.begintime;
			if(getNowFormatDate()>=beginTime){
				$.messager.alert('错误',"测评计划已经开始,不能删除",'error');
				return;
			} 
			$.messager.confirm(
				'Confirm','你确定删除选择的计划吗?',
					function(r) {
					if (r) {
						var id =row.id;
						$.ajax({
								url : '${pageContext.request.contextPath}/deletePlan',
								type : 'post',
								data : 'id='+ id,
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
	function changeColumn(){
		var column = $("#column").val();
		if(column=='isPerson' || column=='isFinish' || column=='isSupportSMS') {
			$("#key").hide();
			$("#param1").hide();
			$("#param").show();
			
		}else if(column=='status'){
			$("#key").hide();
			$("#param1").show();
			$("#param").hide();
		}else{
			$("#key").show();
			$("#param1").hide();
			$("#param").hide();
		}
		
	}
	
	function doSearch() {
		var column = $("#column").val();
		var value="";
		if(column=='isPerson' || column=='isFinish' || column=='isSupportSMS') {
			value= $("#param").value();
		}else if(column=='status'){
			value= $("#param1").value();
		}else{
			value= $("#key").value();
			if(value="请输入查询值") {
				value ="";
			}
		}
		  $('#dg').datagrid('load',{  
			  param: param,
			  value:value,
	       });  
	}

	function cancel() {
		$('#fm').form('clear');
	}
	
</script>
<style type="text/css">
	body{
		padding:0px;
	}
</style>
</head>
<body>
	<table id="dg" title="计划列表">
		
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newRelation()">添加测评关系</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyRelation()">取消测评关系</a>
		<div style="float:right;">
			<select id="column" name="column" onchange="changeColumn()">
				<option value="plan_id">计划标题</option>
				<option value="testPerson">测评人</option>
				<option value="betestedobject">被测评对象</option>
				<option value="isPerson">被测评是否是人</option>
				<option value="isFinish">是否完成</option>
				<option value="isSupportSMS">是否支持短信</option>
				<option value="status">状态</option>
			</select>
			<input type="text" id="key" name="key" value="请输入查询值" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<select id="param" name="param" style="display: none">
				<option value=1>是</option>
				<option value=0>否</option>
			</select>
			<select id="param1" name="param1" style="display: none">
				<option value=1>有效</option>
				<option value=0>作废</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
</body>
</html>