<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.hitokoto.NewsBean" %>
<%@ page import = "mira.hitokoto.NewsManager" %>

<jsp:useBean id="notice" class="mira.hitokoto.NewsBean">
    <jsp:setProperty name="notice" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/";

   notice.setRegister(new Timestamp(System.currentTimeMillis()));     
   NewsManager manager = NewsManager.getInstance();    
   if(notice.getContent()==null){
   	   notice.setContent("No Data");
    }
   manager.insert(notice);  
%>
<script language="JavaScript">
alert("登録しました。");
location.href = "<%=urlPage%>tokubetu/admin/admin_main.jsp";
</script>
