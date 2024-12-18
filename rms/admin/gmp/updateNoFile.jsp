<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>

<jsp:useBean id="pds" class="mira.gmp.GmpBeen" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/";
GmpManager mgr=GmpManager.getInstance();
mgr.update2(pds);

response.sendRedirect(urlPage+"rms/admin/gmp/listForm.jsp");
%>








