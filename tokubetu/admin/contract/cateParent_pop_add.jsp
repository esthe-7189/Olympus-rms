<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.contract.Category" %>
<%@ page import = "mira.contract.CateMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.Timestamp" %>

	
<%
  request.setCharacterEncoding("utf-8");
 String urlPage=request.getContextPath()+"/";	 
%>
<jsp:useBean id="category" class="mira.contract.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%

	CateMgr manager=CateMgr.getInstance();		
		manager.insertMcate(category);
	
 %>
	<script language="JavaScript">
	alert("完了しました");
	location.href="<%=urlPage%>tokubetu/admin/contract/cateParent_pop.jsp";
	</script>		

















