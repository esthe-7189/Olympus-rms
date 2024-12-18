<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*"%>
<%
 String urlPage=request.getContextPath()+"/";	
 String id=(String)session.getAttribute("ID");
%>
<jsp:useBean id="category" class="mira.gmp.GmpBeen">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
			
	GmpManager manager=GmpManager.getInstance();	
 	String seq=request.getParameter("seq"); 
 	String dateKind=request.getParameter("dateKind"); 
 	String dateYn=request.getParameter("dateYn"); 	
 	String mseq=request.getParameter("mseq"); 
 	   	
	manager.dateView(Integer.parseInt(seq),Integer.parseInt(dateKind),Integer.parseInt(dateYn),Integer.parseInt(mseq)); 		
 %>
	<SCRIPT LANGUAGE="JavaScript">
	alert("処理しました");
	location.href="<%=urlPage%>rms/admin/admin_main.jsp";
	</SCRIPT>			
 	