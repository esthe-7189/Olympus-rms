<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>	
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.bunsho.BunshoBean" %>
<%@ page import="mira.bunsho.BunshoMgr" %>
<%@ page import="mira.bunsho.MgrException" %>
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
String bseq=request.getParameter("bseq");
String file_kind=request.getParameter("file_kind");
int fileKind=Integer.parseInt(file_kind);
String fno=request.getParameter("fno");


BunshoMgr manager = BunshoMgr.getInstance();
BunshoBean bunData=manager.getLevel(Integer.parseInt(bseq));
 
%>
<c:set var="bunData" value="<%=bunData%>"/>
<c:if test="${! empty  bunData}" />
		
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

<script language="JavaScript">
function goWrite() {    
    with (document.memberInput) {
    	    if(fileOk[0].checked==true){         	 
		fileNm.value="<%=bunData.getFilename()%>";		
	    }	  
	    if(fileOk[1].checked==true){         	 
		if (chkSpace(fileNmVal.value)) {
	            alert("ファイルを選択して下さい。");
	            fileNmVal.focus();   return false;	
	        }else{
	            fileNm.value="Yes";	
	        }
	   }	           
    }   
  if ( confirm("修正しますか?") != 1 ) { return; }	
     	document.memberInput.action = "<%=urlPage%>rms/admin/bunsho/modifyUpload_pop.jsp";	
	document.memberInput.submit();  
	

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
function goInit(){
	document.forminput.reset();
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
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">翻訳したファイルの編集
    		</td>    	
	</tr>		
</table>	
<table width="90%" border=0 cellspacing=0 cellpadding=0 align=center class=c>
	<form name="memberInput" action="<%=urlPage%>rms/admin/bunsho/modifyUpload_pop.jsp" method="post" enctype="multipart/form-data" >											
		<input type="hidden" name="bseq" value="<%=bseq%>">	
		<input type="hidden" name="kind_yn" value="<%=bunData.getKind_yn()%>">
		<input type="hidden" name="fileNm" value="">		
		<input type="hidden" name="file_kind" value="<%=fileKind%>">		
	

	<tr>
		<td colspan="5" bgcolor="#A3C5DF" height="3"></td>
	</tr>
	<tr >
		<td align="" bgcolor="#f7f7f7" style="padding: 5 5 5 5"><img src="<%=urlPage%>rms/image/icon_s.gif" >翻訳段階:</td>
		<td style="padding: 5 5 5 5">
<c:choose>
	<c:when test="${param.file_kind=='2'}">			
		      	翻訳初本(NH)		
	</c:when>
	<c:when test="${param.file_kind=='3'}">			
		      	PG完成本(PG)	
	</c:when>
	<c:when test="${param.file_kind=='4'}">			
		      	ORMS最終本(OR)	
	</c:when>	
	<c:otherwise>
	    		No Data!!
	</c:otherwise>
</c:choose>		
		</td>
	</tr>
	<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif"></td></tr>
	<tr   height=20>
		<td align="" bgcolor="#f7f7f7" width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイル名:</td>
		<td>	<%=bunData.getFilename()%></td>
	</tr>
	<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif"></td></tr>
	<tr >
		<td align="" bgcolor="#f7f7f7"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの変更:</td>
		<td>
			<input type="radio" onfocus="this.blur()"  name="fileOk" value="1"  onClick="selectFile()"  checked>No&nbsp;
			<input type="radio" onfocus="this.blur()"  name="fileOk" value="2"  onClick="selectFile()" >Yes 	<br>			
					<div id="file_01"  style="display:none;">									
						<table border=0 cellspacing=0 cellpadding=1>
							<tr>
								<td>
									<font color="#CC3333" width="82%">									
									▷アップロードするファイル名に '&,%,^'などの記号は使わないで下さい!
									</font><br>				
									<input type="file" name="fileNmVal" size="60" class="file_solid">
								</td>
							</tr>						
						</table>
					</div>			
		</td>
	</tr>	
	<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif"></td></tr>
	<tr>
		<td align="" bgcolor="#f7f7f7" ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
		<td >
			<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()"  <%if(bunData.getView_yn()==0){%>checked<%}%>>Yes &nbsp;
			<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" <%if(bunData.getView_yn()==1){%>checked<%}%>>No
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
<script language="JavaScript">
var f=document.memberInput;
var d=document.all;	

function selectFile(){		
	if (f.fileOk[0].checked==true)	{				
		d.file_01.style.display="none";		
	}else if (f.fileOk[1].checked==true)	{		
		d.file_01.style.display="";		
	}		
}
</script>