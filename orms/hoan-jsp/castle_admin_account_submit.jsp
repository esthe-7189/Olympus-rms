<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 castle_admin_account_submit.jsp
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

<%@ include file = "castle_policy.jsp" %>
<%
		/* 예외 사항 체크 */
	boolean bHasAdminIDParam = false;
	boolean bHasAdminPasswordParam = false;
	boolean bHasAdminRepasswordParam = false;
	boolean bHasAdminOldPasswordParam = false;

	java.util.Enumeration eParam = (java.util.Enumeration) request.getParameterNames();

	while (eParam.hasMoreElements()) {

		String pName = (String)eParam.nextElement();

		if (pName.equals("admin_id")) 
			bHasAdminIDParam = true;
		else
		if (pName.equals("admin_old_password")) 
			bHasAdminOldPasswordParam = true;
		else
		if (pName.equals("admin_password")) 
			bHasAdminPasswordParam = true;
		else
		if (pName.equals("admin_repassword")) 
			bHasAdminRepasswordParam = true;
		else
		if (pName.equals("x")) ;
		else
		if (pName.equals("y")) ;
		else {
			out.println(castlejsp.CastleLib.msgBack("허용하지 않는 입력 파라미터 입니다."));
			return;
		}
	}

	if (!bHasAdminIDParam) {
		out.println(castlejsp.CastleLib.msgBack("관리자 아이디가 입력되지 않았습니다."));
		return;
	}

	if (!bHasAdminOldPasswordParam) {
		out.println(castlejsp.CastleLib.msgBack("관리자 이전암호가 입력되지 않았습니다."));
		return;
	}

	if (!bHasAdminPasswordParam) {
		out.println(castlejsp.CastleLib.msgBack("관리자 신규암호가 입력되지 않았습니다."));
		return;
	}

	if (!bHasAdminRepasswordParam) {
		out.println(castlejsp.CastleLib.msgBack("관리자 암호확인이 입력되지 않았습니다."));
		return;
	}

		/* 요청 변수 처리 */
	String strAdminID = request.getParameter("admin_id");
	strAdminID = strAdminID.trim();

	strAdminID = new String(strAdminID.getBytes("8859_1"), "UTF-8"); 

	String strAdminPassword = request.getParameter("admin_password");
	String strAdminRepassword = request.getParameter("admin_repassword");
	String strAdminOldPassword = request.getParameter("admin_old_password");

	strAdminPassword = strAdminPassword.trim();
	strAdminRepassword = strAdminRepassword.trim();
	strAdminOldPassword = strAdminOldPassword.trim();

		/* CASTLE 정책 정보: 이전 암호 가져오기 */
	String strPolicyAdminPassword = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminPassword));

		/* MD5 수행 */
	strAdminOldPassword = castlejsp.CastleLib.getDoubleMD5(strAdminOldPassword);

		/* 이전 암호 확인 *
	if (!strAdminOldPassword.equals(strPolicyAdminPassword)) {
		out.println(castlejsp.CastleLib.msgBack("이전 암호가 정확하지 않습니다."));
		return;
	}

		/* 관리자 암호 및 암호 확인 검사 */
	if (!strAdminPassword.equals(strAdminRepassword)) {
		out.println(castlejsp.CastleLib.msgBack("암호와 확인 암호가 같지 않습니다."));
		return;
	}

		/* 관리자 아이디 길이 체크 */
	if ((strAdminID.length() < 4) || (strAdminID.length() > 16)) {
		out.println(castlejsp.CastleLib.msgBack("관리자 아이디는 4자 이상 16자 이하여야 합니다."));
		return;
	}

		/* 관리자 암호 길이 체크 */
	if ((strAdminPassword.length() < 8) || (strAdminID.length() > 32)) {
		out.println(castlejsp.CastleLib.msgBack("관리자 암호는 8자 이상 32자 이하여야 합니다."));
		return;
	}

		/* 시간 정보 가져오기 */
	java.util.Date d = new java.util.Date(System.currentTimeMillis());
	String strTime = d.toString();

		/* 신규 암호 MD5 수행 */
	strAdminPassword = castlejsp.CastleLib.getDoubleMD5(strAdminPassword);

		/* CASTLE 정책 정보 수정: 관리자 계정 아이디 및 암호 설정 */
	castlePolicy.strAdminID = castlejsp.CastleLib.getBase64Encode(strAdminID);
	castlePolicy.strAdminPassword = castlejsp.CastleLib.getBase64Encode(strAdminPassword);
	castlePolicy.strAdminLastModified = castlejsp.CastleLib.getBase64Encode(strTime);

		// CASTLE 정책 쓰기
	try {

		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

		if (castlePolicy.write(strCastlePolicyFile)) {
			out.println(castlejsp.CastleLib.msgBack("계정 정보 수정에 실패하였습니다."));
			return;
		}

		out.println(castlejsp.CastleLib.msgMove("관리자 계정 정보가 수정되었습니다.\\n" + 
			"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
			"5초 뒤에 새로고침 하십시오.", "castle_admin_account.jsp"));

	} catch (Exception e) { 
		System.out.println(e);
	}

	/* 관리자 계정 재설정 끝 */
%>
