<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 castle_admin_config_submit.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jan 09 2009
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
	boolean bHasModeParam = false;
	boolean bHasAdminModuleNameParam = false;
	boolean bHasConfigModeParam = false;
	boolean bHasConfigAlertParam = false;
	boolean bHasConfigSiteBoolParam = false;
	boolean bHasTargetParamParam = false;
	boolean bHasTargetCookieParam = false;

	java.util.Enumeration eParam = (java.util.Enumeration) request.getParameterNames();

	while (eParam.hasMoreElements()) {

		String pName = (String)eParam.nextElement();

		if (pName.equals("mode")) 
			bHasModeParam = true;
		else
		if (pName.equals("admin_module_name")) 
			bHasAdminModuleNameParam = true;
		else
		if (pName.equals("config_mode")) 
			bHasConfigModeParam = true;
		else
		if (pName.equals("config_alert")) 
			bHasConfigAlertParam = true;
		else
		if (pName.equals("config_site_bool")) 
			bHasConfigSiteBoolParam = true;
		else
		if (pName.equals("target_param")) 
			bHasTargetParamParam = true;
		else
		if (pName.equals("target_cookie")) 
			bHasTargetCookieParam = true;
		else
		if (pName.equals("x")) ;
		else
		if (pName.equals("y")) ;
		else {
			out.println(castlejsp.CastleLib.msgBack("허용하지 않는 입력 파라미터 입니다."));
			return;
		}
	}

		/* 시간 정보 가져오기 */
	java.util.Date d = new java.util.Date(System.currentTimeMillis());
	String strTime = d.toString();

		/* CASTLE 정책 정보 수정: 최종 수정 시간 설정 */
	castlePolicy.strAdminLastModified = castlejsp.CastleLib.getBase64Encode(strTime);

		/* 요청 변수 처리 */
	String strMode = request.getParameter("mode");

		/* 기본 설정 */
	if (strMode.equals("CONFIG_BASIC")) {

		if (!bHasAdminModuleNameParam) {
			out.println(castlejsp.CastleLib.msgBack("CASTLE 이름이 입력되지 않았습니다."));
			return;
		}

		if (!bHasConfigModeParam) {
			out.println(castlejsp.CastleLib.msgBack("집행모드가 입력되지 않았습니다."));
			return;
		}

		if (!bHasConfigAlertParam) {
			out.println(castlejsp.CastleLib.msgBack("알림방식이 입력되지 않았습니다."));
			return;
		}

		String strAdminModuleName = request.getParameter("admin_module_name");
		strAdminModuleName = strAdminModuleName.trim();

		strAdminModuleName = new String(strAdminModuleName.getBytes("8859_1"), "UTF-8"); 

		String strConfigMode = request.getParameter("config_mode");
		String strConfigAlert = request.getParameter("config_alert");

		strConfigMode = strConfigMode.trim();
		strConfigAlert = strConfigAlert.trim();

			/*  이름 길이 체크 */
		if ((strAdminModuleName.length() < 4) || (strAdminModuleName.length() > 64)) {
			out.println(castlejsp.CastleLib.msgBack("CASTLE 이름은 4자 이상 16자 이하여야 합니다."));
			return;
		}

		castlePolicy.strAdminModuleName = castlejsp.CastleLib.getBase64Encode(strAdminModuleName);

			/* CASTLE 정책 정보 수정: 기본 설정 */
		if (strConfigMode.equals("enforcing")) 
			castlePolicy.strMode = castlejsp.CastleLib.getBase64Encode("ENFORCING");
		else
		if (strConfigMode.equals("permissive")) 
			castlePolicy.strMode = castlejsp.CastleLib.getBase64Encode("PERMISSIVE");
		else
		if (strConfigMode.equals("disabled")) 
			castlePolicy.strMode = castlejsp.CastleLib.getBase64Encode("DISABLED");
		else
			castlePolicy.strMode = castlejsp.CastleLib.getBase64Encode("PERMISSIVE");

		if (strConfigAlert.equals("alert")) 
			castlePolicy.strAlert = castlejsp.CastleLib.getBase64Encode("ALERT");
		else
		if (strConfigAlert.equals("message")) 
			castlePolicy.strAlert = castlejsp.CastleLib.getBase64Encode("MESSAGE");
		else
		if (strConfigAlert.equals("stealth")) 
			castlePolicy.strAlert = castlejsp.CastleLib.getBase64Encode("STEALTH");
		else
			castlePolicy.strAlert = castlejsp.CastleLib.getBase64Encode("MESSAGE");

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 기본설정 정보가 수정되었습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 기본설정 정보가 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_config.jsp#basic"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}

		/* 사이트 설정 */
	if (strMode.equals("CONFIG_SITE")) {

		if (!bHasConfigSiteBoolParam) {
			out.println(castlejsp.CastleLib.msgBack("사이트 잠금여부가 입력되지 않았습니다."));
			return;
		}

		String strConfigSiteBool = request.getParameter("config_site_bool");

		strConfigSiteBool = strConfigSiteBool.trim();

			/* CASTLE 정책 정보 수정: 사이트 설정 */
		if (strConfigSiteBool.equals("true")) 
			castlePolicy.strSiteBool = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strSiteBool = castlejsp.CastleLib.getBase64Encode("FALSE");

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 SITE 정책 수정에 실패하였습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 SITE 정책이 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_config.jsp#site"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}

		/* 대상 설정 */
	if (strMode.equals("CONFIG_TARGET")) {

		if (!bHasTargetParamParam) 
			out.println(castlejsp.CastleLib.msgBack("Get/Post 변수 적용 여부가 입력되지 않았습니다."));

		if (!bHasTargetCookieParam) 
			out.println(castlejsp.CastleLib.msgBack("Cookie 변수 적용 여부가 입력되지 않았습니다."));

		String strTargetParam = request.getParameter("target_param");
		String strTargetCookie = request.getParameter("target_cookie");
	
		strTargetParam = strTargetParam.trim();
		strTargetCookie = strTargetCookie.trim();

			/* CASTLE 정책 정보 수정: 대상 설정 */
		if (strTargetParam.equals("true")) 
			castlePolicy.strTargetParam = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strTargetParam = castlejsp.CastleLib.getBase64Encode("FALSE");

		if (strTargetCookie.equals("true")) 
			castlePolicy.strTargetCookie = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strTargetCookie = castlejsp.CastleLib.getBase64Encode("FALSE");

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 적용 대상 정보가 수정에 실패하였습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 적용 대상 정보가 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_config.jsp#target"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}

	/* 캐슬 기본 정책 설정 끝 */

%>
