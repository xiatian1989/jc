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
				title : '计划名',
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
			},{
				title : '创建时间',
				field : 'id',
				width : 100,
				formatter: function(value,row,index){
					return '<a href="javaScript:void(0)" onClick="openSMS('+"'"+value+"'"+')">启用短信</a>&nbsp;&nbsp;<a href="javaScript:void(0)" onClick="disabledSMS('+"'"+value+"'"+')">禁用短信</a>';
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
	
	function openSMS(id){
		$.ajax({   
		    url:'${pageContext.request.contextPath}/openSMSRelationByid',   
		    type:'post',   
		    data:'id='+id,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="success") {
		    		$.messager.alert('提示','短信启用成功!','info')
		    	}else{
		    		$.messager.alert('错误','短信启用失败，请刷新以后重试!','error');
		    	}
		    }
		});
	}
	
	function disabledSMS(id){
		$.ajax({   
		    url:'${pageContext.request.contextPath}/disabledSMSRelationByid',   
		    type:'post',   
		    data:'id='+id,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="success") {
		    		$.messager.alert('提示','短信取消成功!','info')
		    	}else{
		    		$.messager.alert('错误','短信取消失败，请刷新以后重试!','error');
		    	}
		    }
		});
	}
	
	function doSearch() {
		param = $("#key").val();
		if (param == "请输入计划名称") {
			param ="";
		}
		  $('#dg').datagrid('load',{  
			  param: param, 
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
		<div style="float:right;">
			<input type="text" id="key" name="key" value="请输入计划名称" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
	
</body>
</html>