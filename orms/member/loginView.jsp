<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>	


<%
 String urlPage=request.getContextPath()+"/orms/";

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
//		top.location.href="<%=urlPage%>";
		top.location.href="http://olympus-rms.com/orms/home/home.jsp";		
		</script>
		<%  } 

%>
