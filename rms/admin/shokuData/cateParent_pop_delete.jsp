<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import = "mira.shokudata.FileMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.Timestamp" %>

<%
 String urlPage=request.getContextPath()+"/";	
 String id=(String)session.getAttribute("ID");

	CateMgr manager=CateMgr.getInstance();
	FileMgr manager2=FileMgr.getInstance();		
	
		String seq=request.getParameter("seq");		
		Category cate=manager2.selectFile(Integer.parseInt(seq));
	if(cate==null){
		manager.deleteMCateSeq(Integer.parseInt(seq));					
 %>
	<script language="JavaScript">
	alert("削除しました");
	location.href="<%=urlPage%>rms/admin/shokuData/cateParent_pop.jsp";
	</script>			
 <%}else{ %>
 	<script language="JavaScript">
	alert("この大分類を削除する前、ファイルを先に削除して下さい。");
	opener.location.href="<%=urlPage%>rms/admin/shokuData/listForm.jsp?pg=<%=seq%>";
	self.close();
	</script>		
 
 <%}%>