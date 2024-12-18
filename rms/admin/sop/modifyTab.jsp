<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
	
<jsp:useBean id="tab" class="mira.sop.AccBean">
    <jsp:setProperty name="tab" property="*" />
</jsp:useBean>
	
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
String stayPg=request.getParameter("stayPg");
String seq_tab=request.getParameter("seq_tab");
String name_tab=request.getParameter("name_tab");
String junbang=request.getParameter("junbang");
String pg_seq_tab=request.getParameter("pg_seq_tab");


AccMgr tabmgr=AccMgr.getInstance();	
if(seq_tab!=null){
	tab.setName_tab(name_tab);
	tab.setSeq_tab(Integer.parseInt(seq_tab));
	tab.setJunbang(Integer.parseInt(junbang));
	tabmgr.updatetab(tab);
%>
	<script language="JavaScript">	
	  alert("修正しました");
	  parent.location.href = "<%=urlPage%>rms/admin/sop/listForm.jsp";	  
	</script>
<%}else{%>
	<script language="JavaScript">	
	alert("修正失敗!!!!!  もう一度お願いします");
	  window.history(-1);
	</script>
<%}%>	
	
	
	
	

<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

