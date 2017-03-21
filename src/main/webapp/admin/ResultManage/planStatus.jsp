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
		
		.panel {
			font-size: 14px !important;
		}
		
		.t1 {
			clear: both;
			border: 1px solid #c9dae4;
		}
		
		.t1 tr th {
			color: #0d487b;
			background: #f2f4f8;
			line-height: 28px;
			border-bottom: 1px solid #9cb6cf;
			border-top: 1px solid #e9edf3;
			font-weight: normal;
			text-shadow: #e6ecf3 1px 1px 0px;
			padding-left: 5px;
			padding-right: 5px;
		}
		
		.t1 tr td {
			border-bottom: 1px solid #e9e9e9;
			padding-bottom: 5px;
			padding-top: 5px;
			color: #444;
			border-top: 1px solid #FFFFFF;
			padding-left: 5px;
			padding-right: 5px;
			word-break: break-all;
		}
		/* white-space:nowrap; text-overflow:ellipsis; */
		tr.alt td {
			background: #ecf6fc; /*这行将给所有的tr加上背景色*/
		}
		
		tr.over td {
			background: #bcd4ec; /*这个将是鼠标高亮行的背景色*/
		}
		caption{
			font-size: 14px;
		}
	</style> 
	 <script type="text/javascript">
        $(document).ready(function () { //这个就是传说的ready  
            $(".t1 tr").mouseover(function () {
                //如果鼠标移到class为stripe的表格的tr上时，执行函数  
                $(this).addClass("over");
            }).mouseout(function () {
                //给这行添加class值为over，并且当鼠标一出该行时执行函数  
                $(this).removeClass("over");
            }) //移除该行的class  
            $(".t1 tr:even").addClass("alt");
            //给class为stripe的表格的偶数行添加class值为alt
        });
    </script>
</head>
<body>
	<div id="p" class="easyui-panel" title="查询结果">
		<div class="easyui-tabs">
			<c:forEach items="${map}" var="map">
				<div title="${map.key.plantitle}">
				<table id="ListArea" border="0" class="t1" align="center" cellpadding="0" cellspacing="0" width="100%"> 
						<caption>
							<fmt:formatDate value="${map.key.begintime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								 &nbsp;&nbsp;
								~&nbsp;&nbsp;
							 <fmt:formatDate value="${map.key.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
							 	&nbsp;&nbsp;
							 <c:choose>
							 	<c:when test="${map.key.isfinish}">
							 		完成
							 	</c:when>
							 	<c:otherwise>
							 		 <c:choose>
									 	<c:when test="${map.key.isstart}">
									 		未完成
									 	</c:when>
									 	<c:otherwise>
									 		未开始
									 	</c:otherwise>
									 </c:choose>
							 	</c:otherwise>
							 </c:choose>
						 </caption>
						<tr align="center">
							<th>被测评对象</th>
							<th>测评人数</th>
							<th>有效测评人数</th>
							<th>未完成人数</th>
						</tr>
						<c:forEach items="${map.value}" var="planStatusBean" >
							<tr align="center">
								<td>${planStatusBean.betestedObejct }</td>
								<td>${planStatusBean.totalRelation }</td>
								<td>${planStatusBean.validateRelation }</td>
								<td>
									<c:choose>
										<c:when test="${planStatusBean.isPerson}">
											<a href="${pageContext.request.contextPath}/admin/viewNofinish?type=0&no=${planStatusBean.betestedObejctNo }&planId=${map.key.id }">${planStatusBean.noFinishRelation }</a>
										</c:when>
										<c:otherwise>
											<a href="${pageContext.request.contextPath}/admin/viewNofinish?type=1&no=${planStatusBean.betestedObejctNo }&planId=${map.key.id }">${planStatusBean.noFinishRelation }</a>
										</c:otherwise>
									</c:choose>
									
								</td>
							</tr>		
						</c:forEach>
				</table>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>