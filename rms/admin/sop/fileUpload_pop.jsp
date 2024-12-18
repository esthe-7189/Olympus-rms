<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import="mira.sop.AccDownMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
String seq_list=request.getParameter("seq_list");
String goPg=request.getParameter("goPg");

String filename = ""; 	
	AccMgr mgrdn = AccMgr.getInstance();
	AccBean fnm=mgrdn.getSopFile(Integer.parseInt(seq_list));
		if(fnm!=null){
			filename=fnm.getFilename();
		}
	
%>

		
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<script language="JavaScript">
function goWrite() {
    with (document.memberInput) {
        if (chkSpace(fileNm.value)) {
   	    	alert("ファイルを選択してください.");
            fileNm.focus();
            return ;
         }         
    }
     if ( confirm("登録しますか?") != 1 ) { return; }	
     	document.memberInput.action = "<%=urlPage%>rms/admin/sop/updateFile_pop.jsp";	
	document.memberInput.submit();  
	
}
function goInit(){
	document.forminput.reset();
}
function chkSpace(strValue) {
    var flag=true;
    if (strValue!="") {
        for (var i=0; i < strValue.length; i++) {
            if (strValue.charAt(i) != " ") {
	        	flag=false;
	        	break;
	    	}
        }
    }
    return flag;
}

function resize(width, height){	
	window.resizeTo(width, height);
}
</script>
</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('720','290') ;">
<center>

<table width="90%" border=0 cellspacing=0 cellpadding=0 >	
	<tr>
		<td width="100%"  height="30" style="padding: 0 0 0 0"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">ファイル変更  
    		</td>    	
	</tr>		
</table>	
<table width="90%" border=0 cellspacing=0 cellpadding=0 align=center class=c>
	<form name="memberInput" action="<%=urlPage%>rms/admin/sop/updateFile_pop.jsp" method="post" enctype="multipart/form-data" >											
		<input type="hidden" name="seq" value="<%=seq_list%>">			
		<input type="hidden" name="goPg" value="<%=goPg%>">		
		<input type="hidden" name="seq_list" value="<%=seq_list%>">	
			
	<tr>
		<td colspan="5" bgcolor="#A3C5DF" height="3"></td>
	</tr>	
	<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif"></td></tr>
	<tr   height=20>
		<td align="" bgcolor="#f7f7f7" width="18%" style="padding: 5px 5px 5px 5px;"><img src="<%=urlPage%>rms/image/icon_s.gif" >既存ファイル:</td>
		<td width="82%" style="padding: 5px 5px 5px 5px;">
			<%if(filename.equals("Data")){%>--
			<%}else{%>			
				<font color="#CC3333" ><%=filename%></font>
			<%}%>			
		</td>
	</tr>	
	<tr   height=20>
		<td align="" bgcolor="#f7f7f7" width="18%" style="5px 5px 5px 5px;"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイル選択:</td>
		<td width="82%" style="padding: 5px 5px 5px 5px;"><font color="#CC3333" >			
			▷アップロードするファイル名に '&,%,^'などの記号は使わないで下さい!<br>
			</font>
			<input type="file" name="fileNm" size="60" class="file_solid">	
		</td>
	</tr>	
	
</table>
<table width="90%" border="0" cellpadding="2" cellspacing="0">
	<tr>
		<td align="center" style="padding:5px 0px 10px 0px;">
			<a href="JavaScript:goWrite()"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></A>
				&nbsp;
			<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></A>
		</td>
	</tr>
</form>			
</table>
</center>
</body>
</html>
