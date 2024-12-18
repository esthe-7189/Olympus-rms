<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.hinsithu.HinsithuBean" %>
<%@ page import="mira.hinsithu.HinsithuMgr" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CommentMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
String file_bseq=request.getParameter("file_bseq");
String bseq=request.getParameter("bseq");
String file_kind=request.getParameter("file_kind");
String parentId = request.getParameter("parentId");
String pg=request.getParameter("pg");
String openerPg=request.getParameter("openerPg");
String ip_info=(String)request.getRemoteAddr();

String title = ""; String conRe="";      	
    Category board = null;
    if (parentId != null) {      
        CommentMgr manager = CommentMgr.getInstance();
        board = manager.select(Integer.parseInt(bseq));
        if (board != null) {
            title = board.getTitle();                   
            conRe=board.getContent()+"<br>"+
            board.getLevel()+">===================================<br>";            
        }
    }	
%>
<c:set var="board" value="<%= board %>" />


		
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
function goWrite() {
var frm=document.memberInput;
    with (document.memberInput) {
        if (chkSpace(title.value)) {
   	    	alert("タイトルを書いてください.");
            title.focus();    return ;        
         }else if (chkSpace(name.value)) {
            alert("作成者を書いてください.");
            name.focus();   return ;
         }
    }
    
   if(isOutOfRange(frm.password, 4, 8, "アルファベットと 4～8個の数字のみ.")) return ;	
   if(frm.mail_yn[0].checked == true){	
	if(!isVaildMail(frm.mail_address.value)) {
		alert("メールを正しく書いて下さい。特殊文字などは入力不可能です。!"); return ;
	 }
   }else{
	  frm.mail_address.value="No Data";	  
  }    
  
  	if(frm.henji_yn[0].checked == true){
	  frm.ok_yn.value="0";	 
	}else{
	  frm.ok_yn.value="1";		  
	}    
 
     		 var oEditor=FCKeditorAPI.GetInstance('content');
		 var div=document.createElement("DIV");
		 div.innerHTML=oEditor.GetXHTML();
		
		 if(div.innerText=="" || div.innerText==null){	 	 
		    	alert("コメントを書いてください.");
		　　 oEditor.Focus();
		　     return ;	    		    
		  }
		
		if ( confirm("登録しますか?") != 1 ) {
			return ;
		}
	document.memberInput.action = "<%=urlPage%>rms/admin/hinsithu/commentInsert.jsp";	
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
</script>	
<script type="text/javascript">
function FCKeditor_OnComplete( editorInstance ){
	var oCombo = document.getElementById( 'cmbLanguages' ) ;
	for ( code in editorInstance.Language.AvailableLanguages )	{
		AddComboOption( oCombo, editorInstance.Language.AvailableLanguages[code] + ' (' + code + ')', code ) ;
	}
	oCombo.value = editorInstance.Language.ActiveLanguage.Code ;
}	

function AddComboOption(combo, optionText, optionValue){
	var oOption = document.createElement("OPTION") ;
	combo.options.add(oOption) ;
	oOption.innerHTML = optionText ;
	oOption.value     = optionValue ;	
	return oOption ;
}

function ChangeLanguage( languageCode ){
	window.location.href = window.location.pathname + "?code=" + languageCode + "&pg=${param.pg}&file_bseq=${param.file_bseq}&file_kind=${param.file_kind}${param.bseq}" ;
}
</script>

<%
String autoDetectLanguageStr;
String defaultLanguageStr;
String codeStr=request.getParameter("code");
if(codeStr==null) {
	autoDetectLanguageStr="true";
	defaultLanguageStr="en";
}
else {
	autoDetectLanguageStr="false";
	defaultLanguageStr=codeStr;
}
%>

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0"  BORDER=0  align="center"　onLoad="javascript:resize('720','400') ;">
<center>				
<table width="100%" border="0" cellspacing="0" cellpadding="0">		
	<tr>		
		<td width="90%"  height="" style="padding: 5 0 0 20"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">コメントのリスト<font  color="#FF6600">></font>
<c:choose>
	<c:when test="${param.file_kind=='1'}">			
		      	試験書原文(ORMS)	
	</c:when>
	<c:when test="${param.file_kind=='2'}">			
		      	QAチェック本(OT)		
	</c:when>
	<c:when test="${param.file_kind=='3'}">			
		      	QA確認本	
	</c:when>
	<c:when test="${param.file_kind=='4'}">			
		      	最終完成本	
	</c:when>	
	<c:otherwise>
	    		No Data!!
	</c:otherwise>
</c:choose>
<font  color="#FF6600">></font>
<c:choose>									
	<c:when test="${param.pg=='lead'}">			
		      	コメントの内容
	</c:when>
	<c:when test="${param.pg=='mody'}">			
		      	書き直し		
	</c:when>
	<c:when test="${param.pg=='write'}">			
		      	書く		
	</c:when>
	<c:when test="${param.pg=='kotae'}">			
		      	回答	
	</c:when>
	<c:otherwise>
	    		...
	</c:otherwise>
</c:choose>				
    		</td>        			
	</tr>	
</table>
<table width="95%"  border="0" cellspacing="0" cellpadding="0" align="center">
	<form name="memberInput" action="<%=urlPage%>rms/admin/seizo/commentInsert.jsp" method="post"  onSubmit="return goWrite(this)" >					
		<input type="hidden" name="file_bseq" value="${param.file_bseq}">	
		<input type="hidden" name="file_kind" value="${param.file_kind}">	
		<input type="hidden" name="pg" value="${param.pg}">
		<input type="hidden" name="openerPg" value="<%=openerPg%>">		
		<input type="hidden" name="ok_yn" value="0">	
		<input type="hidden" name="hit_cnt" value="0">		
		<input type="hidden" name="add_ip" value="<%=ip_info%>">	
		
	<c:if test="${! empty board}">
		<input type="hidden" name="bseq" value="${board.bseq}">	
	</c:if>
	<c:if test="${empty board}">
		<input type="hidden" name="bseq" value="0">	
	</c:if>			
	<c:if test="${! empty param.groupId}">
		<input type="hidden" name="groupId" value="${board.groupId}">
	</c:if>
		<input type="hidden" name="parentId" value="<%=bseq%>">					
		<input type="hidden" name="level" value="${board.level + 1}">					
		<tr>
	    		<td style="padding: 0 0 0 20" align="right">  
	    			<a href="javascript:goPgList()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_coment_list.gif" align="absmiddle"></a>	    				    		    	   				
	    		</td> 
		</tr>							
</table>
<table width="95%" border="0" cellpadding="0" cellspacing="0" class=c>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="12%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
	<td   style="padding: 3 3 3 3" width="38%">
		<font color="red">*</font>		
		<c:if test="${!empty board}">
			<input type="text" name="title" value="<%=title%>" size="100" maxlength="120" class="input02" style="width:180px">	
		</c:if>				
	</td>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" >pw:</td>
	<td   style="padding: 3 3 3 3" width="35%">
		<input type="password" name="password"  value="" size="20" maxlength="20" class="input02" style="width:60px">
		<font color="#807265">(▷修正,削除に使う)</font>	 
	</td>     	
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="12%"><img src="<%=urlPage%>rms/image/icon_s.gif" >作成者:</td>
	<td   style="padding: 3 3 3 3"  width="38%">
		<font color="red">*</font>		
		<input type="text" name="name" value="" size="40" maxlength="50" class="input02" style="width:180px">	 
	</td> 
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >メール使用:</td>
	<td   style="padding: 3 3 3 3" >
		<input type="radio" name="mail_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">Yes</font>
		<input type="radio" name="mail_yn" value="2" onClick="show02()" onfocus="this.blur()"  checked><font  color="#FF6600">No</font><br>		 
				<div id="show" style="display:none;">	
					<input type="text" name="mail_address" value="" size="40" maxlength="80" class="input02" style="width:170px;ime-mode:disabled">	
				</div>		 
	</td>     
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td  bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >返事要求:</td>
	<td  style="padding: 3 3 3 3" colspan="3">
		<input type="radio" name="henji_yn" value="0"  onfocus="this.blur()" ><font  color="#FF6600">はい</font>
		<input type="radio" name="henji_yn" value="1"  onfocus="this.blur()"  checked><font  color="#FF6600">いいえ</font>
	</td> 	
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td  bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >コメント:</td>
	<td  colspan="3" style="padding: 3 3 3 3" height="50" >
		<select id="cmbLanguages" onchange="ChangeLanguage(this.value);"></select><br>
			<FCK:editor id="content" basePath="/fckeditor/" toolbarSet="Basic02" 									
				autoDetectLanguage="<%=autoDetectLanguageStr%>"
				defaultLanguage="<%=defaultLanguageStr%>"
				imageBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/editor/filemanager/browser/default/connectors/jsp/connector" 				
				linkBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
				flashBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
				imageUploadURL="/editor/filemanager/upload/simpleuploader?Type=Image"
				linkUploadURL="/editor/filemanager/upload/simpleuploader?Type=File"
				flashUploadURL="/editor/filemanager/upload/simpleuploader?Type=Flash">										
				<%=conRe%>					
			</FCK:editor>
	
	</td>
</tr>
</table>
 <p>
<table width="90%" border="0" cellpadding="2" cellspacing="0">
		<tr>
		<td align=center>		
			<a href="javascript:goWrite()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>
			<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif" align="absmiddle"></a>				
	  		<a href="javascript:opener.location.href='<%=urlPage%>rms/admin/bunsho/listForm.jsp?page=<%=openerPg%>';window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>		
		</td>
	</tr>
</table>
</center>	
</form>
 
</center>
</body>
</html>
<script language="JavaScript"> 
function goPgList() {
	var frm=document.memberInput;
	frm.action = "<%=urlPage%>rms/admin/seizo/commentList_pop.jsp";	
	frm.pg.value="List";	
  	frm.submit();
}
function show01(){	document.getElementById("show").style.display=''; }
function show02(){	document.getElementById("show").style.display='none'; }
function cateReset() {  
	document.memberInput.reset();	 
	var oEditor=FCKeditorAPI.GetInstance('content');
	var div=document.createElement("DIV");
		div.innerHTML=oEditor.GetXHTML();
	 	oEditor.SetHTML(" "); 	 	
}
</script>
