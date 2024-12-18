//@UTF-8 CastleReferee.java
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : neodal <mirr1004@gmail.com>
 *
 * Last modified Jan 12 2009
 *
 */

package castlejsp;

public class CastleReferee
{
		/* CastleLib Class */
	private castlejsp.CastleLib castleLib = new castlejsp.CastleLib();

		/* CastlePolicy */
	private CastlePolicy policy;
	private String strURLName;
	private	String strServerName = "";
	private	String strServletName = "";
	private	String strCastleBasePath = "";

	private String strLogMessage = "";
	private String strErrorMessage = "";
	public String strDebugMessage = "";
	
	public CastleReferee(CastlePolicy p, String strSN, String strSP, String strCBP) { 
		policy = p;
		String strServerName = strSN;
		strServletName = strSP;
		strCastleBasePath = strCBP;
		strURLName = "http://" + strSN + strSP;
	}

	public boolean compareRegex(String r, String s, String c)
	{
		boolean found = false;

		try {
			java.util.regex.Pattern p = java.util.regex.Pattern.compile(r, java.util.regex.Pattern.UNICODE_CASE | java.util.regex.Pattern.CASE_INSENSITIVE);
			java.util.regex.Matcher m = p.matcher(s); 	

			while (m.find()) 
				found = true;

		}catch (Exception e) {
			System.out.println(e);
		}

		try {
			String ns = new String(s.getBytes("UTF-8"), "eucKR");

			java.util.regex.Pattern p = java.util.regex.Pattern.compile(r, java.util.regex.Pattern.UNICODE_CASE | java.util.regex.Pattern.CASE_INSENSITIVE);
			java.util.regex.Matcher m = p.matcher(ns); 	

			while (m.find()) 
				found = true;

		}catch (Exception e) {
			System.out.println(e);
		}

		return found;
	}
		
	public String getDateString() 
	{
		java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat ("yyyyMMdd");

		return fm.format(new java.util.Date());
	}
	 
		/* 로그 메소드 */
	public String getLogMessage() 
	{
		return strLogMessage;
	}

	public void setLogMessage(String part, String m, String p, String r, String k, String s) 
	{
		StringBuffer sb = new StringBuffer();
	
		try {

			String strLogDegree = new String(castlejsp.CastleLib.getBase64Decode(policy.strLogDegree));

			if (strLogDegree.equals("SIMPLE")) {
				sb.append(part + ": ");
				sb.append(k + ": ");
				sb.append(m + "\n");
			}
			else
			if (strLogDegree.equals("DETAIL")) {
				sb.append(k + ": ");
				sb.append(m + "\n");
				sb.append(" -> [Method: " + part + "]\n");
				sb.append(" -> [Policy: " + p + "]\n");
				sb.append(" -> [Pattern: " + r + "]\n");

				java.util.regex.Pattern mp = java.util.regex.Pattern.compile(r, java.util.regex.Pattern.UNICODE_CASE | java.util.regex.Pattern.CASE_INSENSITIVE);
				java.util.regex.Matcher mt = mp.matcher(s); 	

				while (mt.find()) 
					sb.append(" -> [Offset: " + mt.start() + "] " + 
							"[Matched-Content: \"" + mt.group() + "\"]\n");
			}

		}catch(Exception e)
		{
			System.out.println(e);
		}

		strLogMessage = sb.toString();

	}

		/* HtmlEntity 디코딩 */
	public String htmlDecode(String s) 
	{
		return s;
	}

		/* 디렉터리 트레버스 패턴 제거 */
	public String deleteDirectoryTraverse(String strPath) 
	{	
		return strPath;
	}

		/* 에러 처리 */
	public String getErrorMessage() throws Exception
	{
		return strErrorMessage;
	}

