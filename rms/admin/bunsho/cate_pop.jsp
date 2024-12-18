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
<c:set var="list" value="<%= list %>" />
<c:set var="boardModi" value="<%= boardModi %>" />

<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<script language="javascript">
function resize(width, height){	
	window.resizeTo(width, height);
}

function goWrite01(){	
	var frmL = document.formlgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点(,)は使わないで下さい")) return ;	
	frmL.action = "<%=urlPage%>rms/admin/bunsho/cateInsert01_view.jsp";	
	frmL.submit();
}

</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('800','700') ;">
<center>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 6px;"> 
  <tr>
    <td  width="95%"  style="padding:10 0 10 6" valign="middle">
    	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">    
    <strong> 項目を選択して下さい。（大項目 ==>中項目 ==>小項目）</strong><br>
   　 <img src="<%=urlPage%>rms/image/icon_ball.gif" >
	<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
	<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">
    	新しい項目は<img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle">で登録して下さい。
    </td>
  </tr>
  <tr>
    <td  bgcolor="#ff8000" height="2" width="95%"><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="2" border="0"></td>
  </tr>
  <tr>
    <td width="95%" valign="top" bgcolor="#F7F5EF"> 
<!-- 대 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
	      <tr> 
	        <td height="10" align="center"><b> [大項目]</b></td>
	      </tr>
	      <tr>				
	        <td align="left" style="margin-left:10px;">
			<div align="center">
	            <select class="normal" style="border:0;HEIGHT:80px;WIDTH:700px;" onChange="doselectLcode();" multiple size="7" name="selectlg">
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
		  </div>  	
	
<%if(modi.equals("no")){%>	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=urlPage%>rms/image/icon_ball.gif" > 大項目の新規登録:
	<textarea class="textarea" name="name" cols="60" rows="2"></textarea>	
	<a href="javascript:goWrite01('<%=grid%>');"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>&nbsp;
	<a href="javascript:goModify()" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle" alt="書き直し"></a>&nbsp;	
	<a href="javascript:cateDel('<%=levelVal%>','<%=grid%>')"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>
<%}else if(modi.equals("ok")){%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=urlPage%>rms/image/icon_ball.gif" > 大項目の修正:
	<textarea class="textarea" name="name" cols="60" rows="2"><%=title%></textarea>	
	<a href="javascript:goModiOk('<%=bseqModi%>','<%=cateNo%>');"><img src="<%=urlPage%>rms/image/admin/btnKomokuMmodi.gif" align="absmiddle"></a>&nbsp;
<%}%>	
<%if(modi.equals("ok")){%>
	<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif"></a>
<%}%>
	          	
	          
	        </td>
	</form>
	      </tr>
	    </table>
<!-- /대 -->
		</td>
</tr>
<tr height="25"><td  bgcolor="#BEBE7C" height="1" ><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="1" border="0"></td></tr>
<tr>
    <td width="95%" valign="top" bgcolor="#F7F5EF"> 
<!-- 중 -->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr height="25"> 
	        <td height="10" align="center"><b> [中項目] </b></td>
	      </tr>
	      <tr>
	        <td height="110" bgcolor="#F7F5EF" style="padding:0 0 0 0" align="center">
	        	<iframe name="mgroupframe" src="Mgroup_pop.jsp" scrolling="no" frameborder="0" width="700" height="120"></iframe>
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
	        <td height="10" align="center"><b> [小項目] </b></td>
	      </tr>
	      <tr>
	        <td height="110" bgcolor="#F7F5EF" style="padding:0 0 0 0" align="center">
			<iframe name="sgroupframe" src="Sgroup_pop.jsp" scrolling="no" frameborder="0" width="700" height="120"></iframe>
         	 </td>
        </tr>
      </table>
