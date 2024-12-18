<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
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
    int seqdb=0; int seqSche=0;

	String seq=request.getParameter("seq");
	String sign_ok=request.getParameter("sign_ok");	
	String noRiyu=request.getParameter("noRiyumo");	
	

    DataMgrKintai manager = DataMgrKintai.getInstance();	
    manager.signOk(Integer.parseInt(seq),Integer.parseInt(sign_ok),noRiyu);  
    
%>
	<script language="JavaScript">
	alert("処理しました!!");
	parent.location.href = "<%=urlPage%>rms/admin/sign/listForm.jsp";	
	</script>

