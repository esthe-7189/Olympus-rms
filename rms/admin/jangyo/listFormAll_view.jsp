<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.jangyo.DataBeanJangyo" %>
<%@ page import = "mira.jangyo.DataMgrJangyo" %>
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
int mseq=0; int level=0; int posiLevel=0; String busho="";
//String hour_hh=""; String minute_hh="";
int totalValueHH_s=0; int totalValueMM_s;

String inDate=dateFormat.format(new java.util.Date());		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");
String bushopg=request.getParameter("bushopg");
if(id.equals("candy")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
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
		 busho=member.getBusho();
		 posiLevel=member.getPosition_level();
	}	
	if(bushopg==null){bushopg="1";}

	int endsum=0; int startsum=0; int seqsum=0;
	int endsum2=0; int startsum2=0; int seqsum2=0;
	
	String mgrYM=inDate.substring(0,7);  //0000-00	
	String mgrYyyy=inDate.substring(0,4);
	String mgrMmmm=inDate.substring(5,7);
	if(mmVal !=null){
		mgrYM=yyVal+"-"+mmVal;
		mgrMmmm=mmVal;
	}
	int mgrYyyyInt=Integer.parseInt(mgrYyyy);
	int mgrMmmmInt=Integer.parseInt(mgrMmmm);
	
	String bushoVal="";
	 if(id.equals("moriyama") || id.equals("juc0318") || id.equals("hashi")  ||  id.equals("admin")){	
		 bushoVal=bushopg;	
	}else{
		bushoVal=busho;
	}	
	
	
	DataMgrJangyo mgr = DataMgrJangyo.getInstance();		
	int totalValueHH=0;
	int totalValueMM=0;
//	int totalValueHH2=0;
//	int totalValueMM2=0;
			
//	String yymmddVal=inDate.substring(0,10); //0000-00-00
	List listDay=mgr.listYMD(mgrYM,bushoVal);	
	List listMseq;	
	List listSign=manager.selectListSchedule(1,4);
	Member memSign;
