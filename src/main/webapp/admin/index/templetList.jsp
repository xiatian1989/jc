<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
	
	function disabledTemplet(id){
		$("#"+id+" td:eq(6) span").html("禁用");
		$("#disabledButton"+id).hide();
		$("#enabledButton"+id).show();
		var data = 'templet.id='+id+"&templet.status="+false;
		updateTemplet(data,false);
	}
	
	function enabledTemplet(id){
		$("#"+id+" td:eq(6) span").html("启用");
		$("#disabledButton"+id).show();
		$("#enabledButton"+id).hide();
		var data = 'templet.id='+id+"&templet.status="+true;
		updateTemplet(data,false);
	}
	
	function updateTemplet(data,flag){
		$.ajax({   
		    url:'${pageContext.request.contextPath}/updateTemplet',   
		    type:'post',   
		    data:data,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('更新失败');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="success") {
		    		if(flag) {
		    			window.location.href="${pageContext.request.contextPath}/templetList";
		    		}
		    	}else{
		    		alert('更新失败'); 
		    	}
		    }
		});
	}
	
	function deleteTemplet(id) {
		$.ajax({   
		    url:'${pageContext.request.contextPath}/deleteTemplet',   
		    type:'post',   
		    data:'id='+id,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('删除失败');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="success") {
		    		window.location.href="${pageContext.request.contextPath}/templetList";
		    	}else{
		    		alert('删除失败'); 
		    	}
		    }
		});
	}
	function editTempletBefore(id){
		$("#disabledButton"+id).hide();
		$("#enabledButton"+id).hide();
		$("#editButton"+id).hide();
		$("#deleteButton"+id).hide();
		$("#editTempletDetail"+id).hide();
		$("#OKButton"+id).show();
		$("#"+id+" td:eq(1) input").removeAttr("disabled");
		$("#"+id+" td:eq(2) input").removeAttr("disabled");
		$("#"+id+" td:eq(3) textarea").removeAttr("disabled");
		$("#"+id+" td:eq(6)").html("<select><option>启用</option><option>禁用</option></select>");
	}
	
	function editTemplet(id){
		var templettitle = $("#"+id+" td:eq(1) input").val();
		var keyword = $("#"+id+" td:eq(2) input").val();
		var description = $("#"+id+" td:eq(3) textarea").val();
		var statusText = $("#"+id+" td:eq(6) select").val();
		var status =true;
		if(statusText=="禁用") {
			status=false
		}
		var data = 'templet.id='+id+"&templet.status="+status+"&templet.keyword="+keyword+"&templet.templettitle="+templettitle+"&templet.description="+description;
		updateTemplet(data,true);
	}
	
	function checkUniqName(id,object) {
		var TempletName = $("#"+id+" td:eq(1) input").val();
		var oldTempletName = $("#"+id+" td:eq(1) input").attr("title");
		if(TempletName == oldTempletName) {
			return;
		}
		
		$.ajax({   
		    url:'${pageContext.request.contextPath}/checkTempletName',   
		    type:'post',   
		    data:'name='+TempletName,   
		    async : false, //默认为true 异步   
		    error:function(){   
		       alert('模板名称已经存在！');   
		    },   
		    success:function(msg){
		    	var obj = jQuery.parseJSON(msg);
		    	if(obj.result=="failed") {
		    		
		    		alert('模板名称已经存在！');
		    		$(object).focus().select();
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
	<table class="altrowstable" id="alternatecolor" width="100%">
		<tr>
			<th width="30px">序号</th>
			<th width="12%">标题</th>
			<th width="12%">关键词</th>
			<th>描述</th>
			<th width="150px">创建时间</th>
			<th width="150px">更新时间</th>
			<th width="40px">状态</th>
			<th width="250px">操作</th>
		</tr>
		<c:forEach items="${page.list }" var="templet" varStatus="status">
			<tr id="${templet.id}">
				<td>${status.index+1 }</td>
				<td><input type="text" value="${templet.templettitle}"  disabled="disabled" title="${templet.templettitle}" onblur="checkUniqName('${organization.id}',this)" style="width:99%;word-break:break-all"/></td>
				<td><input type="text" value="${templet.keyword}"  disabled="disabled" title="${templet.keyword}" style="width:99%;word-break:break-all"/></td>
				<td>
					<textarea rows="4" cols="50" disabled="disabled" title="${templet.description}" style="width:99%;word-break:break-all">${templet.description}</textarea>
				</td>
				<td><fmt:formatDate value ="${templet.createtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><fmt:formatDate value ="${templet.updattime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>
					<c:choose>
						<c:when test="${templet.status}">
							<span>启用</span>
						</c:when>
						<c:otherwise>
							<span>禁用</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${templet.status}">
							<input type="button" value="禁用" onclick="disabledTemplet('${templet.id}')" id="disabledButton${templet.id}"/>
							<input type="button" value="启用" onclick="enabledTemplet('${templet.id}')" id="enabledButton${templet.id}" style="display:none"/>
						</c:when>
						<c:otherwise>
							<input type="button" value="启用" onclick="enabledTemplet('${templet.id}')" id="enabledButton${templet.id}"/>
							<input type="button" value="禁用" onclick="disabledTemplet('${templet.id}')" id="disabledButton${templet.id}" style="display:none"/>
						</c:otherwise>
					</c:choose>
					<input type="button" value="编辑" onclick="editTempletBefore('${templet.id}')" id="editButton${templet.id}"/>
					<input type="button" value="删除" onclick="deleteTemplet('${templet.id}')" id="deleteButton${templet.id}"/>
					<input type="button" value="编辑模板详情" onclick="editTempletDetail('${templet.id}')" id="editTempletDetail${templet.id}"/>
					<input type="button" value="确定" onclick="editTemplet('${templet.id}')" style="display: none" id="OKButton${templet.id}"/>
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
				<a href="templetList?pageNum=${page.pageNum - 1}">上一页</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${pages != 1}">
			<c:forEach var="pageIndex" begin="1" end="${page.pages}">
				<c:choose>
					<c:when test="${page.pageNum == pageIndex}">
						<a>${pageIndex}</a>
					</c:when>
					<c:otherwise>
						<a href="templetList?pageNum=${pageIndex}">${pageIndex}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		<c:choose>
			<c:when test="${page.pageNum == page.pages}">
					<a>下一页</a>
				</c:when>
				<c:otherwise>
					<a href="templetList?pageNum=${page.pageNum+1}">下一页</a>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>