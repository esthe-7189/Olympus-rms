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
<%
		/* 설치 여부 판단 */
	try {

		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

		java.io.File filePolicy = new java.io.File(strCastlePolicyFile);
		if (!filePolicy.isFile()) {
			out.println(castlejsp.CastleLib.msgMove("CASTLE이 설치되어 있지 않습니다.", "install.jsp"));
			return;
		}

	} catch (Exception e) { 
		System.out.println(e);
	}

%>
