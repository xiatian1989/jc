<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
	<title>学费管理系统</title>
	<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/demo/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
	<style>
	html, body {
		margin: 0;
		padding: 0
	}
	.panel{
		font-size: 14px!important;
	}
</style>
</head>
<body>
	<div id="p" class="easyui-panel" title="查询结果">
		<div class="easyui-tabs">
			<c:forEach items="${map}" var="map">
				<div title="${map.key}">
					<c:forEach items="${map.value}" var="mapForDetail">
						<c:choose>
							<c:when test="${mapForDetail.key=='plan'}">
								<p>
									开始时间:
									<fmt:formatDate value="${mapForDetail.value.begintime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									 &nbsp;&nbsp;&nbsp;&nbsp;
									 结束时间：
									 <fmt:formatDate value="${mapForDetail.value.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									 &nbsp;&nbsp;&nbsp;&nbsp;
									 计划状态：
									 <c:choose>
									 	<c:when test="${mapForDetail.value.isfinish}">
									 		完成
									 	</c:when>
									 	<c:otherwise>
									 		 <c:choose>
											 	<c:when test="${mapForDetail.value.isstart}">
											 		未完成
											 	</c:when>
											 	<c:otherwise>
											 		未开始
											 	</c:otherwise>
											 </c:choose>
									 	</c:otherwise>
									 </c:choose>
								 </p>
							</c:when>
							<c:otherwise>
								<p>${mapForDetail.value}</p>
							</c:otherwise>	
						</c:choose>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>