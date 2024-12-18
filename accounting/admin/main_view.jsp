<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("acc")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%}%>


<table width="99%" border="0" cellspacing="0" cellpadding="0">	
	<tr>
    		<td align="center" height="100" background="<%=urlPage%>image/user/left_img01.gif">
    			準備中<br>
    			
    			
    		</td>
  	</tr>
  	  	
</table>	
			
