<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
	
<jsp:forward page="/rms/template/tempAdminBunsho_schedule.jsp">
	<jsp:param name="CONTENTPAGE3"  value="/rms/admin/order/writeForm_view.jsp" />	
</jsp:forward>
	