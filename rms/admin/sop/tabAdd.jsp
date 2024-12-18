<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.sop.AccBean" %>
<%@ page import = "mira.sop.AccMgr" %>
<%@ page import=  "mira.sop.MgrException" %>
	
<jsp:useBean id="category" class="mira.sop.AccBean">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/";
String nm=request.getParameter("name_tab"); 

if(nm==null){
	nm="no data";
}
category.setName_tab(nm);	
	AccMgr manager = AccMgr.getInstance();
	manager.insertTab(category);
%>

<script language="JavaScript">
  alert("処理しました。");
  parent.location.href = "<%=urlPage%>rms/admin/sop/listForm.jsp";  
</script>







