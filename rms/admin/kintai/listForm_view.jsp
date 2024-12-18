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
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");

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

	
	String mgrYM=inDate.substring(0,7);
	String mgrYyyy=inDate.substring(0,4);
	String mgrMmmm=inDate.substring(5,7);
	if(mmVal !=null){
		mgrYM=yyVal+"-"+mmVal;
		mgrMmmm=mmVal;
	}
	int mgrYyyyInt=Integer.parseInt(mgrYyyy);
	int mgrMmmmInt=Integer.parseInt(mgrMmmm);			

	DataMgrKintai mgr = DataMgrKintai.getInstance();	
	DataBeanKintai bean=mgr.getSum(mgrYM,mseq);
	int beginval=bean.getBeginval();
	int endval=bean.getEndval();
//출퇴근 시간 (일반인 8시45~17시30분 총 8시간 근무, 점심 45분/  계약직 현재 사원번호 101은 8시15~06시30분 총7시간 30분 근무, 점심 45분 )	
//잔교시 무조건 15분 휴식
		
	List list=mgr.listSchedule(mgrYM,mseq);	
	int levelKubun=0;
	if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
	List listSign=manager.selectJangyo(1,levelKubun,busho); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
	Member memSign;
	
	int totalsum=0;int totalKyusum=0;int totalChikokuTime=0;
%>
	
<c:set var="list" value="<%= list %>" />	
<c:set var="listSign" value="<%= listSign %>" />	
<c:set var="member" value="<%= member %>" />		
<style type="text/css">	input.calendarkin { behavior:url(calendarMove.htc); } </style>	
<script type="text/javascript">
	window.onload = function() {
		StartTime(); 
		EndTime();
	}
	function StartTime() { 
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();							
		if(document.getElementById("emNumber").value=="010"){ 
			document.getElementById("begin_hh").value ="08" ;
			document.getElementById("begin_mm").value ="15" ;
		}else{
			document.getElementById("begin_hh").value ="08" ;
			document.getElementById("begin_mm").value ="45" ;
		}
	}
	function EndTime() {
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();			
		if(document.getElementById("emNumber").value=="010"){
			document.getElementById("end_hh").value ="16" ;
			document.getElementById("end_mm").value ="30" ;
		}else{
			document.getElementById("end_hh").value ="17" ;
			document.getElementById("end_mm").value ="30" ;
		}
		
	}
	function SimyaTime() {
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();	
		document.getElementById("simya_hh").value =h ;
		document.getElementById("simya_mm").value =m ;
	}
/*	
	function HolidayTime() {
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();	
		document.getElementById("holiday_hh").value =h ;
		document.getElementById("holiday_mm").value =m ;
	}
*/
	function ChikokuTime() {
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();	
		document.getElementById("chikoku_hh").value =h ;
		document.getElementById("chikoku_mm").value =m ;
	}
	
	
//	function Stop() {
//	  tEnd = new Date();

//	  temp = tEnd.getTime()-tStart.getTime();
//	  document.getElementById("time").value = Math.floor(temp/1000);

	//  document.frm.action = test.jsp;
	//  document.frm.submit();
//	}

