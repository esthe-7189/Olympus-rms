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
String title = ""; String name=""; String mailadd=""; String pass=""; int mseq=0; int level=0;
String inDate=dateFormat.format(new java.util.Date());		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />
	</jsp:forward>
<%
	}
//page권한
int pageArrow=0; int pageMseq=0;
if(id.equals("togawa") || id.equals("juc0318") || id.equals("admin") || id.equals("hamano") ||  id.equals("funakubo") ||
	 id.equals("kubota") || id.equals("kira") || id.equals("saito") || id.equals("sugita")  || id.equals("matsu") ||
	 id.equals("ichimura") || id.equals("mine") || id.equals("hashi") || id.equals("okubo")){ pageArrow=1; }else{pageArrow=2;}	


	//달력보기 시작
  String format="yyyy-MM-dd"; int changeDate =1;
  String m_week="";   

  Calendar calen=Calendar.getInstance();   Date date02 =calen.getTime();  Calendar cal = new GregorianCalendar(); cal.setTime(date02);    
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
	}	

	int endsum=0; int startsum=0; int seqsum=0;
	
	String mgrYM=inDate.substring(0,7);  //0000-00	
	String mgrYyyy=inDate.substring(0,4);
	String mgrMmmm=inDate.substring(5,7);
	if(mmVal !=null){
		mgrYM=yyVal+"-"+mmVal;
		mgrMmmm=mmVal;
	}
	int mgrYyyyInt=Integer.parseInt(mgrYyyy);
	int mgrMmmmInt=Integer.parseInt(mgrMmmm);
		
	DataMgrKintai mgr = DataMgrKintai.getInstance();		
	int totalValueHH=0;
	int totalValueMM=0;
			
//	String yymmddVal=inDate.substring(0,10); //0000-00-00
	List listDay=mgr.listYMD(mgrYM,mseq,pageArrow);	
	List listMseq;	
	List listSign=manager.selectListSchedule(1,3);
	Member memSign;
%>
<c:set var="listDay" value="<%= listDay %>" />	
<c:set var="listSign" value="<%= listSign %>" />		
<c:set var="member" value="<%= member %>" />		
	
<style type="text/css">	input.calendarkin { behavior:url(calendarMoveTotal.htc); } </style>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">部署出勤リスト</span> 
<div class="clear_line_gray"></div>
<p>	
<div id="boxNoLineBig"  >	
<table width="97%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
<form name="search2"  action="<%=urlPage%>rms/admin/kintai/listFormAll.jsp" method="post">			
	<input type="hidden" name="yyVal" value="">	
	<input type="hidden" name="mmVal" value="">	
	<tr>
		<td width="10%"  valign="bottom"  style="padding:2px 0px 2px 20px;" class="calendar5_01">
		<%if(yyVal==null){%><%=mgrYM%> <%}%>
		<%if(yyVal!=null){%><%=yyVal%>-<%=mmVal%> <%}%>月	
		</td>		
		<td width="30%"  valign="bottom"  style="padding:2px 0px 2px 10px;">				
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="year_sch" class="select_type3" >
				  	  <option value="0" >0000</option>
	<%	for(int i=2009;i<=mgrYyyyInt;i++){%>
					<%if(i==mgrYyyyInt){%>
						<option value="<%=i%>"  selected><%=i%></option>
					 <%}else{%> 			            							
						<option value="<%=i%>"  ><%=i%></option>
					<%}%>
	<%}%>																			
				  </select>年 
			</div>
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">							
				  <select name="menths_sch" class="select_type3"  onChange="return doSubmitYM();">
				  	  	<option value="0" >00</option>
				  		<option value="01" >1</option>
				  		<option value="02" >2</option>
				  		<option value="03" >3</option>
				  		<option value="04" >4</option>
				  		<option value="05" >5</option>
				  		<option value="06" >6</option>
				  		<option value="07" >7</option>
				  		<option value="08" >8</option>
				  		<option value="09" >9</option>
				  		<option value="10" >10</option>
				  		<option value="11" >11</option>
				  		<option value="12" >12</option>				  									
				  </select>月
			</div>		
			<input type="hidden" size="12%" name='yymmMove' class=calendarkin value="" style="text-align:center">
		</td>			
		<td width="60%"style="padding: 0px 5px 0px 5px" align="right">			
				<img src="<%=urlPage%>rms/image/admin/tokei_small.gif" align="absmiddle"><font color="#807265">==></font>登録日 &nbsp;
				<img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle"><font color="#807265">==></font>日付及びメモ&nbsp;	
							
	<%if(id.equals("togawa") || id.equals("juc0318") || id.equals("admin") || id.equals("hamano") || id.equals("funakubo") || 
		id.equals("kubota") || id.equals("kira") || id.equals("saito") || id.equals("sugita") || 
		id.equals("matsu") || id.equals("ichimura") || id.equals("mine") || id.equals("hashi") || id.equals("okubo")){%>			
		
				<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle"  title="Print">																
				  <select name="printall"  onChange="return doSubmitOnEnter('<%=mgrYM%>');"  >
				  	<option value="0">::::::選択する:::::</option>
				<!--<option value="biofloc">李　恩永</option>				
				<option value="hazama">間　靖子</option>-->
					<option value="komatsu">小松　希</option>
					<option value="udah">宇田　温菜</option>									
				  </select>
			
	<%}%>			
	    		
	    </td>	
	 </tr>											
