<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page errorPage="/orms/error/error.jsp"%>	

<jsp:useBean id="member" class="mira.memberuser.Member" >
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/orms/";
String  mseq=request.getParameter("mseq");
String mailVal=request.getParameter("mailVal");
String mailBase=request.getParameter("email");
String mail_address=request.getParameter("mail_address");
	if(mailVal.equals("no")){
		mail_address=mailBase;
	}

String ip_info=(String)request.getRemoteAddr();
    
    MemberManager manager = MemberManager.getInstance();       
    
    if(mseq!=null ){    	
    	member.setMail_address(mail_address);    		
    	member.setIp_info(ip_info);
    	
    	manager.updateMember(member);
%>
	<script language=javascript>			
		alert("会員情報が修正されました。もう一度ログインをお願いいたします。");
		top.location.href="<%=urlPage%>member/logout.jsp";	
	</script>

<%}else{%>
	<script language="JavaScript">
	alert("会員情報修正失敗);
	document.history.go(-1);
	</script>

<%}%>