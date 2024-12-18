<%@ page pageEncoding = "UTF-8" %>
<% 

//@UTF-8 castle_referee.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 (mirr1004@gmail.com)
 *          주필환 (juluxer@gmail.com)
 *
 * Last modified Jun 23 2009
 *
 */

%>
<%
	try {

			/* Referee 생성 */
		String strServerName = new String(request.getServerName());
		String strServletName = new String(request.getServletPath());
		
		castlejsp.CastleReferee castleReferee = new castlejsp.CastleReferee(castlePolicy, 
								strServerName, strServletName, castleJSPVersionBaseDir);

		String strCastleMode = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strMode));

			/* Enforcing 및 Permissive 모드일 때만 동작 */
		if (!strCastleMode.equals("DISABLED")) {

			boolean bCastleStatus = false;

			String strCastleErrorMessage = "";
			String strCastleLogMessage = "";

			String strRemoteIP = request.getRemoteAddr();
			java.util.Date d = new java.util.Date(System.currentTimeMillis());
			String strLogTime = d.toString();
			String strLogPath = request.getServletPath();

			byte[] b;
			java.nio.charset.CharsetDecoder decoder = java.nio.charset.Charset.forName("UTF-8").newDecoder();
			String strLogBool = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogBool));
			String strLogCharset = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogCharset));

			String strCastleLogPrefix = strRemoteIP + " - [" + strLogTime + "] " + strLogPath + ": ";

				/* 사이트 접근 통제 적용 */
			if (castleReferee.checkSitePolicy()) {

				strCastleErrorMessage = castleReferee.getErrorMessage();

				if (strLogBool.equals("TRUE")) {

					strCastleLogMessage = strCastleLogPrefix + castleReferee.getLogMessage();
					if (strLogCharset.equals("eucKR")) {

						b = strCastleLogMessage.getBytes("UTF-8");
						try {
							java.nio.CharBuffer r = decoder.decode(java.nio.ByteBuffer.wrap(b));
						} catch (java.nio.charset.CharacterCodingException e) {
							strCastleLogMessage = new String(b, "eucKR");
						}
					}

					String strLogFileName = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogFileName));

					java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("yyyyMMdd");
					String strCastleToday = fm.format(new java.util.Date());

					String strCastleLogPath = "";
					strCastleLogPath = getServletContext().getRealPath(castleJSPVersionBaseDir);
					String strCastleLogFile = strCastleLogPath + "/log/" + strCastleToday + "-" + strLogFileName;
					java.io.File f = new java.io.File(strCastleLogFile);
					if (!f.exists()) {
						if (!f.createNewFile()) {
							out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 생성할 수 없습니다."));
							return;
						}
					}

					f = new java.io.File(strCastleLogFile);
					if (!f.canRead() || !f.canWrite()) {
						out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 읽거나 쓸수 없습니다."));
						return;
					}

					String strLogFileContent = "";
					String s = "";
					java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(strCastleLogFile));
					while ((s = br.readLine()) != null) 
						strLogFileContent += s + "\n";

					strLogFileContent += strCastleLogMessage + "\n";
					br.close();	

					java.io.BufferedOutputStream pf = new java.io.BufferedOutputStream(new java.io.FileOutputStream(f));
					pf.write(strLogFileContent.getBytes());
					pf.flush();

				}

				bCastleStatus = true;

			}

				/* IP 접근 통제 적용 */
			String strCastleIPBool = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strIPBool));

			if (strCastleIPBool.equals("TRUE")) {

				if (castleReferee.checkIPPolicy(strRemoteIP)) {

					strCastleErrorMessage = castleReferee.getErrorMessage();

					if (strLogBool.equals("TRUE")) {

						strCastleLogMessage = strCastleLogPrefix + castleReferee.getLogMessage();
						if (strLogCharset.equals("eucKR")) {

							b = strCastleLogMessage.getBytes("UTF-8");
							try {
								java.nio.CharBuffer r = decoder.decode(java.nio.ByteBuffer.wrap(b));
							} catch (java.nio.charset.CharacterCodingException e) {
								strCastleLogMessage = new String(b, "eucKR");
							}
						}

						String strLogFileName = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogFileName));

						java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("yyyyMMdd");
						String strCastleToday = fm.format(new java.util.Date());

						String strCastleLogPath = "";
						strCastleLogPath = getServletContext().getRealPath(castleJSPVersionBaseDir);
						String strCastleLogFile = strCastleLogPath + "/log/" + strCastleToday + "-" + strLogFileName;
						java.io.File f = new java.io.File(strCastleLogFile);
						if (!f.exists()) {
							if (!f.createNewFile()) {
								out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 생성할 수 없습니다."));
								return;
							}
						}

						f = new java.io.File(strCastleLogFile);
						if (!f.canRead() || !f.canWrite()) {
							out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 읽거나 쓸수 없습니다."));
							return;
						}

						String strLogFileContent = "";
						String s = "";
						java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(strCastleLogFile));
						while ((s = br.readLine()) != null) 
							strLogFileContent += s + "\n";

						strLogFileContent += strCastleLogMessage + "\n";
						br.close();	

						java.io.BufferedOutputStream pf = new java.io.BufferedOutputStream(new java.io.FileOutputStream(f));
						pf.write(strLogFileContent.getBytes());
						pf.flush();

					}

					bCastleStatus = true;

				}

			}

				/* GET/POST 변수 적용 */
			String strCastleTargetParamBool = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strTargetParam));

			if (strCastleTargetParamBool.equals("TRUE")) {

				java.util.Enumeration eCastleParams = request.getParameterNames();
				while (eCastleParams.hasMoreElements()) {

					String strCastleParamName = (String)eCastleParams.nextElement();
					String strCastleParamValue = request.getParameter(strCastleParamName);
					String strCastleSiteCharset = "";

					strCastleParamValue = castleReferee.deleteDirectoryTraverse(strCastleParamValue);
					
					b = strCastleParamValue.getBytes("8859_1");
					try {
						java.nio.CharBuffer r = decoder.decode(java.nio.ByteBuffer.wrap(b));
						strCastleParamValue = r.toString();
						strCastleSiteCharset = "UTF-8";
					} catch (java.nio.charset.CharacterCodingException e) {
						strCastleParamValue = new String(b, "eucKR"); 
						strCastleSiteCharset = "eucKR";
					}

					if (castleReferee.checkParamPolicy(strCastleParamName, strCastleParamValue, strCastleSiteCharset)) {

						strCastleErrorMessage = castleReferee.getErrorMessage();

						if (strLogBool.equals("TRUE")) {

							strCastleLogMessage = strCastleLogPrefix + castleReferee.getLogMessage();

							if (strLogCharset.equals("eucKR")) {
								
								b = strCastleLogMessage.getBytes("UTF-8");
								try {
									java.nio.CharBuffer r = decoder.decode(java.nio.ByteBuffer.wrap(b));
								} catch (java.nio.charset.CharacterCodingException e) {
									strCastleLogMessage = new String(b, "eucKR");
								}

							}

							String strLogFileName = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogFileName));

							java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("yyyyMMdd");
							String strCastleToday = fm.format(new java.util.Date());

							String strCastleLogPath = "";
							strCastleLogPath = getServletContext().getRealPath(castleJSPVersionBaseDir);
							String strCastleLogFile = strCastleLogPath + "/log/" + strCastleToday + "-" + strLogFileName;
							java.io.File f = new java.io.File(strCastleLogFile);
							if (!f.exists()) {
								if (!f.createNewFile()) {
									out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 생성할 수 없습니다."));
									return;
								}
							}

							f = new java.io.File(strCastleLogFile);
							if (!f.canRead() || !f.canWrite()) {
								out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 읽거나 쓸수 없습니다."));
								return;
							}

							String strLogFileContent = "";
							String s = "";
							java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(strCastleLogFile));
							while ((s = br.readLine()) != null) 
								strLogFileContent += s + "\n";

							strLogFileContent += strCastleLogMessage + "\n";
							br.close();	

							java.io.BufferedOutputStream pf = new java.io.BufferedOutputStream(new java.io.FileOutputStream(f));
							pf.write(strLogFileContent.getBytes());
							pf.flush();

						}

						bCastleStatus = true;

					}

				}

			}

				/* COOKIE 변수 적용 */
			String strCastleTargetCookieBool = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strTargetCookie));

			if (strCastleTargetCookieBool.equals("TRUE")) {

				int i;
				Cookie[] castleCookies = request.getCookies();

				if (castleCookies != null) {

					for (i = 0; i < castleCookies.length; i++) {

						String strCastleCookieName = castleCookies[i].getName();
						String strCastleCookieValue = castleCookies[i].getValue();
						String strCastleSiteCharset = "";

						strCastleCookieValue = castleReferee.deleteDirectoryTraverse(strCastleCookieValue);

						b = strCastleCookieValue.getBytes("8859_1");
						try {
							java.nio.CharBuffer r = decoder.decode(java.nio.ByteBuffer.wrap(b));
							strCastleCookieValue = r.toString();
							strCastleSiteCharset = "UTF-8";
						} catch (java.nio.charset.CharacterCodingException e) {
							strCastleCookieValue = new String(b, "eucKR"); 
							strCastleSiteCharset = "eucKR";
						}

						if (castleReferee.checkCookiePolicy(strCastleCookieName, strCastleCookieValue, strCastleSiteCharset)) {

							strCastleErrorMessage = castleReferee.getErrorMessage();
							
							if (strLogBool.equals("TRUE")) {

								strCastleLogMessage = strCastleLogPrefix + castleReferee.getLogMessage();
								if (strLogCharset.equals("eucKR")) {
								
									b = strCastleLogMessage.getBytes("UTF-8");
									try {
										java.nio.CharBuffer r = decoder.decode(java.nio.ByteBuffer.wrap(b));
									} catch (java.nio.charset.CharacterCodingException e) {
										strCastleLogMessage = new String(b, "eucKR");
									}
								}

								String strLogFileName = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogFileName));

								java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("yyyyMMdd");
								String strCastleToday = fm.format(new java.util.Date());

								String strCastleLogPath = "";
								strCastleLogPath = getServletContext().getRealPath(castleJSPVersionBaseDir);
								String strCastleLogFile = strCastleLogPath + "/log/" + strCastleToday + "-" + strLogFileName;
								java.io.File f = new java.io.File(strCastleLogFile);
								if (!f.exists()) {
									if (!f.createNewFile()) {
										out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 생성할 수 없습니다."));
										return;
									}
								}

								f = new java.io.File(strCastleLogFile);
								if (!f.canRead() || !f.canWrite()) {
									out.println(castlejsp.CastleLib.msgBack("CASTLE - 로그 파일을 읽거나 쓸수 없습니다."));
									return;
								}

								String strLogFileContent = "";
								String s = "";
								java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(strCastleLogFile));
								while ((s = br.readLine()) != null) 
									strLogFileContent += s + "\n";

								strLogFileContent += strCastleLogMessage + "\n";
								br.close();	

								java.io.BufferedOutputStream pf = new java.io.BufferedOutputStream(new java.io.FileOutputStream(f));
								pf.write(strLogFileContent.getBytes());
								pf.flush();

							}

							bCastleStatus = true;
						}

					}

				}

			}

				/* Enforcing 모드 */
			if (strCastleMode.equals("ENFORCING")) {

					/* 결과 적용 */
				if (bCastleStatus) {
					out.println(strCastleErrorMessage);
					return;
				}

			}
				/* Permissive 모드 - Do not enforce */

		}
			/* Disabled 모드 - Nothing Todo */

	} catch (Exception e) {
		out.println(e);
	}	

%>
