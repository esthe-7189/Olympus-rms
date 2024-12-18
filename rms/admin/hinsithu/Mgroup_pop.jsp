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
String selectlg = request.getParameter("selectlg");
String lgroup = request.getParameter("lgroup");
String parentId = request.getParameter("parentId");	
String groupId = request.getParameter("groupId");	
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
function goWrite02(){	
	var frmL = document.formmgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;	
	document.move.nameval.value=frmL.name.value;	
	document.move.parentIdval.value=frmL.parentId.value;	
	document.move.action = "<%=urlPage%>rms/admin/hinsithu/cateInsert02_view.jsp";	
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
<form name="formmgroup" method=post action="<%=urlPage%>rms/admin/hinsithu/cateInsert02_view.jsp" onSubmit="return goWrite02(this)" >		
		<input type="hidden" name="groupId" value="${param.lgroup}">	
		<input type="hidden" name="parentId" value="${param.lgroup}">	
		<input type="hidden" name="level" value="2">			
	<tr>
	<td align="left">
			<div align="center">
	<select class="normal" style="border:0;HEIGHT:80px;WIDTH:700px;" onChange="doselectMcode();" multiple size=7 name="selectmg">		
<c:if test="${empty list2}">				
			    	<option value="0">No Data</option>			    		
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
  			</div>
  	
<%if(modi.equals("no")){ %>
	<img src="<%=urlPage%>rms/image/icon_ball.gif" > 中項目の新規登録:	
		<%if(selectlgInt==0){%>
			<textarea class="textarea" name="name" cols="60" rows="2"  readOnly='true' ></textarea>				
		<%}else{%>
			<textarea class="textarea" name="name" cols="60" rows="2" ></textarea>	
			<a href="JavaScript:goWrite02()" onfocus="this.blur()" ><img src="<%=urlPage%>rms/image/admin/btn_apply.gif"></a>&nbsp;	
			<a href="javascript:goModify()" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle" alt="書き直し"></a>&nbsp;	
	<a href="javascript:cateDel('<%=levelVal%>')"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>
		<%}%>
<%}else if(modi.equals("ok")){%>
   	<img src="<%=urlPage%>rms/image/icon_ball.gif" > 中項目の修正:
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

<script language='JavaScript'>
//각 iframe의 url
var mgroupurl  = "Mgroup_pop.jsp";
var sgroupurl  = "Sgroup_pop.jsp";
var delpage= "cateDel_02.jsp";
var listForm="cate_pop.jsp";
var modiOk="cateModi_02.jsp";

function doselectMcode(){
	var mgroup = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].value;
	var mname = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].text;
	parent.document.formcategory.mgroup_name.value  = mname;
	document.formmgroup.name.value  = mname;		
	parent.sgroupframe.document.location = sgroupurl + "?lgroup=<%=lgroup%>&mgroup="+mgroup;
	
}
function goModify() {
  var frmL = document.formmgroup;	
	if(isEmpty(frmL.selectmg, "項目を選択しからもう一度このボタンをおして下さい")) return  ;
  var lgroup = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].value;
  var lname = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].text;

	document.formmgroup.name.value  = lname;
	document.location = mgroupurl + "?bseqModi="+ lgroup+"&modi=ok&lgroup=<%=lgroup%>";  	
}
function cateDel(level) {
	var frmL = document.formmgroup;	
	if(isEmpty(frmL.selectmg, "項目を選択して下さい")) return  ;
	var lgroup = document.formmgroup.selectmg.options[document.formmgroup.selectmg.selectedIndex].value;
	if ( confirm("本当に削除しますか?") != 1 ) { return; }	
	document.location= delpage + "?lgroup="+ lgroup+"&level="+level+"&pbseq=<%=lgroup%>";     	
}

function cateReset() {
  var frmL = document.formmgroup;	 
	document.location = mgroupurl + "?modi=no";  	 
}
function goModiOk(bseqq,cateNo){
	var frmL = document.formmgroup;		
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;			
	document.location= modiOk + "?bseq="+ bseqq+"&name="+frmL.name.value+"&frmNo="+cateNo+"&pbseq=<%=lgroup%>";  
}
</script>
</body> 
	
	
	