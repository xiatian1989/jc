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

	<table id="dg1" title="可用试卷" class="easyui-datagrid" 
		toolbar="#toolbarForPaper"
		rownumbers="true" striped="true" pagination="true" fitColumns="true">
		<thead>
			<tr>
				<th field="papertitle" width="60">试卷标题</th>
				<th field="createtime" width="100">创建时间</th>
				<th field="type" width="40">类型</th>
				<th field="id" width="90">操作</th>
			</tr>
		</thead>
			<tbody>
				<c:forEach items="${papers}" var="paper" >
					<tr>
						<td>${paper.papertitle }</td>
						<td><fmt:formatDate value="${paper.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<c:choose>
								<c:when test="${paper.type }">
									人事考核
								</c:when>
								<c:otherwise>
									问卷
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<a href="javaScript:void(0)" onClick="openPaper('${paper.id }')">预览试卷</a>&nbsp;&nbsp;
							<a href="javaScript:void(0)" onClick="makesurePaper('${paper.id }','${paper.type }')">确认选择</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
	</table>
	<div id="toolbarForPaper">
		<div style="float:right;">
			<select id="columnForPaper" onchange="changeColumnForPaper()">
				<option value="paperTitle">试卷标题</option>
				<option value="type">类型</option>
			</select>
			<input type="text" id="keyForPaper" value="请输入查询值" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<select id="paramForPaper" style="display: none">
				<option value=1>人事考核</option>
				<option value=0>问卷</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearchForPaper()">搜索</a>
		</div>
	</div>

	<div id="winForPapeForPreview" class="easyui-window" title="试卷预览" style="width:980px;height:460px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true">
	</div>
</body>
</html>