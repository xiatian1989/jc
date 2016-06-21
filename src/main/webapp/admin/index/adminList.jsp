<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function altRows(id) {
		if (document.getElementsByTagName) {

			var table = document.getElementById(id);
			var rows = table.getElementsByTagName("tr");

			for (i = 0; i < rows.length; i++) {
				if (i % 2 == 0) {
					rows[i].className = "evenrowcolor";
				} else {
					rows[i].className = "oddrowcolor";
				}
			}
		}
	}

	window.onload = function() {
		altRows('alternatecolor');
	}
</script>
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
		<tr>
			<th>Info Header 1</th>
			<th>Info Header 2</th>
			<th>Info Header 3</th>
		</tr>
		<tr>
			<td>Text 1A</td>
			<td>Text 1B</td>
			<td>Text 1C</td>
		</tr>
		<tr>
			<td>Text 2A</td>
			<td>Text 2B</td>
			<td>Text 2C</td>
		</tr>
		</tr>
		<tr>
			<td>Text 3A</td>
			<td>Text 3B</td>
			<td>Text 3C</td>
		</tr>
		<tr>
			<td>Text 4A</td>
			<td>Text 4B</td>
			<td>Text 4C</td>
		</tr>
		<tr>
			<td>Text 5A</td>
			<td>Text 5B</td>
			<td>Text 5C</td>
		</tr>
	</table>
</body>
</html>