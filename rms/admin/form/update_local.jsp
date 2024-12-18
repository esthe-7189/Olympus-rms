<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.Hashtable"%>

<%
String urlPage=request.getContextPath()+"/";
GmpManager mgr=GmpManager.getInstance();
String saveFolder = "C:/dev/tomcat5/webapps/orms/rms/admin/gmp/fileList/";
//String saveFolder="/home/user/orms/public_html/rms/admin/gmp/fileList/"; 

FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,"C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp","utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.gmp.GmpBeen" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
FileItem frmFileItem=requestWrap.getFileItem("fileNmVal");
String file_manualMoto = request.getParameter("file_manualMoto");
String fileNm = request.getParameter("file_manual");
String kanri_no = request.getParameter("kanri_no");
String fil="";
//out.println(pds.getKanri_no());

if(fileNm.equals("NO")){	
	
if (frmFileItem.getSize() >0){
		//**************기존 파일 삭제******************************	
					File  file = new File( saveFolder + file_manualMoto );  // 파일 객체생성
						if( file.exists() ){ file.delete(); }																 		
		//********************************************
	
	int idx=frmFileItem.getName().lastIndexOf("\\");
	if (idx==-1){
		idx=frmFileItem.getName().lastIndexOf("/");
	}
	fil=frmFileItem.getName().substring(idx+1);

	//파일을 지정한 경로에 저장
	File fileNmVal=new File( "C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\gmp\\fileList",fil);
	
	//같은 이름의 파일 처리
	if (fileNmVal.exists())	{
		for (int i=0;true ;i++ ){
			fileNmVal=new File("C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\gmp\\fileList",fil);
			if (!fileNmVal.exists()){
				fil="("+i+")"+fil;
				break;
			}
		}
	}
	frmFileItem.write(fileNmVal);
}

pds.setFile_manual(fil);
mgr.update1(pds);

}else{
mgr.update2(pds);
}

response.sendRedirect(urlPage+"rms/admin/gmp/listForm.jsp");
%>
	













