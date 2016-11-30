<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

</script>
<style type="text/css">
	body{
		padding:0px;
	}
</style>
</head>
<body>

	<table id="dg1" title="可用模板列表" class="easyui-datagrid" 
		toolbar="#toolbar1"
		rownumbers="true" striped="true" pagination="true" fitColumns="true">
		<thead>
			<tr>
				<th field="templettitle" width="60">模板标题</th>
				<th field="keyword" width="90">关键字</th>
				<th field="description" width="140">描述</th>
				<th field="createtime" width="100">创建时间</th>
				<th field="updatetime" width="100">更新时间</th>
				<th field="type" width="40">类型</th>
				<th field="id" width="90">操作</th>
			</tr>
		</thead>
			<tbody>
				<c:forEach items="${templets}" var="templet" >
					<tr>
						<td>${templet.templettitle }</td>
						<td>${templet.keyword }</td>
						<td>${templet.description }</td>
						<td><fmt:formatDate value="${templet.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td><fmt:formatDate value="${templet.updatetime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<c:choose>
								<c:when test="${templet.type }">
									人事考核
								</c:when>
								<c:otherwise>
									问卷
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<a href="javaScript:void(0)" onClick="openView1('${templet.id }')">预览模板</a>&nbsp;&nbsp;
							<a href="javaScript:void(0)" onClick="copyTemplet('${templet.id }')">确认选择</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
	</table>
	<div id="toolbar1">
		<div style="float:right;">
			<select id="column1" onchange="changeColumn1()">
				<option value="templetTitle">模板标题</option>
				<option value="keyWord">关键字</option>
				<option value="description">描述信息</option>
				<option value="type">类型</option>
			</select>
			<input type="text" id="key1" value="请输入查询值" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<select id="param1" style="display: none">
				<option value=1>人事考核</option>
				<option value=0>问卷</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch1()">搜索</a>
		</div>
		
	</div>

	<div id="dlg1" class="easyui-dialog"
		style="width: 380px; height: 160px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		
		<form id="fm1" method="post">
			<input id=id1 name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=120>试卷标题：</td>
					<td style="height: 28px" width=210>
						<input id=papertitle1 style="width: 190px" name=papertitle class="easyui-validatebox" required="true" onchange="checkUniqName()">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="win1" class="easyui-window" title="模板预览" style="width:980px;height:460px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true">
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="savePaper1()">保存</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancel1();">取消</a>
	</div>
</body>
</html>