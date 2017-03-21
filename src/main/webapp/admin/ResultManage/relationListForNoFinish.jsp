<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
<title>学费管理系统</title>
<meta charset="UTF-8">
	<style>
		
		.t1 {
			clear: both;
			border: 1px solid #c9dae4;
		}
		
		.t1 tr th {
			color: #0d487b;
			background: #f2f4f8 url(../CSS/Table/images/sj_title_pp.jpg) repeat-x
				left bottom;
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
	<table id="ListArea" border="0" class="t1" align="center" cellpadding="0" cellspacing="0" width="100%">
		<caption align="right"><a href="javascript:void(0)" onclick="javascript:history.go(-1)">返回上一页</a></caption>
		<tr align="center">
			<th>测评计划</th>
			<th>被测评对象</th>
			<th>测评人</th>
			<th>创建时间</th>
		</tr>
		<c:forEach items="${relations}" var="relation" >
			<tr align="center">
				<td>${relation.plan.plantitle }</td>
				<c:choose>
					<c:when	test="${relation.isperson }">
						<td>${relation.beTestedUser.truename}</td>
					</c:when>
					<c:otherwise>
						<td>${relation.testedDepart.departName}</td>
					</c:otherwise>
				</c:choose>
				<td>${relation.testUser.truename}</td>
				<td><fmt:formatDate value="${relation.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				
			</tr>		
		</c:forEach>
	</table>
</body>
</html>