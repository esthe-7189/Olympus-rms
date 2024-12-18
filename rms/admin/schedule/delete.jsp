<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "java.sql.Timestamp" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";

String pg=request.getParameter("pg");
String seq=request.getParameter("seq");
String monthVal=request.getParameter("monthVal");
String yearVal=request.getParameter("yearVal");

DataMgr manager = DataMgr.getInstance();	
manager.deleteSch(Integer.parseInt(seq));
/*
manager.deleteSchSignup(Integer.parseInt(seq));
manager.deleteSchFellow(Integer.parseInt(seq));
*/

if(pg.equals("list")){
%>
<script language="JavaScript">
	alert("削除しました。");
  	parent.document.location.href = "<%=urlPage%>rms/admin/schedule/listForm.jsp?month=<%=monthVal%>&year=<%=yearVal%>&action=0";	
	parent.document.getElementById('qPop').style.display = 'none';
</script>
<%}else if(pg.equals("cal")){%>
	<script language="JavaScript">
		alert("削除しました。");
	  	parent.document.location.href = "<%=urlPage%>rms/admin/schedule/monthForm.jsp?month=<%=monthVal%>&year=<%=yearVal%>&action=0";	
		parent.document.getElementById('qPop').style.display = 'none';
	</script>
<%}%>
	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
















