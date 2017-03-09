//兼容所有苹果手机设置目前最大比例
//$(window).bind('resize load', function() {
//  $("body").css("zoom", $(window).width() / 414);
//  $("body").css("display", "block");
//  $("body").css("zoom", $(window).width() / 414);
//});
//所有的js特效集合
function GetObj(objName){
	if(document.getElementById){
		return eval('document.getElementById("'+objName+'")')
	}else{
		return eval('document.all.'+objName)
	}
}

function AutoPlay(){ //自动滚动
	clearInterval(AutoPlayObj);
	AutoPlayObj = setInterval('ISL_GoDown();ISL_StopDown();',2000);//间隔时间
}

function ISL_GoUp(){ //上翻开始
	if(MoveLock) return;
	clearInterval(AutoPlayObj);
	MoveLock = true;
	MoveTimeObj = setInterval('ISL_ScrUp();',Speed);
}

function ISL_StopUp(){ //上翻停止
	clearInterval(MoveTimeObj);
	if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0){
		Comp = fill - (GetObj('ISL_Cont').scrollLeft % PageWidth);
		CompScr();
	}else{
		MoveLock = false;
	}
	AutoPlay();
}

function ISL_ScrUp(){ //上翻动作
	if(GetObj('ISL_Cont').scrollLeft <= 0){
		GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft + GetObj('List1').offsetWidth
	}
		GetObj('ISL_Cont').scrollLeft -= Space ;
}

function ISL_GoDown(){ //下翻
	clearInterval(MoveTimeObj);
	if(MoveLock) return;
	clearInterval(AutoPlayObj);
	MoveLock = true;
	ISL_ScrDown();
	MoveTimeObj = setInterval('ISL_ScrDown()',Speed);
}
function ISL_StopDown(){ //下翻停止
	clearInterval(MoveTimeObj);
	if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0 ){
		Comp = PageWidth - GetObj('ISL_Cont').scrollLeft % PageWidth + fill;
		CompScr();
	}else{
		MoveLock = false;
	}
	AutoPlay();
}

function ISL_ScrDown(){ //下翻动作
	if(GetObj('ISL_Cont').scrollLeft >= GetObj('List1').scrollWidth){
		GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft - GetObj('List1').scrollWidth;
	}
	GetObj('ISL_Cont').scrollLeft += Space ;
}

function CompScr(){
	var num;
	if(Comp == 0){
		MoveLock = false;return;
	}
	if(Comp < 0){ //上翻
		if(Comp < -Space){
			Comp += Space;
			num = Space;
		}else{
			num = -Comp;
			Comp = 0;
		}
		GetObj('ISL_Cont').scrollLeft -= num;
		setTimeout('CompScr()',Speed);
	}else{ //下翻
		if(Comp > Space){
			Comp -= Space;
			num = Space;
		}else{
			num = Comp;
			Comp = 0;
		}
		GetObj('ISL_Cont').scrollLeft += num;
		setTimeout('CompScr()',Speed);
	}
}

//购物车页面js---获取系统事件js
function current(){
	var d=new Date(),str=''; 
	str +=d.getFullYear()+'年'; //获取当前年份 
	str +=d.getMonth()+1+'月'; //获取当前月份（0——11） 
	str +=d.getDate()+'日'; 
	str +=d.getHours()+'时'; 
	str +=d.getMinutes()+'分'; 
	str +=d.getSeconds()+'秒'; 
	return "当前系统时间："+str; 
}
function current2(){ 
	var d=new Date(),str=''; 
	str +=d.getFullYear()+'年'; //获取当前年份 
	str +=d.getMonth()+1+'月'; //获取当前月份（0——11） 
	str +=d.getDate()+'日'; 
	str +=d.getHours()+'时'; 
	str +=d.getMinutes()+'分'; 
	str +=d.getSeconds()+'秒'; 
	return str; 
}

setInterval(function(){$(".nowTime").text(current)},1000);

