<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:forward page="/rms/template/tempMain.jsp">
	<jsp:param name="CONTENTPAGE3"  value="/tokubetu/member/writeFormView.jsp" />
</jsp:forward>
