<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "mira.tokubetu.Category" %>
<%@ page import = "mira.tokubetu.CateMgr" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
	MemberManager managermem=MemberManager.getInstance();
	Member member=managermem.getMember(id);
if(id==null){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";	
String urlPagemain=request.getContextPath()+"/";	
String parentId = request.getParameter("parentId");		
String modi = request.getParameter("modi");	
String bseqModi = request.getParameter("bseqModi");	
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
 List listFollow=managermem.selectListSchedule(1,6);  //level 2부터
%>
<c:set var="board" value="<%= board %>" />
<c:set var="boardModi" value="<%=boardModi%>" />
<c:set var="list" value="<%=list%>" />
<c:set var="member" value="<%=member%>" />
<c:set var="listFollow" value="<%= listFollow %>" />
	
<script language="javascript">
function goWrite01(){
	var frmL = document.formlgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点(,)は使わないで下さい")) return ;	
	frmL.action = "<%=urlPage%>tokubetu/admin/file/cateInsert01_view.jsp";	
	frmL.submit();
}
function goWrite(){
var frm=document.input;	
var frmCate = document.formcategory;	    
var nameMseq=frm.sekiningNm.options[frm.sekiningNm.selectedIndex].value;

	if(isEmpty(frmCate.lgroup_name, "文書区分を選択して下さい"))  return ;	

	frm.cate_seq.value=frmCate.lgroup_code.value;
	frm.sekining_mseq.value =nameMseq;
	 if(nameMseq=="0"){alert("担当者を選択して下さい。"); return ;}		
	 
	if(isEmpty(frm.title, "タイトルを入力して下さい。!")) return ;
	if(isEmpty(frm.fileNm, "ファイル選択して下さい。!")) return ;
	
	if ( confirm("ファイルを登録しますか?") != 1 ) {	return ;}
	frm.action = "<%=urlPage%>tokubetu/admin/file/upload.jsp";	
	frm.submit();	
	
}
function goInit(){
	var frm = document.formContent;
	frm.reset();
}
</script>	
	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">決裁書/契約書文書ファイル管理 <font color="#A2A2A2">　></font> 登録 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/file/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/file/cateAddForm.jsp'">			
</div>
<div id="boxNoLine_100"  >		
<label class="calendar11">
			<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">&nbsp;入力の手順 : 
</label>		
	<span class="calendar1_3">文書区分登録及び管理 ==>ファイルの情報</span>
<div class="clear_margin"></div>
<label class="calendar9">
			1) 文書区分登録及び管理
</label>			
	
	
<table width="800"   cellspacing="5" cellpadding="5" >
		<tr>
			<td align="left"  style="padding-left:30px;padding-top:10px"  colspan="2">
			<img src="<%=urlPage%>orms/images/bg/ol_dot.gif" > まず、文書区分を選択してから下の <font color="green">2)ファイルの情報</font>フォームに内容を書いて下さい。<br><br>			
			<img src="<%=urlPage%>orms/images/bg/ol_dot.gif" > もし、探している文書区分が登録されていなかった場合は、次の<font color="red">文書区分追加</font>で登録してください。<br><br>
			<img src="<%=urlPage%>orms/images/bg/ol_dot.gif" > 同じ文書区分を再び、重ねて登録するのは避けて下さい。
			</td>			
		</tr>	
</table>	
	
<table width="800"  class="tablebox" cellspacing="5" cellpadding="5" >		  
	<form name="formlgroup" method="post"  action="<%=urlPage%>tokubetu/admin/file/cateInsert01_view.jsp" >
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
			<td width="40%">文書区分選択	:
				<select class="normal"  onChange="doselectLcode();"  name="selectlg">
<c:if test="${empty list}">				
			    	<option value="0">::::::::::no data!!:::::::::</option>			    		
</c:if>	
				<option value="">::::::::::文書区分選択:::::::::</option>	
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
		<option value="<%=bseq%>">       <%=cate.getName()%>      </option>
<%
i++;
}												  													  
%>	
</c:if>			
	            </select>
			</td>
			<td width="60%">	
				<font color="red">文書区分追加</font>:<textarea name="name" class="textarea" cols="40" rows="2"><%=title%></textarea>
				<a href="javascript:goWrite01('<%=grid%>');" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"　alt="登録"></a>
				<a href="javascript:goModify('<%=cateNo%>');" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuMmodi.gif" align="absmiddle" alt="修正"></a>	
				<a href="javascript:cateDel('<%=levelVal%>','<%=grid%>')"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>			
			</td>	
		</tr>
