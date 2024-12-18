<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>
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
	
	DataMgrTripHokoku mgrKin=DataMgrTripHokoku.getInstance();
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
	List listSign=manager.selectJangyo(1,levelKubun,bushoVal); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
	Member memSign;	
	
	String seasonVal=mgrHokoku.getReason().replaceAll("<br>","\r\n");
	

%>
<c:set var="member" value="<%=member%>"/>
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

if(frm.title01.value ==""){alert("一番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.title02.value ==""){alert("二番目の承認者/職名(階級)を入力して下さい"); return;}
if(frm.destination.value ==""){frm.destination.value=".";}
if(frm.during_begin.value ==""){alert("出張期間を選択してください"); return;}
if(frm.during_end.value ==""){frm.during_end.value=frm.during_begin.value;}
if(frm.reason.value ==""){frm.reason.value=".";}
if(frm.comment.value ==""){frm.comment.value=".";}

if ( confirm("修正しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/hokoku/writeTripBogo/update.jsp";	
frm.submit();
}
function goInit(){
	document.frm.reset();
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
   $("#during_begin").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#during_end").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

</script>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">出張/休日勤務 > 出張報告書 > 書き直す   </span> 
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
				<a class="topnav"  href="javascript:goJumpTripBogo('<%=bushoVal%>'); " onfocus="this.blur();">[:::::全体目録:::::]</a>					
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
	<form name="frm"   method="post"  >
	 <input type="hidden" name="day_of_week" value="<%=day_of_week%>">	 
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	 <input type="hidden" name="today_youbi" value="(<%=m_week%>)">	  
	 <input type="hidden" name="sign_ok_yn_boss" value="1">  <!--*** 1=사인전, 2=사인ok  -->
	 <input type="hidden" name="sign_ok_yn_bucho" value="1">	 		
	 <input type="hidden" name="lineCntVal" value="">	 
	 <input type="hidden" name="bushopg" value="<%=bushopg%>">
	 <input type="hidden" name="fno" value="<%=seq%>">
	 <input type="hidden" name="lineVal" value="">
	 
	<tr>		
				<td><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張者氏名</span></td>
				<td><%=name%> </td>
				<td><img src="<%=urlPage%>rms/image/icon_s.gif"><span class="titlename">承認者選択</span></td>
				<td>
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
						        		<td><input type="text" size="2" name='title02'  value="<%=mgrHokoku.getTitle02()%>" class="input02" maxlength="20" style="width:80px"></td>
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
						        		<td align="center" style="padding: 3 0 3 0;"><span class="titlename">出張者</span></td>
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
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張先</span></td>		
				<td  ><input type="text" size="2" name='destination'  value="<%=mgrHokoku.getDestination()%>" class="input02" maxlength="200" style="width:300px"></td>
				<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張者所属</span></td>		
				<td  width="35%">
								    	<% if(busho.equals("0")){%>その他<%}%>										
										<% if(busho.equals("1")){%>品質管理 部<%}%>
										<% if(busho.equals("2")){%>製造 部<%}%>
										<% if(busho.equals("3")){%>管理 部<%}%>
										<% if(busho.equals("no data")){%>その他<%}%>
										<% if(busho.equals("4")){%>その他<%}%>.	
    			</td>
    		</tr>
    		<tr>
				<td ><font color="#CC0000">※</font><span class="titlename">出張期間</span></td>
				<td  colspan="3">					
					<input type="text" size="12%" name='during_begin' id="during_begin"  value="<%=mgrHokoku.getDuring_begin()%>" style="text-align:center">  ～
					<input type="text" size="12%" name='during_end' id="during_end"  value="<%=mgrHokoku.getDuring_end()%>" style="text-align:center">				
				</td>				
			</tr>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">出張の目的</span></td>
				<td  colspan="3"><textarea class="textarea2" name="reason" rows="5" cols="70"><%=seasonVal%></textarea></td>			
			<tr >
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">実施事項</span></td>
				<td align="right"  colspan="3" style="padding: 0px 50px 0px 0px"><select id="cmbLanguages" onchange="ChangeLanguage(this.value);"></select></td>												
			</tr>
			<tr >
				<td colspan="4" style="padding: 0px 0px 0px 0px" align="center">						
			
								<FCK:editor id="comment" basePath="/fckeditor/" 
									width="100%"
									height="400"
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
										
<!--								
									<FCK:editor id="comment" basePath="/orms/fckeditor/"
									width="90%"
									height="400"				
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
				</td>												
			</tr>					
</table>
<table  width="960" border="0" cellspacing="0" cellpadding="0" >												
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
	frm.action = "<%=urlPage%>rms/admin/hokoku/writeTripBogo/updateForm.jsp";	
	frm.submit();
}
function fellow01(){document.getElementById("fellow").style.display=''; }
function fellow02(){document.getElementById("fellow").style.display='none'; }
function goJump(busho) {    
	document.frm.bushopg.value =busho;    
	document.frm.action = "<%=urlPage%>rms/admin/hokoku/listForm.jsp";
    document.frm.submit();
}
function goJumpTripBogo(busho) {    	
	document.frm.bushopg.value =busho;    
	document.frm.action = "<%=urlPage%>rms/admin/hokoku/listTripBogoForm.jsp";
    document.frm.submit();
}
function goJumpHoliBogo(busho) {    	
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp";
    document.searchDate.submit();
}
</script>

