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
	//String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/gmp/fileList/";
	String saveFolder="/home/user/orms/public_html/rms/admin/gmp/fileList/"; 	
		
	GmpManager manager=GmpManager.getInstance();	
 	String seq=request.getParameter("seq");
 	String fileNm=request.getParameter("filename"); 	 	 
 	   	
		 //**************폴더 삭제******************************// 파일 객체생성	
		/*	File  file = new File( saveFolder + fileNm );  
					if( file.exists() ){ file.delete(); }
		*/								
		 
		 	manager.delete(Integer.parseInt(seq)); 		
 %>
	<SCRIPT LANGUAGE="JavaScript">
	alert("削除しました");
	location.href="<%=urlPage%>rms/admin/gmp/listForm.jsp";
	</SCRIPT>			
 