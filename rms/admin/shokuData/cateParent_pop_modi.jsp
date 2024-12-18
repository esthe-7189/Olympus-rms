<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.Timestamp" %>

<%
 request.setCharacterEncoding("utf-8");
 String urlPage=request.getContextPath()+"/";	
 String id=(String)session.getAttribute("ID");

	CateMgr manager=CateMgr.getInstance();		
	
		String seq=request.getParameter("seq");
		String orderNo=request.getParameter("orderNo");
		String name=request.getParameter("name");		
		manager.updateMCate(Integer.parseInt(orderNo), Integer.parseInt(seq), name);
	
 %>
	<script language="JavaScript">
	alert("完了しました");
	location.href="<%=urlPage%>rms/admin/shokuData/cateParent_pop.jsp";
	</script>		
