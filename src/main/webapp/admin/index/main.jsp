<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<STYLE type=text/css>
BODY {
	PADDING-RIGHT: 0px;
	PADDING-LEFT: 0px;
	PADDING-BOTTOM: 0px;
	MARGIN: 0px;
	PADDING-TOP: 0px;
	BACKGROUND-COLOR: #2a8dc8
}

BODY {
	FONT-SIZE: 11px;
	COLOR: #003366;
	FONT-FAMILY: Verdana
}

TD {
	FONT-SIZE: 11px;
	COLOR: #003366;
	FONT-FAMILY: Verdana
}

DIV {
	FONT-SIZE: 11px;
	COLOR: #003366;
	FONT-FAMILY: Verdana
}

P {
	FONT-SIZE: 11px;
	COLOR: #003366;
	FONT-FAMILY: Verdana
}

.mainMenu {
	FONT-WEIGHT: bold;
	FONT-SIZE: 14px;
	CURSOR: hand;
	COLOR: #000000
}

A.style2:link {
	PADDING-LEFT: 4px;
	COLOR: #0055bb;
	TEXT-DECORATION: none
}

A.style2:visited {
	PADDING-LEFT: 4px;
	COLOR: #0055bb;
	TEXT-DECORATION: none
}

A.style2:hover {
	PADDING-LEFT: 4px;
	COLOR: #ff0000;
	TEXT-DECORATION: none
}

A.active {
	PADDING-LEFT: 4px;
	COLOR: #ff0000;
	TEXT-DECORATION: none
}

.span {
	COLOR: #ff0000
}
</STYLE>
<LINK href="${pageContext.request.contextPath}/css/Style.css" type=text/css rel=stylesheet>
<LINK href="${pageContext.request.contextPath}/css/Manage.css" type=text/css
	rel=stylesheet>
<SCRIPT language=javascript src="${pageContext.request.contextPath}/js/FrameDiv.js"></SCRIPT>

<SCRIPT language=javascript src="${pageContext.request.contextPath}/js/Common.js"></SCRIPT>

<SCRIPT language=javascript>
        function selectallbox()
        {
            var list = document.getElementsByName('setlist');
            var listAllValue='';
             if(document.getElementById('checkAll').checked)
             {
                  for(var i=0;i<list.length;i++)
                  {
                    list[i].checked = true;
                    if(listAllValue=='')
                        listAllValue=list[i].value;
                    else
                        listAllValue = listAllValue + ',' + list[i].value;
                  }
                  document.getElementById('boxListValue').value=listAllValue;
             }
             else 
             {
                  for(var i=0;i<list.length;i++)
                  {
                    list[i].checked = false;
                  }
                  document.getElementById('boxListValue').value='';
             }
         } 
    </SCRIPT>

