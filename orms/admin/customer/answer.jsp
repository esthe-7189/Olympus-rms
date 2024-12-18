<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.customer.DataBean" %>
<%@ page import = "mira.customer.DataMgr" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("home")){
%>			
	<jsp:forward page="/orms/template/tempAdmin.jsp">    
		<jsp:param name="CSSPAGE1" value="/orms/home/home.jsp" />		
	</jsp:forward>
	
<%
	}	
	String urlPage=request.getContextPath()+"/";
	String seq=request.getParameter("seq");	
	String mem_level=request.getParameter("okYn");	
	
if (seq != null){	
	DataMgr manager = DataMgr.getInstance();	
       manager.changeAnswer(Integer.parseInt(mem_level),Integer.parseInt(seq));  
%>

	<script language="JavaScript">
	alert("お返事OK!!");
	location.href = "<%=urlPage%>orms/admin/customer/customerForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!. ");
	history.go(-1);
	</script>
<%}%>