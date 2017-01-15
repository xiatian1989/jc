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
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:46px;background:#B3DFDA;padding-top:8px;padding-left:8px;padding-right:8px" >
		<a href="#" class="easyui-menubutton" data-options="menu:'#mm3',iconCls:'icon-man'" style="float:right;">${user.truename}</a>
		<div id="mm3">
			<div>修改资料</div>
			<div>测评结果查看</div>
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
	</div>
</body>
</html>