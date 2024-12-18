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
String title = ""; String name=""; String mailadd=""; 
String pass=""; int mseq=0; int level=0; int dbPosiLevel=0;
String position="";
String busho="";

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

	DataMgrJangyo mgr = DataMgrJangyo.getInstance();	
	DataBeanJangyo bean=mgr.getSum(mgrYM,mseq);
	int beginval=bean.getBeginval();
	int endval=bean.getEndval();
	int seqcnt=bean.getSeqcnt()*525;  
//	int totalValueHH=(endval-beginval-seqcnt)/60;
//	int totalValueMM=(endval-beginval-seqcnt)%60;
	
	int totalValueHH2=(endval-beginval)/60;
	int totalValueMM2=(endval-beginval)%60;
		
	List list=mgr.listSchedule(mgrYM,mseq);	
	
	int levelKubun=0;
	if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
	List listSign=manager.selectJangyo(1,levelKubun,busho); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
	Member memSign;	

%>
<c:set var="list" value="<%=list%>"/>	
<c:set var="member" value="<%=member%>"/>
<c:set var="mseq" value="<%= mseq %>" />	
<c:set var="listSign" value="<%= listSign %>" />				
	
<script type="text/javascript">
	window.onload = function() {
		StartTime(); 
		EndTime();
	}
	function StartTime() {
	  	now=new Date();
		h=document.getElementById("day_of_week").value;	
		m=now.getMinutes();	
	if(h==1||h==7){
		document.getElementById("begin_hh").value =09 ;
		document.getElementById("begin_mm").value =00 ;
	}else{
		document.getElementById("begin_hh").value =17 ;
		document.getElementById("begin_mm").value =45 ;
	}					
	}
	function EndTime() {
	  	now=new Date();
		hour=now.getHours();
		if((""+hour).length==1){hour="0"+hour;}	
		
		m=now.getMinutes();	
		if((""+m).length==1){m="0"+m;}	
		document.getElementById("end_hh").value =hour ;
		document.getElementById("end_mm").value =m ;
	}
	

