<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page errorPage="/rms/error/error-common.jsp"%>
	
<jsp:useBean id="member" class="mira.memberacc.Member" >
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/";
String ip_info=(String)request.getRemoteAddr();
String nm=member.getNm();	    
    
    MemberManager manager = MemberManager.getInstance();            
    
    	member.setRegister(new Timestamp(System.currentTimeMillis()) );
    	member.setIp_info(ip_info);    	
    	manager.updateMember(member);
%>
	<script language=javascript>			
		alert("会員情報が修正されました。もう一度ログインをお願いいたします。");
		top.location.href="<%=urlPage%>accounting/member/logout.jsp";	
	</script>
