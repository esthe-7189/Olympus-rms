<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>	
<%@ page import="mira.tokubetu.AccBean" %>
<%@ page import="mira.tokubetu.AccMgr" %>
<%@ page import="mira.tokubetu.AccDownMgr" %>
<%@ page import = "mira.tokubetu.Category" %>
<%@ page import = "mira.tokubetu.CateMgr" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");

	MemberManager managermem=MemberManager.getInstance();
	Member member=managermem.getMember(id);

if(kind!=null && ! kind.equals("toku")){	
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String seq = request.getParameter("seq");	
AccMgr manager = AccMgr.getInstance();
if(seq==null){ seq="0";}

AccBean accBean=manager.getAcc(Integer.parseInt(seq));
int sekining_mseq=accBean.getSekining_mseq();
String sekining_nm=accBean.getSekining_nm();

String parentId = request.getParameter("parentId");		
String modi = request.getParameter("modi");	
String bseqModi = request.getParameter("bseqModi");	
if(modi==null){modi="no";}

int grid=0; int levelVal=0; int bseq=0; int cateNo=0;
String title="";

CateMgr manager2 = CateMgr.getInstance();
Category board = null;
    if (parentId != null) {        
        board = manager2.select(Integer.parseInt(parentId));        
    } 

//항목 수정시 사용
Category boardModi = null;
if(bseqModi !=null){
	boardModi = manager2.select(Integer.parseInt(bseqModi));
	title=boardModi.getName();        
}

List  list=manager2.selectListAdminLevel(0,1);  
List listFollow=managermem.selectListSchedule(1,6);  //level 2부터
%>
<c:set var="board" value="<%= board %>" />
<c:set var="sekining_mseq" value="<%= sekining_mseq %>" />
<c:set var="sekining_nm" value="<%= sekining_nm %>" />
<c:set var="boardModi" value="<%= boardModi %>" />
<c:set var="list" value="<%= list %>" />
<c:set var="accBean" value="<%= accBean %>" />
<c:if test="${! empty  accBean}" />
<c:set var="listFollow" value="<%= listFollow %>" />


<script type="text/javascript">
function goWrite01(){
	var frmL = document.formlgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点(,)は使わないで下さい")) return ;		

	if ( confirm("登録しますか?") != 1 ) {	return ;}
	frmL.action = "<%=urlPage%>tokubetu/admin/file/cateInsertModi_view.jsp";	
	frmL.submit();
}
function goWrite(){
var frm=document.input;
var frmcate=document.formlgroup;
var frmname=document.formlgroup;
var nameMseq=frm.sekiningNm.options[frm.sekiningNm.selectedIndex].value;

    if(frmcate.cateKind[0].checked==true){frm.cate_seq.value=frm.cate_seq_value.value;  }	  
    if(frmcate.cateKind[1].checked==true){  
	  if(isEmpty(frmname.lgroup_name, "文書区分を選択して下さい"))  return  ;	        
	  else{ frm.cate_seq.value=frmname.lgroup_code.value;}	
	}	   
	
frm.sekining_mseq.value =nameMseq;
if(nameMseq=="0"){alert("担当者を選択して下さい。"); return ;}		
if(isEmpty(frm.title, "タイトルを入力して下さい。!")) return ;

if ( confirm("修正しますか?") != 1 ) {	return ;}
frm.action = "<%=urlPage%>tokubetu/admin/file/modify.jsp";	
frm.submit();
}

</script>

<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">決裁書/契約書文書ファイル管理 <font color="#A2A2A2"> ></font> 修正  </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/file/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/file/cateAddForm.jsp'">				
</div>
<div id="boxNoLine_100"  >		
<label class="calendar11">
			<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">&nbsp;ファイル情報
</label>		

<table width="800"  class="tablebox" cellspacing="5" cellpadding="5" >	
<form name="formlgroup" method="post"  action="<%=urlPage%>tokubetu/admin/file/cateInsertModi_view.jsp"  >	  
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
		<input type='hidden' name="lgroup_code">			
		<input type='hidden' name="list_cate_seq">	
		<input type='hidden' name="seq" value="<%=seq%>">	
  	<tr height=20>
		<td  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >既存文書区分:</td>
		<td>${accBean.cate_nm}</tr>
	<tr>
		<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >文書区分変更:</td>
		<td >
			<input type="radio" onfocus="this.blur()"  name="cateKind" value="1"  onClick="selectCate()"  checked>No&nbsp;
			<input type="radio" onfocus="this.blur()"  name="cateKind" value="2"  onClick="selectCate()" >Yes 	<br>			
		<div id="file_02"  style="display:none;" class="hiddeninner_select">
<!------category begin----------->													
			<table cellspacing="5" cellpadding="5">
				<tr>
					<td width="20%">	<img src="<%=urlPage%>orms/images/common/jirusi.gif" width="9" height="9" align="absmiddle"><span class="fontBb"> 文書区分選択: </span> </td>
					<td width="80%">
				<select class="normal"  onChange="doselectLcode();"  name="selectlg">
<c:if test="${empty list}">				
			    	<option value="0">:::::::::::no data!!::::::::::::</option>			    		
</c:if>	
				<option value="">:::::::::::::::::::文書区分選択::::::::::::::::::::</option>
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
	            </select>
			</td>
		</tr>
		<tr>
			<td ><img src="<%=urlPage%>orms/images/common/jirusi.gif" width="9" height="9" align="absmiddle"><span class="fontBb"> 文書区分編集: </span></td> 
			<td >
				<textarea name="name" class="textarea" cols="40" rows="2"><%=title%></textarea>				
				<a href="javascript:goWrite01();" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"　alt="登録"></a>
				<a href="javascript:goModify('<%=cateNo%>');" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuMmodi.gif" align="absmiddle" alt="修正"></a>	
				<a href="javascript:cateDel('<%=levelVal%>','<%=grid%>')"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>			
			</td>	
		</tr>
		<tr>
			<td height="10" valign="middle" ><img src="<%=urlPage%>orms/images/common/jirusi.gif" width="9" height="9" align="absmiddle"><span class="fontBb"> 選択された項目: </span></td> 
			<td >
				<input type=text size="40" class=input02 readonly name="lgroup_name"> 								
			</td>
	</tr>
</form>
</table>								
<!------category end----------->																
		</div>			
		</td>
	</tr>	
<form name="input" action="<%=urlPage%>tokubetu/admin/file/modify.jsp" method="post" enctype="multipart/form-data" >				
		<input type="hidden" name="seq" value="<%=seq%>">
		<input type="hidden" name="fileNm" value="No">
		<input type="hidden" name="cate_seq" >
		<input type="hidden" name="cate_seq_value" value="${accBean.cate_seq}">	
		<input type='hidden' name="name" value="${accBean.name}">	
		<input type="hidden" name="sekining_mseq" value="">				
			<tr>
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >登録者:</td>
				<td>${accBean.name}</td>
			</tr>							
			<tr>
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >担当者:</td>
				<td>
					<select name="sekiningNm"  id="sekiningNm">	
						<option value="0">---選択して下さい---</option>								
	<c:if test="${! empty  listFollow}">
		<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >		
				<c:if test="${sekining_mseq==mem.mseq}">						            							
						<option value="${mem.mseq}" selected>${mem.nm}</option>	
				</c:if>	
				<c:if test="${sekining_mseq!=mem.mseq}">						            							
						<option value="${mem.mseq}" >${mem.nm}</option>	
				</c:if>					
		</c:forEach>
	</c:if>				
					</select>			
				</td>
			</tr>			
		
		<tr >
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
				<td><input type="text" maxlength="100" name="title" value="${accBean.title}" class="input02" style="width:300px"><font color="#807265">(▷100文字以下)</font></td>
		</tr>
		<tr   height=20>
				<td  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイル名:</td>
				<td>${accBean.filename}</td>			
		</tr>
	<!--********>						
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの変更:</td>
				<td>
					<input type="radio" onfocus="this.blur()"  name="fileKind" value="1"  onClick="selectFile()"  checked>No&nbsp;
					<input type="radio" onfocus="this.blur()"  name="fileKind" value="2"  onClick="selectFile()" >Yes 	<br>			
							<div id="file_01"  style="display:none;">									
								<table border=0 cellspacing=0 cellpadding=1>
									<tr>
										<td>
											<font color="#CC3333" width="82%">									
											▷アップロードするファイル名に '&,%,^'などの記号は使わないで下さい!
											</font><br>				
											<input type="file" name="fileNmVal" size="60" >
										</td>
									</tr>						
								</table>
							</div>			
				</td>
			</tr>
<*************-->	
			
			<tr>
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
				<td colspan="3">
					<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()"  <%if(accBean.getView_yn()==0){%>checked<%}%>>Yes &nbsp;
					<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" <%if(accBean.getView_yn()==1){%>checked<%}%>>No
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
	
<textarea id="comment" name="comment" style="width:100%;height:200px;">${accBean.comment}</textarea>
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

<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>			
<script language='JavaScript'>
//각 iframe의 url
// var mgroupurl  = "<%=urlPage%>admin/info/Mgroup.jsp";
// var sgroupurl  = "<%=urlPage%>admin/info/Sgroup.jsp";
var delpage= "<%=urlPage%>tokubetu/admin/file/cateDelModi.jsp";
var listForm="<%=urlPage%>tokubetu/admin/file/cateAddForm.jsp";
var modiOk="<%=urlPage%>tokubetu/admin/file/cateModiModi.jsp";

//대분류 목록을 선택 했을때
function doselectLcode(kind) {
  var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
  var lname = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].text;    
	
	document.formlgroup.name.value  = lname;	
	document.formlgroup.lgroup_name.value  = lname;
	document.formlgroup.lgroup_code.value  = lgroup;		
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
			
<script language="JavaScript">
var f=document.input;
var d=document.all;	
var cateform=document.formlgroup;

function selectFile(){		
	if (f.fileKind[0].checked==true)	{				
		d.file_01.style.display="none";		
	}else if (f.fileKind[1].checked==true)	{		
		d.file_01.style.display="";		
	}		
}
function selectCate(){		
	if (cateform.cateKind[0].checked==true)	{				
		document.getElementById("file_02").style.display="none";		
	}else if (cateform.cateKind[1].checked==true)	{		
		document.getElementById("file_02").style.display="block";		
	}		
}
</script> 