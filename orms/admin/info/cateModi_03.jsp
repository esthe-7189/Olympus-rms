﻿<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.info.Category" %>
<%@ page import = "mira.info.CateMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>
	

<%
	String urlPage=request.getContextPath()+"/orms/";	
	
	String bseq=request.getParameter("bseq");
	String name=request.getParameter("nameModi");	
	String cateNo=request.getParameter("cateNo");	//parent_id		
	String pbseq=request.getParameter("pbseq");
		
	CateMgr manager = CateMgr.getInstance();
	if(bseq !=null && name !=null){
		manager.update(Integer.parseInt(bseq),name,Integer.parseInt(cateNo));			
	}

%>

<script language="JavaScript">
alert("修正しました");
location.href = "<%=urlPage%>admin/info/Sgroup.jsp?lgroup=<%=pbseq%>&mgroup=<%=pbseq%>";
</script>
