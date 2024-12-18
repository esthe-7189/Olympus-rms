<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import = "mira.shokudata.FileMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.*"%>


<%
String urlPage=request.getContextPath()+"/";
String ip_add=(String)request.getRemoteAddr();

FileMgr mgr=FileMgr.getInstance();

/*
   C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp
   C:\\dev\\tomcat5\\webapps\\orms\\rms/admin/shokuData/fileList
   /home/user/orms/public_html/rms/admin/shokuData/fileList
   //파라미터를 출력함
   while(params.hasMoreElements()){ //전송한 파일이 있으면
      String name = (String)params.nextElement(); //input tag 이름
      String value = multi.getParameter(name);    //input tag 값  
      out.println(name + " = " + value +"<br>");
   }

*/

	//String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/shokuData/fileList";
	String saveFolder="/home/user/orms/public_html/rms/admin/shokuData/fileList"; 

int maxSize = 100*1024*1024;//100M
String fileName="";
String originFileName = "";
String cateNo="";
String cate_cnt="";
String mseq="";
String ok_yn="";
String lgroup_no="";
String cate_group="";

ArrayList saveFiles = new ArrayList(); //저장된 파일명 목록
ArrayList origFiles = new ArrayList(); //저장되기전 파일명 목록
ArrayList saveTitle = new ArrayList(); //저장되기전 파일명 목록

try{ 	
 //객체 생성시 파일 업로드 발생
 MultipartRequest multi = new MultipartRequest( request,saveFolder,maxSize,"utf-8",new DefaultFileRenamePolicy());
 
 //일반 text input tag에서 입력한 값을 가져옴             
 cateNo = multi.getParameter("cate_L");  //
 cate_cnt = multi.getParameter("cate_seq");
 mseq = multi.getParameter("mseq");
 ok_yn = multi.getParameter("ok_yn");
 lgroup_no=multi.getParameter("lgroup_no");
 cate_group=multi.getParameter("cate_group");
 
 
 //올려진 파일명 산출
 String title[]=multi.getParameterValues("title");	
 Enumeration files = multi.getFileNames();
 while(files.hasMoreElements()){
    String name = (String)files.nextElement();
    saveFiles.add(multi.getFilesystemName(name)); 
    origFiles.add(multi.getOriginalFileName(name)); 
        
 }
	 if(saveFiles.size()!=0){
		 int ii=0;
		 for(int i=saveFiles.size()-1; i>=0;i--){
		 	 fileName=(String)saveFiles.get(i);	
		 	
		 	mgr.insertFileMulti(Integer.parseInt(cateNo),Integer.parseInt(cate_cnt),Integer.parseInt(mseq),title[ii],fileName,Integer.parseInt(ok_yn),Integer.parseInt(cate_group));
		 ii++;
		 }
%>
<script language="JavaScript">
	alert("データアップロード完了！！");
	 location.href="<%=urlPage%>rms/admin/shokuData/listForm.jsp?pg=<%=cateNo%>";
</script>
<%
	 }else{
%>
<script language="JavaScript">
	alert("アップロード失敗");
	 location.href="<%=urlPage%>rms/admin/shokuData/cateAddForm.jsp?hCateCode=<%=lgroup_no%>";
</script>
<%	  
	  
	 }
 
}catch(IOException ioe){
 System.out.println(ioe);
}catch(Exception ex){
 System.out.println(ex);
}
%>
