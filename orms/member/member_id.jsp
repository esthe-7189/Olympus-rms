<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/orms/hoan-jsp"; %>
<%@ include file = "/orms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/orms/hoan-jsp/castle_referee.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>

<%
	String urlPage=request.getContextPath()+"/orms/";	
	String memId=request.getParameter("mail_address");
	
	MemberManager manager=MemberManager.getInstance();
	Member member=manager.idCh(memId);
%>

<c:set var="member" value="<%= member %>" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Olympus RMS</title>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="title" content="olympus-rms.com" />
<meta name="author" content="www.ableu.com" />
<meta name="keywords" content="OLYMPUS RMS, BIO, collagen, chondron, cosmetic" />
<link rel="stylesheet" type="text/css" href="<%=urlPage%>common/css/style.css" />
<script type="text/javascript" src="<%=urlPage%>common/js/default.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/common.js"></script>
<script type="text/javascript" src="<%=urlPage%>hoan-jsp/castle.js"></script>

<script language=vbscript>
	sub window_onload()
		document.checkForm.mail_address.focus()
	end sub
</script>
<script>
/* email 중복 조회 */
function check_email() {
	var frm = document.checkForm;
	var mail_address = Replace_Blank(frm.mail_address.value);

	if (mail_address == '') {
		alert("idを書いて下さい!");
		frm.mail_address.focus();
		return;
	}
	var SH_mail_address = mail_address.split("@");
	if (SH_mail_address.length != 2) {
		alert("idを正確に書いて下さい!");
		frm.mail_address.focus();
		return;
	}
	if (!MailCheck(SH_mail_address[0], SH_mail_address[1])) {
		alert("idを正確に書いて下さい!");
		frm.mail_address.focus();
		return;
	}	
	frm.mail_address.value = mail_address;	
	frm.action="<%=urlPage%>member/member_id.jsp";  	   	
	frm.submit();
}

/* email 적용 */
function email_apply() {
	opener.document.insertForm.mail_address.value = document.checkForm.CHECKED_EMAIL.value;
	opener.document.insertForm.CHECKED_EMAIL.value = document.checkForm.CHECKED_EMAIL.value;
	opener.document.insertForm.CHECK_FG.value = 'Y';

	window.close();
}
</script>
</head>
<body id="pop">
<form name="checkForm" action="<%=urlPage%>member/member_id.jsp" method="post"  onSubmit = "">
<input type="hidden" name="mseq" value="" />
<input type="hidden" name="CHECKED_EMAIL" value="<%=memId%>">
<div class="popup_border">
	<div class="pop_title">
		<p class="left"><a href="#"><img src="<%=urlPage%>images/bg/popup_logo.jpg" alt="olympus-rms.com" title="olympus-rms.com"/></a></p>
		<p class="right pad_t3 pad_r6"><a href="javascript:window.close();"><span class="clo_1">close</span> <span class="clo_1">x</span></a></p>
	</div>
	<div class="id_type">
		<ul class="top">
		<c:if test="${empty member}">		
					<li class="txt">ID:<span><%=memId%></span>は使うことができます。</li>
					<li class="btn"><img src="<%=urlPage%>images/bg/popup_btn_apply.jpg" onClick="email_apply();" style="cursor:pointer;" alt="apply" title="apply"/></li>
		</c:if>		
		<c:if test="${!empty member}">			
			<li class="txt">ID:<span><%=memId%></span>は現在使われているIDなのでもう一度検索して下さい。	</li>
					
		</c:if>		
		</ul>		
		<ul class="search">
			<li class="title">E-mail</li>
			<li class="ip"><input type="text" name="mail_address" maxlength="50" style="width:264px"/></li>
			<li class="btn"><a href="#"><img src="<%=urlPage%>images/bg/btn_search.gif" onClick="check_email();" style="cursor:pointer;" alt="search" title="search"/></a></li>
		</ul>		
	</div>
	<p class="pop_btn">&nbsp;</p>
</div>
</form>
</body>
</html>	
	
	
