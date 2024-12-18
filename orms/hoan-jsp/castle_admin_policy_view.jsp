<%@ page pageEncoding = "UTF-8" %>
<%

//@UTF-8 castle_admin_view.jsp
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jun 29 2009
 *
 * History:
 *     Jun 29 2009 - 파일 관련 정책 부분 제거
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
                                  <font color="#C0C0C0"><li><b>정책보기</b> - CASTLE 정책보기를 실행합니다.</font>
                                </td>
                                <td width="8"><img src="img/menu_top_rt.gif"></td>
                              </tr>
                            </table>
                            <table width="100%" cellspacing="10" cellpadding="0" border="0">
                              <tr>
                                <td width="100%" style="line-height:160%" nowrap>
                                  <li><b>정책 보기: CASTLE 정책을 트리 구조와 정책 구조로 출력합니다.</b><br>
                                </td>
                              </tr>
                            </table>
                            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                              <tr>
                                <td>
                                  <table width="800" cellspacing="1" cellpadding="20" border="0" bgcolor="#000000">
                                    <tr>
                                      <td width="100%" height="100%" style="line-height:130%" bgcolor="#FFFFFF" nowrap>
<%
	out.println("<b>CASTLE Policy Tree View<br><br></b>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; <b>- CONFIG</b><br><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- ADMIN</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; MODULE_NAME = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminModuleName)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ID = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminID)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; LASTMODIFIED = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminLastModified)) + "<br><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- SITE</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BOOL = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strSiteBool)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- MODE = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strMode)) + "</b><br><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- ALERT = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAlert)) + "</b><br><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- LOG</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BOOL = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogBool)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FILENAME = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogFileName)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; DEGREE = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogDegree)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; LIST_COUNT = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogListCount)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CHARSET = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strLogCharset)) + "</b><br><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- TARGET</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PARAM(GET/POST) = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strTargetParam)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; COOKIE = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strTargetCookie)) + "<br><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; <b>- POLICY</b><br><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- SQL_INJECTION</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BOOL = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strSQLInjectionBool)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- LIST</b><br>");

	int i = 1;
	java.util.Enumeration e = castlePolicy.listSQLInjection.elements();
	while (e.hasMoreElements()) {
		String s = (String)e.nextElement();
		if (s.length() == 0)
			continue;

		s = new String(castlejsp.CastleLib.getBase64Decode(s));
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");

		out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " + i + " = " + s + "<br>");
		i++;
	}
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; <br>");

	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- XSS</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BOOL = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strXSSBool)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- LIST</b><br>");

	i = 1;
	e = castlePolicy.listXSS.elements();
	while (e.hasMoreElements()) {
		String s = (String)e.nextElement();
		if (s.length() == 0)
			continue;

		s = new String(castlejsp.CastleLib.getBase64Decode(s));
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");

		out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " + i + " = " + s + "<br>");
		i++;
	}
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; <br>");

	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- WORD</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BOOL = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strWordBool)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- LIST</b><br>");

	i = 1;
	e = castlePolicy.listWord.elements();
	while (e.hasMoreElements()) {
		String s = (String)e.nextElement();
		if (s.length() == 0)
			continue;

		s = new String(castlejsp.CastleLib.getBase64Decode(s));
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");

		out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " + i + " = " + s + "<br>");
		i++;
	}
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; <br>");

	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- TAG</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BOOL = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strTagBool)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- LIST</b><br>");

	i = 1;
	e = castlePolicy.listTag.elements();
	while (e.hasMoreElements()) {
		String s = (String)e.nextElement();
		if (s.length() == 0)
			continue;

		s = new String(castlejsp.CastleLib.getBase64Decode(s));
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");

		out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " + i + " = " + s + "<br>");
		i++;
	}
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; <br>");

	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- IP</b><br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BOOL = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strIPBool)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BASE = " + new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strIPBase)) + "<br>");
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>- LIST</b><br>");

	i = 1;
	e = castlePolicy.listIP.elements();
	while (e.hasMoreElements()) {
		String s = (String)e.nextElement();
		if (s.length() == 0)
			continue;

		s = new String(castlejsp.CastleLib.getBase64Decode(s));
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");

		out.println("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " + i + " = " + s + "<br>");
		i++;
	}
	out.println("&nbsp; &nbsp; &nbsp; &nbsp; <br>");
%>
                                      </td>
                                    </tr>
                                  <table width="800" height="1">
                                    <tr>
                                      <td width="100" height="100%" background="img/line_bg.gif"></td>
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
