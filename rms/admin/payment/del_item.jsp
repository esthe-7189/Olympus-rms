<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.FileMgr" %>
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
String seq=request.getParameter("seq");
String docontact=request.getParameter("docontact");
String btn=request.getParameter("btn");
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");
String pageNum=request.getParameter("page");

	FileMgr mgr=FileMgr.getInstance();	
	mgr.delete(Integer.parseInt(seq));
%>

	<script language="JavaScript">
		alert("削除しました");
	  	location.href = "<%=urlPage%>rms/admin/payment/listForm.jsp?docontact=<%=docontact%>&btn=<%=btn%>&yyVal=<%=yyVal%>&mmVal=<%=mmVal%>&page=<%=pageNum%>";		  	
	</script>