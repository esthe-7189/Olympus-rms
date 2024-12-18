<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("home")){
%>			
	<jsp:forward page="/orms/template/tempAdmin.jsp">
		<jsp:param name="CSSPAGE1"  value="/orms/home/home.jsp" />
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
	alert("Level Change OK!!");
	location.href = "<%=urlPage%>orms/admin/member/listForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!. ");
	history.go(-1);
	</script>
<%}%>