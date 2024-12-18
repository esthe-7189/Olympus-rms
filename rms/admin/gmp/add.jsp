<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%
String urlPage=request.getContextPath()+"/";
String ip_add=(String)request.getRemoteAddr();

	//String saveFoldTemp="C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp";
	//String saveFold="C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\gmp\\fileList";
	String saveFoldTemp="/home/user/orms/public_html/rms/temp";
	String saveFold="/home/user/orms/public_html/rms/admin/gmp/fileList";


FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,saveFoldTemp,"utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.gmp.GmpBeen" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
FileItem frmFileItem=requestWrap.getFileItem("fileNm");
String fil="";
String file_manualVal = request.getParameter("file_manualVal");


if (frmFileItem.getSize() >0){
	int idx=frmFileItem.getName().lastIndexOf("\\");
	if (idx==-1){
		idx=frmFileItem.getName().lastIndexOf("/");
	}
	fil=frmFileItem.getName().substring(idx+1);
	File fileNm=new File( saveFold,fil);
	
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
%>

<%
pds.setRegister(new Timestamp(System.currentTimeMillis()));

if(file_manualVal.equals("no data")){
	pds.setFile_manual(file_manualVal);
}else if(file_manualVal.equals("0")){
	pds.setFile_manual(fil);
}

GmpManager mgr=GmpManager.getInstance();	
mgr.insertBoard(pds);

response.sendRedirect(urlPage+"rms/admin/gmp/listForm.jsp");
%>

