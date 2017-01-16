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
	function notice(){
		$.messager.alert("提示", "该对象已经被测评了，请选择其他人员测评！", "info");
		window.open("${pageContext.request.contextPath}/client/planStatus","mainContent");
	}
	function editUser() {
		$('#dlg').dialog('open').dialog('setTitle', '编辑资料');
		$('#fm').form('clear');
		if ($("#usersex").val()=='true') {
			$("#sex").val("1");
		} else {
			$("#sex").val("0");
		}
		$("#truename").val($("#username").val());
		$("#phone").val($("#userphone").val());
		$("#webchat").val($("#userwebchat").val());
		$("#id").val($("#userid").val());
		$("#password").val("")
		url = "${pageContext.request.contextPath}/updateUser"
	}
	
	function saveUser() {

		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				var flag = $(this).form('validate');
				if (!flag) {
					return flag;
				}
				var password = $("#password").val();
				var repassword = $("#repassword").val();
				if(password != repassword) {
					$.messager.alert('提示','两次输入密码不匹配！','info');
					return false;
				}
			},
			success : function(result) {
				var obj = jQuery.parseJSON(result);
				if (obj.result == "success") {
					$("#userTruename").text($("#truename").val())
					$('#dlg').dialog('close');
				} else {
					$.messager.alert('错误', obj.errorMsg, 'error');
				}
			}
		});
	}
	
	function cancel() {
		$('#fm').form('clear');
		$('#dlg').dialog('close');
	}
	
	function openWinForResult(){
		$('#winForResult').window('open');
		$('#winForResult').window('refresh', '${pageContext.request.contextPath}/client/resultSearchForSingle?userno='+$("#userno").val());
	}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:46px;background:#B3DFDA;padding-top:8px;padding-left:8px;padding-right:8px" >
		<a href="#" class="easyui-menubutton" data-options="menu:'#mm3',iconCls:'icon-man'" style="float:right;"><span id="userTruename">${user.truename}</span></a>
		<input type="text" id="username" value="${user.truename }" style="display: none">
		<input type="text" id="userno" value="${user.userno }" style="display: none">
		<input type="text" id="userid" value="${user.id }" style="display: none">
		<input type="text" id="usersex" value="${user.sex }" style="display: none">
		<input type="text" id="userphone" value="${user.phone }" style="display: none">
		<input type="text" id="userwebchat" value="${user.webchat }" style="display: none">
		<div id="mm3">
			<div onclick="editUser()">修改资料</div>
			<div onclick="openWinForResult()">测评结果查看</div>
			<div id="logOut">安全退出</div>
		</div>
	</div>
	<div data-options="region:'west',split:true,title:'测评对象'" style="width:200px">
		<ul id="tt" class="easyui-tree">
			<c:forEach items="${planForRelations}" var="map" varStatus="status">
				<c:choose>
					<c:when test="${status.index == 0}">
						<li>
					</c:when>
					<c:otherwise>
						<li data-options="state:'closed'">
					</c:otherwise>
				</c:choose>				
					<span>${map.key.plantitle}
						<c:choose>
							<c:when test="${map.key.isfinish}">
								(结束)
							</c:when>
							<c:otherwise>
								(未结束)
							</c:otherwise>
						</c:choose>
					</span>
					<ul>
						<c:forEach items="${map.value}" var="relation" >
							<li>
								<span>
									<c:choose>
										<c:when test="${relation.isfinish}">
											<a href="javascript:void(0)" onclick="notice()">
										</c:when>
										<c:otherwise>
											<a href="${pageContext.request.contextPath}/paperTest?paperId=${relation.paperId}&relationId=${relation.id}&type=${relation.paper.type}" target="mainContent">
										</c:otherwise>
									</c:choose>
										<c:choose>
											<c:when test="${relation.isperson}">
												${relation.beTestedUser.truename}
												<c:choose>
													<c:when test="${relation.isfinish}">
														(已测评)
													</c:when>
													<c:otherwise>
														(未测评)
													</c:otherwise>
												</c:choose>
											</c:when>
											 <c:otherwise>
												 ${relation.testedDepart.departName	}
												 <c:choose>
													<c:when test="${relation.isfinish}">
														(已测评)
													</c:when>
													<c:otherwise>
														(未测评)
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</a>
								</span>
							</li>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;text-align: center;"><p>Copyright ©2017</div>
	<div data-options="region:'center'">
		<iframe src="${pageContext.request.contextPath}/client/planStatus" scrolling="auto" width="100%"  height="99%" style="border: 0" name="mainContent"></iframe>
		<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 300px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
			<form id="fm" method="post">
				<input id=id name=id  style="display:none">
				<table>
					<tr>
						<td style="height: 28px" width=120>姓名：</td>
						<td style="height: 28px" width=210><input id=truename
							style="width: 190px" name=truename class="easyui-validatebox" required="true"></td>
					</tr>
					<tr>
						<td style="height: 28px">密码：</td>
						<td style="height: 28px" width=210><input id=password style="width: 190px"
							type=password name=password></td>
					</tr>
					<tr>
						<td style="height: 28px">确认密码：</td>
						<td style="height: 28px" width=210><input id=repassword style="width: 190px"
							type=password name=repassword></td>
					</tr>
					<tr>
						<td style="height: 28px" width=120>性别：</td>
						<td style="height: 28px">
							<select id="sex" name="sex" style="width:195px;">
								<option value="1">女</option>
								<option value="0">男</option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="height: 28px" width=120>电话号码：</td>
						<td style="height: 28px" width=210><input id=phone
							style="width: 190px" name=phone class="easyui-validatebox" required="true" validType="length[11,11]"></td>
					</tr>
					<tr>
						<td style="height: 28px" width=120>微信号：</td>
						<td style="height: 28px" width=210><input id=webchat
							style="width: 190px" name=webchat class="easyui-validatebox" required="true"></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				onclick="saveUser()">保存</a> <a href="#" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="cancel();">取消</a>
		</div>
		<div id="winForResult" class="easyui-window" title="测评结果" style="width:1000px;height:460px"
   	 		data-options="iconCls:'icon-save',modal:true,closed:true,cache: false">
		</div>
	</div>
</body>
</html>