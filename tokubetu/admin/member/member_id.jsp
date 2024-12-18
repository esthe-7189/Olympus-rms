<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String urlPage=request.getContextPath()+"/";
	
	String memId=request.getParameter("member_id");
	
	MemberManager manager=MemberManager.getInstance();
	Member member=manager.idCh(memId);
%>

<c:set var="member" value="<%= member %>" />


<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<script language=vbscript>
	sub window_onload()
		document.searchId.member_id.focus()
	end sub
</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function doSh(){
	var fm=document.searchId;
	var member_id = fm.member_id;	
	if (!isLoginname(member_id)) {
      alert("dを正確に書いて下さい!");	  
      member_id.focus();	  
      return ;
    }
	fm.action="member_id.jsp?member_id="+member_id.value;
	fm.submit();
}

function choice(memId){			
	opener.document.memberInput.member_id.value = document.searchId.CHECKED_EMAIL.value;
	opener.document.memberInput.CHECKED_EMAIL.value = document.searchId.CHECKED_EMAIL.value;
	opener.document.memberInput.CHECK_FG.value = 'Y';
	window.close();
}
//-->
</SCRIPT>
</head>
<BODY bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>

<table width=100% height=100% cellpadding=0 cellspacing=0 border=0 >
<tr>
<td width=5 align=center >&nbsp;</td>
<td width=100% height=100% valign=top align=center bgcolor=#ffffff>

	<!--타이틀-->
	<table width=100% cellpadding=0 cellspacing=0 border=0>
	<tr>
	<td width=10>&nbsp;</td>
	<td><img src="<%=urlPage%>rms/image/user/pop_title_idcheck_j.gif" ></td>
	</tr>
	<tr height="1"  bgcolor="#E6E6E6"><td colspan="2"></td></tr>
	</table>
	
<!--내용넣기 시작-->
	<table width=390 cellpadding=0 cellspacing=0 border=0>
<form name="searchId" action="<%=urlPage%>tokubetu/admin/member/member_id.jsp" method="post"  onSubmit = "">
	<input type="hidden" name="CHECKED_EMAIL" value="<%=memId%>">
	<tr>
	<td width=1 height=10 >&nbsp;</td>
	</tr>
<c:if test="${!empty member}">		
	<tr>
<!-- 	사용중인 아이디가 있을경우 노출  시작-->
	<td height=70 align=center>
	Stop! "<b>${member.member_id}</b>"は現在使われているIDなので<br>
	もう一度検索して下さい。		
	</td>
<!-- 	사용중인 아이디가 있을경우 노출  끝-->	
	</tr>
</c:if>
<c:if test="${empty member}">	
	<tr>
<!-- 	사용중인 아이디가 없을경우 노출 시작-->
	<td align=center height=50>	
		<table cellpadding=0 cellspacing=0 border=0 align=center>		
			<tr>
				<td><font color="#2266BB"><b>ID:</b><%=memId%></font><br>
このIDは使うことができます。<br><br>
"<%=memId%>"にきめたいなら次の送信を押していただきます。<br>
しかし、他のIDがほしかったら下でもう一度探してください！！。

				</td>
			</tr>
			<tr>
				<td align="center">&nbsp;&nbsp;&nbsp;	
					<a href="javascript:choice('<%=memId%>')" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/user/btn_big_send.gif"  border=0></a>
				</td>
			</tr>
		</table>	
	</td>
<!-- 	사용중인 아이디가 없을경우 노출 시작 끝-->
	</tr>
</c:if>
	<tr><td background="<%=urlPage%>rms/image/dot_line_all.gif"></td></tr>
	<tr>
	<td width=1 height=10>&nbsp;</td>
	</tr>
	</table>

	<table width=390 cellpadding=0 cellspacing=0 border=0>
	<tr>
	<td align=center>	
		<table cellpadding=0 cellspacing=0 border=0>
			<tr>
				<td>*search</td>
				<td><input type="text" name="member_id" value="" maxlength="30" class="logbox" style="width:120px">
				</td>
				<td><a href="javascript:doSh()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/pop_seach_j.gif"  style="cursor:hand;"></a></td>
			</tr>
		</table>		
	</td>
	</tr>
	</form>
	</table>	
<!--내용넣기 끝-->	
</td>
<td width=5 align=center >&nbsp;</td></tr>
<tr>
<td>&nbsp;</td>
<td width=100% height=34 >
	<table width=100% height="34" border=0 cellpadding=0 cellspacing=0>
		<tr>
			<td width=125>&nbsp;</td>
			<td width=100% align=right>	
				<table cellpadding=0 cellspacing=0 border=0>
				   <tr> 
					 <td align=right><a href="javascript:close();" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/user/layer_news_x.gif"  border=0></a></td>
				   </tr>
				</table>	
			</td>
		</tr>
	</table>	
</td>
</tr>
</table>		
</center>

</body>
</html>

	
