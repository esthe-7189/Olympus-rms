<%@ page contentType="text/html; charset=utf-8"%>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%
String urlPage=request.getContextPath()+"/";	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">	
<head>
<title>OLYMPUS RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<%=urlPage%>rms/css/style.css" type="text/css">		
<script type="text/javascript" src="<%=urlPage%>rms/js/fadeEffects.js"></script>
<script language="javascript" src="<%=urlPage%>rms/js/Commonjs.js"></script>
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
<Link rel="shortcut icon"  href="<%=urlPage%>orms/common/favicon.ico" />

<style type="text/css">
	input.calendar { behavior:url(calendar.htc); }
</style>
<script language="JavaScript">
function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
        todayDate.setDate( todayDate.getDate() + expiredays );
        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }

function closeWin() {
    if ( document.notice_form.chkbox.checked ){
        setCookie( "maindiv", "done" , 1 );
    }
    document.all['divpop'].style.visibility = "hidden";
}
</script>


</head>

<body  leftmargin="0"  topmargin="0"  marginwidth="0"  marginheight="0"  border="0" >
<script src="http://weblog.olympus-rms.com/hanbiro.js"></script> 	

<div id="loadingBar" ><img src="<%=urlPage%>rms/image/loader.gif"></div>
<div id="login_container" >	
	<div id="login_top">
		<jsp:include page="/rms/module/top.jsp" flush="false"/>
	</div>
	<div id="login_restofpage" >
		hghghghghghgh
	</div>	
</div>
<div id="login_footer_container">
	<jsp:include page="/rms/module/footer.jsp" flush="false"/>
</div>
<script language="JavaScript">
document.getElementById('loadingBar').style.display="none";
document.getElementById('login_container').style.display="";
</script>


</body>
</html>
