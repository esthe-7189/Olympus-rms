<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "mira.info.InfoBean" %>
<%@ page import = "mira.info.InfoMgr" %>

<%
 String urlPage=request.getContextPath()+"/orms/";	
%>
<jsp:useBean id="info" class="mira.info.InfoBean">
    <jsp:setProperty name="info" property="*" />
</jsp:useBean>

<%
	InfoMgr manager=InfoMgr.getInstance();
 	InfoBean oldBean=manager.getInfo(info.getSeq());

	manager.delete(info.getSeq());
%>
<SCRIPT LANGUAGE="JavaScript">
alert("削除しました");
location.href="<%=urlPage%>admin/info/infoList.jsp";
</SCRIPT>