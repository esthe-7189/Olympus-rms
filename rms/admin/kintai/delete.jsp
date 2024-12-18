<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
<%@ page import = "java.sql.Timestamp" %>


<jsp:useBean id="kintai" class="mira.kintai.DataBeanKintai">
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

	DataMgrKintai mgr = DataMgrKintai.getInstance();	
	mgr.deleteKintai(Integer.parseInt(seq));
	
 	// mgr.deleteDb(Integer.parseInt(seq));   //일정표 연동시 사용
%>
<script language="JavaScript">
alert("データが削除されました");
location.href = "<%=urlPage%>rms/admin/kintai/listForm.jsp";
</script>
