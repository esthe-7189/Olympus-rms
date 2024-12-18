<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.hitokoto.NewsBean" %>
<%@ page import = "mira.hitokoto.NewsManager" %>

<jsp:useBean id="notice" class="mira.hitokoto.NewsBean">
    <jsp:setProperty name="notice" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/";
String gopage=request.getParameter("gopage");
if(gopage==null){gopage="hitokoto";}


   notice.setRegister(new Timestamp(System.currentTimeMillis()));     
   NewsManager manager = NewsManager.getInstance();    
   if(notice.getContent()==null){
   	   notice.setContent("No Data");
    }
   manager.insert(notice);
  
  if(gopage.equals("hitokoto")){
%>

<script language="JavaScript">
alert("登録しました。");
location.href = "<%=urlPage%>rms/admin/hitokoto/listForm.jsp";
</script>

<%}else if(gopage.equals("main")){%>

<script language="JavaScript">
alert("登録しました。");
location.href = "<%=urlPage%>rms/admin/admin_main.jsp";
</script>

<%}%>