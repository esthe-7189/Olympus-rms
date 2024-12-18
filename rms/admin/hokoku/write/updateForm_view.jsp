<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripKesaisho" %>
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
String pass=""; int mseq=0; int level=0; int dbPosiLevel=0; int lineCnt=0; int iSche=0; int icnt=0;
String position="";
String busho="";

String inDate=dateFormat.format(new java.util.Date());		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String seq = request.getParameter("fno");
String lineVal=request.getParameter("lineVal");
if(lineVal==null){lineVal="2";}

String lineCntVal=request.getParameter("lineCntVal");
if(lineCntVal==null){lineCnt=0;}
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
	
	DataMgrTripKesaisho mgrKin=DataMgrTripKesaisho.getInstance();
	DataBeanHokoku mgrHokoku=mgrKin.getDb(Integer.parseInt(seq));
	String gradeVal= mgrHokoku.getGrade();
	String dangerVal=mgrHokoku.getDanger();
		
	String bushoVal="";
		if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){	
			 bushoVal=bushopg;	
		}else{
			bushoVal=busho;
		}	

	int levelKubun=0;
	if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
	List listSign=manager.selectJangyo(1,levelKubun,bushoVal); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
	Member memSign;	
	List listCon= mgrKin.listCon(Integer.parseInt(seq));

%>
<c:set var="member" value="<%=member%>"/>
<c:set var="listSign" value="<%= listSign %>" />				
	
<script type="text/javascript">		

