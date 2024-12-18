<%@ page contentType = "text/html; charset=utf-8" %> 
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.job.JobBean" %>
<%@ page import = "mira.job.JobMgr" %>
<%@ page import=  "mira.job.MgrException" %>

<jsp:useBean id="job" class="mira.job.JobBean">
    <jsp:setProperty name="job" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/orms/";
   job.setRegister(new Timestamp(System.currentTimeMillis()));     
   JobMgr manager = JobMgr.getInstance();    
   manager.insert(job);
%>

<script language="JavaScript">
alert("登録完了！！！！！ ");
location.href = "<%=urlPage%>admin/job/jobList.jsp";
</script>