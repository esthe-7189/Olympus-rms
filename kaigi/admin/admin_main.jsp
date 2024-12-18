<%@ page contentType = "text/html; charset=utf8" %>
<%
request.setCharacterEncoding("utf8");
%>


<jsp:forward page="/rms/template/tempAdminKaigi.jsp">
	<jsp:param name="CONTENTPAGE3"  value="/kaigi/admin/admin_mainView.jsp" />
</jsp:forward>