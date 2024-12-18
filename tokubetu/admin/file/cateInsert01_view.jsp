<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.tokubetu.Category" %>
<%@ page import = "mira.tokubetu.CateMgr" %>
<%@ page import=  "mira.tokubetu.MgrException" %>
	
<jsp:useBean id="category" class="mira.tokubetu.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/";
String nm=request.getParameter("name"); 

if(nm==null){
	nm="no data";
}
category.setName(nm);	
category.setLevel(1);	
category.setKind(0);	
	CateMgr manager = CateMgr.getInstance();
	manager.insertBoard(category);
%>

<script language="JavaScript">
  location.href = "<%=urlPage%>tokubetu/admin/file/cateAddForm.jsp";
</script>







