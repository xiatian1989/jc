<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>人事测评管理系统 </title>
</head>
<body>
	<FORM id=form1 name=form1 action=YHTop.aspx method=post>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TBODY>
				<TR>
					<TD width=10><IMG src="${pageContext.request.contextPath}/image/new_001.jpg" border=0></TD>
					<TD background=${pageContext.request.contextPath}image/new_002.jpg><FONT size=4><B>人事测评管理系统
								管理中心</B></FONT></TD>
					<TD background=image/new_002.jpg>
						<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
							<TBODY>
								<TR>
									<TD align=right height=35>
									</TD>
								</TR>
								<TR>
									<TD height=35>
									<span id="role">
										<c:if test="${Admin.level==1 }">
											超级管理员
										</c:if>
										<c:if test="${Admin.level==0 }">
											管理员
										</c:if>
									</span>
									<A href="#" target=_top><FONT color=red><B>安全退出</B></FONT></A>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD width=10><IMG src="${pageContext.request.contextPath}/image/new_003.jpg" border=0></TD>
				</TR>
			</TBODY>
		</TABLE>
	</FORM>
</body>

</html>