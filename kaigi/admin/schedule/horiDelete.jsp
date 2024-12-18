<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "java.sql.Timestamp" %>


<jsp:useBean id="kintai" class="mira.schedule.DataBean">
    <jsp:setProperty name="kintai" property="*" />
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
String seq = request.getParameter("seq");

	DataMgr mgr = DataMgr.getInstance();	
	mgr.deleteHori(Integer.parseInt(seq));
	
%>
<script language="JavaScript">
alert("データが削除されました");
location.href = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";
</script>
