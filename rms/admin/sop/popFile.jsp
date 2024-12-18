<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import="mira.sop.AccDownMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String ip_add=(String)request.getRemoteAddr();
		
String seq_list = request.getParameter("seq_list");	
String seq_item = request.getParameter("seq_item");	
String filename = request.getParameter("filename"); 	
String seq_tab = request.getParameter("seq_tab"); 	
String cate_nm = request.getParameter("cate_nm"); 	
String password=request.getParameter("pass");	
String filename2="";
if(id!=null){					
	
	AccDownMgr mgrAcc = AccDownMgr.getInstance();

	MemberManager manager = MemberManager.getInstance();
	Member mem=manager.getMember(id);	
	int mseq_int=mem.getMseq();	
	int chValue=manager.checkPass(mseq_int,password);	
if(chValue ==1){				

AccMgr manager2 = AccMgr.getInstance();
List listFileItem=manager2.listFileItem(Integer.parseInt(seq_list));
 
%>
<c:set var="listFileItem" value="<%=listFileItem%>" /> 
	
	
	
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

</script>

</head>
<body style="margin:5px"  onLoad="javascript:resize('600','500') ;">
<center>
<table width="98%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td align="center" >
		<!-- 상단풀정보 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>					
					<td width="80%" style="padding: 0 0 0 5px;;" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">ファイル内容</td>
					<td width="20%"><a href="javascript:FuncClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>			
<p>						
<table width=98% border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>		
	<tr bgcolor=#F1F1F1 align=center height="25">	
		<td  align="center" width="20%"   >手順書番号</td>
		<td  align="center" width="75%" >ファイル</td>	
		<td  align="center" width="5%" >ファイル変更</td>	
		<td  align="center" width="5%" >削除</td>						    						    
	</tr>							
		<c:if test="${!empty listFileItem}">						
			<c:forEach var="item" items="${listFileItem}" varStatus="idx">								
				<tr>													
					<td>${item.cate_nm}</td>
					<td>						
						<a class="fileline" href="#" onclick="goDown('${item.seq}','${item.filename}','<%=seq_tab%>');"   onfocus="this.blur()">${item.filename}</a>									
					</td>					
					<td align="center">	
						<input type="button"  class="cc" onClick="goModi('${item.seq}','${item.filename}');" onfocus="this.blur();" style=cursor:pointer value="変更" >							
					</td>
					<td align="center">	
						<a href="javascript:goDelete('<%=seq_list%>','${item.seq}','${item.filename}','sop_item_multi_pop')"  onfocus="this.blur()">
						<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>								
					</td>	
				</tr>
			</c:forEach>
		</c:if>			
</table>					
</center>	
<form name="frmMost"  method="post">		
	<input type="hidden" name="seq">							
	<input type="hidden" name="seq_list" value="<%=seq_list%>">	
	<input type="hidden" name="seq_item" value="<%=seq_item%>">	
	<input type="hidden" name="orderNo">
	<input type="hidden" name="name">	
	<input type="hidden" name="filename">
	<input type="hidden" name="seq_tab">
	<input type="hidden" name="goPg">
	<input type="hidden" name="kubun">
</form>

<%}else if(chValue ==0){%>		
			<script language=javascript>
				alert("パスワードが正しくありません。");				
				self.close();
			</script>
		
	<%}else if(chValue ==-1){%>
			<script language=javascript>
				alert("パスワードに一致するユーザが存在しません。");				
				self.close();
			</script>
	<%}
}else{%>	
		<script language="JavaScript">		
			window.opener.location.href = "<%=urlPage%>rms/member/loginForm.jsp";
			self.close();
		</script>	
<%}%>



						
<script language="JavaScript">							
function goDelete(seq_list,seq_item,filename,kubun) {	
	if ( confirm("削除しますか?") != 1 ) {
		return;
	}
    	document.frmMost.action = "<%=urlPage%>rms/admin/sop/delete.jsp";	
    	document.frmMost.seq_list.value=seq_list;
    	document.frmMost.seq_item.value=seq_item;	
	document.frmMost.kubun.value=kubun;	
	document.frmMost.filename.value = filename;
    	document.frmMost.submit();
    	
}
function goModi(seq,filename) {
	document.frmMost.seq.value=seq;
	document.frmMost.filename.value=filename;
	document.frmMost.goPg.value="multi";		
    	document.frmMost.action = "<%=urlPage%>rms/admin/sop/fileUpload_pop.jsp";	
    	document.frmMost.submit();
}

function goDown(seq,filename,seq_tab) {	
	document.frmMost.action = "<%=urlPage%>rms/admin/sop/downNoPass.jsp";
	document.frmMost.seq.value = seq;	
	document.frmMost.filename.value = filename;	
	document.frmMost.seq_tab.value = seq_tab; 	
	document.frmMost.goPg.value = "multi"; 	
	document.frmMost.submit();	
}
 function FuncClose() {	
	opener.location.href="<%=urlPage%>rms/admin/sop/listForm.jsp";
	self.close();
}	
</script>								
</body>
</html>					
	
	
	
	
	
	
	