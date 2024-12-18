<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

<%		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String name=""; String pass=""; int mseq=0; int level=0;
	String busho=""; int dbPosiLevel=0;
	
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();		 
		 mseq=member.getMseq();
		 busho=member.getBusho();
		 dbPosiLevel=member.getPosition_level();
	}		
//달력보기 시작
  String inDate=dateFormat.format(new java.util.Date());
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
	
	
		
	
String seq=request.getParameter("seq");
String hhh=request.getParameter("hhh");
String mmm=request.getParameter("mmm");
DataMgrKintai mgrKin=DataMgrKintai.getInstance();
DataBeanKintai mem=mgrKin.getDb(Integer.parseInt(seq));

int levelKubun=0; String upDaikyu="";
if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
List list=manager.selectJangyo(1,levelKubun,busho); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
%>
	
<c:set var="list" value="<%= list %>" />		
<c:set var="mem" value="<%=mem%>" />
<c:set var="member" value="<%=member%>" />


<script type="text/javascript">
	window.onload = function() {
	//	StartTime(); 
	//	EndTime();
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
	function HolidayTime() {
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();	
		document.getElementById("holiday_hh").value =h ;
		document.getElementById("holiday_mm").value =m ;
	}
	function ChikokuTime() {
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();	
		document.getElementById("chikoku_hh").value =h ;
		document.getElementById("chikoku_mm").value =m ;
	}
	

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
if(frm.daikyu_date.value ==""){frm.daikyu_date.value="0000-00-00";}
if(frm.daikyu_date.value.length >10){frm.daikyu_date.value=frm.daikyu_date.value.substring(0,10);}

if(frm.hizuke.value.length >10){frm.hizuke.value=frm.hizuke.value.substring(0,10);}
if(frm.comment.value ==""){frm.comment.value=".";}
if(frm.sign_ok_mseq.value ==0 ){alert("承認者を選択してください！");return;}

if ( confirm("修正しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/kintai/update.jsp";	
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
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">出勤管理 <font color="#A2A2A2">></font>  書き直し</span> 
<div class="clear_line_gray"></div>
<p>	
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録/目録" onClick="location.href='<%=urlPage%>rms/admin/kintai/listForm.jsp'">	
</div>
<div id="boxNoLineBig"  >		
				
<table width="97%"  class="tablebox_list" cellpadding="0" cellspacing="0" >
<form name="frm" action="<%=urlPage%>rms/admin/kintai/update.jsp" method="post" >	 
	 <input type="hidden" name="emNumber" id="emNumber" value="<%=member.getEm_number()%>">
	 <input type="hidden" name="simya_hh"  id="simya_hh" value="00">
	 <input type="hidden" name="simya_mm" id="simya_mm" value="00">
	 <input type="hidden" name="seq" value="<%=seq%>">
	 <input type="hidden" name="daikyuSche" id="daikyuSche" value="<%=mem.getDaikyu()%>">
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	 <input type="hidden" name="today_youbi"  id="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="<%=mem.getSign_ok()%>">  <!--*** 1=사인전, 2=사인ok  -->
<tr bgcolor="" align=center height=23>	
    <td  align="center" colspan="4" class="title_list_L_r">ORMS企画部</td>
    <td  align="center" colspan="2" class="title_list_L_r"><%=name%></td>
    <td  align="center" colspan="5" class="title_list_L"><%=mem.getHizuke()%></td>
</tr>
<tr bgcolor=#F1F1F1 align=center height=23>	
    <td  align="center" width="9%" class="title_list_m_r">日付 </td>
    <td  align="center" width="5%" class="title_list_m_r">普通残業<br>FT過不足</td>    
    <td  align="center" width="7%" class="title_list_m_r">休日出勤</td>
    <td  align="center" width="7%" class="title_list_m_r">休暇</td>
    <td  align="center" width="8%" class="title_list_m_r">代休取得</td>
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
	<td  align="center" width="10%" class="title_list_m_r">印</td>  
	<td  align="center" width="4%" class="title_list_m">登録</td>
</tr>
<tr >
	<td align="center" class="clear_dot">
		<input type="text" size="12%" name="hizuke" id="hizuke" value="<%=mem.getHizuke()%>" style="text-align:center">
	<!--	<input type="text" size="12%" name='hizuke'  value="<%=mem.getHizuke()%>" style="text-align:center" >-->
	
	</td>
	<td align="center" class="clear_dot">
		<input type="text" size="2" onClick="javascript:sikpEvent();" readonly name="zangyo_hh" id="zangyo_hh"  value="<%=hhh%>" class="box" maxlength="2" style="width:25px">:<input type="text" size="2" onClick="javascript:sikpEvent();" readonly name="zangyo_mm" id="zangyo_mm"  value="<%=mmm%>" class="box" maxlength="2" style="width:25px">
	</td>
	<td align="center" class="clear_dot">
<!--***>		<a onclick="HolidayTime();" style="CURSOR: pointer;">	
		<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
<******-->
		<input type="text" size="2"   name="holiday_hh" id="holiday_hh"  value="<%=mem.getHoliday_hh()%>" class="box" maxlength="2" style="width:25px">:<input type="text" size="2"   name="holiday_mm" id="holiday_mm"  value="<%=mem.getHoliday_mm()%>" class="box" maxlength="2" style="width:25px">
	</td>
	<td align="center" class="clear_dot">			
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="oneday_holi" class="select_type3" >	
					<option value="0" selected>選択</option>
					<option value="一日中" <%if(mem.getOneday_holi().equals("一日中")){%>selected<%}%>>一日中</option>	
					<option value="AM,半日" <%if(mem.getOneday_holi().equals("AM,半日")){%>selected<%}%>>AM,半日</option>	
					<option value="PM,半日" <%if(mem.getOneday_holi().equals("PM,半日")){%>selected<%}%>>PM,半日</option>	
					<option value="無給休暇" <%if(mem.getOneday_holi().equals("無給休暇")){%>selected<%}%>>無給休暇</option>
					<option value="休" <%if(mem.getOneday_holi().equals("休")){%>selected<%}%>>休</option>	
					<option value="0" >選択しない</option>
				  </select>
			 	<img style="CURSOR: pointer;" src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle" title="AM:午前半休&#13;AM:午前半休&#13;年:年休&#13;病:病欠&#13;事:事欠&#13;認:認欠&#13;生:生理休暇&#13;育:育児・介護休暇・ボランティア">	
			</div>
		</td>
	<td align="left" class="clear_dot">
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="daikyu" class="select_type3" >
					<option value="0" selected>選択</option>			            							
					<option value="0" <%if(mem.getDaikyu().equals("0")){%>selected<%}%>>代休 種類..</option>
					<option value="代" <%if(mem.getDaikyu().equals("代")){%>selected<%}%>>代</option>
					<option value="AM" <%if(mem.getDaikyu().equals("AM")){%>selected<%}%>>AM</option>
					<option value="PM" <%if(mem.getDaikyu().equals("PM")){%>selected<%}%>>PM</option>
					<option value="0" >選択しない</option>									
				  </select>		
			 	<img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle" style="CURSOR: pointer;" title="代:一日代休 / AM:午後半休 / PM:午後半休 &#13; 備考欄に休出日を記入して下さい ">
		        </div>
		  <%if(mem.getDaikyu_date().equals("0000-00-00") ){
		    	 upDaikyu="";   	
		    	}else{
		    	upDaikyu=mem.getDaikyu_date();
		    	}
		   %>		
		<input type="text" size="12%" name="daikyu_date" id="daikyu_date" value="<%=upDaikyu%>" style="text-align:center">
   	<!--	<input type="text" size="12%" name='daikyu_date' class='calendar' value="<%=upDaikyu%>" style="text-align:center">-->
	</td>
	<td align="center" class="clear_dot">
<!--********>
		<a onclick="ChikokuTime();" style="CURSOR: pointer;" >	
			<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
<******-->
			<input type="text" size="2" name="chikoku_hh"  id="chikoku_hh"  value="<%=mem.getChikoku_hh()%>" class="box" maxlength="2" style="width:25px">:<input type="text" size="2" name="chikoku_mm" id="chikoku_mm"  value="<%=mem.getChikoku_mm()%>" class="box" maxlength="2" style="width:25px">
	</td>
	<td align="center" class="clear_dot">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1">
			<tr bgcolor=#F1F1F1 align=center height=26>	
				<td  align="center" class="line_gray_bottomnright">
					<a onclick="StartTime();" style="CURSOR: pointer;" >	
			 		<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
					<input type="text" size="2" name="begin_hh"  id="begin_hh"  value="<%=mem.getBegin_hh()%>" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="begin_mm" id="begin_mm"  value="<%=mem.getBegin_mm()%>" class="box" maxlength="2" style="width:25px">分
				</td>
				<td  align="center" class="line_gray_bottom">
					<a onclick="EndTime();" style="CURSOR: pointer;">	
			 		<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
					<input type="text" size="2" name="end_hh" id="end_hh"  value="<%=mem.getEnd_hh()%>" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="end_mm" id="end_mm"  value="<%=mem.getEnd_mm()%>" class="box" maxlength="2" style="width:25px">分
				</td>
			</tr>			
			<tr height=2 bgcolor=#F1F1F1 style=color:#336699;>
				<td align="center" colspan="2">
<%if(mem.getRiyu()!=null){%>
					<input type="text" name="riyu"  id="riyu" value="<%=mem.getRiyu()%>" class="box" maxlength="200" style="width:210px">
<%}else{%>
					<input type="text" name="riyu"  id="riyu" value="" class="box" maxlength="200" style="width:210px">
<%}%>				
				</td>					
			</tr>
		</table>	
	</td>
	<td align="center" class="clear_dot"><textarea class="textarea2" name="comment" rows="4" cols="9"><%=mem.getComment()%></textarea>
	</td>
<!--
	<td align="center">
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				  
	<c:if test="${empty list}">
		No Data
	</c:if>
			<select name="sign_ok_mseq" class="select_type3" >
				<option value="0" selected>選択</option>
	<c:if test="${! empty list}">
<%
			int i=1;	int mseqdbval=0;
			Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					Member mem02=(Member)listiter.next();
					 mseqdbval=mem02.getMseq();											
					if(mseqdbval!=0 && mseq!=mem02.getMseq()){		
%>	
					<option value="<%=mseqdbval%>" <%if(mseqdbval==mem.getSign_ok_mseq()){%>selected<%}%>><%=mem02.getNm()%></option>	
<%	}
i++;	
}
%>
		</c:if>												
				  </select>
		</div>
		</td>
-->
	<td align="center" class="clear_dot">
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				  	
			<select name="sign_ok_mseq" class="select_type3" >				
					<option value="0">選択する</option>
	<%if(mem.getSign_ok_mseq() !=0){%>					
					<option value="45" <%if(mem.getSign_ok_mseq()==45){%>selected<%}%>>張　晶旭</option>
					<option value="43" <%if(mem.getSign_ok_mseq()==43){%>selected<%}%>>浜野　雅彦</option>					
					<option value="6" <%if(mem.getSign_ok_mseq()==6){%>selected<%}%>>林　孔華</option>					
					<option value="1" <%if(mem.getSign_ok_mseq()==1){%>selected<%}%>>舘　義人</option>	
					<option value="53" <%if(mem.getSign_ok_mseq()==53){%>selected<%}%>>木下　亜紀</option>	
					<option value="82" <%if(mem.getSign_ok_mseq()==82){%>selected<%}%>>大野　隆弘</option>	
					<option value="71" <%if(mem.getSign_ok_mseq()==71){%>selected<%}%>>小林　佐代子</option>	
					<option value="62" <%if(mem.getSign_ok_mseq()==62){%>selected<%}%>>伊藤　志穂</option>
					<option value="68" <%if(mem.getSign_ok_mseq()==62){%>selected<%}%>>戸川　祐一</option>
						
	<%}%>																			
				  </select>
		</div>
		</td>	
	<td align="center" class="clear_dot">
		<a href="JavaScript:goWrite();" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif" align="absmiddle" alt="send"></a>	
	</td>
</tr>
</table>	
</form>	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
