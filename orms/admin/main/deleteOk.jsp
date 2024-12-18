<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.main.Bean" %>
<%@ page import = "mira.main.Mgr" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
	
<%

	String urlPage=request.getContextPath()+"/";	
	String seq=request.getParameter("seq");

    Mgr manager = Mgr.getInstance();    
    manager.delete(Integer.parseInt(seq));
     
%>

	<script language="JavaScript">
	alert("情報を削除しました。");
	location.href = "<%=urlPage%>orms/admin/main/addForm.jsp";	
	</script>