</head>
<body>
	<TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
		<TBODY>
			<TR>
				<TD width=15><IMG src="${pageContext.request.contextPath}/image/new_019.jpg"
					border=0></TD>
				<TD width="100%" background=${pageContext.request.contextPath}/image/new_020.jpg
					height=20></TD>
				<TD width=15><IMG src="${pageContext.request.contextPath}/image/new_021.jpg"
					border=0></TD>
			</TR>
		</TBODY>
	</TABLE>
	<TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
		<TBODY>
			<TR>
				<TD width=15 background=${pageContext.request.contextPath}/image/new_022.jpg><IMG
					src="${pageContext.request.contextPath}/image/new_022.jpg" border=0></TD>
				<TD vAlign=top width="100%" bgColor=#ffffff>
					<TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
						<TR>
							<TD class=manageHead>当前位置：管理首页 &gt; 管理中心 &gt; 渠道商广告申请</TD>
						</TR>
						<TR>
							<TD height=2></TD>
						</TR>
					</TABLE>
					<TABLE borderColor=#cccccc cellSpacing=0 cellPadding=0 width="100%"
						align=center border=0>
						<TBODY>
							<TR>
								<TD height=25>
									<TABLE cellSpacing=0 cellPadding=2 border=0>
										<TBODY>
											<TR>
												<TD>筛选数据：</TD>
												<TD><SELECT id=sClient name=sClient>
														<OPTION value="" selected>全部广告商</OPTION>
														<OPTION value=lenovo>罗宝网</OPTION>
														<OPTION value=lenovoshop>联想在线</OPTION>
														<OPTION value=letao>乐淘网</OPTION>
														<OPTION value=newsmy>纽曼网上商城</OPTION>
														<OPTION value=ouku>欧酷行货手机网</OPTION>
														<OPTION value=uiyi>佑一良品网</OPTION>
														<OPTION value=haier>海尔之星</OPTION>
														<OPTION value=hpbase>惠普基地</OPTION>
												</SELECT></TD>
												<TD><SELECT id=sFlag name=sFlag>
														<OPTION value=0 selected>全部状态</OPTION>
														<OPTION value=1>新申请</OPTION>
														<OPTION value=2>审核通过</OPTION>
														<OPTION value=3>审核未通过</OPTION>
												</SELECT></TD>
												<TD>渠道商</TD>
												<TD><INPUT class=textbox id=sChannel2
													style="WIDTH: 80px" maxLength=50 name=sChannel2></TD>
												<TD>起始日期</TD>
												<TD><INPUT class=textbox id=sStart2 style="WIDTH: 70px"
													name=sStart2></TD>
												<TD>截止日期</TD>
												<TD><INPUT class=textbox id=sEnd2 style="WIDTH: 70px"
													name=sEnd2></TD>
												<TD><INPUT class=button id=sButton2 type=submit
													value=" 筛选 " name=sButton2></TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
							</TR>
							<TR>
								<TD>
									<TABLE id=grid
										style="BORDER-TOP-WIDTH: 0px; FONT-WEIGHT: normal; BORDER-LEFT-WIDTH: 0px; BORDER-LEFT-COLOR: #cccccc; BORDER-BOTTOM-WIDTH: 0px; BORDER-BOTTOM-COLOR: #cccccc; WIDTH: 100%; BORDER-TOP-COLOR: #cccccc; FONT-STYLE: normal; BACKGROUND-COLOR: #cccccc; BORDER-RIGHT-WIDTH: 0px; TEXT-DECORATION: none; BORDER-RIGHT-COLOR: #cccccc"
										cellSpacing=1 cellPadding=2 rules=all border=0>
										<TBODY>
											<TR
												style="FONT-WEIGHT: bold; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
												<TD>用户名</TD>
												<TD>网站名称</TD>
												<TD>状态</TD>
												<TD>广告商</TD>
												<TD>申请时间</TD>
												<TD>详细</TD>
												<TD>操作</TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>longlikai1</TD>
												<TD><A href="#" target=_blank>金币网</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>惠普基地</TD>
												<TD>2008-12-18 15:48:36</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=65 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>longlikai1</TD>
												<TD><A href="#" target=_blank>金币网</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>纽曼网上商城</TD>
												<TD>2008-12-18 15:28:41</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=64 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>dama2003</TD>
												<TD><A href="#" target=_blank>网狐科技</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>联想在线</TD>
												<TD>2008-12-17 19:09:16</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=62 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>liyiyan</TD>
												<TD><A href="#" target=_blank>网龙公司VIP商城</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>惠普基地</TD>
												<TD>2008-12-17 12:05:29</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=60 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>liyiyan</TD>
												<TD><A href="#" target=_blank>网龙公司VIP商城</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>海尔之星</TD>
												<TD>2008-12-17 12:05:24</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=59 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>liyiyan</TD>
												<TD><A href="#" target=_blank>网龙公司VIP商城</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>纽曼网上商城</TD>
												<TD>2008-12-17 12:05:14</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=58 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>dama2003</TD>
												<TD><A href="#" target=_blank>网狐科技</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>纽曼网上商城</TD>
												<TD>2008-11-28 16:02:21</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=55 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>weiyi11</TD>
												<TD><A href="#" target=_blank>唯一</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>罗宝网</TD>
												<TD>2008-11-10 12:44:27</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=51 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>weiyi11</TD>
												<TD><A href="#" target=_blank>唯一</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>欧酷行货手机网</TD>
												<TD>2008-11-10 12:44:16</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=50 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>eqifa</TD>
												<TD><A href="#" target=_blank>亿起发</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>佑一良品网</TD>
												<TD>2008-11-5 9:44:09</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=47 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>dama2003</TD>
												<TD><A href="#" target=_blank>网狐科技</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>欧酷行货手机网</TD>
												<TD>2008-10-30 16:58:43</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=45 name=setlist></TD>
											</TR>

											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>chanet</TD>
												<TD><A href="#" target=_blank>CHANet成果网</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>罗宝网</TD>
												<TD>2008-9-17 16:38:28</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=38 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>chanet</TD>
												<TD><A href="#" target=_blank>CHANet成果网</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>海尔之星</TD>
												<TD>2008-9-17 16:38:08</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=37 name=setlist></TD>
											</TR>
											<TR
												style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
												<TD>lanhen</TD>
												<TD><A href="http://www.mycodes.net/" target=_blank>源码之家</A></TD>
												<TD><IMG alt=申请通过 src="${pageContext.request.contextPath}/image/start.gif"
													border=0></TD>
												<TD>罗宝网</TD>
												<TD>2008-9-4 19:51:32</TD>
												<TD><A href="#">查看</A></TD>
												<TD><INPUT id=setlist
													onClick="check(this,'boxListValue');" type=checkbox
													value=34 name=setlist></TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
							</TR>
							<TR>
								<TD align=right height=25><INPUT id=boxListValue
									type=hidden name=boxListValue> <INPUT class=button
									id=button1 type=submit value=批量审核通过 name=button1> <INPUT
									class=button id=button2 type=submit value=批量拒绝申请 name=button2>
									<INPUT onclick=selectallbox(); type=checkbox name=checkAll>
									全选&nbsp;&nbsp;&nbsp;</TD>
							</TR>
							<TR>
								<TD><SPAN id=pagelink>
										<DIV
											style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right">
											[<B>84</B>]条记录 [6]页 当前是[46-60]条 [<A href="#">前一页</A>] <A
												class="" href="#">1</A> <A class="" href="#">2</A> <A
												class="" href="#">3</A> <B>4</B> <A class="" href="#">5</A>
											<A class="" href="#">6</A> [<A class="" href="#">后一页</A>] <SELECT><OPTION
													value=1>第1页</OPTION>
												<OPTION value=2>第2页</OPTION>
												<OPTION value=3>第3页</OPTION>
												<OPTION value=4 selected>第4页</OPTION>
												<OPTION value=5>第5页</OPTION>
												<OPTION value=6>第6页</OPTION></SELECT>
										</DIV>
								</SPAN></TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
				<TD width=15 background=${pageContext.request.contextPath}/image/new_023.jpg><IMG
					src="${pageContext.request.contextPath}/image/new_023.jpg" border=0></TD>
			</TR>
		</TBODY>
	</TABLE>
	<TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
		<TBODY>
			<TR>
				<TD width=15><IMG src="${pageContext.request.contextPath}/image/new_024.jpg"
					border=0></TD>
				<TD align=middle width="100%"
					background=${pageContext.request.contextPath}/image/new_025.jpg height=15></TD>
				<TD width=15><IMG src="${pageContext.request.contextPath}/image/new_026.jpg"
					border=0></TD>
			</TR>
		</TBODY>
	</TABLE>
</body>

</html>