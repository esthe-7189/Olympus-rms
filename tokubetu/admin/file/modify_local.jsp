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

//request.setCharacterEncoding("euc-kr");

FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,"C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp","utf-8");
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
	File fileNmVal=new File( "C:\\dev\\tomcat5\\webapps\\orms\\tokubetu/admin/file/fileList",fil);
	
	//같은 이름의 파일 처리
	if (fileNmVal.exists())	{
		for (int i=0;true ;i++ ){
			fileNmVal=new File("C:\\dev\\tomcat5\\webapps\\orms\\tokubetu/admin/file/fileList","("+i+")"+fil);
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

%>
<script language="JavaScript">
alert("yes");  
</script>
<%

mgr.update(pds);

}else if(fileNm.equals("No")){
mgr.update2(pds);

%>
<script language="JavaScript">
alert("no");  
</script>
<%

}

response.sendRedirect(urlPage+"tokubetu/admin/file/listForm.jsp");
%>
