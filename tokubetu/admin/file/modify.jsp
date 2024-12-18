<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.tokubetu.AccBean" %>
<%@ page import="mira.tokubetu.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "java.util.Hashtable"%>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String ip_add=(String)request.getRemoteAddr();
AccMgr mgr=AccMgr.getInstance();

//String saveFoldTemp="C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp";
//String saveFold="C:\\dev\\tomcat5\\webapps\\orms\\tokubetu\\admin\\file\\fileList";
String saveFoldTemp="/home/user/orms/public_html/rms/temp";
String saveFold="/home/user/orms/public_html/tokubetu/admin/file/fileList";


FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,saveFoldTemp,"utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.tokubetu.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
FileItem frmFileItem=requestWrap.getFileItem("fileNmVal");
String fileNm = request.getParameter("fileNm");
String fil="";

if(fileNm.equals("Yes")){
if (frmFileItem.getSize() >0){
	int idx=frmFileItem.getName().lastIndexOf("\\");
	if (idx==-1){
		idx=frmFileItem.getName().lastIndexOf("/");
	}
	fil=frmFileItem.getName().substring(idx+1);

	//파일을 지정한 경로에 저장
	File fileNmVal=new File( saveFold,fil);
	
	//같은 이름의 파일 처리
	if (fileNmVal.exists())	{
		for (int i=0;true ;i++ ){
			fileNmVal=new File(saveFold,"("+i+")"+fil);
			if (!fileNmVal.exists()){
				fil="("+i+")"+fil;
				break;
			}
		}
	}
	frmFileItem.write(fileNmVal);
}
%>

<%

pds.setFilename(fil);
if(pds.getComment()==null){
   	pds.setComment("...");
   }

mgr.update(pds);
}else if(fileNm.equals("No")){
	if(pds.getComment()==null){
   	pds.setComment(".");
   	}
mgr.update2(pds);
}

response.sendRedirect(urlPage+"tokubetu/admin/file/listForm.jsp");
%>
