<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrSignup" %>
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
String pass=""; int mseq=0; int level=0; int dbPosiLevel=0; int lineCnt=0; int iSche=0;
String position="";
String busho="";

String inDate=dateFormat.format(new java.util.Date());		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");

String lineCntVal=request.getParameter("lineCntVal");
if(lineCntVal==null){lineCnt=1;}
if(lineCntVal!=null){lineCnt=Integer.parseInt(lineCntVal);}

String bushopg=request.getParameter("bushopg");
if(bushopg==null){bushopg="1";}



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
	String bushoVal="";
	 if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){	
		 bushoVal=bushopg;	
	}else{
		bushoVal=busho;
	}	
/*	int levelKubun=0;
	if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
	List listSign=manager.selectJangyo(1,levelKubun,bushoVal); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
	Member memSign;	
*/		
	DataMgrSignup managerSign = DataMgrSignup.getInstance();	
	List listSignFix=managerSign.listSignFix(1,mseq);
	
%>
<c:set var="member" value="<%=member%>"/>
<c:set var="listSignFix" value="<%= listSignFix %>" />				
	
<script type="text/javascript">
function goWrite(){	
var frm= document.frm;

if(frm.sign_yn.value=="no"){alert("承認者を選択してください"); return;}
if(frm.destination_info.value ==""){frm.destination_info.value=".";}
if(frm.destination.value ==""){frm.destination.value=".";}
if(frm.drive_yn.value ==""){frm.drive_yn.value=".";}
if(frm.reason.value ==""){frm.reason.value=".";}
if(frm.comment.value ==""){frm.comment.value=".";}
if(frm.during_begin.value ==""){alert("出張期間を入力して下さい！");return;}
if(frm.during_end.value ==""){alert("出張期間を入力して下さい！");return;}

<%for(iSche=1;iSche<=lineCnt;iSche++){%>	
	if(document.getElementById("sche_date<%=iSche%>").value ==""){alert("出張スケジュールを入力して下さい！");return;}
<%}%>

if ( confirm("登録しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/hokoku/write/insertTrip.jsp";	
frm.submit();
}

function checkCodeWrite(kind_pg_write){				
	var param="&kind_pg_write="+kind_pg_write;
	openNoScrollWin("<%=urlPage%>rms/admin/hokoku/signupLine/signAdd_pop.jsp", "signAdd", "signAdd", "500", "350",param);
}
function goInit(){
	document.frm.reset();
}
</script>
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#during_begin").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#during_end").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

<%for(iSche=1;iSche<=lineCnt;iSche++){%>    
	$(function() {
	   $("#sche_date<%=iSche%>").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
	    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
<%}%>  
</script>		
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">出張/休日勤務 > 出張決裁書 > 新規登録  </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<jsp:include page="/rms/admin/hokoku/middleMenuView.jsp" flush="false"/>		
</div>
<table width="95%" border="0" cellpadding="0" cellspacing="0" >
	<form name="searchDate"   method="post"  >
	<input type="hidden" name="bushopg" value="">	
	<tr>			
		<td style="padding: 0 10 1 0" align="right">
				<a class="topnav"  href="javascript:goJump('<%=bushoVal%>'); " onfocus="this.blur();">[:::::全体目録:::::]</a>				
    	</td>  				
	</tr>
</form>		
</table>
<div id="boxNoLine_900"  >		
<table  width="95%" border="0" cellspacing="2" cellpadding="2" >								
		<tr>
			<td style="padding-left:10px;padding-top:10px" class="calendar16_1">
				<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">  
				<% if(bushoVal.equals("1")){%>(品質管理部)<%}%>
				<% if(bushoVal.equals("2")){%>(製造部)<%}%>
				<% if(bushoVal.equals("3")){%>(管理部)<%}%>	
				<% if(bushoVal.equals("0")){%>(経営役員)<%}%>						
				<% if(bushoVal.equals("4")){%>(その他部)<%}%>				
			</td>
		</tr>
		<tr>
			<td style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
			</td>			
		</tr>	
</table>				

<table width="960"  class="tablebox" cellspacing="5" cellpadding="5">		
	<form name="frm" action="<%=urlPage%>rms/admin/write/insertTrip.jsp" method="post" >
	 <input type="hidden" name="day_of_week" value="<%=day_of_week%>">	 
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	 <input type="hidden" name="today_youbi" value="(<%=m_week%>)">	  
	 <input type="hidden" name="sign_ok_yn_boss" value="1">  <!--*** 1=사인전, 2=사인ok  -->
	 <input type="hidden" name="sign_ok_yn_bucho" value="1">	 		
	 <input type="hidden" name="lineCntVal" value="">	 
	 <input type="hidden" name="bushopg" value="<%=bushopg%>">
	<tr>			
				<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">承認者</span></td>
				<td  width="40%">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">					
						   <tr> 
<c:if test="${! empty listSignFix}">
	<input type="hidden" name="sign_yn" value="yes">						
	<c:forEach var="dbdata" items="${listSignFix}"   varStatus="idx"  >
					<input type="hidden" name="sign_ok_mseq" value="${dbdata.signup_mseq}">	
					<input type="hidden" name="title" value="${dbdata.destination}">												
							<td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr>
						        		<td align="center">${dbdata.destination}</td>
						        	</tr>
						        	<tr>
						        		<td align="center">${dbdata.nm}&nbsp;</td>
						        	</tr>
						        	</table>
						     </td>									
		</c:forEach>							
							<td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr>
						        		<td align="center">出張者</td>
						        	</tr>
						        	<tr>
						        		<td align="center"><%=name%>&nbsp;</td>
						        	</tr>
						        	</table>
						     </td>
						     	
	</c:if>										
	<c:if test="${empty listSignFix}">
		<input type="hidden" name="sign_yn" value="no">				
				<td> 
					<a href="JavaScript:checkCodeWrite(4);" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/signLineMenu.jpg" ></a>
					&nbsp;&nbsp;<font color="#807265">(▷選択してください)</font>
				</td>		
	</c:if>	
														
					</tr>					
					</table>					
				</td>
				<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">社員番号</span></td>
				<td  width="30%">${member.em_number}</td>			
			</tr>
			<tr >
				<td  width="15%"><font color="#CC0000">※</font><span class="titlename">出張期間登録</span> </td>
				<td  width="35%" valign="bottom">
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="lineCnt" class="select_type3" onChange="return doSubmitOnEnter();">
					<%for(int i=1;i<=31;i++){%>		
							<option value="<%=i%>" <%if(i==lineCnt){%>selected<%}%> ><%=i%>日間</option>
					<%}%>	
						</select>
					</div>	
						&nbsp;&nbsp;<font color="#807265">(▷出張スケジュールのライン生成)</font>
				</td>											
				<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張者所属</span></td>		
				<td  width="30%">
								    	<% if(busho.equals("0")){%>その他<%}%>										
										<% if(busho.equals("1")){%>品質管理 部<%}%>
										<% if(busho.equals("2")){%>製造 部<%}%>
										<% if(busho.equals("3")){%>管理 部<%}%>
										<% if(busho.equals("no data")){%>その他<%}%>	
    			</td>
    		</tr>
    		<tr>
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張者氏名</span></td>
				<td  ><%=name%> </td>
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">グレード</span></td>
				<td  >
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="grade" class="select_type3" >
								<option value="0">選択する</option>	
								<option value="Ⅰ" <%if(member.getPosition_level()==1){%>selected<%}%> >Ⅳ</option>
								<option value="Ⅱ" <%if(member.getPosition_level()==2){%>selected<%}%> >Ⅲ</option>
								<option value="Ⅲ" <%if(member.getPosition_level()==3){%>selected<%}%> >Ⅱ</option>
								<option value="Ⅳ" <%if(member.getPosition_level()==4){%>selected<%}%> >Ⅰ</option>
								<option value="Ⅴ" <%if(member.getPosition_level()==5){%>selected<%}%> >Ⅴ</option>
								<option value="Ⅵ" <%if(member.getPosition_level()==6){%>selected<%}%> >Ⅵ</option>
								<option value="Ⅶ" <%if(member.getPosition_level()==7){%>selected<%}%> >Ⅶ</option>
								<option value="Ⅷ" <%if(member.getPosition_level()==8){%>selected<%}%> >Ⅷ</option>									
						</select>
					</div>	
				</td>
			</tr>
			<tr >
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">パスポート英字氏名</span></td>
				<td ><input type="text" size="2" name='passportName'  value="<%=member.getHurigana()%>" class="input02" maxlength="50" style="width:180px"> <font color="#807265">(▷50文字以下)</font></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">危険度</span></td>		
				<td  >
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="danger" class="select_type3" >
							<option value="0">選択する</option>	
							<option value="危険度なし">危険度なし</option>	
							<option value="危険度1">危険度1</option>	
							<option value="危険度2">危険度2</option>
							<option value="危険度3">危険度3</option>	
							<option value="危険度4">危険度4</option>							
						</select>
					</div>	
				</td>							
    		</tr>
    		<tr >
				<td ><font color="#CC0000">※</font><span class="titlename">出張期間</span></td>
				<td >
					<input type="text" size="12%" name="during_begin" id="during_begin"  value="" style="text-align:center">
					～
					<input type="text" size="12%" name="during_end" id="during_end"  value="" style="text-align:center">					
				</td>
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出向先(国または県）</span></td>		
				<td  ><input type="text" size="2" name='destination'  value="" class="input02" maxlength="200" style="width:180px"></td>
    		</tr>		
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">出向先の情報<br>&nbsp;&nbsp;(HomePage)</span></td>
				<td ><input type="text" size="2" name='destination_info'  value="" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">渡航先での自動車<br>&nbsp;&nbsp;運転の有無</span></td>
				<td ><input type="text" size="2" name='drive_yn'  value="" class="input02" maxlength="50" style="width:180px"><font color="#807265">(▷50文字以下)</font></td>
			</tr>
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張の目的</span></td>
				<td ><textarea class="textarea2" name="reason" rows="3" cols="45"></textarea></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">備考:</span></td>
				<td ><input type="text" size="2" name='comment'  value="" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>				
			</tr>	
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張スケジュール</span></td>
				<td  colspan="3">
					<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr height="20" align="center">
							<td bgcolor="#f7f7f7" width="20%">日付(曜日)</td>							
							<td bgcolor="#f7f7f7" width="80%">摘要</td>
						</tr>
			<%					
					for(iSche=1;iSche<=lineCnt;iSche++){%>		
						<tr>
							<td align="center" >
								<input type="text" size="15%" name="sche_date" id="sche_date<%=iSche%>"  value="" style="text-align:center"></td>							
							<td >
							<input type="text" size="2" name="sche_comment" value="*" class="input02" maxlength="300" style="width:380px">
							<font color="#807265">(▷300文字以下)</font></td>
						</tr>						
			<%}%>
						<input type="hidden" name="cntSchedule" value="<%=iSche-1%>">										
					</table>
				</td>								
			</tr>					
</table>
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15px 0px 50px 0px;">
				<a href="JavaScript:goWrite()"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></A>
		<!--		<input type="Button" value="DONE" onclick="JavaScript:formSubmit(this.form)">  -->
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>
</form>				
</table>							

</div>

<script language="javascript">
function doSubmitOnEnter(){
	var frm=document.frm;
	frm.lineCntVal.value=frm.lineCnt.value;	
	frm.action = "<%=urlPage%>rms/admin/hokoku/write/writeTripForm.jsp";	
	frm.submit();
}

function goJump(busho) {    
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/listForm.jsp";
    document.searchDate.submit();
}
function goJumpTripBogo(busho) {    	
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/listTripBogoForm.jsp";
    document.searchDate.submit();
}
function goJumpHoliBogo(busho) {    	
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp";
    document.searchDate.submit();
}
</script>
		
	
	
	
	
	
	
	
	
	
	
	
