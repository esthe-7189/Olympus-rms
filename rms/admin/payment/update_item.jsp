<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="pds" class="mira.payment.Category" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>

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
String docontact=request.getParameter("docontact");
String btn=request.getParameter("btn");
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");
String pageNum=request.getParameter("page");
if(pageNum==null){pageNum="1";}

	FileMgr mgr=FileMgr.getInstance();	
	mgr.update(pds);
%>

	<script language="JavaScript">
		alert("修正しました");
	  	opener.location.href = "<%=urlPage%>rms/admin/payment/listForm.jsp?docontact=<%=docontact%>&btn=<%=btn%>&yyVal=<%=yyVal%>&mmVal=<%=mmVal%>&page=<%=pageNum%>";	
	  	self.close();		
	</script>





