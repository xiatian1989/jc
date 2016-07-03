<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
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
	
	function disabledAdmin(id,flag) {
		if(flag) {
			alert("超级管理员不可以禁用！");
		}else {
			$("#"+id+" td:eq(4) span").html("禁用");
			$("#disabledButton"+id).hide();
			$("#enabledButton"+id).show();
			var data = 'admin.id='+id+"&admin.status="+false;
			updateAdmin(data);
		}
	}
	
	function enabledAdmin(id){
		$("#"+id+" td:eq(4) span").html("启用");
		$("#disabledButton"+id).show();
		$("#enabledButton"+id).hide();
		var data = 'admin.id='+id+"&admin.status="+true;
		updateAdmin(data);
	}
	
	function updateAdmin(data){
		$.ajax({   
		    url:'${pageContext.request.contextPath}/updateAdmin',   
		    type:'post',   
		    data:data,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('更新失败');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.model.result=="success") {
		    		alert("更新成功!")
		    	}else{
		    		alert('更新失败'); 
		    	}
		    }
		});
	}
	
	function deleteAdmin(id,flag){
		
		if(flag) {
			alert("超级管理员不可以删除！");
		}else {
			top.operation="delete";
			$.ajax({   
			    url:'${pageContext.request.contextPath}/deleteAdmin',   
			    type:'post',   
			    data:'id='+id,   
			    async : false, //默认为true 异步   
			    error:function(){   
			       alert('删除失败!');   
			    },   
			    success:function(msg){
			    	var obj = jQuery.parseJSON(msg);
			    	if(obj.result=="success") {
			    		window.location.href="${pageContext.request.contextPath}/adminList";
			    	}else{
			    		alert('删除失败!'); 
			    	}
			    }
			});
		}
	}
	$(function() {
		$("#add-form").dialog({
			autoOpen : false,
			height : 300,
			width : 350,
			modal : true,
			buttons : {
				"OK" : function() {
					$("#addAdmin").submit();
				},
				Cancel : function() {
					$(this).dialog("close");
				}
			}

		});
		$("#update-form").dialog({
			autoOpen : false,
			height : 300,
			width : 350,
			modal : true,
			buttons : {
				"OK" : function() {
					$("#updateAdmin").submit();
				},
				Cancel : function() {
					$(this).dialog("close");
				}
			}

		});	
		$("#addAdminBefore").button().click(function() {
			$.ajax({   
			    url:'${pageContext.request.contextPath}/addAdminBefore',   
			    type:'post',   
			    async : false, //默认为true 异步   
			    success:function(msg){
			    	var obj = jQuery.parseJSON(msg);
			    	if(obj.model.result=="success") {
			    		
			    		$("#add-form").dialog("open");
			    		var html="";
			    		for ( var i = 0; i < obj.model.organizationList.length; i++) {
			    			html = html+ ("<option value=\"" + obj.model.organizationList[i].id +
			    					"\">" + obj.model.organizationList[i].organizationName+ "</option>");
			    		}
			    		$("#organization").html(html);
			    	}
			    }
			});
		});
	});
	function checkInput(type){
		if(type=='0') {
			var userName = $("#userName").val();
			var password = $("#password").val();
			var rePassword = $("#rePassword").val();
			if(userName==""){
				alert("请输入用户名！");
				$("#userName").focus().select();
				return false;
			}
			if(password==""){
				alert("请输入密码！");
				$("#password").focus().select();
				return false;
			}
			if(password != rePassword) {
				alert("密码不一致！");
				$("#rePassword").focus().select();
				return false;
			}
		}else {
			debugger;
			var password = $("#passwordp").val();
			var rePassword = $("#repasswordp").val();
			if(password != rePassword) {
				alert("密码不一致！");
				$("#rePassword").focus().select();
				return false;
			}
		}
	}
	function editAdminBefore(id,flag){
		$.ajax({   
		    url:'${pageContext.request.contextPath}/editAdminBefore',   
		    type:'post',   
		    async : false, //默认为true 异步   
		    data:'id='+id,  
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.model.result=="success") {
		    		$("#update-form").dialog("open");
		    		$("#userNamep").val(obj.model.username);
		    		$("#idp").val(obj.model.id);
		    		if(obj.model.level == '1') {
		    			$("#statusp").attr("disabled","disabled")
		    		}
		    		if(obj.model.status) {
		    			$("#statusp").val("1");
		    		}else {
		    			$("#statusp").val("0");
		    		}
		    		if(!flag) {
		    			debugger;
			    		var html="";
			    		for ( var i = 0; i < obj.model.organizationList.length; i++) {
			    			html = html+ ("<option value=\"" + obj.model.organizationList[i].id +
			    					"\">" + obj.model.organizationList[i].organizationName+ "</option>");
			    		}
			    		$("#organizationp").html(html);
		    		}
		    	}
		    }
		});
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
	text-align: center;
}

.oddrowcolor {
	background-color: #d4e3e5;
}

.evenrowcolor {
	background-color: #c3dde0;
}
.page {
	PADDING-RIGHT: 3px;
	PADDING-LEFT: 3px;
	PADDING-BOTTOM: 3px;
	MARGIN: 3px;
	PADDING-TOP: 3px;
	TEXT-ALIGN: center
}

