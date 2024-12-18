<%@ page pageEncoding = "UTF-8" %>
<%
//@UTF-8 castle_admin_title.jsp
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
<%@ include file = "castle_policy.jsp" %>

<%
		/* CASTLE 정책 정보: 타이틀 가져오기 */
	String strTitle = new String(castlejsp.CastleLib.getBase64Decode(castlePolicy.strAdminModuleName));
%>
    <title><%=strTitle%></title>
