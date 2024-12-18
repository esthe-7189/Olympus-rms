<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.jangyo.DataBeanJangyo" %>
<%@ page import = "mira.jangyo.DataMgrJangyo" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="kintai" class="mira.jangyo.DataBeanJangyo">
    <jsp:setProperty name="kintai" property="*" />
</jsp:useBean>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
//--------요일 구하기
String hizuke=request.getParameter("hizuke");
Calendar cal = Calendar.getInstance( ) ; 
String dates[] = hizuke.split( "-" ) ; 
cal.set( Integer.parseInt( dates[0] ), Integer.parseInt( dates[1] ) - 1, Integer.parseInt( dates[2] ) ) ;
String ch_week = "";
switch( cal.get( cal.DAY_OF_WEEK ) ) {
	case java.util.Calendar.SUNDAY :    ch_week = "日" ; break ;
	case java.util.Calendar.MONDAY :    ch_week = "月" ; break ;
	case java.util.Calendar.TUESDAY :   ch_week = "火" ; break ;
	case java.util.Calendar.WEDNESDAY : ch_week = "水" ; break ;
	case java.util.Calendar.THURSDAY :  ch_week = "木" ; break ;
	case java.util.Calendar.FRIDAY :    ch_week = "金" ; break ;
	case java.util.Calendar.SATURDAY :  ch_week = "土" ; break ;
}
String dayHizeke=hizuke+"("+ch_week+")";




DataMgrJangyo manager = DataMgrJangyo.getInstance();	
kintai.setHizuke(dayHizeke);
kintai.setRegister(new Timestamp(System.currentTimeMillis()) );
manager.insertDb(kintai);		
							
%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	location.href = "<%=urlPage%>rms/admin/jangyo/listForm.jsp";		
	</script>
	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

















