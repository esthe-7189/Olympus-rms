<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CateMgr" %>

<%	
String kindpgkubun=(String)session.getAttribute("KIND");
if(kindpgkubun!=null && ! kindpgkubun.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";	
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

<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
<script language="javascript">
function goWrite03(groupId3,parentId3){	
	var frmL = document.formsgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;
	
	document.move.nameval.value=frmL.name.value;	
	document.move.parentIdval.value=parentId3;			
	document.move.action = "<%=urlPage%>rms/admin/hinsithu/cateInsert03_view.jsp";	
	document.move.submit();
}

</script>			
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#F7F5EF">
<!-- 중분류 목록 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>	  	        
<form name="formsgroup" method=post action="<%=urlPage%>rms/admin/hinsithu/cateInsert03_view.jsp" onSubmit="return goWrite03(this)" >		
		<input type="hidden" name="groupId" value="${param.lgroup}">	
		<input type="hidden" name="parentId" value="${param.mgroup}">	
		<input type="hidden" name="level" value="3">			
	<tr>
	<td align="left">
			<div align="center">
	<select class="normal" style="border:0;HEIGHT:80px;WIDTH:700px;" onChange="doselectScode();"  multiple size=7 name="selectsg">		
<c:if test="${empty list3}">				
			    	<option value="0">No Data</option>			    		
</c:if>	
		
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
</div>
	
<%if(modi.equals("no")){ %>
	<img src="<%=urlPage%>rms/image/icon_ball.gif" > 小項目の新規登録: 
		<%if(mgroupInt==0){%>
			<textarea class="textarea" name="name" cols="60" rows="2"  readOnly='true' ></textarea>				
		<%}else{%>
			<textarea class="textarea" name="name" cols="60" rows="2"></textarea>	
			<a href="JavaScript:goWrite03('${param.lgroup}','${param.mgroup}')" onfocus="this.blur()" ><img src="<%=urlPage%>rms/image/admin/btn_apply.gif"></a>&nbsp;
			<a href="javascript:goModify()" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle" alt="書き直し"></a>&nbsp;	
			<a href="javascript:cateDel('<%=levelVal%>')"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>
		<%}%>
<%}else if(modi.equals("ok")){%>
	<img src="<%=urlPage%>rms/image/icon_ball.gif" > 小項目の修正:
	<textarea class="textarea" name="name" cols="60" rows="2"><%=title%></textarea>	
	<a href="javascript:goModiOk('<%=bseqModi%>','<%=cateNo%>');"><img src="<%=urlPage%>rms/image/admin/btnKomokuMmodi.gif"></a>&nbsp;
<%}%>
	
<%if(modi.equals("ok")){%>
	<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif"></a>
<%}%>	
	</td>
	
</tr>
</form>
</table>

<!-- /중분류 목록 -->

<SCRIPT LANGUAGE="JavaScript">
//각 iframe의 url
var mgroupurl  = "Mgroup_pop.jsp";
var sgroupurl  = "Sgroup_pop.jsp";
var delpage= "cateDel_03.jsp";
var modiOk="cateModi_03.jsp";
//세분류 목록을 선택 했을때
function doselectScode(){
	var sgroup = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].value;
	var sname = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].text;
	parent.document.formcategory.sgroup_name.value  = sname;
	document.formsgroup.name.value  = sname;
	document.location = sgroupurl + "?lgroup=<%=lgroup%>&mgroup="+mgroup+"&groupId=<%=lgroup%>";
}

function goModify() {
  var frmL = document.formsgroup;	
	if(isEmpty(frmL.selectsg, "項目を選択しからもう一度このボタンをおして下さい")) return  ;
  var lgroup = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].value;
  var lname = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].text;

	document.formsgroup.name.value  = lname;
	document.location = sgroupurl + "?bseqModi="+ lgroup+"&modi=ok&lgroup=<%=lgroup%>&mgroup=<%=mgroup%>";  
}
function cateDel(level) {
	var frmL = document.formsgroup;	
	if(isEmpty(frmL.selectsg, "項目を選択して下さい")) return  ;
	var seq = document.formsgroup.selectsg.options[document.formsgroup.selectsg.selectedIndex].value;
	alert(level);
	if ( confirm("本当に削除しますか?") != 1 ) { return; }	
	document.location= delpage + "?seq="+ seq+"&level="+level+"&mgroup=<%=mgroup%>";     	
}

function cateReset() {
  var frmL = document.formsgroup;	 
	document.location = sgroupurl + "?modi=no";  	 
}
function goModiOk(bseqq,cateNo){
	var frmL = document.formsgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;			
	document.location= modiOk + "?bseq="+ bseqq+"&name="+frmL.name.value+"&frmNo="+cateNo+"&pbseq=<%=mgroup%>";  
}
</script>
</body>
	
	
	
	
	