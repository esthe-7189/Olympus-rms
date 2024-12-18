<%@ page pageEncoding = "UTF-8" %>
<%

//@UTF-8 castle_admin_config.jsp
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
                          <td width="100%" style="line-height:120%" nowrap>
                            <table width="100%" height="25" cellspacing="0" cellpadding="0" border="0">
                              <tr height="100%">
                                <td width="9"><img src="img/menu_top_lt.gif"></td>
                                <td width="100%" background="img/menu_top_bg.gif">
                                  <font color="#C0C0C0"><li><b>기본설정</b> - CASTLE 기본 정책을 설정합니다.</font>
                                </td>
                                <td width="8"><img src="img/menu_top_rt.gif"></td>
                              </tr>
                            </table>
                            <table width="100%" cellspacing="10" cellpadding="0" border="0">
                              <tr>
                                <td width="100%" style="line-height:160%" nowrap>
                                  <li><b>알림: CASTLE 이름을 따로 설정하시길 바랍니다.</b><br>
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
                                <td height="100%" bgcolor="#B0B0B0" align="center"><b><font color="#FFFFFF">CASTLE 기본설정</font></b></td>
                                <td width="2"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
<%
		/* CASTLE 정책 정보: 가져오기 */
	String strAdminModuleName = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminModuleName));
	
	String strModeEnforcingSelect = "";
	String strModePermissiveSelect = "";
	String strModeDisableSelect = "";

		/* 집행모드 */
	String strMode = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strMode));

	if (strMode.equals("ENFORCING")) 
		strModeEnforcingSelect = new String("selected");
	else
	if (strMode.equals("PERMISSIVE")) 
		strModePermissiveSelect = new String("selected");
	else
	if (strMode.equals("DISABLED")) 
		strModeDisableSelect = new String("selected");
	else
		strModePermissiveSelect = new String("selected");

		/* 경고모드 */
	String strAlertAlertSelect = "";
	String strAlertMessageSelect = "";
	String strAlertStealthSelect = "";

	String strAlert = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAlert));

	if (strAlert.equals("ALERT")) 
		strAlertAlertSelect = new String("selected");
	else
	if (strAlert.equals("MESSAGE")) 
		strAlertMessageSelect = new String("selected");
	else
	if (strAlert.equals("STEALTH")) 
		strAlertStealthSelect = new String("selected");
	else
		strAlertMessageSelect = new String("selected");
%>

                            <a name="basic"></a>
                            <table cellspacing="2" cellpadding="5" border="0">
                            <form action="castle_admin_config_submit.jsp?mode=CONFIG_BASIC" method="post">
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">CASTLE 이름</th>
                                <td><input type="text" name="admin_module_name" size="48" maxlength="64" value="<%=strAdminModuleName%>"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="800" cellspacing="2" cellpadding="5" border="0">
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">집행모드</th>
                                <td>
                                  <select type="radio" name="config_mode">
                                    <option value="enforcing" <%=strModeEnforcingSelect%>>적용모드
                                    <option value="permissive" <%=strModePermissiveSelect%>>감사모드
                                    <option value="disabled" <%=strModeDisableSelect%>>비적용모드
                                  </select>
                                </td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>적용모드(enforcing) - 실제 CASTLE을 적용함.
                                        <li>감사모드(permissive) - CASTLE을 적용하지만 집행하지는 않음(기본).
                                        <li>비적용모드(disabled) - CASTLE을 적용하지 않음.
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">알림방식</th>
                                <td>
                                  <select type="radio" name="config_alert">
                                    <option value="alert" <%=strAlertAlertSelect%>>경고모드
                                    <option value="message" <%=strAlertMessageSelect%>>메세지모드
                                    <option value="stealth" <%=strAlertStealthSelect%>>스텔스모드
                                  </select>
                                </td>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>경고모드(Alert) - 집행결과를 경고창으로 알림.
                                        <li>메세지모드(Message) - 집행결과를 메시지로 알림.
                                        <li>스텔스모드(Stealth) - 아무런 결과도 알리지 않음(기본).
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
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="800" height="25" cellspacing="0" cellpadding="0" border="0">
                              <tr>
                                <td width="2"></td>
                                <td height="100%" bgcolor="#B0B0B0" align="center"><b><font color="#FFFFFF">사이트 설정</font></b></td>
                                <td width="2"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
