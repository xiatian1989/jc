<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
<style type="text/css">
	body{
		padding-left:10px;
		padding-top:25px;
	}
</style>
<script type="text/javascript">
	function submit() {
		debugger;
		var total = $("#total").val();
		var relationId = $("#relationId").val();
		var type = $("#type").val();
		var answerTotal=0;
		var answer;
		var resultMessage="";
		var extraMeassge="";
		for(var i = 1;i<=total;i++) {
			answer=$("input[name='"+i+"']:checked").val();
			if(answer) {
				answerTotal++;
				resultMessage = resultMessage + "#";
				resultMessage = resultMessage+i +":"+answer;
				if($("#"+i).val()){
					extraMeassge = extraMeassge + "#";
					extraMeassge = extraMeassge+i +":"+$("#"+i).val();
				}
			}
		}
		$.messager.confirm(
			'Confirm','你确定提交吗?',
			function(r) {
				if (r) {
					$.ajax({
						url : '${pageContext.request.contextPath}/client/submitPaper',
						type : 'post',
						data : 'total='+total+"&answerTotal="+answerTotal+"&relationId="+relationId+"&type="+type+"&resultMessage="+resultMessage+"&extraMeassge="+extraMeassge,
						async : false, //默认为true 异步   
						success : function(msg) {
							if (msg.result == "success") {
								$.messager.alert('成功',"提交成功！",'info');
								parent.document.location.reload();
							} else {
								$.messager.alert('错误',"提交失败！",'error');
							}
						}
					});
				}
			});
	}
</script>
</head>
<body>
	<input type="text" id="total" value="${fn:length(paperDetails)}" style="display: none">
	<input type="text" id="relationId" value="${relationId}" style="display: none">
	<input type="text" id="type" value="${type}" style="display: none">
	<div style="position:absolute; top:0; right:0; z-index:1000;">
		<input type="button" value="提交" onclick="submit()">
	</div>
	<c:forEach items="${paperDetails }" var="paperDetail">
		${paperDetail.questionno }:${paperDetail.question }
		<p >
		&nbsp;&nbsp;<input type="radio" name="${paperDetail.questionno }" value="A">A:${paperDetail.optiona }&nbsp;&nbsp;
		<input type="radio" name="${paperDetail.questionno }" value="B">B:${paperDetail.optionb }&nbsp;&nbsp;
		<input type="radio" name="${paperDetail.questionno }" value="C">C:${paperDetail.optionc }&nbsp;&nbsp;
		<input type="radio" name="${paperDetail.questionno }" value="D">D:${paperDetail.optiond }&nbsp;&nbsp;
		<c:if test="${paperDetail.optione != null }">
			<input type="radio" name="${paperDetail.questionno }" value="E">E:${paperDetail.optione }&nbsp;&nbsp;
		</c:if>
		<c:if test="${paperDetail.optionf != null }">
			<input type="radio" name="${paperDetail.questionno }" value="F">F:${paperDetail.optionf }&nbsp;&nbsp;
		</c:if>
		<c:if test="${paperDetail.issuggest}">
			建议：<input type="text" id="${paperDetail.questionno }">
		</c:if>
		<p>
	</c:forEach>
</body>
</html>