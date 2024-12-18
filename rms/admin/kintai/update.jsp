<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "java.sql.Timestamp" %>


<jsp:useBean id="kintai" class="mira.kintai.DataBeanKintai">
    <jsp:setProperty name="kintai" property="*" />
</jsp:useBean>
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
//대체취득이 0이 아니면, 1)comment_kintai 테이블 update  2)schedule 테이블 수정 3)결재자 초기화
String urlPage=request.getContextPath()+"/";
String seq=request.getParameter("seq");
String daikyuSche=request.getParameter("daikyuSche");

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

String daikyu_date=request.getParameter("daikyu_date");
Calendar cal2 = Calendar.getInstance( ) ; 
String dates2[] = daikyu_date.split( "-" ) ; 
cal2.set( Integer.parseInt( dates2[0] ), Integer.parseInt( dates2[1] ) - 1, Integer.parseInt( dates2[2] ) ) ;
String ch_week2 = "";
switch( cal2.get( cal2.DAY_OF_WEEK ) ) {
	case java.util.Calendar.SUNDAY :    ch_week2 = "日" ; break ;
	case java.util.Calendar.MONDAY :    ch_week2 = "月" ; break ;
	case java.util.Calendar.TUESDAY :   ch_week2 = "火" ; break ;
	case java.util.Calendar.WEDNESDAY : ch_week2 = "水" ; break ;
	case java.util.Calendar.THURSDAY :  ch_week2 = "木" ; break ;
	case java.util.Calendar.FRIDAY :    ch_week2 = "金" ; break ;
	case java.util.Calendar.SATURDAY :  ch_week2 = "土" ; break ;
}
String dayDaikyu=daikyu_date+"("+ch_week+")";
//--------요일 구하기 end

	DataMgrKintai manager = DataMgrKintai.getInstance();				
		kintai.setHizuke(dayHizeke);
		kintai.setDaikyu_date(dayDaikyu);
	manager.update(kintai);	
	
	
/*	
	DataMgr manaSch=DataMgr.getInstance();	

String daikyu=request.getParameter("daikyu");
String dateDaikyu=kintai.getDaikyu_date().substring(0,10);
String ymdCompare=kintai.getHizuke().substring(0,10);
int count=0; int seqdb=0;

if(!daikyuSche.equals("0") && !daikyu.equals("0")){
	//update
			schedule.setKintai_seq(seqdb);			
			schedule.setDuring_begin(dateDaikyu);
			schedule.setDuring_end(dateDaikyu);
			schedule.setTitle(kintai.getDaikyu()+"(~"+ymdCompare+") ");			
			schedule.setIchinichi_begin("一日中");
			schedule.setIchinichi_end("一日中");
			schedule.setBasho("国内");
			schedule.setBasho_detail("no data");			
			manaSch.updateKintai(schedule);	
//out.println("01,,,,,,,,"+daikyuSche);
	
}else if(daikyuSche.equals("0") && !daikyu.equals("0")){
	//insert (schedule)
	seqdb=manaSch.getIdSeq("comment_kintai");
			
			schedule.setKintai_seq(seqdb);
			schedule.setMseq(kintai.getMseq());
			schedule.setDuring_begin(dateDaikyu);
			schedule.setDuring_end(dateDaikyu);
			schedule.setTitle(kintai.getDaikyu()+"(~"+ymdCompare+") ");
			schedule.setRegister(new Timestamp(System.currentTimeMillis()) );
			schedule.setIchinichi_begin("一日中");
			schedule.setIchinichi_end("一日中");
			schedule.setBasho("国内");
			schedule.setBasho_detail("no data");
			schedule.setView_seq(1);
			manaSch.insertDbSchedule(schedule);
	//out.println("02,,,,,,,"+daikyuSche+"-----"+daikyu);
}else if(!daikyuSche.equals("0") && daikyu.equals("0")){
			manaSch.deleteSchKintak(Integer.parseInt(seq));
	//out.println("02,,,,,,,,,,,,,"+daikyuSche+"-----"+daikyu);
}	
*/

%>
<script language="JavaScript">
		alert("修正完了!! ");
	  	location.href = "<%=urlPage%>rms/admin/kintai/listForm.jsp";		
	</script>

	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>