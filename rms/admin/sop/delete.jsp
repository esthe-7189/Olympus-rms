<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*"%>

<jsp:useBean id="pds" class="mira.sop.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
   String urlPage=request.getContextPath()+"/";
   AccMgr mgr = AccMgr.getInstance();       
      
	//String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/sop/fileList/";
	String saveFolder="/home/user/orms/public_html/rms/admin/sop/fileList/"; 	
	
	String seq_list=request.getParameter("seq_list");
 	String seq_item=request.getParameter("seq_item"); 	
 	String fileNm=request.getParameter("filename"); 	
 	String kubun = request.getParameter("kubun"); 	 
 	String lastFile=""; int lastSeq=0;	
 	
 	 
//**************파일 및 데이터 삭제******************************	
			File  file = new File( saveFolder + fileNm );  // 파일 객체생성
				if( file.exists() ){
					// file.delete(); 
				}
			
			if(kubun.equals("sop_item") || kubun.equals("sop_item_multi_list")){  				
				mgr.delete(Integer.parseInt(seq_list),Integer.parseInt(seq_item));	
			}else if(kubun.equals("sop_item_multi_pop")){				
				mgr.deleteFileFollow(Integer.parseInt(seq_item));	
			}
											
//******sop_item_multi 테이블 1개파일 남았을때 삭제, 마지막 파일명 sop_item테이블에 업데이트****************

		int cntFile=mgr.countFileItem(Integer.parseInt(seq_list));	
		if(cntFile==1){
			AccBean fone=mgr.delFileLastOne(Integer.parseInt(seq_list));   	
			 if(fone!=null){
			 	lastFile=fone.getFilename();
			 	lastSeq=fone.getSeq();
			 }
					
			pds.setSeq(Integer.parseInt(seq_list));	
			pds.setFilename(lastFile);
			mgr.updateFile_item(pds);
			mgr.deleteFileFollow(lastSeq);				
		
		}
					
		
			
 if(kubun.equals("sop_item") || kubun.equals("sop_item_multi_list")){
 %>
	<script language="JavaScript">
	alert("処理しました。");
	location.href = "<%=urlPage%>rms/admin/sop/listForm.jsp";
	</script>
<%}else if(kubun.equals("sop_item_multi_pop")){%>
	
	<script language="JavaScript">
		alert("処理しました。");
		opener.location.href = "<%=urlPage%>rms/admin/sop/listForm.jsp";    		  		
		self.close();
	</script>
	

<%}%>

	