<!-- /소 -->
		</td> 
	</tr>	
	<tr><form name=formcategory method=post>
		<td height="10" valign="middle" bgcolor="EAE3DE" style="padding:4 2 4 10">
			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" width="9" height="9" align="absmiddle"><span class="fontBb"> 選択された項目 : </span> 
			<input type=text size=25 class=input02 readonly name="lgroup_name"> > 
			<input type='hidden' name="lgroup_code"  value="">
			<input type=text size=25 class=input02 readonly name="mgroup_name"> > 
			<input type='hidden' name="mgroup_code" value="">
			<input type=text size=25 class=input02 readonly name="sgroup_name"> 
			<input type='hidden' name="sgroup_code" value="">			
		</td>
	</tr></form>
	
	<tr>
	  <td  align="center" style="padding:10 0 0 0">
	  	<a href="javascript:cateGo();"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>
	  	<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif" align="absmiddle"></a>
	  	<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>	  	
	  </td>
	</tr>
</table>
</center>
<script language='JavaScript'>

//각 iframe의 url
var mgroupurl  = "Mgroup_pop.jsp";
var sgroupurl  = "Sgroup_pop.jsp";
//var catePopUrl  = "cate_pop.jsp";

//var mgroupurl  = "Mgroup.jsp";
//var sgroupurl  = "Sgroup.jsp";
var delpage= "cateDel.jsp";
var listForm="cate_pop.jsp";
var modiOk="cateModi.jsp";
//대분류 목록을 선택 했을때
function doselectLcode() {
  var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
  var lname = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].text;	
	document.formcategory.lgroup_name.value  = lname;
	document.formlgroup.name.value  = lname;
  	mgroupframe.document.location = mgroupurl + "?lgroup=" + lgroup;
	sgroupframe.document.location = sgroupurl  + "?lgroup=" + lgroup;
}


//카테고리로 선택해서 검색 버튼을 클릭했을때
function cateGo(){
	var f = document.formlgroup;
  if (f.selectlg.value == "") { 
    alert("大項目を選択して下さい。");
    return;
  }

  var selLgroupIndex = document.formlgroup.selectlg.selectedIndex;
  var selMgroupIndex = mgroupframe.document.formmgroup.selectmg.selectedIndex;
  var selSgroupIndex = sgroupframe.document.formsgroup.selectsg.selectedIndex;  
  if (selLgroupIndex < 0 || selMgroupIndex < 0 || selSgroupIndex < 0 ) {
    alert("項目を選択して下さい");
    return;
  }

	var fs = document.formcategory;
	if(f.selectlg.value != "" ) {
	  fs.lgroup_name.value = document.formlgroup.selectlg.options[selLgroupIndex].text;
	  fs.lgroup_code.value = document.formlgroup.selectlg.options[selLgroupIndex].value;
	  fs.mgroup_name.value = mgroupframe.document.formmgroup.selectmg.options[selMgroupIndex].text;
	  fs.mgroup_code.value = mgroupframe.document.formmgroup.selectmg.options[selMgroupIndex].value;
	  fs.sgroup_name.value = sgroupframe.document.formsgroup.selectsg.options[selSgroupIndex].text;
	  fs.sgroup_code.value = sgroupframe.document.formsgroup.selectsg.options[selSgroupIndex].value;	 
	}

	var lcode = fs.lgroup_code.value;
	var mcode = fs.mgroup_code.value;
	var scode = fs.sgroup_code.value;	
	var name01= fs.lgroup_name.value  ;
	var name02= fs.mgroup_name.value ;
	var name03= fs.sgroup_name.value ;
		
	if (window.opener && !window.opener.closed) {
    window.opener.document.memberInput.lgroup_code.value = lcode;
    window.opener.document.memberInput.mgroup_code.value = mcode;
    window.opener.document.memberInput.sgroup_code.value = scode;    
    window.opener.document.memberInput.lgroup_name.value = name01;
    window.opener.document.memberInput.mgroup_name.value = name02;
    window.opener.document.memberInput.sgroup_name.value = name03;	
  	window.close();
	} 

}

function entry(){
	var f = document.formcategory;

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
