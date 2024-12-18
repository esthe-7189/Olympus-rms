<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
	
<jsp:useBean id="pds" class="mira.gmp.GmpBeen" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>	
	
	
<%
String urlPage=request.getContextPath()+"/";
String ip_add=(String)request.getRemoteAddr();

pds.setRegister(new Timestamp(System.currentTimeMillis()));
GmpManager mgr=GmpManager.getInstance();	
mgr.insertBoard(pds);

response.sendRedirect(urlPage+"rms/admin/gmp/listForm.jsp");
%>

