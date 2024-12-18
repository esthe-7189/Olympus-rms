<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>	
<%@ page errorPage="/rms/error/error_common.jsp"%>

<%
 String urlPage=request.getContextPath()+"/";

int result=((Integer)request.getAttribute("LOGINRESULT")).intValue();
	
	 if (result == -1) { %>
		<script language=javascript>
			alert("idが存在してないです。");
			history.go(-1);
		</script>

		<%  } else if (result == 0) { %>
		<script language=javascript>
			alert("パスワードが正しくないです。\nもし、キーボードのCaps Lockがつけているとログインができないのでご確認下さい");
			history.go(-1);
		</script>

		<%  } else if (result == 1) { %>					
		<script language=javascript>		
	//	top.location.href="http://olympus-rms.com/tokubetu/admin/admin_main.jsp";
		top.location.href="<%=urlPage%>tokubetu/admin/admin_main.jsp";		
		</script>
		<%  } 

%>
