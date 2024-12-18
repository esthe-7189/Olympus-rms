<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%
String urlPage=request.getContextPath()+"/orms/";
String urlPage_rms=request.getContextPath()+"/rms/";
String urlPage_acc=request.getContextPath()+"/accounting/";
String urlPageRms=request.getContextPath()+"/rms/home/home.jsp";
Calendar cal = Calendar.getInstance();
%>


<table id="footer2" cellspacing="0" cellpadding="0" align="center" border="0" width="100%">
<tr>
<td align="center">
	<table align="center" border="0" width="960">
	<tr>
	<td align="left" width="200">.</td>
	<td align="right" style="word-spacing:6px;font-size:80%;padding-right:10px;">
		<a href="<%=urlPageRms%>" target="_top">HOME</a> |		
		<a href='http://www.olympus.co.jp' target="_blank">OLYMPUS</a> |
		<a href="http://www.sewoncellontech.com" target="_blank">SEWONCELLONTECH</a>		
	<!--<a href="#top" target="_top">TOP</a> | -->
	</td>
	</tr>
	<tr>
	<td valign="top" colspan="2" align="center" style="padding-top:10px;color:#404040;">
		Copyright  &copy; (C)<%=cal.get(cal.YEAR)%>	 Olympus-rms All rights reserved.
	</td>
	</tr>
	</table>
	<br />
</td>
</tr>
</table>

	

