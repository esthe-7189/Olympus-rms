<%@ page pageEncoding = "UTF-8" %> 
<% 

//@UTF-8 install_step2.jsp
/*
 * Castle: KISA WEB Security Template(CASTLE) - JSP Version
 * 
 * Author : 이재서 <mirr1004@gmail.com>
 *          주필환 <juluxer@gmail.com>
 *
 * Last modified Jun 22 2009
 *
 * History:
 *     Jun 22 2009 - 설치 여부 판단 기능 추가
 *                   로그 파일명 입력 기능 추가
 */
%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page session = "true" %>

<%
	/* 설치 여부 판단 */
	try {

		String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
		String strCastlePolicyFile = getServletContext().getRealPath(strServletName + "/castle_policy.jsp");

		java.io.File filePolicy = new java.io.File(strCastlePolicyFile);
		if (filePolicy.isFile()) {
			out.println(castlejsp.CastleLib.msgBack("CASTLE - JSP 버전이 이미 설치되어 있습니다."));
			return;
		}

	} catch (Exception e) { 
		System.out.println(e);
	}

	/* 초기 페이지 이용 여부 확인 */
	String strSessionInstall = (String)session.getAttribute("castleSessionInstall");
	if (strSessionInstall == null || !strSessionInstall.equals("TRUE")) {
		out.println(castlejsp.CastleLib.msgMove("install.jsp 설치 초기 페이지로 접근하십시오.", "install.jsp"));
		return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="StyleSheet" HREF="style.css" type="text/css" title="style">
    <title>CASTLE - 설치 2단계</title>
  </head>
  <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" bgcolor="#D0D0D0">
    <script language="javascript">
      function nextstep() {
        var len = document.step2.admin_id.value.length;
        if (len == 0) {
          alert("관리자 아이디가 입력되지 않았습니다.");
          document.step2.admin_id.focus();
          return;
        }
        len = document.step2.admin_password.value.length;
        if (len == 0) {
          alert("관리자 암호가 입력되지 않았습니다.");
          document.step2.admin_password.focus();
          return;
        }
        len = document.step2.admin_repassword.value.length;
        if (len == 0) {
          alert("관리자 확인암호가 입력되지 않았습니다.");
          document.step2.admin_repassword.focus();
          return;
        }
        document.step2.submit();
      }
    </script>
    <br><br><br>
    <center>
      <table width="600" height="80" cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td width="100%" height="80">
            <img src="img/logo.png" border="0" alt="LOGO">
          </td>
        </tr>
        <tr>
          <td>
            <form name="step2" action="install_step2_submit.jsp" method="post">
            <table width="600" cellspacing="1" cellpadding="20" border="0" bgcolor="#000000"
              <tr>
                <td width="100%" bgcolor="#FFFFFF" style="line-height:160%" nowrap>
                  <li><b>CASTLE 관리자 계정을 생성하고 로그 파일이름을 설정합니다.</b><br>
                  <br>
                  ※ 알림1: 아이디는 최소 4자 이상이며 최대 16자 이하입니다.<br>
                  ※ 알림2: 암호는 최소 8자 이상이며 최대 32자 이하입니다.<br>
                  ※ 알림3: 로그 파일이름을 변경하시길 바랍니다.<br>
                </td>
              </tr>
            </table>
            <br><br>
            <center>
            <table width="300" cellspacing="1" cellpadding="5" border="0" bgcolor="#808080">
              <tr height="30">
                <td width="100" bgcolor="#C0C0C0" align="right"><b><font color="#404040">관리자 아이디</font></b></td>
                <td width="200" colspan="3" bgcolor="#FFFFFF"><input type="text" name="admin_id" size="24"></td>
              </tr>
              <tr height="30">
                <td width="100" bgcolor="#C0C0C0" align="right"><b><font color="#404040">암호</font></b></td>
                <td width="200" bgcolor="#FFFFFF"><input type="password" name="admin_password" size="24"></td>
              </tr>
              <tr height="30">
                <td width="100" bgcolor="#C0C0C0" align="right"><b><font color="#404040">암호확인</font></b></td>
                <td width="200" bgcolor="#FFFFFF"><input type="password" name="admin_repassword" size="24"></td>
              </tr>
            </table>
            <br>
            <b><font color="red">※ 주의: 관리자 계정 정보는 암호 찾기 기능이 존재하지 않으므로 반드시 기억하셔야 합니다.</font></b>
            <br><br>
            <table width="300" cellspacing="1" cellpadding="5" border="0" bgcolor="#808080">
              <tr height="30">
                <td width="100" bgcolor="#C0C0C0" align="right"><b><font color="#404040">로그 파일이름</font></b></td>
                <td width="200" bgcolor="#FFFFFF"><input type="text" name="log_filename" size="24" value='castle_log.txt'></td>
              </tr>
            </table>
            <br>
            </center>
            <table width="100%" height="1">
              <tr>
                <td width="100%" height="100%" background="img/line_bg.gif"></td>
              </tr>
            </table>
            <input type="button" value="설치 완료하기(Finish).." class="submit" style="height:20px;" onclick="return nextstep();">
            </form>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>
