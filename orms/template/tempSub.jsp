<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/orms/hoan-jsp"; %>
<%@ include file = "/orms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/orms/hoan-jsp/castle_referee.jsp" %>
<%
String contentPage1 = request.getParameter("CSSPAGE1");	
String urlPage=request.getContextPath()+"/orms/";
%>
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
<Link rel="shortcut icon"  href="<%=urlPage%>common/favicon.ico" />
<script type="text/javascript" src="<%=urlPage%>hoan-jsp/castle.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/default.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/prototype.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/jquery.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/jquery_easing.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/jquery_easyslider.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/jquery_fancybox.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/jquery_flash.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/jquery_sifr.js"></script>
<script type="text/javascript" src="<%=urlPage%>common/js/common.js"></script>
<script language="JavaScript">
//font style
function highlight(which,color){
    if (document.all||document.getElementById)
    which.style.backgroundColor=color
}
</script>	
</head>
<body>
<center>
<div id="wrapper">	
<h2 class="blind">top</h2>
<div id="skipmenu">
<a href="#top">top</a><br/>
<a href="#content">content</a><br/>		
<a href="#footer">footer</a><br/>
</div>
<!--**************************** top begin *****************************************-->
<div id="top_area">         	
	<jsp:include page="/orms/module/topMain.jsp" flush="false"/>
</div>	
<!-- *********************************top end *********************************************-->	
<h2 class="blind">contnet</h2>
<!-- *********************************content begin*********************************************-->	
<div id="contnet_area">	
	<jsp:include page="<%= contentPage1%>" flush="false"/>		 
</div>
<!-- *********************************content end*********************************************-->	
</center> 
<h2 class="blind">footer</h2>
<!-- footer begin -->	 
<div id="footer_area">
	<jsp:include page="/orms/module/footer.jsp" flush="false"/>
</div>
 <!-- footer end -->		 	
</body>
</html>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

