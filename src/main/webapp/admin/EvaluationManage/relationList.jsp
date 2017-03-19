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
			url:'${pageContext.request.contextPath}/admin/relationList',
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
				title : '被测评是否是人',
				field : 'isperson',
				width : 60,
				align:'center',
				formatter : function(value, row, index) {
					if (value) {
						return '是';
					} else {
						return '否';
					}
				}
				
			},{
				title : '是否完成',
				field : 'isfinish',
				width : 60,
				align:'center',
				formatter : function(value, row, index) {
					if (value) {
						return '是';
					} else {
						return '否';
					}
				}
			},{
				title : '是否支持短信考试',
				field : 'issupportsms',
				width : 80,
				align:'center',
				formatter : function(value, row, index) {
					if (value) {
						return '是';
					} else {
						return '否';
					}
				}
			
			},{
				title : '创建时间',
				field : 'createtime',
				width : 100,
			},{
				title : '状态',
				field : 'status',
				width : 30,
				formatter : function(value, row, index) {
					if (value) {
						return '启用';
					} else {
						return '作废';
					}
				}
			},{
				title : '规则',
				field : 'ruleId',
				width : 60,
				align:'center',
				formatter : function(value, row, index) {
					return '<a href="javaScript:void(0)" onClick="openRule('+"'"+value+"'"+')">查看规则</a>';
				}
			}
			,{
				title : '试卷',
				field : 'paperId',
				width : 60,
				align:'center',
				formatter : function(value, row, index) {
					return '<a href="javaScript:void(0)" onClick="openPaperForRelation('+"'"+value+"'"+')">预览试卷</a>';
				}
			}] ],
			fitColumns:true,
			pagination:true,
			toolbar: '#toolbar',
			onLoadSuccess:function(){  
	          $('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
	       } 
		});
		$('#win').window({
			onLoad:function(){
				fillDepart();
		    }
		});
	});
	
	function newRelation() {
		$('#win').window('open');
		$('#win').window('refresh', '${pageContext.request.contextPath}/admin/EvaluationManage/relationListConnect.jsp');
	}


	function destroyRelation() {
		
		var row = $('#dg').datagrid('getSelections');
		if (row.length>0) {
			$.messager.confirm(
				'Confirm','你确定取消选中的测评关系吗?',
					function(r) {
					if (r) {
						var id = "";
						for (var i = 0; i < row.length; i++) {
							id = id+","+"'"+ row[i].id+"'";
						}
						$.ajax({
								url : '${pageContext.request.contextPath}/admin/deleteRelation',
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
			value= $("#param").val();
		}else if(column=='status'){
			value= $("#param1").val();
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

	function cancel() {
		$('#fm').form('clear');
	}
	
	function fillDepart(){
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/getDeparts',
			type : 'post',
			async : false, //默认为true 异步   
			success : function(objs) {
				$("#departNoLeft").empty();
				$("#departNoLeft").append("<option value=''></option>");
				for(var i =0;i<objs.length;i++) {
					$("#departNoLeft").append("<option value='"+objs[i].departNo+"'>"+objs[i].departName+"</option>");
				}
				$("#departNoRight").empty();
				$("#departNoRight").append("<option value=''></option>");
				for(var i =0;i<objs.length;i++) {
					$("#departNoRight").append("<option value='"+objs[i].departNo+"'>"+objs[i].departName+"</option>");
				}
			}
		});
	}
	function changeDepartLeft(){
		 $("#ttLeft").tree("options").url="${pageContext.request.contextPath}/admin/departListForUser?id="+$("#departNoLeft").val();
		$('#ttLeft').tree('reload');
		 $("#ttLeft").tree("options").url="${pageContext.request.contextPath}/admin/departListForUser";
	}
	function changeDepartRight(){
		var type = $("#beTestedType").val()
		if(type==0){
			$("#ttRight").tree("options").url="${pageContext.request.contextPath}/admin/departListForUser?id="+$("#departNoRight").val();
		}else{
			$("#ttRight").tree("options").url="${pageContext.request.contextPath}/admin/departList?id="+$("#departNoRight").val();
		}
		$('#ttRight').tree('reload');
		if(type==0){
			$("#ttRight").tree("options").url="${pageContext.request.contextPath}/admin/departListForUser";
		}else{
			$("#ttRight").tree("options").url="${pageContext.request.contextPath}/admin/departList";
		}
	}
	function choosePaper(){
		$('#winForpaper').window('open');
		$('#winForpaper').window('refresh', '${pageContext.request.contextPath}/admin/paperListForPaper');
	}
	function choosePlan(){
		$('#winForPlan').window('open');
		$('#winForPlan').window('refresh', '${pageContext.request.contextPath}/admin/planListForNoStart');
	}
	function makeSurePlan(planId){
		$("#planId").val(planId);
		$('#winForPlan').window('close');
	}
	function changeColumnForpaper() {
		var column = $("#columnForpaper").val();
		if (column == 'type') {
			$("#paramForpaper").show();
			$("#keyForpaper").hide();
		} else {
			$("#keyForpaper").show();
			$("#paramForpaper").hide();
		}
	}
	function doSearchForpaper() {
		var column = $("#columnForpaper").val();
		var value =  $("#keyForpaper").val();
		if(column == "type") {
			value = $("#paramForpaper").val();
		}

		if (value == "请输入查询值") {
			value = "";
		}
		$('#winForpaper').window('refresh', '${pageContext.request.contextPath}/admin/paperListForPaper?column='+column+'&value='+value);
	}
	
	function openPaper(paperId){
		$('#winForPapeForPreview').window('open');
		$('#winForPapeForPreview').window('refresh', '${pageContext.request.contextPath}/admin/paperPreview?paperId='+paperId);
	}
	
	function makesurePaper(paperId,type) {
		debugger;
		if(type=="true"){
			$("#addRelationRule").show();
			$("#type").val("1");
		}else{
			$("#addRelationRule").hide();
			$("#type").val("0")
		}
		$('#winForpaper').window('close');
		$("#paperId").val(paperId);
		
	}
	
	function addRelationRule() {

		$('#dlgForRule').dialog('open').dialog('setTitle', '添加测评规则');
		$('#fmForRule').form('clear');
		url = "${pageContext.request.contextPath}/admin/addRule"
	}
	
	function saveRule(){
		$('#fmForRule').form('submit', {
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if (!flag) {
					return flag;
				}
				var first = $('#first').numberspinner('getValue');
				var second = $('#second').numberspinner('getValue');
				var third = $('#third').numberspinner('getValue');
				var forth = $('#forth').numberspinner('getValue');
				var fifth = $('#fifth').numberspinner('getValue');
				if(second>first) {
					$.messager.alert('提示','第二档次的范围的值不能大于第一档次！','info');
					return false;
				}
				if(third>second) {
					$.messager.alert('提示','第三档次的范围的值不能大于第二档次！','info');
					return false;
				}
				if(forth>third) {
					$.messager.alert('提示','第四档次的范围的值不能大于第三档次！','info');
					return false;
				}
				if(fifth>forth) {
					$.messager.alert('提示','第五档次的范围的值不能大于第四档次！','info');
					return false;
				}
			},
			success : function(result) {
				var obj = jQuery.parseJSON(result);
				if (obj.result == "success") {
					$('#dlgForRule').dialog('close');
					$("#ruleId").val(obj.id);
				} else {
					$.messager.alert('错误', obj.errorMsg, 'error');
				}
			}
		});
	}
	function cancelForRule(){
		$('#fmForRule').form('clear');
		$('#dlgForRule').dialog('close');
	}
	
	function changeFirst(value){
		$('#firstCopy').numberbox('setValue',value);
	}
	function changeSecond(value){
		$('#secondCopy').numberbox('setValue',value);
	}
	function changeThird(value){
		$('#thirdCopy').numberbox('setValue',value);
	}
	function changeForth(value){
		$('#forthCopy').numberbox('setValue',value);
	}
	
	function createRelation(){
		debugger;
		var ruleId = $("#ruleId").val(); 
		var planId = $("#planId").val();
		var paperId = $("#paperId").val();
		var type = $("#type").val();
		if(planId==""){
			$.messager.alert('错误', "请先选择测评计划", 'error');
			return;
		}
		if(paperId==""){
			$.messager.alert('错误', "请先添加测评试卷", 'error');
			return;
		}
		if(type == "1" && ruleId==""){
			$.messager.alert('错误', "请先添加测评规则", 'error');
			return;
		}
		var leftNodes = $('#ttLeft').tree('getChecked');
		var testPeople = ""
		var beTestObject=""
		var isPerson =  $("#beTestedType").val();
		
		for(var i = 0;i<leftNodes.length;i++){
			if(leftNodes[i].attributes=='1') {
				testPeople = testPeople+leftNodes[i].id;
				testPeople = testPeople+",";
			}
		}
		if(testPeople==""){
			$.messager.alert('错误', "请先勾选左侧树的人员", 'error');
			return;
		}
		var rightNodes = $('#ttRight').tree('getChecked');
		for(var i = 0;i<rightNodes.length;i++){
			if(isPerson == '0'){
				if(rightNodes[i].attributes=='1') {
					beTestObject = beTestObject+rightNodes[i].id;
					beTestObject = beTestObject+",";
				}
			}else{
				if(rightNodes[i].attributes=='0') {
					beTestObject = beTestObject+rightNodes[i].id;
					beTestObject = beTestObject+",";
				}
			}
		}
		if(beTestObject==""){
			$.messager.alert('错误', "请先勾选右侧树的人员或者部门", 'error');
			return;
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/addRelations',
			type : 'post',
			data : 'paperId='+ paperId+"&ruleId="+ruleId+"&testPeople="+testPeople+"&beTestObject="+beTestObject+"&isPerson="+isPerson+"&planId="+planId,
			async : false, //默认为true 异步   
			success : function(msg) {
				if (msg.result == "success") {
					$('#win').window('close');
					$('#dg').datagrid('reload');
				} else {
					$.messager.alert('错误',msg.errorMsg,'error');
				}
			}
		});
	}
	function openPaperForRelation(paperId){
		$('#winForRelationPaper').window('open');
		$('#winForRelationPaper').window('refresh', '${pageContext.request.contextPath}/admin/paperPreview?paperId='+paperId);
	}
	
	function openRule(ruleId){
		$('#winForRule').window('open');
		$('#winForRule').window('refresh', '${pageContext.request.contextPath}/admin/rulePreview?ruleId='+ruleId);
	}
</script>
<style type="text/css">
	#win,body{
		padding:0px;
	}
	a {
		cursor: pointer;
		text-decoration: none;
		hide-focus: expression(this.hideFocus = true);
		outline: none;
	}
	
	a:link, a:visited, a:hover, a:active {
		text-decoration: none;
	}
	
	a:focus {
		outline: 0;
	}
</style>
</head>
<body>
	<table id="dg" title="关系列表">
		
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
	<div id="win" class="easyui-window" title="添加测评关系" style="width:1005px;height:520px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true,cache: false">
	</div>
	<div id="winForRelationPaper" class="easyui-window" title="预览测评试卷" style="width:1000px;height:460px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true,cache: false">
	</div>
	<div id="winForRule" class="easyui-window" title="查看规则" style="width:400px;height:180px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true,cache: false">
	</div>
</body>
</html>