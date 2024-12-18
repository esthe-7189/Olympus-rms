<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.info.Category" %>
<%@ page import = "mira.info.CateMgr" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	
String selectlg = request.getParameter("selectmg");
String mgroup = request.getParameter("mgroup");
String lgroup = request.getParameter("lgroup");
String parentId = request.getParameter("parentId");	
String parentIda = request.getParameter("parentIda");	
String bseqModi = request.getParameter("bseqModi");	
String modi = request.getParameter("modi");	
if(modi==null){modi="no";}


if(selectlg==null) selectlg="0";
if(mgroup==null) mgroup="0";
if(lgroup==null) lgroup="0";
int selectlgInt=Integer.parseInt(lgroup);
int mgroupInt=Integer.parseInt(mgroup);
int bseq3=0;

int levelVal=0; int bseq=0; int cateNo=0;
String title="";

CateMgr manager = CateMgr.getInstance();
Category board3 = null;
    if (parentId != null) {        
        board3 = manager.select(Integer.parseInt(parentId));        
    } 
    
//항목 수정시 사용
Category boardModi = null;
if(bseqModi !=null){
	boardModi = manager.select(Integer.parseInt(bseqModi));
	title=boardModi.getName();        
}

List  list3=manager.selectListAdminLevel(mgroupInt,3);

%>
<c:set var="board3" value="<%= board3 %>" />
<c:set var="list3" value="<%= list3%>" />
<c:set var="boardModi" value="<%= boardModi %>" />	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Olympus RMS</title>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="title" content="olympus-rms.com" />
<meta name="author" content="www.ableu.com" />
<meta name="keywords" content="OLYMPUS RMS, BIO, collagen, chondron, cosmetic" />
<link href="<%=urlPage%>common/admin/css/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=urlPage%>common/admin/js/common.js"></script>
<script language="javascript" src="<%=urlPage%>common/admin/js/Commonjs.js"></script>
	
<script language="javascript">
function goWrite03(groupId3,parentId3){	
	var frmL = document.formsgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;
	
	document.move.nameval.value=frmL.name.value;	
	document.move.parentIdval.value=parentId3;			
	document.move.action = "<%=urlPage%>admin/info/cateInsert03_view.jsp";	
	document.move.submit();
}

</script>			
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#F1F1F1">
<!-- 중분류 목록 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>	  	        
<form name="formsgroup" method=post action="<%=urlPage%>admin/info/cateInsert03_view.jsp" onSubmit="return goWrite03(this)" >		
		<input type="hidden" name="groupId" value="">	
		<input type="hidden" name="parentId" value="${param.mgroup}">	
		<input type="hidden" name="level" value="3">
		<input type="hidden" name="bseq" value="">
		<input type="hidden" name="nameModi" value="">
		<input type="hidden" name="cateNo" value="">
		<input type="hidden" name="pbseq" value="">						
	<tr>
	<td align="center">
	<select class="normal" style="border:0;HEIGHT:111px;WIDTH:200px;" onChange="doselectScode()" multiple size=7 name="selectsg">		
		
<c:if test="${! empty list3}">
<%
int iii=1;
Iterator listiter3=list3.iterator();
while (listiter3.hasNext()){				
	Category cate3=(Category)listiter3.next();
	bseq3=cate3.getBseq();	
	levelVal=cate3.getLevel();
	cateNo=cate3.getCateNo();		
%>	  
		<option value="<%=bseq3%>"><%=cate3.getName()%></option>
<%
iii++;
}												  													  
%>	
</c:if>			
	            </select><br>
				<textarea name="name" cols="30" rows="2" ><%=title%></textarea><br>			
				<a href="javascript:goWrite03('${param.lgroup}','${param.mgroup}');" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_write.gif"  align="absmiddle" alt="write"></a>
				<a href="javascript:goModify03('<%=cateNo%>');" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_update.gif"  align="absmiddle" alt="modify"></a>	
				<a href="javascript:cateDel03('<%=levelVal%>');"  onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_cancel.gif" align="absmiddle" alt="delete"></a>	
	</td>
</tr>
</form>
</table>

<!-- /중분류 목록 -->

<SCRIPT LANGUAGE="JavaScript">
//각 iframe의 url
var mgroupurl  = "<%=urlPage%>admin/info/Mgroup.jsp";
var sgroupurl  = "<%=urlPage%>admin/info/Sgroup.jsp";
var delpage= "<%=urlPage%>admin/info/cateDel_03.jsp";
var modiOk="<%=urlPage%>admin/info/cateModi_03.jsp";

//세분류 목록을 선택 했을때
function doselectScode(){
	var sgroup = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].value;
	var sname = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].text;
	parent.document.formcategory.sgroup_name.value  = sname;
	parent.document.formcategory.sgroup_code.value  = sgroup;
	document.formsgroup.name.value  = sname;	
	parent.sgroupframe.document.location = sgroupurl + "?lgroup=<%=lgroup%>&mgroup=<%=mgroup%>";
}

function cateDel03(level) {
	var frmL = document.formsgroup;	
	if(isEmpty(frmL.selectsg, "項目を選択して下さい")) return  ;
	var lgroup = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].value;
	if ( confirm("上の内容を本当に削除しますか?") != 1 ) { return; }	
	document.location= delpage + "?lgroup="+ lgroup+"&level="+level+"&pbseq=<%=mgroup%>";     	
}

function goModify03(cateNo){
	var frmL = document.formsgroup;
	var sgroup = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].value;
  
	if(isEmpty(frmL.name, "項目を選択及び入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;		
	if ( confirm("上の内容を修正しますか?") != 1 ) { return; }	
	
	document.formsgroup.action = modiOk;
    	document.formsgroup.bseq.value = sgroup;
    	document.formsgroup.nameModi.value = frmL.name.value;
    	document.formsgroup.cateNo.value = cateNo;    	
    	document.formsgroup.pbseq.value = "<%=mgroup%>";    	
    	document.formsgroup.submit();
	
}
</script>
</body>