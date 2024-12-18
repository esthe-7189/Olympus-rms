<%@ page pageEncoding = "UTF-8" %> 
<%

//@UTF-8 install_step1.jsp
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

<%
		/* 출력 형태 작성 */
	boolean bNext = true;
	String strPrintCastleDirPermission = new String();
	String strPrintCastleLogPermission = new String();

	strPrintCastleDirPermission = " - <font color=\"green\">쓰기 권한이 설정되었습니다.</font>";
	strPrintCastleLogPermission = " - <font color=\"green\">쓰기 권한이 설정되었습니다.</font>";

	String strServletName = castlejsp.CastleLib.getDirPath(request.getServletPath());
	String strCastlePolicyPath = getServletContext().getRealPath(strServletName);

		/* 설치 디렉터리 상태 */
	java.io.File file = new java.io.File(strCastlePolicyPath);
	if (!file.canWrite()) {
		strPrintCastleDirPermission = " - <font color=\"red\">쓰기 권한이 설정되지 않았습니다.</font>";
		bNext = false;
	}

	file = new java.io.File(strCastlePolicyPath + "/log");
	if (!file.canWrite()) {
		strPrintCastleLogPermission = " - <font color=\"red\">쓰기 권한이 설정되지 않았습니다.</font>";
		bNext = false;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="StyleSheet" HREF="style.css" type="text/css" title="style">
    <title>CASTLE  - 설치 2단계</title>
  </head>
  <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" bgcolor="#D0D0D0">
    <script language="javascript">
      function nextstep_windows() {
        location.href = "install_step2.jsp";
	  }
      function nextstep() {
<%
		/* 다음 단계 버튼 활성화 */
	if (bNext) {
%>
        location.href = "install_step2.jsp";
<%
	}
	else {
%>
        alert("권한이 설정되지 않았습니다.");
<%
	}
%>
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
            <form name="step1">
            <table width="600" cellspacing="1" cellpadding="20" border="0" bgcolor="#000000"
              <tr>
                <td width="100%" bgcolor="#FFFFFF" style="line-height:160%" nowrap>
                  <li><b>설치를 위하여 디렉터리 권한을 체크합니다.</b><br>
                  <br>
                  CASTLE 설치를 위하여 다음의 디렉터리를 권한 <font color="red"><b>707</b></font>로 설정하십시오.
                  <br>
                  <br>
                  <ul>
                    - CASTLE을 설치할 디렉터리 <%= strPrintCastleDirPermission %><br>
                    - ./log 디렉터리 <%= strPrintCastleLogPermission %><br>
                  </ul>
                  ※ FTP나 텔넷, SSH를 이용하여 권한을 설정하십시오.
                </td>
              </tr>
            </table>
            <br><br>
            <table width="100%" height="1">
              <tr>
                <td width="100%" height="100%" background="img/line_bg.gif"></td>
              </tr>
            </table>
            <input type="button" value="다음 단계로(Next).." class="submit" style="height:20px;" onclick="return nextstep();">
            <input type="button" value="윈도우시스템인경우:  바로 다음 단계로(Next).." class="submit" style="height:20px;" onclick="return nextstep_windows();">
            </form>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>
