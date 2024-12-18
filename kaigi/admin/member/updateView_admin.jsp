<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>
<%@ page import = "mira.kaigi.MemberManagerException" %>
<%@ page import = "java.sql.Timestamp" %>


<jsp:useBean id="member" class="mira.kaigi.Member" >
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
		top.location.href="<%=urlPage%>kaigi/admin/member/listForm.jsp";	
	</script>
