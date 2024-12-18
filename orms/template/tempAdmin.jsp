<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/orms/hoan-jsp"; %>
<%@ include file = "/orms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/orms/hoan-jsp/castle_referee.jsp" %>
<%
String contentPage1 = request.getParameter("CSSPAGE1");	
String urlPage=request.getContextPath()+"/orms/";	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Olympus RMS</title>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="title" content="olympus-rms.com" />
<meta name="author" content="www.ableu.com" />
<meta name="keywords" content="OLYMPUS RMS, BIO, collagen, chondron, cosmetic" />
<link href="<%=urlPage%>common/admin/css/style.css" rel="stylesheet" type="text/css">
<Link rel="shortcut icon"  href="<%=urlPage%>common/favicon.ico" />
<script language="JavaScript" src="<%=urlPage%>common/admin/js/common.js"></script>
<script language="javascript" src="<%=urlPage%>common/admin/js/Commonjs.js"></script>
<script type="text/javascript" src="<%=urlPage%>hoan-jsp/castle.js"></script>

<body  leftmargin="0"  topmargin="0"  marginwidth="0"  marginheight="0"  border="0"  >
<table border="0" cellpadding="0" cellspacing="0" width="940"  align="center" >	
	<tr>
		<td valign="top" width="100%" style="padding: 10 0 0 0"><jsp:include page="/orms/module/topAdmin.jsp" flush="false"/></td>
	</tr>		
	<tr>		
		<td valign="top" align="center" width="100%"><jsp:include page="<%= contentPage1%>" flush="false"/></td>
	</tr>			
</table>		
</body>
</html>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

