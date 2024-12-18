<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.hinsithu.HinsithuBean" %>
<%@ page import="mira.hinsithu.HinsithuMgr" %>
<%@ page import = "java.sql.Timestamp" %>

<jsp:useBean id="pds" class="mira.seizo.SeizoBean">
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

   HinsithuMgr mgr = HinsithuMgr.getInstance();   
     mgr.deleteLevel1(Integer.parseInt(fno));
%>
<script language="JavaScript">
alert("ファイルが削除されました");
location.href = "<%=urlPage%>rms/admin/hinsithu/listForm.jsp";
</script>
