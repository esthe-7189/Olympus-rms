<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:forward page="/rms/template/tempAdminAcc.jsp">
	<jsp:param name="CONTENTPAGE3"  value="/accounting/admin/member/updateFormView.jsp" />
</jsp:forward>