function goWrite(){	
var frm= document.frm;
if(isNotNumber(frm.begin_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.begin_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.end_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.end_mm, "mm形式で入力して下さい。!")) return;

if(frm.riyu.value ==""){frm.riyu.value=".";}
if(frm.comment.value ==""){frm.comment.value=".";}
if ( confirm("登録しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/jangyo/insert.jsp";	
frm.submit();
}
</script>
</script>
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#hizuke").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

</script>
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">残業申請管理 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<% if(busho.equals("0")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(経営役員)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>
	<% if(busho.equals("1")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(企画部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>
	<% if(busho.equals("2")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(事業統括部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>
	<% if(busho.equals("3")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(開発部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>		
	<% if(busho.equals("4")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(製造部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("5")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(品質保証部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("6")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(臨床開発部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("7")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(安全管理部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("8")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(その他)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>										

</div>
<div id="boxNoLineBig"  >				

<table width="920" >
	<tr>
	    <td width="10%" style="padding: 0px 0px 0px 5px;" class="calendar16_1">
		<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">申請	    		    	
		</td>
		<td width="50%">
	    		<img src="<%=urlPage%>rms/image/admin/tokei_small.gif" align="absmiddle"><font color="#807265">==></font>今の時間を自動的に入力				    
	    	</td>	
		<td width="40%" align="right" >			
			<input type="radio" name="sign_yn" value="1" onClick="show01()" onfocus="this.blur()" checked><font  color="#FF6600">登録欄を見せる</font>
			<input type="radio" name="sign_yn" value="2" onClick="show02()" onfocus="this.blur()"  ><font  color="#FF6600">登録欄を隠す</font>	
    		</td>    	
	</tr>		
</table>
<div id="show" style="display:;overflow:hidden ;width:100%;" >
<table width="920"  class="tablebox" cellspacing="5" cellpadding="5">	
	<form name="frm" action="<%=urlPage%>rms/admin/jangyo/insert.jsp" method="post" >
	 <input type="hidden" name="day_of_week" id="day_of_week" value="<%=day_of_week%>">	 
	 <input type="hidden" name="simya_hh" id="simya_hh" value="00">
	 <input type="hidden" name="simya_mm" id="simya_mm" value="00">
	 <input type="hidden" name="mseq" id="mseq" value="<%=mseq%>">
	 <input type="hidden" name="today_youbi" id="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
	<tr>
	<td colspan="4" class="calendar9" align="right"><%=inDate%>(<%=m_week%>曜日)</td>
	</tr>
			<tr align="left">
				<td width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">申請者</span></td>
				<td width="39%" ><%=name%> (
								    	<% if(busho.equals("0")){%>その他<%}%>										
										<% if(busho.equals("1")){%>品質管理部<%}%>
										<% if(busho.equals("2")){%>製造部<%}%>
										<% if(busho.equals("3")){%>管理部<%}%>
										<% if(busho.equals("4")){%>その他<%}%>
										<% if(busho.equals("no data")){%>その他<%}%>)	
    			</td>
				<td  width="13%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">承認者</span></td>
				<td width="37%">
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="sign_ok_mseq" class="select_type3" >
							<option value="0">選択</option>						
<c:choose>
	<c:when test="${mseq==42 || mseq==6}">
			<option value="40">森山　剛 </option>
			<option value="45">張　晶旭 </option>
	</c:when>
	<c:when test="${mseq==1 || mseq==53 || mseq==54}">
			<option value="40">森山　剛 </option>
			<option value="45">張　晶旭 </option>
			<option value="42">李　恩永 </option>
			<option value="6">林　孔華 </option>
			<option value="71">小林　佐代子 </option>
			<option value="82">大野　隆弘 </option>			
			
			<option value="59">田村　知明 </option>
			<option value="60">堀井　章弘 </option>
			<option value="62">伊藤　志穂 </option>
			<option value="68">戸川　祐一 </option>
			<option value="83">上野　仁士 </option>
			<option value="88">橋本　弘 </option>
	</c:when>
	<c:otherwise>
	    		<option value="40">森山　剛 </option>
			<option value="45">張　晶旭 </option>
			<option value="42">李　恩永 </option>
			<option value="6">林　孔華 </option>			
			<option value="1">舘　義人 </option>
			<option value="53">木下　亜紀 </option>
			<option value="54">富樫　恭子 </option>	
			<option value="71">小林　佐代子 </option>
			<option value="82">大野　隆弘 </option>
			
			<option value="59">田村　知明 </option>
			<option value="60">堀井　章弘 </option>
			<option value="62">伊藤　志穂 </option>
			<option value="68">戸川　祐一 </option>
			<option value="83">上野　仁士 </option>
			<option value="88">橋本　弘 </option>
					
	</c:otherwise>		
</c:choose>			
		
													
	<!--															
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
	-->					
					</select>
					</div>							  
				</td>
			</tr>
			<tr align="left">
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">日付(残業日)</span></td>
				<td ><input type="text" size="9%" name="hizuke" id="hizuke" value="<%=inDate%>" style="text-align:center"></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">残業申請時間</span> </td>
				<td>
					<input type="text" size="2" name="begin_hh" id="begin_hh"  value="00" class="input02" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="begin_mm" id="begin_mm"  value="00" class="input02" maxlength="2" style="width:25px">分から
					<a onclick="EndTime();" style="CURSOR: pointer;">	
					<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
					<input type="text" size="2" name="end_hh" id='end_hh'  value="00" class="input02" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="end_mm" id="end_mm"  value="00" class="input02" maxlength="2" style="width:25px">分まで
				</td>
			</tr>
			<tr align="left">
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">残業理由及び内容</span></td>
				<td><input type="text" size="2" name='riyu'  value="" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">備考</span></td>
				<td><input type="text" size="2" name='comment'  value="" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>				
		</tr>					
</table>				
<table width="920" >
		<tr>			
			<td colspan="2" align="center"style="padding: 0 0 7 0" >
				<a href="JavaScript:goWrite()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle" alt="submit"></a>
			</td>
		</tr>					
</table>	
</form>	
</div>	
<table width="97%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
<form name="search2"  action="<%=urlPage%>rms/admin/jangyo/listForm.jsp" method="post">			
	<input type="hidden" name="yyVal" value="">	
	<input type="hidden" name="mmVal" value="">	
	<tr>
		<td width="10%"  valign="bottom"  style="padding:2 0 2 2" class="calendar5_01">
		<%if(yyVal==null){%><%=mgrYM%> <%}%>
		<%if(yyVal!=null){%><%=yyVal%>-<%=mmVal%> <%}%>
		月</td>		
		<td width="90%"  valign="bottom"  style="padding:2 0 2 0">
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="year_sch" class="select_type3" >
	<%	for(int i=2009;i<=mgrYyyyInt;i++){%>			            							
					<option value="<%=i%>" <%if(i==mgrYyyyInt){%>selected <%}%>><%=i%></option>
	<%}%>																			
				  </select>年 
			</div>
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">							
				  <select name="menths_sch" class="select_type3"  onChange="return doSubmitOnEnter();">
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
<table width="97%" class="tablebox_list">
<form name="frm02" action="<%=urlPage%>rms/admin/jangyo/insert.jsp" method="post" >
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	<input type="hidden" name="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
<tr bgcolor=#F1F1F1 align=center >	
	<td  width="8%" class="title_list_m_r">登録日</td> 
	<td  width="12%" class="title_list_m_r">日付(残業)</td> 
	<td  width="15%" class="title_list_m_r">
		<table width=100% class="tablebox_list">
			<tr bgcolor=#F1F1F1 align=center >	
				<td  align="center" colspan="2" class="line_gray_bottom">残業申請時間</td>				
			</tr>
			<tr bgcolor=#F1F1F1 align=center >	
				<td  align="center" class="line_gray_right">始業</td>
				<td  align="center" >終業</td>
			</tr>		
		</table>	
	</td>	
     <td  width="10%"  class="title_list_m_r">部署</td>    
     <td  width="10%"  class="title_list_m_r">承認者</td>     
	<td width="20%"  class="title_list_m_r">残業理由及び内容</td> 
	<td width="15%"  class="title_list_m_r">備考</td>		
	<td width="10%"  class="title_list_m">修正・削除</td>
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="8">NO DATA</td>
	</tr>
</c:if>				
<c:if test="${! empty list}">	
<%
	int i=1;	int sumZanHH=0;  int sumZanMM=0; int sumZanTotal=0; String hour_hhTotal=""; String minuteMmTotal="";
		Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					DataBeanJangyo dbb=(DataBeanJangyo)listiter.next();
					int seq=dbb.getSeq();											
					if(seq!=0){							
						int beginval_s=dbb.getBeginval();  //시작한 분계산
						int endval_s=dbb.getEndval();	 //끝난 분계산				
						int totalValueHH_s=(endval_s-beginval_s-525)/60;
						int totalValueMM_s=(endval_s-beginval_s-525)%60;
						
						int hourHhBegin=dbb.getBegin_hh();
							if(hourHhBegin==1 || hourHhBegin==2 || hourHhBegin==3 || hourHhBegin==4 || hourHhBegin==5 || hourHhBegin==6 || hourHhBegin==7 || hourHhBegin==8 || hourHhBegin==9){
									hour_hhTotal="0"+hourHhBegin;
								}
						int minuteHhBegin=dbb.getBegin_mm();
							if(minuteHhBegin==1 || minuteHhBegin==2 || minuteHhBegin==3 || minuteHhBegin==4 || minuteHhBegin==5 || minuteHhBegin==6 || minuteHhBegin==7 || minuteHhBegin==8 || minuteHhBegin==9){
									minuteMmTotal="0"+minuteHhBegin;								
							}				
%>
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="clear_dot"><%=dateFormat.format(dbb.getRegister())%></td>
	<td align="center" class="clear_dot"><%=dbb.getHizuke()%></td>
	<td align="center" class="clear_dot" width="17%">
		<table width=100% class="tablebox_list">
			<tr bgcolor=#F1F1F1 align=center >	
				<td  align="center" width=""><%=hourHhBegin%>時 <%=minuteHhBegin%>分</td>
				<td  align="center" width=""><%=dbb.getEnd_hh()%>時 <%=dbb.getEnd_mm()%>分</td>				
			</tr>			
		</table>	
	</td>				
	<td align="center" class="clear_dot">(
		<% if(busho.equals("0")){%>その他<%}%>		
		<% if(busho.equals("1")){%>品質管理部<%}%>
		<% if(busho.equals("2")){%>製造部<%}%>
		<% if(busho.equals("3")){%>管理部<%}%>	
		<% if(busho.equals("4")){%>その他<%}%>
		<% if(busho.equals("no data")){%>その他<%}%>)
	</td>
	<td align="center" class="clear_dot">
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
	<td align="left" class="clear_dot"><%=dbb.getRiyu()%></td>
	<td align="left" class="clear_dot"><%=dbb.getComment()%></td>	
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
	<tr bgcolor=#F1F1F1 align=center height=26 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">今月残業回数:  <%=bean.getSeqcnt()%>日</td>
	<td align="center" class="calendar5">今月残業総時間:  <%=totalValueHH2%>:<%=totalValueMM2%></td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>
	<td align="center" class="calendar5">-</td>	
</tr>
</c:if>
</table>
</form>
<form name="move" method="post">
    <input type="hidden" name="seq" value="">        
    <input type="hidden" name="hhh" value="">    
    <input type="hidden" name="mmm" value="">    
 </form>
<!--**********금월 리스트 end  -->	
</div>
<script language="javascript">
function doSubmitOnEnter(){
	var frm=document.search2;
	frm.yyVal.value=frm.year_sch.value;
	frm.mmVal.value=frm.menths_sch.value;
	frm.action = "<%=urlPage%>rms/admin/jangyo/listForm.jsp";	
	frm.submit();
}
function goDelete(seq,ymd) {
	   if ( confirm(ymd+"のデータを削除しますか?") != 1 ) {return ;}
	document.move.action = "<%=urlPage%>rms/admin/jangyo/delete.jsp";
	document.move.seq.value=seq;	
    document.move.submit();
}
function goModify(seq,hh,mm) {	
    document.move.action = "<%=urlPage%>rms/admin/jangyo/updateForm.jsp";
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

</script> 	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
