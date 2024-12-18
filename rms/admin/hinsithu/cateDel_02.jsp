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
	String bseq=request.getParameter("lgroup");
	String level=request.getParameter("level");
	String pbseq=request.getParameter("pbseq");
	String groupId=request.getParameter("groupId");
	
	int bseqInt=Integer.parseInt(bseq);	
	int levelInt=Integer.parseInt(level);
	int groupIdInt=Integer.parseInt(groupId);				
	
	CateMgr manager = CateMgr.getInstance();

	if(bseq !=null){			
		manager.delete(bseqInt,levelInt,groupIdInt);		
/*		
		HinsithuMgr mgr = HinsithuMgr.getInstance();   //파일 삭제
   if(file_kind.equals("2")){
   	mgr.deleteLevel2(Integer.parseInt(fno));
   	mgr.updateHenkoLeve_0(Integer.parseInt(fno),0);
   }else if(file_kind.equals("3")){
   	mgr.deleteLevel3(Integer.parseInt(bseq));
   	mgr.updateHenkoLeve_2(Integer.parseInt(parentId),0);
   }else if(file_kind.equals("4")){
   	mgr.deleteLevel4(Integer.parseInt(bseq));   	
   	mgr.updateHenkoLeve_2(Integer.parseInt(parentId),0);
   }						
*/	

%>
<script language="JavaScript">
alert("削除しました。");
  location.href = "<%=urlPage%>rms/admin/hinsithu/Mgroup_pop.jsp?lgroup=<%=pbseq%>&groupId=<%=pbseq%>";
</script>
<%}else{%>
<script language="JavaScript">
alert("項目を選択して下さい");
  location.href = "<%=urlPage%>rms/admin/hinsithu/Mgroup_pop.jsp?lgroup=<%=pbseq%>&groupId=<%=pbseq%>";
</script>	

<%}%>