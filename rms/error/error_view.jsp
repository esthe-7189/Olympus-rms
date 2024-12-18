<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>	
<%@ page import = "javax.servlet.ServletException" %>
<%@ page isErrorPage = "true" %>
<%
request.setCharacterEncoding("utf-8");
String contextPath=request.getContextPath()+"/";		
%>
<body  leftmargin="0"  topmargin="0"  marginwidth="0"  marginheight="0"  border="0" >
<script src="http://weblog.olympus-rms.com/hanbiro.js"></script> 	
<table align=center  width="500"  height="460" background="<%=contextPath%>rms/image/error.gif" class=c>
<tr>
	<td align="center"><br><br>システムの障害です。もう一度行っていただきます。
Error Message: <%= exception.getMessage() %>
<p>
<a href="<%=contextPath%>">メインへ(Main)</a><br>
<a href="javascript:history.go(-1);">前のページへ(Back)</a>
	</td>
</tr>
</table>

<%
    Throwable rootCause = null;
    if (exception instanceof ServletException) {
        rootCause = ((ServletException)exception).getRootCause();
    }
    if (rootCause != null) {
        do {
%>
メッセ?ジ: <%= rootCause.getMessage() %><br>
<%
            rootCause = rootCause.getCause();
        } while(rootCause != null);
    }
%>
</body>
</html>
