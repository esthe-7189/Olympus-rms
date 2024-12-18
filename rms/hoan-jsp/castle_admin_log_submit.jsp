<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 castle_admin_log_submit.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jun 22 2009
 *
 * History:
 *     Jun 22 2009 - 로그 파일이름 검사 기능 추가
 *                   초기 로그파일 이름 사용 불능화
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

	boolean bHasLogFileNameParam = false;
	boolean bHasLogBoolParam = false;
	boolean bHasLogDegreeParam = false;
	boolean bHasLogCharsetParam = false;
	boolean bHasLogListCountParam = false;

	java.util.Enumeration eParam = (java.util.Enumeration) request.getParameterNames();

	while (eParam.hasMoreElements()) {

		String pName = (String)eParam.nextElement();

		if (pName.equals("mode")) 
			bHasModeParam = true;
		else
		if (pName.equals("log_filename")) 
			bHasLogFileNameParam = true;
		else
		if (pName.equals("log_str")) 
			bHasLogBoolParam = true;
		else
		if (pName.equals("log_mode")) 
			bHasLogDegreeParam = true;
		else
		if (pName.equals("log_charset")) 
			bHasLogCharsetParam = true;
		else
		if (pName.equals("log_list_count")) 
			bHasLogListCountParam = true;
		else
		if (pName.equals("x")) ;
		else
		if (pName.equals("y")) ;
		else {
			out.println(castlejsp.CastleLib.msgBack("허용하지 않는 입력 파라미터 입니다."));
			return;
		}
	}

		/* 요청 변수 처리 */
	String strMode = request.getParameter("mode");

		/* 로그 설정 재설정 */
	if (strMode.equals("LOG_MODIFY")) {
		/*
		if (!bHasLogFileNameParam) {
			out.println(castlejsp.CastleLib.msgBack("로그 파일이름이 입력되지 않았습니다."));
			return;
		}
		*/
		if (!bHasLogBoolParam) {
			out.println(castlejsp.CastleLib.msgBack("로그 기록 여부가 입력되지 않았습니다."));
			return;
		}

		if (!bHasLogDegreeParam) {
			out.println(castlejsp.CastleLib.msgBack("로그 기록 방식이 입력되지 않았습니다."));
			return;
		}

		if (!bHasLogCharsetParam) {
			out.println(castlejsp.CastleLib.msgBack("로그 문자셋이 입력되지 않았습니다."));
			return;
		}

		if (!bHasLogListCountParam) {
			out.println(castlejsp.CastleLib.msgBack("로그 목록 개수가 입력되지 않았습니다."));
			return;
		}

			/* 요청 변수 처리 */
		/*
		String strLogFileName = request.getParameter("log_filename");
		strLogFileName = strLogFileName.trim();
		strLogFileName = new String(strLogFileName.getBytes("8859_1"), "UTF-8"); 
		*/

		String strLogBool = request.getParameter("log_str");
		String strLogDegree = request.getParameter("log_mode");
		String strLogCharset = request.getParameter("log_charset");

		String strLogListCount = request.getParameter("log_list_count");
		strLogListCount = strLogListCount.trim();
		strLogListCount = new String(strLogListCount.getBytes("8859_1"), "UTF-8"); 

			/* 로그 파일이름 길이 체크 */
		/*
		if ((strLogFileName.length() < 4) || (strLogFileName.length() > 48)) {
			out.println(castlejsp.CastleLib.msgBack("로그 파일이름은 4자 이상 48자 이하여야 합니다."));
			return;
		}
		*/

			/* 로그 파일이름 체크 */
		/*
		if (strLogFileName.equals("castle_log.txt")) {
			out.println(castlejsp.CastleLib.msgBack("castle_log.txt는 로그 파일이름으로 사용할 수 없습니다."));
			return;
		}
		*/

			/* 로그 파일이름 예외사항 검사 */
		/*
		if (strLogFileName.matches("\\.\\.")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\./")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\.\\\\")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\.\\./")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\.\\.\\\\\\\\")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		*/
			/* 로그 목록개수 검사 */
		if (strLogListCount.length() < 1) {
			out.println(castlejsp.CastleLib.msgBack("로그 목록개수가 입력되지 않았습니다."));
			return;
		}

		Integer intLogListCount = new Integer(strLogListCount);

			/* 로그 목록개수 값 > 0 검사 */
		if (intLogListCount.intValue() < 1) {
			out.println(castlejsp.CastleLib.msgBack("로그 목록개수는 0보다 커야 합니다."));
			return;
		}

			/* 시간 정보 가져오기 */
		java.util.Date d = new java.util.Date(System.currentTimeMillis());
		String strTime = d.toString();

			/* CASTLE 정책 정보 수정: 로그 설정 */
		// castlePolicy.strLogFileName = castlejsp.CastleLib.getBase64Encode(strLogFileName);

		if (strLogBool.equals("true")) 
			castlePolicy.strLogBool = castlejsp.CastleLib.getBase64Encode("TRUE");
		else
			castlePolicy.strLogBool = castlejsp.CastleLib.getBase64Encode("FALSE");

		if (strLogDegree.equals("simple")) 
			castlePolicy.strLogDegree = castlejsp.CastleLib.getBase64Encode("SIMPLE");
		else
			castlePolicy.strLogDegree = castlejsp.CastleLib.getBase64Encode("DETAIL");

		if (strLogCharset.equals("UTF-8")) 
			castlePolicy.strLogCharset = castlejsp.CastleLib.getBase64Encode("UTF-8");
		else
			castlePolicy.strLogCharset = castlejsp.CastleLib.getBase64Encode("eucKR");

		castlePolicy.strLogListCount = castlejsp.CastleLib.getBase64Encode(strLogListCount);

			// CASTLE 정책 쓰기
		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

		if (castlePolicy.write(strCastlePolicyFile)) {
			out.println(castlejsp.CastleLib.msgBack("로그 설정 수정에 실패하였습니다."));
			return;
		}

		out.println(castlejsp.CastleLib.msgMove("로그 설정 정보가 수정되었습니다.\\n" + 
					"캐시로 인하여 정책이 바로 반영되지 않을 수 있습니다.\\n" + 
					"5초 뒤에 새로고침 하십시오.", "castle_admin_log.jsp"));

		/* 로그 설정 재설정 끝 */
	}

		/* 로그 파일 삭제 재설정 */
	if (strMode.equals("LOG_DELETE")) {

		if (!bHasLogFileNameParam) {
			out.println(castlejsp.CastleLib.msgBack("로그 파일이름이 입력되지 않았습니다."));
			return;
		}

		String strLogFileName = request.getParameter("log_filename");
		strLogFileName = strLogFileName.trim();
		strLogFileName = new String(strLogFileName.getBytes("8859_1"), "UTF-8"); 

			/* 로그 파일이름 길이 검사 */
		if (strLogFileName.length() < 1) {
			out.println(castlejsp.CastleLib.msgBack("로그 파일이름 길이가 너무 짧습니다."));
			return;
		}

			/* 로그 파일이름 예외사항 검사 */
		if (strLogFileName.matches("\\.\\.")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\./")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\.\\\\")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\.\\./")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}
		if (strLogFileName.matches("\\.\\.\\\\")) {
			out.println(castlejsp.CastleLib.msgBack("정상적이지 않은 파일 이름입니다."));
			return;
		}

			/* CASTLE 정책 가져오기 : 경로 가져오기 */
		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastleLogPath = getServletContext().getRealPath(strServletName + "/log/" + strLogFileName);

		java.io.File file = new java.io.File(strCastleLogPath);

		if (file.isFile()) {
			if (file.delete()) 
				out.println(castlejsp.CastleLib.msgBack("로그 파일이 삭제되었습니다."));
			else
				out.println(castlejsp.CastleLib.msgBack("로그 파일 삭제에 실패하였습니다."));
		}

	}
		/* 로그 파일 삭제 끝 */

%>
