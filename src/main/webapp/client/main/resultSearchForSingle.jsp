<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<title>人事测评系统</title>
	<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/demo/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/amazeui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css" />
<script type="text/javascript">
	function IsPC() {
	    var userAgentInfo = navigator.userAgent;
	    var Agents = ["Android", "iPhone",
	                "SymbianOS", "Windows Phone",
	                "iPad", "iPod"];
	    var flag = true;
	    for (var v = 0; v < Agents.length; v++) {
	        if (userAgentInfo.indexOf(Agents[v]) > 0) {
	            flag = false;
	            break;
	        }
	    }
	    return flag;
	}
	$(function(){
		if(!IsPC()) {
			$("#bottom").html('<div class="chat-msg"><div class="chat-div-my"><input type="submit" class="btn-style-01" value="返回" onclick="javascript:history.go(-1)"/></div></div>');
		}
	});
</script>
<style>
	html, body {
		margin: 0;
		padding: 0
	}
	.panel{
		font-size: 14px!important;
	}
	.right {
		margin-right: 15px;
	}
</style>
</head>
<body>
	<div id="p" class="easyui-panel" title="查询结果">
		<c:choose>
			<c:when test="${!empty map}">
				<div class="easyui-tabs">
					<c:forEach items="${map}" var="map">
						<div title="${map.key}">
							<div class="easyui-accordion" style="width:100%;height: 600px;">
								<c:forEach items="${map.value}" var="mapForUser">
									<div title="${mapForUser.key}" style="padding:10px;">
										<c:forEach items="${mapForUser.value}" var="mapForPaper">
											<p>
												<h1>《${mapForPaper.key}》</h1>
												<c:forEach items="${mapForPaper.value}" var="mapForDetail">
													<h3>${mapForDetail.key}</h3>
													<span>&nbsp;&nbsp;${mapForDetail.value}</span>
													<br>
												</c:forEach>
											</p>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<div>系统没有您的被测评结果</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div id="bottom"></div>
</body>
</html>