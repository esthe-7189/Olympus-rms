<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/rms/error/error_view.jsp"%>	
<%
request.setCharacterEncoding("utf-8");

%>

<jsp:forward page="/rms/template/tempAdminBunsho.jsp">		    
    <jsp:param name="CONTENTPAGE3" value="/rms/admin/seizo/bunshoUploadForm_view.jsp" />	
</jsp:forward>