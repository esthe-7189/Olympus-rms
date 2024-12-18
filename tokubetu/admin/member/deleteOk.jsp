<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page import = "mira.tokubetu.MemberManagerException" %>
<%@ page errorPage="/orms/error/error_common.jsp"%>
	
<jsp:useBean id="member" class="mira.tokubetu.Member">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("toku")){
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
	location.href = "<%=urlPage%>tokubetu/admin/member/listForm.jsp";
	</script>
