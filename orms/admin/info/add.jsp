<%@ page contentType = "text/html; charset=utf-8" %> 
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.info.InfoBean" %>
<%@ page import = "mira.info.InfoMgr" %>
<%@ page import=  "mira.info.MgrException" %>

<jsp:useBean id="info" class="mira.info.InfoBean">
    <jsp:setProperty name="info" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/orms/";
   info.setRegister(new Timestamp(System.currentTimeMillis()));     
   InfoMgr manager = InfoMgr.getInstance();    
   manager.insert(info);
%>

<script language="JavaScript">
alert("登録完了！！！！！ ");
location.href = "<%=urlPage%>admin/info/infoList.jsp";
</script>