<%@ page contentType = "text/html; charset=utf8" %>

<%
String contextPath=request.getContextPath()+"/rms/";
session.invalidate();
%>

<script language=javascript>
	location.href="<%=contextPath%>home/home.jsp";
</script>
