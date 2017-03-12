<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>

<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
})
	function notice(){
		alert("该对象已经被测评了，请选择其他人员测评！");
		window.open("${pageContext.request.contextPath}/client/planStatus","rightFrame");
	}
	function notice1(){
		alert("测评还未开始，请等待测评开始！");
		window.open("${pageContext.request.contextPath}/client/planStatus","rightFrame");
	}
	function viewUserResult(isSure,id,endviewtime){
		debugger;
		if(new Date(endviewtime).getTime()<new Date().getTime()) {
			alert("测评结果查看时间已经过去！");
			return false;
		}else{
			if(isSure) {
				window.open("${pageContext.request.contextPath}/client/resultSearchForSingle?id="+id,"rightFrame");
			}else{
				alert("该次测评结果还没有发布，请等待测评结果发布！");
				return false;
			}
		}
	}
</script>

</head>
<body style="background:#f0f9fd;">
	<div class="lefttop"><span></span>导航</div>
    
    <dl class="leftmenu">
    <c:forEach items="${planForRelations}" var="map" varStatus="status">
    	<dd>
		    <div class="title">
		    	<span><img src="${pageContext.request.contextPath}/images/leftico01.png" /></span>${map.key.plantitle}
		    	 <c:choose>
						<c:when test="${map.key.isfinish}">
							(已完成)
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${map.key.isstart}">
									(进行中)
								</c:when>
								<c:otherwise>
									(未开始)
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
		    </div>
		    <c:choose>
			    <c:when test="${map.key.isfinish}">
			    	<ul class="menuson">
			    	  <li class="active"><cite></cite><a href="javascript:void(0)" onclick="viewUserResult('${map.key.issure}','${map.key.id}','${map.key.endviewtime}')">本人测评结果</a><i></i></li>
			    	</ul>
			     </c:when>
			     <c:otherwise>
			     	<ul class="menuson">
				    	<c:forEach items="${map.value}" var="relation" >
				       		<li class="active"><cite></cite>
				       			<c:choose>
									<c:when test="${map.key.isstart}">
										<c:choose>
											<c:when test="${relation.isfinish}">
												<a href="javascript:void(0)" onclick="notice()">
											</c:when>
											<c:otherwise>
												<a href="${pageContext.request.contextPath}/client/paperTest?paperId=${relation.paperId}&relationId=${relation.id}&type=${relation.paper.type}" target="rightFrame">
											</c:otherwise>
										</c:choose>+
									</c:when>
									<c:otherwise>
										<a href="javascript:void(0)" onclick="notice1()">
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
				       		</a><i></i></li>
				        </c:forEach>        
			        </ul>
			     </c:otherwise>
		     </c:choose>
	    </dd>
	</c:forEach>
    </dl>
    
</body>
</html>