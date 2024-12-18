<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ page import = "java.sql.Timestamp" %>


<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String seq = request.getParameter("seq");


	MgrOrderBunsho mgr = MgrOrderBunsho.getInstance();	
	
	//del-yn 사용 --결재완료후에는 승인을 받아야 함.  2=승인
	BeanOrderBunsho dborder=mgr.getDbOrder(Integer.parseInt(seq));
	int dbSign02_yn=dborder.getSign_02_yn();
	
	if(dbSign02_yn==1 ){
		mgr.deleteOrder(Integer.parseInt(seq));	
%>
<script language="JavaScript">
alert("データを削除しました。");
location.href = "<%=urlPage%>rms/admin/order/listForm.jsp";
</script>

<%						
	}
	
	 if(dbSign02_yn==2){		
		if(id.equals("juc0318") || id.equals("moriyama")  || id.equals("admin")){
			mgr.deleteOrder(Integer.parseInt(seq));	
		}else{			
			mgr.changeDelYn(Integer.parseInt(seq),2);	
		}
%>
<script language="JavaScript">
alert("処理しました。");
location.href = "<%=urlPage%>rms/admin/order/listForm.jsp";
</script>	
	
	
<%	
	}
%>	
	
