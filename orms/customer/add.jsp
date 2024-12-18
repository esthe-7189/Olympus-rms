<%@ page contentType = "text/html; charset=utf-8" %> 
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.customer.DataBean" %>
<%@ page import = "mira.customer.DataMgr" %>


<jsp:useBean id="info" class="mira.customer.DataBean">
    <jsp:setProperty name="info" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/orms/";
   info.setRegister(new Timestamp(System.currentTimeMillis()));     
   DataMgr manager = DataMgr.getInstance();    
   manager.insertDb(info);
%>

<script language="JavaScript">
alert("登録完了！！！！！ ");
location.href = "<%=urlPage%>customer/customerForm.jsp";
</script>