<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CateMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>
	


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
	
	String bseq=request.getParameter("bseq");
	String name=request.getParameter("name");	
	String cateNo=request.getParameter("frmNo");	//parent_id		
		
	CateMgr manager = CateMgr.getInstance();
	if(bseq !=null && name !=null){
		manager.update(Integer.parseInt(bseq),name,Integer.parseInt(cateNo));			
	}

%>

<script language="JavaScript">
alert("修正しました");
 location.href = "<%=urlPage%>rms/admin/hinsithu/cate_pop.jsp";
</script>

<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>	