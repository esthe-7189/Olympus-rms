<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page errorPage="/rms/error/error_common.jsp"%>

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
	String mseq=request.getParameter("mseq2");	
	String member_yn=request.getParameter("okYn");	
	
if (mseq != null){	
	MemberManager manager = MemberManager.getInstance();	
       manager.memberYn(Integer.parseInt(mseq),Integer.parseInt(member_yn));  
%>

	<script language="JavaScript">
	alert("承認OK!!");
	location.href = "<%=urlPage%>tokubetu/admin/member/listForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!.");
	history.go(-1);
	</script>
<%}%>