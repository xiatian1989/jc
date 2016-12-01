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
			url:'${pageContext.request.contextPath}/planList',
			columns: [ [ 
			{
				title : '用户名',
				field : 'plantitle',
				width : 100,
			},{
				title : '开始时间',
				field : 'begintime',
				width : 100,
			},{
				title : '结束时间',
				field : 'endtime',
				width : 100,
			}, {
				title : '是否完成',
				field : 'isfinish',
				width : 100,
				formatter: function(value,row,index){
					if(value) {
						return '完成';
					}else{
						return '未完成';
					}
				}
			},{
				title : '创建时间',
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
	
	function doSearch() {
		param = $("#key").val();
		if (param == "请输入计划名称") {
			param ="";
		}
		  $('#dg').datagrid('load',{  
			  param: param, 
	       });  
	}
	
	function newPlan() {
		$('#dlg').dialog('open').dialog('setTitle', '添加计划');
		$('#fm').form('clear');
		url = "${pageContext.request.contextPath}/addPlan"
		model="add";
	}

	function editPlan() {
		var selRow = $('#dg').datagrid('getSelected');
		var isfinish = selRow.isfinish;
		if(isfinish) {
			$.messager.alert('错误',"测评计划已经结束,不能进行编辑",'error');
			return;
		}
		var beginTime = selRow.begintime;
		if(getNowFormatDate()>=beginTime){
			$.messager.alert('错误',"测评计划已经开始,不能进行编辑",'error');
			return;
		} 
		if (selRow) { 
			$('#dlg').dialog('open').dialog('setTitle', '编辑计划');
			$('#fm').form('clear');
			$('#fm').form('load', selRow);
			url = "${pageContext.request.contextPath}/updatePlan"
			model="update";
		}

	}
	
	function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
	            + " " + date.getHours() + seperator2 + date.getMinutes()
	            + seperator2 + date.getSeconds();
	    return currentdate;
	}

	function savePlan() {

		$('#fm').form('submit',{
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if(!flag) {
					return flag;
				}
				var beginTime = $('#begintime').datetimebox('getValue');
				var endTime = $('#endtime').datetimebox('getValue');
				if(getNowFormatDate()>beginTime) {
					$.messager.alert('错误',"测评开始时间不能早于当前时间",'error');
					return false;
				}
				if(beginTime>=endTime) {
					$.messager.alert('错误',"测评结束时间不能早于测评开始时间",'error');
					return false;
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

	function destroyPlan() {
		
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

	function cancel() {
		$('#fm').form('clear');
		$('#dlg').dialog('close');
	}
	
	function checkUniqName(){
		var plantitle = $("#plantitle").val();
		$.ajax({   
		    url:'${pageContext.request.contextPath}/checkPlantitle',   
		    type:'post',   
		    data:'plantitle='+plantitle,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="failed") {
		    		$.messager.alert('警告','计划名称已经存在!','warning',function(){
		    			$("#plantitle").focus().select();
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
	<table id="dg" title="计划列表">
		
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newPlan()">添加计划</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editPlan()">编辑计划</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyPlan()">删除计划</a>
		<div style="float:right;">
			<input type="text" id="key" name="key" value="请输入计划名称" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog"
		style="width: 280px; height: 200px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=80>计划名称：</td>
					<td style="height: 28px" width=150>
						<input id=plantitle
							style="width: 130px" name=plantitle class="easyui-validatebox" required="true" onChange="checkUniqName()">
					</td>
				</tr>
				<tr>
					<td style="height: 28px">开始时间：</td>
					<td style="height: 28px"><input id=begintime style="width: 135px"
						class="easyui-datetimebox" data-options="required:true,showSeconds:false" name=begintime></td>
				</tr>
				<tr>
					<td style="height: 28px">结束时间：</td>
					<td style="height: 28px"><input id=endtime style="width: 135px"
						class="easyui-datetimebox" data-options="required:true,showSeconds:false" name=endtime></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="savePlan()">保存</a>
		<a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancel();">取消</a>
	</div>
</body>
</html>