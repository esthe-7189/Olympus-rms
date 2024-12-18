<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
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
	
	DataMgrHoliHokoku mgrKin=DataMgrHoliHokoku.getInstance();
	DataBeanHokoku mgrHokoku=mgrKin.getDb(Integer.parseInt(seq));
	
	String bushopg=request.getParameter("bushopg");
	if(bushopg==null){bushopg="1";}
	String bushoVal="";
		if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){	
			 bushoVal=bushopg;	
		}else{
			bushoVal=busho;
		}	
	int levelKubun=0;
	if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
	List listSign=manager.selectMulty(1,4); //position level 1~4, 모든부서(1=品質管理部,2=製造部 ,3=管理部)
	Member memSign;	
	
	String seasonVal=mgrHokoku.getReason().replaceAll("<br>","\r\n");

%>
<c:set var="member" value="<%=member%>"/>
<c:set var="listSign" value="<%= listSign %>" />				
<c:set var="mgrHokoku" value="<%= mgrHokoku %>" />		
<script type="text/javascript">
window.onload = function() {
		PlanTime(); 
		HoliTime();
	}
	
function PlanTime() {
   totalHHMM=0;
   resultHH=0;
   resultMM=0;	
  	planh=eval(document.getElementById("plan_begin_hh").value);
  	planm=eval(document.getElementById("plan_begin_mm").value);
  	planhhEnd=eval(document.getElementById("plan_end_hh").value);
  	planmmEnd=eval(document.getElementById("plan_end_mm").value);						
	totalHHMM=(planhhEnd*60+planmmEnd)-(planh*60+planm);
	resultHH=Math.floor(totalHHMM/60);
	resultMM=Math.floor(totalHHMM%60);
	document.getElementById("plan_begin_hh_result").value =resultHH ;
	document.getElementById("plan_begin_mm_result").value =resultMM ;
	}
function HoliTime() {
   totalHHMM=0;
   resultHH=0;
   resultMM=0;	
  	planh=eval(document.getElementById("rest_begin_hh").value);
  	planm=eval(document.getElementById("rest_begin_mm").value);
  	planhhEnd=eval(document.getElementById("rest_end_hh").value);
  	planmmEnd=eval(document.getElementById("rest_end_mm").value);
	totalHHMM=(planhhEnd*60+planmmEnd)-(planh*60+planm);
	resultHH=Math.floor(totalHHMM/60);
	resultMM=Math.floor(totalHHMM%60);		
	document.getElementById("rest_begin_hh_result").value =resultHH ;
	document.getElementById("rest_begin_mm_result").value =resultMM ;
}
	

