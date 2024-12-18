<%@ page pageEncoding = "UTF-8" %>
<%

//@UTF-8 castle_admin_backup.jsp
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="StyleSheet" HREF="style.css" type="text/css" title="style">
<% pageContext.include("castle_admin_title.jsp"); %>
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
                                  <font color="#C0C0C0"><li><b>백업관리</b> - CASTLE 정책을 백업합니다.</font>
                                </td>
                                <td width="8"><img src="img/menu_top_rt.gif"></td>
                              </tr>
                            </table>
                            <table width="100%" cellspacing="10" cellpadding="0" border="0">
                              <tr>
                                <td width="100%" style="line-height:160%" nowrap>
                                  <li><b>알림: 자주 정책 파일을 백업하면 안정적인 CASTLE 운영에 도움이 됩니다.</b><br>
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
                                <td height="100%" bgcolor="#B0B0B0" align="center"><b><font color="#FFFFFF">CASTLE 정책백업</font></b></td>
                                <td width="2"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
<%
		/* CASTLE 정책 정보 가져오기: CASTLE 설치 디렉터리 가져오기 */

	String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
	String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

	java.io.File file = new java.io.File(strCastlePolicyFile);

	long longPolicyFileSize = file.length();

	java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("yyyyMMdd");
	String strToday = fm.format(new java.util.Date());
	String strPolicyBackupFileName = strToday + "-castle_policy.bak";

	String strLastModified = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminLastModified));

%>

                            <table cellspacing="2" cellpadding="5" border="0">
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">정책 파일 이름</th>
                                <td width="475">
                                  castle_policy.jsp
                                </td>
                              </tr>
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">정책 파일 크기</th>
                                <td width="475">
                                  <%=longPolicyFileSize%> bytes
                                </td>
                              </tr>
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">최근 정책 수정일</th>
                                <td width="475">
                                  <%=strLastModified%>
                                </td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        "Year.Month.Day-castle_policy.bak" 이름으로 다운로드 됩니다.<br>
                                        (ex. 20071016-castle_policy.bak)
                                      </td>
                                    </tr>
                                  </table>
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
                                  <a href="castle_admin_download.jsp?filename=<%=strPolicyBackupFileName%>&filepath=/castle_policy.jsp"><img src="img/button_confirm.gif" border="0"></a>
                                  <input type="image" src="img/button_cancel.gif" onclick="history.back(-1);"></a>
                                </td>
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
