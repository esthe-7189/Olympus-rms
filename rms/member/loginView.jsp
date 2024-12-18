<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>	

<% 
String urlPage=request.getContextPath()+"/";
String urlPage2="https://olympus-rms.com/";
%>


<%
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
	//	top.location.href="<%=urlPage2%>rms/admin/admin_main.jsp";
		top.location.href="<%=urlPage%>rms/admin/admin_main.jsp";		
		</script>
		<%  } 

%>

