<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 install_step2_submit.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jun 29 2009
 *
 * History:
 *     Jun 22 2009 - 로그 파일이름 검사 기능 추가
 *                   초기 로그파일 이름 사용 불능화
 *                   src[[:space:]]*= 정책 제거
 *     Jun 29 2009 - 파일 관련 정책 부분 제거
 */
%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page session = "true" %>

<%
		/* 설치 여부 판단 */
	try {

		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

		java.io.File filePolicy = new java.io.File(strCastlePolicyFile);
		if (filePolicy.isFile()) {
			out.println(castlejsp.CastleLib.msgBack("CASTLE - JSP 버전이 이미 설치되어 있습니다."));
			return;
		}

	} catch (Exception e) { 
		System.out.println(e);
	}

		/* 초기 페이지 이용 여부 확인 */
	String strSessionInstall = (String)session.getAttribute("castleSessionInstall");
	if (strSessionInstall == null || !strSessionInstall.equals("TRUE")) {
		out.println(castlejsp.CastleLib.msgMove("install.jsp 설치 초기 페이지로 접근하십시오.", "install.jsp"));
		return;
	}
%>

<%
		/* 예외 사항 체크 */
	boolean bHasAdminIDParam = false;
	boolean bHasAdminPasswordParam = false;
	boolean bHasAdminRepasswordParam = false;
	boolean bHasLogFileNameParam = false;

	java.util.Enumeration eParam = (java.util.Enumeration) request.getParameterNames();

	while (eParam.hasMoreElements()) {
		String pName = (String)eParam.nextElement();
		if (pName.equals("admin_id")) 
			bHasAdminIDParam = true;
		else
		if (pName.equals("admin_password")) 
			bHasAdminPasswordParam = true;
		else
		if (pName.equals("admin_repassword")) 
			bHasAdminRepasswordParam = true;
		else
		if (pName.equals("log_filename")) 
			bHasLogFileNameParam = true;
		else {
			out.println(castlejsp.CastleLib.msgBack("허용하지 않는 입력 파라미터 입니다."));
			return;
		}
	}

	if (!bHasAdminIDParam) {
		out.println(castlejsp.CastleLib.msgBack("관리자 아이디가 입력되지 않았습니다."));
		return;
	}

	if (!bHasAdminPasswordParam) {
		out.println(castlejsp.CastleLib.msgBack("관리자 암호가 입력되지 않았습니다."));
		return;
	}

	if (!bHasAdminRepasswordParam) {
		out.println(castlejsp.CastleLib.msgBack("관리자 암호확인이 입력되지 않았습니다."));
		return;
	}

	if (!bHasLogFileNameParam) {
		out.println(castlejsp.CastleLib.msgBack("로그 파일이름이 입력되지 않았습니다."));
		return;
	}

		/* 요청 변수 처리 */
	String strAdminID = request.getParameter("admin_id");
	strAdminID = new String(strAdminID.getBytes("8859_1"), "UTF-8"); 
	strAdminID = strAdminID.trim();

	String strAdminPassword = request.getParameter("admin_password");
	strAdminPassword = strAdminPassword.trim();

	String strAdminRepassword = request.getParameter("admin_repassword");
	strAdminRepassword = strAdminRepassword.trim();

	String strLogFileName = request.getParameter("log_filename");
	strLogFileName = strLogFileName.trim();

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
	if ((strAdminPassword.length() < 8) || (strAdminPassword.length() > 32)) {
		out.println(castlejsp.CastleLib.msgBack("관리자 암호는 8자 이상 32자 이하여야 합니다."));
		return;
	}

		/* 로그 파일이름 길이 체크 */
	if ((strLogFileName.length() < 4) || (strLogFileName.length() > 48)) {
		out.println(castlejsp.CastleLib.msgBack("로그 파일이름은 4자 이상 48자 이하여야 합니다."));
		return;
	}

		/* 로그 파일이름 체크 */
	if (strLogFileName.equals("castle_log.txt")) {
		out.println(castlejsp.CastleLib.msgBack("castle_log.txt는 로그 파일이름으로 사용할 수 없습니다."));
		return;
	}

		/* MD5 수행 */
	strAdminPassword = castlejsp.CastleLib.getDoubleMD5(strAdminPassword);

		/* 시간 정보 가져오기 */
	java.util.Date d = new java.util.Date(System.currentTimeMillis());
	String strTime = d.toString();

		/* 초기 기본 정책 생성 */
	castlejsp.CastlePolicy castlePolicy = new castlejsp.CastlePolicy();

	castlePolicy.listSQLInjection = new java.util.Vector();

	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("delete +from"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("drop +database"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("drop +table"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("drop +column"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("drop +procedure"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("create +table"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("update +.* +set"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("insert +into.* +values"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("select +.* +from"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("bulk +insert"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("union +select"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("or+\\s+[a-zA-Z]+\\s*['\\\"]?\\s*=\\s*\\(?['\\\"]?\\s*[a-zA-Z]+"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("or+\\s+[0-9]+\\s*['\\\"]?\\s*=\\s*\\(?['\\\"]?\\s*[0-9]+"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("alter +table"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("into +outfile"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("load +data"));
	castlePolicy.listSQLInjection.add(castlejsp.CastleLib.getBase64Encode("declare.+varchar.+set"));


	castlePolicy.listXSS = new java.util.Vector();

	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("<script"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("%3script"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("\\x3script"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("javascript:"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("%00"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("expression *\\(*\\)"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("xss:*\\(*\\)"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("document.cookie"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("document.location"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("document.write"));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onAbort *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onBlur *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onChange *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onClick *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onDblClick *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onDragDrop *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onError *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onFocus *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onKeyDown *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onKeyPress *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onKeyUp *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onload *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onmousedown *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onmousemove *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onmouseout *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onmouseover *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onmouseup *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onmove *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onreset *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onresize *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onselect *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onsubmit *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("onunload *="));
	castlePolicy.listXSS.add(castlejsp.CastleLib.getBase64Encode("location.href *="));


	castlePolicy.listWord = new java.util.Vector();

	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("새끼"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("개새끼"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("소새끼"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("병신"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("지랄"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("씨팔"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("십팔"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("니기미"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("찌랄"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("쌍년"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("쌍놈"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("빙신"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("좆까"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("니기미"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("좆같은게"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("잡놈"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("벼엉신"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("바보새끼"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("씹새끼"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("씨발"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("씨팔"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("시벌"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("씨벌"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("떠그랄"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("좆밥"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("추천인"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("추천id"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("추천아이디"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("추/천/인"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("쉐이"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("등신"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("싸가지"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("미친놈"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("미친넘"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("찌랄"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("죽습니다"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("아님들아"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("씨밸넘"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("sex"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("섹스"));
	castlePolicy.listWord.add(castlejsp.CastleLib.getBase64Encode("바카라"));


	castlePolicy.listTag = new java.util.Vector();

	castlePolicy.listTag.add(castlejsp.CastleLib.getBase64Encode("<iframe *"));
	castlePolicy.listTag.add(castlejsp.CastleLib.getBase64Encode("<meta *"));
	castlePolicy.listTag.add(castlejsp.CastleLib.getBase64Encode("\\.\\./"));
	castlePolicy.listTag.add(castlejsp.CastleLib.getBase64Encode("\\.\\.\\\\"));

	castlePolicy.listIP = new java.util.Vector();

		// CASTLE 기본 정책 생성 
	castlePolicy.strAdminModuleName = castlejsp.CastleLib.getBase64Encode("CASTLE - JSP 버전");
	castlePolicy.strAdminID = castlejsp.CastleLib.getBase64Encode(strAdminID);
	castlePolicy.strAdminPassword = castlejsp.CastleLib.getBase64Encode(strAdminPassword);
	castlePolicy.strAdminLastModified = castlejsp.CastleLib.getBase64Encode(strTime);

	castlePolicy.strSiteBool = castlejsp.CastleLib.getBase64Encode("TRUE"); 
	castlePolicy.strMode = castlejsp.CastleLib.getBase64Encode("PERMISSIVE");
	castlePolicy.strAlert = castlejsp.CastleLib.getBase64Encode("STEALTH");

	castlePolicy.strLogBool = castlejsp.CastleLib.getBase64Encode("TRUE");
	castlePolicy.strLogDegree = castlejsp.CastleLib.getBase64Encode("SIMPLE");
	castlePolicy.strLogFileName = castlejsp.CastleLib.getBase64Encode(strLogFileName);
	castlePolicy.strLogCharset = castlejsp.CastleLib.getBase64Encode("UTF-8");
	castlePolicy.strLogListCount = castlejsp.CastleLib.getBase64Encode("10");

	castlePolicy.strTargetParam = castlejsp.CastleLib.getBase64Encode("TRUE");
	castlePolicy.strTargetCookie = castlejsp.CastleLib.getBase64Encode("TRUE");

	castlePolicy.strSQLInjectionBool = castlejsp.CastleLib.getBase64Encode("TRUE"); 
	castlePolicy.strXSSBool = castlejsp.CastleLib.getBase64Encode("TRUE");
	castlePolicy.strWordBool = castlejsp.CastleLib.getBase64Encode("FALSE");
	castlePolicy.strTagBool = castlejsp.CastleLib.getBase64Encode("TRUE");
	castlePolicy.strIPBool = castlejsp.CastleLib.getBase64Encode("FALSE");

	castlePolicy.strIPBase = castlejsp.CastleLib.getBase64Encode("DENY");

		/* CASTLE 정책 쓰기 */
	try {

		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

		if (!castlePolicy.write(strCastlePolicyFile))
			out.println(castlejsp.CastleLib.msgMove("설치가 끝났습니다.", "castle_admin.jsp"));
		else {
			out.println(castlejsp.CastleLib.msgBack(castlePolicy.strErrorMessage + ": 설치에 실패하였습니다."));
		}

	} catch (Exception e) { 
		System.out.println(e);
	}

	/* 설치 끝 */
%>
