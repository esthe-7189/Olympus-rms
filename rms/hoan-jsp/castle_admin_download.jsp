<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 castle_admin_download.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jan 11 2009
 *
 */
%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page session = "true" %>

<%@ include file = "castle_policy.jsp" %>
<%
		/* 설치 여부 판단 */
	try {

		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

		java.io.File filePolicy = new java.io.File(strCastlePolicyFile);
		if (!filePolicy.isFile()) 
			return;

	} catch (Exception e) { 
		System.out.println(e);
	}

		/* 인증 여부 판단 */

	String strSessionAuthAdminID = (String)session.getAttribute("castleSessionAuthAdminID");
	String strAuthKey = new String();

	strAuthKey = "castleSessionAuthToken" + strSessionAuthAdminID;
		
	String strSessionAuth = (String)session.getAttribute(strAuthKey);
	if (strSessionAuth == null)
		return;	

	String strSessionRemoteAddr = (String)request.getRemoteAddr();
	if (!strSessionAuth.equals(strSessionRemoteAddr))
		return;	

		/* 예외 사항 체크 */
	boolean bHasFileNameParam = false;
	boolean bHasFilePathParam = false;

	java.util.Enumeration eParam = (java.util.Enumeration) request.getParameterNames();

	while (eParam.hasMoreElements()) {

		String pName = (String)eParam.nextElement();

		if (pName.equals("filename")) 
			bHasFileNameParam = true;
		else
		if (pName.equals("filepath")) 
			bHasFilePathParam = true;
		else {
			//out.println(castlejsp.CastleLib.msgBack("허용하지 않는 입력 파라미터 입니다."));
			return;
		}
	}

	if (!bHasFileNameParam) {
		//out.println(castlejsp.CastleLib.msgBack("파일 이름이 입력되지 않았습니다."));
		return;
	}

	if (!bHasFilePathParam) {
		//out.println(castlejsp.CastleLib.msgBack("파일 경로가 입력되지 않았습니다."));
		return;
	}

		/* 요청 변수 처리 */
	String strFileName = request.getParameter("filename");
	strFileName = strFileName.trim();

	String strFilePath = request.getParameter("filepath");
	strFilePath = strFilePath.trim();

		/* 파일 이름 및 파일 경로 길이 검사 */
	if (strFileName.length() < 1 || strFileName.length() > 32) {
		//out.println(castlejsp.CastleLib.msgBack("파일 이름의 길이는 1보다 크고 32보다 작아야 합니다."));
		return;
	}

	if (strFilePath.length() < 1 || strFilePath.length() > 64) {
		//out.println(castlejsp.CastleLib.msgBack("파일 경로의 길이는 1보다 크고 64보다 작아야 합니다."));
		return;
	}

		/* 트레버스 검사 및 제거 */
	try {

		strFilePath = java.net.URLDecoder.decode(strFilePath);

		java.util.regex.Pattern p = java.util.regex.Pattern.compile("\\.\\.");
		java.util.regex.Matcher m = p.matcher(strFilePath);
		while (m.find()) {
			strFilePath = strFilePath.replaceAll("\\.\\.", "\\.");
			m = p.matcher(strFilePath);
		}

		p = java.util.regex.Pattern.compile("\\./");
		m = p.matcher(strFilePath);
		while (m.find()) {
			strFilePath = strFilePath.replaceAll("\\./", "/");
			m = p.matcher(strFilePath);
		}

		p = java.util.regex.Pattern.compile("//");
		m = p.matcher(strFilePath);
		while (m.find()) {
			strFilePath = strFilePath.replaceAll("//", "/");
			m = p.matcher(strFilePath);
		}

		p = java.util.regex.Pattern.compile("\\.\\\\");
		m = p.matcher(strFilePath);
		while (m.find()) {
			strFilePath = strFilePath.replaceAll("\\.\\\\", "\\\\");
			m = p.matcher(strFilePath);
		}

		p = java.util.regex.Pattern.compile("\\\\\\\\");
		m = p.matcher(strFilePath);
		while (m.find()) {
			strFilePath = strFilePath.replaceAll("\\\\\\\\", "\\\\");
			m = p.matcher(strFilePath);
		}

			/* CASTLE 정책 가져오기 : 경로 가져오기 */
		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strSitePath = getServletContext().getRealPath(strServletName);
		String strDownFilePath = strSitePath + strFilePath;

		java.io.File file = new java.io.File(strDownFilePath);
		if (!file.exists()) {
			//out.println(castlejsp.CastleLib.msgBack("파일이 존재하지 않습니다."));
			return;
		}

		String strUserAgent = request.getHeader("USER-AGENT");

		int nUserAgent = 0;
		p = java.util.regex.Pattern.compile("MSIE 5.0|MSIE 5.1|MSIE 6.0|MSIE 7.0");
		m = p.matcher(strUserAgent);
		if (m.find()) {
			response.setHeader("Cache-Control", "public");
			response.setHeader("Content-Disposition", "attachment; filename=" + strFileName + ";");
			response.setHeader("Content-type", "application/x-force-download");
			nUserAgent = 1;
		}

		p = java.util.regex.Pattern.compile("MSIE 5.5");
		m = p.matcher(strUserAgent);
		if (m.find()) {
			response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
			response.setHeader("Cache-Control", "post-check=0, pre-check=0, false");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Content-Disposition", "inline; filename=" + strFileName + ";");
			nUserAgent = 1;
		}

		if (nUserAgent == 0) {
			response.setHeader("Cache-Control", "public");
			response.setHeader("Content-Disposition", "attachment; filename=" + strFileName + ";");
			response.setHeader("Content-type", "application/octet-stream");
		}

		java.util.Date date = new java.util.Date(file.lastModified());
		Integer intFileSize = new Integer(116 + (int)file.length());

		response.setHeader("Last-Modified", date.toString());
		response.setHeader("Content-Length", intFileSize.toString());
		response.setHeader("Content-Transfer-Encoding", "binary");

		byte[] b = new byte[5 * 1024 * 1024];

		if (file.isFile()) {

			java.io.BufferedInputStream fin = new java.io.BufferedInputStream(new java.io.FileInputStream(file));
			java.io.BufferedOutputStream fout = new java.io.BufferedOutputStream(response.getOutputStream());
				
			int nRead = 0;

			while ((nRead = fin.read(b)) != -1) 
				fout.write(b, 0, nRead);

			fout.flush();
			fin.close();
			fout.close();

		}

	} catch (Exception e) {
		out.println(e);
	}
		/* 파일 다운로드 끝 */

%>