function goWrite(){	
var frm=document.frm;
if(isNotNumber(frm.holiday_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.holiday_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.chikoku_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.chikoku_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.begin_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.begin_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.end_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.end_mm, "mm形式で入力して下さい。!")) return;

if(frm.daikyu.value ==0){frm.daikyu_date.value="0000-00-00";}
//if(frm.hizuke.value.length ==10){frm.hizuke.value=frm.hizuke.value+frm.today_youbi.value;}
if(frm.comment.value ==""){frm.comment.value=".";}

if(frm.sign_ok_mseq.value ==0 ){alert("承認者を選択してください！");return;}

/*
if(frm.daikyu.value !=0 && frm.sign_ok_mseq.value==0){alert("承認者を選択してください！");return;}	
if(frm.daikyu.value ==0 && frm.sign_ok_mseq.value!=0){alert("代休取得しない場合は承認者の選択はいりません！");return;}
*/

if ( confirm("登録しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/kintai/insert.jsp";	
frm.submit();
}

function sikpEvent(){
	alert("自動的に入力されるので書かなくてもよろしいです");
}
</script>
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#hizuke").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#daikyu_date").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
</script>
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">出勤管理</span> 
<div class="clear_line_gray"></div>
<p>	
<div id="boxNoLineBig"  >	
<table width="97%" border="0" cellpadding="5" cellspacing="5" bgcolor="#FFFFFF">
	<tr height="29" >
	    <td width="70%" align="left"  style="padding: 0px 0px 3px 5px;">
	    	<font color="red">※</font>
	    	<font color="#807265">出勤して始業時間のみ登録したら、退勤時修正ページにて終業時間を再び書き直して下さい。。。</font>＾０＾<br>
	    	<font color="red"></b>※</b></font>
	    	<font color="#807265">休日勤務の場合は、<font color="#FF6600">[ 休日出勤 ]</font>　時間をご自分で直接入力して下さい。</font> &nbsp;&nbsp;	    		
	    	<font color="red">※</font> 		
		<font color="#807265"><img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle">==>説明</font>
	    </td>	
		<td width="30%" style="padding: 0 0 0 0" align="right" >
    			<input type="radio" name="sign_yn" value="1" onClick="show01()" onfocus="this.blur()" checked><font  color="#FF6600">登録欄を見せる</font>
			<input type="radio" name="sign_yn" value="2" onClick="show02()" onfocus="this.blur()"  ><font  color="#FF6600">登録欄を隠す</font>	
    		</td>    	
	</tr>		
</table>
<div id="show" style="display:;overflow:hidden ;width:100%;" >				
<table width="97%"  class="tablebox_list" cellpadding="0" cellspacing="0" >
<form name="frm" action="<%=urlPage%>rms/admin/kintai/insert.jsp" method="post" >
	 <input type="hidden" name="view_seq" value="1">
	 <input type="hidden" name="emNumber" id="emNumber" value="<%=member.getEm_number()%>">
	 <input type="hidden" name="simya_hh" id="simya_hh" value="00">
	 <input type="hidden" name="simya_mm"  id="simya_mm" value="00">
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	 <input type="hidden" name="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
	 <input type="hidden" name="sign_no_riyu" value="no data">	
<tr  align=center height=23>	
    <td  align="center" colspan="4" class="title_list_L_r">ORMS<%=position%></td>
    <td  align="center" colspan="2" class="title_list_L_r"><%=name%></td>
    <td  align="center" colspan="5" class="title_list_L"><%=inDate%>(<%=m_week%>曜日)</td>
</tr>
<tr bgcolor=#F1F1F1 align=center height=23>	
    <td  align="center" width="8%" class="title_list_m_r">日付 </td>
    <td  align="center" width="5%" class="title_list_m_r">普通残業<br>FT過不足</td>    
    <td  align="center" width="7%" class="title_list_m_r"><font color="#FF6600">休日出勤</font></td>
    <td  align="center" width="7%" class="title_list_m_r">休暇</td>
    <td  align="center" width="9%" class="title_list_m_r">代休取得</td>
    <td  align="center" width="7%" class="title_list_m_r">遅刻・早退・<br>外出時間</td>    
    <td  align="center" width="17%" class="title_list_m_r">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1">
			<tr bgcolor=#F1F1F1 align=center height=20>	
				<td  align="center" class="line_gray_bottomnright">始業時間</td>
				<td  align="center" class="line_gray_bottom">終業時間</td>
			</tr>			
			<tr height=2 bgcolor=#F1F1F1 style=color:#336699;>
				<td align="center" colspan="2">理由</td>					
			</tr>
		</table>	
	</td>	
	<td  align="center" width="7%" class="title_list_m_r">備考</td>
	<td  align="center" width="10%" class="title_list_m_r">決裁者</td>  
	<td  align="center" width="4%" class="title_list_m">登録</td>
</tr>
<tr >
	<td align="center" class="title_list_m_r">
			<input type="text" size="9%" name='hizuke' id="hizuke" value="<%=inDate%>" style="text-align:center">
		<!--<input type="text" size="9%" name='hizuke' class=calendar value="<%=inDate%>" style="text-align:center">-->
	</td>
	<td align="center" class="title_list_m_r">
		<input type="text" size="2" onClick="javascript:sikpEvent();" readonly name='zangyo_hh' id="zangyo_hh"  value="00" class="box" maxlength="2" style="width:25px" >:<input type="text" size="2" onClick="javascript:sikpEvent();"　name='zangyo_mm' id="zangyo_mm" value="00" class="box" maxlength="2" style="width:25px" readonly>
	</td>	
	<td align="center" class="title_list_m_r">			
		<input type="text" size="2"   name='holiday_hh'  id="holiday_hh"  value="00" class="box" maxlength="2" style="width:25px">:<input type="text" size="2"  name='holiday_mm' id="holiday_mm" value="00" class="box" maxlength="2" style="width:25px">
	</td>
	<td align="center" class="title_list_m_r">			
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="oneday_holi" class="select_type3" >			            							
					<option value="0">選択する</option>
					<option value="一日中">一日中</option>
					<option value="AM,半日">AM,半日</option>
					<option value="PM,半日">PM,半日</option>
					<option value="無給休暇">無給休暇</option>
					 <option value="休">休</option>									
				  </select>
			</div>
		</td>
	<td align="center" class="title_list_m_r">
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="daikyu" class="select_type3" >			            							
					<option value="0">選択する</option>
					<option value="代">代</option>
					<option value="AM">AM</option>
					<option value="PM">PM</option>									
				  </select>		
			 	<img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle" style="CURSOR: pointer;" title="代:一日代休 / AM:午後半休 / PM:午後半休 &#13; 備考欄に休出日を記入して下さい ">
		        </div>		
		<input type="text" size="9%" name='daikyu_date' id="daikyu_date" value="<%=inDate%>" style="text-align:center">
		<!--<input type="text" size="9%" name='daikyu_date' class=calendar value="<%=inDate%>" style="text-align:center">-->
	</td>
	<td align="center" class="title_list_m_r">
<!--**>		<a onclick="ChikokuTime();" style="CURSOR: pointer;" >	
			<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
<****-->
			<input type="text" size="2" name='chikoku_hh' id="chikoku_hh" value="00" class="box" maxlength="2" style="width:25px">:<input type="text" size="2" name='chikoku_mm' id="chikoku_mm"  value="00" class="box" maxlength="2" style="width:25px">
	</td>
	<td align="center" class="title_list_m_r">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1">
			<tr bgcolor=#F1F1F1 align=center >	
				<td  align="center" class="line_gray_bottomnright">
					<a onclick="StartTime();" style="CURSOR: pointer;" >	
			 		<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
					<input type="text" size="2" name="begin_hh"  id="begin_hh" value="00" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="begin_mm"  id="begin_mm" value="00" class="box" maxlength="2" style="width:25px">分
				</td>
				<td  align="center" class="line_gray_bottom">
					<a onclick="EndTime();" style="CURSOR: pointer;">	
			 		<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
					<input type="text" size="2" name="end_hh"  id="end_hh" value="00" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="end_mm"  id="end_mm" value="00" class="box" maxlength="2" style="width:25px">分
				</td>
			</tr>			
			<tr height=2 bgcolor=#F1F1F1 style=color:#336699;>
				<td align="center" colspan="2"><input type="text" name='riyu'  value="" class="input02" maxlength="200" style="width:210px"></td>					
			</tr>
		</table>	
	</td>
	<td align="center" class="title_list_m_r"><textarea class="textarea2" name="comment" rows="4" cols="12"></textarea>
	</td>
<!--	
	<td align="center">
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="sign_ok_mseq" class="select_type3" >
					<option value="0">選択する</option>	
			<c:if test="${! empty  listSign}">
				<%	int i=1;
					Iterator listiter=listSign.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
						if(mseq!=mem.getMseq()){					
				%>					
							<option value="<%=mem.getMseq()%>"><%=mem.getNm()%></option>	
				<%i++;}}%>	
			</c:if>
			<c:if test="${empty listSign}">
				--
			</c:if>				  					
				  </select>
			</div>
		</td>
-->
	<td align="center" class="title_list_m_r">
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="sign_ok_mseq" class="select_type3" >
					<option value="0">選択する</option>					
					<option value="45">張　晶旭</option>
					<option value="43">浜野　雅彦</option>					
					<option value="6">林　孔華</option>					
					<!--<option value="42">李　恩永</option>-->
					<option value="1">舘　義人</option>	
					<option value="53">木下　亜紀</option>	
					<option value="82">大野　隆弘</option>	
					<option value="71">小林　佐代子</option>
					<option value="62">伊藤　志穂</option>		
					<option value="68">戸川　祐一</option>												
				  </select>
			</div>
	</td>
	<td align="center" class="title_list_m"><a href="JavaScript:goWrite()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle" alt="send"></a>
	</td>
</tr>
</table>	
</form>	
</div>	
<table width="97%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
<form name="search2"  action="<%=urlPage%>rms/admin/kintai/listForm.jsp" method="post">			
	<input type="hidden" name="yyVal"  id="yyVal"value="">	
	<input type="hidden" name="mmVal" id="mmVal" value="">	
	<tr>
		<td width="10%"  valign="bottom"  style="padding:2 0 2 20" class="calendar5_01">
		<%if(yyVal==null){%><%=mgrYM%> <%}%>
		<%if(yyVal!=null){%><%=yyVal%>-<%=mmVal%> <%}%> 
		月</td>		
		<td width="70%"  valign="bottom"  style="padding:2 0 2 0">
		
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
				  <select name="menths_sch" class="select_type3"  onChange="return doSubmitOnEnter();">
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
		<td width="20%"  valign="bottom"  style="padding:2 0 2 120" class="calendar5_01"　align="center">
			<a href="javascript:popPrint('<%=mgrYM%>')" onfocus="this.blur()"> 						
			<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle"  title="Print"></a>
		<!--***>
			&nbsp; form02:<a href="javascript:popPrint2('<%=mgrYM%>')" onfocus="this.blur()"> 						
			<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle"  title="Print"></a>
		<*****-->		
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
    <td  align="center" width="9%" colspan="2" class="title_list_m_r">日付 </td>
    <td  align="center" width="6%" class="title_list_m_r">普通残業<br>FT過不足</td>    
    <td  align="center" width="8%" class="title_list_m_r">休日出勤</td>
    <td  align="center" width="8%" class="title_list_m_r">休暇</td>
    <td  align="center" width="8%" class="title_list_m_r">代休取得</td>
    <td  align="center" width="8%" class="title_list_m_r">遅刻・早退・<br>外出時間</td> 
    <td  align="center" width="16%" class="title_list_m_r">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1">
			<tr bgcolor=#E9FEEA align=center height=26>	
				<td  align="center"  class="line_gray_bottomnright">始業時間</td>
				<td  align="center" class="line_gray_bottom">終業時間</td>
			</tr>			
			<tr height=2 bgcolor=#E9FEEA style=color:#336699;>
				<td align="center" colspan="2" >理由</td>					
			</tr>
		</table>	
	</td>	
	<td  align="center" width="8%" class="title_list_m_r">備考</td>
	<td  align="center" width="7%" class="title_list_m_r">印</td>  
	<td  align="center" width="4%" class="title_list_m">修正・削除</td>
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="11">NO DATA</td>
	</tr>
</c:if>				
<c:if test="${! empty list}">	
<%
	int i=1;	int sumZanHH=0;  int sumZanMM=0; int sumZanTotal=0; String ddZero="";  String ymdList=""; String yyHori=""; String mmHori="";  String ddHori="";
	int jangyoPast495=0; int jangyoPast595=0; String beginZero=""; String endZero="";
	int totalValueHH_s=0; int totalValueMM_s=0;	
	int totalKyuHH_s=0; int totalKyuMM_s=0; int chikokuTime=0;	
		Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					DataBeanKintai dbb=(DataBeanKintai)listiter.next();
					int seq=dbb.getSeq();											
					if(seq!=0){							
						int beginval_s=dbb.getBeginval();  //출근시간 시작한 분계산
						int endval_s=dbb.getEndval();	 //출근시간 끝난 분계산		
						int horiTotal=(dbb.getHoliday_hh()*60)+dbb.getHoliday_mm(); 	 //휴일출근 수작업							
				
						chikokuTime=(dbb.getChikoku_hh()*60)+dbb.getChikoku_mm();
						jangyoPast495=endval_s-beginval_s-495;				
						jangyoPast595=endval_s-beginval_s-525;
						String hizukeYoubi=dbb.getHizuke().substring(11,12);
						String yyCol=dbb.getHizuke().substring(0,4);
						String mmCol=dbb.getHizuke().substring(5,7);
						String ddCol=dbb.getHizuke().substring(8,10);
						String ddColZero=dbb.getHizuke().substring(8,9);									
						
	DataMgr mgrHori = DataMgr.getInstance();	
//*************************휴일 start***********************
					
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
					// 잔교시 휴식 15분(휴일 근무는 점심시간을 계산에서 제외)	
		if(hizukeYoubi.equals("日") || hizukeYoubi.equals("土") || yyCol.equals(yyHori) && mmCol.equals(mmHori) && ddCol.equals(ddHori) || mmCol.equals(mmHori) && ddCol.equals(ddHori)){
					if(member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){	
					//	totalKyuHH_s=(endval_s-beginval_s-chikokuTime)/60;
					//	totalKyuMM_s=(endval_s-beginval_s-chikokuTime)%60;	
						totalKyusum +=(horiTotal-chikokuTime);
						totalChikokuTime +=chikokuTime;						
					}else if(!member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){					
					//	totalKyuHH_s=(endval_s-beginval_s-chikokuTime)/60;
					//	totalKyuMM_s=(endval_s-beginval_s-chikokuTime)%60;	
						totalKyusum +=(horiTotal-chikokuTime);	
						totalChikokuTime +=chikokuTime;								
					}
		}else{
					if(jangyoPast495 <=0 && member.getEm_number().equals("010") &&  dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){	
						totalValueHH_s=(endval_s-beginval_s-495-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-495-chikokuTime)%60;	
						totalsum +=(endval_s-beginval_s-495-chikokuTime);	
						totalChikokuTime +=chikokuTime;						
					}else if(jangyoPast495 >0 && member.getEm_number().equals("010") &&  dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-510-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-510-chikokuTime)%60;
						totalsum += (endval_s-beginval_s-510-chikokuTime);
						totalChikokuTime +=chikokuTime;	
						
					}else if(jangyoPast595 <=0 && !member.getEm_number().equals("010") &&  dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-525-chikokuTime)/60;
						totalValueMM_s=(endval_s-beginval_s-525-chikokuTime)%60;	
						totalsum +=(endval_s-beginval_s-525-chikokuTime);
						totalChikokuTime +=chikokuTime;	
						
					}else if(jangyoPast595 >0 && !member.getEm_number().equals("010") && dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0")){						
						totalValueHH_s=(endval_s-beginval_s-540-chikokuTime)/60;  
						totalValueMM_s=(endval_s-beginval_s-540-chikokuTime)%60;	
						totalsum +=(endval_s-beginval_s-540-chikokuTime);	
						totalChikokuTime +=chikokuTime;						
					}
		}
					
						if(ddColZero.equals("0")){ddZero=dbb.getHizuke().substring(9,10);
						}else{
							ddZero=ddCol;
						}
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
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
<%if(hizukeYoubi.equals("日") || hizukeYoubi.equals("土") || yyCol.equals(yyHori) && mmCol.equals(mmHori) && ddCol.equals(ddHori) || mmCol.equals(mmHori) && ddCol.equals(ddHori)){%>		
				<td align="center" class="clear_dot"><font color="red"><%=ddZero%></font></td>
				<td align="center" class="clear_dot" bgcolor=#F1F1F1 ><font color="red"><%=hizukeYoubi%></font></td>	
				<td align="center" class="clear_dot" bgcolor=#F1F1F1>&nbsp;</td>	
				<td align="center"  class="clear_dot">														
					<%if(dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0") && !id.equals("candy")){%>
							<%=dbb.getHoliday_hh()%>:<%if(dbb.getHoliday_mm()==0){%><%=dbb.getHoliday_mm()%>0<%}else{%><%=dbb.getHoliday_mm()%><%}%>					
					<%}else if(dbb.getOneday_holi().equals("0") && !dbb.getDaikyu().equals("0") && !id.equals("candy")){%>
							&nbsp;					
					<%}else if(!dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0") && !id.equals("candy")){%>
							&nbsp;
					<%}else if(id.equals("candy")){%>
							0:00				
					<%}else{%>
							 &nbsp;		 
					<%}%>						
				</td>
				<td align="center"class="clear_dot"  bgcolor=#F1F1F1>
					<%if(!dbb.getOneday_holi().equals("0")){%>
							<%=dbb.getOneday_holi()%>					
					<%}else{%>
						 &nbsp;		 
					<%}%>	
				</td>		
<%if(!dbb.getDaikyu().equals("0")){%>
				<td align="center" class="clear_dot" title="<%=dbb.getDaikyu_date()%>" bgcolor=#F1F1F1><%=dbb.getDaikyu()%>
					<img style="CURSOR: pointer;" src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle">
				</td>					
<%}else{%>
			 	<td align="center" class="clear_dot" bgcolor=#F1F1F1> &nbsp;</td>			 
<%}%>	
	<td align="center" class="clear_dot" bgcolor=#F1F1F1>				
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
		
<%}else{%>
	<td align="center" class="clear_dot"><%=ddZero%></td>
	<td align="center" class="clear_dot"><%=hizukeYoubi%></td>	
	<td align="center" class="clear_dot">ddd
		<%if(dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0") && !id.equals("candy")){%>
				<%=totalValueHH_s%>:<%if(totalValueMM_s==0){%><%=totalValueMM_s%>0<%}else{%><%=totalValueMM_s%><%}%> 					
		<%}else if(dbb.getOneday_holi().equals("0") && !dbb.getDaikyu().equals("0") && !id.equals("candy")){%>
				&nbsp;					
		<%}else if(!dbb.getOneday_holi().equals("0") && dbb.getDaikyu().equals("0") && !id.equals("candy")){%>
				&nbsp;					
		<%}else if(id.equals("candy")){%>
			0:00
		<%}else{%>
				 &nbsp;		 
		<%}%>
			
	</td>	
	<td align="center" class="clear_dot" bgcolor=#F1F1F1>&nbsp;</td>
	<td align="center" class="clear_dot">
		<%if(!dbb.getOneday_holi().equals("0")){%>
				<%=dbb.getOneday_holi()%>					
		<%}else{%>
				 &nbsp;		 
		<%}%>	
	</td>	
	<%if(!dbb.getDaikyu().equals("0")){%>
			<td align="center" class="clear_dot" title="<%=dbb.getDaikyu_date()%>"><%=dbb.getDaikyu()%>
				<img style="CURSOR: pointer;" src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle">
			</td>					
	<%}else{%>
		 <td align="center" class="clear_dot"> &nbsp;</td>
	<%}%>	
	<td align="center" class="clear_dot">
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
<%}%>			
	<td  align="center" class="clear_dot" width="17%">
		<table width=100% class="tablebox_list" >
			<tr align=center height=18>	
				<td  align="center" width="50%" class="line_gray_bottomnright"><%=dbb.getBegin_hh()%>:<%=beginZero%></td>
				<td  align="center" width="50%" class="line_gray_bottom"><%=dbb.getEnd_hh()%>:<%=endZero%></td>				
			</tr>
			<tr>
				<td  align="center" width="10%" colspan="2">
					<%if(dbb.getRiyu() !=null){%>						
							<%=dbb.getRiyu()%>										
					<%}else{%>.<%}%>
				</td>
			</tr>			
		</table>	
	</td>				
	<td align="center" class="clear_dot"><%=dbb.getComment()%></td>
	<td align="center" class="clear_dot">
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
	<td align="center" class="clear_dot">
		<a href="javascript:goModify('<%=seq%>','<%=totalValueHH_s%>','<%=totalValueMM_s%>');"  onFocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>
		<a href="javascript:goDelete('<%=seq%>','<%=dbb.getHizuke()%>')"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>		
	</td>
