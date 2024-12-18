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
%>
<jsp:useBean id="category" class="mira.shokudata.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
	//String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/shokuData/fileList/";
	String saveFolder="/home/user/orms/public_html/rms/admin/shokuData/fileList"; 	
	
	CateMgr manager=CateMgr.getInstance();
	FileMgr manager2=FileMgr.getInstance();
	
 	String bseq=request.getParameter("bseqModi");
 	String level=request.getParameter("level");
 	String groupId=request.getParameter("groupIdDel");
 	String lgroup_no=request.getParameter("lgroup_no");
 	int filecnt=0;
  	
 //파일 
 
 List listFiles=manager2.selectListFileDel(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));
  		Iterator iter2=listFiles.iterator();
			while(iter2.hasNext()){
				Category cate2=(Category)iter2.next();
				if(cate2.getBseq() !=0){					
					manager2.delYn(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));
				}
			filecnt++;
			}
if(filecnt==0){
	manager.delete(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));	 //DB: shoku_cate   테이블
		if(Integer.parseInt(level)==1){
	%>
		<SCRIPT LANGUAGE="JavaScript">
		alert("削除しました");
		location.href="<%=urlPage%>rms/admin/shokuData/cateAddForm.jsp?hCateCode=<%=lgroup_no%>";
		</SCRIPT>

	<%}else{
		String lgroup=request.getParameter("lgroup");
			
	%>
		<SCRIPT LANGUAGE="JavaScript">
		alert("削除しました");
		location.href="<%=urlPage%>rms/admin/shokuData/Mgroup.jsp?lgroup_no=<%=lgroup_no%>&lgroup=<%=lgroup%>";
		</SCRIPT>

	<%}	
	
}else{
 
//*****************To page*********************************

if(Integer.parseInt(level)==1){
%>
	<SCRIPT LANGUAGE="JavaScript">
	alert("このカテゴリにファイルが（<%=filecnt%>）個ありますので、削除失敗しました\n目録ページにてファイルを先に削除してください<%=level%>");
	location.href="<%=urlPage%>rms/admin/shokuData/cateAddForm.jsp?hCateCode=<%=lgroup_no%>";
	</SCRIPT>

<%}else{
	String lgroup=request.getParameter("lgroup");
		
%>
	<SCRIPT LANGUAGE="JavaScript">
	alert("このカテゴリにファイルが（<%=filecnt%>）個ありますので、削除失敗しました\n目録ページにてファイルを先に削除してください<%=level%>");
	location.href="<%=urlPage%>rms/admin/shokuData/Mgroup.jsp?lgroup_no=<%=lgroup_no%>&lgroup=<%=lgroup%>";
	</SCRIPT>

<%}}%>
	


	
	
<%

//**************폴더 삭제******************************	
/*	List listFiles=manager2.selectListFileDel(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));
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
 //*****************DB삭제**********************************	
 /*
List listFiles=manager2.selectListFileDel(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));
	Iterator iter=listFiles.iterator();
	while(iter.hasNext()){
		Category cate=(Category)iter.next();		
		if(cate.){
		
		}
	}
*/
//	manager.delete(Integer.parseInt(bseq),Integer.parseInt(level),Integer.parseInt(groupId));	 //DB: shoku_cate   테이블		
//	manager2.delYn(Integer.parseInt(bseq));
	

%>