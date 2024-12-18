<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.*"%>


<%
String urlPage=request.getContextPath()+"/";
String ip_add=(String)request.getRemoteAddr();

AccMgr mgr=AccMgr.getInstance();

/*
   C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp
   C:\\dev\\tomcat5\\webapps\\orms\\rms/admin/sop/fileList
   /home/user/orms/public_html/rms/admin/sop/fileList
   //파라미터를 출력함
   while(params.hasMoreElements()){ //전송한 파일이 있으면
      String name = (String)params.nextElement(); //input tag 이름
      String value = multi.getParameter(name);    //input tag 값  
      out.println(name + " = " + value +"<br>");
   }

*/

	//String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/sop/fileList";
	String saveFolder="/home/user/orms/public_html/rms/admin/sop/fileList"; 
int maxSize = 100*1024*1024;//100M
String fileName="";
String originFileName = "";

String cate_nm="";
String title="";
String content="";
String view_yn="";
String nm="";
String hit_cnt="";
String seq_tab="";
int item_seq=0;
String fileSize="";

ArrayList saveFiles = new ArrayList(); //저장된 파일명 목록
ArrayList origFiles = new ArrayList(); //저장되기전 파일명 목록
ArrayList saveTitle = new ArrayList(); //저장되기전 파일명 목록

try{ 	
 //객체 생성시 파일 업로드 발생
 MultipartRequest multi = new MultipartRequest( request,saveFolder,maxSize,"utf-8",new DefaultFileRenamePolicy());
 
	 cate_nm= multi.getParameter("cate_nm");
	 title= multi.getParameter("title");
	 content= multi.getParameter("content");
	 view_yn= multi.getParameter("view_yn");	
	 nm= multi.getParameter("name");
	 hit_cnt= multi.getParameter("hit_cnt");
	 seq_tab= multi.getParameter("seq_tab");
 
 
 //올려진 파일명 산출 
 
 Enumeration files = multi.getFileNames();
 while(files.hasMoreElements()){
    String name = (String)files.nextElement();
    saveFiles.add(multi.getFilesystemName(name)); 
    origFiles.add(multi.getOriginalFileName(name));         
 }	 
 
//out.println(saveFiles.size());	 
	 if(saveFiles.size()!=0){
		 int ii=0;
		 if(saveFiles.size() ==1){ 		 	
			 	 fileName=(String)saveFiles.get(ii);			 	
			 		mgr.insertItemMulti(cate_nm,title,content,Integer.parseInt(view_yn),nm,fileName,ip_add,Integer.parseInt(seq_tab));			 				 			
			
		 }else if(saveFiles.size() >1){	
		 	fileName=(String)saveFiles.get(0);	 				 			 	
			mgr.insertItemMulti(cate_nm,title,content,Integer.parseInt(view_yn),nm,fileName,ip_add,Integer.parseInt(seq_tab));
			item_seq=mgr.getIdSeq("sop_item");
		 	 for(int i=saveFiles.size()-1; i>=0;i--){
			 	 fileName=(String)saveFiles.get(i);			 	
			 		mgr.insertFileMulti(item_seq,fileName);		
			 }
		 }
		 
		
%>
<script language="JavaScript">
	alert("データアップロード完了！！");
	 location.href="<%=urlPage%>rms/admin/sop/listForm.jsp";
</script>
<%
	 }else{
%>
<script language="JavaScript">
	alert("アップロード失敗");
	 location.href="<%=urlPage%>rms/admin/sop/cateAddForm.jsp";
</script>
<%	  
	  
	 }
 
}catch(IOException ioe){
 System.out.println(ioe);
}catch(Exception ex){
 System.out.println(ex);
}
%>
