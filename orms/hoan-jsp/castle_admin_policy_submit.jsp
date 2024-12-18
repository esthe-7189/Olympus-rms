<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 castle_admin_policy_submit.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jan 10 2009
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

	boolean bHasSQLInjectionBoolParam = false;
	boolean bHasXSSBoolParam = false;
	boolean bHasWordBoolParam = false;
	boolean bHasTagBoolParam = false;
	boolean bHasIPBoolParam = false;
	boolean bHasIPBaseParam = false;
	boolean bHasSQLInjectionListParam = false;
	boolean bHasXSSListParam = false;
	boolean bHasWordListParam = false;
	boolean bHasTagListParam = false;
	boolean bHasIPListParam = false;

	java.util.Enumeration eParam = (java.util.Enumeration) request.getParameterNames();

	while (eParam.hasMoreElements()) {

		String pName = (String)eParam.nextElement();

		if (pName.equals("mode")) 
			bHasModeParam = true;
		else
		if (pName.equals("policy_sql_injection")) 
			bHasSQLInjectionBoolParam = true;
		else
		if (pName.equals("policy_sql_injection_list")) 
			bHasSQLInjectionListParam = true;
		else
		if (pName.equals("policy_xss")) 
			bHasXSSBoolParam = true;
		else
		if (pName.equals("policy_xss_list")) 
			bHasXSSListParam = true;
		else
		if (pName.equals("policy_word")) 
			bHasWordBoolParam = true;
		else
		if (pName.equals("policy_word_list")) 
			bHasWordListParam = true;
		else
		if (pName.equals("policy_tag")) 
			bHasTagBoolParam = true;
		else
		if (pName.equals("policy_tag_list")) 
			bHasTagListParam = true;
		else
		if (pName.equals("policy_ip")) 
			bHasIPBoolParam = true;
		else
		if (pName.equals("policy_ip_base")) 
			bHasIPBaseParam = true;
		else
		if (pName.equals("policy_ip_list")) 
			bHasIPListParam = true;
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

	Integer nIndex = new Integer(0);
	Integer nCountToken = new Integer(1);

		/* SQL_INJECTION 정책 재설정 */
	if (strMode.equals("POLICY_SQL_INJECTION")) {

		if (!bHasSQLInjectionBoolParam) {
			out.println(castlejsp.CastleLib.msgBack("SQL Injection 적용 여부가 입력되지 않았습니다."));
			return;
		}

		if (!bHasSQLInjectionListParam) {
			out.println(castlejsp.CastleLib.msgBack("SQL Injection 리스트가 입력되지 않았습니다."));
			return;
		}

		String strSQLInjectionBool = request.getParameter("policy_sql_injection");
		String strSQLInjectionList = request.getParameter("policy_sql_injection_list");

		strSQLInjectionBool = strSQLInjectionBool.trim();
		strSQLInjectionList = strSQLInjectionList.trim();

			/* CASTLE 정책 정보 수정: SQL 정책 설정 */

			/* SQL 정책 적용 여부 설정 */
		if (strSQLInjectionBool.equals("true")) 
			castlePolicy.strSQLInjectionBool = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strSQLInjectionBool = castlejsp.CastleLib.getBase64Encode("FALSE");

			/* 기존 SQL 정책 목록 삭제 */
		castlePolicy.listSQLInjection.removeAllElements();

		String[] strList = strSQLInjectionList.split("\n");

		nIndex = new Integer(0);
		nCountToken = new Integer(1);

		while (true) {
			nIndex = new Integer(strSQLInjectionList.indexOf('\n', nIndex.intValue()));
			if (nIndex.intValue() < 0)
				break;

			nIndex = new Integer(nIndex.intValue() + 1);
			nCountToken = new Integer(nCountToken.intValue() + 1);
		}

		for (int i = 0; i < nCountToken.intValue(); i++) {
			strList[i] = strList[i].trim();
			strList[i] = new String(strList[i].getBytes("8859_1"), "UTF-8"); 

			castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode(strList[i]));
		}

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 기본설정 정보가 수정되었습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 기본설정 정보가 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_policy_sql.jsp"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}
		/* SQL_INJECTION 정책 재설정 끝 */

		/* XSS 정책 재설정 */
	if (strMode.equals("POLICY_XSS")) {

		if (!bHasXSSBoolParam) {
			out.println(castlejsp.CastleLib.msgBack("XSS 적용 여부가 입력되지 않았습니다."));
			return;
		}

		if (!bHasXSSListParam) {
			out.println(castlejsp.CastleLib.msgBack("XSS 리스트가 입력되지 않았습니다."));
			return;
		}

		String strXSSBool = request.getParameter("policy_xss");
		String strXSSList = request.getParameter("policy_xss_list");

		strXSSBool = strXSSBool.trim();
		strXSSList = strXSSList.trim();

			/* CASTLE 정책 정보 수정: XSS 정책 설정 */

			/* XSS 정책 적용 여부 설정 */
		if (strXSSBool.equals("true")) 
			castlePolicy.strXSSBool = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strXSSBool = castlejsp.CastleLib.getBase64Encode("FALSE");

			/* 기존 XSS 정책 목록 삭제 */
		castlePolicy.listXSS.removeAllElements();

		String[] strList = strXSSList.split("\n");

		nIndex = new Integer(0);
		nCountToken = new Integer(1);

		while (true) {
			nIndex = new Integer(strXSSList.indexOf('\n', nIndex.intValue()));
			if (nIndex.intValue() < 0)
				break;

			nIndex = new Integer(nIndex.intValue() + 1);
			nCountToken = new Integer(nCountToken.intValue() + 1);
		}

		for (int i = 0; i < nCountToken.intValue(); i++) {
			strList[i] = strList[i].trim();
			strList[i] = new String(strList[i].getBytes("8859_1"), "UTF-8"); 

			castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode(strList[i]));
		}

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 기본설정 정보가 수정되었습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 기본설정 정보가 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_policy_xss.jsp"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}
		/* XSS 정책 재설정 끝 */

		/* WORD 정책 재설정 */
	if (strMode.equals("POLICY_WORD")) {

		if (!bHasWordBoolParam) {
			out.println(castlejsp.CastleLib.msgBack("Word 적용 여부가 입력되지 않았습니다."));
			return;
		}

		if (!bHasWordListParam) {
			out.println(castlejsp.CastleLib.msgBack("Word 리스트가 입력되지 않았습니다."));
			return;
		}

		String strWordBool = request.getParameter("policy_word");
		String strWordList = request.getParameter("policy_word_list");

		strWordBool = strWordBool.trim();
		strWordList = strWordList.trim();

			/* CASTLE 정책 정보 수정: WORD 정책 설정 */

			/* WORD 정책 적용 여부 설정 */
		if (strWordBool.equals("true")) 
			castlePolicy.strWordBool = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strWordBool = castlejsp.CastleLib.getBase64Encode("FALSE");

			/* 기존 WORD 정책 목록 삭제 */
		castlePolicy.listWord.removeAllElements();

		String[] strList = strWordList.split("\n");

		nIndex = new Integer(0);
		nCountToken = new Integer(1);

		while (true) {
			nIndex = new Integer(strWordList.indexOf('\n', nIndex.intValue()));
			if (nIndex.intValue() < 0)
				break;

			nIndex = new Integer(nIndex.intValue() + 1);
			nCountToken = new Integer(nCountToken.intValue() + 1);
		}

		for (int i = 0; i < nCountToken.intValue(); i++) {
			strList[i] = strList[i].trim();
			strList[i] = new String(strList[i].getBytes("8859_1"), "UTF-8"); 

			castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode(strList[i]));
		}

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 기본설정 정보가 수정되었습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 기본설정 정보가 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_policy_word.jsp"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}
		/* WORD 정책 재설정 끝 */

		/* TAG 정책 재설정 */
	if (strMode.equals("POLICY_TAG")) {

		if (!bHasTagBoolParam) {
			out.println(castlejsp.CastleLib.msgBack("Tag 적용 여부가 입력되지 않았습니다."));
			return;
		}

		if (!bHasTagListParam) {
			out.println(castlejsp.CastleLib.msgBack("Tag 리스트가 입력되지 않았습니다."));
			return;
		}

		String strTagBool = request.getParameter("policy_tag");
		String strTagList = request.getParameter("policy_tag_list");

		strTagBool = strTagBool.trim();
		strTagList = strTagList.trim();

			/* CASTLE 정책 정보 수정: TAG 정책 설정 */

			/* SQL 정책 적용 여부 설정 */
		if (strTagBool.equals("true")) 
			castlePolicy.strTagBool = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strTagBool = castlejsp.CastleLib.getBase64Encode("FALSE");

			/* 기존 SQL 정책 목록 삭제 */
		castlePolicy.listTag.removeAllElements();

		String[] strList = strTagList.split("\n");

		nIndex = new Integer(0);
		nCountToken = new Integer(1);

		while (true) {
			nIndex = new Integer(strTagList.indexOf('\n', nIndex.intValue()));
			if (nIndex.intValue() < 0)
				break;

			nIndex = new Integer(nIndex.intValue() + 1);
			nCountToken = new Integer(nCountToken.intValue() + 1);
		}

		for (int i = 0; i < nCountToken.intValue(); i++) {
			strList[i] = strList[i].trim();
			strList[i] = new String(strList[i].getBytes("8859_1"), "UTF-8"); 

			castlePolicy.listTag.add(castlejsp.CastleLib.getBase64Encode(strList[i]));
		}

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 기본설정 정보가 수정되었습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 기본설정 정보가 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_policy_tag.jsp"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}
		/* TAG 정책 재설정 끝 */

		/* IP 정책 재설정 */
	if (strMode.equals("POLICY_IP")) {

		if (!bHasIPBoolParam) {
			out.println(castlejsp.CastleLib.msgBack("IP 적용 여부가 입력되지 않았습니다."));
			return;
		}

		if (!bHasIPBaseParam) {
			out.println(castlejsp.CastleLib.msgBack("IP 적용 기반이 입력되지 않았습니다."));
			return;
		}

		if (!bHasIPListParam) {
			out.println(castlejsp.CastleLib.msgBack("IP 리스트가 입력되지 않았습니다."));
			return;
		}

		String strIPBool = request.getParameter("policy_ip");
		String strIPBase = request.getParameter("policy_ip_base");
		String strIPList = request.getParameter("policy_ip_list");

		strIPBool = strIPBool.trim();
		strIPBase = strIPBase.trim();
		strIPList = strIPList.trim();

			/* CASTLE 정책 정보 수정: IP 정책 설정 */

			/* IP 정책 적용 여부 설정 */
		if (strIPBool.equals("true")) 
			castlePolicy.strIPBool = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strIPBool = castlejsp.CastleLib.getBase64Encode("FALSE");

			/* IP 정책 적용 기반 설정 */
		if (strIPBase.equals("allow")) 
			castlePolicy.strIPBase = castlejsp.CastleLib.getBase64Encode("ALLOW");
		else
			castlePolicy.strIPBase = castlejsp.CastleLib.getBase64Encode("DENY");

			/* 기존 IP 정책 목록 삭제 */
		castlePolicy.listIP.removeAllElements();

		String[] strList = strIPList.split("\n");

		nIndex = new Integer(0);
		nCountToken = new Integer(1);

		while (true) {
			nIndex = new Integer(strIPList.indexOf('\n', nIndex.intValue()));
			if (nIndex.intValue() < 0)
				break;

			nIndex = new Integer(nIndex.intValue() + 1);
			nCountToken = new Integer(nCountToken.intValue() + 1);
		}

		for (int i = 0; i < nCountToken.intValue(); i++) {
			strList[i] = strList[i].trim();
			strList[i] = new String(strList[i].getBytes("8859_1"), "UTF-8"); 

			castlePolicy.listIP.add(castlejsp.CastleLib.getBase64Encode(strList[i]));
		}

			// CASTLE 정책 쓰기
		try {

			String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
			String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

			if (castlePolicy.write(strCastlePolicyFile))
				out.println(castlejsp.CastleLib.msgBack("CASTLE 정책 기본설정 정보가 수정되었습니다."));

			out.println(castlejsp.CastleLib.msgMove("CASTLE 정책 기본설정 정보가 수정되었습니다.\\n" + 
						"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
						"5초 뒤에 새로고침 하십시오.", "castle_admin_policy_ip.jsp"));

		} catch (Exception e) { 
			System.out.println(e);
		}

	}
		/* IP 정책 재설정 끝 */

	/* 캐슬 정책 설정 끝 */

%>