$(function() {
	//字符串截取
	$("#data-news ul li a").each(function(i){
		if($("#data-news ul li a").eq(i).text().length > 20){
			$("#data-news ul li a").eq(i).text($("#data-news ul li a").eq(i).text().substring(0,20)+"...");
		}
	});
	//发布新闻  获取事件和传值事件
	$(".chat-msg-msg").on("click",function(){
		var msg_my = $(".msg-my").val();
		if(msg_my == ""){
			$(".alert-pay").show();
			$(".alert-gwc-text").html("新闻内容不得为空！");
			return false;
		}else{
			$(".alert-pay").show();
			$(".alert-gwc-text").html("您于&nbsp;<span class='nowTime2'></span>&nbsp;发布新闻成功！您发布的新闻会在页面最下面显示哦！(温馨提示：每天发布一篇新闻。)");
			$("span.nowTime2").text(current2);
		}
		//获取时间和输入框的值存入追加的文本中
		var d=new Date(),str=''; 
		str +=d.getFullYear()+"-"; //获取当前年份 
		str +=d.getMonth()+1+"-"; //获取当前月份（0——11） 
		str +=d.getDate();
		//链接也可以变成动态的
		$("#data-news ul").append("<li><span class='new-time'>"+str+"</span><a href='news_det.html'>"+msg_my+"</a></li>");
		$(this).css("background-color","#CCCCCC");
		$(this).unbind();
		$(".msg-my").val("");
	});
	
	
	//点击付款获取商铺信息事件  &传值
	$(".gwc-btn-pay").on("click",function(){
		$(".alert-pay").show();
		$("span.nowTime2").text(current2);
		var payId=$(this).parent().parent().find(".data-nums span.gwc-pay-id").text();
		var payName=$(this).parent().parent().find(".data-nums span.gwc-pay-name").text();
		var payMoney=$(this).parent().parent().find(".gwc-time p.time-p2 span").text();
		var payImg=$(this).parent().find("img:first").attr("src");
		$(".pay-id").text(payId);
		$(".pay-name").text(payName);
		$(".pay-money").text(payMoney);
		sessionStorage.setItem('payImg',payImg);
		sessionStorage.setItem('payId',payId);
		sessionStorage.setItem('payName',payName);
		sessionStorage.setItem('payMoney',payMoney);
		
	});
	$(".gwc-btn-on-pay").on("click",function(){
		window.location.href="pay.html"
	});
	//点击催单事件
	$(".gwc-cd").on("click",function(){
		$("span.nowTime2").text(current2);
		$(this).css("background-color","#cccccc");
		$(this).text("已催单");
		$(this).unbind();
		$(".alert-cd").show();
	});
	$(".alert-gwc-cd span").on("click",function(){
		$(".alert-cd").hide();
		$(".alert-qrsh").hide();
		$(".alert-pay").hide();
	})
	$(".alert-gwc-btn .gwc-btn-ok").on("click",function(){
		$(".alert-cd").hide();
	})
	
	//确认收货事件--确定和取消重铸
	$(".gwc-btn-qrsh").on("click",function(){
		$("span.nowTime2").text(current2);
		$(".alert-qrsh").show();
	})
	$(".alert-gwc .alert-gwc-btn .gwc-btn-no").on("click",function(){
		$(".alert-qrsh").hide();
		$(".alert-pay").hide();
	});
	$(".alert-gwc .alert-gwc-btn .gwc-btn-ok").on("click",function(){
		$(".alert-qrsh").hide();
		$(".gwc-btn-qrsh").css("background-color","#cccccc");
		$(".gwc-btn-qrsh").text("订单结束");
		$(".gwc-btn-qrsh").unbind();
	});
	//TAB切换
	$(".gwc-style").each(function(i) {
		$(".gwc-style").eq(i).click(function() {
			$(".gwc-style").removeClass("gwc-style-on");
			$(this).addClass("gwc-style-on");
			$(".data-style-gwc").hide();
			$(".data-style-gwc").eq(i).show();
		});
	});
});


