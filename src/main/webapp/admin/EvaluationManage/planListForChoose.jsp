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
</script>
<style type="text/css">
	body{
		padding:0px;
	}
</style>
</head>
<body>
<table id="dgForPlan" title="未开始计划" class="easyui-datagrid" 
		toolbar="#toolbarForPlan"
		rownumbers="true" striped="true" pagination="true" fitColumns="true">
		<thead>
			<tr>
				<th field="plantitle" width="100">计划名</th>
				<th field="begintime" width="100">开始时间</th>
				<th field="endtime" width="100">结束时间</th>
				<th field="isstart" width="60">是否开始</th>
				<th field="isfinish" width="60">是否完成</th>
				<th field="createtime" width="100">创建时间</th>
				<th field="id" width="60">操作</th>
			</tr>
		</thead>
			<tbody>
				<c:forEach items="${plans}" var="plan" >
					<tr>
						<td>${plan.plantitle }</td>
						<td><fmt:formatDate value="${plan.begintime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td><fmt:formatDate value="${plan.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<c:choose>
								<c:when test="${plan.isstart}">
									进行中
								</c:when>
								<c:otherwise>
									未开始
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${plan.isfinish}">
									已经结束
								</c:when>
								<c:otherwise>
									未结束
								</c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatDate value="${plan.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<a href="javaScript:void(0)" onClick="makeSurePlan('${plan.id }')">选择计划</a>&nbsp;&nbsp;
						</td>
					</tr>
				</c:forEach>
			</tbody>
	</table>
	<div id="toolbarForPlan">
		<div style="float:right;">
			<input type="text" id="key" name="key" value="请输入计划名称" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" 
			onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch()">搜索</a>
		</div>
	</div>
	
</body>
</html>