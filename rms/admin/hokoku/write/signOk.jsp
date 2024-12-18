<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripKesaisho" %>
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
     int kindPosi=0; 
        
	String seq=request.getParameter("seq");
	String sign_ok=request.getParameter("sign_ok");
	String noRiyu=request.getParameter("noRiyumo");			
	String position=request.getParameter("position");    
		
	DataMgrTripKesaisho manager = DataMgrTripKesaisho.getInstance();	
    	manager.signOk(Integer.parseInt(seq),Integer.parseInt(sign_ok),noRiyu,Integer.parseInt(position));   

	
/*	
	int seqdb=0; int seqSche=0;String reasonVal=""; String bashoVal="";
	String mseq=request.getParameter("mseq");
	String during_begin=request.getParameter("begin_hh");
	String during_end=request.getParameter("begin_mm");
	String reason=request.getParameter("end_hh");
	String destination=request.getParameter("hizuke");
	String duringBegin=during_begin.substring(0,10);
	String duringEnd=during_end.substring(0,10);
	if(reason.length()>100){ reasonVal=reason.substring(0,100); }else{reasonVal=reason;}	
	if(destination.length()>10){bashoVal=destination.substring(0,10);}else{bashoVal=destination;}
    
    //View_seq 0=일정관리, 1=출퇴근, 2=잔업, 3=출장결재서,4=출장보고서,5=휴가출근신청/보고서  
	     if(kindPosi==1 && sign_ok.equals("2")){
	    	DataMgr manaSch=DataMgr.getInstance();									
				schedule.setHokoku_seq(Integer.parseInt(seq));
				schedule.setMseq(Integer.parseInt(mseq));
				schedule.setDuring_begin(duringBegin);
				schedule.setDuring_end(duringEnd);
				schedule.setTitle("[出張決裁書]"+reasonVal);
				schedule.setRegister(new Timestamp(System.currentTimeMillis()) );
				schedule.setIchinichi_begin("一日中");
				schedule.setIchinichi_end("一日中");
				schedule.setBasho(bashoVal);
				schedule.setBasho_detail("no data");
				schedule.setView_seq(3);
				manaSch.insertDbSchedule(schedule);
	    }   
 */
      
%>
	
	<script language="JavaScript">
	alert("処理しました!! ");
	parent.location.href = "<%=urlPage%>rms/admin/sign/listForm.jsp";	
	</script>
