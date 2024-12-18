<%@ page contentType = "text/html; charset=utf-8" %> 
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.job.JobBean" %>
<%@ page import = "mira.job.JobMgr" %>

<jsp:useBean id="info" class="mira.job.JobBean">
    <jsp:setProperty name="info" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/orms/";
 JobMgr manager=JobMgr.getInstance();
 JobBean oldBean=manager.getInfo(info.getSeq());
  
   manager.update(info);
%>

<script language="JavaScript">
alert("修正完了！！！！！ ");
location.href = "<%=urlPage%>admin/job/jobList.jsp";
</script>

