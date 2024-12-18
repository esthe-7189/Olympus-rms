<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page errorPage="/rms/error/error_common.jsp"%>

<%
String urlPage=request.getContextPath()+"/";
String ip_add=(String)request.getRemoteAddr();

//request.setCharacterEncoding("euc-kr");

FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,"C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp","utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.sop.AccBean" >
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
	File fileNm=new File( "C:\\dev\\tomcat5\\webapps\\orms\\rms/admin/sop/fileList",fil);
	
	//같은 이름의 파일 처리
	if (fileNm.exists())	{
		for (int i=0;true ;i++ ){
			fileNm=new File("C:\\dev\\tomcat5\\webapps\\orms\\rms/admin/sop/fileList","("+i+")"+fil);
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
if(pds.getContent()==null){ pds.setContent("no data");  }

AccMgr mgr=AccMgr.getInstance();
mgr.insertAcc(pds);

response.sendRedirect(urlPage+"rms/admin/sop/listForm.jsp");
%>
