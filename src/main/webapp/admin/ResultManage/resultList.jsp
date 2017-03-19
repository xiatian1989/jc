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
			singleSelect:false,
			rownumbers:false,
			selectOnCheck:true,
			pageSize:10,
	        pageList:[5,10,15],
			url:'${pageContext.request.contextPath}/admin/resultList',
			columns: [ [ {
				field : 'ck',
				checkbox : true,
				width : 30,
				align:'center',
			}, 	
			{
				title : '计划名',
				field : 'plantitle',
				width : 100,
				align:'center',
			},{
				title : '被测评对象',
				field : 'betestedobject',
				width : 60,
				align:'center',
			},{
				title : '测评人',
				field : 'testperson',
				width : 60,
				align:'center',
			}, {
				title : '答题比例',
				field : 'answerproportion',
				width : 60,
				align:'center',
				formatter : function(value, row, index) {
					return value+"%";
				}
				
			},{
				title : '创建时间',
				field : 'createtime',
				width : 100,
				align:'center',
			},{
				title : '状态',
				field : 'status',
				width : 30,
				align:'center',
				formatter : function(value, row, index) {
					if (value) {
						return '有效';
					} else {
						return '无效';
					}
				}
			},{
				title : '查看详情',
				field : 'id',
				width : 60,
				align:'center',
				formatter : function(value, row, index) {
					return '<a href="javaScript:void(0)" onClick="openPaperForTest('+"'"+value+"'"+')">测评详情</a>';
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

	function changeColumn(){
		var column = $("#column").val();
		$("#text1").hide();
		$("#text2").hide();
		if(column=='status') {
			$("#key").hide();
			$("#param").show();
			
		}else{
			$("#key").show();
			$("#param").hide();
			if(column=='answerproportion') {
				$("#text1").show();
				$("#text2").show();
			}
		}
	}
	
	function doSearch() {
		var column = $("#column").val();
		var value="";
		if(column=='status') {
			value= $("#param").val();
		}else{
			value= $("#key").val();
			if(value=="请输入查询值") {
				value ="";
			}
		}
		$('#dg').datagrid('load', {
			column : column,
			value : value,
		});
	}
	
	function openPaperForTest(resultId){
		$('#winForTestPaper').window('open');
		$('#winForTestPaper').window('refresh', '${pageContext.request.contextPath}/admin/paperTestDetail?resultId='+resultId);
		
		var t=setTimeout(function(){
			var resultMessage = $("#resultMessage").val();
			var extraMeassge = $("#extraMeassge").val();
			if(resultMessage) {
				var resultMessageArr = resultMessage.split("#");
				for(var i= 0;i<resultMessageArr.length;i++){
					var questionno = resultMessageArr[i].split(":")[0];
					var value = resultMessageArr[i].split(":")[1];
					$("input[name='"+questionno+"'][value="+value+"]").attr("checked",true); 
				}
				var extraMeassgeArr = extraMeassge.split("#");
				for(var i= 0;i<extraMeassgeArr.length;i++){
					var questionno = extraMeassgeArr[i].split(":")[0];
					var suggest = extraMeassgeArr[i].split(":")[1];
					$("#"+questionno).val(suggest);
				}
				clearTimeout(t);
			}
		},500)
		
		
	}
	
	function ensabledResultByids() {

		var row = $('#dg').datagrid('getSelections');
		if (row.length>0) {
			$.messager.confirm(
				'Confirm',
				'你确定将选中的结果设置为有效吗?',
				function(r) {
					if (r) {
						var id = "";
						for (var i = 0; i < row.length; i++) {
							id = id +  ",'"+row[i].id +"'";
						}
						$.ajax({
							url : '${pageContext.request.contextPath}/admin/ensabledResultByids',
							type : 'post',
							data : 'ids=' + id,
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
			$.messager.alert("提示", "请选择要处理的数据！", "info");
		}
	}
	
	function disabledResultByids() {

		var row = $('#dg').datagrid('getSelections');
		if (row.length>0) {
			$.messager.confirm(
				'Confirm',
				'你确定将选中的结果设置为有效吗?',
				function(r) {
					if (r) {
						var id = "";
						for (var i = 0; i < row.length; i++) {
							id = id +  ",'"+row[i].id +"'";
						}
						$.ajax({
							url : '${pageContext.request.contextPath}/admin/disabledResultByids',
							type : 'post',
							data : 'ids=' + id,
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
			$.messager.alert("提示", "请选择要处理的数据！", "info");
		}
	}
	
</script>
<style type="text/css">
	#win,body{
		padding:0px;
	}
</style>
</head>
<body>
	<table id="dg" title="结果列表">
		
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="ensabledResultByids()">设置为有效</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="disabledResultByids()">设置为无效</a>
		<div style="float:right;">
			<select id="column" name="column" onchange="changeColumn()">
				<option value="plan_id">计划标题</option>
				<option value="testPerson">测评人</option>
				<option value="betestedobject">被测评对象</option>
				<option value="answerproportion">答题比例</option>
				<option value="status">状态</option>
			</select>
			<span id="text1" style="display: none">答题比例低于</span><input type="text" id="key" name="key" value="请输入查询值" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"><span id="text2" style="display: none">%</span>
			<select id="param" name="param" style="display: none">
				<option value=1>有效</option>
				<option value=0>无效</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
	<div id="winForTestPaper" class="easyui-window" title="试卷测评详情" style="width:1000px;height:460px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true,cache: false">
	</div>
</body>
</html>