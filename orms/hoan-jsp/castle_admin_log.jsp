<%@ page pageEncoding = "UTF-8" %>
<%

//@UTF-8 castle_admin_log.jsp
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="StyleSheet" HREF="style.css" type="text/css" title="style">
<% pageContext.include("castle_admin_title.jsp"); %>
    <script language=javascript>
    <!--
      function log_delete_submit(log_filename)
      {
        ret = confirm("삭제하시겠습니까?");
        if (!ret)
          return;
        location.href = 'castle_admin_log_submit.jsp?mode=LOG_DELETE&log_filename='+log_filename;  
      }
    //-->
    </script>
  </head>
  <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" bgcolor="#D0D0D0">
    <table width="100%" height="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#000000">
      <tr bgcolor="#FFFFFF"> 
        <td>
          <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
            <tr bgcolor="#606060">
              <td width="100%" height="80" colspan="2">
<% pageContext.include("castle_admin_top.jsp"); %>
               </td>
            </tr>
            <tr>
              <td height="2" bgcolor="#000000" colspan="2"></td>
            </tr>
            <tr>
              <td width="160" bgcolor="#D0D0D0">
<% pageContext.include("castle_admin_menu.jsp"); %>
              </td>
              <td width="100%" bgcolor="#E0E0E0">
                <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
                  <tr valign="top">
                    <td width="100%">
                      <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
                        <tr valign="top">
                          <td width="100%">
                            <table width="100%" height="25" cellspacing="0" cellpadding="0" border="0">
                              <tr height="100%">
                                <td width="9"><img src="img/menu_top_lt.gif"></td>
                                <td width="100%" background="img/menu_top_bg.gif">
                                  <font color="#C0C0C0"><li><b>로그관리</b> - CASTLE 로그 관리합니다.</font>
                                </td>
                                <td width="8"><img src="img/menu_top_rt.gif"></td>
                              </tr>
                            </table>
                            <table width="100%" cellspacing="10" cellpadding="0" border="0">
                              <tr>
                                <td width="100%" style="line-height:160%" nowrap>
                                  <li><b>알림: 로그는 수시로 파일 용량을 확인하시고 백업 받으시길 바랍니다.</b><br>
                                </td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="800" height="25" cellspacing="0" cellpadding="0" border="0">
                              <tr>
                                <td width="2"></td>
                                <td height="100%" bgcolor="#B0B0B0" align="center"><b><font color="#FFFFFF">캐슬 로그설정</font></b></td>
                                <td width="2"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
<%
		/* CASTLE 정책 정보: 로그 정보 가져오기 */
	String strLogFileName = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogFileName));

	String strLogBoolTrueCheck = "";
	String strLogBoolFalseCheck = "";

	String strLogBool = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogBool));

	if (strLogBool.equals("TRUE")) 
		strLogBoolTrueCheck = new String("checked");
	else
		strLogBoolFalseCheck = new String("checked");

	String strLogSimpleCheck = "";
	String strLogDetailCheck = "";

	String strLogDegree = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogDegree));

	if (strLogDegree.equals("SIMPLE")) 
		strLogSimpleCheck = new String("checked");
	else
		strLogDetailCheck = new String("checked");

	String strLogCharsetUTF8Check = "";
	String strLogCharsetEuckrCheck = "";

	String strLogCharset = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogCharset));

	if (strLogCharset.equals("UTF-8")) 
		strLogCharsetUTF8Check = new String("checked");
	else
		strLogCharsetEuckrCheck = new String("checked");

	String strLogListCount = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogListCount));
	Integer intLogListCount = new Integer(strLogListCount);
%>

                            <table cellspacing="2" cellpadding="5" border="0">
                            <form action="castle_admin_log_submit.jsp?mode=LOG_MODIFY" method="post">
							<!--
							  <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">로그 파일이름</th>
                                <td width="475"><input type="text" name="log_filename" size="48" maxlength="64" value="<?php echo $print['log_filename']?>"></td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        "log/Year.Month.Day-로그파일이름"에 기록됩니다.<br>
                                        (ex. log/20071016-castle_log.txt)
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
							  -->
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">로그 기록여부</th>
                                <td>
                                  <input type="radio" name="log_str" value="true" <%=strLogBoolTrueCheck%>>기록
                                  <input type="radio" name="log_str" value="false"<%=strLogBoolFalseCheck%>>무기록
                                </td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>기록(logging) - 웹캐슬 기록을 남김(기본).
                                        <li>무기록(none) - 웹캐슬 기록을 남기지 않음.
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">로그 기록방식</th>
                                <td>
                                  <input type="radio" name="log_mode" value="simple" <%=strLogSimpleCheck%>>간략
                                  <input type="radio" name="log_mode" value="detail" <%=strLogDetailCheck%>>상세
                                </td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>간략(simple) - 웹캐슬 기록을 간략히 남김(기본).<br>
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                           (REMOTE_ADDR - [Date] REQUEST_URL: Message)
                                        <li>상세(detail) - 웹캐슬 기록을 상세히 남김.<br>
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                           (REMOTE_ADDR - [Date] REQUEST_URL: Message: ...)
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">로그 문자셋</th>
                                <td>
                                  <input type="radio" name="log_charset" value="UTF-8" <%=strLogCharsetUTF8Check%>>UTF-8(기본)
                                  <input type="radio" name="log_charset" value="eucKR" <%=strLogCharsetEuckrCheck%>>eucKR
                                </td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>UTF-8 - 로그 기록을 UTF-8로 하는 경우(기본).
                                        <li>eucKR - 로그 기록을 eucKR로 하는 경우.
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">로그 목록개수</th>
                                <td>
                                  <input type="text" name="log_list_count" value="<%=intLogListCount%>">
                                </td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="475" height="50" cellspacing="0" cellpadding="0" border="0">
                              <tr valign="top">
                                <td width="175">&nbsp;</td>
                                <td width="300">
                                  <a href="#"><input type="image" src="img/button_confirm.gif" ></a>
                                  <input type="image" src="img/button_cancel.gif" onclick="reset(); return false;"></a>
                                </td>
                              </tr>
                            </form>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="800" height="25" cellspacing="0" cellpadding="0" border="0">
                              <tr>
                                <td width="2"></td>
                                <td height="100%" bgcolor="#B0B0B0" align="center"><b><font color="#FFFFFF">캐슬 로그목록</font></b></td>
                                <td width="2"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="800" cellspacing="2" cellpadding="5" border="0">
                              <tr height="30">
                                <th width="80" bgcolor="#D8D8D8">번호</th>
                                <th width="370" bgcolor="#D8D8D8">로그파일</th>
                                <th width="100" bgcolor="#D8D8D8">파일크기</th>
                                <th width="200" bgcolor="#D8D8D8">최근시간</th>
                                <th width="50" bgcolor="#D8D8D8">삭제</th>
                              </tr>