</tr>
	
<%}
i++;	
}

%>	
	<tr  align=center height=26 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="calendar5" colspan="2">&nbsp;</td>
	<td align="center" class="calendar5">
	<%if(!id.equals("candy")){%>
		<%=totalsum/60%>:<%if(totalsum%60==0){%><%=totalsum%60%>0<%}else{%><%=totalsum%60%><%}%> 	
	<%}else if(id.equals("candy")){%>
		0:00
	<%}%>
	</td> 
	<td align="center" class="calendar5">
		<%=totalKyusum/60%>:<%if(totalKyusum%60==0){%><%=totalKyusum%60 %>0<%}else{%><%=totalKyusum%60%><%}%> 	
	</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td> 
	<td align="center" class="calendar5">
		<%=totalChikokuTime/60%>:<%if(totalChikokuTime%60==0){%><%=totalChikokuTime%60 %>0<%}else{%><%=totalChikokuTime%60%><%}%> 		
	</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">.</td>
	<td align="center" class="calendar5">-</td>	
</tr>
</c:if>
</table>
</form>
</div>			
<form name="move" method="post">
    <input type="hidden" name="seq" value="">    
    <input type="hidden" name="daikyu" value="">    
    <input type="hidden" name="hhh" value="">    
    <input type="hidden" name="mmm" value="">    
 </form>
 <p><p>
