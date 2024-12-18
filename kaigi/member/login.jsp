<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>
<%@ page import="mira.util.CookieBox"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String urlPage=request.getContextPath()+"/";

String member_id=request.getParameter("member_id");
String password=request.getParameter("password");	

int member_yn=0;

MemberManager manager=MemberManager.getInstance();
Member member=manager.adminUse(member_id);
if(member!=null){  member_yn=member.getMember_yn();}

if(member_yn==1){%>
	<script language=javascript>
			alert("ログインは管理者からの許可が必要です");
			history.go(-1);
	</script>	
<%}else if(member_yn==2 || member_yn==0){
	int result=manager.checkAuth(member_id,password);

	if(result==1){
		session.setAttribute("ID",member_id);
		session.setAttribute("KIND","kaigi");
		session.setMaxInactiveInterval(60*60*5);	
		//5시간
	}
	request.setAttribute("LOGINRESULT",new Integer(result));
	
	
	String idSave=request.getParameter("idSave");
	if(idSave==null){idSave="no";}
	Cookie [] cookies=request.getCookies();
	Cookie cookie=null;

	//쿠키 조건에 따라 굽기	
	if(idSave.equals("save")){		
		response.addCookie(CookieBox.createCookie("idNameToku",member_id,"/",60*60*24*365));
	}	

%>
			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/kaigi/member/loginView.jsp" />	
	</jsp:forward>
<%}%>