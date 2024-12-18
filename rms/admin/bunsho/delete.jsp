<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.bunsho.BunshoBean" %>
<%@ page import="mira.bunsho.BunshoMgr" %>
<%@ page import="mira.bunsho.MgrException" %>
<%@ page import = "java.sql.Timestamp" %>

<jsp:useBean id="pds" class="mira.bunsho.BunshoBean">
    <jsp:setProperty name="pds" property="*" />
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
String fno = request.getParameter("fno");	

   BunshoMgr mgr = BunshoMgr.getInstance();   
     mgr.deleteLevel1(Integer.parseInt(fno));
%>
<script language="JavaScript">
alert("ファイルが削除されました");
location.href = "<%=urlPage%>rms/admin/bunsho/listForm.jsp";
</script>
