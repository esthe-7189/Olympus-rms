<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>	
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.news.NewsBean" %>
<%@ page import = "mira.news.NewsManager" %>

<%! SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");	%>
<%
String today=formatter.format(new java.util.Date());	
String urlPage=request.getContextPath()+"/orms/";	

%>

<script type="text/javascript">
// 카테고리 코드 가져오기


function goWrite(){
	var frm = document.resultform;	
	if(isEmpty(frm.title, "タイトルを書いて下さい!")) return;	
		
if ( confirm("登録しましょうか?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>admin/news/add.jsp";	
frm.submit();	
	
	
}	
	
function goInit(){
	var frm = document.venderChk;
	frm.reset();
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
	window.location.href = window.location.pathname + "?code=" + languageCode ;
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">ニュース管理
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
</table>	
<p>
<!-- 내용 시작 *****************************************************************-->
				  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">
		<form action="<%=urlPage%>admin/product/add.jsp" method="post"  name="resultform"  >
	
	
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">
				<img src="<%=urlPage%>images/common/ArrowNews.gif">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">書く</td>
			<td align="left" width="75%" style="padding-top:10px" ><font color="#CC0000">※</font>必修項目</td>				
			<td align="right" width="10%" style="padding-right:30px;padding-top:10px" >
				<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/news/newsForm.jsp'" id="List!"  title="List!" class="button buttonGeneral" />					
			</td>
		</tr>
		<tr>
			<td align="center" colspan="3">						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>																
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										タイトル</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="text" NAME="title"  VALUE="" SIZE="20" maxlength="120"  class="logbox" style="width:550px">
										<font color="#807265">(▷100字まで入力できます。)</font>
									</td>
								</tr>									
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
										ユーザーのページで見える</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="radio" name="view_yn" value="1" checked>はい									
										<input type="radio" name="view_yn" value="2"  >いいえ						
									</td>
								</tr>									
					</table>
				</td>
			</tr>
	</table>	
<p>
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF" style="padding-top:10px">		
				<tr>
					<td bgcolor= "#F7F5EF" align="left"  style="padding-left:30px"  width="15%">
					<font color="#CC0000">※</font>詳しい内容
					</td>
					<td align="left" width="45%" ><img src="<%=urlPage%>images/bg/ol_dot.gif" >内容中のイメージ名はアルファベットでお願いします。（例：abcd.gif / abcd.jpg）</td>	
					<td  align="right" width="40%" style="padding-right:30px"><select id="cmbLanguages" onchange="ChangeLanguage(this.value);"></select></td>	
				</tr>				
				<tr>
					<td align="center" colspan="3" width="100%">											
						<table width="100%" border=0 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>												
							<tr>
								<td style="padding: 5 0 0 0" width="100%" align="center">
					
								<FCK:editor id="content" basePath="/fckeditor/"
									width="100%"
									height="400"
									autoDetectLanguage="<%=autoDetectLanguageStr%>"
									defaultLanguage="<%=defaultLanguageStr%>"
									imageBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/editor/filemanager/browser/default/connectors/jsp/connector" 				
									linkBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
									flashBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
									imageUploadURL="/editor/filemanager/upload/simpleuploader?Type=Image"
									linkUploadURL="/editor/filemanager/upload/simpleuploader?Type=File"
									flashUploadURL="/editor/filemanager/upload/simpleuploader?Type=Flash">										
									content
							</FCK:editor>
									
<!--						
									<FCK:editor id="content" basePath="/orms/fckeditor/"
									width="90%"
									height="400"				
									autoDetectLanguage="<%=autoDetectLanguageStr%>"
									defaultLanguage="<%=defaultLanguageStr%>"
									imageBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector" 				
									linkBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector"
									flashBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector"
									imageUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=Image"
									linkUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=File"
									flashUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=Flash">										
									content
									</FCK:editor>	
-->																			
								</td>							
						</tr>
				</table>
			</td>			
		</tr>									 		
</table>
<table align=center>									   
	<tr align="center">
			<td >
				<A HREF="JavaScript:goWrite()"><IMG SRC="<%=urlPage%>images/common/btn_off_submit.gif" ></A>
				&nbsp;
				<A HREF="JavaScript:goInit()"><IMG SRC="<%=urlPage%>images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>
</form>
</table>			

			
			
			