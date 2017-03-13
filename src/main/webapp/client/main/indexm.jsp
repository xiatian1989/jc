<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>人事测评系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/amazeui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/TouchSlide.1.1.source.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/Marquee.js"></script>
<style type="text/css">
	ul, li {
		list-style: none;
	}
</style>
<script type="text/javascript">
	$(function(){	
		//导航切换
		$('.headname').click(function(){
			var $ul = $(this).next('ul');
			$('dd').find('ul').slideUp();		
			if($ul.is(':visible')){			
			   $ul.slideUp();
			}else{
				$ul.slideDown();
			}
		});
	})
	function notice(){
		alert("该对象已经被测评了，请选择其他人员测评！");
	}
	function notice1(){
		alert("测评还未开始，请等待测评开始！");
	}
	function viewUserResult(isSure,id,endviewtime){
		debugger;
		if(new Date(endviewtime).getTime()<new Date().getTime()) {
			alert("测评结果查看时间已经过去！");
			return false;
		}else{
			if(isSure) {
				window.open("${pageContext.request.contextPath}/client/resultSearchForSingle?id="+id,"_self");
			}else{
				alert("该次测评结果还没有发布，请等待测评结果发布！");
				return false;
			}
		}
	}
</script>
</head>
<body>
	<!--头部-->
    <div class="page-head-div">
      <div class="page-head">	
          <div class="page-head-title"><img src="../images/logo.png"></div>
      </div>
    </div>
    <!--九宫格div-->
	<div class="header">
	 	<c:forEach items="${planForRelations}" var="map" varStatus="status">
	        <dd>
				<div class="headname"><img src="${pageContext.request.contextPath}/images/leftico3.png">&nbsp;${map.key.plantitle}
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
			    	  <li class="active"><a href="javascript:void(0)" onclick="viewUserResult('${map.key.issure}','${map.key.id}','${map.key.endviewtime}')"><div class="ment10"><p class="newIcon am-icon-user">本人测评结果</p></div></a></li> 
			    	</ul>
			     </c:when>
			     <c:otherwise>
			     	<ul class="menuson">
				    	<c:forEach items="${map.value}" var="relation" varStatus="i" >
				       		<li class="active">
				       			<c:choose>
									<c:when test="${map.key.isstart}">
										<c:choose>
											<c:when test="${relation.isfinish}">
												<a href="javascript:void(0)" onclick="notice()">
											</c:when>
											<c:otherwise>
												<a href="${pageContext.request.contextPath}/client/paperTest?paperId=${relation.paperId}&relationId=${relation.id}&type=${relation.paper.type}" target="rightFrame">
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<a href="javascript:void(0)" onclick="notice1()">
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${relation.isperson}">
										<div class="ment${i.count}"><table class="mentable"><tr><td><p class="newIcon am-icon-user"></p>${relation.beTestedUser.truename}<br>
										<c:choose>
											<c:when test="${relation.isfinish}">
												(已测评)
											</c:when>
											<c:otherwise>
												(未测评)
											</c:otherwise>
										</c:choose>
										</td></tr></table></div>
									</c:when>
									 <c:otherwise>
										
										 <div class="ment1"><table class="mentable"><tr><td><p class="newIcon am-icon-user"></p>${relation.testedDepart.departName}<br>
											 <c:choose>
												<c:when test="${relation.isfinish}">
													(已测评)
												</c:when>
												<c:otherwise>
													(未测评)
												</c:otherwise>
											</c:choose>
										</td></tr></table></div>
									</c:otherwise>
								</c:choose>
				       		</a></li>
				        </c:forEach>        
			        </ul>
			     </c:otherwise>
		     </c:choose>
	        </dd>
	        
	      </c:forEach>
	</div>  
</body>
</html>