<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>人事测评管理系统</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<style type="text/css">
BODY {
	FONT-SIZE: 12px;
	COLOR: #ffffff;
	FONT-FAMILY: 宋体
}

TD {
	FONT-SIZE: 12px;
	COLOR: #ffffff;
	FONT-FAMILY: 宋体
}
</style>
<script type="text/javascript">
	function refreshCode(obj){
		var day = new Date();
		var t = day.getTime();
		obj.src="/jc/code?t="+t;
	}
	
	function submitBefore(){
		var submitFlag = true;
		
		$("#RequiredFieldtxtName").hide();
		$("#RequiredFieldtxtPwd").hide();
		$("#RequiredFieldtxtCode").hide();
		$("#message").html("");
		
		if($("#txtName").val() ==""){
			$("#RequiredFieldtxtName").show();
			submitFlag =  false;
		}
		if($("#txtPwd").val() ==""){
			$("#RequiredFieldtxtPwd").show();
			submitFlag =  false;
		}
		if($("#txtcode").val() =="") {
			$("#RequiredFieldtxtCode").show();
			submitFlag =  false;
		}
		
		return submitFlag;
	}
	
</script>
</head>
<body>
	<DIV>&nbsp;&nbsp;</DIV>
	<DIV>
		<TABLE cellSpacing=0 cellPadding=0 width=900 align=center border=0>
			<TBODY>
				<TR>
					<TD style="HEIGHT: 105px"><IMG src="${pageContext.request.contextPath}/image/login.jpg"
						border=0></TD>
				</TR>
				<TR>
					<TD background="${pageContext.request.contextPath}/image/login_2.jpg" height=300>
						<TABLE height=300 cellPadding=0 width=900 border=0>
							<TBODY>
								<TR>
									<TD colSpan=2 height=35></TD>
								</TR>
								<TR>
									<TD width=360></TD>
									<TD>
										<form action="${pageContext.request.contextPath}/admin/adminLogin" method="post" id="form1" onsubmit="return submitBefore()">
											<TABLE cellSpacing=0 cellPadding=2 border=0>
												<TBODY>
														<TR>
															<TD style="HEIGHT: 28px" width=80>登 录 名：</TD>
															<TD style="HEIGHT: 28px" width=150><INPUT id=txtName
																style="WIDTH: 130px" name=txtName></TD>
															<TD style="HEIGHT: 28px" width=370><SPAN
																id=RequiredFieldtxtName
																style="FONT-WEIGHT: bold; display: none; COLOR: red">请输入登录名</SPAN></TD>
														</TR>
														<TR>
															<TD style="HEIGHT: 28px">登录密码：</TD>
															<TD style="HEIGHT: 28px"><INPUT id=txtPwd
																style="WIDTH: 130px" type=password name=txtPwd></TD>
															<TD style="HEIGHT: 28px"><SPAN
																id=RequiredFieldtxtPwd
																style="FONT-WEIGHT: bold; display: none; COLOR: red">请输入密码</SPAN></TD>
														</TR>
														<TR>
															<TD style="HEIGHT: 28px">验证码：</TD>
															<TD style="HEIGHT: 28px"><INPUT id=txtcode
																style="WIDTH: 130px" name=txtcode ></TD>
															<TD style="HEIGHT: 28px"><img src="${pageContext.request.contextPath}/admin/code" onclick="refreshCode(this)"/><SPAN
																id=RequiredFieldtxtCode
																style="FONT-WEIGHT: bold; display: none; COLOR: red;">&nbsp;请输入验证码</SPAN></TD>
														</TR>
														<TR>
															<TD style="HEIGHT: 18px" colspan="2" align="center"><SPAN
																id=message
																style="FONT-WEIGHT: bold; COLOR: red" >${message}</SPAN></TD>
															<TD style="HEIGHT: 28px"></TD>
														</TR>
														<TR>
															<TD></TD>
															<TD><INPUT id=btn
																style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px"
																type=image src="${pageContext.request.contextPath}/image/login_button.gif" name=btn>
															</TD>
														</TR>
												</TBODY>
											</TABLE>
										</form>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD><IMG src="${pageContext.request.contextPath}/image/login_3.jpg" border=0></TD>
				</TR>
			</TBODY>
		</TABLE>
	</DIV>
</body>
</html>