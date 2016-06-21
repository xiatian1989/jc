<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>人事测评管理系统</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0
}

ul, li {
	list-style: none;
}

a:link, a:visited {
	text-decoration: none;
}

.list {
	width: 210px;
	border-bottom: solid 1px #316a91;
	margin: 0px auto 0 auto;
}

.list ul li {
	background-color: #467ca2;
	border: solid 1px #316a91;
	border-bottom: 0;
}

.list ul li a {
	padding-left: 10px;
	color: #fff;
	font-size: 12px;
	display: block;
	font-weight: bold;
	height: 36px;
	line-height: 36px;
	position: relative;
}

.list ul li .inactive {
	background: url(${pageContext.request.contextPath}/image/off.png)
		no-repeat 184px center;
}

.list ul li .inactives {
	background: url(${pageContext.request.contextPath}/image/on.png)
		no-repeat 184px center;
}

.list ul li ul {
	display: none;
}

.list ul li ul li {
	border-left: 0;
	border-right: 0;
	background-color: #6196bb;
	border-color: #467ca2;
}

.list ul li ul li ul {
	display: none;
}

.list ul li ul li a {
	padding-left: 20px;
}

.list ul li ul li ul li {
	background-color: #d6e6f1;
	border-color: #6196bb;
}

.last {
	background-color: #d6e6f1;
	border-color: #6196bb;
}

.list ul li ul li ul li a {
	color: #316a91;
	padding-left: 30px;
}

html, body {
	width: 99%;
	height: 99%;
	margin: 0 auto;
	padding: 0px;
	font-size: 12px;
	font-family: "宋体", "微软雅黑";
	over-flow:hidden;
}

#top {
	clear: both;
	height: 8%;
	background: red;
}

#left {
	float: left;
	width: 20%;
	background: blue;
	height: 100%;
}

#right {
	float: right;
	background: green;
	width: 80%;
	height: 100%;
}

#content {
	height: 84%;
}

#footer {
	clear: both;
	height: 8%;
	background: red;
}

#log {
	text-indent: 2em;
	padding-top: 12px;
}

#logout {
	padding-top: 12px;
	margin-right: 2em;
	float: right;
}

span {
	display: inline-block;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.inactive').click(function(){
		if($(this).siblings('ul').css('display')=='none'){
			$(this).parent('li').siblings('li').removeClass('inactives');
			$(this).addClass('inactives');
			$(this).siblings('ul').slideDown(100).children('li');
			if($(this).parents('li').siblings('li').children('ul').css('display')=='block'){
				$(this).parents('li').siblings('li').children('ul').parent('li').children('a').removeClass('inactives');
				$(this).parents('li').siblings('li').children('ul').slideUp(100);

			}
		}else{
			//控制自身变成+号
			$(this).removeClass('inactives');
			//控制自身菜单下子菜单隐藏
			$(this).siblings('ul').slideUp(100);
			//控制自身子菜单变成+号
			$(this).siblings('ul').children('li').children('ul').parent('li').children('a').addClass('inactives');
			//控制自身菜单下子菜单隐藏
			$(this).siblings('ul').children('li').children('ul').slideUp(100);

			//控制同级菜单只保持一个是展开的（-号显示）
			$(this).siblings('ul').children('li').children('a').removeClass('inactives');
		}
	})
});
</script>
</head>
<body>
	<div id="top">
		<span id="log">人事测评管理系统管理中心</span>
		<span id="logout">安全退出</span>
	</div>
	<div id="content">
		<div id="left" class="list">
				<ul class="yiji">
		<li><a href="#">中国美协章程</a></li>
		<li><a href="#" class="inactive">团体会员</a>
			<ul style="display: none">
				<li><a href="#" class="inactive active">美协机关</a>
					<ul>
						<li><a href="#">办公室</a></li>
						<li><a href="#">人事处</a></li>
						<li><a href="#">组联部</a></li>
						<li><a href="#">外联部</a></li>
						<li><a href="#">研究部</a></li>
						<li><a href="#">维权办</a></li>
					</ul>
				</li> 
				<li class="last"><a href="#">《美术》杂志社</a></li> 
			</ul>
		</li>
		<li><a href="#" class="inactive">组织机构</a>
			<ul style="display: none">
				<li><a href="#" class="inactive active">美协机关</a>
					<ul>
						<li><a href="#">办公室</a></li>
						<li><a href="#">人事处</a></li>
						<li><a href="#">组联部</a></li>
						<li><a href="#">外联部</a></li>
						<li><a href="#">研究部</a></li>
						<li><a href="#">维权办</a></li>
					</ul>
				</li> 
				<li><a href="#" class="inactive active">中国文联美术艺术中心</a>   
					<ul>
						<li><a href="#">综合部</a></li>
						<li><a href="#">大型活动部</a></li>
						<li><a href="#">展览部</a></li>
						<li><a href="#">艺委会工作部</a></li>
						<li><a href="#">信息资源部</a></li>
						<li><a href="#">双年展办公室</a></li>
					</ul>
				</li> 
				<li class="last"><a href="#">《美术》杂志社</a></li> 
			</ul>
		</li>
	</ul>
		</div>
		<div id="right">
			<iframe src="${pageContext.request.contextPath}/admin/index/main.jsp" scrolling="auto" width="100%"  height="100%" style="border: 0" name="mainContent"></iframe>
		</div>
	</div>
	<div id="footer">
	</div>
</body>
</html>