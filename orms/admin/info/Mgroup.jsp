<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.info.Category" %>
<%@ page import = "mira.info.CateMgr" %>
<%@ page import=  "mira.info.MgrException" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	
String selectlg = request.getParameter("selectlg");
String lgroup = request.getParameter("lgroup");
String parentId = request.getParameter("parentId");	
String bseqModi = request.getParameter("bseqModi");	
String modi = request.getParameter("modi");	
if(modi==null){modi="no";}

if(selectlg==null) selectlg="0";
if(lgroup==null) lgroup="0";
int grid2=0;
int selectlgInt=Integer.parseInt(lgroup);

 int levelVal=0; int bseq=0; int cateNo=0;
String title="";

CateMgr manager = CateMgr.getInstance();
Category board2 = null;
    if (parentId != null) {        
        board2 = manager.select(Integer.parseInt(parentId));        
    } 

//항목 수정시 사용
Category boardModi = null;
if(bseqModi !=null){
	boardModi = manager.select(Integer.parseInt(bseqModi));
	title=boardModi.getName();        
}

List  list2=manager.selectListAdminLevel(selectlgInt,2);

%>
<c:set var="board2" value="<%= board2 %>" />
<c:set var="list2" value="<%= list2%>" />
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
function goWrite02(){	
	var frmL = document.formmgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;	
	if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
	
	document.move.nameval.value=frmL.name.value;	
	document.move.parentIdval.value=frmL.parentId.value;	
	document.move.action = "<%=urlPage%>admin/info/cateInsert02_view.jsp";	
	document.move.submit();
}

</script>				
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#F1F1F1">
<!-- 중분류 목록 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" >
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>	  	        
<form name="formmgroup" method=post action="<%=urlPage%>admin/info/cateInsert02_view.jsp" onSubmit="return goWrite02(this)" >		
		<input type="hidden" name="groupId" value="">	
		<input type="hidden" name="parentId" value="${param.lgroup}">	
		<input type="hidden" name="level" value="2">
		<input type="hidden" name="bseq" value="">
		<input type="hidden" name="nameModi" value="">
		<input type="hidden" name="cateNo" value="">
		<input type="hidden" name="pbseq" value="">						
	<tr>
	<td align="center">
	<select class="normal" style="border:0;HEIGHT:111px;WIDTH:200px;" onChange="doselectMcode();" multiple size=7 name="selectmg">		
<c:if test="${empty list2}">				
			    	<option value="0"></option>			    		
</c:if>	
		
<c:if test="${! empty list2}">
<%
int ii=1;
Iterator listiter2=list2.iterator();
while (listiter2.hasNext()){				
	Category cate2=(Category)listiter2.next();
	int bseq2=cate2.getBseq();	
	grid2=cate2.getGroupId();
	levelVal=cate2.getLevel();
	cateNo=cate2.getCateNo();	
%>	  
		<option value="<%=bseq2%>"><%=cate2.getName()%></option>
<%
ii++;
}												  													  
%>	
</c:if>			
	            </select><br>	
				<textarea name="name" cols="30" rows="2"><%=title%></textarea><br>			
				<a href="javascript:goWrite02();" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_write.gif"  align="absmiddle" alt="write"></a>
				<a href="javascript:goModify02('<%=cateNo%>');" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_update.gif"  align="absmiddle" alt="modify"></a>	
				<a href="javascript:cateDel02('<%=levelVal%>');"  onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_cancel.gif" align="absmiddle" alt="delete"></a>	
	          </div>
</form>	
	</td>
</tr>
</table>
<!-- /중분류 목록 -->

<script language='JavaScript'>
//각 iframe의 url
var mgroupurl  = "<%=urlPage%>admin/info/Mgroup.jsp";
var sgroupurl  = "<%=urlPage%>admin/info/Sgroup.jsp";
var delpage= "<%=urlPage%>admin/info/cateDel_02.jsp";
var listForm="<%=urlPage%>admin/info/cateAddForm.jsp";
var modiOk="<%=urlPage%>admin/info/cateModi_02.jsp";


//중분류 목록을 선택 했을때

function doselectMcode() {
  var mgroup = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].value;
  var mname = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].text;

	document.formmgroup.name.value  = mname;	
	parent.document.formcategory.mgroup_name.value  = mname;
	parent.document.formcategory.mgroup_code.value  = mgroup;
	parent.sgroupframe.document.location = sgroupurl + "?lgroup=<%=lgroup%>&mgroup="+mgroup;		
}

function cateDel02(level) {
	var frmL = document.formmgroup;
	
	if(isEmpty(frmL.selectmg, "項目を選択して下さい")) return  ;
	var lgroup = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].value;

	if ( confirm("上の内容を本当に削除しますか?") != 1 ) { return; }	
	document.location= delpage + "?lgroup="+ lgroup+"&level="+level+"&pbseq=<%=lgroup%>";     	
}

function goModify02(cateNo){
	var frmL = document.formmgroup;
	var mgroup = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].value;
  
	if(isEmpty(frmL.name, "項目を選択及び入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;		
	if ( confirm("上の内容を修正しますか?") != 1 ) { return; }	
	
	document.formmgroup.action = modiOk;
    	document.formmgroup.bseq.value = mgroup;
    	document.formmgroup.nameModi.value = frmL.name.value;
    	document.formmgroup.cateNo.value = cateNo;    	
    	document.formmgroup.pbseq.value = "<%=lgroup%>";    	
    	document.formmgroup.submit();
	
}
</script>
</body> 
	
	
	