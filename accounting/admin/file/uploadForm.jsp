<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/rms/error/error_common.jsp"%>	
	

<jsp:forward page="/rms/template/tempAdminAcc.jsp">    
	<jsp:param name="CONTENTPAGE3" value="/accounting/admin/file/uploadForm_view.jsp" />		
</jsp:forward>