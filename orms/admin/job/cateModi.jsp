<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.job.Category" %>
<%@ page import = "mira.job.CateMgr" %>
<%@ page import=  "mira.job.MgrException" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>
	

<%
	String urlPage=request.getContextPath()+"/orms/";	
	
	String bseq=request.getParameter("bseq");
	String name=request.getParameter("nameModi");	
	String cateNo=request.getParameter("cateNo");	//parent_id		
		
	CateMgr manager = CateMgr.getInstance();
	if(bseq !=null && name !=null){
		manager.update(Integer.parseInt(bseq),name,Integer.parseInt(cateNo));			
	}

%>

<script language="JavaScript">
alert("修正しました");
 location.href = "<%=urlPage%>admin/job/cateAddForm.jsp";
</script>
