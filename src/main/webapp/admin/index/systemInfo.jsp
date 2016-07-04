<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table.altrowstable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-width: 1px;
	border-color: #a9c6c9;
	border-collapse: collapse;
}

table.altrowstable th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}

table.altrowstable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}

.oddrowcolor {
	background-color: #d4e3e5;
}

.evenrowcolor {
	background-color: #c3dde0;
}
</style>
</head>
<body>
	<table class="altrowstable" id="alternatecolor">
	<caption>系统信息</caption>
		<tr>
			<td style="width:20%;">OS</td>
			<td style="width:80%;">${systemInfo.oS }</td>
		</tr>
		<tr>
			<td style="width:20%;">ServerName</td>
			<td style="width:80%;">${systemInfo.serverName}</td>
		</tr>
		<tr>
			<td style="width:20%;">JAVA_HOME</td>
			<td style="width:80%;">${systemInfo.javaHome }</td>
		</tr>
		<tr>
			<td style="width:20%;">ServerInfo</td>
			<td style="width:80%;">${systemInfo.serverInfo }</td>
		</tr>
		<tr>
			<td style="width:20%;">ContextPath</td>
			<td style="width:80%;">${systemInfo.contextPath }</td>
		</tr>
		<tr>
			<td style="width:20%;">ServerHostIP</td>
			<td style="width:80%;">${systemInfo.serverHostIP }</td>
		</tr>
		<tr>
			<td style="width:20%;">Protocol</td>
			<td style="width:80%;">${systemInfo.protocol }</td>
		</tr>
		<tr>
			<td style="width:20%;">ServerPort</td>
			<td style="width:80%;">${systemInfo.serverPort }</td>
		</tr>
		<tr>
			<td style="width:20%;">ServerTime</td>
			<td style="width:80%;">${systemInfo.serverTime }</td>
		</tr>
	</table>
</body>
</html>