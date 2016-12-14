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
</script>
<style type="text/css">
	body{
		padding:0px;
	}
</style>
</head>	
<body>
	<div class="easyui-layout" style="width:100%;height:100%;">
		<div data-options="region:'east',split:true" title="" style="width:350px;">
			&nbsp;部门:<select id="departNoRight" name="departNoRight" style="width:140px;" onchange="changeDepartRight()">
			</select>
			&nbsp;&nbsp;对象类型:
			<select id="beTestedType" name="beTestedType" style="width:100px;" onchange="changeDepartRight()">
				<option value="0">人员</option>
				<option value="1">部门</option>
			</select>
			<ul class="easyui-tree" data-options="url:'${pageContext.request.contextPath}/departListForUser',checkbox:true,lines:true" id="ttRight" ></ul>
		</div>
		<div data-options="region:'west',split:true" title="" style="width:350px;">
			&nbsp;部门:<select id="departNoLeft" name="departNoLeft" style="width:140px;" onchange="changeDepartLeft()">
			</select>
			<ul class="easyui-tree" data-options="url:'${pageContext.request.contextPath}/departListForUser',checkbox:true,lines:true" id="ttLeft" ></ul>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok'">
			<div style="text-align: center;margin-top: 50px">
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加测评试卷</a><br><br>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加测评规则</a><br><br>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">建立测评关系</a><br><br>
			</div>
		</div>
	</div>
</body>
</html>