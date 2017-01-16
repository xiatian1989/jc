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
			url:'${pageContext.request.contextPath}/admin/subDepartList',
			columns: [ [ 
			{
				title : '部门编号',
				field : 'departNo',
				width : 100,
			}, {
				title : '部门名称',
				field : 'departName',
				width : 100,
			}, {
				title : '叶子节点',
				field : 'isleaf',
				width : 100,
				formatter: function(value,row,index){
					if(value) {
						return '是';
					}else{
						return '否';
					}
				}
			}, {
				title : '状态',
				field : 'status',
				width : 100,
				formatter: function(value,row,index){
					if(!value) {
						return '禁用';
					}else{
						return '启用';
					}
				}
			}] ],
			fitColumns:true,
			pagination:true,
			toolbar: '#toolbar',
			onLoadSuccess:function(){  
	          $('#dg').datagrid('clearSelections'); //一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题  
	       } 
		});
		
		$('#tt').tree({
			animate:true,
			onClick: function(node){
				$.ajax({   
				    url:'${pageContext.request.contextPath}/admin/getDepartDetail',   
				    type:'post',   
				    data:'departNo='+node.id,   
				    async : false, //默认为true 异步   
				    success:function(msg){
				    	$("#departNo").val(msg.departNo);
				    	$("#departName").val(msg.departName);
				    	$("#isLeaf").val(msg.isleaf);
				    	$("#status").val(msg.status);
				    	$("#nodepath").val(msg.nodePath);
				    }
				});
			  	$('#dg').datagrid('load',{  
				  param: node.id, 
		       });
			},
			onExpand: function(node,data){
				if(node ==null){
					return;
				}
				var departNo = $("#departNo").val();
				var fatherDepart = $('#tt').tree("getParent",($('#tt').tree('find',departNo)).target);
				if(fatherDepart.id == node.id) {
					var tempNode= $('#tt').tree("find",departNo);
					$('#tt').tree('expandAll',tempNode.target);
					$('#tt').tree('select',tempNode.target);
				}
			}
		});
	});
	
	function newDepart() {
		var node = $('#tt').tree('getSelected');
		if(node == null) {
			$.messager.alert('警告','请先在左侧树选择父节点!','warning');
			return;
		}
		$("#subDepartNo").removeAttr("readonly");
		$('#dlg').dialog('open').dialog('setTitle', '添加子部门');
		$('#fm').form('clear');
		var parentNo =$("#departNo").val();
		if(parentNo == ""){
			parentNo = "0"
		}
		$("#parentNo").val(parentNo);
		var nodepath = $("#nodepath").val();
		if(nodepath==""){
			nodepath ="0"
		}
		$("#subNodepath").val(nodepath);
		$("#subStatus").val("1")
		
		url = "${pageContext.request.contextPath}/admin/addDepart"
		model="add";
	}

	function editDepart() {
		
		var selRow = $('#dg').datagrid('getSelected');
		if (selRow) { 
			$('#dlg').dialog('open').dialog('setTitle', '编辑部门');
			$('#fm').form('clear');
			$('#fm').form('load', selRow);
			url = "${pageContext.request.contextPath}/admin/updateDepart"
			model="update";
			
			$("#subDepartNo").attr("readonly", "readonly")
			if(selRow.status){
				$("#subStatus").val("1")
			}else if(!selRow.status){
				$("#subStatus").val("0")
			}
		}
	}

	function saveDepart() {

		$('#fm').form('submit',{
			url : url,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				var msg = jQuery.parseJSON(result);
				if (msg.result == "success") {
					$('#dlg').dialog('close');
					var node = $('#tt').tree('getSelected');
					$('#dg').datagrid('load',{  
						  param: node.id, 
				    });
					if(node.id==0){
						$('#tt').tree('reload');
					}else{
						var parentNode = $('#tt').tree('getParent',node.target);
						$('#tt').tree('reload',parentNode.target);
						$('#tt').tree('expand',parentNode.target);
					}
				} else {
					$.messager.alert('错误',msg.errorMsg,'error');
				}
			}
		});
	}

	function destroyDepart() {
		
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager
					.confirm(
							'Confirm','你确定删除选择的部门以及该部门的下属部门吗?',
							function(r) {
								if (r) {
									var id =row.id;
									$.ajax({
											url : '${pageContext.request.contextPath}/admin/deleteDepart',
											type : 'post',
											data : 'id='
													+ id,
											async : false, //默认为true 异步   
											success : function(msg) {
												if (msg.result == "success") {
													var node = $('#tt').tree('getSelected');
													$('#dg').datagrid('load',{  
														  param: node.id, 
												    });
													if(node.id==0){
														$('#tt').tree('reload');
													}else{
														var parentNode = $('#tt').tree('getParent',node.target);
														$('#tt').tree('reload',parentNode.target);
														$('#tt').tree('expand',parentNode.target);
													}
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
	
	function checkUniqNo(){
		var departNo =  $("#subDepartNo").val();
		if(departNo =='0') {
			$.messager.alert('警告','部门编号不能为0!','warning');
			return;
		}
		$.ajax({   
		    url:'${pageContext.request.contextPath}/admin/checkDepartDepartNo',   
		    type:'post',   
		    data:'departNo='+departNo,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="failed") {
		    		$.messager.alert('警告','部门编号已经存在!','warning',function(){
		    			$("#subDepartNo").focus().select();
		    		});
		    	}
		    }
		});
	}
	
	function checkUniqName(){
		var departName = $("#subDepartName").val();
		$.ajax({   
		    url:'${pageContext.request.contextPath}/admin/checkDepartDepartName',   
		    type:'post',   
		    data:'departName='+departName,   
		    async : false, //默认为true 异步   
		    success:function(msg){
		    	if(msg.result=="failed") {
		    		$.messager.alert('警告','部门名已经存在!','warning',function(){
		    			$("#subDepartName").focus().select();
		    		});
		    	}
		    }
		});
	}
</script>
<style type="text/css">
	body{
		padding:10px;
	}
</style>
</head>
<body>
	<div id="cc" class="easyui-layout" style="height:520px;">
	    <div data-options="region:'west',title:'部门列表',split:true" style="width:150px;">
			<ul class="easyui-tree" data-options="url:'${pageContext.request.contextPath}/admin/departList'" id="tt" ></ul>
	    </div>
	    <div data-options="region:'center',title:'部门详情'" style="padding:5px;background:#eee;">
	    	<table id="dd" title="详细信息" style="width: 100%">
				<tr>
					<td>部门编号</td>
					<td><input type="text" id="departNo" readonly="readonly"></td>
					<td>部门名称</td>
					<td><input type="text" id="departName"  readonly="readonly"></td>
				</tr>
				<tr>
					<td>叶子节点</td>
					<td><input type="text" id="isLeaf"  readonly="readonly"></td>
					<td>状态</td>
					<td><input type="text" id="status"  readonly="readonly"></td>
				</tr>
			</table>
			<input type="text" id="nodepath" style="display:none">
	    	<table id="dg" title="子部门列表">
		
			</table>
			<div id="toolbar">
				<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newDepart()">添加子部门</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editDepart()">编辑部门 </a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyDepart()">删除部门</a>
			</div>
			
			<div id="dlg" class="easyui-dialog"
				style="width: 270px; height: 200px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
				
				<form id="fm" method="post">
					<input id=id name=id style="display:none">
					<input id=subNodepath name=nodePath style="display:none">
					<input id=parentNo name=parentNo style="display:none">
					<table>
						<tr>
							<td style="height: 28px" width=80>部门编号：</td>
							<td style="height: 28px" width=150>
								<input id=subDepartNo
									style="width: 130px" name=departNo class="easyui-validatebox" required="true" onchange="checkUniqNo()">
							</td>
						</tr>
						<tr>
							<td style="height: 28px">部门名称：</td>
							<td style="height: 28px"><input id=subDepartName style="width: 130px"
								name=departName class="easyui-validatebox" required="true" onchange="checkUniqName()"></td>
						</tr>
						<tr>
							<td style="height: 28px">状态：</td>
							<td style="height: 28px">
								<select id="subStatus" name="status" style="width: 137px">
									<option value="0">禁用</option>
									<option value="1">启用</option>
								</select>
							</td>
						</tr>
					</table>
				</form>
				
			</div>
			<div id="dlg-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
					onclick="saveDepart()">保存</a>
				<a href="#" class="easyui-linkbutton"
					iconCls="icon-cancel" onclick="cancel();">取消</a>
			</div>
		</div>
	</div>
</body>
</html>