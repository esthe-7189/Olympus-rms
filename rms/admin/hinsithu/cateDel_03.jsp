<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CateMgr" %>
<%@ page import="mira.hinsithu.HinsithuBean" %>
<%@ page import="mira.hinsithu.HinsithuMgr" %>
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
	String bseq=request.getParameter("seq");
	String level=request.getParameter("level");
	String mgroup=request.getParameter("mgroup"); 
	
	int bseqInt=Integer.parseInt(bseq);	
	int levelInt=Integer.parseInt(level);	
	int mgroupint=Integer.parseInt(mgroup);		
	
	CateMgr manager = CateMgr.getInstance();

	if(bseq !=null){		
	//	manager.proDel(bseqInt);     //파일 삭제		
		manager.delete(bseqInt,levelInt,mgroupint);							


%>
<script language="JavaScript">
alert("削除しました。");
  location.href = "<%=urlPage%>rms/admin/seizo/Sgroup_pop.jsp?lgroup=<%=bseq%>&mgroup=<%=mgroup%>";
</script>
<%}else{%>
<script language="JavaScript">
alert("項目を選択して下さい");
  location.href = "<%=urlPage%>rms/admin/seizo/Sgroup_pop.jsp?lgroup=<%=bseq%>&mgroup=<%=mgroup%>";
</script>	

<%}%>