<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
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
String seq = request.getParameter("fno");


	DataMgrHoliHokoku mgr = DataMgrHoliHokoku.getInstance();	
	mgr.deleteBogo(Integer.parseInt(seq));	

 	
%>
<script language="JavaScript">
alert("データが削除されました");
location.href = "<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp";
</script>