<!--**********금월 리스트 end  -->	

<script language="javascript">
function doSubmitOnEnter(){
	var frm=document.search2;
	frm.yyVal.value=frm.year_sch.value;
	frm.mmVal.value=frm.menths_sch.value;
	frm.action = "<%=urlPage%>rms/admin/kintai/listForm.jsp";	
	frm.submit();
}
function goDelete(seq,ymd) {
	   if ( confirm(ymd+"のデータを削除しますか?") != 1 ) {return ;}
	document.move.action = "<%=urlPage%>rms/admin/kintai/delete.jsp";
	document.move.seq.value=seq;
	document.move.submit();
}
function goModify(seq,hh,mm) {	
    document.move.action = "<%=urlPage%>rms/admin/kintai/updateForm.jsp";
	document.move.seq.value=seq;
	document.move.hhh.value=hh;
	document.move.mmm.value=mm;	
    document.move.submit();
}	
	
function show01(){	document.getElementById("show").style.display=''; }
function show02(){	document.getElementById("show").style.display='none'; }
// 한줄쓰기 토글 함수
function ShowHidden(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.itemData_block" + i + ".style");	
		if ( i == ShowMenuID ){
			if ( menu.display == "block" )
				menu.display	= "none";
			else 
				menu.display	= "block";
		} 
		else 
			menu.display	= "none";
	}
	frame_init();
} 
</script>		
<script type="text/javascript">
function popup_Layer(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     // 좌우 위치 지정
     if(_marginx < 0){
        main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px";
     }
     else{
        main.style.left = event.clientX + document.body.scrollLeft-5+"px";
     }
     //높이 지정
     if(_marginy < 0){
        main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";
     }  
     else{
        main.style.top = event.clientY + document.body.scrollTop-5+"px";
     } 
} 

