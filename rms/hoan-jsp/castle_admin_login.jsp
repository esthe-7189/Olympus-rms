<%@ page pageEncoding = "UTF-8" %>
<%

//@UTF-8 castle_admin_login.jsp
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

<% 
		/* 이미 인증된 경우 바로 이동 */
	String strImsiSessionAuthAdminID = (String)session.getAttribute("castleSessionAuthAdminID");
	String strImsiAuthKey = new String();

	strImsiAuthKey = "castleSessionAuthToken" + strImsiSessionAuthAdminID;
		
	String strImsiSessionAuth = (String)session.getAttribute(strImsiAuthKey);
	if (strImsiSessionAuth != null)
		out.println(castlejsp.CastleLib.move("castle_admin.jsp"));

%>

<% pageContext.include("castle_check_install.jsp"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="StyleSheet" HREF="style.css" type="text/css" title="style">
<% pageContext.include("castle_admin_title.jsp"); %>
  </head>
  <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" bgcolor="#D0D0D0" onload="document.login.admin_id.focus()">
    <script language="javascript">
      function nextstep() {
        var len = document.login.admin_id.value.length;
        if (len == 0) {
          alert("관리자 아이디가 입력되지 않았습니다.");
          document.login.admin_id.focus();
          return false;
        }
        len = document.login.admin_password.value.length;
        if (len == 0) {
          alert("관리자 암호가 입력되지 않았습니다.");
          document.login.admin_password.focus();
          return false;
        }
        document.login.submit();
      }
    </script>
    <br><br><br>
    <center>
      <table width="600" height="75" cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td width="100%" height="75" align="center">
            <img src="img/logo.png" border="0" alt="LOGO">
          </td>
        </tr>
        <tr>
          <td>
            <form name="login" action="castle_admin_login_submit.jsp" method="post" onsubmit="return nextstep();">
            <table width="100%" height="1">
              <tr>
                <td width="100%" height="100%" background="img/line_bg.gif"></td>
              </tr>
            </table>
            <br><br>
            <center>
            <b>관리자 인증화면</b>
            <br><br><br>
            <table width="300" cellspacing="1" cellpadding="5" border="0" bgcolor="#808080">
              <tr height="30">
                <td width="100" bgcolor="#C0C0C0" align="right"><b><font color="#404040">관리자 아이디</font></b></td>
                <td width="200" colspan="3" bgcolor="#FFFFFF"><input type="text" name="admin_id" size="24"></td>
              </tr>
              <tr height="30">
                <td width="100" bgcolor="#C0C0C0" align="right"><b><font color="#404040">암호</font></b></td>
                <td width="200" bgcolor="#FFFFFF"><input type="password" name="admin_password" size="24"></td>
              </tr>
              </tr>
            </table>
            <br>
            <input type="submit" value="로그인(Login)" class="submit" style="height:20px;">
            <input type="button" value="취소(Cancel)" class="submit" style="height:20px;" onclick="reset(); return false">
            <br><br><br>
            <table width="100%" height="1">
              <tr>
                <td width="100%" height="100%" background="img/line_bg.gif"></td>
              </tr>
            </table>
            <br>
<% pageContext.include("castle_admin_bottom.jsp"); %>
            </form>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>
