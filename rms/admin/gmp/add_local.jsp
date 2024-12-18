<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "java.util.Hashtable"%>

<%	
String kindpgkubun=(String)session.getAttribute("KIND");
if(kindpgkubun!=null && ! kindpgkubun.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}

String urlPage=request.getContextPath()+"/";

FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,"C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp","utf-8");
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

//out.println(file_manualVal);

if (frmFileItem.getSize() >0){
	int idx=frmFileItem.getName().lastIndexOf("\\");
	if (idx==-1){
		idx=frmFileItem.getName().lastIndexOf("/");
	}
	fil=frmFileItem.getName().substring(idx+1);

	//파일을 지정한 경로에 저장
	File fileNm=new File( "C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\gmp\\fileList",fil);
	
	//같은 이름의 파일 처리
	if (fileNm.exists())	{
		for (int i=0;true ;i++ ){
			fileNm=new File("C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\gmp\\fileList","("+i+")"+fil);
			if (!fileNm.exists()){
				fil="("+i+")"+fil;
				break;
			}
		}
	}
	frmFileItem.write(fileNm);
	
}

if(file_manualVal.equals("no data")){
	pds.setFile_manual(file_manualVal);
}else if(file_manualVal.equals("0")){
	pds.setFile_manual(fil);
}
pds.setRegister(new Timestamp(System.currentTimeMillis()));


GmpManager mgr=GmpManager.getInstance();
mgr.insertBoard(pds);

response.sendRedirect(urlPage+"rms/admin/gmp/listForm.jsp");



%>
