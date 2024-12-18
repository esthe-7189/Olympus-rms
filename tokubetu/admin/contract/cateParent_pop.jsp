<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.contract.Category" %>
<%@ page import = "mira.contract.CateMgr" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String urlPage=request.getContextPath()+"/";		

CateMgr mgr=CateMgr.getInstance();
List list=mgr.listMcate();	
%>
<c:set var="list" value="<%=list%>" /> 
	
	
	
<html>
<head>
<title>OLYMPUS RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<script language="javascript">
function resize(width, height){	
	window.resizeTo(width, height);
}
function goWrite(){	
if(isEmpty(document.frm.orderNo, "順番を書いて下さい")) return ; 	
if(isEmpty(document.frm.name, "契約区分を書いて下さい")) return ; 
if ( confirm("登録しますか?") != 1 ) { return; }	
	document.frm.action = "cateParent_pop_add.jsp";	
	document.frm.submit();
}

</script>

</head>
<body style="margin:5px"  onLoad="javascript:resize('500','600') ;">
<center>
<table width="98%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td align="center" >
		<!-- 상단풀정보 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>					
					<td width="80%" style="padding: 0 0 0 5px;;" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">契約区分管理</td>
					<td width="20%"><a href="javascript:FuncClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>			
<table width="98%"  border=0 cellpadding=0 cellspacing=0 >
	
	<tr>
		<td style="padding: 5 0 0 0;"><img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 新規登録</td>
	</tr>
</table>
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
<form name="frm" action="" method="post">
<tr>
	<td bgcolor="#f7f7f7" width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >順番 : </td>
	<td width="60%" bgcolor="#ffffff"><input type=text size="2" class="box"  name="orderNo" maxlength="10" value=""></td>
	<td width="20%" bgcolor="#ffffff" rowspan="2" align="center">
	<a href="javascript:goWrite();" onfocus="this.blur()"><img src="<%=urlPage%>orms/images/admin/icon_write.gif"  align="absmiddle" alt="write"></a>
	</td>
</tr>
<tr>
	<td bgcolor="#f7f7f7"><img src="<%=urlPage%>rms/image/icon_s.gif" >契約区分 : </td>
	<td bgcolor="#ffffff"><input type=text size="35" class="box"  name="name" maxlength="100" value="">	
	</td>
</tr>
</form>
</table>
<p>
<table width="98%"  border=0 cellpadding=0 cellspacing=0 >
	<tr>
		<td style="padding: 5 0 0 0;"><img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 既存データ</td>
	</tr>	
</table>					
<table width="98%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
<form name="frmInsert"  method="post">				
		<tr align=center height=26>	
			<td width="15%"  align="center" bgcolor="#f7f7f7">固有番号</td>
			<td width="15%"  align="center" bgcolor="#f7f7f7">順番</td>
			<td width="55%" align="center" bgcolor="#f7f7f7">契約区分</td>
			<td width="15%"  align="center" >修正/削除</td>
		</tr>
<c:if test="${empty list}" >		
<tr>	
	<td align="center" style="padding: 2 0 1 0" colspan="4">登録された内容がありません。</td>							
</tr>
</c:if>
<c:if test="${!empty list}">		
	<c:forEach items="${list}" var="data" >
		<input type="hidden" name="seq" value="${data.bseq}">
		<tr align=center  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">			
			<td >${data.bseq}</td>
			<td ><input type=text size="2" class="box"  name="orderNo" id="orderNo${data.bseq}"  maxlength="10" value="${data.orderNo}"></td>
			<td ><input type=text size="35" class="box"  name="name" id="name${data.bseq}"   maxlength="100" value="${data.name}"></td>	
			<td >
				<a href="javascript:goModi(${data.bseq});"  onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif" align="absmiddle"></a>&nbsp;
				<a href="javascript:goDelete(${data.bseq});"  onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
			</td>					
		</tr>
	</c:forEach>
</c:if>																
</table>
<table width="98%"  border=0 cellpadding=0 cellspacing=0 >
	<tr>
		<td style="padding: 5 0 0 0;" align="center"><a class="topnav"  href="javascript:goModiAll();" onfocus="this.blur();">[:::全体を修正する:::]</a></td>
	</tr>
</table>	
</center>	
</form>
<form name="frmMost"  method="post">		
	<input type="hidden" name="seq">
	<input type="hidden" name="orderNo">
	<input type="hidden" name="name">	
</form>							
<script language="JavaScript">
function goDelete(seq) {
	document.frmMost.seq.value=seq;		
	if ( confirm("この契約区分を削除すると、今までアップしたデータも\n一緒に削除されます。それでも続けますか?") != 1 ) {
		return;
	}
    	document.frmMost.action = "cateParent_pop_delete.jsp";	
    	document.frmMost.submit();
}
function goModi(seq) {
	var orderNo=document.getElementById("orderNo"+seq).value; 		
	var name=document.getElementById("name"+seq).value;	
	
	document.frmMost.seq.value=seq;
	document.frmMost.orderNo.value=orderNo;
	document.frmMost.name.value=name;		

    	document.frmMost.action = "cateParent_pop_modi.jsp";	
    	document.frmMost.submit();
}
function goModiAll() {	
	if ( confirm("全体を修正しますか?") != 1 ) {
		return;
	}
    	document.frmInsert.action = "cateParent_pop_modiAll.jsp";	
    	document.frmInsert.submit();
}
 function FuncClose() {	
	opener.location.href="addForm.jsp";
	self.close();
}	
</script>								
</body>
</html>					
	
	
	
	
	
	
	