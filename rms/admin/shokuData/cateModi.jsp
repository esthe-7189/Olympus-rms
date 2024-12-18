<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>
	

<%
	String urlPage=request.getContextPath()+"/";	
	
	String bseq=request.getParameter("bseq");
	String name=request.getParameter("nameModi");	
	String cateNo=request.getParameter("cateNo");		
	String lgroup_no=request.getParameter("lgroup_no");
	if(cateNo==null){cateNo="1";}	
	if(lgroup_no==null){cateNo="1";}	
	CateMgr manager = CateMgr.getInstance();
	if(bseq !=null && name !=null){
		
		manager.update(Integer.parseInt(bseq),name,Integer.parseInt(cateNo));			
	}

%>

<script language="JavaScript">
alert("修正しました");
 location.href = "<%=urlPage%>rms/admin/shokuData/cateAddForm.jsp?hCateCode=<%=lgroup_no%>";
</script>
