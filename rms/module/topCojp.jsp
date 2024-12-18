<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>

<%
String urlPage=request.getContextPath()+"/";	
String urlPageRms=request.getContextPath()+"/rms/home/home.jsp";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");

%>
<form name="move">
<div class="cat_menu_cont">
<ul>	
	 
	<li><a class="topnav"  href="javascript:goRms()" onfocus="this.blur()"> オリンパスRMS株式会社 </a></li> 	
	<li><a class="topnav"  href="javascript:goRmsAdmin()" onfocus="this.blur()"> オリンパスRMSグループウェア </a></li> 
</ul>
  </div>
</form>	
<script language="JavaScript">
function goRms() {
    document.move.action = "http://www.olympus-rms.co.jp/";    
    document.move.submit();
}
function goOlympus() {
    document.move.action = "<%=urlPage%>accounting/member/loginForm.jsp";    
    document.move.submit();
}

function goSewon() {
    document.move.action = "<%=urlPage%>tokubetu/member/loginForm.jsp";    
    document.move.submit();
}
function goRmsAdmin() {
    document.move.action = "<%=urlPage%>rms/member/loginForm.jsp";    
    document.move.submit();
}
</script>




