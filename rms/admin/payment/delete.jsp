<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
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
String cseq=request.getParameter("cseq");
String pay_item=request.getParameter("pay_item");
	CateMgr mgr=CateMgr.getInstance();	
	mgr.delete(Integer.parseInt(cseq));	
	mgr.delete_client(Integer.parseInt(cseq));
%>

	<script language="JavaScript">
		alert("削除しました");
	  	location.href = "<%=urlPage%>rms/admin/payment/addForm.jsp?pay_item=<%=pay_item%>";		
	</script>
	