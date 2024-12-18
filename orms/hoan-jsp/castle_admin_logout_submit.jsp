<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 castle_admin_logout_submit.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jan 05 2009
 *
 */
%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page session = "true" %>

<% pageContext.include("castle_check_install.jsp"); %>
<% pageContext.include("castle_check_auth.jsp"); %>

<%
		/* 인증 세션 해지 */

	String strAuthKey = new String();
	strAuthKey = "castleSessionAuthToken" + (String)session.getAttribute("castleSessionAuthAdminID");

	session.removeAttribute("castleSessionAuthAdminID");
	session.removeAttribute(strAuthKey);

	out.println(castlejsp.CastleLib.msgMove("관리자 로그아웃 되었습니다.", "castle_admin_login.jsp"));

	/* 관리자 로그아웃 끝 */
%>
