<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.job.Category" %>
<%@ page import = "mira.job.CateMgr" %>
<%@ page import=  "mira.job.MgrException" %>
	
<jsp:useBean id="category" class="mira.job.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/orms/";
String nm=request.getParameter("name"); 

if(nm==null){
	nm="data is not";
}
category.setName(nm);	
category.setLevel(1);	
category.setKind(0);	
	CateMgr manager = CateMgr.getInstance();
	manager.insertBoard(category);
%>

<script language="JavaScript">
  location.href = "<%=urlPage%>admin/job/cateAddForm.jsp";
</script>







