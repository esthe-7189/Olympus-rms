<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>	
<%@ page import = "mira.job.Category" %>
<%@ page import = "mira.job.CateMgr" %>
<%@ page import = "mira.job.JobBean" %>
<%@ page import = "mira.job.JobMgr" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	
String id=(String)session.getAttribute("ID");
String seq=request.getParameter("seq");
JobMgr managerMain = JobMgr.getInstance();		
JobBean info=managerMain.getJobItem(Integer.parseInt(seq));
int lcate=info.getCate_L_seq();
int mcate=info.getCate_M_seq();

//category
String parentId = request.getParameter("parentId");	
String bseqModi = request.getParameter("bseqModi");	
String modi = request.getParameter("modi");	
if(modi==null){modi="no";}

int grid=0; int levelVal=0; int bseq=0; int cateNo=0;
String title="";

CateMgr manager = CateMgr.getInstance();
Category board = null;
    if (parentId != null) {        
        board = manager.select(Integer.parseInt(parentId));        
    } 

//항목 수정시 사용
Category boardModi = null;
if(bseqModi !=null){
	boardModi = manager.select(Integer.parseInt(bseqModi));
	title=boardModi.getName();        
}
List  list=manager.selectListAdminLevel(0,1);

%>
<c:set var="board" value="<%= board %>" />
<c:set var="boardModi" value="<%= boardModi %>" />
<c:set var="list" value="<%= list %>" />
<c:set var="info" value="<%= info %>" />

<script language="javascript">
function goWrite01(){
var frmL = document.formlgroup;
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点(,)は使わないで下さい")) return ;	
	if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
	frmL.action = "<%=urlPage%>admin/job/cateInsert01_view.jsp";	
	frmL.submit();
}
</script>	
<script language="javascript">	
function contentWite(){
  var frm = document.formContent;
  var frmCate = document.formcategory;
  var frmyn=document.formlgroup;
  	 if (frmyn.fileKind[1].checked==true)	{		
		if(isEmpty(frmCate.lgroup_name, "(1)の大分類カテゴリを選択して下さい")) return ; 
       	if(isEmpty(frmCate.mgroup_name, "(2)の中分類カテゴリを選択して下さい")) return ;	
       	frm.cate_L_seq.value=frmCate.lgroup_code.value;
	       frm.cate_M_seq.value=frmCate.mgroup_code.value;            
	       if(frmCate.mgroup_name.value==""){frm.cate_seq.value=frmCate.lgroup_code.value;}
	       else{frm.cate_seq.value=frmCate.mgroup_code.value;} 
	}		       	   
       
	if(isEmpty(frm.title, "タイトルを入力して下さい")) return ;         	
  	 if ( confirm("上の内容を修正しますか?") != 1 ) { return; }	
	 frm.action = "<%=urlPage%>admin/job/update.jsp";	
	 frm.submit();
}
function goInit(){
	var frm = document.formContent;
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
    		<td colspan="2" align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">採用情報管理
    		</td>    		
	</tr>	
	<tr>		
    		<td  colspan="2" width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
	<tr>		
    		<td width="90%" align="right"  style="padding-right:2px;padding-top:10px" >
				<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/job/jobList.jsp'" id="List!"  title="List!" class="button buttonGeneral" />					
		</td>
		<td width="10%" style="padding-right:30px;padding-top:10px" >
				<input type="button" name="" value="書く" onclick="location.href='<%=urlPage%>admin/job/cateAddForm.jsp'" id="Write"  title="Write!" class="button buttonGeneral" />					
		</td>	
	</tr>
</table>	
<!-- category begin *****************************************************************-->
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#EAE3DE">
	<form name="formlgroup" method="post"  action="<%=urlPage%>admin/job/cateInsert01_view.jsp" onSubmit="return goWrite01(this)" >								
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar9">
			<font color="#007AC3">(1)</font>  カテゴリ修正<br></td>			
		</tr>
		<tr>
			<td align="center" colspan="2" bgcolor="#F7F5EF">						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>																
								<tr>
									<td align="left"  style="padding-left:10px"  width="20%"  bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										大分類 / 中分類</td>																	
									<td align="left"  style="padding-left:10px"  width="80%">
	<%board=manager.select(lcate);
		if(board!=null){%><%=board.getName()%> /
	<%}else{%>No Data
	<%}%>	
		
	<%board=manager.select(mcate);
		if(board!=null){%><%=board.getName()%>
	<%}else{%>No Data
	<%}%>	
									
									</td>
								</tr>
								<tr>
									<td align="left"  style="padding-left:10px"  width="20%"  bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										大分類 / 中分類の変更</td>																	
									<td align="left"  style="padding-left:10px"  width="80%">
										<input type="radio" onfocus="this.blur()"  name="fileKind" value="1"  onClick="selectFile()"  checked>No&nbsp;
										<input type="radio" onfocus="this.blur()"  name="fileKind" value="2"  onClick="selectFile()" >Yes
									</td>
								</tr>										
						</table>
				</td>
			</tr>	
</table>
<div id="file_01"  style="display:none;">				  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">			
			<c:if test="${! empty board}">
		<input type="hidden" name="bseq" value="${board.bseq}">	
			</c:if>
			<c:if test="${empty board}">
		<input type="hidden" name="bseq" value="0">	
			</c:if>			
			<c:if test="${! empty param.groupId}">
		<input type="hidden" name="groupId" value="${param.groupId}">
			</c:if>
			<c:if test ="${! empty param.parentId}">
		<input type="hidden" name="parentId" value="${param.parentId}">
			</c:if>						
		<input type="hidden" name="level" value="${board.level + 1}">
		<input type="hidden" name="cateNo" value="">	
		<input type="hidden" name="modi" value="">		
		<input type="hidden" name="bseqModi" value="">	
		<input type="hidden" name="groupIdDel" value="">					
		<input type="hidden" name="nameModi" value="">		
		<tr>
			<td align="left"  style="padding-left:30px;padding-top:10px" >
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >  まず、カテゴリを選択してから下の<font color="#007AC3">(2)</font>コンテンツの登録フォームに内容を書いて下さい。<br>
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >   新しいカテゴリの登録は [大分類]==> [中分類]の順番に記入します。
			</td>			
		</tr>	
		<tr>
			<td align="center" >						
				<table width="75%" >					
					<tr>
						<td width="45%" bgcolor="#F1F1F1">
							<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>																
								<tr>
								        <td height="20" align="center"><b> [大分類]</b></td>
								 </tr>
									<td align="left"  style="padding-left:10px" valign="middle" height="200">
<!-- 대분류 category begin-->	
	          <div align="center" > 
	            <select class="normal" style="border:0;HEIGHT:111px;WIDTH:200px;" onChange="doselectLcode();" multiple size="7" name="selectlg">
<c:if test="${empty list}">				
			    	<option value="0">Data is not!!</option>			    		
</c:if>	
		
<c:if test="${! empty list}">
<%
int i=1;
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		Category cate=(Category)listiter.next();
		bseq=cate.getBseq();	
		grid=cate.getGroupId();
		levelVal=cate.getLevel();		
		cateNo=cate.getCateNo();		
%>	  
		<option value="<%=bseq%>"><%=cate.getName()%></option>
<%
i++;
}												  													  
%>	
</c:if>			
	            </select><br>	
				<textarea name="name" cols="30" rows="2"><%=title%></textarea><br>	
				<a href="javascript:goWrite01('<%=grid%>');" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_write.gif"  align="absmiddle" alt="write"></a>
				<a href="javascript:goModify('<%=cateNo%>');" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_update.gif"  align="absmiddle" alt="modify"></a>	
				<a href="javascript:cateDel('<%=levelVal%>','<%=grid%>')"  onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_cancel.gif" align="absmiddle" alt="delete"></a>	
	          </div>				