</form>						
</table>	
<table  width="100%" border="0" cellspacing="0" cellpadding="0"  style="padding-top:10px">
	<form name=formcategory method=post >									
	<tr>
		<td height="10" valign="middle"  width="100%">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif"  align="absmiddle"><span class="fontBb"> 選択された項目: </span> 
			<input type=text size="40" class=input02 readonly name="lgroup_name"> 
			<input type='hidden' name="lgroup_code">			
			<input type='hidden' name="list_cate_seq">						
		</td>
	</tr>	
</form>
</table>
<div class="clear_margin"></div>			
				
<!-- item begin *****************************************************************-->
<label class="calendar9">
				2) ファイルの情報
</label>	  					
<table width="800"  class="tablebox" cellspacing="5" cellpadding="5">
		<form name="input" action="<%=urlPage%>tokubetu/admin/file/upload.jsp" method="post" enctype="multipart/form-data" >		
		<input type="hidden" name="hit_cnt" value="0">
		<input type='hidden' name="cate_L_seq">
		<input type='hidden' name="cate_seq">
		<input type='hidden' name="name" value="${member.nm}">	
		<input type="hidden" name="sekining_mseq" value="">	
			<tr>
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >登録者:</td>
				<td>${member.nm}</td>
			</tr>							
			<tr>
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >担当者:</td>
				<td>
					<select name="sekiningNm"  id="sekiningNm">	
						<option value="0">---選択して下さい---</option>								
	<c:if test="${! empty  listFollow}">
		<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >		
				<c:if test="${member.mseq==mem.mseq}">						            							
						<option value="${mem.mseq}" selected>${mem.nm}</option>	
				</c:if>	
				<c:if test="${member.mseq!=mem.mseq}">						            							
						<option value="${mem.mseq}" >${mem.nm}</option>	
				</c:if>					
		</c:forEach>
	</c:if>				
					</select>			
				</td>
			</tr>
			<tr >
				<td  width="25%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
				<td><input type="text" maxlength="100" name="title" value="" class="input02" style="width:300px"><font color="#807265">(▷100文字以下)</font></td>
			</tr>			
			<tr>
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
				<td colspan="3">
					<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()" checked>Yes &nbsp;
					<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" >No
			</td>
		</tr>
		<tr>	
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの選択:</td>
				<td><font color="#807265">(▷アップロードするファイル名に '&,%,^'などの記号は使わないで下さい!)</font>					
					<input  type='file' name="fileNm" size="80" class="file_solid" >
					
				</td>
			</tr>									
</table>
<div class="clear_margin"></div>							
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >	コメント
</label>			
<table  width="800" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">	
	<tr>
		<td style="padding: 5 0 0 0" width="50%" >

<textarea id="comment" name="comment" style="width:100%;height:200px;"></textarea>
<script type="text/javascript">
//<![CDATA[
CKEDITOR.replace( 'comment', {
	customConfig : '<%=urlPage%>ckeditor/config.js',   	
   	width: '100%',
   	height: '300px'
} );
//]]>
</script>							
							
		</td>			
	</tr>									 		
</table>
<div class="clear_margin"></div>	
<table width="800"  cellspacing="5" cellpadding="5">
	<tr>
		<td align="center" style="padding:15px 0px 100px 0px;">
				<a href="JavaScript:goWrite();"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></A>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></A>
			</td>	
	</tr>	
</form>		
</table>								
</div>
<!-- item end *****************************************************************-->				
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>			
<script language='JavaScript'>
//각 iframe의 url
// var mgroupurl  = "<%=urlPage%>admin/info/Mgroup.jsp";
// var sgroupurl  = "<%=urlPage%>admin/info/Sgroup.jsp";
var delpage= "<%=urlPage%>tokubetu/admin/file/cateDel.jsp";
var listForm="<%=urlPage%>tokubetu/admin/file/cateAddForm.jsp";
var modiOk="<%=urlPage%>tokubetu/admin/file/cateModi.jsp";

//대분류 목록을 선택 했을때
function doselectLcode(kind) {
  var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
  var lname = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].text;    
	
	document.formlgroup.name.value  = lname;	
	document.formcategory.lgroup_name.value  = lname;
	document.formcategory.lgroup_code.value  = lgroup;		
 // 	mgroupframe.document.location = mgroupurl + "?lgroup=" + lgroup;
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
			
			
			