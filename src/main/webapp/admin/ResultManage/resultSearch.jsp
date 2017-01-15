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
	.right {
		margin-right: 15px;
	}
</style>
	<script>
		$(function(){
			var search = $("#search").val();
			if(search=='1') {
				$('#p').panel('open');
			}
		})
		function search(){
			var userno = $("#userno").val();
			var truename = $("#truename").val();
			var departname = $("#departname").val();
			var flag = false;
			
			var param = '1=1';
			if (userno != '') {
				flag = true;
				param = param + '&userno=' + userno;
			}
			if (truename != '') {
				flag = true;
				param = param + '&truename=' + encodeURIComponent(encodeURIComponent(truename));
			}
			if (departname != '') {
				flag = true;
				param = param + '&departname=' + encodeURIComponent(encodeURIComponent(departname));
			}
			
			if(!flag) {
				$.messager.alert("提示", "请输入查询值！", "info");
				return;
			}
			
			window.location.href="${pageContext.request.contextPath}/admin/resultSearch?param="+param;
		}
	</script>
</head>
<body>
	<input type="text" value="${search }" style="display: none" id="search">
	<div id="header" class="easyui-panel" title="查询条件" style="height:70px;text-align: center; line-height:40px;">
		用户账号：<input class="easyui-textbox right" style="width:140px;height:20px" id="userno" value="${userno}">
		姓名：<input class="easyui-textbox right" style="width:140px;height:20px" id="truename" value="${truename}" >
		部门：<input class="easyui-textbox right" style="width:140px;height:20px" id="departname" value="${departname}">
		<input type="button" value="搜索" onclick="search()"> 
	</div>
	<div id="p" class="easyui-panel" title="查询结果" closed="true">
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
	</div>
</body>
</html>