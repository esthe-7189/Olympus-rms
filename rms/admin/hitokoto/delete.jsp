<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "mira.hitokoto.NewsBean " %>
<%@ page import = "mira.hitokoto.NewsManager" %>
<%
 String urlPage=request.getContextPath()+"/";	
%>
<jsp:useBean id="news" class="mira.hitokoto.NewsBean">
	<jsp:setProperty name="news" property="*" />
</jsp:useBean>

<%
    NewsManager manager=NewsManager.getInstance();
	NewsBean oldBean = manager.select(news.getSeq());
	manager.delete(news.getSeq());
%>
<SCRIPT LANGUAGE="JavaScript">
alert("削除しました。");
location.href="<%=urlPage%>rms/admin/hitokoto/listForm.jsp";
</SCRIPT>