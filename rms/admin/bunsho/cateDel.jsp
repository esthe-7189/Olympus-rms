<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.bunsho.Category" %>
<%@ page import = "mira.bunsho.CateMgr" %>
<%@ page import=  "mira.bunsho.MgrException" %>
<%@ page import="mira.bunsho.BunshoBean" %>
<%@ page import="mira.bunsho.BunshoMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>


<jsp:useBean id="pds" class="mira.bunsho.BunshoBean">
    <jsp:setProperty name="pds" property="*" />
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
	String bseq=request.getParameter("lgroup");
	String level=request.getParameter("level");
	String groupId=request.getParameter("groupId");
	
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
  location.href = "<%=urlPage%>rms/admin/bunsho/cate_pop.jsp";
</script>
<%}else{%>
<script language="JavaScript">
alert("項目を選択して下さい");
  location.href = "<%=urlPage%>rms/admin/bunsho/cate_pop.jsp";
</script>	

<%}%>