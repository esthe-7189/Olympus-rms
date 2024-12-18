<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.jangyo.DataBeanJangyo" %>
<%@ page import = "mira.jangyo.DataMgrJangyo" %>
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
    int seqdb=0; int seqSche=0;

	String seq=request.getParameter("seq");
	String sign_ok=request.getParameter("sign_ok");
	String pgKind=request.getParameter("pgKind");
	String noRiyu=request.getParameter("noRiyumo");	
	String hizuke=request.getParameter("hizuke");
	String mseq=request.getParameter("mseq");
	String begin_hh=request.getParameter("begin_hh");
	String begin_mm=request.getParameter("begin_mm");
	String end_hh=request.getParameter("end_hh");
	String end_mm=request.getParameter("end_mm");
	String sign_ok_mseq=request.getParameter("sign_ok_mseq");	
	
	if(pgKind==null){pgKind="jangyo";}

	DataMgrJangyo manager = DataMgrJangyo.getInstance();	
    manager.signOk(Integer.parseInt(seq),Integer.parseInt(sign_ok),noRiyu);  
     
     if(sign_ok.equals("2")){
    	DataMgr manaSch=DataMgr.getInstance();			
			//seqdb=manaSch.getIdSeq("jangyo");
			
			schedule.setJangyo_seq(Integer.parseInt(seq));
			schedule.setMseq(Integer.parseInt(mseq));
			schedule.setDuring_begin(hizuke);
			schedule.setDuring_end(hizuke);
			schedule.setTitle(Integer.parseInt(begin_hh)+":"+Integer.parseInt(begin_mm)+"~"+Integer.parseInt(end_hh)+":"+Integer.parseInt(end_mm));
			schedule.setRegister(new Timestamp(System.currentTimeMillis()) );
			schedule.setIchinichi_begin("一日中");
			schedule.setIchinichi_end("一日中");
			schedule.setBasho("国内");
			schedule.setBasho_detail("no data");
			schedule.setView_seq(2);
			manaSch.insertDbSchedule(schedule);
			
			seqSche=manaSch.getIdSeq("schedule");
			schedule.setSchedule_seq(seqSche);
			schedule.setMseq(Integer.parseInt(sign_ok_mseq));
			schedule.setSign_ok(Integer.parseInt(sign_ok));			
			manaSch.insertDbSign(schedule);
    }   
       
        if(pgKind.equals("jangyo")){
%>
	<script language="JavaScript">
	alert("処理しました!! ");
	parent.location.href = "<%=urlPage%>rms/admin/jangyo/listFormAll.jsp";	
	</script>
<%}else{%>
	<script language="JavaScript">
	alert("処理しました!!");
	parent.location.href = "<%=urlPage%>rms/admin/sign/listForm.jsp";	
	</script>
<%}%>