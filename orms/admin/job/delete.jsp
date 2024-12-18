<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "mira.job.JobBean" %>
<%@ page import = "mira.job.JobMgr" %>

<%
 String urlPage=request.getContextPath()+"/orms/";	
%>
<jsp:useBean id="info" class="mira.job.JobBean">
    <jsp:setProperty name="info" property="*" />
</jsp:useBean>

<%
	JobMgr manager=JobMgr.getInstance();
 	JobBean oldBean=manager.getInfo(info.getSeq());

	manager.delete(info.getSeq());
%>
<SCRIPT LANGUAGE="JavaScript">
alert("削除しました");
location.href="<%=urlPage%>admin/job/jobList.jsp";
</SCRIPT>