<%
		/* CASTLE 정책 정보 가져오기: CASTLE 설치 디렉터리 가져오기 */
	String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
	String strCastleLogPath = getServletContext().getRealPath(strServletName + "/log/");

	java.io.File dir = new java.io.File(strCastleLogPath);
	if (!dir.isDirectory()) {
		out.println(castlejsp.CastleLib.msgBack(strCastleLogPath + "로그 설정 경로에 오류가 있습니다."));
		return;
	}

	java.io.File[] files = dir.listFiles();

	java.util.Arrays.sort(files);

	int nListCount = java.lang.reflect.Array.getLength(files);
	Integer intListFileCount = new Integer(0);

	for (int i = nListCount - 1; i >= 0; i--) {

		String strLoggedFilePath = files[i].toString();
		String strLoggedFileName = files[i].getName();

		java.util.regex.Pattern p = java.util.regex.Pattern.compile(strLogFileName);
		java.util.regex.Matcher m = p.matcher(strLoggedFileName);
		if (!m.find()) 
			continue;
		
		intListFileCount = new Integer(intListFileCount.intValue() + 1);
	}

	Integer intFullListFileCount = new Integer(intListFileCount.intValue());

	for (int i = nListCount - 1; i >= 0; i--) {

		if ((nListCount - 1) - i >= intLogListCount.intValue())
			break;

		String strLoggedFilePath = files[i].toString();
		String strLoggedFileName = files[i].getName();

		long nLoggedFileSize = files[i].length();
		Integer intLoggedFileSize = new Integer((int)nLoggedFileSize);
		String strLoggedFileSize = intLoggedFileSize.toString();

		long nLoggedFileMDate = files[i].lastModified(); 
		java.util.Date date = new java.util.Date(nLoggedFileMDate);

		String strLoggedFileMDate = date.toString();

		java.util.regex.Pattern p = java.util.regex.Pattern.compile(strLogFileName);
		java.util.regex.Matcher m = p.matcher(strLoggedFileName);
		if (!m.find()) 
			continue;

		String strLoggedFileNum = intListFileCount.toString();

		out.println("                              <tr height=\"25\" bgcolor=\"#FFFFFF\">");
 		out.println("                               <td align=\"center\">" + strLoggedFileNum + "</td>");
 		out.println("                               <td align=\"center\">");
 		out.println("                                 <table>");
 		out.println("                                   <tr>");
 		out.println("                                     <td><a href=\"castle_admin_download.jsp?filename=" + strLoggedFileName + "&filepath=./log/" + strLoggedFileName + "\">" + strLoggedFileName + "</a></td>");
 		out.println("                                     <td><a href=\"castle_admin_download.jsp?filename=" + strLoggedFileName + "&filepath=./log/" + strLoggedFileName + "\"><img src=\"img/button_download.gif\" border=\"0\"></a></td>");
 		out.println("                                   </tr>");
 		out.println("                                 </table>");
 		out.println("                               <td align=\"center\">" + strLoggedFileSize + " Bytes</td>");
 		out.println("                               <td align=\"center\">" + strLoggedFileMDate + "</td>");
 		out.println("                               <td align=\"center\"><input type=\"image\" src=\"img/button_delete.jpg\" onclick=\"log_delete_submit('" + strLoggedFileName + "'); return false;\"></td>");
 		out.println("                             </tr>");

		intListFileCount = new Integer(intListFileCount.intValue() - 1);
	}

%>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="800" height="40">
                              <tr>
                                <td width="100%" height="100%" align="center">총 <b><%=intFullListFileCount%></b> 개가 기록되었습니다.</td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td height="2" bgcolor="#000000" colspan="2"></td>
            </tr>
            <tr bgcolor="#A0A0A0">
              <td width="100%" height="50" colspan="2" align="center">
<% pageContext.include("castle_admin_bottom.jsp"); %>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
