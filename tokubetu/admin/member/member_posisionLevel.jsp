<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
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
	alert("職責レベルを変更しました");
	location.href = "<%=urlPage%>tokubetu/admin/member/listForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!. ");
	history.go(-1);
	</script>
<%}%>