<!-- 대분류 category end-->
</form>											
									</td>
								</tr>									
							</table>
						</td>
						<td width="10%"><img src="<%=urlPage%>images/admin/icon_jirusi.gif"  align="absmiddle" ></td>	
						<td width="45%" align="left" bgcolor="#F1F1F1">					
<!-- 중분류 category begin -->
	    <table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2 >
	      <tr> 
	        <td height="20" align="center"><b> [中分類] </b></td>
	      </tr>
	      <tr>
	        <td align="left"  style="padding-left:10px" valign="middle" height="200">
	      <div align="center" > 
	       <%if(id!=null){%>
	        	<iframe name="mgroupframe" src="Mgroup.jsp" scrolling="no" frameborder="0" width="100%" height="180"></iframe>
	       <%}else{%>
	       	<img src="<%=urlPage%>images/admin/btn_admin_update.gif" align="absmiddle" alt="登録">
	       <%}%>
	       </div>
	        </td>
        </tr>
      </table>
<!-- /중 end -->
									
						</td>						
					</tr>												
				</table>
			</td>
		</tr>
</table>	
<table  width="100%" border="0" cellspacing="0" cellpadding="0"  style="padding-top:10px">
	<form name=formcategory method=post >									
	<tr>
		<td height="10" valign="middle"  width="100%">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle"><span class="fontBb"> 選択された項目: </span> 
			<input type=text size="40" class=input02 readonly name="lgroup_name" value="
	<%board=manager.select(lcate);
		if(board!=null){%><%=board.getName()%>
	<%}else{%>No Data
	<%}%>					
							"> > 
			<input type='hidden' name="lgroup_code" value="<%=lcate%>">
			<input type=text size="40" class=input02 readonly name="mgroup_name" value="
	<%board=manager.select(mcate);
		if(board!=null){%><%=board.getName()%>
	<%}else{%>No Data
	<%}%>					
							"> 
			<input type='hidden' name="mgroup_code" value="<%=mcate%>">			
			<input type='hidden' name="list_cate_seq">						
		</td>
	</tr>	
