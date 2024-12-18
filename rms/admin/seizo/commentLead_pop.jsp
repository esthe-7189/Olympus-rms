<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.seizo.SeizoBean" %>
<%@ page import="mira.seizo.SeizoMgr" %>
<%@ page import = "mira.seizo.Category" %>
<%@ page import = "mira.seizo.CommentMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
String pg=request.getParameter("pg");
String openerPg=request.getParameter("openerPg");
String ip_info=(String)request.getRemoteAddr();

CommentMgr manager = CommentMgr.getInstance();
Category board = manager.select(Integer.parseInt(bseq));        
   String conValue=board.getContent();	
   
   //Hit
  	manager.hit(Integer.parseInt(bseq));  
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

<script type="text/javascript">
function goWrite() { 
var frm=document.memberInput;
var frmMail=document.mailCk;
    with (document.memberInput) {
        if (chkSpace(title.value)) {
   	    	alert("タイトルを書いてください.");
            title.focus();    return ;              
         }else if (chkSpace(name.value)) {
            alert("作成者を書いてください.");
            name.focus();   return ;        
         }
    }
    
  
   if(frm.mail_yn[0].checked == true){	
	if(!isVaildMail(frm.mail_address.value)) {
		alert("メールを正しく書いて下さい。特殊文字などは入力不可能です。!"); return ;
	 }
   }else{
	  frm.mail_address.value=frmMail.mail_address.value;	  
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
		
		if ( confirm("修正しますか?") != 1 ) {
			return ;
		}
	document.memberInput.action = "<%=urlPage%>rms/admin/seizo/commentModi_pop.jsp";	
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
	window.status = editorInstance.Description ;
}
</script>	

<script type="text/javascript">
function popup_Layer(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     // 좌우 위치 지정
     if(_marginx < 0){
        main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px";
     }
     else{
        main.style.left = event.clientX + document.body.scrollLeft-5+"px";
     }
     //높이 지정
     if(_marginy < 0){
        main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";
     }  
     else{
        main.style.top = event.clientY + document.body.scrollTop-5+"px";
     } 

}  

function Layer_popup_Off() { 
  var frm=document.memberInput;
  var pay_len = eval(frm.divPass.length);  
  var pay_val=frm.divPass;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
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
	<form name="mailCk">
		<input type="hidden" name="mail_address" value="${board.mail_address}">	
	</form>		
	<tr>		
		<td width="90%"  height="" style="padding: 5 0 0 20"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">コメントリスト <font  color="#FF6600">></font>

<c:choose>
	<c:when test="${param.file_kind=='1'}">			
		      	記録書原文(ORMS)	
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
<form name="memberInput" action="<%=urlPage%>rms/admin/seizo/commentModi_pop.jsp" method="post"  onSubmit="return goWrite(this)" >					
		<input type="hidden" name="file_bseq" value="${param.file_bseq}">	
		<input type="hidden" name="bseq" value="${param.bseq}">	
		<input type="hidden" name="file_kind" value="${param.file_kind}">	
		<input type="hidden" name="pg" value="${param.pg}">	
		<input type="hidden" name="hit_cnt" value="${board.hit_cnt}">		
		<input type="hidden" name="add_ip" value="${board.add_ip}">	
		<input type="hidden" name="groupId" value="${board.groupId}">
		<input type="hidden" name="parentId" value="${board.parentId}">					
		<input type="hidden" name="level" value="${board.level}">	
		<input type="hidden" name="pass" value="">	
		<input type="hidden" name="openerPg" value="<%=openerPg%>">		
		<tr>
	    		<td style="padding: 0 0 0 20" align="right">  
	    			<a href="javascript:goPgList()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_coment_list.gif" align="absmiddle"></a>
	    			<a href="<%=urlPage%>rms/admin/bunsho/commentWrite_pop.jsp?file_kind=<%=file_kind%>&file_bseq=<%=file_bseq%>&openerPg=<%=openerPg%>"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_coment_write.gif" align="absmiddle"></a>
	    			<a href="javascript:goPgKotae()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_coment_kotae.gif" align="absmiddle"></a>
	    			<a href="javascript:goPgEditor()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif" align="absmiddle"></a>
<input type="hidden" name="divPass" value="popup_1">		
<!-- *****************************레이어 start-->
<div id="popup_1" style="position:absolute; left:0px; top:0px; z-index:999;display:none;border:#FFCCCC;filter: alpha(opacity=80);" >
	<table border="0" width="170" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td ><img src="<%=urlPage%>rms/image/user/title_board_passLayer.gif" ></td>
		     	<td align="right"><a onclick="Layer_popup_Off();"  style="CURSOR: pointer;"><img src="<%=urlPage%>rms/image/user/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="170" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	
         <tr>
                 	<td valign="top" width="80%" valign="middle" style="padding:5 0 5 10;" ><img src="<%=urlPage%>rms/image/icon_s.gif" >password</td>
            		<td valign="top" width="20%" valign="bottom" style="padding:15 0 5 3;" rowspan="2">
			<a href="javascript:goDelete('${board.bseq}','${board.level}','${board.groupId}');" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/ic_go.gif" align="asbmiddle"></a>
            		</td>
            </tr>
            <tr>			         
			<td  valign="top" valign="middle" style="padding:0 0 5 10;" ><input type="text" name="passVal" value="" size="20" class="logbox" style="width:100px;ime-mode:disabled"></td>
	</tr>	
     </table>
</div>
<!-- ********************************레이어 end -->
	<a onclick="popup_Layer(event,'popup_1');" style="CURSOR: pointer;"><img src="<%=urlPage%>rms/image/admin/btn_coment_del.gif" align="absmiddle"></a>  		    						    		    	   				
	    		</td> 
		</tr>							
</table>
<table width="95%" border="0" cellpadding="0" cellspacing="0" class=c>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="12%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
	<td  style="padding: 3 3 3 3" width="38%">
		<c:if test="${param.pg=='lead'}">
			${board.title}	 
		</c:if>
		<c:if test="${param.pg=='mody'}">
			<font color="red">*</font>
			<input type="text" name="title" value="${board.title}" size="40" maxlength="120" class="input02" style="width:170px" >	
		</c:if>					
	</td>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" >日付/訪問数:</td>
	<td   style="padding: 3 3 3 3" class="msmall" width="35%">
		<fmt:formatDate value="${board.register}" pattern="yyyy-MM-dd" /> / <font  color="#FF6600">(${board.hit_cnt})</font>			 
	</td>       
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="12%"><img src="<%=urlPage%>rms/image/icon_s.gif" >作成者:</td>
	<td   style="padding: 3 3 3 3"  width="38%">
		<c:if test="${param.pg=='lead'}">
			${board.name}
		</c:if>
		<c:if test="${param.pg=='mody'}">
			<font color="red">*</font>
			<input type="text" name="name" value="${board.name}" size="40" maxlength="50" class="input02" style="width:170px" >	
		</c:if>
		
	</td> 
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" >メール:</td>
	<td   style="padding: 3 3 3 3" width="35%">
		<c:if test="${param.pg=='lead'}">
			<a href="mailto:${member.mail_address}?subject=olympus-rms comment">${board.mail_address}</a>
		</c:if>
		<c:if test="${param.pg=='mody'}">
			<input type="radio" name="mail_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">Yes</font>
			<input type="radio" name="mail_yn" value="2" onClick="show02()" onfocus="this.blur()"  checked><font  color="#FF6600">No</font><br>		 
					<div id="show" style="display:none;">	
						<input type="text" name="mail_address" value="${board.mail_address}" size="40" maxlength="80" class="input02" style="width:170px;ime-mode:disabled">	
					</div>			
		</c:if>			 
	</td>     
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >返事要求:</td>
	<td   style="padding: 3 3 3 3" >
		<c:if test="${param.pg=='lead'}">
			<c:if test="${board.henji_yn==0}"><font  color="#FF6600">はい</font> </c:if>
			<c:if test="${board.henji_yn==1}">いいえ </c:if>
		</c:if>
		<c:if test="${param.pg=='mody'}">
			<input type="radio" name="henji_yn"  value="0"  onfocus="this.blur()"  <c:if test="${board.henji_yn==0}">checked </c:if> >はい &nbsp;
			<input type="radio" name="henji_yn"  value="1"  onfocus="this.blur()" <c:if test="${board.henji_yn==1}">checked </c:if> ><font  color="#FF6600">いいえ</font>		
		</c:if>			
	</td>  			
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >返事の結果:</td>
	<td   style="padding: 3 3 3 3" >			
		<c:if test="${param.pg=='lead'}">
			<c:if test="${board.ok_yn==0}"><font  color="#FF6600">未決</font> </c:if>
			<c:if test="${board.ok_yn==1}">完了</c:if>
		</c:if>
		<c:if test="${param.pg=='mody'}">
			<input type="radio" name="ok_yn"  value="0"  onfocus="this.blur()"  <c:if test="${board.ok_yn==0}">checked </c:if> ><font  color="#FF6600">未決</font> &nbsp;
			<input type="radio" name="ok_yn"  value="1"  onfocus="this.blur()" <c:if test="${board.ok_yn==1}">checked </c:if> >完了		
		</c:if>				
	</td>     	    
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td  bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >コメント:</td>  
	<td  colspan="3" style="padding: 3 3 3 3" height="80"  valign="top">
		<c:if test="${param.pg=='lead'}">
			<div style="height:200;overflow-y:auto;">	
				<table width="100%" height="400" border=0 cellpadding=0 cellspacing=0  valign="top"><tr>
					<td valign="top"><%=conValue%></td>
				</tr></table>
			</div>		
		</c:if>
		<c:if test="${param.pg=='mody'}">
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
				<%=conValue%>					
			</FCK:editor>				
				
		</c:if>		
			
	
	</td>
</tr>
</table>
 <p>
<table width="90%" border="0" cellpadding="2" cellspacing="0">
		<tr>
		<td align=center>		
	<%if(pg.equals("lead")){%>
		<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>	
	<%}else{%>
		<a href="javascript:goWrite()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>
		<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif" align="absmiddle"></a>				
	  	<a href="javascript:opener.location.href='<%=urlPage%>rms/admin/bunsho/listForm.jsp?page=<%=openerPg%>';window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>		
	<%}%>			
		</td>
	</tr>
</table>
</center>	
</form>
 
</center>
</body>
</html>
		 
<script language="JavaScript">
 function goPgWrite() {
	var frm=document.memberInput;
	frm.action = "<%=urlPage%>rms/admin/seizo/commentWrite_pop.jsp";	
	frm.pg.value="write";	
  	frm.submit();
}
 function goPgEditor () {
	var frm=document.memberInput;
	frm.action = "<%=urlPage%>rms/admin/seizo/commentLead_pop.jsp";	
	frm.pg.value="mody";	
  	frm.submit();
}
function goPgList() {
	var frm=document.memberInput;
	frm.action = "<%=urlPage%>rms/admin/seizo/commentList_pop.jsp";	
	frm.pg.value="List";	
  	frm.submit();
}
function goPgKotae() {
	var frm=document.memberInput;
	frm.action = "<%=urlPage%>rms/admin/seizo/commentKotae_pop.jsp";	
	frm.pg.value="kotae";	
  	frm.submit();
}
 function goDelete(bseq,level,groupId) {
 	var frm=document.memberInput;	
	var passValue=eval("frm.passVal.value");  			
	frm.bseq.value = bseq;
	frm.pass.value = passValue;		
	frm.level.value=level;	
	frm.groupId.value=groupId;	
	frm.file_bseq.value=<%=file_bseq%>;	
	frm.file_kind.value=<%=file_kind%>;			
    	frm.action = "<%=urlPage%>rms/admin/seizo/commentDel_pop.jsp";	
    	frm.submit();
}
</script>
<script type="text/javascript">
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

















