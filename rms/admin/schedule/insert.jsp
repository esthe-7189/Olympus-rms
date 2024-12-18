<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="schedule" class="mira.schedule.DataBean">
    <jsp:setProperty name="schedule" property="*" />
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
String sign_yn=request.getParameter("sign_yn");
String fellow_yn=request.getParameter("fellow_yn");
String pg=request.getParameter("pg");
String monthVal=request.getParameter("monthVal");
String yearVal=request.getParameter("yearVal");
int count=0;

DataMgr manager = DataMgr.getInstance();	

if(sign_yn.equals("2") ){	
	schedule.setRegister(new Timestamp(System.currentTimeMillis()) );
	manager.insertDbSchedule(schedule);	
	
}else if(sign_yn.equals("1")){	
	String signupCheckBox[]=request.getParameterValues("signup"); 
	int cnt=signupCheckBox.length;
	schedule.setRegister(new Timestamp(System.currentTimeMillis()) );
	manager.insertDbSchedule(schedule);
	count=manager.getIdSeq("schedule");
	for(int i=0; i<cnt;i++){
		schedule.setSchedule_seq(count);
		schedule.setMseq(Integer.parseInt(signupCheckBox[i]));
		manager.insertDbSign(schedule);
	}	
}

 if(fellow_yn.equals("1")){	
	String fellowCheckBox[]=request.getParameterValues("fellow"); 
	int cnt=fellowCheckBox.length;	
	count=manager.getIdSeq("schedule");
	for(int i=0; i<cnt;i++){
		schedule.setSchedule_seq(count);
		schedule.setMseq(Integer.parseInt(fellowCheckBox[i]));
		manager.insertDbFellow(schedule);
	}	
}

if(pg.equals("list")){
%>
<script language="JavaScript">
	alert("書き済みました。");
  	parent.document.location.href = "<%=urlPage%>rms/admin/schedule/listForm.jsp?month=<%=monthVal%>&year=<%=yearVal%>&action=0";	
	parent.document.getElementById('qPop').style.display = 'none';
</script>

<%}else if(pg.equals("cal")){%>
	<script language="JavaScript">
		alert("書き済みました。");
	  	parent.document.location.href = "<%=urlPage%>rms/admin/schedule/monthForm.jsp?month=<%=monthVal%>&year=<%=yearVal%>&action=0";	
		parent.document.getElementById('qPop').style.display = 'none';
	</script>
<%}%>
	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

















