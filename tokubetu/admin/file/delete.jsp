<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.tokubetu.AccBean" %>
<%@ page import="mira.tokubetu.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*"%>

<jsp:useBean id="pds" class="mira.tokubetu.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
String urlPage=request.getContextPath()+"/";
String seq = request.getParameter("seq");	
String fileNm=request.getParameter("filename");

String saveFolder="/home/user/orms/public_html/tokubetu/admin/file/fileList/"; 	
//String saveFolder="C:\\dev\\tomcat5\\webapps\\orms\\tokubetu/admin/file/fileList/";

   AccMgr mgr = AccMgr.getInstance();   
   //**************폴더 삭제******************************	
	File  file = new File( saveFolder + fileNm );  // 파일 객체생성
		if( file.exists() ){ 	 file.delete(); 	}
  //******************************************************
     mgr.delete(Integer.parseInt(seq));
  
     
%>

<script language="JavaScript">
alert("ファイルが削除されました");
location.href = "<%=urlPage%>tokubetu/admin/file/listForm.jsp";
</script>
