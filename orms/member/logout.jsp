<%@ page contentType = "text/html; charset=utf8" %>
<%@ page errorPage="/orms/error/error.jsp"%>

<%
String contextPath=request.getContextPath()+"/orms/";
session.invalidate();
%>

<script language=javascript>
	location.href="<%=contextPath%>home/home.jsp";
</script>
