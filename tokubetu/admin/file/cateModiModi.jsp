<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.tokubetu.Category" %>
<%@ page import = "mira.tokubetu.CateMgr" %>
<%@ page import=  "mira.tokubetu.MgrException" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>
	

<%
	String urlPage=request.getContextPath()+"/";	
	
	String bseq=request.getParameter("bseq");
	String seq=request.getParameter("seq"); 
	String name=request.getParameter("nameModi");	
	String cateNo=request.getParameter("cateNo");	//parent_id		
		
	CateMgr manager = CateMgr.getInstance();
	if(bseq !=null && name !=null){
		manager.update(Integer.parseInt(bseq),name,Integer.parseInt(cateNo));			
	}

%>

<script language="JavaScript">
alert("修正しました");
 location.href = "<%=urlPage%>tokubetu/admin/file/modifyForm.jsp?seq=<%=seq%>";
</script>