</form>						  
</table>

<!--**********금월 리스트 begin  -->	
<table width="97%"  class="tablebox_list" cellpadding="1" cellspacing="1" >
<form name="frm02" action="<%=urlPage%>rms/admin/kintai/insert.jsp" method="post" >
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	<input type="hidden" name="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
<tr bgcolor=#E9FEEA align=center >	
    <td  align="center" width="6%" class="title_list_m_r">日付 </td>
    <td  align="center" width="7%" class="title_list_m_r">氏名</td>
    <td  align="center" width="5%" class="title_list_m_r">普通残業<br>FT過不足</td>   
    <td  align="center" width="10%" class="title_list_m_r">休日出勤</td>
    <td  align="center" width="7%" class="title_list_m_r">休暇</td>
    <td  align="center" width="7%" class="title_list_m_r">代休取得</td>
    <td  align="center" width="7%" class="title_list_m_r">遅刻・早退・<br>外出時間</td> 
    <td  align="center" width="15%" class="title_list_m_r">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1">
			<tr bgcolor=#E9FEEA align=center height=20>	
				<td  align="center" class="line_gray_bottomnright">始業時間</td>
				<td  align="center" class="line_gray_bottom">終業時間</td>
			</tr>			
			<tr height=2 bgcolor=#E9FEEA style=color:#336699;>
				<td align="center" colspan="2">理由</td>					
			</tr>
		</table>	
	</td>	
	<td  align="center" width="8%" class="title_list_m_r">備考</td>
	<td  align="center" width="5%" class="title_list_m">印</td>	
</tr>
<c:if test="${empty listDay}">
	<tr>
		<td colspan="10" class="clear_dot">NO DATA</td>
	</tr>