a {
	position: relative;
	text-decoration: none;
	border-bottom: 1px dotted #ccc;
	padding-bottom: 5px;
}

a em {
	display: none;
	position: absolute;
	padding: 5px;
	border: 1px solid #ccc;
	left: 20px;
	top: 30px;
	width: 60px;
}

a:hover {
	border-bottom: 1px solid #ccc;
}

a:hover em {
	display: block;
}
</style>
</head>
<body>
	<button id="addAdminBefore">添加账号</button>
	<table class="altrowstable" id="alternatecolor" width="100%">
		<tr>
			<th width="100px">序号</th>
			<th>用户名称</th>
			<th>管理员名称</th>
			<th width="120px">管理员类别</th>
			<th width="100px">管理员状态</th>
			<th width="150px">操作</th>
		</tr>
		<c:forEach items="${page.list }" var="admin" varStatus="status">
			<tr id="${admin.id}">
				<td>${status.index+1}</td>
				<td>
					<c:if test="${admin.organization != null }">
						${admin.organization.organizationName}
					</c:if>
				</td>
				<td>
					${admin.username}
				</td>
				<td>
					<c:choose>
						<c:when test="${admin.level}">
							<span>超级管理员</span>
						</c:when>
						<c:otherwise>
							<span>普通管理员</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${admin.status}">
							<span>启用</span>
						</c:when>
						<c:otherwise>
							<span>禁用</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${admin.status}">
							<input type="button" value="禁用" onclick="disabledAdmin('${admin.id}',${admin.level})" id="disabledButton${admin.id}"/>
							<input type="button" value="启用" onclick="enabledAdmin('${admin.id}')" id="enabledButton${admin.id}" style="display:none"/>
						</c:when>
						<c:otherwise>
							<input type="button" value="启用" onclick="enabledAdmin('${admin.id}')" id="enabledButton${admin.id}"/>
							<input type="button" value="禁用" onclick="disabledAdmin('${admin.id}',${admin.level})" id="disabledButton${admin.id}" style="display:none"/>
						</c:otherwise>
					</c:choose>
					<input type="button" value="编辑" onclick="editAdminBefore('${admin.id}',${admin.level})" id="editButton${admin.id}"/>
					<input type="button" value="删除" onclick="deleteAdmin('${admin.id}',${admin.level})" id="deleteButton${admin.id}"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="page">
		<span style="padding-right:10px;">总记录数为${page.total},共${page.pages}页</span>
		<c:choose>
			<c:when test="${page.pageNum == 1}">
				<a>上一页</a>
			</c:when>
			<c:otherwise>
				<a href="adminList?pageNum=${page.pageNum - 1}">上一页</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${pages != 1}">
			<c:forEach var="pageIndex" begin="1" end="${page.pages}">
				<c:choose>
					<c:when test="${page.pageNum == pageIndex}">
						<a>${pageIndex}</a>
					</c:when>
					<c:otherwise>
						<a href="adminList?pageNum=${pageIndex}">${pageIndex}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		<c:choose>
			<c:when test="${page.pageNum == page.pages}">
					<a>下一页</a>
				</c:when>
				<c:otherwise>
					<a href="adminList?pageNum=${page.pageNum+1}">下一页</a>
			</c:otherwise>
		</c:choose>
	</div>
	
    <div id="add-form" title="创建新用户">
	 	<form action="${pageContext.request.contextPath}/addAdmin" method="post" onsubmit="return checkInput(0);" id="addAdmin">
			<table width=100%>
				<tbody>
					<tr>
						<td class=“left” width=40% align="right"><label for="userName">姓
								名：</label></td>
						<td class="right"><input type="text" id="userName" name=username></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right"><label
							for="password">密 码：</label></td>
						<td class="right"><input id="password" type="password"
							name="password" /></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right"><label
							for="rePassword">确认密 码：</label></td>
						<td class="right"><input id="rePassword" type="password"
							name="rePassword" /></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right">状态：</td>
						<td><select id="status" name="status">
								<option value="1">启用</option>
								<option value="0">禁用</option>
						</select></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right">关联用户：</td>
						<td><select id="organization" name="organizationId">
						</select></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
    <div id="update-form" title="更新管理员信息">
	 	<form action="${pageContext.request.contextPath}/updateAdmin" method="post" onsubmit="return checkInput(1);" id="updateAdmin">
			<table width=100%>
				<tbody>
					<tr style="display:none">
						<td class=“left” width=40% align="right"></td>
						<td class="right"><input type="text" name="id" id="idp"></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right"><label for="userNamep">姓
								名：</label></td>
						<td class="right"><input type="text" id="userNamep" name="username"></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right"><label
							for="passwordp">密 码：</label></td>
						<td class="right"><input id="passwordp" type="password"
							name="password" /></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right"><label
							for="repasswordp">确认密 码：</label></td>
						<td class="right"><input id="repasswordp" type="password"
							name="repassword" /></td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right">状态：</td>
						<td>
							<select id="statusp" name="status">
									<option value="1">启用</option>
									<option value="0">禁用</option>
							</select>
								
						</td>
					</tr>
					<tr>
						<td class=“left” width=40% align="right">关联用户：</td>
						<td><select id="organizationp" name="organizationId">
						</select></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>