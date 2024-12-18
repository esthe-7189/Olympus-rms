<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>

<%	
String title = ""; String name=""; String mailadd=""; String pass=""; 
int mseq=0; int level=0; String position=""; int dbPosiLevel=0; String busho="";
String inDate=dateFormat.format(new java.util.Date());		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String mgrYM=request.getParameter("mgrYM");
String signMseq=request.getParameter("signMseq");



String sum01=request.getParameter("totalsum");
String sum02=request.getParameter("totalKyusum");
String sum03=request.getParameter("totalChikokuTime");
int sum01_int=Integer.parseInt(sum01);
int sum02_int=Integer.parseInt(sum02);
int sum03_int=Integer.parseInt(sum03);

/*
int year= Integer.parseInt(mgrYM.substring(0,4));
String month= Integer.parseInt(mgrYM.substring(5,7));
*/


if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}

	
	//달력보기 시작
  String format="yyyy-MM-dd"; int changeDate =1;
  String m_week="";   

  Calendar calen=Calendar.getInstance();   
   Date date02 =calen.getTime();    
   Calendar cal = new GregorianCalendar(); 
   cal.setTime(date02);   
 
   int day_of_week = cal.get ( calen.DAY_OF_WEEK );
   switch(day_of_week){
		case 1:
			m_week="日";
			break;
		case 2:
			m_week="月";
			break;
		case 3:
			m_week="火";
			break;
		case 4:
			m_week="水";
			break;
		case 5:
			m_week="木";
			break;
		case 6:
			m_week="金";
			break;
		case 7:
			m_week="土";
			break;
		default:
			m_week=" ";
	}			
	
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();
		 mailadd=member.getMail_address();
		 pass=member.getPassword();
		 mseq=member.getMseq();
		 position=member.getPosition();
		 busho=member.getBusho();
		 dbPosiLevel=member.getPosition_level();
	}	

	
	//String mgrYM=inDate.substring(0,7);
	String mgrYyyy=inDate.substring(0,4);
	String mgrMmmm=inDate.substring(5,7);

	int mgrYyyyInt=Integer.parseInt(mgrYyyy);
	int mgrMmmmInt=Integer.parseInt(mgrMmmm);			

	DataMgrKintai mgr = DataMgrKintai.getInstance();	
	DataBeanKintai bean=mgr.getSum(mgrYM,mseq);
	int beginval=bean.getBeginval();
	int endval=bean.getEndval();
//출퇴근 시간 (일반인 8시45~17시30분 총 8시간 근무, 점심 45분/  계약직 현재 사원번호 101은 8시15~06시30분 총 )	
		
//	List list=mgr.listSchedule(mgrYM,mseq);	
	int levelKubun=0;
	if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
	List listSign=manager.selectJangyo(1,levelKubun,busho); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
	Member memSign;



// Global Vars
int action = 0;  // incoming request for moving calendar up(1) down(0) for month
int currYear = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
int currMonth = 0; // same as year
String boxSizeW = "118";  String boxSizeH = "85";

//build 2 calendars

