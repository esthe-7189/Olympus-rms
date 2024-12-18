<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
	
<jsp:useBean id="category" class="mira.shokudata.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/";
String lgroup_no=request.getParameter("lgroup_no");
String nm=request.getParameter("name"); 
String cateNo=request.getParameter("viewNo"); 

if(nm==null){
	nm="data is not";
}
category.setName(nm);	
category.setCateNo(Integer.parseInt(cateNo));	
category.setLevel(1);	
category.setKind(Integer.parseInt(lgroup_no));	
	CateMgr manager = CateMgr.getInstance();
	manager.insertBoard(category);
%>

<script language="JavaScript">
  location.href = "<%=urlPage%>rms/admin/shokuData/cateAddForm.jsp?hCateCode=<%=lgroup_no%>";
</script>







