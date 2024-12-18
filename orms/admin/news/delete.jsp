<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "mira.news.NewsBean" %>
<%@ page import = "mira.news.NewsManager" %>
<%
 String urlPage=request.getContextPath()+"/orms/";	
%>
<jsp:useBean id="news" class="mira.news.NewsBean">
	<jsp:setProperty name="news" property="*" />
</jsp:useBean>

<%
    NewsManager manager=NewsManager.getInstance();
	NewsBean oldBean = manager.select(news.getSeq());
	manager.delete(news.getSeq());
%>
<SCRIPT LANGUAGE="JavaScript">
alert("Delete OK");
location.href="<%=urlPage%>admin/news/newsForm.jsp";
</SCRIPT>