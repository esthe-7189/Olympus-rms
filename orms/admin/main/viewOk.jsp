<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.main.Bean" %>
<%@ page import = "mira.main.Mgr" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>

<%
	String urlPage=request.getContextPath()+"/";
	String seq=request.getParameter("seq");
	String okYn=request.getParameter("okYn");			
	
if (seq != null){	
	 Mgr manager = Mgr.getInstance();	
       manager.updateViewSeq(Integer.parseInt(okYn),Integer.parseInt(seq));  
%>

	<script language="JavaScript">
	alert("変更OK!!");
	location.href = "<%=urlPage%>orms/admin/main/addForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!. ");
	history.go(-1);
	</script>
<%}%>