<%@ page contentType = "text/html; charset=utf8" %>

<%
String urlPage=request.getContextPath()+"/";
%>
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
</head>

<script language=vbscript>
	sub window_onload()
		document.check.domain_name.focus()
	end sub
</script>
<Script language="JavaScript">
<!--
function addr_send(){
	if(!(document.check.domain_name.value.indexOf(".") != -1 )) {
		window.alert("メールを正しく書いて下さい。");
		return;
	}
	if ( document.check.domain_name.value == "" ) {
		alert("'@'の後を書いて下さい");
		document.check.domain_name.focus();
		return;
	}	
	kiss = new Array("~","`","!","#","$","%","^","&","*","(",")","/","\,","\\","?","<",">","+","=","|",":",";"," ","'","}","{","[","]");
	for (i = 0; i < document.check.domain_name.value.length ; i++) {
	  for ( j = 0 ; j < 28; j++){
			if( kiss[j] == document.check.domain_name.value.charAt(i)){
				alert("特殊文字などは入力不可能です。");
				return
		    }
	  }
	}

  if ( document.check.domain_name.value.indexOf("@") < 0 ) {	  
    opener.document.memberInput.email2.options[0].text = document.check.domain_name.value;
    opener.document.memberInput.email2.options[0].value = "@"+document.check.domain_name.value;
    opener.document.memberInput.email2.options[0].selected = "@"+document.check.domain_name.value;
    opener.document.memberInput.email2.focus();
    self.close();	  
  } else {
		alert("'@'の後を書いて下さい");
    document.check.domain_name.focus();
    return;
  }
}
-->
</script>

<BODY bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<table width=100% height=100% cellpadding=0 cellspacing=0 border=0 background="<%=urlPage%>rms/image/user/bg.gif">
<tr>
<td width=5 align=center background="<%=urlPage%>rms/image/user/pop_bg_02.gif">&nbsp;</td>
<td width=100% height=100% valign=top align=center bgcolor=#ffffff>
	<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr>
	<td width=5%>&nbsp;</td>
	<td><script>flashWrite('<%=urlPage%>rms/image/user/pop_email2.swf','250','80')</script></td>	
	</tr>
	</table>	
	<table width=100% cellpadding=0 cellspacing=0 border=0>
	<form name="check" method="post" onSubmit="return addr_send()">		
	<tr>
	<td width=1 height=10>&nbsp;</td>
	</tr>
	<tr>
	<td height=50 align=center>メールを書いて下さい</td>
	</tr>
	<tr><td background="<%=urlPage%>rms/image/dot_line_all.gif"></td></tr>	
	<tr>
	<td height=70 align=center>
		<input type="text" class="logbox"  name="domain_name" size="25" maxlength="25" style="width:130px;ime-mode:disabled">
		<br><br>@ の後を書いて下さい	
	</td>
	</tr>
	<tr>
	<tr><td background="<%=urlPage%>rms/image/dot_line_all.gif"></td></tr>	
	</tr>
	<tr>
	<td align=center height=50>	
		<table cellpadding=0 cellspacing=0 border=0>
		<tr>
		<td><a href="javascript:addr_send()" onfocus="this.blur()"><img src="<%=urlPage%>irms/image/user/btn_bic_kakunin.gif"  border=0></a></td>
		</tr>
		</table>	
	</td>
	</tr>
	</form>
	</table>

</td>
<td width=5 align=center background="<%=urlPage%>rms/image/user/pop_bg_02.gif">&nbsp;</td>
</tr>
<tr bgcolor="#999999">
<td background="<%=urlPage%>image/user/pop_bg.gif" WIDTH="40" HEIGHT="34" BORDER="0" ALT="">&nbsp;</td>
<td width=100% height=34 background="<%=urlPage%>image/user/pop_bg.gif" WIDTH="40" HEIGHT="34" BORDER="0" ALT="">
	<table width=100% height="34" border=0 cellpadding=0 cellspacing=0>
	<tr>
	<td width=125>BabyPose</td>
	<td width=100% align=right>	
		<table cellpadding=0 cellspacing=0 border=0>
                <tr> 
                 <td align=right><a href="javascript:close();"><IMG SRC="<%=urlPage%>rms/image/user/layer_news_x.gif" WIDTH="68" HEIGHT="34" BORDER="0" ALT=""></a></td>
                </tr>
              	</table>	
	</td>
	</tr>
	</table>
</td>
<td background="<%=urlPage%>image/user/pop_bg.gif" WIDTH="40" HEIGHT="34" BORDER="0" ALT=""></td>
</tr>
</table>		
</center>
</body>
</html>
