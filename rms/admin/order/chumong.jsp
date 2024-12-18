<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ page import = "java.sql.Timestamp" %>


<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String seq = request.getParameter("seq");
String sign = request.getParameter("sign");
String kubun = request.getParameter("kubun");


	MgrOrderBunsho mgr = MgrOrderBunsho.getInstance();		
	mgr.changeChumong(Integer.parseInt(seq),Integer.parseInt(sign),Integer.parseInt(kubun));	
%>

<script language="JavaScript">
alert("処理しました。");
location.href = "<%=urlPage%>rms/admin/order/listForm.jsp";
</script>	
	
