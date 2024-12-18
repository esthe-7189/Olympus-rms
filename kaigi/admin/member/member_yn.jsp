<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>
<%@ page import = "mira.kaigi.MemberManagerException" %>


<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("kaigi")){
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
	location.href = "<%=urlPage%>kaigi/admin/member/listForm.jsp";	
	</script>
<%}else{%>	
	<script>
	alert("もう一度お願いいたします!.");
	history.go(-1);
	</script>
<%}%>