<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
<%@ page import = "mira.memberacc.MemberManagerException" %>
<%@ page errorPage="/orms/error/error_common.jsp"%>
	
<jsp:useBean id="member" class="mira.memberacc.Member">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("acc")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}	
String urlPage=request.getContextPath()+"/";	

    MemberManager manager = MemberManager.getInstance();
    Member oldBean = manager.getMember(member.getMember_id());
    manager.deleteMember(member.getMseq());
     
%>

	<script language="JavaScript">
	alert("会員情報を削除しました。");
	location.href = "<%=urlPage%>accounting/admin/member/listForm.jsp";
	</script>
