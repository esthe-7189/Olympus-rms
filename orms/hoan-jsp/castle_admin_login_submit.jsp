<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 castle_admin_login_submit.jsp
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
<%
		/* 예외 사항 체크 */
	boolean bHasLoginIDParam = false;
	boolean bHasLoginPasswordParam = false;

	java.util.Enumeration eParam = (java.util.Enumeration) request.getParameterNames();

	while (eParam.hasMoreElements()) {
		String pName = (String)eParam.nextElement();
		if (pName.equals("admin_id")) 
			bHasLoginIDParam = true;
		else
		if (pName.equals("admin_password")) 
			bHasLoginPasswordParam = true;
		else {
			out.println(castlejsp.CastleLib.msgBack("허용하지 않는 입력 파라미터 입니다."));
			return;
		}
	}

	if (!bHasLoginIDParam) {
		out.println(castlejsp.CastleLib.msgBack("로그인 아이디가 입력되지 않았습니다."));
		return;
	}

	if (!bHasLoginPasswordParam) {
		out.println(castlejsp.CastleLib.msgBack("로그인 암호가 입력되지 않았습니다."));
		return;
	}

		/* 요청 변수 처리 */
	String strLoginAdminID = request.getParameter("admin_id");
	strLoginAdminID = new String(strLoginAdminID.getBytes("8859_1"), "UTF-8"); 
	strLoginAdminID = strLoginAdminID.trim();

	String strLoginAdminPassword = request.getParameter("admin_password");
	strLoginAdminPassword = strLoginAdminPassword.trim();

		/* 관리자 아이디 길이 체크 */
	if ((strLoginAdminID.length() < 4) || (strLoginAdminID.length() > 16)) {
		out.println(castlejsp.CastleLib.msgBack("관리자 아이디는 4자 이상 16자 이하여야 합니다."));
		return;
	}

		/* 관리자 암호 길이 체크 */
	if ((strLoginAdminPassword.length() < 8) || (strLoginAdminPassword.length() > 32)) {
		out.println(castlejsp.CastleLib.msgBack("관리자 암호는 8자 이상 32자 이하여야 합니다."));
		return;
	}
%>
<%@ include file = "castle_policy.jsp" %>
<%
	/* CASTLE 정책 정보: 관리자 계정 아이디 및 암호 가져오기 */
	String strPolicyAdminID = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminID));
	String strPolicyAdminPassword = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminPassword));

		/* MD5 수행 */
	strLoginAdminPassword = castlejsp.CastleLib.getDoubleMD5(strLoginAdminPassword);

		/* 아이디 & 암호 검사 */
	if (!strLoginAdminID.equals(strPolicyAdminID)) {
		out.println(castlejsp.CastleLib.msgBack("잘못된 인증 정보입니다."));
		return;
	}

	if (!strLoginAdminPassword.equals(strPolicyAdminPassword)) {
		out.println(castlejsp.CastleLib.msgBack("잘못된 인증 정보입니다."));
		return;
	}

		/* 인증 세션 생성 */
	String strAuthKey = new String();
	strAuthKey = "castleSessionAuthToken" + strLoginAdminID;
	String strAuthValue = (String)request.getRemoteAddr();

	session.setAttribute("castleSessionAuthAdminID", strLoginAdminID);
	session.setAttribute(strAuthKey, strAuthValue);

	out.println(castlejsp.CastleLib.msgMove("관리자 인증 되었습니다.", "castle_admin.jsp"));

	/* 관리자 인증 끝 */
%>
