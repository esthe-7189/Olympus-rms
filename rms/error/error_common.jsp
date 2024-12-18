<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>	
<%@ page import = "javax.servlet.ServletException" %>
<%@ page isErrorPage = "true" %>
<%
request.setCharacterEncoding("utf-8");
String urlPage=request.getContextPath()+"/";	
%>
<html>
<head>
<title>OLYMPUS RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">

</head>
<body >
<p>
<table align=center  width="500"  height="460" background="<%=urlPage%>rms/image/error.gif" class=c>
<tr>
	<td align="center"><br><br>システムの障害です。もう一回行っていただきます。<br>시스템 장애 또는 원하시는 내용이 없으니 다시 확인하신 후 이용해 주세요!!<br>
Error Message: <%= exception.getMessage() %>
<p>
<a href="<%=urlPage%>index.jsp">メインへ(Main)</a><br>
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