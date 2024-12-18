<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
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
String parentId = request.getParameter("parentId");
    String pcode = "";		
    ProductBean product =null;
    if (parentId != null) {
        ProductManager manager = ProductManager.getInstance();
        product = manager.select(Integer.parseInt(parentId));
        if (product != null) {
			pcode = product.getPcode()+"_";			
        }
    }	

%>

<script type="text/javascript">
// 카테고리 코드 가져오기
function checkCode(){		
	openNoScrollWin("popCode.jsp", "category", "카테고리선택", "400", "540","&kind=1");
}
function returnPopcode(pseq,pcode1,pcode2 ,pcode3){
var frm = document.venderChk;
		frm.category.value = pcode1+"> "+pcode2+"> "+pcode3;
		frm.bseq.value = pseq;
		frm.pname.focus();	
}	
	

function goWrite(){
	var frm = document.venderChk;	
	if(isEmpty(frm.title, "title을 입력해 주세요!")) return;
		
if ( confirm("등록하시겠습니까?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>admin/product/add.jsp";	
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">		
	<tr>		
    		<td width="100%"  height="30" style="padding: 0 0 0 0"  class="calendar7">
    				<img src="<%=urlPage%>images/common/icon_ball.gif" >
				<img src="<%=urlPage%>images/common/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/icon_ball.gif" style="filter:Alpha(Opacity=30);">신규등록...개별등록
    		</td>    		
	</tr>	
</table>	
<table width="95%" border="0" cellspacing="0" cellpadding="0">	
	<tr>		    
		<td style="padding: 5 0 2 15" width="60%">
			<img src="<%=urlPage%>images/common/icon_jirusi.gif" align="absmiddle">코드는 자동으로 생성됩니다. 
		</td>			
	</tr>		
</table><p>
<!-- 내용 시작 *****************************************************************-->
				  
<table  width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">
		<form action="<%=urlPage%>admin/product/product.jsp?pg=insert&left=product" method="post"  name="venderChk"  enctype="multipart/form-data">	
						<input type="hidden" name="bseq" >		
						<input type="hidden" name="ymd" value="<%=today%>">	
						<input type="hidden" name="level" value="${product.level+1}">
						<c:if test="${! empty param.groupId}">
						<input type="hidden" name="groupId" value="${param.groupId}">
						</c:if>
						<c:if test ="${! empty param.parentId}">
						<input type="hidden" name="parentId" value="${param.parentId}">
						</c:if>		
		<tr>
			<td bgcolor= "#F7F5EF" style="padding: 5 0 5 10" class="calendar9">
				<img src="<%=urlPage%>images/common/icon_s.gif" >
				<img src="<%=urlPage%>images/common/icon_s.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/icon_s.gif" style="filter:Alpha(Opacity=30);">기본정보</td>
		</tr>
		<tr>
			<td align="center" style="padding: 0 0 30 0">						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
								<tr>
									<td style="padding: 0 0 0 0" width="15%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										カテゴリ</td>																	
									<td style="padding: 5 0 0 0" width="85%">
										<input type="radio" name="category" value="1" checked >コンドロン(Chondron)									
										<input type="radio" name="category" value="2"  >コラーゲン(Collagen)
										<input type="radio" name="category" value="3"  >医療機器
										
									</td>
								</tr>								
								<tr>
									<td style="padding: 0 0 0 0"  bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										タイトル</td>																	
									<td style="padding: 5 0 0 0" >
										<input type="text" NAME="pname"  VALUE="" SIZE="20" maxlength="120"  class="logbox" style="width:350px">
										<font color="#807265">(▷100字まで入力できます。)</font>
									</td>
								</tr>								
								
								<tr>
									<td style="padding: 0 0 0 0"  bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/icon_s.gif" >
										ユーザーのページで見える</td>																	
									<td style="padding: 5 0 0 0" >
										<input type="radio" name="pviewyn" value="1" checked>はい									
										<input type="radio" name="pviewyn" value="2"  >いいえ						
									</td>
								</tr>			
					</table>
				</td>
			</tr>
	</table>
	<p>
	
	<p>
	<table  width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
				<tr>
					<td bgcolor= "#F7F5EF" style="padding: 5 0 5 10" class="calendar9">
					<img src="<%=urlPage%>images/common/icon_s.gif" >
					<img src="<%=urlPage%>images/common/icon_s.gif" style="filter:Alpha(Opacity=60);">
					<img src="<%=urlPage%>images/common/icon_s.gif" style="filter:Alpha(Opacity=30);">이미지 정보
					</td>
				</tr>
				<tr>
					<td bgcolor= "#F7F5EF" style="padding: 0 0 0 40" >					
									<font color="#807265">
									▷원본 이미지의 파일명은 자동으로 바뀝니다.<br>
									▷원본 이미지 사이즈는 퀄리티를 위해 <b>134*100</b>으로 제한해주세요!!!<br>									
									</font>
					</td>
				</tr>
				<tr>
					<td align="center" style="padding: 0 0 30 0">											
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>												
							<tr>
								<td style="padding: 5 0 0 0" width="15%"><img src="<%=urlPage%>image/icon_s.gif" >
								메인 이미지</td>																	
								<td style="padding: 5 0 0 0" width="85%">
									<input type="file" name="imageFile" value="Find" size="100" style="cursor:pointer"  onChange='dreamkos_imgview()' class="logbox">
														
								</td>
							</tr>							
						</table>						
			</td>			
		</tr>	
															 		
</table>
<p>
<table  width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
				<tr>
					<td bgcolor= "#F7F5EF" style="padding: 5 0 5 10" class="calendar9" width="50%">
					<img src="<%=urlPage%>images/common/icon_s.gif" >
					<img src="<%=urlPage%>images/common/icon_s.gif" style="filter:Alpha(Opacity=60);">
					<img src="<%=urlPage%>images/common/icon_s.gif" style="filter:Alpha(Opacity=30);">상품설명서
					</td>
					<td  align="right" width="50%" style="padding: 5 28 5 10"><select id="cmbLanguages" onchange="ChangeLanguage(this.value);"></select></td>	
				</tr>				
				<tr>
					<td align="center" style="padding: 0 0 30 0" colspan="2">											
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>												
							<tr>
								<td style="padding: 5 0 0 0" width="100%" align="center">
					
<!--								<FCK:editor id="content" basePath="/fckeditor/"
									width="700"
									height="500"
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
									
-->						
									<FCK:editor id="content" basePath="/orms/fckeditor/"
									width="700"
									height="500"				
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
			
			
			
			
			
			
			
			
			