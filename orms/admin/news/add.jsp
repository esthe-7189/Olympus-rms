<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.news.NewsBean" %>
<%@ page import = "mira.news.NewsManager" %>

<jsp:useBean id="news" class="mira.news.NewsBean">
    <jsp:setProperty name="news" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/orms/";
   news.setRegister(new Timestamp(System.currentTimeMillis()));     
   NewsManager manager = NewsManager.getInstance();    
   manager.insert(news);
%>

<script language="JavaScript">
alert("登録完了！！！！！ ");
location.href = "<%=urlPage%>admin/news/newsForm.jsp";
</script>