%>
<c:set var="listDay" value="<%= listDay %>" />	
<c:set var="listSign" value="<%= listSign %>" />				
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">
	<% if(bushoVal.equals("1")){%>(企画部) 部署残業リスト<%}%>
	<% if(bushoVal.equals("2")){%>(事業統括部) 部署残業リスト<%}%>
	<% if(bushoVal.equals("3")){%>(開発部) 部署残業リスト<%}%>						
	<% if(bushoVal.equals("4")){%>(製造部) 部署残業リスト<%}%>	
	<% if(bushoVal.equals("5")){%>(品質保証部) 部署残業リスト<%}%>	
	<% if(bushoVal.equals("6")){%>(臨床開発部) 部署残業リスト<%}%>	
	<% if(bushoVal.equals("7")){%>(安全管理部) 部署残業リスト<%}%>	
	<% if(bushoVal.equals("8")){%>(その他) 部署残業リスト<%}%>	
	</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
		<%if(id.equals("moriyama") || id.equals("juc0318") || id.equals("hashi") || id.equals("admin")){%>			  
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="企画部" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=1'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="事業統括部" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=2'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="開発部" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=3'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="製造部" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=4'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="品質保証部" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=5'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="臨床開発部" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=6'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="安全管理部" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=7'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="その他" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=8'">
					
				
				
		<%}%>		
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="私の残業申請管理表" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listForm.jsp'">											
</div>
<div id="boxNoLineBig"  >			
<table width="97%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">		
<form name="search2"  action="<%=urlPage%>rms/admin/jangyo/listFormAll.jsp" method="post">			
	<input type="hidden" name="yyVal" value="">	
	<input type="hidden" name="mmVal" value="">	
	<input type="hidden" name="bushopg" value="">	
	<tr>
		<td width="10%"  valign="bottom"  style="padding:2px 0px 2px 3px;" class="calendar5_01">
			<%if(yyVal==null){%><%=mgrYM%> <%}%>
			<%if(yyVal!=null){%><%=yyVal%>-<%=mmVal%> <%}%>月
		</td>		
		<td width="90%"  valign="bottom"  style="padding:2px 20px 2px 0px;">
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="year_sch" class="select_type3" >
	<%	for(int i=2009;i<=mgrYyyyInt;i++){%>			            							
					<option value="<%=i%>" <%if(i==mgrYyyyInt){%>selected <%}%>><%=i%></option>
	<%}%>																			
				  </select>年 
			</div>
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">							
				  <select name="menths_sch" class="select_type3"  onChange="return doSubmitOnEnter(<%=bushoVal%>);">
				  	<option value="01" <%if(yyVal==null){if(1==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(1==mgrMmmmInt){%>selected <%}}%>>1</option>
				  		<option value="02" <%if(yyVal==null){if(2==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(2==mgrMmmmInt){%>selected <%}}%>>2</option>
				  		<option value="03" <%if(yyVal==null){if(3==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(3==mgrMmmmInt){%>selected <%}}%>>3</option>
				  		<option value="04" <%if(yyVal==null){if(4==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(4==mgrMmmmInt){%>selected <%}}%>>4</option>
				  		<option value="05" <%if(yyVal==null){if(5==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(5==mgrMmmmInt){%>selected <%}}%>>5</option>
				  		<option value="06" <%if(yyVal==null){if(6==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(6==mgrMmmmInt){%>selected <%}}%>>6</option>
				  		<option value="07" <%if(yyVal==null){if(7==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(7==mgrMmmmInt){%>selected <%}}%>>7</option>
				  		<option value="08" <%if(yyVal==null){if(8==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(8==mgrMmmmInt){%>selected <%}}%>>8</option>
				  		<option value="09" <%if(yyVal==null){if(9==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(9==mgrMmmmInt){%>selected <%}}%>>9</option>
				  		<option value="10" <%if(yyVal==null){if(10==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(10==mgrMmmmInt){%>selected <%}}%>>10</option>
				  		<option value="11" <%if(yyVal==null){if(11==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(11==mgrMmmmInt){%>selected <%}}%>>11</option>
				  		<option value="12" <%if(yyVal==null){if(12==mgrMmmmInt){%>selected <%}}if(yyVal!=null){if(12==mgrMmmmInt){%>selected <%}}%>>12</option>				  									
				  </select>月
			</div>					 
		</td>			
	</tr>
	</form>			
</table>

<!--**********금월 리스트 begin  -->	
<table width="97%" border=1 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
<form name="frm02" method="post" >
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	<input type="hidden" name="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
<tr bgcolor=#F1F1F1 align=center height=26>	    
	<td  align="center" width="10%">日付(残業)</td> 	
	<td  align="center" width="10%">申請者</td> 
	<td  align="center" width="18%">登録日</td> 
	<td  align="center" width="15%">残業申請時間</td>		 
	<td  align="center" width="22%">残業理由及び内容</td> 
	<td  align="center" width="15%">備考</td>
	<td  align="center" width="10%">印</td>	
</tr>
<c:if test="${empty listDay}">
	<tr>
		<td colspan="7">NO DATA</td>
	</tr>
</c:if>				
<c:if test="${! empty listDay}">	<!----bean에서 hizuke를 sign_no_riyu로 사용했음 ---dbDay.getSign_no_riyu()-------->
<%
	int i=1; int beginvalMseqAll=0;
			 int endvalMseqAll=0;
			 int seqcntMseqAll=0; 						 
			 int totalValueHhMseqAll=0;
			 int totalValueMmMseqAll=0;				 	 
			 
		Iterator listiter=listDay.iterator();					
				while (listiter.hasNext()){
					DataBeanJangyo dbDay=(DataBeanJangyo)listiter.next();										
					listMseq=mgr.listMseq(dbDay.getHizuke(),bushoVal);				
					
					//직원 토탈 잔업시간
					DataBeanJangyo janup=mgr.getSumYmdMseq(dbDay.getHizuke(),bushoVal);					
						 beginvalMseqAll=janup.getBeginval();
						 endvalMseqAll=janup.getEndval();
						 seqcntMseqAll=janup.getSeqcnt(); 	
						 					 
						 totalValueHhMseqAll=(endvalMseqAll-beginvalMseqAll)/60;						 	
						 totalValueMmMseqAll=(endvalMseqAll-beginvalMseqAll)%60;
							
						endsum +=endvalMseqAll;
						startsum +=beginvalMseqAll;
						seqsum +=seqcntMseqAll;
															
												
%>
<tr >	
	<td align="center"><%=dbDay.getSign_no_riyu()%></td>	
	<td colspan="6" width=100%>
		<table width=100% border=0 cellpadding=0 cellspacing=0 >			
<c:set var="listMseq" value="<%= listMseq %>" />		
		<c:if test="${empty listMseq}">
			<tr>
				<td colspan="6">NO DATA,,,,,</td>
			</tr>
		</c:if>				
		<c:if test="${! empty listMseq}">	
		<% 
			int ii=1;	
				
				Iterator listiter2=listMseq.iterator();					
						while (listiter2.hasNext()){
							DataBeanJangyo dbb=(DataBeanJangyo)listiter2.next();
							int beginval_s=dbb.getBeginval();  //시작한 분계산
							int endval_s=dbb.getEndval();	 //끝난 분계산				
							    totalValueHH_s=(endval_s-beginval_s)/60;								
							    totalValueMM_s=(endval_s-beginval_s)%60;
							    
							    endsum2 +=totalValueHH_s;
								startsum2 +=totalValueMM_s;
							//	seqsum2 +=seqcntMseqAll;							
								
							String ymdhY=timeFormat.format(dbb.getRegister()).substring(0,4);
							String ymdhM=timeFormat.format(dbb.getRegister()).substring(4,6);
							String ymdhD=timeFormat.format(dbb.getRegister()).substring(6,8);
							String ymdhH=timeFormat.format(dbb.getRegister()).substring(8,15);																			
														
		%>
	<!-- 직원출력 시작*********************-->
			<tr align=center height="25" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">				
				<td align="left" width="11%"  style="padding:0px 0px 0px 2px;"><img src="<%=urlPage%>rms/image/ion_img01.gif" align="absmiddle"> <%=dbb.getNm()%></td>
				<td  width="20%"><%=ymdhY%>-<%=ymdhM%>-<%=ymdhD%>(<%=ymdhH%>)</td>
				<td  width="17%"><font color="#339900"><%=dbb.getBegin_hh()%>:<%=dbb.getBegin_mm()%>～<%=dbb.getEnd_hh()%>:<%=dbb.getEnd_mm()%></font>   (<%=totalValueHH_s%>:<%=totalValueMM_s%>)</td>				
				<td align="left" width="24%"><%=dbb.getRiyu()%></td>
				<td align="left" width="17%"><%=dbb.getComment()%></td>	
				<td  width="11%">
<%
	memSign=manager.getDbMseq(dbb.getSign_ok_mseq());
	if(memSign!=null){
	 if(dbb.getSign_ok_mseq() !=0){			
	%>
		
		<%if(dbb.getSign_ok()==2 ){%>
			<%if(!memSign.getMimg().equals("no")){%>
				<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
			<%}else{%><font color="#007AC3"><%=memSign.getNm()%></font><br>決裁済<%}%>
		<%}%>
		<%if(dbb.getSign_ok()==1 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="決裁中"><%}%> 
		<%if(dbb.getSign_ok()==3 ){%><font color="#007AC3"><%=memSign.getNm()%></font><br><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:<%=dbb.getSign_no_riyu()%>"><%}%> 
	<%}}else{%>--
	<%}%>			
				</td>					
			</tr>
			<tr><td background="<%=urlPage%>rms/image/dot_line_all.gif" colspan="10"></td></tr>											
<!-- 직원출력 끝*********************-->								
<% ii++; } 

//	totalValueHH2=(endsum2-startsum2)/60;
//	totalValueMM2=(endsum2-startsum2)%60;
	
%>
			<tr bgcolor=#F1F1F1>
				<td align="center" class="calendar1_3">-</td>
				<td align="center" class="calendar3">-</td>
				<td align="center" class="calendar3">-</td>				
				<td align="center" class="calendar3">-</td>
				<td align="center" class="calendar3">-</td>	
				<td align="center" class="calendar3">-</td>							
			</tr>
			</c:if>
		</table>
	</td>
</tr>
<%i++;}
		totalValueHH=(endsum-startsum)/60;
		totalValueMM=(endsum-startsum)%60;																					
%>		
	<tr bgcolor=#F1F1F1 align=center height=26 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">今月残業回数 :  <%=seqsum%></td>	
	<td align="center" class="calendar5">今月残業総時間  <%=totalValueHH%>:<%=totalValueMM%></td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	
</tr>
</c:if>
</table>
</form>
</div>	
	
	
<script language="javascript">
function doSubmitOnEnter(pg){
	var frm=document.search2;
	frm.yyVal.value=frm.year_sch.value;
	frm.mmVal.value=frm.menths_sch.value;
	frm.bushopg.value=pg;
	frm.action = "<%=urlPage%>rms/admin/jangyo/listFormAll.jsp";	
	frm.submit();
}
</script>	 			
			
			
			
			
	
	
	
	
	
	
