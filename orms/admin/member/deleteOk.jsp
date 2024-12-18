<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ page errorPage="/orms/error/error_common.jsp"%>
	
<jsp:useBean id="member" class="mira.memberuser.Member">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("home")){
%>			
	<jsp:forward page="/orms/template/tempMain.jsp">		    
		<jsp:param name="CSSPAGE1" value="/orms/home/home.jsp" />	
	</jsp:forward>
<%
	}	
String urlPage=request.getContextPath()+"/";	

    MemberManager manager = MemberManager.getInstance();
    Member oldBean = manager.getMember(member.getMail_address());
    manager.deleteMember(member.getMseq());
     
%>

	<script language="JavaScript">
	alert("会員情報を削除しました。");
	location.href = "<%=urlPage%>orms/admin/member/listForm.jsp";
	</script>