</c:if>				
<c:if test="${! empty listDay}">	
<%
	int i=1; int seqcntMseqAll=0;	int totalValueHhMseqAll=0; int totalValueMmMseqAll=0; String ymdList=""; String yyHori=""; String mmHori="";  String ddHori="";
	int totalsum2=0; //대계 근무시간
	int totalsumMonth=0;  //소계 근무시간 대체 사용
	int totalKyusumMonth=0; //대계 휴일근무
	int totalKyusum2=0; //소계 휴일근무 
	int chikokuTimeMonth=0;
	int chikokuTime2=0;	
	
	
		Iterator listiter=listDay.iterator();					
				while (listiter.hasNext()){
					DataBeanKintai dbDay=(DataBeanKintai)listiter.next();					
					listMseq=mgr.listMseq(dbDay.getHizuke(),mseq,pageArrow);
					//요일
				//	DataBeanKintai week=mgr.getDbypbi(dbDay.getHizuke());
					
					//직원 토탈 잔업시간
					DataBeanKintai janup=mgr.getSumYmdMseq(dbDay.getHizuke());
								 												
						String hizukeYoubi=dbDay.getDaikyu().substring(11,12);
						String yyCol=dbDay.getDaikyu().substring(0,4);
						String mmCol=dbDay.getDaikyu().substring(5,7);
						String ddCol=dbDay.getDaikyu().substring(8,10);
												
%>
<tr>
	<td align="center" class="line_gray_bottomnright">
<%
	DataMgr mgrHori = DataMgr.getInstance();	
//*************************매년 틀린 휴일 start***********************
					
	DataBean beanHori=mgrHori.getHoriday(yyCol+"-"+mmCol+"-"+ddCol);
	DataBean beanHori2=mgrHori.getHoriday("0000-"+mmCol+"-"+ddCol);
	if(beanHori !=null && beanHori2 ==null){		
		yyHori=beanHori.getDuring_begin().substring(0,4); 
		mmHori=beanHori.getDuring_begin().substring(5,7); 
		ddHori=beanHori.getDuring_begin().substring(8,10); 	
				
	}else if(beanHori ==null && beanHori2 !=null){
		yyHori=beanHori2.getDuring_begin().substring(0,4); 
		mmHori=beanHori2.getDuring_begin().substring(5,7); 
		ddHori=beanHori2.getDuring_begin().substring(8,10); 	
	}else if(beanHori ==null && beanHori2 ==null){
		yyHori="0000"; 
		mmHori="00"; 
		ddHori="00"; 
	}						
	if(hizukeYoubi.equals("日") || hizukeYoubi.equals("土") || yyCol.equals(yyHori) && mmCol.equals(mmHori) && ddCol.equals(ddHori) || mmCol.equals(mmHori) && ddCol.equals(ddHori)){%>	
		<font color="red"><%=dbDay.getDaikyu()%></font>
	<%}else{%><%=dbDay.getDaikyu()%><%}%>	
	</td>
	<td colspan="10" width=100% class="clear_dot">
		<table width=100%  >
			<tr align=center >
<c:set var="listMseq" value="<%= listMseq %>" />		
		<c:if test="${empty listMseq}">
			<tr>
				<td colspan="10">NO DATA</td>
			</tr>
		</c:if>				
		<c:if test="${! empty listMseq}">	
		<% 
		int ii=1;String beginZero=""; String endZero=""; int totalValueHH_s=0; int totalValueMM_s=0;  
		int totalsum=0;int jangyoPast495=0; int jangyoPast595=0;
		int totalKyuHH_s=0; int totalKyuMM_s=0; int totalKyusum=0; int chikokuTime=0;int totalChikokuTime=0;
		String jobTimeKubun="day"; String onedayVal="";			
				Iterator listiter2=listMseq.iterator();					
						while (listiter2.hasNext()){
							DataBeanKintai dbb=(DataBeanKintai)listiter2.next();
							int beginval_s=dbb.getBeginval();  //시작한 분계산
							int endval_s=dbb.getEndval();	 //끝난 분계산
							int horiTotal=(dbb.getHoliday_hh()*60)+dbb.getHoliday_mm(); 	 //휴일출근 수작업	
							
							chikokuTime=(dbb.getChikoku_hh()*60)+dbb.getChikoku_mm();
											
							jangyoPast495=endval_s-beginval_s-495;				
							jangyoPast595=endval_s-beginval_s-525;							
							if(dbb.getOneday_holi().equals("0") || dbb.getOneday_holi().equals("早退")){
								onedayVal="full";
							}
							
						// 잔교시 휴식 15분	
						
			if(hizukeYoubi.equals("日") || hizukeYoubi.equals("土") || yyCol.equals(yyHori) && mmCol.equals(mmHori) && ddCol.equals(ddHori) || mmCol.equals(mmHori) && ddCol.equals(ddHori)){							
					jobTimeKubun	="holi";
					if(dbb.getEm_number().equals("010") && onedayVal.equals("full") && dbb.getDaikyu().equals("0")){	
					//	totalKyuHH_s=(endval_s-beginval_s-chikokuTime)/60;
					//	totalKyuMM_s=(endval_s-beginval_s-chikokuTime)%60;	
						totalKyusum +=(horiTotal-chikokuTime);
						totalChikokuTime +=chikokuTime;						
					}else if(!dbb.getEm_number().equals("010") && onedayVal.equals("full") && dbb.getDaikyu().equals("0")){				
					//	totalKyuHH_s=(endval_s-beginval_s-chikokuTime)/60;
					//	totalKyuMM_s=(endval_s-beginval_s-chikokuTime)%60;	
						totalKyusum +=(horiTotal-chikokuTime);	
						totalChikokuTime +=chikokuTime;								
					}
			}else{
					if(jangyoPast495 <=0 && dbb.getEm_number().equals("010") && onedayVal.equals("full") && dbb.getDaikyu().equals("0")){
						totalValueHH_s=(endval_s-beginval_s-495-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-495-chikokuTime)%60;	
						totalsum +=(endval_s-beginval_s-495-chikokuTime);	
						totalChikokuTime +=chikokuTime;						
					}else if(jangyoPast495 >0 && dbb.getEm_number().equals("010") && onedayVal.equals("full") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-510-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-510-chikokuTime)%60;
						totalsum += (endval_s-beginval_s-510-chikokuTime);
						totalChikokuTime +=chikokuTime;	
						
					}else if(jangyoPast595 <=0 && !dbb.getEm_number().equals("010") && onedayVal.equals("full") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-525-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-525-chikokuTime)%60;	
						totalsum +=(endval_s-beginval_s-525-chikokuTime);
						totalChikokuTime +=chikokuTime;	
						
					}else if(jangyoPast595 >0 && !dbb.getEm_number().equals("010") && onedayVal.equals("full") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-540-chikokuTime)/60;  
						totalValueMM_s=(endval_s-beginval_s-540-chikokuTime)%60;	
						totalsum +=(endval_s-beginval_s-540-chikokuTime);	
						totalChikokuTime +=chikokuTime;						
					}
		}
							totalsumMonth =totalsum;	
							totalKyusumMonth=totalKyusum;
							chikokuTimeMonth=totalChikokuTime;
							
																	
							String ymdhY=timeFormat.format(dbb.getRegister()).substring(0,4);
							String ymdhM=timeFormat.format(dbb.getRegister()).substring(4,6);
							String ymdhD=timeFormat.format(dbb.getRegister()).substring(6,8);
							String ymdhH=timeFormat.format(dbb.getRegister()).substring(8,15);	
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
																									
														
		%>
	<!-- 직원출력 시작*********************-->
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
				<td width="7%"  style="padding:0 0 0 2;" class="clear_dot"><img src="<%=urlPage%>rms/image/ion_img01.gif" align="absmiddle"> <%=dbb.getNm()%>
					<img src="<%=urlPage%>rms/image/admin/tokei_small.gif" align="absmiddle" alt="登録日:<%=ymdhY%>-<%=ymdhM%>-<%=ymdhD%>(<%=ymdhH%>)" title="登録日:<%=ymdhY%>-<%=ymdhM%>-<%=ymdhD%>(<%=ymdhH%>)"  style="CURSOR: pointer;">			
				</td>
				<td align="center" width="5%" class="clear_dot">
					<%if(jobTimeKubun.equals("day")){%>	
							<%if(onedayVal.equals("full") && dbb.getDaikyu().equals("0")){%>
									<%=totalValueHH_s%>:<%if(totalValueMM_s==0){%><%=totalValueMM_s%>0<%}else{%><%=totalValueMM_s%><%}%> 					
							<%}else if(onedayVal.equals("full") && !dbb.getDaikyu().equals("0")){%>
									&nbsp;					
							<%}else if(!onedayVal.equals("full") && dbb.getDaikyu().equals("0")){%>
									&nbsp;					
							<%}else{%>
									 &nbsp;		 
							<%}%>										
					<%}else{%>
							&nbsp;	
					<%}%>
				</td>				
				<td align="center" width="10%" class="clear_dot">
					<%if(jobTimeKubun.equals("holi")){%>	
							<%if(onedayVal.equals("full") && dbb.getDaikyu().equals("0")){%>
									<%=dbb.getHoliday_hh()%>:<%if(dbb.getHoliday_mm()==0){%><%=dbb.getHoliday_mm()%>0<%}else{%><%=dbb.getHoliday_mm()%><%}%>					
							<%}else if(onedayVal.equals("full") && !dbb.getDaikyu().equals("0")){%>
									&nbsp;					
							<%}else if(!onedayVal.equals("full") && dbb.getDaikyu().equals("0")){%>
									&nbsp;					
							<%}else{%>
									 &nbsp;		 
							<%}%>												
					<%}else{%>
							&nbsp;	
					<%}%>				
				</td>
				<td align="center" width="7%" class="clear_dot">
					<%if(!dbb.getOneday_holi().equals("0")){%>
							<%=dbb.getOneday_holi()%>					
					<%}else{%>
						 -
					<%}%>
				</td>
										
					<%if(!dbb.getDaikyu().equals("0")){%>
							<td align="center" title="<%=dbb.getDaikyu_date()%>" width="7%" class="clear_dot"><%=dbb.getDaikyu()%>
								<img style="CURSOR: pointer;" src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle">
							</td>					
					<%}else{%>
						 <td align="center" width="7%" class="clear_dot">-</td>
					<%}%>
				
				<td align="center" width="7%" class="clear_dot">
					<%if(dbb.getChikoku_hh()==0 && dbb.getChikoku_mm()==0){%>
							&nbsp;			
					<%}else if(dbb.getChikoku_hh()!=0 && dbb.getChikoku_mm()==0){%>
						<%=dbb.getChikoku_hh()%>:<%=dbb.getChikoku_mm()%>0		 
					<%}else if(dbb.getChikoku_hh()==0 && dbb.getChikoku_mm()!=0){%>
						<%=dbb.getChikoku_hh()%>:<%=dbb.getChikoku_mm()%>		 
					<%}else if(dbb.getChikoku_hh()!=0 && dbb.getChikoku_mm()!=0){%>
						<%=dbb.getChikoku_hh()%>:<%=dbb.getChikoku_mm()%>		 
					<%}else{%>		
							&nbsp;
					<%}%>			
					
				</td>
				<td  align="center" width="15%" class="clear_dot">
					<table width=100% class="tablebox_list" >
						<tr align=center >	
							<td  align="center"  class="line_gray_bottomnright"><%=dbb.getBegin_hh()%>:<%=beginZero%></td>
							<td  align="center" class="line_gray_bottom"><%=dbb.getEnd_hh()%>:<%=endZero%></td>
						</tr>			
						<tr height=2 style=color:#336699;>
							<td align="center" colspan="2">
								<%if(dbb.getRiyu() !=null){%>						
										<%=dbb.getRiyu()%>										
								<%}else{%>.<%}%>
							</td>					
						</tr>
					</table>						
				</td>				
				<td align="center" width="8%" class="clear_dot"><%=dbb.getComment()%></td>
				<td align="center" width="5%" class="clear_dot">