function popup_LayerCo(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     // 좌우 위치 지정
     if(_marginx < 0){
        main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px";
     }
     else{
        main.style.left = event.clientX + document.body.scrollLeft-5+"px";
     }
     //높이 지정
     if(_marginy < 0){
        main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";
     }  
     else{
        main.style.top = event.clientY + document.body.scrollTop-5+"px";
     } 

}  

function Layer_popup_Off() { 
  var frm=document.frm;
  var pay_len = eval(frm.divPass.length);  
  var pay_val=frm.divPass;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
} 

function popPrint(mgrYM){	
	var arratym=mgrYM.split("-",2);	
	var year=	arratym[0];			
	var month=arratym[1];	
	var totalsum=<%=totalsum%>;
	var totalKyusum=<%=totalKyusum%>;
	var totalChikokuTime=<%=totalChikokuTime%>;

	var param="&mgrYM="+mgrYM+"&month="+month+"&year="+year+"&action=0&totalsum="+totalsum+"&totalKyusum="+totalKyusum+"&totalChikokuTime="+totalChikokuTime;	
	openScrollWin("<%=urlPage%>rms/admin/kintai/printForm.jsp", "出退社", "出退社", "500", "700",param);	
}

/*
function popPrint2(mgrYM){	
	var arratym=mgrYM.split("-",2);	
	var year=	arratym[0];			
	var month=arratym[1];	

	var param="&mgrYM="+mgrYM+"&month="+month+"&year="+year+"&action=0";	
	openScrollWin("<%=urlPage%>rms/admin/kintai/printForm2.jsp", "出退社", "出退社", "500", "700",param);
	
}
*/
</script> 	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
