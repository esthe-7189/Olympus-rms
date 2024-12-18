<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.form.FormBeen" %>
<%@ page import = "mira.form.FormManager" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*"%>
<%
 String urlPage=request.getContextPath()+"/";	
 String id=(String)session.getAttribute("ID");
%>
<jsp:useBean id="category" class="mira.form.FormBeen">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
	//String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/form/fileList/";
	String saveFolder="/home/user/orms/public_html/rms/admin/form/fileList/"; 	
		
	FormManager manager=FormManager.getInstance();	
 	String seq=request.getParameter("seq");
 	String fileNm=request.getParameter("filenm"); 	 	 
 	   	
		 //**************폴더 삭제******************************	
			File  file = new File( saveFolder + fileNm );  // 파일 객체생성
					if( file.exists() ){ file.delete(); }
										
		 	manager.delete(Integer.parseInt(seq)); 		
 %>
	<SCRIPT LANGUAGE="JavaScript">
	alert("削除しました");
	location.href="<%=urlPage%>rms/admin/form/listForm.jsp";
	</SCRIPT>			
 