function goWrite(){	
var frm= document.frm;
if(frm.title01.value ==""){alert("一番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.title02.value ==""){alert("二番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.destination_info.value ==""){frm.destination_info.value=".";}
if(frm.destination.value ==""){frm.destination.value=".";}
if(frm.drive_yn.value ==""){frm.drive_yn.value=".";}
if(frm.reason.value ==""){frm.reason.value=".";}
if(frm.comment.value ==""){frm.comment.value=".";}

var sdate=document.getElementsByName("sche_date");
var sdateval=0;
for(var i=0;i<sdate.length;i++){
	sdateval=i+1;
	if(sdate[i].value ==""){alert("("+sdateval+")番目の出張スケジュールを入力して下さい！");return;}
}	
		
if ( confirm("修正しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/hokoku/write/update.jsp";	
frm.submit();
}
function goInit(){	
	location.href = "<%=urlPage%>rms/admin/hokoku/write/updateForm.jsp?fno=<%=seq%>";	
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
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">出張/休日勤務 > 出張決裁書 > 書き直す   </span> 
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
			<td style="padding-left:10px;" class="calendar16_1">
				<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">  
				<% if(bushoVal.equals("1")){%>(品質管理部)<%}%>
				<% if(bushoVal.equals("2")){%>(製造部)<%}%>
				<% if(bushoVal.equals("3")){%>(管理部)<%}%>	
				<% if(bushoVal.equals("0")){%>(経営役員)<%}%>						
				<% if(bushoVal.equals("4")){%>(その他部)<%}%>				
			</td>
			<td>
			<font color="#CC0000">※</font>必修です。				
			</td>	
		</tr>		
		<%if(mgrHokoku.getSign_ok_yn_boss()==3 || mgrHokoku.getSign_ok_yn_bucho()==3 ){%>		
		<tr>
			<td width="15%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">  差戻し理由: 			
			</td>
			<td width="85%" align="left"  style="padding-left:10px;padding-top:10px" >				
				<%if(mgrHokoku.getSign_ok_yn_boss()==3 ){%><font color="#CC0000">===></font><%=mgrHokoku.getTitle01()%>:  <%=mgrHokoku.getSign_no_riyu_boss()%><br>  <%}%>				
				<%if(mgrHokoku.getSign_ok_yn_bucho()==3 ){%><font color="#CC0000">===></font><%=mgrHokoku.getTitle02()%>:  <%=mgrHokoku.getSign_no_riyu_bucho()%>   <%}%>
			</td>			
		</tr>
	<%}%>		
</table>				

<table width="960"  class="tablebox" cellspacing="5" cellpadding="5">			 
	<form name="frm" action="<%=urlPage%>rms/admin/hokoku/write/update.jsp" method="post" >
	 <input type="hidden" name="day_of_week" value="<%=day_of_week%>">	 
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	 <input type="hidden" name="today_youbi" value="(<%=m_week%>)">	  
	 <input type="hidden" name="sign_ok_yn_boss" value="1">  <!--*** 1=사인전, 2=사인ok  -->
	 <input type="hidden" name="sign_ok_yn_bucho" value="1">	 		
	 <input type="hidden" name="lineCntVal" value="">	 
	 <input type="hidden" name="bushopg" value="<%=bushoVal%>">
	 <input type="hidden" name="fno" value="<%=seq%>">
	 <input type="hidden" name="lineVal" value="">		
	<tr>
		
		<td  width="15%"><font color="#CC0000">※</font><span class="titlename">出張日数追加</span></td>
		<td  width="35%">
		<input type="radio" name="fellow_yn" value="1" onClick="fellow01()" onfocus="this.blur()"  <%if(lineVal.equals("1")){%>checked<%}%>><font  color="#FF6600">修正する</font>
		<input type="radio" name="fellow_yn" value="2" onClick="fellow02(<%=seq%>);" onfocus="this.blur()"  <%if(lineVal.equals("2")){%>checked<%}%>><font  color="#FF6600">しない</font>		 
				<div id="fellow" style="display:none;overflow:hidden ;width:420;border:1px solid #99CC00;" >			
		
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="lineCnt" class="select_type3" onChange="return doSubmitOnEnter();">
							<option value="0" >日数追加</option>
					<%for(int i=1;i<=31;i++){%>		
							<option value="<%=i%>" <%if(i==lineCnt){%>selected<%}%> ><%=i%>日間</option>
					<%}%>	
						</select>
					</div>	
						<font color="#807265">(▷出張スケジュールのライン生成)</font>
			</div>	
				</td>
				<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">承認者選択</span></td>
				<td  width="85%" >	  
					<table width="100%" border="0" cellspacing="0" cellpadding="0">					
						<tr> 										
							<td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr height="22">
						        		<td align=""><input type="text" size="2" name='title01'  value="<%=mgrHokoku.getTitle01()%>" class="input02" maxlength="20" style="width:80px"></td>
						        	</tr>
						        	<tr height="22">
						        		<td align="center">
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="sign_ok_mseq_boss" class="select_type3"  >																		
			<c:if test="${! empty  listSign}">
				<%	int i=1;
					Iterator listiter=listSign.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
						int memId=mgrHokoku.getSign_ok_mseq_boss();
											
				%>					
							<option value="<%=mem.getMseq()%>" <%if(memId==mem.getMseq()){%>selected<%}%> ><%=mem.getNm()%></option>	
				<%i++;}%>	
			</c:if>
			<c:if test="${empty list}">
				--
			</c:if>		
					</select>
					</div>	
						    
						    			</td>
						        	</tr>
						        	</table>
						     </td>
						     <td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr height="22">
						        		<td align=""><input type="text" size="2" name='title02'  value="<%=mgrHokoku.getTitle02()%>" class="input02" maxlength="20" style="width:80px"></td>
						        	</tr>
						        	<tr height="22">
						        		<td align="center">
				<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="sign_ok_mseq_bucho" class="select_type3" >										
			<c:if test="${! empty  listSign}">
				<%	int i=1;
					Iterator listiter=listSign.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
						int memId=mgrHokoku.getSign_ok_mseq_bucho();						
										
				%>					
							<option value="<%=mem.getMseq()%>" <%if(memId==mem.getMseq()){%>selected<%}%>><%=mem.getNm()%></option>	
				<%i++;}%>	
			</c:if>
			<c:if test="${empty list}">
				--
			</c:if>		
					</select>
					</div>	
						    
						    			</td>
						        	</tr>
						        	</table>
							</td>								
							<td height="15" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr height="22">
						        		<td align="center" style="padding: 3 0 3 0;"><input type="text" size="2" name='title02'  value="出張者" class="input02" maxlength="20" style="width:80px" readonly></td>
						        	</tr>
						        	<tr height="22">
						        		<td align="center" style="padding: 4 0 4 0;"><%=name%></td>
						        	</tr>
						        	</table>
							</td>
						</tr>
					</table>
				</td>							
			</tr>
			<tr >
				<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">社員番号</span></td>
				<td  width="35%">${member.em_number}</td>
				<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張者所属</span></td>		
				<td  width="35%">
								    	<% if(busho.equals("0")){%>経営役員<%}%>										
										<% if(busho.equals("1")){%>品質管理 部<%}%>
										<% if(busho.equals("2")){%>製造 部<%}%>
										<% if(busho.equals("3")){%>管理 部<%}%>
										<% if(busho.equals("4")){%>その他<%}%>	
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
							<option value="Ⅰ" <%if(gradeVal.equals("Ⅰ")){%>selected<%}%> >Ⅰ</option>									
							<option value="Ⅱ" <%if(gradeVal.equals("Ⅱ")){%>selected<%}%>>Ⅱ</option>	
							<option value="Ⅲ" <%if(gradeVal.equals("Ⅲ")){%>selected<%}%>>Ⅲ</option>
							<option value="Ⅳ" <%if(gradeVal.equals("Ⅳ")){%>selected<%}%>>Ⅳ</option>	
							<option value="Ⅴ" <%if(gradeVal.equals("Ⅴ")){%>selected<%}%>>Ⅴ</option>	
							<option value="Ⅵ" <%if(gradeVal.equals("Ⅵ")){%>selected<%}%>>Ⅵ</option>	
							<option value="Ⅶ" <%if(gradeVal.equals("Ⅶ")){%>selected<%}%>>Ⅶ</option>	
							<option value="Ⅷ" <%if(gradeVal.equals("Ⅷ")){%>selected<%}%>>Ⅷ</option>	
						</select>
					</div>	
				</td>
			</tr>
			<tr >
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">パスポート英字氏名</span></td>
				<td ><input type="text" size="2" name='passportName'  value="<%=mgrHokoku.getPassportName()%>" class="input02" maxlength="50" style="width:180px"> <font color="#807265">(▷50文字以下)</font></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">危険度</span></td>		
				<td  >
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="danger" class="select_type3" >
							<option value="0">選択する</option>	
							<option value="危険度なし" <%if(dangerVal.equals("危険度なし")){%>selected<%}%>>危険度なし</option>	
							<option value="危険度1" <%if(dangerVal.equals("危険度1")){%>selected<%}%>>危険度1</option>	
							<option value="危険度2" <%if(dangerVal.equals("危険度2")){%>selected<%}%>>危険度2</option>
							<option value="危険度3" <%if(dangerVal.equals("危険度3")){%>selected<%}%>>危険度3</option>	
							<option value="危険度4" <%if(dangerVal.equals("危険度4")){%>selected<%}%>>危険度4</option>							
						</select>
					</div>	
				</td>							
    		</tr>
    		<tr >
				<td ><font color="#CC0000">※</font><span class="titlename">出張期間</span></td>
				<td >
					<input type="text" size="12%" name="during_begin" id="during_begin" value="<%=mgrHokoku.getDuring_begin()%>" style="text-align:center">  ～
					<input type="text" size="12%" name="during_end" id="during_end" value="<%=mgrHokoku.getDuring_end()%>" style="text-align:center">
				</td>
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出向先(国または県）</span></td>		
				<td  ><input type="text" size="2" name='destination'  value="<%=mgrHokoku.getDestination()%>" class="input02" maxlength="200" style="width:180px"></td>
    		</tr>		
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">出向先の情報<br>&nbsp;&nbsp;(HomePage)</span></td>
				<td ><input type="text" size="2" name='destination_info'  value="<%=mgrHokoku.getDestination_info()%>" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">渡航先での自動車<br>&nbsp;&nbsp;運転の有無</span></td>
				<td ><input type="text" size="2" name='drive_yn'  value="<%=mgrHokoku.getDrive_yn()%>" class="input02" maxlength="50" style="width:180px"><font color="#807265">(▷50文字以下)</font></td>
			</tr>
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張の目的</span></td>
				<td ><textarea class="textarea2" name="reason" rows="3" cols="45"><%=mgrHokoku.getReason()%></textarea></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">備考:</span></td>
				<td ><input type="text" size="2" name='comment'  value="<%=mgrHokoku.getComment()%>" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>				
			</tr>	
			<tr >
				<td >
					<img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename"><%if(lineVal.equals("1")){%><font color="red">[修正]</font><br><%}%>出張スケジュール</span></td>
				<td  colspan="3">
					<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr height="20" align="center">
							<td bgcolor="#f7f7f7" width="20%">日付(曜日)</td>							
							<td bgcolor="#f7f7f7" width="80%">摘要</td>
						</tr>
				<c:set var="listCon" value="<%=listCon %>" />					
					<c:if test="${!empty listCon}">
								<%	icnt=1;
									Iterator listiter2=listCon.iterator();					
										while (listiter2.hasNext()){
										DataBeanHokoku dbCon=(DataBeanHokoku)listiter2.next();
										int seqq=dbCon.getSeq();
															
								%>
								<input type="hidden" name="seqCon" value="<%=seqq%>">		
<script>
	$(function() {
	   $("#sche_datedb<%=icnt%>").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
	    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); }); 
</script>	
											<tr>
											<td align="center" >
												<input type="text" size="15%" name="sche_date" id="sche_datedb<%=icnt%>"  value="<%=dbCon.getSche_date()%>" style="text-align:center"></td>							
											<td >
												<input type="text" size="2" name="sche_comment" value="<%=dbCon.getSche_comment()%>" class="input02" maxlength="300" style="width:380px">
											<font color="#807265">(▷300文字以下)</font>
											</td>
										</tr>								
								<%
								icnt++;
								}%>	
					</c:if>
					<c:if test="${empty listCon}">
					--
					</c:if>	
						<input type="hidden" name="cntSchedule01" value="<%=icnt-1%>">						
						<%					
					for(iSche=1;iSche<=lineCnt;iSche++){%>		
						<tr>
							<td align="center" >
								<input type="text" size="15%" name="sche_date" id="sche_date<%=iSche%>" style="text-align:center"></td>							
							<td >
							<input type="text" size="2" name="sche_comment" value="" class="input02" maxlength="300" style="width:380px">
							<font color="#807265">(▷300文字以下)</font></td>
						</tr>						
					<%}%>
						<input type="hidden" name="cntSchedule02" value="<%=iSche-1%>">										
					</table>
				</td>								
			</tr>							
</table>
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15px 0px 50px 0px;">
				<a href="JavaScript:goWrite()"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></a>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></a>
			</td>			
	</tr>
</form>				
</table>				
</div>
<script language="javascript">
function doSubmitOnEnter(){
	var frm=document.frm;
	var lineVal="";
	if(document.getElementsByName("fellow_yn")[0].checked == true){
		lineVal="1";
	}else if(document.getElementsByName("fellow_yn")[1].checked == true){ 
		lineVal="2";
	}
	
	frm.lineCntVal.value=frm.lineCnt.value;	
	frm.fno.value=frm.fno.value;
	frm.lineVal.value=lineVal;	
	frm.action = "<%=urlPage%>rms/admin/hokoku/write/updateForm.jsp";	
	frm.submit();
}
function fellow01(){document.getElementById("fellow").style.display=''; }
function fellow02(){
	var frm=document.frm;
	document.getElementById("fellow").style.display='none'; 	
	
	var lineVal="";
	if(document.getElementsByName("fellow_yn")[0].checked == true){
		lineVal="1";
	}else if(document.getElementsByName("fellow_yn")[1].checked == true){ 
		lineVal="0";
	}
	
	frm.lineCntVal.value="0";	
	frm.fno.value=frm.fno.value;
	frm.lineVal.value=lineVal;		
	frm.action = "<%=urlPage%>rms/admin/hokoku/write/updateForm.jsp";	
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

