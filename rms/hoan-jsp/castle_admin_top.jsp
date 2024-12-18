<%@ page pageEncoding = "UTF-8" %>
<% 

//@UTF-8 castle_admin_top.jsp
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

<% pageContext.include("castle_check_install.jsp"); %>
<% pageContext.include("castle_check_auth.jsp"); %>

<%@ include file = "castle_policy.jsp" %>
<%@ include file = "castle_version.jsp" %>

<%
	String strLastModified = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminLastModified));
%>
                <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
                  <tr valign="middle">
                    <td width="50%">&nbsp;<a href="castle_admin.jsp"><img src="img/logo.png" alt="LOGO" border="0"></a></td>
                    <td width="50%" align="right">
                      <table width="100%" height="100%" cellspacing="0" cellpadding="10">
                        <tr align="right">
                          <td>
                            <font color="#FFFFFF"><b>CASTLE / JSP 버전(<%= CASTLE_VERSION %>)</b></font><br><br>
                            <b>
                            <a href="castle_admin_logout_submit.jsp"><font color="#FFFFFF">로그아웃</font></a> |
                            <a href="http://www.krcert.or.kr" target="castle"><font color="#FFFFFF">공식홈페이지</font></a> |
                            <a href="http://www.krcert.or.kr" target="castle"><font color="#FFFFFF">메뉴얼</font></a> | 
                            <a href="http://www.krcert.or.kr"><font color="#FFFFFF">만든이</font></a> 
                            </b><br><br>
                            <font color="#B0B0B0">최근 정책 수정일: <%= strLastModified %></font><br>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
