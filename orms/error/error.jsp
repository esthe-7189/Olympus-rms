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
<body  leftmargin="50"  topmargin="20"  marginwidth="0"  marginheight="0"  border="0" align="center">
	
<table  width="60%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF" align="center" >
<tr>
		<td bgcolor= "#F7F5EF" style="padding: 5 0 5 10" class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=60);">
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=30);">error！！</td>		
</tr>
<tr>
	<td align="center" style="padding: 0 0 30 0" colspan="2">						
		<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>	
			<tr>
			<td align="center"><br><br>システムの障害です。もう一回行っていただきます。<br>시스템 장애 또는 원하시는 내용이 없으니 다시 확인하신 후 이용해 주세요!!<br>
			Error Message: <%= exception.getMessage() %>
		<p>
		<a href="<%=urlPage%>index.jsp">メインへ(Main)</a><br>
		<a href="javascript:history.go(-1);">前のページへ(Back)</a>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
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
	
	</td>
</table>


</body>
</html>