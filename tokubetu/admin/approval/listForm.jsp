<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:forward page="/rms/template/tempAdminToku.jsp">
	<jsp:param name="CONTENTPAGE3"  value="/tokubetu/admin/approval/listForm_view.jsp" />
</jsp:forward>
