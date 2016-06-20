<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>人事测评管理系统</title>
<script type="text/javascript" src="../../js/jquery-1.12.3.min.js"></script>
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
	
	function submitForm(){
		$("#RequiredFieldtxtName").hide();
		$("#RequiredFieldtxtPwd").hide();
		
		if($("#txtName").val() ==""){
			$("#RequiredFieldtxtName").show();
			$("#txtName").focus();
			return;
		}
		if($("#txtPwd").val() ==""){
			$("#RequiredFieldtxtPwd").show();
			$("#txtPwd").focus();
			return;
		}
		if($("#txtcode").val() =="") {
			alert("请输入验证码!");
			$("#txtcode").focus();
			return;
		}
		
		$("#form1").submit();
	}
	
</script>
</head>
<body>
	<DIV>&nbsp;&nbsp;</DIV>
	<DIV>
		<TABLE cellSpacing=0 cellPadding=0 width=900 align=center border=0>
			<TBODY>
				<TR>
					<TD style="HEIGHT: 105px"><IMG src="../../image/login.jpg"
						border=0></TD>
				</TR>
				<TR>
					<TD background=../../image/login_2.jpg height=300>
						<TABLE height=300 cellPadding=0 width=900 border=0>
							<TBODY>
								<TR>
									<TD colSpan=2 height=35></TD>
								</TR>
								<TR>
									<TD width=360></TD>
									<TD>
										<form action="/jc/adminLogin" method="post" id="form1">
											<TABLE cellSpacing=0 cellPadding=2 border=0>
												<TBODY>
														<TR>
															<TD style="HEIGHT: 28px" width=80>登 录 名：</TD>
															<TD style="HEIGHT: 28px" width=150><INPUT id=txtName
																style="WIDTH: 130px" name=txtName></TD>
															<TD style="HEIGHT: 28px" width=370><SPAN
																id=RequiredFieldtxtName
																style="FONT-WEIGHT: bold; VISIBILITY: hidden; COLOR: white">请输入登录名</SPAN></TD>
														</TR>
														<TR>
															<TD style="HEIGHT: 28px">登录密码：</TD>
															<TD style="HEIGHT: 28px"><INPUT id=txtPwd
																style="WIDTH: 130px" type=password name=txtPwd></TD>
															<TD style="HEIGHT: 28px"><SPAN
																id=RequiredFieldtxtPwd
																style="FONT-WEIGHT: bold; VISIBILITY: hidden; COLOR: white">请输入密码</SPAN></TD>
														</TR>
														<TR>
															<TD style="HEIGHT: 28px">验证码：</TD>
															<TD style="HEIGHT: 28px"><INPUT id=txtcode
																style="WIDTH: 130px" name=txtcode ></TD>
															<TD style="HEIGHT: 28px"><img src="/jc/code" onclick="refreshCode(this)"/></TD>
														</TR>
														<TR>
															<TD style="HEIGHT: 18px"></TD>
															<TD style="HEIGHT: 18px"></TD>
															<TD style="HEIGHT: 18px"></TD>
														</TR>
														<TR>
															<TD></TD>
															<TD><INPUT id=btn
																style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px"
																onclick='submitForm()'
																type=image src="../../image/login_button.gif" name=btn>
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
					<TD><IMG src="../../image/login_3.jpg" border=0></TD>
				</TR>
			</TBODY>
		</TABLE>
	</DIV>
</body>
</html>