Calendar c = Calendar.getInstance();

	if (request.getParameter("action") == null) // Check to see if we should set the year and month to the current
	{
		currMonth = c.get(c.MONTH);
		currYear = c.get(c.YEAR);
		cal.set(currYear, currMonth,1);
	}

	else
	{
		if (!(request.getParameter("action") == null)) // Hove the calendar up or down in this if block
		{
			currMonth = Integer.parseInt(request.getParameter("month"));
			currYear = Integer.parseInt(request.getParameter("year"));

				if (Integer.parseInt( request.getParameter("action")) == 1 )
				{
					cal.set(currYear, currMonth, 1);
					cal.add(cal.MONTH, 1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}
				else
				{
					cal.set(currYear, currMonth ,1);
					cal.add(cal.MONTH, -1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}
		}
	} 
%>

<%!
    public boolean isDate(int m, int d, int y) // This method is used to check for a VALID date
    {
        m -= 1;
        Calendar c = Calendar.getInstance();
        c.setLenient(false);

        try{
                c.set(y,m,d);
                Date dt = c.getTime();
        }
          catch (IllegalArgumentException e){
                return false;

        }
                return true;
    }
%>
<%!
   public String getDateName (int monthNumber) // This method is used to quickly return the proper name of a month
   {
		String strReturn = "";
		switch (monthNumber)
		{ 
	case 0:
		strReturn = "01";
		break;
	case 1:
		strReturn = "02";
		break;
	case 2:
		strReturn = "03";
		break;
	case 3:
		strReturn = "04";
		break;
	case 4:
		strReturn = "05";
		break;
	case 5:
		strReturn = "06";
		break;
	case 6:
		strReturn = "07";
		break;
	case 7:
		strReturn = "08";
		break;
	case 8:
		strReturn = "09";
		break;
	case 9:
		strReturn = "10";
		break;
	case 10:
		strReturn = "11";
		break;
	case 11:
		strReturn = "12";
		break;
	}
	return strReturn;
    }
    
    //DataMgr mgr = DataMgr.getInstance();	    
 	int ydataEnd=0; int mdataEnd=0;int ddataEnd=0; int ydata=0; int mdata=0;int ddata=0;
 	String name=""; String title=""; String endYMD; int fellowCnt=0;
 
%>	

<c:set var="listSign" value="<%= listSign %>" />	
<c:set var="member" value="<%= member %>" />		
<html>
<head>
<title>OLYMPUS-RMS [出・退社]</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
<style type="text/css">
.tFont {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:12px; color: #000000; text-decoration:none; }
.tFontB {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:14px; color: #000000; text-decoration:none; }
.tFontS {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:11px; color: #000000; text-decoration:none; }
</style>
<script language="javascript">
function resize(width, height){	
	window.resizeTo(width, height);
}

function ieExecWB( intOLEcmd, intOLEparam )
{
//참고로 IE 5.5 이상에서만 동작함
// 웹 브라우저 컨트롤 생성
var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';

// 웹 페이지에 객체 삽입
document.body.insertAdjacentHTML('beforeEnd', WebBrowser);

// if intOLEparam이 정의되어 있지 않으면 디폴트 값 설정
if ( ( ! intOLEparam ) || ( intOLEparam < -1 ) || (intOLEparam > 1 ) )
intOLEparam = 1;

// ExexWB 메쏘드 실행
WebBrowser1.ExecWB( intOLEcmd, intOLEparam );

// 객체 해제
WebBrowser1.outerHTML = "";
}

function printa(){
	window.print();
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('650','860') ;">
<center>
<table width="98%"  border=0 cellpadding=1 cellspacing=0 class="tPrint">
<tr>
	<td align="center" width="45%">
		<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#000000>
		<tr>
			<td align="center" width="5%" class="tFont">所属</td>	
			<td align="center" width="45%" class="tFontB">
					<% if(busho.equals("1")){%>品質管理部<%}%>
					<% if(busho.equals("2")){%>製造部<%}%>
					<% if(busho.equals("3")){%>管理部<%}%>	
					<% if(busho.equals("0")){%>経営役員<%}%>						
					<% if(busho.equals("4")){%>その他部<%}%>			
			</td>
			<td align="center" width="5%" class="tFont">氏名</td>	
			<td align="center" width="45%" class="tFont"><%=name%> &nbsp; 
				<%if(!member.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=member.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>(印)<%}%>	
			</td>		
		</tr>
		</table>
	</td>
	<td align="center" width="55%">
		<table width="100%"  border=0 cellpadding=0 cellspacing=0 >
		<tr>
			<td align="center" width="50%" class="calendar5_01"><%=mgrYM%>月</td>	
			<td align="center" >
				<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#000000>
				<tr>
					<td align="center" width="20%" class="tFont">上長印</td>	
					<td align="center" width="40%"> &nbsp;</td>						
					<td align="center" width="40%">
	<% DataBeanKintai signBean=mgr.getSignMseq(mgrYM,mseq);		
		if(signBean !=null){ 
			int sign_ok_mseqTotal=signBean.getMseq();
	%>																			
							
					<%
					memSign=manager.getDbMseq(sign_ok_mseqTotal);
					if(memSign!=null){
					 if(sign_ok_mseqTotal !=0){			
					%>
							<%if(!memSign.getMimg().equals("no")){%>
								<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
							<%}else{%><font color="#007AC3"><%=memSign.getNm()%></font><br>はんこ無し<%}%>				
						
					<%}}else{%>
						&nbsp;			
					<%}%>												
	<%}else{%>
				&nbsp;			
	<%}%>
					</td>		
				</tr>
				</table>
			</td>										
		</tr>
		</table>
	</td>
</tr>
</table>			
<table width="98%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<form name="frm">
			<tr>
				<td align="center" bgcolor="#ffffff" >					

<!--**********금월 리스트 begin  -->	
<table width="100%" border=1 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#000000>
<form name="frm02" action="<%=urlPage%>rms/admin/kintai/insert.jsp" method="post" >
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	<input type="hidden" name="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
<tr bgcolor=#E9FEEA align=center >	
    <td  align="center" width="7%" rowspan="2" colspan="2" class="tFont">日付 </td>
    <td  align="center" width="7%" rowspan="2" class="tFont">普通残業<br>FT過不足</td>    
    <td  align="center" width="7%" rowspan="2" class="tFont">休日出勤</td>
    <td  align="center" width="8%" rowspan="2" class="tFont">休暇</td>
    <td  align="center" width="8%" rowspan="2" class="tFont">代休取得</td>
    <td  align="center" width="7%" rowspan="2" class="tFont">遅刻・早退・<br>外出時間</td>     
    <td  align="center" width="10%" class="tFont">始業時間</td>
    <td  align="center" width="10%" class="tFont">終業時間</td> 
    <td  align="center" rowspan="2" width="8%" class="tFont">備考</td>
    <td  align="center" rowspan="2" width="6%" class="tFont">印</td>  		
</tr>
 <tr bgcolor=#E9FEEA align=center>
    <td align="center" colspan="2" class="tFont">理由</td>
 </tr>
					
<!--*****시작-->
<%
//'Calendar loop
	int currDay;
	//String todayColor;
	int count = 1;
	int dispDay = 1;	
	String ymdToday="";
//	String ymdList="";
//	int totalsum=0; int totalKyusum=0;int totalChikokuTime=0;	
	for (int w = 1; w < 7; w++){						
  		for (int d = 1; d < 8; d++){  		  	  			
  	
  	int i=1;	int sumZanHH=0;  int sumZanMM=0; int sumZanTotal=0; String ddZero=""; int beginval_s=0; int endval_s=0;int seq=0;int sign_ok=0; int sign_ok_mseq=0;
	int totalValueHH_s=0; int totalValueMM_s=0;	 String beginZero="0"; String endZero="0"; String riyu=""; String comment="&nbsp;";
	String daikyu="0"; String daikyu_date="0"; int chikoku_hh=0; int chikoku_mm=0; int begin_hh=0; int end_hh=0;int horiTotal=0;
//	String hizukeYoubi="";String yyCol=""; String mmCol=""; String ddCol=""; String ddColZero=""; 
	String bgCol="#ffffff"; String bgColElse="#ffffff"; String bgColKyu="#D0D0D0"; 
	//휴일=holi, 평일=day
	String jobTimeKubun="day";
	
	int holiday_hh=0; int holiday_mm=0; String oneday_holi="&nbsp;";
	int jangyoPast495=0; int jangyoPast595=0;
	int totalKyuHH_s=0; int totalKyuMM_s=0; int chikokuTime=0;
	
	
	DataMgr mgrHori = DataMgr.getInstance();	
//*************************휴일 start***********************
	String ymdList=""; int yyHori=0; int mmHori=0;  int ddHori=0;
	if(dispDay<10){
		ymdList=cal.get(cal.YEAR)+"-"+getDateName (cal.get(cal.MONTH))+"-0"+dispDay;
	}else{
		ymdList=cal.get(cal.YEAR)+"-"+getDateName (cal.get(cal.MONTH))+"-"+dispDay;
	}						
		
	String ymdList2="";
	if(dispDay<10){
		ymdList2="0000-"+getDateName (cal.get(cal.MONTH))+"-0"+dispDay;
	}else{
		ymdList2="0000-"+getDateName (cal.get(cal.MONTH))+"-"+dispDay;
	}
	DataBeanKintai dbb=mgr.getKintaiDate(ymdList,mseq);
	DataBean beanHori=mgrHori.getHoriday(ymdList);
	DataBean beanHori2=mgrHori.getHoriday(ymdList2);	
	
	if(beanHori !=null && beanHori2 ==null){
		yyHori=Integer.parseInt(beanHori.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori.getDuring_begin().substring(8,10)); 
		
		bgCol="#FFC286";  bgColElse="#D0D0D0"; bgColKyu="#ffffff"; jobTimeKubun="holi" ;
								
	}else if(beanHori ==null && beanHori2 !=null){
		yyHori=Integer.parseInt(beanHori2.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori2.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori2.getDuring_begin().substring(8,10)); 	
		
		bgCol="#FFC286";  bgColElse="#D0D0D0"; bgColKyu="#ffffff"; jobTimeKubun="holi" ;
		
	}else if(beanHori !=null && beanHori2 !=null){
		yyHori=Integer.parseInt(beanHori.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori.getDuring_begin().substring(8,10)); 
		
		bgCol="#FFC286";  bgColElse="#D0D0D0"; bgColKyu="#ffffff"; jobTimeKubun="holi" ;
		
	}else if(beanHori ==null && beanHori2 ==null){		
		yyHori=0; 
		mmHori=0; 
		ddHori=0; 
		
		if(d==1 || d==7  || cal.get(cal.MONTH)==1-1 && dispDay==1 || cal.get(cal.MONTH)==1-1 && dispDay==1){
	 		bgCol="#FFC286";  bgColElse="#D0D0D0"; bgColKyu="#ffffff"; jobTimeKubun="holi" ; 
	 	}   	     			 
}%>

<c:set var="dbb" value="<%= dbb %>" />	
<%
		
if(dbb !=null){	
		seq=dbb.getSeq();								
		beginval_s=dbb.getBeginval();  //시작한 분계산
		endval_s=dbb.getEndval();	 //끝난 분계산
		horiTotal=(dbb.getHoliday_hh()*60)+dbb.getHoliday_mm(); 	 //휴일출근 수작업	
						
		sign_ok=dbb.getSign_ok();				
		sign_ok_mseq=dbb.getSign_ok_mseq();
		daikyu=dbb.getDaikyu();
		daikyu_date=dbb.getDaikyu_date();
		chikoku_hh=dbb.getChikoku_hh();
		chikoku_mm=dbb.getChikoku_mm();
		begin_hh=dbb.getBegin_hh();
		end_hh=dbb.getEnd_hh();
		riyu= dbb.getRiyu();
		comment= dbb.getComment();
		holiday_hh=dbb.getHoliday_hh();
		holiday_mm=dbb.getHoliday_mm();
		oneday_holi=dbb.getOneday_holi();
		
						jangyoPast495=endval_s-beginval_s-495;				
						jangyoPast595=endval_s-beginval_s-525;
						chikokuTime=(dbb.getChikoku_hh()*60)+dbb.getChikoku_mm();
						
						
					// 잔교시 휴식 15분	
	if(jobTimeKubun.equals("holi")){
					if(member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){	
				//		totalKyuHH_s=(endval_s-beginval_s-chikokuTime)/60;
				//		totalKyuMM_s=(endval_s-beginval_s-chikokuTime)%60;	
				//		totalKyusum +=(endval_s-beginval_s-chikokuTime);
				//		totalChikokuTime +=chikokuTime;						
					}else if(!member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){					
				//		totalKyuHH_s=(endval_s-beginval_s-chikokuTime)/60;
				//		totalKyuMM_s=(endval_s-beginval_s-chikokuTime)%60;	
				//		totalKyusum +=(endval_s-beginval_s-chikokuTime);	
				//		totalChikokuTime +=chikokuTime;								
					}
			}else{
					if(jangyoPast495 <=0 && member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){
						totalValueHH_s=(endval_s-beginval_s-495-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-495-chikokuTime)%60;	
					//	totalsum +=(endval_s-beginval_s-495-chikokuTime);	
					//	totalChikokuTime +=chikokuTime;						
					}else if(jangyoPast495 >0 && member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-510-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-510-chikokuTime)%60;
					//	totalsum += (endval_s-beginval_s-510-chikokuTime);
					//	totalChikokuTime +=chikokuTime;	
						
					}else if(jangyoPast595 <=0 && !member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-525-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-525-chikokuTime)%60;	
					//	totalsum +=(endval_s-beginval_s-525-chikokuTime);
					//	totalChikokuTime +=chikokuTime;	
						
					}else if(jangyoPast595 >0 && !member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-540-chikokuTime)/60;  
						totalValueMM_s=(endval_s-beginval_s-540-chikokuTime)%60;	
					//	totalsum +=(endval_s-beginval_s-540-chikokuTime);	
					//	totalChikokuTime +=chikokuTime;						
					}
		}
		
	/*					hizukeYoubi=dbb.getHizuke().substring(11,12);
						yyCol=dbb.getHizuke().substring(0,4);
						mmCol=dbb.getHizuke().substring(5,7);
						ddCol=dbb.getHizuke().substring(8,10);
						ddColZero=dbb.getHizuke().substring(8,9);
						if(ddColZero.equals("0")){ddZero=dbb.getHizuke().substring(9,10);
						}else{
							ddZero=ddCol;
						}
		*/
					if(dbb.getBegin_mm()==0){
						beginZero="0"+dbb.getBegin_mm();
					}else{
						beginZero=String.valueOf(dbb.getBegin_mm());
					}	
					
					if(dbb.getEnd_mm()==0){
						endZero="0"+dbb.getEnd_mm();
					}else{
						endZero=String.valueOf(dbb.getEnd_mm());
					}
}				
  					
			if (! (count >= cal.get(c.DAY_OF_WEEK))){ 								

%>
				&nbsp;
				    	
<%	count += 1;
	} else{
				if (isDate ( currMonth + 1, dispDay, currYear) ) { 					
%> 
<%if(seq!=0){%>
		<tr align="center">
	<%if(dispDay <10){%>
			<td width="5" style="padding:0 0 0 10" rowspan="2" align="right" class="tFont"><%=dispDay%></td>	
	<%}else{%>
			<td width="5" style="padding:0 0 0 5" rowspan="2" align="right"class="tFont" ><%=dispDay%></td>	
	<%}%>					
			<%if(d==1){%><td width="5" align="center"  rowspan="2" style="padding:0 0 0 5" bgcolor="#FFC286" class="tFont">日<%}%>
			<%if(d==2){%><td width="5" align="center"  rowspan="2" style="padding:0 0 0 5"  bgcolor="<%=bgCol%>" class="tFont">月<%}%>
			<%if(d==3){%><td width="5" align="center"  rowspan="2" style="padding:0 0 0 5" bgcolor="<%=bgCol%>" class="tFont">火<%}%>
			<%if(d==4){%><td  width="5" align="center"  rowspan="2" style="padding:0 0 0 5" bgcolor="<%=bgCol%>" class="tFont">水<%}%>
			<%if(d==5){%><td  width="5" align="center"  rowspan="2" style="padding:0 0 0 5" bgcolor="<%=bgCol%>" class="tFont">木<%}%>
			<%if(d==6){%><td  width="5" align="center"  rowspan="2" style="padding:0 0 0 5"  bgcolor="<%=bgCol%>" class="tFont">金<%}%>
			<%if(d==7){%><td  width="5" align="center"  rowspan="2" style="padding:0 0 0 5" bgcolor="#FFC286" class="tFont" >土<%}%></td>							
	<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" rowspan="2">		
		<%if(jobTimeKubun.equals("holi") ){%> 
			&nbsp; 
		<%}else if(jobTimeKubun.equals("day") && seq !=0){%>
					<%if(oneday_holi.equals("0") && daikyu.equals("0") && !id.equals("candy")){%>
							<%=totalValueHH_s%>:<%if(totalValueMM_s==0){%><%=totalValueMM_s%>0<%}else{%><%=totalValueMM_s%><%}%> 					
					<%}else if(oneday_holi.equals("0") && !daikyu.equals("0") && !id.equals("candy")){%>
							&nbsp;					
					<%}else if(!oneday_holi.equals("0") && daikyu.equals("0") && !id.equals("candy")){%>						
							&nbsp;					
					<%}else if(id.equals("candy")){%>
						0:00
					<%}else{%>
							 &nbsp;		 
					<%}%>						
		<%}else{%>	
			&nbsp; 
		<%}%>
	</td>			
	<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColKyu%>" class="tFont" rowspan="2">
		<%if(jobTimeKubun.equals("day")){%> 
			&nbsp; 
		<%}else if(jobTimeKubun.equals("holi") && seq !=0){%>
					<%if(oneday_holi.equals("0") && daikyu.equals("0") && !id.equals("candy")){%>
							<%=dbb.getHoliday_hh()%>:<%if(dbb.getHoliday_mm()==0){%><%=dbb.getHoliday_mm()%>0<%}else{%><%=dbb.getHoliday_mm()%><%}%>					
					<%}else if(oneday_holi.equals("0") && !daikyu.equals("0") && !id.equals("candy")){%>
							&nbsp;					
					<%}else if(!oneday_holi.equals("0") && daikyu.equals("0") && !id.equals("candy")){%>
							&nbsp;					
					<%}else if(id.equals("candy")){%>
						0:00
					<%}else{%>
							 &nbsp;		 
					<%}%>			
		<%}else{%>	
			&nbsp; 
		<%}%>						
	</td>
	<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" rowspan="2">
		<%if(oneday_holi.equals("0")){%> &nbsp;
		<%}else if(!oneday_holi.equals("0") && oneday_holi !=null){%><%=oneday_holi%> <%}%>
	</td>	
			
	<%if(!daikyu.equals("0")){%>
			<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" rowspan="2"><%=daikyu%>(<%=daikyu_date%>)</td>					
	<%}else{%>
		 	<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" rowspan="2">&nbsp;</td>
	<%}%>	
	<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" rowspan="2">
		<%if(chikoku_hh==0 && chikoku_mm==0 ){%>
				&nbsp;			
		<%}else if(chikoku_hh!=0 && chikoku_mm==0){%>
			<%=chikoku_hh%>:<%=chikoku_mm%>0		 
		<%}else if(chikoku_hh==0 && chikoku_mm!=0){%>
			<%=chikoku_hh%>:<%=chikoku_mm%>		
		<%}else{%>	
				&nbsp;
		<%}%>		
		
	</td>	
	<td   style="padding:0 0 0 0" align="center" class="tFont">				
		<%if(begin_hh==0 && beginZero.equals("0")){%> &nbsp; <%}%>
		<%if(begin_hh==0 && !beginZero.equals("0")){%> 0:<%=beginZero%> <%}%>
		<%if(begin_hh !=0 && !beginZero.equals("0")){%> <%=begin_hh%>:<%=beginZero%> <%}%>
	</td>					
	<td   style="padding:0 0 0 0" align="center" class="tFont">
		<%if(end_hh==0 && endZero.equals("0")){%> &nbsp; <%}%>
		<%if(end_hh==0 && !endZero.equals("0")){%> 0:<%=endZero%> <%}%>
		<%if(end_hh!=0 && !endZero.equals("0")){%> <%=end_hh%>:<%=endZero%> <%}%>						
	</td>				
	<td  style="padding:0 0 0 0" align="center" class="tFont" rowspan="2">
		<%if(comment.equals(".")){%>&nbsp;
		<%}else{%><%=comment%><%}%>
	</td>
	<td  style="padding:0 0 0 0" align="center" class="tFont" rowspan="2">
<%
	memSign=manager.getDbMseq(sign_ok_mseq);
	if(memSign!=null){
	 if(sign_ok_mseq !=0){			
	%>
		
		<%if(sign_ok==2 ){%>
			<%if(!memSign.getMimg().equals("no")){%>
				<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
			<%}else{%><font color="#007AC3"><%=memSign.getNm()%></font><br>はんこ無し<%}%>
		<%}%>
		<%if(sign_ok==1 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><font color="#FF6600">未決</font><%}%> 
		<%if(sign_ok==3 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><font color="#BA7474">返還</font><%}%> 
	<%}}else{%>
		&nbsp;			
	<%}%>	
	</td>			
</tr>				
<tr>
	<td   style="padding:0 0 0 0" align="center" width="10%"  colspan="2" class="tFont">
	<%if(riyu !=null){%>	<%=riyu%>
	<%}else{%>&nbsp;<%}%>					
	</td>				
	
<%}else{%>
	<tr align="center">
	<%if(dispDay <10){%>
			<td width="5" style="padding:0 0 0 10"  align="right" class="tFont"><%=dispDay%></td>	
	<%}else{%>
			<td width="5" style="padding:0 0 0 5"  align="right"class="tFont" ><%=dispDay%></td>	
	<%}%>					
			<%if(d==1){%><td width="5" align="center"   style="padding:0 0 0 5" bgcolor="#FFC286" class="tFont">日<%}%>
			<%if(d==2){%><td width="5" align="center"   style="padding:0 0 0 5"  bgcolor="<%=bgCol%>" class="tFont">月<%}%>
			<%if(d==3){%><td width="5" align="center"   style="padding:0 0 0 5" bgcolor="<%=bgCol%>" class="tFont">火<%}%>
			<%if(d==4){%><td  width="5" align="center"   style="padding:0 0 0 5" bgcolor="<%=bgCol%>" class="tFont">水<%}%>
			<%if(d==5){%><td  width="5" align="center"   style="padding:0 0 0 5" bgcolor="<%=bgCol%>" class="tFont">木<%}%>
			<%if(d==6){%><td  width="5" align="center"   style="padding:0 0 0 5"  bgcolor="<%=bgCol%>" class="tFont">金<%}%>
			<%if(d==7){%><td  width="5" align="center"   style="padding:0 0 0 5" bgcolor="#FFC286" class="tFont" >土<%}%></td>
				<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" >		
					<%if(jobTimeKubun.equals("holi")){%> 
						&nbsp; 
					<%}else if(jobTimeKubun.equals("day") && seq !=0){%>
						<%=totalValueHH_s%>:<%if(totalValueMM_s==0){%><%=totalValueMM_s%>0<%}else{%><%=totalValueMM_s%><%}%> 		
					<%}else{%>	
						&nbsp; 
					<%}%>
				</td>			
				<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColKyu%>" class="tFont" >
					<%if(jobTimeKubun.equals("day")){%> 
						&nbsp; 
					<%}else if(jobTimeKubun.equals("holi") && seq !=0 ){%>
						<%=dbb.getHoliday_hh()%>:<%if(dbb.getHoliday_mm()==0){%><%=dbb.getHoliday_mm()%>0<%}else{%><%=dbb.getHoliday_mm()%><%}%> 		
					<%}else{%>	
						&nbsp; 
					<%}%>						
				</td>
				<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" >
					<%if(oneday_holi.equals("0")){%> &nbsp;
					<%}else if(!oneday_holi.equals("0") && oneday_holi !=null){%><%=oneday_holi%> <%}%>
				</td>	
						
				<%if(!daikyu.equals("0")){%>
						<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" ><%=daikyu%>(<%=daikyu_date%>)</td>					
				<%}else{%>
					 	<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" >&nbsp;</td>
				<%}%>	
				<td  style="padding:0 0 0 0" align="center" bgcolor="<%=bgColElse%>" class="tFont" >
					<%if(chikoku_hh==0 && chikoku_mm==0 ){%>
							&nbsp;			
					<%}else if(chikoku_hh!=0 && chikoku_mm==0){%>
						<%=chikoku_hh%>:<%=chikoku_mm%>0		 
					<%}else if(chikoku_hh==0 && chikoku_mm!=0){%>
						<%=chikoku_hh%>:<%=chikoku_mm%>		
					<%}else{%>	
							&nbsp;
					<%}%>		
					
				</td>	
				<td   style="padding:0 0 0 0" align="center" class="tFont">				
					<%if(begin_hh==0 && beginZero.equals("0")){%> &nbsp; <%}%>
					<%if(begin_hh==0 && !beginZero.equals("0")){%> 0:<%=beginZero%> <%}%>
					<%if(begin_hh !=0 && !beginZero.equals("0")){%> <%=begin_hh%>:<%=beginZero%> <%}%>
				</td>					
				<td   style="padding:0 0 0 0" align="center" class="tFont">
					<%if(end_hh==0 && endZero.equals("0")){%> &nbsp; <%}%>
					<%if(end_hh==0 && !endZero.equals("0")){%> 0:<%=endZero%> <%}%>
					<%if(end_hh!=0 && !endZero.equals("0")){%> <%=end_hh%>:<%=endZero%> <%}%>						
				</td>											
				<td  style="padding:0 0 0 0" align="center" class="tFont" >
					<%if(comment.equals(".")){%>&nbsp;
					<%}else{%><%=comment%><%}%>
				</td>
				<td  style="padding:0 0 0 0" align="center" class="tFont" >
			<%
				memSign=manager.getDbMseq(sign_ok_mseq);
				if(memSign!=null){
				 if(sign_ok_mseq !=0){			
				%>
					
					<%if(sign_ok==2 ){%>
						<%if(!memSign.getMimg().equals("no")){%>
							<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
						<%}else{%><font color="#007AC3"><%=memSign.getNm()%></font><br>はんこ無し<%}%>
					<%}%>
					<%if(sign_ok==1 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><font color="#FF6600">未決</font><%}%> 
					<%if(sign_ok==3 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><font color="#BA7474">返還</font><%}%> 
				<%}}else{%>
					&nbsp;			
				<%}%>	
				</td>			
										
<%}%>		
																	
<%	count += 1;
	dispDay += 1;
				}				
			}

       } 
%>
  	
 </tr> 	
<% 
}
%>		
	

<!--***End-->					
						
</tr>
<tr  align=center  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="calendar5" colspan="2" >&nbsp;</td>
	<td align="center" class="calendar5" >
	<%if(!id.equals("candy")){%>	
		<%=sum01_int/60%>:<%if(sum01_int%60==0){%><%=sum01_int%60%>0<%}else{%><%=sum01_int%60%><%}%> 
	<%}else if(id.equals("candy")){%>
		0:00
	<%}%>
	
	</td>
	<td align="center" class="calendar5">
	<%if(!id.equals("candy")){%>		
		<%=sum02_int/60%>:<%if(sum02_int%60==0){%><%=sum02_int%60 %>0<%}else{%><%=sum02_int%60%><%}%>
	<%}else if(id.equals("candy")){%>
		0:00
	<%}%>
	</td>
	<td align="center" class="calendar5">&nbsp;</td>
	<td align="center" class="calendar5">&nbsp;</td>
	<td align="center" class="calendar5"><%=sum03_int/60%>:<%if(sum03_int%60==0){%><%=sum03_int%60 %>0<%}else{%><%=sum03_int%60%><%}%></td>
	<td align="center" class="calendar5">&nbsp;</td>
	<td align="center" class="calendar5">&nbsp;</td>
	<td align="center" class="calendar5">&nbsp;</td>
	<td align="center" class="calendar5">&nbsp;</td>	
</tr>

</table>	
</form>
	</td>
	</tr>
	<tr>
		<td>
			<table width="100%"  border=0 >
				<tr>
					<td align="center" style="padding: 2 0 1 0">
<!--*******>
<input type=button value="プレビュー" onclick="window.ieExecWB(7)"　onMouseOver="手動的操作：マウスを画面の上に置き、マウスの右をクリックし==>(N)をクリック"> 
<input type=button value="印刷する" onclick="printa();">
<input type=button value="閉じる" onclick="javascript:window.close();">
<********-->	
<a href="javascript:window.ieExecWB(7)"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintPreview.gif" align="absmiddle" title="手動的操作：マウスを画面の上に置き、マウスの右をクリックし==>(N)をクリック"></a>	
<a href="javascript:printa();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintBogoForm.gif" align="absmiddle"></a>
<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/xBogoForm.gif" align="absmiddle"></a>
					</td>							
				</tr>		
			</table>
		</td>
	</tr>
</table>
</body>	
</html>
	
	
	
	
	
	
	
