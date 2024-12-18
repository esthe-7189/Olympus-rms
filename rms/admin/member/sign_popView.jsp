<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String fileKind=request.getParameter("fileKind");
String member_id=request.getParameter("member_id");
String mseq=request.getParameter("mseq");
String mimg="";

	MemberManager manager = MemberManager.getInstance();
	Member member=manager.getMember(member_id);

  
%>
<c:set var="member" value="<%= member %>" />


		
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

<script type="text/javascript">
window.onload = function() {
		codeMake();
	}
function codeMake(){					
	i = 0;					
	result = 0;				
	while (true){
	i = parseInt(Math.random()*9999);
	if (i > 1000){
	result = i;
	break;
	}
}	
document.getElementById("mcode").value =result ;  								
}

function goWrite(){
var frm=document.memberInput;

if(isEmpty(frm.imageFile, "イメージを入力して下さい。")) return;
if ( confirm("登録しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/member/sign_pop.jsp";	
frm.submit();
}

function resize(width, height){	
	window.resizeTo(width, height);
}
</script>	


</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0"  BORDER=0  align="center"　onLoad="javascript:resize('720','200') ;">
<center>				
<table width="100%" border="0" cellspacing="0" cellpadding="0">		
	<tr>		
		<td width="90%"  height="" style="padding: 5 0 0 20"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">印鑑のイメージ 
	<font  color="#FF6600">
<%if(fileKind.equals("modi")){%>修正　<%}%>
<%if(fileKind.equals("new")){%>登録　<%}%>
	</font>					
    		</td>        			
	</tr>	
</table>
<c:if test="${! empty member}" />
<p>
<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
<form name="memberInput" action="<%=urlPage%>rms/admin/member/sign_pop.jsp" method="post"   enctype="multipart/form-data">					
		<input type="hidden" name="mseq" value="${member.mseq}">	
		<input type="hidden" name="fileKind" value="<%=fileKind%>">
		<input type="hidden" name="mcode">
	<tr>    
		<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >印鑑のイメージ</td>
		<td width="80%">
<!--		<span style="overflow:hidden; width:94; height:23; background-image:url(<%=urlPage%>rms/image/admin/btn_file_search.gif);">
		<input  type='file' name="imageFile" style="width:0;height:20;filter:alpha(opacity=0);" onchange='photo.value=this.value' >
		</span>	
-->
		
			<font color="#807265">(▷イメージのサイズは潰れる場合がありますので出来るだけ<b>width 32pix</b>にして下さい!!</font><br>
			<input type="file" name="imageFile" size="60" class="file_solid">
		</td> 
	</tr>
	<%if(!member.getMimg().equals("no")){%>
	<tr>    
		<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >既存のイメージ</td>
		<td width="80%" align="center">
			<img src="<%=urlPage%>rms/image/admin/ingam/<%=member.getMimg()%>_40.jpg" align="absmiddle">			
		</td> 
	</tr>	
	<%}%>
</table>
<p>
<table width="95%" >	  
	<tr>
		<td align="center">
			<a href="JavaScript:goWrite()" onfocus="this.blur();">
				<%if(fileKind.equals("modi")){%><img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"><%}%>
				<%if(fileKind.equals("new")){%><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"><%}%>				
			</a>				
		</td>
		</tr>	
</table>
</center>	
</form>
 
</center>
</body>
</html>


























