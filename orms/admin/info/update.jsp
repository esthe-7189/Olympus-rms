<%@ page contentType = "text/html; charset=utf-8" %> 
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.info.InfoBean" %>
<%@ page import = "mira.info.InfoMgr" %>

<jsp:useBean id="info" class="mira.info.InfoBean">
    <jsp:setProperty name="info" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/orms/";
 InfoMgr manager=InfoMgr.getInstance();
 InfoBean oldBean=manager.getInfo(info.getSeq());
  
   manager.update(info);
%>

<script language="JavaScript">
alert("修正完了！！！！！ ");
location.href = "<%=urlPage%>admin/info/infoList.jsp";
</script>

