<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import = "mira.shokudata.FileMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*"%>
<%
 String urlPage=request.getContextPath()+"/";	
 String id=(String)session.getAttribute("ID");
%>
<jsp:useBean id="category" class="mira.shokudata.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
	//String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/shokuData/fileList/";
	String saveFolder="/home/user/orms/public_html/rms/admin/shokuData/fileList/"; 	
		
	FileMgr manager=FileMgr.getInstance();	
 	String seq=request.getParameter("seq");
 	String pg=request.getParameter("pg");
 	String fileNm=request.getParameter("fileNm");
 	String groupId=request.getParameter("groupId");
 	 int level=2;  //일반직원용
 	 
 	 	 	
  	
		 //**************폴더 삭제******************************	
	/*		File  file = new File( saveFolder + fileNm );  // 파일 객체생성
					if( file.exists() ){ 	 file.delete(); 	}
	*/
										
		 	manager.delete(Integer.parseInt(seq));
 		//	manager.deleteByCate(Integer.parseInt(seq),level,Integer.parseInt(groupId));	  //DB: shoku_file 테이블
 %>
	<SCRIPT LANGUAGE="JavaScript">
	alert("削除しました");
	location.href="<%=urlPage%>rms/admin/shokuData/listForm.jsp?pg=<%=pg%>";
	</SCRIPT>			
 
 
 
 
 
 
<%
/*폴더내 다중파일 삭제
	List listFiles=manager2.selectListFileDel(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));
	Iterator iter=listFiles.iterator();
	while(iter.hasNext()){
		Category cate=(Category)iter.next();		
		File  file = new File( saveFolder + cate.getFile() );  // 파일 객체생성
			if( file.exists() ){
				 file.delete();
			}
	}
	Iterator iter2=listFiles.iterator();
	while(iter2.hasNext()){
		Category cate2=(Category)iter2.next();
		
		out.print(cate2.getFile()+"<br>");
	}

manager2.deleteByCate(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));	  //DB: shoku_file 테이블
 */


%>
	