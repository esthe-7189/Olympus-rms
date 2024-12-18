<%  String castleJSPVersionBaseDir = "/orms/hoan-jsp"; %>
<%@ include file = "/orms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/orms/hoan-jsp/castle_referee.jsp" %>
<%
	String urlPage=request.getContextPath()+"/orms/";	
%>

<%@ page contentType = "text/html; charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type=text/javascript src=<%=urlPage%>hoan-jsp/castle.js></script>
  	  
<script>
	a = "안녕>고급 정책 부분 테스트";
	CastleBrowserDetect.init();
	document.write(a + ": " + CastleCodeConvert.utf8ToCp949(a));
</script>
  </head>
  <body>
<b>고급 정책 부분 테스트
<hr>
<%
	String strName = request.getParameter("name");
	String strID = request.getParameter("id");
	String strPassword = request.getParameter("password");

	out.println("name = " + strName + "<br>");
	out.println("id = " + strID + "<br>");
	out.println("password = " + strPassword + "<br>");
%>
<hr>
<table>
	<form action=test.jsp method=post >
	<tr>
		<td>name:</td>
		<td><input type=text name=name size=20></td>
	</tr>
	<tr>
		<td>id:</td>
		<td><input type=text name=id size=20></td>
	</tr>
	<tr>
		<td>password:</td>
		<td><input type=password name=password size=20></td>
	</tr>
	<tr>
		<td></td>
		<td><input type=submit value=SUBMIT>
	</tr>
	</form>
</table>
</body>
</html>
