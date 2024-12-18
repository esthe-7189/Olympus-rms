<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>

<%@ page import = "mira.memberuser.MemberManager" %>

<%@ page import="mira.util.CookieBox"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

String cooki_mail=request.getParameter("cooki_mail");
String member_id=request.getParameter("mail_address");
String password=request.getParameter("password");	


MemberManager manager=MemberManager.getInstance();
	int result=manager.checkAuth(member_id,password);

	if(result==1){
		session.setAttribute("ID",member_id);
		session.setAttribute("KIND","home");
		session.setMaxInactiveInterval(60*40);	
		//40분
	}
	request.setAttribute("LOGINRESULT",new Integer(result));
	
	
	String idSave=request.getParameter("idSave");
	if(idSave==null){idSave="no";}	

	//쿠키 조건에 따라 굽기	
	if(idSave.equals("save")){		
		response.addCookie(CookieBox.createCookie("idNameHome",cooki_mail,"/",60*60*24*365));
	}	

%>

<jsp:forward page="/orms/template/tempSub.jsp">    
	<jsp:param name="CSSPAGE1" value="/orms/member/loginView.jsp" />		
</jsp:forward>