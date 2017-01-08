<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>人事测评管理系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/demo/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
<style type="text/css">
	ul, li {
		list-style: none;
	}
</style>
<script type="text/javascript">
	function setalign(align){
		$('a.easyui-menubutton').menubutton({
			menuAlign: align
		})
	}
	$(function(){
	    $('#logOut').bind('click', function(){
	    	window.location.href="${pageContext.request.contextPath}/client/userLogout";
	    });
	});
</script>
</head>
<body>
	<div class="easyui-accordion" style="width:100%;height:100%;">
		<c:forEach items="${planStatus }" var="map">
			<div title="${map.key }" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:10px;">
				<c:forEach items="${map.value}" var="mapForRelation">
					<c:if test="${mapForRelation.key=='total'}">
						<p>总共${mapForRelation.value}人需要你进行测评！</p>
					</c:if>
					<c:if test="${mapForRelation.key=='tested'}">
						<p>已经有${mapForRelation.value}人被你测评了</p>
					</c:if>
					<c:if test="${mapForRelation.key=='noTested'}">
						<p>还有${mapForRelation.value}人没有需要你进行测评</p>
					</c:if>
				</c:forEach>
			</div>
		</c:forEach>
	</div>
</body>
</html>