	public void setErrorMessage(String msg) throws Exception
	{
		StringBuffer sb = new StringBuffer();

		try {

			String strTitleName = new String(castlejsp.CastleLib.getBase64Decode(policy.strAdminModuleName));
			String strAlert = new String(castlejsp.CastleLib.getBase64Decode(policy.strAlert));
			
				/* 스텔스 모드 */
			if (strAlert.equals("STEALTH"))
			{
				sb.append("");  
			}

				/* 메시지 모드 */
			if (strAlert.equals("MESSAGE")) 
			{
				String strErrorImg = strCastleBasePath + "/img/sorry.gif";

				sb.append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> \n");
				sb.append("<html> \n");
				sb.append("<head> \n");
				sb.append(" 	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"> \n");
				sb.append("</head> \n");
				sb.append("<body bgcolor=\"#FFFFFF\"> \n");
				sb.append(" 	<center><br><br><br><img src=\"" + strErrorImg + "\"></center>\n");
				sb.append("</body> \n");
				sb.append("</html> \n");
			} 

				/* 경고 모드 */
			if (strAlert.equals("ALERT")) 
			{
				sb.append("<html>");
				sb.append(" <head>");
				sb.append("  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
				sb.append(" </head>");
				sb.append("<script> alert('");
				sb.append("\\n");
				sb.append("※ CASTLE 알림 ※ \\n");
				sb.append("\\n");
				sb.append("CASTLE에 의해 접근이 차단되었습니다.\\n");
				sb.append("\\n");
				sb.append("--- 차단 페이지 ---\\n\\n " + strURLName + "\\n");
				sb.append("\\n");
				sb.append("--- 차단 사유 ---\\n\\n " + msg + "\\n");
				sb.append("\\n");
				sb.append("특별한 사유 없이 위의 에러가 반복되면 관리자에게 문의하십시오.\\n");
				sb.append("위의 결과는 모두 별도의 로그에 기록됩니다.\\n");
				sb.append("\\n");
				sb.append("'); history.back(-1);</script>");
				sb.append("</html>");
			}
		
		}catch(Exception e)
		{
			System.out.println(e);
		}

		strErrorMessage = sb.toString();
	}

		/* SQL 공격 탐지 */
	public boolean detectSQL(String p, String k, String s, String c) throws Exception
	{
		String strBool = new String(castlejsp.CastleLib.getBase64Decode(policy.strSQLInjectionBool));
		if (strBool.equals("FALSE"))
			return false;

		java.util.Vector listSQL = policy.listSQLInjection;

		boolean bStatus = false;
		java.util.Enumeration e = listSQL.elements();

		while (e.hasMoreElements()) 
		{
			String r = (String)e.nextElement();
			r = new String(castlejsp.CastleLib.getBase64Decode(r));
			if (r.length() == 0)
				continue;

			if (compareRegex(r, s, c)) {
				// 에러 및 로그 설정
				setErrorMessage("SQL_Injection 공격 패턴 탐지: " + k);
				setLogMessage(p, "SQL_Injection 공격 패턴 탐지", "정책설정", r, k, s);
				bStatus = true;
			}

		}

		return bStatus;
	}

		/* XSS 공격 탐지 */
	public boolean detectXSS(String p, String k, String s, String c) throws Exception
	{
		String strBool = new String(castlejsp.CastleLib.getBase64Decode(policy.strXSSBool));
		if (strBool.equals("FALSE"))
			return false;

		java.util.Vector listXSS = policy.listXSS;

		boolean bStatus = false;
		java.util.Enumeration e = listXSS.elements();

		while (e.hasMoreElements()) 
		{
			String r = (String)e.nextElement();
			r = new String(castlejsp.CastleLib.getBase64Decode(r));
			if (r.length() == 0)
				continue;

			if (compareRegex(r, s, c)) {
				// 에러 및 로그 설정
				setErrorMessage("XSS 공격 패턴 탐지: " + k);
				setLogMessage(p, "XSS 공격 패턴 탐지", "정책설정", r, k, s);
				bStatus = true;
			}

		}

		return bStatus;
	}

		/* WORD 공격 탐지 */
	public boolean detectWord(String p, String k, String s, String c) throws Exception
	{
		String strBool = new String(castlejsp.CastleLib.getBase64Decode(policy.strWordBool));
		if (strBool.equals("FALSE"))
			return false;

		java.util.Vector listWord = policy.listWord;

		boolean bStatus = false;
		java.util.Enumeration e = listWord.elements();

		while (e.hasMoreElements()) 
		{
			String r = (String)e.nextElement();
			r = new String(castlejsp.CastleLib.getBase64Decode(r));
			if (r.length() == 0)
				continue;

			if (compareRegex(r, s, c)) {
				// 에러 및 로그 설정
				setErrorMessage("불량 WORD 공격 패턴 탐지: " + k);
				setLogMessage(p, "불량 WORD 공격 패턴 탐지", "정책설정", r, k, s);
				bStatus = true;
			}

		}

		return bStatus;
	}

		/* TAG 공격 탐지 */
	public boolean detectTag(String p, String k, String s, String c) throws Exception
	{
		String strBool = new String(castlejsp.CastleLib.getBase64Decode(policy.strTagBool));
		if (strBool.equals("FALSE"))
			return false;

		java.util.Vector listTag = policy.listTag;

		boolean bStatus = false;
		java.util.Enumeration e = listTag.elements();

		while (e.hasMoreElements()) 
		{
			String r = (String)e.nextElement();
			r = new String(castlejsp.CastleLib.getBase64Decode(r));
			if (r.length() == 0)
				continue;

			if (compareRegex(r, s, c)) {
				// 에러 및 로그 설정
				setErrorMessage("TAG 공격 패턴 탐지: " + k);
				setLogMessage(p, "TAG 공격 패턴 탐지", "정책설정", r, k, s);
				bStatus = true;
			}

		}

		return bStatus;
	}

		/* 사이트 접근 통제 적용 */
	public boolean checkSitePolicy() throws Exception
	{
		String strSiteBool = new String(castlejsp.CastleLib.getBase64Decode(policy.strSiteBool));

		if (strSiteBool.equals("FALSE")) {
				// 에러 및 로그 설정
			setErrorMessage("사이트 잠금: " + "SITE");
			setLogMessage("SITE", "사이트 잠금", "기본설정", "denied", "site", "denied");
			return true;
		}

		return false;
	}

		/* IP 접근 통제 적용 */
	public boolean checkIPPolicy(String s) throws Exception
	{
		java.util.Vector listIP = policy.listIP;

		boolean bStatus = false;
		java.util.Enumeration e = listIP.elements();

		while (e.hasMoreElements()) 
		{
			String r = (String)e.nextElement();
			r = new String(castlejsp.CastleLib.getBase64Decode(r));

			if (compareRegex(r, s, "UTF-8"))
				bStatus = true;
		}

		String strIPBase = new String(castlejsp.CastleLib.getBase64Decode(policy.strIPBase));
		if (strIPBase.equals("ALLOW")) {
			if (!bStatus) {
					// 에러 및 로그 설정
				setErrorMessage("허용되지 않은 아이피 대역에서 접근 시도: " + s);
				setLogMessage("IP", "허용되지 않은 아이피 대역에서 접근 시도", "정책설정", "denied", "IP", s);
				return true;
			}
		}
		else {
			if (bStatus) {
					// 에러 및 로그 설정
				setErrorMessage("차단된 아이피 대역에서 접근 시도: " + s);
				setLogMessage("IP", "차단된 아이피 대역에서 접근 시도", "정책설정", "denied", "IP", s);
				return true;
			}
		}

		return false;
	}

		/* GET/POST 변수 검사 */
	public boolean checkParamPolicy(String k, String s, String c) throws Exception
	{
			/* SQL 탐지 */
		if (detectSQL("GET/POST", k, s, c)) 
			return true;

			/* XSS 탐지 */
		if (detectXSS("GET/POST", k, s, c)) 
			return true;

			/* Bad Word 탐지 */
		if (detectWord("GET/POST", k, s, c)) 
			return true;

			/* Tag 탐지 */
		if (detectTag("GET/POST", k, s, c)) 
			return true;

		return false;
	}

		/* COOKIE 변수 검사 */
	public boolean checkCookiePolicy(String k, String s, String c) throws Exception
	{
			/* SQL 탐지 */
		if (detectSQL("Cookie", k, s, c)) 
			return true;

			/* XSS 탐지 */
		if (detectXSS("Cookie", k, s, c)) 
			return true;

			/* Bad Word 탐지 */
		if (detectWord("Cookie", k, s, c)) 
			return true;

			/* Tag 탐지 */
		if (detectTag("Cookie", k, s, c)) 
			return true;

		return false;
	}

	/* CASTLE Referee 메인 함수 호출 */
}
