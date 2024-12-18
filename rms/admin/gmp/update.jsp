<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>

<%
String urlPage=request.getContextPath()+"/";
	//String saveFoldTemp="C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp";
	//String saveFold="C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\gmp\\fileList";
	String saveFoldTemp="/home/user/orms/public_html/rms/temp";
	String saveFold="/home/user/orms/public_html/rms/admin/gmp/fileList";


GmpManager mgr=GmpManager.getInstance();

FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(request,-1,-1,saveFoldTemp,"utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.gmp.GmpBeen" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
FileItem frmFileItem=requestWrap.getFileItem("fileNmVal");
String file_manualMoto = request.getParameter("file_manualMoto");
String fileNmKind = request.getParameter("file_manual");
String kanri_no = request.getParameter("kanri_no");
String fil="";
//out.println(fileNmKind);

if(fileNmKind.equals("NO")){					
	if (frmFileItem.getSize() >0){
		int idx=frmFileItem.getName().lastIndexOf("\\");
		if (idx==-1){
			idx=frmFileItem.getName().lastIndexOf("/");
		}
		fil=frmFileItem.getName().substring(idx+1);

		//파일을 지정한 경로에 저장
		File fileNm=new File( saveFold,fil);
		
		//같은 이름의 파일 처리
		if (fileNm.exists())	{
			for (int i=0;true ;i++ ){
				fileNm=new File(saveFold,"("+i+")"+fil);
				if (!fileNm.exists()){
					fil="("+i+")"+fil;
					break;
				}
			}
	}
		frmFileItem.write(fileNm);
}
	pds.setFile_manual(fil);	
	mgr.update1(pds);

}else{	
	mgr.update2(pds);
}

response.sendRedirect(urlPage+"rms/admin/gmp/listForm.jsp");
%>








