<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page errorPage="/rms/error/error.jsp"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManagerException" %>


<%
String urlPage=request.getContextPath()+"/";

String kindForm=request.getParameter("kindForm");
String nm=null; 
String himithu_1=null;
String himithu_2=null;
String member_id=null;
String pw=null;
if (kindForm==null){kindForm="no"; }

else if (kindForm.equals("yes")){
	nm=request.getParameter("nm");
	//member_id=request.getParameter("member_id");
	himithu_1=request.getParameter("himithu_1");
	himithu_2=request.getParameter("himithu_2");
	
	MemberManager manager=MemberManager.getInstance();
	Member member=manager.idChk(nm,himithu_1,himithu_2);
	
	if (member !=null){
		member_id=member.getMember_id();
		pw=member.getPassword();
	}else{
		kindForm="memberNo";
	}

}
%>

<html>
<head>
<title>ID Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<script language=vbscript>
	sub window_onload()
		document.srcId.cname.focus()
	end sub
</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function doSrc(){
	with(document.srcId){
		if(isEmpty(nm, "名前を正確に書いて下さい?")) return false;
		if(isEmpty(himithu_2, "秘密の答えを入力して下さい!")) return false;				
	}
}

function resize(width, height){
	//alert("사이즈를 재조정합니다");
	window.resizeTo(width, height);
}
//-->
</SCRIPT>

</head>
<BODY bgcolor="#999999" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onload="javascript:resize('440','430');">
<center>
<table width=100% height=100% cellpadding=1 cellspacing=1 border=0 background="<%=urlPage%>rms/image/user/pop_bg.gif">
<!-- form -->
<form name="srcId" method="post" onSubmit="return doSrc(this)" action="pop_idPw.jsp">
<tr>
<td width=5 align=center ></td>
<td width=100% height=100% valign=top  bgcolor=#ffffff>	

	<!--내용넣기-->
	<table width=400 cellpadding=0 cellspacing=0 border=0 align=center>
	<tr >
		<td ><img src="<%=urlPage%>rms/image/user/pop_title_idsch_j.gif"></td>	
	</tr>
	<tr >
		<td align=center background="<%=urlPage%>rms/image/dot_line_all.gif"></td>
	</tr>
	<td align=center>	
		<table width="90%" cellpadding=0 cellspacing=0 border=0>
		<tr height=><td colspan="2">&nbsp;</td></tr>
		<tr>		
			<td width="28%" style="padding: 3 0 3 0"><img src="<%=urlPage%>rms/image/icon_s.gif" >氏名:</td>
			<td width="72%" style="padding: 3 0 3 0" >
				<input type="text" maxlength="20" name="nm" class="logbox" style="width:135px">
			</td>
		</tr>		
		<tr>
			<td style="padding: 3 0 3 0"><img src="<%=urlPage%>rms/image/icon_s.gif" >秘密の質問:</td>
			<td style="padding: 3 0 3 0">
				<select name="himithu_1">
					<option value="1"  selected>飼っているペットの名前は？</option>	
					<option value="2"  selected>旅行に行きたい場所は？</option>
					<option value="3"  selected>子ども時代のヒーローは？</option>	
					<option value="4"  selected>嫌いな食べ物は？</option>	
					<option value="5"  selected>応援しているチームは？</option>	
					<option value="6"  selected>名前を変えるとしたら何？</option>
					<option value="7"  selected>よくドライブした場所は？</option>
					<option value="8"  selected>一番好きな映画は？</option>	
				</select>			
			</td>	
		</tr>
		<tr>
			<td style="padding: 3 0 3 0"><img src="<%=urlPage%>rms/image/icon_s.gif" >秘密の答え:</td>
			<td style="padding: 3 0 3 0">			
				<input type="text" name="himithu_2"  value=""  maxlength="50"  class="logbox" style="width:130px">
			</td>
		<input type="hidden" name="kindForm" value="yes">
		</tr>
		</table>	
	</td>
	</tr>
	<tr>
	<td height=60 align=center>		
		<table cellpadding=0 cellspacing=0 border=0>
			<tr>
				<td><input type=image src="<%=urlPage%>rms/image/user/btn_big_send.gif"  onfocus="this.blur()"></td>
			</tr>
		</table>	
	</td>
	</tr>
	<tr>
	<td align=center background="<%=urlPage%>rms/image/dot_line_all.gif"></td>
	</tr>
	</table>

	<table width=400 cellpadding=0 cellspacing=0 border=0>		
		<tr>
			<td><img src="<%=urlPage%>rms/image/shop/order_denger.gif"  align=absmiddle>確認後情報をきちんと守るためにこのウィンドウズを閉めてください!</td>
		</tr>	
		<tr>
			<td width=1 height=10></td>
		</tr>
		<tr>
			<td align=center>
<%if (kindForm.equals("yes")){%>
				<table class=c align=center>
					<tr>
						<td bgcolor="f4f4f4" >
						<font color="#3399CC"><%=nm%></font>様のIDとPasswordは次のようです。<br>
						<img src="<%=urlPage%>rms/image/icon_s.gif" ><font color="#3399CC">id: </font><%=member_id%>	&nbsp;&nbsp;	
						<img src="<%=urlPage%>rms/image/icon_s.gif" ><font color="#3399CC">pw: </font><%=pw.substring(0,3)%><font color="#FF9900">~で始まる</font></td>
					</tr>
				</table>	
<%}else if (kindForm.equals("memberNo")){
		MemberManager manager=MemberManager.getInstance();
		Member member2=manager.idCh(member_id);
			if (member2==null){			
%>
				<table class=c align=center>
					<tr>
						<td bgcolor="f4f4f4" >
						<font color="#3399CC"><%=nm%></font>様のIDとPasswordが見つけられません。
						<a href="javascript:opener.location.href='<%=urlPage%>rms/member/writeForm.jsp'; window.close();" onfocus="this.blur()">
						<img src="<%=urlPage%>rms/image/user/login_pop_btn_j.gif"  align=absmiddle></a>
						</td>
					</tr>
				</table>	
<%		}else{%>
				<table class=c align=center>
					<tr>
						<td bgcolor="f4f4f4" >
						<font color="#3399CC"><%=member_id%></font>様のIDは既に使われております。<br>
						確認或いは管理者に問い合わせください。
						</td>
					</tr>
				</table>	

<%}}%>			
			</td>
		</tr>	
	</table>

	
	<!--내용넣기-->

	
</td>
<td width=5 align=center background="<%=urlPage%>rms/image/user/pop_bg_02.gif"></td>
</tr>
<tr bgcolor="#999999">
<td background="<%=urlPage%>rms/image/user/pop_bg_03.gif"  width=5 height=1></td>
<td width=100% height=34 background="<%=urlPage%>rms/image/user/pop_bg_03.gif">
	<table width=100% height="34" border=0 cellpadding=0 cellspacing=0>
	<tr>
	<td width=125>olympus-rms</td>
	<td align=right>
		<table cellpadding=0 cellspacing=0 border=0>
                <tr>
                 <td align=right><a href="javascript:close();" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/user/pop_close.gif" width=68 height=34 border=0></a></td>
                </tr>
              	</table>
	</td>
	</tr>
	</table>
</td>
<td background="<%=urlPage%>rms/image/user/pop_bg_03.gif" width=5 height=1></td>
</tr>
</table>
</center>
</body>
</html>
								