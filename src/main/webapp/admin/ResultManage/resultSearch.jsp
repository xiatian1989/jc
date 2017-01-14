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
			
			var param = '1=1';
			if (grade != '') {
				flag = true;
				param = param + '&userno=' + userno;
			}
			if (studentno != '') {
				flag = true;
				param = param + '&truename=' + + encodeURIComponent(encodeURIComponent(truename));
			}
			if (truename != '') {
				flag = true;
				param = param + '&departname=' + encodeURIComponent(encodeURIComponent(departname));
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
		部门：<input class="easyui-textbox right" style="width:140px;height:20px" id="departno" value="${departno}">
		<input type="button" value="搜索" onclick="search()"> 
	</div>
	<div id="p" class="easyui-panel" title="查询结果" style="padding-top:5px;padding-left:5px;padding-right:5px;" closed="true">
		<div class="easyui-tabs" style="margin-bottom: 6px;" id="father">
			<c:forEach items="${mapsForStudentForNoPayChargeList}" var="studentForNoPayChargeList">
				<div title="${studentForNoPayChargeList.key}" style="padding:10px">
					<p style="font-size:14px;text-align: center;">
						<span style="color: blue;">${studentForNoPayChargeList.key}:</span>
						<span>欠费金额：<fmt:formatNumber value="${studentForNoPayChargeList.value.allArrears}" type="currency"/></span>
						<span>欠费人数：${studentForNoPayChargeList.value.arrearsPeople}</span>
					</p>
					<table id= "data" class="easyui-datagrid"  rownumbers="true" fitColumns="true" singleSelect="true" striped="true" style="height: 300px;">
						<thead>
							<tr>
								<th field="studentno" width="40px;">学号</th>
								<th field="truename" width="40px;">姓名</th>
								<th field="grade" width="30px;">年级</th>
								<th field="profession" width="50px;">专业</th>
								<th field="schoolyear" width="30px;">学年</th>
								<th field="moneyname" width="50px;">缴费项目</th>
								<th field="arreas" width="50px;">欠费</th>
								<th field="remarks" width="50px;">备注</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${studentForNoPayChargeList.value.noPayChargeBeans }" var="noPayChargeBean">
								<tr>
									<td>${noPayChargeBean.studentno }</td>
									<td>${noPayChargeBean.truename }</td>
									<td>${noPayChargeBean.grade }</td>
									<td>${noPayChargeBean.profession }</td>
									<td>${noPayChargeBean.schoolyear }</td>
									<td>${noPayChargeBean.moneyname }</td>
									<td><fmt:formatNumber value="${noPayChargeBean.arrears }" type="currency"/></td>
									<td>${noPayChargeBean.remarks }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>