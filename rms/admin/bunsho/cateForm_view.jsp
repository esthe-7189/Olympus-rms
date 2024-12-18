<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "mira.bunsho.Category" %>
<%@ page import = "mira.bunsho.CateMgr" %>
<%@ page import=  "mira.bunsho.MgrException" %>

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
String urlPagemain=request.getContextPath()+"/";	
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

<script language="javascript">
function goWrite01(){
	var frmL = document.formlgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点(,)は使わないで下さい")) return ;	
	frmL.action = "<%=urlPage%>rms/admin/bunsho/cateInsert01_view.jsp";	
	frmL.submit();
}

</script>	

<center>
<table width="960" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="100%"  height="30" style="padding: 0 0 0 0"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">確認申請書類管理リスト......[項目登録]  
    		</td>    	
	</tr>		
</table>
<table width="960" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>
		<td height="31" valign="bottom"  align="right" style="padding:5 10 5 15">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/bunsho/bunshoUploadForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録" onClick="location.href='<%=urlPage%>rms/admin/bunsho/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="マニュアル" onClick="location.href='<%=urlPage%>rms/admin/file/bun_down.jsp?filename=orms20090223admin.ppt'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="データ出力(Excel)" onClick="location.href='<%=urlPage%>rms/admin/bunsho/excelList_view.jsp'">

	</td>			
	</tr>	
</table>


<table align="center" width="65%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 6px;">
  <tr>
    <td  width="85%"  style="padding:10 0 10 6" valign="middle">
    	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">&nbsp;<strong>入力の手順 : </strong>大項目 ==>中項目 ==>小項目
    </td>
  </tr>
  <tr>
    <td  bgcolor="#ff8000" height="2" ><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="2" border="0"></td>
  </tr>
	<tr>
    <td width="95%" valign="top" bgcolor="#F7F5EF"> 
<!-- 대 -->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr> 
	        <td height="20" align="center"><b> [大項目]</b></td>
	      </tr>
	      <tr>
<form name="formlgroup" method="post"  action="<%=urlPage%>rms/admin/bunsho/cateInsert01_view.jsp" onSubmit="return goWrite01(this)" >
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
	        <td height="150" > 
	          <div align="center" > 
	            <select class="normal" style="border:0;HEIGHT:111px;WIDTH:600px;" onChange="doselectLcode();" multiple size="7" name="selectlg">
<c:if test="${empty list}">				
			    	<option value="0">No Data</option>			    		
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
	    		
<%if(modi.equals("no")){%>
	大項目の新規登録:
	<textarea name="name" cols="60" rows="2"></textarea>	
	<a href="javascript:goWrite01('<%=grid%>');"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>&nbsp;
<%}else if(modi.equals("ok")){%>
	大項目の修正:
	<textarea name="name" cols="60" rows="2"><%=title%></textarea>	
	<a href="javascript:goModiOk('<%=bseqModi%>','<%=cateNo%>');"><img src="<%=urlPage%>rms/image/admin/btnKomokuMmodi.gif" align="absmiddle"></a>&nbsp;
<%}%>
	<a href="javascript:goModify()" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle" alt="書き直し"></a>&nbsp;	
	<a href="javascript:cateDel('<%=levelVal%>','<%=grid%>')"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>
<%if(modi.equals("ok")){%>
	<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif"></a>
<%}%>
	          </div>
	        </td>
	</form>
	      </tr>
	    </table>
<!-- /대 -->
		</td>
</tr>
<tr><td  bgcolor="#BEBE7C" height="1" ><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="1" border="0"></td></tr>
<tr>
    <td width="95%" valign="top" bgcolor="#F7F5EF"> 
<!-- 중 -->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr> 
	        <td height="20" align="center"><b> [中項目] </b></td>
	      </tr>
	      <tr>
	        <td height="130" bgcolor="#F7F5EF" style="padding:0 0 0 0" align="center">
	        	<iframe name="mgroupframe" src="Mgroup.jsp" scrolling="no" frameborder="0" width="100%" height="150"></iframe>
	        </td>
        </tr>
      </table>
<!-- /중 -->
		</td>
   </tr>
    <tr><td  bgcolor="#BEBE7C" height="1" ><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="1" border="0"></td></tr>
   <tr>
    <td width="95%" valign="top" bgcolor="#F7F5EF"> 
<!-- 소 -->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr> 
	        <td height="20" align="center"><b> [小項目] </b></td>
	      </tr>
	      <tr>
	        <td height="130" bgcolor="#F7F5EF" style="padding:0 0 0 0" align="center">
			<iframe name="sgroupframe" src="Sgroup.jsp" scrolling="no" frameborder="0" width="100%" height="150"></iframe>
         	 </td>
        </tr>
      </table>
<!-- /소 -->
		</td>
    
	</tr>
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
	<tr><form name=formcategory method=post>
		<td height="10" valign="middle" bgcolor="EAE3DE" style="padding:4 2 4 10">
			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" width="9" height="9" align="absmiddle"><span class="fontBb"> 選択された項目: </span> <br>
			<input type=text size="60" class=input02 readonly name="lgroup_name"> > 
			<input type='hidden' name="lgroup_code">
			<input type=text size="60" class=input02 readonly name="mgroup_name"> 
			<input type='hidden' name="mgroup_code">
					
		</td>
	</tr></form>
	<tr>
		<td  height="10">&nbsp;</td>
	</tr>	
</table>
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>
			
<script language='JavaScript'>
//각 iframe의 url
var mgroupurl  = "Mgroup.jsp";
var sgroupurl  = "Sgroup.jsp";
var delpage= "cateDel.jsp";
var listForm="cateForm.jsp";
var modiOk="cateModi.jsp";

//대분류 목록을 선택 했을때
function doselectLcode() {
  var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
  var lname = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].text;
	
	document.formcategory.lgroup_name.value  = lname;
  	mgroupframe.document.location = mgroupurl + "?lgroup=" + lgroup;
	sgroupframe.document.location = sgroupurl  + "?lgroup=" + lgroup;
}
function goModify() {
  var frmL = document.formlgroup;	
	if(isEmpty(frmL.selectlg, "項目を選択しからもう一度このボタンをおして下さい")) return  ;
  var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
  var lname = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].text;

	document.formlgroup.name.value  = lname;
	document.location = listForm + "?bseqModi=" + lgroup+"&modi=ok";
  	mgroupframe.document.location = mgroupurl + "?lgroup=" + lgroup;
	sgroupframe.document.location = sgroupurl  + "?lgroup=" + lgroup;
}
function cateDel(level,groupId) {
	var frmL = document.formlgroup;	
	if(isEmpty(frmL.selectlg, "項目を選択して下さい")) return  ;
	var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;

	if ( confirm("本当に削除しますか?") != 1 ) { return; }	
	document.location= delpage + "?lgroup="+ lgroup+"&level="+level+"&groupId="+groupId;     	
}

function cateReset() {
  var frmL = document.formlgroup;	 
	document.location = listForm + "?modi=no";  	 
}
function goModiOk(bseqq,cateNo){
	var frmL = document.formlgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;		
	document.location= modiOk + "?bseq="+ bseqq+"&name="+frmL.name.value+"&frmNo="+cateNo+"&level=1";    		
}
</script>