<%
		/* 사이트 잠금여부 */
	String strSiteBoolTrueCheck = "";
	String strSiteBoolFalseCheck = "";

	String strSiteBool = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strSiteBool));

	if (strSiteBool.equals("TRUE")) 
		strSiteBoolTrueCheck = new String("checked");
	else
		strSiteBoolFalseCheck = new String("checked");
%>
                            <a name="site"></a>
                            <table width="800" cellspacing="2" cellpadding="5" border="0">
                            <form action="castle_admin_config_submit.jsp?mode=CONFIG_SITE" method="post">
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">사이트 잠금여부</th>
                                <td>
                                  <input type="radio" name="config_site_bool" value="true" <%=strSiteBoolTrueCheck%>>열림(기본)
                                  <input type="radio" name="config_site_bool" value="false" <%=strSiteBoolFalseCheck%>>잠금
                                </td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>열림(Open) - 사이트를 정상적으로 운영함.
                                        <li>잠금(Closed) - 사이트를 잠금하여 운영하지 않음.
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
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
                            <table width="800" height="25" cellspacing="0" cellpadding="0" border="0">
                              <tr>
                                <td width="2"></td>
                                <td height="100%" bgcolor="#B0B0B0" align="center"><b><font color="#FFFFFF">CASTLE 적용대상</font></b></td>
                                <td width="2"></td>
                              </tr>
                            </table>
                            <table width="800" height="1">
                              <tr>
                                <td width="100%" height="100%" background="img/line_bg.gif"></td>
                              </tr>
                            </table>
<%
		/* GET/POST 변수 처리 여부 */
	String strTargetParamTrueCheck = "";
	String strTargetParamFalseCheck = "";

	String strTargetParam = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strTargetParam));

	if (strTargetParam.equals("TRUE")) 
		strTargetParamTrueCheck = new String("checked");
	else
		strTargetParamFalseCheck = new String("checked");

		/* COOKIE 처리 여부 */
	String strTargetCookieTrueCheck = "";
	String strTargetCookieFalseCheck = "";

	String strTargetCookie = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strTargetCookie));

	if (strTargetCookie.equals("TRUE")) 
		strTargetCookieTrueCheck = new String("checked");
	else
		strTargetCookieFalseCheck = new String("checked");

%>
                            <a name="target"></a>
                            <table cellspacing="2" cellpadding="5" border="0">
                            <form action="castle_admin_config_submit.jsp?mode=CONFIG_TARGET" method="post">
                              <tr>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">GET/POST 변수</th>
                                <td>
                                  <input type="radio" name="target_param" value="true" <%=strTargetParamTrueCheck%>>적용
                                  <input type="radio" name="target_param" value="false" <%=strTargetParamFalseCheck%>>비적용
                                </td>
                                <th width="150" height="30" bgcolor="#D8D8D8" align="right">COOKIE 변수</th>
                                <td>
                                  <input type="radio" name="target_cookie" value="true" <%=strTargetCookieTrueCheck%>>적용
                                  <input type="radio" name="target_cookie" value="false" <%=strTargetCookieFalseCheck%>>비적용
                                </td>
                              </tr>
                              <tr>
                                <th width="150" height="30"></th>
                                <td width="500" colspan="3">
                                  <table width="100%" height="50" cellspacing="1" cellpadding="10" border="0" bgcolor="#000000">
                                    <tr>
                                      <td bgcolor="#FFFFFF" style="line-height:120%" nowrap>
                                        <li>적용(True) - 각 변수에 대해서 정책을 적용함.</div>
                                        <li>비적용(False) - 각 변수에  대해서 정책을 적용하지 않음.</div>
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
                                  <input type="image" src="img/button_confirm.gif">
                                  <input type="image" src="img/button_cancel.gif" onclick="reset(); return false;">
                                </td>
                              </tr>
                            </form>
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
