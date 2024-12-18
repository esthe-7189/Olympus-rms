<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="order" class="mira.order.BeanOrderBunsho">
    <jsp:setProperty name="order" property="*" />
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
MgrOrderBunsho manager = MgrOrderBunsho.getInstance();

	String seq=request.getParameter("seq");
	String sign_ok=request.getParameter("sign_ok");	
	String position=request.getParameter("position");
	String noRiyu=request.getParameter("noRiyumo");	
    manager.changeSign(Integer.parseInt(sign_ok),Integer.parseInt(seq),Integer.parseInt(position),noRiyu);                  
							
%>
	<script language="JavaScript">
	alert("決裁しました!!");
	parent.location.href = "<%=urlPage%>rms/admin/sign/listForm.jsp";	
	</script>


	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
