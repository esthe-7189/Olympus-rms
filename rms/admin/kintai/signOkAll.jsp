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
	 DataMgrKintai manager = DataMgrKintai.getInstance();
	
	
	if(request.getParameterValues("chkBoxName01[]") !=null){			
	String[] chkBoxName01=request.getParameterValues("chkBoxName01[]"); 

	if(chkBoxName01.length==1){
		  manager.signOk(Integer.parseInt(chkBoxName01[0]),2,".");  
	}else{
		for(int i=0; i< chkBoxName01.length; i++){
		   manager.signOk(Integer.parseInt(chkBoxName01[i]),2,".");  
		}
	}
}

%>
	<script language="JavaScript">
	alert("処理しました!!");
	location.href = "<%=urlPage%>rms/admin/sign/listForm.jsp";	
	</script>

