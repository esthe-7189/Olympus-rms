<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import="mira.bunsho.BunshoBean" %>
<%@ page import="mira.bunsho.BunshoMgr" %>
<%@ page import="mira.bunsho.MgrException" %>
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
//String saveFold="C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\bunsho\\bunList";
String saveFoldTemp="/home/user/orms/public_html/rms/temp";
String saveFold="/home/user/orms/public_html/rms/admin/bunsho/bunList";



FileUploadRequestWrapper requestWrap=new FileUploadRequestWrapper(
	request,-1,-1,saveFoldTemp,"utf-8");
HttpServletRequest tempRequest=request;
request=requestWrap;
%>
<jsp:useBean id="pds" class="mira.bunsho.BunshoBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
	
	
<%
FileItem frmFileItem=requestWrap.getFileItem("fileNm");
String fil="";
String fileKindValue="";
	if(pds.getFile_kind()==1){
		fileKindValue="SW";
	}else if(pds.getFile_kind()==2){
		fileKindValue="NH";
	}else if(pds.getFile_kind()==3){
		fileKindValue="PG";
	}else if(pds.getFile_kind()==4){
		fileKindValue="OR";
	}
	
if (frmFileItem.getSize() >0){
	int idx=frmFileItem.getName().lastIndexOf("\\");
	if (idx==-1){
		idx=frmFileItem.getName().lastIndexOf("/");
	}
	fil=fileKindValue+"_"+frmFileItem.getName().substring(idx+1);

	//파일을 지정한 경로에 저장
	File fileNm=new File(saveFold,fil);
	
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
%>

<%
pds.setRegister(new Timestamp(System.currentTimeMillis()));
pds.setFilename(fil);

BunshoMgr mgr=BunshoMgr.getInstance();
mgr.insertLevel_2(pds);

if(pds.getFile_kind()==2){
mgr.updateHenkoLeve_1(pds.getNo(),1);
}else{
mgr.updateHenkoLeve_2(pds.getParentId(),1);
}

%>
<script language="JavaScript">
	opener.location.href="<%=urlPage%>rms/admin/bunsho/listForm.jsp";    
    window.close();
</script>
