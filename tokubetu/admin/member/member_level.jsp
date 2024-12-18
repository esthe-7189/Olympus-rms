<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}	String urlPage=request.getContextPath()+"/";
	String mseq=request.getParameter("mseq2");	
	String mem_level=request.getParameter("okYn");	
	
if (mseq != null){	
	MemberManager manager = MemberManager.getInstance();	
       manager.levelChange(Integer.parseInt(mseq),Integer.parseInt(mem_level));  
%>

	<script language="JavaScript">
	alert("承認OK!!");
	location.href = "<%=urlPage%>tokubetu/admin/member/listForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!. ");
	history.go(-1);
	</script>
<%}%>