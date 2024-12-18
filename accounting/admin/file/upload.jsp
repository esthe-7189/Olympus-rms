<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.acc.AccBean" %>
<%@ page import="mira.acc.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "java.util.Hashtable"%>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("acc")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String ip_add=(String)request.getRemoteAddr();
//String saveFoldTemp="C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp";
//String saveFold="C:\\dev\\tomcat5\\webapps\\orms\\accounting\\admin\\file\\fileList";
String saveFoldTemp="/home/user/orms/public_html/rms/temp";
String saveFold="/home/user/orms/public_html/accounting/admin/file/fileList";


FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,saveFoldTemp,"utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.acc.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
FileItem frmFileItem=requestWrap.getFileItem("fileNm");
String fil="";
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
			fileNm=new File("/home/user/orms/public_html/accounting/admin/file/fileList","("+i+")"+fil);
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
pds.setFilename(fil);
pds.setIp_add(ip_add);
if(pds.getComment()==null){
   	pds.setComment("...");
   }

AccMgr mgr=AccMgr.getInstance();
mgr.insertAcc(pds);

response.sendRedirect(urlPage+"accounting/admin/file/listForm.jsp");
%>

