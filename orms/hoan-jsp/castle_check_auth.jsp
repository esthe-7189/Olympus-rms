<%@ page pageEncoding = "UTF-8" %>
<%

//@UTF-8 castle_check_auth.jsp
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
<%
		/* 인증 여부 판단 */

	String strSessionAuthAdminID = (String)session.getAttribute("castleSessionAuthAdminID");
	String strAuthKey = new String();

	strAuthKey = "castleSessionAuthToken" + strSessionAuthAdminID;
		
	String strSessionAuth = (String)session.getAttribute(strAuthKey);
	if (strSessionAuth == null)
		out.println(castlejsp.CastleLib.msgMove("관리자 페이지 접근이 인증 되지 않습니다.", "castle_admin_login.jsp"));
	else {
		String strSessionRemoteAddr = (String)request.getRemoteAddr();
		if (!strSessionAuth.equals(strSessionRemoteAddr))
			out.println(castlejsp.CastleLib.msgMove("관리자 페이지 접근이 인증 되지 않습니다.", "castle_admin_login.jsp"));
	}

%>