function goWrite(){	
var frm= document.frm;
if(frm.title01.value ==""){alert("一番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.title02.value ==""){alert("二番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.title03.value ==""){alert("三番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.title04.value ==""){alert("四番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.theday.value ==""){alert("出張期間を選択してください"); return;}
if(frm.reason.value ==""){frm.reason.value=".";}
if(frm.comment.value ==""){frm.comment.value=".";}
if(isNotNumber(frm.rest_begin_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.rest_begin_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.rest_end_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.rest_end_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.plan_begin_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.plan_begin_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.plan_end_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.plan_end_mm, "mm形式で入力して下さい。!")) return;

if ( confirm("修正しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/update.jsp";	
frm.submit();
}

</script>
<script type="text/javascript">
function FCKeditor_OnComplete( editorInstance ){
	var oCombo = document.getElementById( 'cmbLanguages' ) ;
	for ( code in editorInstance.Language.AvailableLanguages )	{
		AddComboOption( oCombo, editorInstance.Language.AvailableLanguages[code] + ' (' + code + ')', code ) ;
	}
	oCombo.value = editorInstance.Language.ActiveLanguage.Code ;
}	

function AddComboOption(combo, optionText, optionValue){
	var oOption = document.createElement("OPTION") ;
	combo.options.add(oOption) ;
	oOption.innerHTML = optionText ;
	oOption.value     = optionValue ;	
	return oOption ;
}

function ChangeLanguage( languageCode ){
	window.location.href = window.location.pathname + "?code=" + languageCode+"&fno=<%=seq%>" ;
}
</script>
<%
String autoDetectLanguageStr;
String defaultLanguageStr;
String codeStr=request.getParameter("code");
if(codeStr==null) {
	autoDetectLanguageStr="true";
	defaultLanguageStr="en";
}
else {
	autoDetectLanguageStr="false";
	defaultLanguageStr=codeStr;
}
%>
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#theday").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

</script>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">出張/休日勤務 > 休日出勤申請書 > 書き直す   </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<jsp:include page="/rms/admin/hokoku/middleMenuView.jsp" flush="false"/>		
</div>
<table width="95%" border="0" cellpadding="0" cellspacing="0" >
	<form name="searchDate"   action="<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp" method="post"  >		
		<input type="hidden" name="bushopg" value="<%=bushoVal%>">
	<tr>			
		<td style="padding: 0 10 1 0" align="right">
			<a class="topnav"  href="javascript:goJumpHoliBogo('<%=bushoVal%>');" onfocus="this.blur();">[:::::全体目録:::::]</a>			
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
			<td>
				<font color="#CC0000">※</font>必修です。				
			</td>	
		</tr>		
		<%if(mgrHokoku.getSign_ok_yn_boss()==3 || mgrHokoku.getSign_ok_yn_bucho()==3 || mgrHokoku.getSign_ok_yn_bucho2()==3 || mgrHokoku.getSign_ok_yn_kanribu()==3){%>		
		<tr>
			<td width="15%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">  差戻し理由: 			
			</td>
			<td width="85%" align="left"  style="padding-left:10px;padding-top:10px" >				
				<%if(mgrHokoku.getSign_ok_yn_boss()==3 ){%><font color="#CC0000">===></font><%=mgrHokoku.getTitle01()%>:  <%=mgrHokoku.getSign_no_riyu_boss()%><br>  <%}%>				
				<%if(mgrHokoku.getSign_ok_yn_bucho()==3 ){%><font color="#CC0000">===></font><%=mgrHokoku.getTitle02()%>:  <%=mgrHokoku.getSign_no_riyu_bucho()%>   <%}%>
				<%if(mgrHokoku.getSign_ok_yn_bucho2()==3 ){%><font color="#CC0000">===></font><%=mgrHokoku.getTitle03()%>:  <%=mgrHokoku.getSign_no_riyu_bucho2()%>   <%}%>
				<%if(mgrHokoku.getSign_ok_yn_kanribu()==3 ){%><font color="#CC0000">===></font><%=mgrHokoku.getTitle04()%>:  <%=mgrHokoku.getSign_no_riyu_kanribu()%>   <%}%>
			</td>			
		</tr>
		<%}%>
</table>

<c:if test="${! empty mgrHokoku}" />
<table width="960"  class="tablebox" cellspacing="5" cellpadding="5" >
	<form name="frm" action="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/update.jsp" method="post" >
	<input type="hidden" name="day_of_week" value="<%=day_of_week%>">	 
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	 <input type="hidden" name="today_youbi" value="(<%=m_week%>)">	  
	 <input type="hidden" name="sign_ok_yn_boss" value="1">  <!--*** 1=사인전, 2=사인ok  -->
	 <input type="hidden" name="sign_ok_yn_bucho" value="1">	
	 <input type="hidden" name="sign_ok_yn_bucho2" value="1">	
	 <input type="hidden" name="sign_ok_yn_kanribu" value="1">	  		
	 <input type="hidden" name="lineCntVal" value="">	 
	 <input type="hidden" name="bushopg" value="<%=bushoVal%>">	 
	 <input type="hidden" name="fno" value="<%=seq%>">
	 
			<tr>		
				<td width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">所 属</span></td>		
				<td width="35%">
								    	<% if(busho.equals("0")){%>その他<%}%>										
										<% if(busho.equals("1")){%>品質管理 部<%}%>
										<% if(busho.equals("2")){%>製造 部<%}%>										
										<% if(busho.equals("no data")){%>その他<%}%>.
									<!--<% if(busho.equals("3")){%>管理 部<%}%>-->	
    				</td>
				<td width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">氏 名</span></td>
				<td width="35%"><%=name%> </td>
			</tr>
			<tr>
				<td  align="center" colspan="4" style="padding:5px 0px 5px 0px">
					<font color="#009900">*************下記の通り休日出勤の申請をします。***************</font>
				</td>
			</tr>			
			<tr>
				<td><font color="#CC0000">※</font><span class="titlename">月 日</span></td>
				<td colspan="3">
					<input type="text" size="15%" name='theday' id="theday"  value="<%=mgrHokoku.getTheday()%>" style="text-align:center">  
					
				</td>				
			</tr>
			<tr>
				<td><font color="#CC0000">※</font><span class="titlename">予定時間</span></td>
				<td colspan="3">
					<input type="text" size="2" name='plan_begin_hh'  id="plan_begin_hh" value="<%=mgrHokoku.getPlan_begin_hh()%>" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name='plan_begin_mm'  id="plan_begin_mm" value="<%=mgrHokoku.getPlan_begin_mm()%>" class="box" maxlength="2" style="width:25px">分 
					～
					<input type="text" size="2" name='plan_end_hh'  id="plan_end_hh" value="<%=mgrHokoku.getPlan_end_hh()%>" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name='plan_end_mm'  id="plan_end_mm" value="<%=mgrHokoku.getPlan_end_mm()%>" class="box" maxlength="2" style="width:25px">分
					
					（<a onclick="PlanTime();" style="CURSOR: pointer;">	
					  <img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動計算入力"></a>
						<input type="text" size="2" name='plan_begin_hh_result'  id="plan_begin_hh_result" value="00" class="box" maxlength="2" style="width:25px"> 時間
					　<input type="text" size="2" name='plan_begin_mm_result'  id="plan_begin_mm_result" value="00" class="box" maxlength="2" style="width:25px">　分）										
				</td>	
			</tr>
			<tr>
				<td><font color="#CC0000">※</font><span class="titlename">休憩時間</span></td>
				<td colspan="3">
					<input type="text" size="2" name='rest_begin_hh'  id="rest_begin_hh" value="<%=mgrHokoku.getRest_begin_hh()%>" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name='rest_begin_mm'  id="rest_begin_mm" value="<%=mgrHokoku.getRest_begin_mm()%>" class="box" maxlength="2" style="width:25px">分 
					～
					<input type="text" size="2" name='rest_end_hh'  id="rest_end_hh" value="<%=mgrHokoku.getRest_end_hh()%>" class="box" maxlength="2" style="width:25px">時
					<input type="text" size="2" name='rest_end_mm'  id="rest_end_mm" value="<%=mgrHokoku.getRest_end_mm()%>" class="box" maxlength="2" style="width:25px">分
					
  					（<a onclick="HoliTime();" style="CURSOR: pointer;">	
					  <img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動計算入力"></a>
						<input type="text" size="2" name='rest_begin_hh_result'  id="rest_begin_hh_result" value="00" class="box" maxlength="2" style="width:25px"> 時間
					　<input type="text" size="2" name='rest_begin_mm_result'  id="rest_begin_mm_result" value="00" class="box" maxlength="2" style="width:25px"> 分）								
				</td>	
			</tr>					
			<tr>
				<td><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">業務内容</span></td>
				<td colspan="3" style="padding: 3 0 3 0">						
						<select id="cmbLanguages" onchange="ChangeLanguage(this.value);"></select><br>
<!--						
			<FCK:editor id="comment" basePath="/orms/fckeditor/" toolbarSet="Basic02" 									
				autoDetectLanguage="<%=autoDetectLanguageStr%>"
				defaultLanguage="<%=defaultLanguageStr%>"
				imageBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector" 				
				linkBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector"
				flashBrowserURL="/orms/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/orms/editor/filemanager/browser/default/connectors/jsp/connector"
				imageUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=Image"
				linkUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=File"
				flashUploadURL="/orms/editor/filemanager/upload/simpleuploader?Type=Flash">
				<%=mgrHokoku.getComment()%>									
			</FCK:editor>
-->			
			
				
			
			<FCK:editor id="comment" basePath="/fckeditor/" toolbarSet="Basic02" 									
				autoDetectLanguage="<%=autoDetectLanguageStr%>"
				defaultLanguage="<%=defaultLanguageStr%>"
				imageBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/editor/filemanager/browser/default/connectors/jsp/connector" 				
				linkBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
				flashBrowserURL="/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
				imageUploadURL="/editor/filemanager/upload/simpleuploader?Type=Image"
				linkUploadURL="/editor/filemanager/upload/simpleuploader?Type=File"
				flashUploadURL="/editor/filemanager/upload/simpleuploader?Type=Flash">										
					<%=mgrHokoku.getComment()%>				
			</FCK:editor>
				</td>				
			</tr >		
			<tr>
				<td><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">申請理由</span></td>
				<td colspan="3"><textarea class="textarea2" name="reason" rows="5" cols="100"><%=seasonVal%></textarea></td>				
			</tr >					
			<tr>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">承認者選択</span></td>
				<td align="" colspan="3">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">					
						<tr> 										
							<td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr height="22">
						        		<td align=""><input type="text" size="2" name='title01'  value="<%=mgrHokoku.getTitle01()%>" class="box" maxlength="20" style="width:80px"></td>
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
						        		<td align=""><input type="text" size="2" name='title02'  value="<%=mgrHokoku.getTitle02()%>" class="box" maxlength="20" style="width:80px"></td>
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
							<td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr height="22">
						        		<td align=""><input type="text" size="2" name='title03'  value="<%=mgrHokoku.getTitle03()%>" class="box" maxlength="20" style="width:80px"></td>
						        	</tr>
						        	<tr height="22">
						        		<td align="center">
				<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="sign_ok_mseq_bucho2" class="select_type3" >										
			<c:if test="${! empty  listSign}">
				<%	int i=1;
					Iterator listiter=listSign.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
						int memId=mgrHokoku.getSign_ok_mseq_bucho2();
										
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
							<td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						        	<tr height="22">
						        		<td align=""><input type="text" size="2" name='title04'  value="<%=mgrHokoku.getTitle04()%>" class="box" maxlength="20" style="width:80px"></td>
						        	</tr>
						        	<tr height="22">
						        		<td align="center">
				<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="sign_ok_mseq_kanribu" class="select_type3" >
							<option value="0">管理部...選択</option>	
										
			<c:if test="${! empty  listSign}">
				<%	int i=1;
					Iterator listiter=listSign.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
						int memId=mgrHokoku.getSign_ok_mseq_kanribu();
										
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
						        		<td align="center" style="padding: 3 0 3 0;">申請者</td>
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
</table>																		
</div>
<table  width="960" border="0" cellspacing="0" cellpadding="0" >												
	<tr>				
			<td align="center" style="padding:15px 0px 50px 0px;">
				<a href="JavaScript:goWrite()"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></a>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></a>
			</td>			
	</tr>
</table>										
</form>

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
	frm.action = "<%=urlPage%>rms/admin/hokoku/writeTripBogo/updateForm.jsp";	
	frm.submit();
}
function fellow01(){document.getElementById("fellow").style.display=''; }
function fellow02(){document.getElementById("fellow").style.display='none'; }
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

