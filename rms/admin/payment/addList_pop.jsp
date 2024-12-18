<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
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
String btn="";
String urlPage=request.getContextPath()+"/";
String docontact=request.getParameter("docontact");
String search_cond=request.getParameter("search_cond"); //毎月支払/随時支払
if(search_cond.equals("1")){btn="A";docontact="1";}
if(search_cond.equals("2")){btn="B";docontact="2";}

String ymd=pds.getSinsei_day();
String yyVal=ymd.substring(0,4);
String mmVal=ymd.substring(5,7);
//String pagenm=request.getParameter("pagenm"); 
String submit_yn=request.getParameter("submit_yn");


	FileMgr mgr=FileMgr.getInstance();	
	pds.setRegister(new Timestamp(System.currentTimeMillis()));
	mgr.insertFile(pds);
%>

	<script language="JavaScript">
		alert("登録しました");
	  	opener.location.href="<%=urlPage%>rms/admin/payment/listForm.jsp?docontact=<%=docontact%>&btn=<%=btn%>&yyVal=<%=yyVal%>&mmVal=<%=mmVal%>&page=1&submit_yn=<%=submit_yn%>";				
		self.close();
	</script>