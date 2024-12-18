<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "mira.hitokoto.NewsBean" %>
<%@ page import = "mira.hitokoto.NewsManager" %>

<jsp:useBean id="news" class="mira.hitokoto.NewsBean">
    <jsp:setProperty name="news" property="*" />
</jsp:useBean>
<%
	String urlPage=request.getContextPath()+"/";	

	String seq=request.getParameter("seq");	
	
	NewsManager manager = NewsManager.getInstance();
	NewsBean oldBean= manager.select(news.getSeq());	
	

if (seq != null){	
       manager.update(news);  
%>


<script language="JavaScript">
alert("処理しました。");
location.href = "<%=urlPage%>rms/admin/hitokoto/listForm.jsp";
</script>

<%
    } else {
%>
<script>
alert("System error ");
history.go(-1);
</script>
<%
    }
%>
