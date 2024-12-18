<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.info.Category" %>
<%@ page import = "mira.info.CateMgr" %>
<%@ page import=  "mira.info.MgrException" %>
<%@ page import="mira.info.BunshoBean" %>
<%@ page import="mira.info.BunshoMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>


<jsp:useBean id="pds" class="mira.info.BunshoBean">
    <jsp:setProperty name="pds" property="*" />
</jsp:useBean>
	
<%
	String urlPage=request.getContextPath()+"/orms/";		
	String bseq=request.getParameter("bseqModi");
	String level=request.getParameter("level");
	String groupId=request.getParameter("groupIdDel");
	
	int bseqInt=Integer.parseInt(bseq);	
	int levelInt=Integer.parseInt(level);		
	int groupIdInt=Integer.parseInt(groupId);		
	
	CateMgr manager = CateMgr.getInstance();
//	BunshoMgr mgr = BunshoMgr.getInstance();   
     

	if(bseq !=null){		
	//	mgr.deleteLevel1(bseqInt);     //파일 삭제
		manager.delete(bseqInt,levelInt,groupIdInt);							


%>
<script language="JavaScript">
alert("削除しました。");
  location.href = "<%=urlPage%>admin/info/cateAddForm.jsp";
</script>
<%}else{%>
<script language="JavaScript">
alert("項目を選択して下さい");
  location.href = "<%=urlPage%>admin/info/cateAddForm.jsp";
</script>	

<%}%>