﻿<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:forward page="/rms/template/tempAdminBunsho_schedule.jsp">
	<jsp:param name="CONTENTPAGE3"  value="/rms/admin/hinsithu/listForm_view.jsp" />
</jsp:forward>
