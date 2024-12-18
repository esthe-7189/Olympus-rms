<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.member.MemberManagerException" %>
<%@ page errorPage="/rms/error/error.jsp"%>

<%
	String urlPage=request.getContextPath()+"/";
	String mseq=request.getParameter("mseq2");	
	String mem_level=request.getParameter("okYn");	
	
if (mseq != null){	
	MemberManager manager = MemberManager.getInstance();	
       manager.levelPosiChange(Integer.parseInt(mseq),Integer.parseInt(mem_level));  
%>

	<script language="JavaScript">
	alert("Level変更...OK!!");
	location.href = "<%=urlPage%>rms/admin/member/listForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!. ");
	history.go(-1);
	</script>
<%}%>