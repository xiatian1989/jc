<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人事测评系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/amazeui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/Marquee.js"></script>
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
		var r=confirm("你确定提交吗?");
		if (r) {
			$.ajax({
				url : '${pageContext.request.contextPath}/client/submitPaper',
				type : 'post',
				data : 'total='+total+"&answerTotal="+answerTotal+"&relationId="+relationId+"&type="+type+"&resultMessage="+resultMessage+"&extraMeassge="+extraMeassge,
				async : false, //默认为true 异步   
				success : function(msg) {
					if (msg.result == "success") {
						alert("提交成功！");
						if(IsPC()) {
							parent.document.location.reload();
						}else{
							window.open("${pageContext.request.contextPath}/client/left","_self");
						}
					} else {
						alert("提交失败！");
					}
				}
			});
		}
	}
	function IsPC() {
	    var userAgentInfo = navigator.userAgent;
	    var Agents = ["Android", "iPhone",
	                "SymbianOS", "Windows Phone",
	                "iPad", "iPod"];
	    var flag = true;
	    for (var v = 0; v < Agents.length; v++) {
	        if (userAgentInfo.indexOf(Agents[v]) > 0) {
	            flag = false;
	            break;
	        }
	    }
	    return flag;
	}
</script>
</head>
<body>
	<input type="text" id="total" value="${fn:length(paperDetails)}" style="display: none">
	<input type="text" id="relationId" value="${relationId}" style="display: none">
	<input type="text" id="type" value="${type}" style="display: none">
	<div class="page-head-div">
	<div class="page-head">
		<div class="page-head-title"><img src="../images/logo.png"></div>
        <a href="javascript:history.go(-1);">
			<div class="page-head-right am-icon-mail-reply"></div>
		</a>
	</div>
	</div>
	<div class="chat">
		<div class="chat-div">
			<div class="item">
				<c:forEach items="${paperDetails }" var="paperDetail">
	                <div class="tit"><span>${paperDetail.questionno }.</span>${paperDetail.question }？</div>
	                <div class="item_con">
	                  <ul>
	                      <li>
	                          <input type="radio" name="${paperDetail.questionno }" id="" class="rad" value="A"><span>A</span>${paperDetail.optiona }
	                      </li>
	                      <li>
	                          <input type="radio" name="${paperDetail.questionno }" id="" class="rad" value="B"><span>B</span>${paperDetail.optionb }
	                      </li>
	                      <li>
	                          <input type="radio" name="${paperDetail.questionno }" id="" class="rad" value="C"><span>C</span>${paperDetail.optionc }
	                      </li>
	                      <li class="bn">
	                          <input type="radio" name="${paperDetail.questionno }" id="" class="rad" value="D"><span>D</span>${paperDetail.optiond }
	                      </li>
	                      <c:if test="${paperDetail.optione != '' }">
	                      		<input type="radio" name="${paperDetail.questionno }" id="" class="rad" value="E"><span>E</span>${paperDetail.optione }
	                      </c:if>
	                      <c:if test="${paperDetail.optione != '' }">
	                      		<input type="radio" name="${paperDetail.questionno }" id="" class="rad" value="E"><span>F</span>${paperDetail.optionf }
	                      </c:if>
	                      <c:if test="${paperDetail.issuggest}">
								建议：<input type="text" id="${paperDetail.questionno }">
						 </c:if>
	                  </ul>                         
	                </div>
	              </c:forEach>
              </div>
		</div>
	</div>
	<div class="chat-msg">
		<div class="chat-div-my">
			<input type="submit" class="btn-style-01" value="提交" onclick="submit()"/>
		</div>
	</div>
</body>
</html>