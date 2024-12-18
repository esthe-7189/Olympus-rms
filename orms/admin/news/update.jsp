<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "mira.news.NewsBean" %>
<%@ page import = "mira.news.NewsManager" %>

<jsp:useBean id="news" class="mira.news.NewsBean">
    <jsp:setProperty name="news" property="*" />
</jsp:useBean>
<%
	String urlPage=request.getContextPath()+"/orms/";	

	String seq=request.getParameter("seq");	
	
	NewsManager manager = NewsManager.getInstance();
	NewsBean oldBean= manager.select(news.getSeq());	
	

if (seq != null){	
       manager.update(news);  
%>


<script language="JavaScript">
alert("Update OK");
location.href = "<%=urlPage%>admin/news/newsForm.jsp";
</script>

<%
    } else {
%>
<script>
alert("もう一度処理してください ");
history.go(-1);
</script>
<%
    }
%>
