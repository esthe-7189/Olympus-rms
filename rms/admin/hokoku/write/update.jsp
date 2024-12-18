<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripKesaisho" %>
<%@ page import = "java.sql.Timestamp" %>


<jsp:useBean id="kintai" class="mira.hokoku.DataBeanHokoku">
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
String reason=request.getParameter("reason");
reason=reason.replaceAll("\r\n","<br>");
//reason=reason.replaceAll("\u0020","&nbsp;");

String seq=request.getParameter("fno");
String cntSchedule01=request.getParameter("cntSchedule01");
if(cntSchedule01==null){cntSchedule01="0";}
String cntSchedule02=request.getParameter("cntSchedule02");
if(cntSchedule02==null){cntSchedule02="0";}
int cntSchedule=Integer.parseInt(cntSchedule01)+Integer.parseInt(cntSchedule02);

	DataMgrTripKesaisho manager = DataMgrTripKesaisho.getInstance();
		kintai.setSign_ok_yn_boss(1);
		kintai.setSign_ok_yn_bucho(1);	
		kintai.setSign_ok_mseq_boss(kintai.getSign_ok_mseq_boss());
		kintai.setSign_ok_mseq_bucho(kintai.getSign_ok_mseq_bucho());
		kintai.setDestination_info(kintai.getDestination_info());		
		kintai.setDrive_yn(kintai.getDrive_yn());		
		kintai.setReason(reason);
		kintai.setComment(kintai.getComment());
		kintai.setGrade(kintai.getGrade());
		kintai.setDanger(kintai.getDanger());		
		kintai.setDuring_begin(kintai.getDuring_begin());
		kintai.setDuring_end(kintai.getDuring_end());
		kintai.setPassportName(kintai.getPassportName());
		kintai.setSign_no_riyu_boss(kintai.getSign_no_riyu_boss());
		kintai.setSign_no_riyu_bucho(kintai.getSign_no_riyu_bucho());
		kintai.setTitle01(kintai.getTitle01());
		kintai.setTitle02(kintai.getTitle02());
		kintai.setSeq(Integer.parseInt(seq));						
	manager.update(kintai);	
	DataBeanHokoku dbcon=manager.getSeqCon(Integer.parseInt(seq));
	if(dbcon!=null){
		manager.delContentSchedule(Integer.parseInt(seq));
	}
	
	
	if(cntSchedule==1){		
		String sche_date=request.getParameter("sche_date");
		String sche_comment=request.getParameter("sche_comment");
		kintai.setHokoku_seq(Integer.parseInt(seq));
		kintai.setSche_date(sche_date);
		kintai.setSche_comment(sche_comment);	
		manager.insertContent(kintai);			
		
	}else if(cntSchedule>1){	
		
		String [] sche_date=request.getParameterValues("sche_date");
		String [] sche_comment=request.getParameterValues("sche_comment");	
		for(int nt=0; nt<sche_date.length;nt++){
			kintai.setHokoku_seq(Integer.parseInt(seq));
			kintai.setSche_date(sche_date[nt]);
			kintai.setSche_comment(sche_comment[nt]);					
			manager.insertContent(kintai);	
		}	
	}	
//	manager.deleteRelated(Integer.parseInt(seq));		
%>
	<script language="JavaScript">
		alert("修正完了!!");
	  	location.href = "<%=urlPage%>rms/admin/hokoku/listForm.jsp";		
	</script>

	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>