</form>
</table>
</div>
<p>
<!-- item begin *****************************************************************-->				  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#EAE3DE">								
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar9">
			<font color="#007AC3">(2)</font>  コンテンツの修正<br></td>			
		</tr>	
</table>	
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">
	<form action="<%=urlPage%>admin/job/add.jsp" method="post"  name="formContent"  onSubmit="return contentWite(this)" >	
			<input type='hidden' name="cate_seq" value="<%=info.getCate_seq()%>">	
			<input type='hidden' name="cate_L_seq" value="<%=info.getCate_L_seq()%>">	
			<input type='hidden' name="cate_M_seq" value="<%=info.getCate_M_seq()%>">
			<input type='hidden' name="seq" value="<%=seq%>">		
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">
				コンテンツの登録</td>
			<td align="right" width="85%" style="padding-right:30px" ><font color="#CC0000">※</font>必修項目</td>				
			
		</tr>
		<tr>
			<td align="center" colspan="2">						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>																
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										タイトル</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="text" NAME="title"  VALUE="<%=info.getTitle()%>" SIZE="20" maxlength="50"  class="logbox" style="width:550px">
										<font color="#807265">(▷50字まで入力できます。)</font>
									</td>
								</tr>									
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
										ユーザーのページに見える</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="radio" name="view_yn" value="1" <c:if test="${info.view_yn==1}">checked</c:if>>はい									
										<input type="radio" name="view_yn" value="2" <c:if test="${info.view_yn==2}">checked</c:if> >いいえ																
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
								<td  width="100%" align="center">
					
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
									<%=info.getContent()%>
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
									<%=info.getContent()%>
									</FCK:editor>	
-->																			
								</td>							
						</tr>
				</table>
			</td>			
		</tr>									 		
</table>
<table  width="100%" border="0" cellspacing="0" cellpadding="0" >									   
	<tr align="center">
			<td style="padding-top:0px;">
				<a href="javascript:contentWite();"><img src="<%=urlPage%>images/common/btn_off_submit.gif" ></A>
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>
</form>
</table>
<p>
<!-- item end *****************************************************************-->				
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>			
<script language='JavaScript'>
//각 iframe의 url
var mgroupurl  = "<%=urlPage%>admin/job/Mgroup.jsp";
// var sgroupurl  = "<%=urlPage%>admin/job/Sgroup.jsp";
var delpage= "<%=urlPage%>admin/job/cateDel.jsp";
var listForm="<%=urlPage%>admin/job/cateAddForm.jsp";
var modiOk="<%=urlPage%>admin/job/cateModi.jsp";

//대분류 목록을 선택 했을때
function doselectLcode(kind) {
  var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
  var lname = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].text;    
	
	document.formlgroup.name.value  = lname;	
	document.formcategory.lgroup_name.value  = lname;
	document.formcategory.lgroup_code.value  = lgroup;		
  	mgroupframe.document.location = mgroupurl + "?lgroup=" + lgroup;
//	sgroupframe.document.location = sgroupurl  + "?lgroup=" + lgroup;
	
}

function cateDel(level,groupId) {
	var frmL = document.formlgroup;
	if(isEmpty(frmL.selectlg, "項目を選択して下さい")) return  ;
	var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;

	if ( confirm("上の内容を本当に削除しますか?") != 1 ) { return; }	
		
	document.formlgroup.action = delpage;
    	document.formlgroup.bseqModi.value = lgroup;
    	document.formlgroup.level.value = level;
    	document.formlgroup.groupIdDel.value = groupId;
    	document.formlgroup.submit();
}

function goModify(cateNo){	
	var frmL = document.formlgroup;
	var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;		
	if(isEmpty(frmL.name, "項目を選択及び入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;		
	if ( confirm("上の内容を修正しますか?") != 1 ) { return; }	
	
	document.formlgroup.action = modiOk;
    	document.formlgroup.bseq.value = lgroup;
    	document.formlgroup.nameModi.value = frmL.name.value;
    	document.formlgroup.cateNo.value = cateNo;    	
    	document.formlgroup.submit();
    	
}
</script>
<script language="JavaScript">
var f=document.formlgroup;
var d=document.all;	

function selectFile(){		
	if (f.fileKind[0].checked==true)	{				
		d.file_01.style.display="none";		
	}else if (f.fileKind[1].checked==true)	{		
		d.file_01.style.display="";		
	}		
}
</script>			
			
			