<%
	memSign=manager.getDbMseq(dbb.getSign_ok_mseq());
	if(memSign!=null){
	 if(dbb.getSign_ok_mseq() !=0){			
	%>
		
		<%if(dbb.getSign_ok()==2 ){%>
			<%if(!memSign.getMimg().equals("no")){%>
				<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
			<%}else{%><font color="#007AC3"><%=memSign.getNm()%></font><br>はんこ無し<%}%>
		<%}%>
		<%if(dbb.getSign_ok()==1 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><font color="#FF6600">未決</font><%}%> 
		<%if(dbb.getSign_ok()==3 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><font color="#BA7474">差戻し</font><%}%> 
	<%}}else{%>--
	<%}%>			
				</td>					
			</tr>
													
<!-- 직원출력 끝*********************-->								
			<% ii++; } %>
			<tr bgcolor=#F1F1F1>
				<td align="center" class="calendar1_3" >&nbsp;</td>
				<td align="center" class="calendar3"><%=totalsum/60%>:<%if(totalsum%60==0){%><%=totalsum%60%>0<%}else{%><%=totalsum%60%><%}%></td>
				<td align="center" class="calendar3"><%=totalKyusum/60%>:<%if(totalKyusum%60==0){%><%=totalKyusum%60 %>0<%}else{%><%=totalKyusum%60%><%}%></td>
				
				<td align="center" class="calendar3">-</td>
				<td align="center" class="calendar3">-</td>
				<td align="center" class="calendar3"><%=totalChikokuTime/60%>:<%if(totalChikokuTime%60==0){%><%=totalChikokuTime%60 %>0<%}else{%><%=totalChikokuTime%60%><%}%></td>
				<td align="center" class="calendar3">-</td>
				<td align="center" class="calendar3">-</td>
				<td align="center" class="calendar3">.</td>				
			</tr>
			</c:if>
		</table>
	</td>
