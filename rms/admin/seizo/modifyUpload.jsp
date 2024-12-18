<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.seizo.SeizoBean" %>
<%@ page import="mira.seizo.SeizoMgr" %>
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
//String saveFoldTemp="C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp";
//String saveFold="C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\seizo\\bunList";
String saveFoldTemp="/home/user/orms/public_html/rms/temp";
String saveFold="/home/user/orms/public_html/rms/admin/seizo/bunList";


SeizoMgr mgr=SeizoMgr.getInstance();

FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,saveFoldTemp,"utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.seizo.SeizoBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
FileItem frmFileItem=requestWrap.getFileItem("fileNmVal");
String fileNm = request.getParameter("fileNm");
String fil="";
String fileKindValue="";
	if(pds.getFile_kind()==1){
		fileKindValue="SE1";
	}else if(pds.getFile_kind()==2){
		fileKindValue="SE2";
	}else if(pds.getFile_kind()==3){
		fileKindValue="SE3";
	}else if(pds.getFile_kind()==4){
		fileKindValue="SE4";
	}
if(fileNm.equals("NO")){	
	
if (frmFileItem.getSize() >0){
	int idx=frmFileItem.getName().lastIndexOf("\\");
	if (idx==-1){
		idx=frmFileItem.getName().lastIndexOf("/");
	}
	fil=fileKindValue+"_"+frmFileItem.getName().substring(idx+1);

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
	if(pds.getBseq()==11){
		pds.setContent("No Data");
	}
mgr.update(pds);

}else{
mgr.update2(pds);
}

response.sendRedirect(urlPage+"rms/admin/seizo/listForm.jsp");
%>
