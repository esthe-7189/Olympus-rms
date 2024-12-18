<%@ page pageEncoding = "UTF-8" %>
<%

//@UTF-8 castle_admin_policy_sql.jsp
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
                                  <font color="#C0C0C0"><li><b>정책설정</b> - CASTLE 정책을 설정합니다.</font>
                                </td>
                                <td width="8"><img src="img/menu_top_rt.gif"></td>
                              </tr>
                            </table>
                            <table width="100%" cellspacing="10" cellpadding="0" border="0">
                              <tr>
                                <td width="100%" style="line-height:160%" nowrap>
                                  <li><b>주의: 적용 여부에 주의하시고 설정에 오류가 없도록 주의하십시오.</b><br>
                                </td>
                              </tr>
                              <tr>
                                <td width="100%" style="line-height:160%" nowrap>
                                  <b>
                                    <li>세부메뉴:
                                    <font color=gray>
                                    <a href=castle_admin_policy_sql.jsp>SQL Injection</a> |
                                    <a href=castle_admin_policy_xss.jsp>XSS</a> | 
                                    <a href=castle_admin_policy_word.jsp>금칙어(WORD)</a> | 
                                    <a href=castle_admin_policy_tag.jsp>태그(TAG)</a> | 
                                    <a href=castle_admin_policy_ip.jsp>아이피(IP)</a>
                                    </font>
                                  </b>
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
                                <td height="100%" bgcolor="#B0B0B0" align="center">
                                <td height="100%" bgcolor="#B0B0B0" align="center">
                                  <b><font color="#FFFFFF">SQL Injection 정책 설정</font></b>
                                </td>
                                <td width="2"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
<%
	/* SQL INJECTION 정책 정보 수정 폼 시작 */

		/* CASTLE 정책 정보: 가져오기 */
	
		/* SQL Injection 적용 여부 */
	String strSQLInjectionBoolTrueCheck = "";
	String strSQLInjectionBoolFalseCheck = "";

	String strSQLInjectionBool = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strSQLInjectionBool));

	if (strSQLInjectionBool.equals("TRUE")) 
		strSQLInjectionBoolTrueCheck = new String("checked");
	else
		strSQLInjectionBoolFalseCheck = new String("checked");

		/* SQL Injection 정책 목록 */
	String strSQLInjectionList = "";

	java.util.Enumeration e = castlePolicy.listSQLInjection.elements();
	while (e.hasMoreElements()) {
		String s = (String)e.nextElement();
		if (s.length() == 0) 
			continue;

		s = new String(castlejsp.CastleLib.getBase64Decode(s));
		strSQLInjectionList = strSQLInjectionList + s + "\n"; 
	}

%>
                            <a name="sql_injection"></a>
                            <table width="800" cellspacing="2" cellpadding="5" border="0">
                            <form action="castle_admin_policy_submit.jsp?mode=POLICY_SQL_INJECTION" method="post">
                              <tr>
                                <th width="150" height="30" rowspan="5" bgcolor="#D8D8D8" align="right">SQL Injection</th>
                              </tr>
                              <tr>
                                <th width="100" height="30" bgcolor="#D8D8D8">적용여부</th>
                                <td width="480">
                                  <input type="radio" name="policy_sql_injection" value="true" <%=strSQLInjectionBoolTrueCheck%>>적용
                                  <input type="radio" name="policy_sql_injection" value="false" <%=strSQLInjectionBoolFalseCheck%>>비적용
                                </td>
                              </tr>
                              <tr>
                                <th width="100"></th>
                                <td width="410" colspan="2">
                                  <table width="100%" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>적용(True) - SQL Injection 취약점 탐지를 실행합니다.
                                        <li>비적용(False) - SQL Injection 취약점 탐지를 실행하지 않습니다.
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <th width="100" height="30" bgcolor="#D8D8D8">목록</th>
                                <td width="410" colspan="2">
                                  <textarea cols="65" rows="20" name="policy_sql_injection_list"><%=strSQLInjectionList%></textarea>
                                </td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="475" height="35" cellspacing="0" cellpadding="0" border="0">
                              <tr valign="top">
                                <td width="175">&nbsp;</td>
                                <td width="300">
                                  <input type="image" src="img/button_confirm.gif">
                                  <input type="image" src="img/button_cancel.gif" onclick="reset(); return false;">
                                </td>
                              </tr>
                            </form>
                            </table>
<%
	/* SQL INJECTION 정책 정보 수정 폼 끝 */
%>
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
