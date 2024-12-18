<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%
 String urlPage=request.getContextPath()+"/";
String kind=request.getParameter("kind");
%>

<html>
<head>
<title>OLYMPUS-RMS</title>
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
<script type="text/javascript">
function addr_send(){
	 if(document.check.kind.value=="kanri"){
	    opener.document.forminput.kanri_noVal.options[0].text = document.check.domain_name.value;
	    opener.document.forminput.kanri_noVal.options[0].value = document.check.domain_name.value;
	    opener.document.forminput.kanri_noVal.options[0].selected = document.check.domain_name.value;
	    opener.document.forminput.kanri_no.value = document.check.domain_name.value;
	    opener.document.forminput.kanri_noVal.focus();    
	    self.close();
	  }else if(document.check.kind.value=="eda"){
	    opener.document.forminput.eda_noVal.options[0].text = document.check.domain_name.value;
	    opener.document.forminput.eda_noVal.options[0].value = document.check.domain_name.value;
	    opener.document.forminput.eda_noVal.options[0].selected = document.check.domain_name.value;
	    opener.document.forminput.eda_no.value = document.check.domain_name.value;
	    opener.document.forminput.eda_noVal.focus();    
	    self.close();
	 }else if(document.check.kind.value=="kanriUpdate"){
	    opener.document.forminputUp.kanri_noVal.options[0].text = document.check.domain_name.value;
	    opener.document.forminputUp.kanri_noVal.options[0].value = document.check.domain_name.value;
	    opener.document.forminputUp.kanri_noVal.options[0].selected = document.check.domain_name.value;
	    opener.document.forminputUp.kanri_noVal.value = document.check.domain_name.value;
	    opener.document.forminputUp.kanri_noVal.focus();    
	    self.close();
	 }else if(document.check.kind.value=="edaUpdate"){
	    opener.document.forminputUp.eda_noVal.options[0].text = document.check.domain_name.value;
	    opener.document.forminputUp.eda_noVal.options[0].value = document.check.domain_name.value;
	    opener.document.forminputUp.eda_noVal.options[0].selected = document.check.domain_name.value;
	    opener.document.forminputUp.eda_no.value = document.check.domain_name.value;
	    opener.document.forminputUp.eda_noVal.focus();    
	    self.close();	 
	}
}
</script>

<BODY bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<table width=100% height=100% cellpadding=0 cellspacing=0 border=0 >
<form name="check" method="post" onSubmit="return addr_send()">
		<input type="hidden" name="kind"  value="<%=kind%>">
<tr>
	<td align=center>	
		新しいデータを入力して下さい<br><br>
					
		<input type="text" class="logbox"  name="domain_name" size="25" maxlength="25" style="width:130px;ime-mode:disabled">
		<a href="javascript:addr_send()" onfocus="this.blur()">[ 登録 ]</a>							
	</td>
</tr>
<tr>
</form>
</table>		
</center>
</body>
</html>