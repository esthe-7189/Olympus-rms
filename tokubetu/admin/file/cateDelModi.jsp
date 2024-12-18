<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.tokubetu.Category" %>
<%@ page import = "mira.tokubetu.CateMgr" %>
<%@ page import=  "mira.tokubetu.MgrException" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>


<jsp:useBean id="pds" class="mira.tokubetu.Category">
    <jsp:setProperty name="pds" property="*" />
</jsp:useBean>
	
<%
	String urlPage=request.getContextPath()+"/";		
	String bseq=request.getParameter("bseqModi");
	String seq=request.getParameter("seq"); 
	String level=request.getParameter("level");
	String groupId=request.getParameter("groupIdDel");
	
	int bseqInt=Integer.parseInt(bseq);	
	int levelInt=Integer.parseInt(level);		
	int groupIdInt=Integer.parseInt(groupId);		
	
	CateMgr manager = CateMgr.getInstance();
	if(bseq !=null){
		manager.delete(bseqInt,levelInt,groupIdInt);							


%>
<script language="JavaScript">
alert("削除しました。");
  location.href = "<%=urlPage%>tokubetu/admin/file/modifyForm.jsp?seq=<%=seq%>";
</script>
<%}else{%>
<script language="JavaScript">
alert("項目を選択して下さい");
  location.href = "<%=urlPage%>tokubetu/admin/file/modifyForm.jsp?seq=<%=seq%>";
</script>	

<%}%>