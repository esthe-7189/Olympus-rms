<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.acc.AccBean" %>
<%@ page import="mira.acc.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>

<jsp:useBean id="pds" class="mira.acc.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%
String urlPage=request.getContextPath()+"/";
String seq = request.getParameter("seq");	

   AccMgr mgr = AccMgr.getInstance();   
     mgr.delete(Integer.parseInt(seq));
%>
<script language="JavaScript">
alert("ファイルが削除されました");
location.href = "<%=urlPage%>accounting/admin/file/listForm.jsp";
</script>
