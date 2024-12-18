<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>	
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>
<%! SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");	%>
<%
String today=formatter.format(new java.util.Date());	
String urlPage=request.getContextPath()+"/orms/";	
String pseq=request.getParameter("pseq");
ProductManager manager = ProductManager.getInstance();	
ProductBean product=manager.getProduct(Integer.parseInt(pseq));
%>
<c:set var="product" value="<%=product%>"/>

<script type="text/javascript">
// 카테고리 코드 가져오기


function goWrite(){
	var frm = document.resultform;	
	if(isEmpty(frm.title_m, "メイン　タイトルを書いて下さい!")) return;
	if(isEmpty(frm.title_s, "サブ　タイトルを書いて下さい")) return;
		
if ( confirm("書き直ししましょうか?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>admin/product/update.jsp";	
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
	window.location.href = window.location.pathname + "?code=" + languageCode  ;
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
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=30);">製品情報管理
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
</table>	
<p>
<!-- 내용 시작 *****************************************************************-->
<c:if test="${empty product}">
	<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">Data is not!!!!!!
			</td>
		</tr>	
	</table>	
</c:if>
<c:if test="${! empty product}">					  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">
		<form action="<%=urlPage%>admin/product/update.jsp" method="post"  name="resultform"  enctype="multipart/form-data">		
						<input type="hidden" name="pseq" value="${product.pseq}">		
						<input type="hidden" name="ymd" value="<%=today%>">	
						<input type="hidden" name="pcode" value="${product.pcode}">
						<input type="hidden" name="pcode_pg" value="">							
						<input type="hidden" name="category_db" value="${product.category}">	
						
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">
				<img src="<%=urlPage%>images/common/ArrowNews.gif">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=30);">書き直し</td>
			<td align="left" width="65%" style="padding-top:10px" ><font color="#CC0000">※</font>必修項目</td>
			<td align="right" width="10%" style="padding-right:1px;padding-top:10px" >
				<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/product/product.jsp'" id="List!"  title="List!" class="button buttonGeneral" />	
			</td>
			<td align="right" width="10%" style="padding-right:30px;padding-top:10px" >								
				<input type="button" name="" value="書く" onclick="location.href='<%=urlPage%>admin/product/addForm.jsp'" id="Write!"  title="Write!" class="button buttonGeneral" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="4">						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
								<tr>
									<td align="left"  style="padding-left:10px"  width="15%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										カテゴリ</td>																	
									<td align="left"  style="padding-left:10px"  width="85%">
										<input type="radio" name="category" value="1" <c:if test="${product.category==1}">checked</c:if> >自家軟骨細胞									
										<input type="radio" name="category" value="2"  <c:if test="${product.category==2}">checked</c:if> >コラーゲン(Collagen)
										<input type="radio" name="category" value="3"  <c:if test="${product.category==3}">checked</c:if> >医療機器
										
									</td>
								</tr>																
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										タイトル_Main</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="text" NAME="title_m"  VALUE="${product.title_m}" SIZE="20" maxlength="120"  class="logbox" style="width:550px">
										<font color="#807265">(▷100字まで入力できます。)</font>
									</td>
								</tr>								
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										タイトル_Sub</td>																	
									<td align="left"  style="padding-left:10px"  >
										<TEXTAREA  name="title_s"  cols="100" rows="5" wrap="hard" >${product.title_s}</TEXTAREA>
										
									</td>
								</tr>		
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
										ユーザーのページで見える</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="radio" name="view_yn" value="1" <c:if test="${product.view_yn==1}">checked</c:if>>はい									
										<input type="radio" name="view_yn" value="2" <c:if test="${product.view_yn==2}">checked</c:if> >いいえ						
									</td>
								</tr>	
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
										サブ　メイン　イメージ</td>																	
									<td align="left"  style="padding-left:15px"  colspan="2">
										<input type="file" name="imageFile" value="Find" size="100" style="cursor:pointer"  onChange='dreamkos_imgview()' class="logbox"><br><br>
										<font color="#807265">(▷イメージのサイズは <b>134*100</b>に限って下さい!!)</font>
														
									</td>
								</tr>					
					</table>
				</td>
			</tr>
	</table>	
<p>
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
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
									width="90%"
									height="500"
									autoDetectLanguage="<%=autoDetectLanguageStr%>"
									defaultLanguage="<%=defaultLanguageStr%>"
									imageBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/editor/filemanager/browser/default/connectors/jsp/connector" 				
									linkBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
									flashBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
									imageUploadURL="/editor/filemanager/upload/simpleuploader?Type=Image"
									linkUploadURL="/editor/filemanager/upload/simpleuploader?Type=File"
									flashUploadURL="/editor/filemanager/upload/simpleuploader?Type=Flash">										
									${product.content}
							</FCK:editor>
									
<!--					
									<FCK:editor id="content" basePath="/orms/fckeditor/"
									width="90%"
									height="500"				
									autoDetectLanguage="<%=autoDetectLanguageStr%>"
									defaultLanguage="<%=defaultLanguageStr%>"
									imageBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector" 				
									linkBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector"
									flashBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector"
									imageUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=Image"
									linkUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=File"
									flashUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=Flash">										
									${product.content}
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
			
<script language='javascript'>
<!--
function dreamkos_imgview()
{
  img_pre = 'pre';
  if(event.srcElement.value.match(/(.jpg|.jpeg|.gif|.png)/)) {
    document.images[img_pre].src = event.srcElement.value;
    document.images[img_pre].style.display = '';
  }
  else {
  document.images[img_pre].style.display = 'none';
  }
}



//-->
</script>			
			
</c:if>			
			
			
			
			
			
			
			