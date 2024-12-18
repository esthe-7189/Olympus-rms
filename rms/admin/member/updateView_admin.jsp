<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.member.MemberManagerException" %>
<%@ page import = "java.sql.Timestamp" %>


<jsp:useBean id="member" class="mira.member.Member" >
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/";
String ip_info=(String)request.getRemoteAddr();
String nm=member.getNm();	    
    
    MemberManager manager = MemberManager.getInstance();            
    
    	member.setRegister(new Timestamp(System.currentTimeMillis()) );
    	member.setIp_info(ip_info);
    	member.setLevel(2);
    	manager.updateMember(member);
%>
	<script language=javascript>			
		alert("会員情報が修正されました。");
		top.location.href="<%=urlPage%>rms/admin/member/listForm.jsp";	
	</script>
