<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
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
String pay_item=request.getParameter("pay_item");
if(pay_item==null){pay_item="1";}
	CateMgr mgr=CateMgr.getInstance();	
	mgr.insertBoard(pds);
%>

	<script language="JavaScript">
		alert("登録しました");
	  	location.href = "<%=urlPage%>rms/admin/payment/addForm.jsp?pay_item=<%=pay_item%>";			
	</script>