</tr>				
<%
totalsum2 +=totalsumMonth;	
totalKyusum2 +=totalKyusumMonth;
chikokuTime2 +=chikokuTimeMonth;				
i++;}																			
%>		

	<tr bgcolor=#F1F1F1 align=center height=26 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="calendar1_2">&nbsp;</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">
		<%=totalsum2/60%>:<%if(totalsum2%60==0){%><%=totalsum2%60%>0<%}else{%><%=totalsum2%60%><%}%>	</td>	
	<td align="center" class="calendar5"><%=totalKyusum2/60%>:<%if(totalKyusum2%60==0){%><%=totalKyusum2%60%>0<%}else{%><%=totalKyusum2%60%><%}%></td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">
		<%=chikokuTime2/60%>:<%if(chikokuTime2%60==0){%><%=chikokuTime2%60 %>0<%}else{%><%=chikokuTime2%60%><%}%>
	</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">.</td>
	<td align="center" class="calendar5">-</td>	
</tr>
</c:if>
</table>
</form>
</div>
<script language="javascript">
function doSubmitOnEnter(mgrYM){		
	var id=document.search2.printall.options[document.search2.printall.selectedIndex].value;		
	var arratym=mgrYM.split("-",2);	
	var year=	arratym[0];			
	var month=arratym[1];	
	var param="&mgrYM="+mgrYM+"&month="+month+"&year="+year+"&action=0&id="+id;	
	openScrollWin("<%=urlPage%>rms/admin/kintai/printFormAll.jsp", "出退社", "出退社", "500", "700",param);	
}
function doSubmitYM(){
	var frm=document.search2;
	frm.yyVal.value=frm.year_sch.value;
	frm.mmVal.value=frm.menths_sch.value;
	frm.action = "<%=urlPage%>rms/admin/kintai/listFormAll.jsp";	
	frm.submit();
}
</script>	 
	
	
	
	
	
	
	
	
