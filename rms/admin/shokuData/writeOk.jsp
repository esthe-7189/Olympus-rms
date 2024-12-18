<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.job.Category" %>
<%@ page import = "mira.job.CateMgr" %>
<%@ page import=  "mira.job.MgrException" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import = "com.oreilly.servlet.*" %>


<%
String urlPage=request.getContextPath()+"/orms/";	



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Olympus RMS</title>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="title" content="olympus-rms.com" />
<meta name="author" content="www.ableu.com" />
<meta name="keywords" content="OLYMPUS RMS, BIO, collagen, chondron, cosmetic" />
<link href="<%=urlPage%>common/admin/css/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=urlPage%>common/admin/js/common.js"></script>
<script language="javascript" src="<%=urlPage%>common/admin/js/Commonjs.js"></script>
	

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#F1F1F1">
<%
String savePath="/home/user/orms/public_html/rms/admin/bunsho/bunList"; // 저장할 디렉토리 (절대경로)
int sizeLimit = 10 * 1024 * 1024 ; // 파일업로드 용량 제한.. 10Mb
try{
MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"utf-8",new DefaultFileRenamePolicy());
String fileName = null;
String originFileName = null;

// 수정 시 첨부 된 파일 중 제거한 value를 모은 배열
String[] fileRemoveList = multi.getParameterValues("fileRemoveList"); 
// 다중 업로드 파일 처리
for (Enumeration<String> e = multi.getFileNames(); e.hasMoreElements() ;) {
String strName = e.nextElement(); 
fileName= multi.getFilesystemName(strName); // 동일한 이름의 파일로 인해 변경 된 파일명
originFileName = multi.getOriginalFileName(strName); // 실제 파일명
}
} catch(Exception e) {
out.print(e.getMessage());
} 
%> 
<script>
// 작성 후 View 또는 List로 이동 시킬 스크립트
</script>

</body> 
	
	
	