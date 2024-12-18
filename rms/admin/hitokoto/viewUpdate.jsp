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
	String view_yn=request.getParameter("view_yn");
	
	NewsManager manager = NewsManager.getInstance();
	NewsBean oldBean= manager.select(news.getSeq());	
	

if (seq != null){	
       manager.viewYn(Integer.parseInt(seq),Integer.parseInt(view_yn));  
%>


<script language="JavaScript">
alert("変更しました。");
window.parent.location.href = "<%=urlPage%>rms/admin/hitokoto/listForm.jsp";

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
