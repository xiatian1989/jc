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
			url:'${pageContext.request.contextPath}/admin/planListForMakeSure',
			columns: [ [ 
			{
				title : '计划名',
				field : 'plantitle',
				width : 100,
				align:'center',
			},{
				title : '开始时间',
				field : 'begintime',
				width : 100,
				align:'center',
			},{
				title : '结束时间',
				field : 'endtime',
				width : 100,
				align:'center',
			}, {
				title : '是否完成',
				field : 'isfinish',
				width : 100,
				align:'center',
				formatter: function(value,row,index){
					if(value) {
						return '完成';
					}else{
						return '未完成';
					}
				}
			}, {
				title : '是否发布',
				field : 'issure',
				width : 100,
				align:'center',
				formatter: function(value,row,index){
					if(value) {
						return '已发布';
					}else{
						return '未发布';
					}
				}
			},{
				title : '创建时间',
				field : 'createtime',
				width : 100,
				align:'center',
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

	/* function makeSurePlan() {
		
		var row = $('#dg').datagrid('getSelected');
		
		if (row) {
			var issure = row.issure;
			if(issure) {
				$.messager.alert('错误',"测评计划的测评结果已经发布！",'error');
				return;
			}
			$.messager.confirm(
				'Confirm','你确定发布该测评计划的测评结果吗?',
					function(r) {
					if (r) {
						var id =row.id;
						$.ajax({
								url : '${pageContext.request.contextPath}/admin/makeSurePlan',
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
	} */
	
	function editPlan() {
		var selRow = $('#dg').datagrid('getSelected');
		if (selRow) { 
			$('#dlg').dialog('open').dialog('setTitle', '发布测评结果');
			$('#fm').form('clear');
			$('#fm').form('load', selRow);
			url = "${pageContext.request.contextPath}/admin/makeSurePlan"
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
				var endviewtime = $('#endviewtime').datetimebox('getValue');
				if(getNowFormatDate()>endviewtime) {
					$.messager.alert('错误',"查询结果结束时间不能早于当前时间",'error');
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
	
	function cancel() {
		$('#fm').form('clear');
		$('#dlg').dialog('close');
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
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="editPlan()">发布测评结果</a>
		<div style="float:right;">
			<input type="text" id="key" name="key" value="请输入计划名称" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog"
		style="width: 380px; height: 140px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px">用户查询结果截止时间：</td>
					<td style="height: 28px"><input id=endviewtime style="width: 180px"
						class="easyui-datetimebox" data-options="required:true,showSeconds:false" name=endviewtime></td>
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