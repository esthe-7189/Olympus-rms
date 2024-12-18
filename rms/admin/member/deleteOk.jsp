<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.member.MemberManagerException" %>
<%@ page errorPage="/pose/error/error_view.jsp"%>
	
<jsp:useBean id="member" class="mira.member.Member">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<%	
String urlPage=request.getContextPath()+"/";	

    MemberManager manager = MemberManager.getInstance();
    Member oldBean = manager.getMember(member.getMember_id());
    manager.deleteMember(member.getMseq());
     
%>

	<script language="JavaScript">
	alert("会員情報を削除しました。");
	location.href = "<%=urlPage%>rms/admin/member/listForm.jsp";
	</script>
