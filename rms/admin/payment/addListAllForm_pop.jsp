<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "org.apache.poi.*" %>

<%! 
NumberFormat currency = NumberFormat.getCurrencyInstance(Locale.KOREA);
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
String urlPage=request.getContextPath()+"/rms/";
String urlPage2=request.getContextPath()+"/orms/";	
String id=(String)session.getAttribute("ID");
String docontact=request.getParameter("docontact");
	if(docontact==null){docontact="1";}
String btn=request.getParameter("btn");
	if(btn==null){btn="A";}
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");
String page_list=request.getParameter("page");
String submit_yn=request.getParameter("submit_yn");
String inDate=dateFormat.format(new java.util.Date());
String bunDay=inDate.substring(5,7);
int monv=Integer.parseInt(bunDay);
int mseq=0;
	MemberManager manager=MemberManager.getInstance();
	Member member=manager.getMember(id);
	if(member!=null){		
		mseq=member.getMseq();
	}
List listFollow=manager.selectListSchedule(1,6);
CateMgr mgrpay=CateMgr.getInstance();	
FileMgr mgritem=FileMgr.getInstance();	

List list01=mgrpay.listClient(1);
List list02=mgrpay.listClient(2);
%>
<c:set var="list01" value="<%= list01%>" />	
<c:set var="list02" value="<%= list02%>" />	
<c:set var="member" value="<%= member %>" />	
<c:set var="listFollow" value="<%=listFollow%>"/>

<html>
<head>
<title>OLYMPUS-RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>css/main.css" type="text/css">
<script  src="<%=urlPage%>js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>js/Commonjs.js" language="javascript"></script>
<style type="text/css">
.tFont {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:12px; color: #000000; text-decoration:none; }
.tFontB {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:14px; color: #000000; text-decoration:none; }
.tFontS {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:11px; color: #000000; text-decoration:none; }
</style>
	
<link href="<%=urlPage%>css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>js/jquery.min.js"></script>
<script src="<%=urlPage%>js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#sinsei_day").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
$(function() {
   $("#post_send_day").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

</script>		
<script language="javascript">
function resize(width, height){	
	window.resizeTo(width, height);
}
function printa(){
	window.print();
}

 //숫자에서 콤마를 빼고 반환.
  function numbertogo(n){
   n=n.replace(/,/g,"");   if(isNaN(n)){return 0;} else{return n;}
  }
  // 숫자를 변환..
  function addComma(n) {
   if(isNaN(n)){return 0;}
    var reg = /(^[+-]?\d+)(\d{3})/;   
    n += '';
    while (reg.test(n))
      n = n.replace(reg, '$1' + ',' + '$2');
    return n;    
  }
  	
  function clean(e){			
	  var regex = /[^0-9]/gi;		  
	  var pricev=document.getElementById("price");	
	 if(e.search(regex) > -1) {	 	 	 		 	 
	 	 pricev.value="";
	 	alert("※請求金額は数字のみ入力して下さい");
	 	pricev.value="";
	 }				    			       		
	 //	pricev.value=addComma(pricev.value);
	
} 	

function formSubmit(){        
  var frm = document.frmp;		
    if(isEmpty(frm.pay_kikan, "取引先名を入力して下さい")) return ; 
    if(isEmpty(frm.sinsei_day, "請求書申請日を入力して下さい")) return ; 
    	
    	if(frm.price.value==""){frm.price.value="0";}		 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>admin/payment/addList_pop.jsp";	
	frm.submit(); 
   }   

function goInit(){
	document.formn.reset();
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('520','420') ;">
<center>

	<table width="100%"  border="0" cellpadding=1 cellspacing=0 >
			<tr>
				<td align="center"  class="calendar15" style="padding: 10px 0px 0px 0px;">請求書手続き登録</td>							
			</tr>		
	</table>
<table width="90%"  border=0 >
	<tr>
		<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。		<%=docontact%>
		</td>		
		<td width="90%" align="right" >
			<input type="button" class="cc" onClick="window.close();" onfocus="this.blur();" style=cursor:pointer value=" 閉じる >>">
		</td>							
	</tr>		
</table>
<table width="90%" class="tablebox" cellspacing="3" cellpadding="3" border="0">
<form name="frmp" method="post" action="<%=urlPage%>admin/payment/addList_pop.jsp">    
    <input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
    <input type="hidden" name="pay_day" value="0000-00-00"> 
    <!--<input type="hidden" name="btn"   value="<%=btn%>">	-->
    <input type="hidden" name="yyVal"   value="<%=yyVal%>">	
    <input type="hidden" name="mmVal"   value="<%=mmVal%>">	
    <input type="hidden" name="pagenm"   value="<%=page_list%>">	
    <input type="hidden" name="submit_yn"   value="<%=submit_yn%>">
    <input type="hidden" name="post_send_day"   value="">
    <input type="hidden" name="receive_yn_sinsei"   value="2">
    <input type="hidden" name="receive_yn_ot"   value="1">
    <input type="hidden" name="receive_yn_tokyo"   value="1">
    <input type="hidden" name="shori_yn"   value="1">
   						
   								<tr>	
									<td width="10%" rowspan="5" >&nbsp;</td>								
									<td width="30%"><img src="<%=urlPage%>image/icon_s.gif" >PJ 選択</td>
									<td width="1%">:</td>
									<td width="59%">
			<input type="radio" name="pj_yn" value="1" onFocus="this.blur();" checked> 通常 &nbsp;&nbsp; <input type="radio" name="pj_yn" value="2" onFocus="this.blur();">国家PJ
									</td>
								</tr>
								<tr>																	
									<td width="30%"><img src="<%=urlPage%>image/icon_s.gif" >支払周期</td>
									<td width="1%">:</td>
									<td width="59%">
			<select name="search_cond"  style="font-size:12px;color:#7D7D7D" onChange="return doEnter('');" >													
				<option name="" VALUE=""  >::::::: 検索 :::::::</option>
	<%if(docontact.equals("1")){%><option name="search_cond" VALUE="1"   selected  >毎月支払</option><%}else{%><option name="search_cond" VALUE="1">毎月支払</option><%}%>
	<%if(docontact.equals("2")){%><option name="search_cond" VALUE="2"  selected>随時支払</option><%}else{%><option name="search_cond" VALUE="2"  >随時支払</option><%}%>											
			</select>
									</td>
								</tr>
								<tr> 
									<td width="33%"><font color="#CC0000">※</font>取引先</td>
									<td width="1%">:</td>
									<td width="66%">
			<%if(docontact.equals("1")){%>
				<select name="client"  style="font-size:12px;color:#7D7D7D;" >														
					<option name="client" value="0" >::::::: 検索 :::::::</option>			
<c:if test="${empty list01}">
					<option  name="client" value="0">データなし</option>					
</c:if>
<c:if test="${! empty list01}">
	<%int i=1;
		Iterator listiter=list01.iterator();					
		while (listiter.hasNext()){
			Category dbb=(Category)listiter.next();
			int cseq=dbb.getCseq();											
			if(cseq!=0){
				//Category dbget=mgritem.selectSeikyu(cseq);
				//if(dbget==null){										
	%>					
					<option  name="client" value="<%=cseq%>"><%=dbb.getClient_nm()%></option>								
	<%//}
		}i++;}%>	
</c:if>															
				</select>			
			<%}%>
			<% if(docontact.equals("2")){%>
				<select name="client"  style="font-size:12px;color:#7D7D7D;" >														
					<option name="client" value="0" >::::::: 検索 :::::::</option>			
<c:if test="${empty list02}">
					<option  name="client" value="0">データなし</option>					
</c:if>
<c:if test="${! empty list02}">
	<%int i=1;
		Iterator listiter=list02.iterator();					
		while (listiter.hasNext()){
			Category dbb=(Category)listiter.next();
			int cseq=dbb.getCseq();											
			if(cseq!=0){
			//	Category dbget=mgritem.selectSeikyu(cseq);
			//	if(dbget==null){										
	%>					
					<option  name="client" value="<%=cseq%>"><%=dbb.getClient_nm()%></option>								
	<%//}
		}i++;}%>	
</c:if>											
				</select>			
			<%}%>	    						
									</td>
								</tr>										
								<tr> 
									<td><img src="<%=urlPage%>image/icon_s.gif" >検収月</td>
									<td>:</td>									
									<td>
										<select name="pay_kikan"  style="font-size:12px;color:#7D7D7D;" >														
										<%											
											for(int i=1;i<13;i++){												
										%>											
												<%if(monv==i){%><option name="pay_kikan" value="<%=i%>"  selected><%=i%></option>
												<%}else{%><option name="pay_kikan" value="<%=i%>"  ><%=i%><%}%>																				
										<%}%>														
										</select>	月	
										<!--<input type=text size="5" class="input02"  name="pay_kikan" maxlength="100"  value="">-->
									</td>
								</tr>						
											
								<tr>									
									<td><img src="<%=urlPage%>image/icon_s.gif" >請求金額</td>
									<td>:</td>
									<td><input type=text size="10" class="input02"  name="price" id="price" maxlength="100"  onkeyup="clean(this.value)" onkeydown="clean(this.value)">	</td>
								</tr>																							
								<tr>									
									<td  rowspan="2" bgcolor="#FAFAFA" class="title_list_all_bold" align="center">ORMS</td>								
									<td bgcolor="#FFFFFF"><font color="#CC0000">※</font>受付日</td>
									<td bgcolor="#FFFFFF">:</td>
									<td bgcolor="#FFFFFF">											
	    									<input type="text" size="8%" name="sinsei_day" id="sinsei_day" value="<%=inDate%>" style="text-align:center" >	 							
									</td>
								</tr>								
								<tr>									
									<td bgcolor="#FFFFFF"><img src="<%=urlPage%>image/icon_s.gif" >担当者</td>
									<td bgcolor="#FFFFFF">:</td>
									<td bgcolor="#FFFFFF">
							<select name="mseq"  id="mseq">	
								<option value="0">---選択して下さい---</option>															            							
								<%if(mseq==40){%><option value="40"  selected>森山　剛</option><%}else{%><option value="40">森山　剛</option><%}%>
								<%if(mseq==45){%><option value="45"  selected>張　晶旭</option><%}else{%><option value="45">張　晶旭</option><%}%>
								<%if(mseq==43){%><option value="43"  selected>浜野　雅彦</option><%}else{%><option value="43">浜野　雅彦</option><%}%>
								<%if(mseq==64){%><option value="64"  selected>舟久保あずさ</option><%}else{%><option value="64">舟久保あずさ</option><%}%>
								<%if(mseq==6){%><option value="6"  selected>林　孔華</option><%}else{%><option value="6">林　孔華</option><%}%>
								<%if(mseq==42){%><option value="42"  selected>李　恩永</option><%}else{%><option value="42">李　恩永</option><%}%>
								<%if(mseq==1){%><option value="1"  selected>舘　義人</option><%}else{%><option value="1">舘　義人</option><%}%>
								<%if(mseq==53){%><option value="53"  selected>木下　亜紀</option><%}else{%><option value="53">木下　亜紀</option><%}%>
								<%if(mseq==54){%><option value="54"  selected>富樫　恭子</option><%}else{%><option value="54">富樫　恭子</option><%}%>
								<%if(mseq==41){%><option value="41"  selected>間　靖子</option><%}else{%><option value="41">間　靖子</option><%}%>										
								<%if(mseq==72){%><option value="72"  selected>杉田　薫</option><%}else{%><option value="72">杉田　薫</option><%}%>	
								<%if(mseq==73){%><option value="73"  selected>吉良　潤子</option><%}else{%><option value="73">吉良　潤子</option><%}%>	
								<%if(mseq==74){%><option value="74"  selected>久保田　理菜</option><%}else{%><option value="74">久保田　理菜</option><%}%>	
								<%if(mseq==75){%><option value="75"  selected>斉藤　明人</option><%}else{%><option value="75">斉藤　明人</option><%}%>	
								<%if(mseq==59){%><option value="59"  selected>田村　知明</option><%}else{%><option value="59">田村　知明</option><%}%>	
								<%if(mseq==65){%><option value="65"  selected>片山　信</option><%}else{%><option value="65">片山　信</option><%}%>	
								<%if(mseq==60){%><option value="60"  selected>堀井　章弘</option><%}else{%><option value="60">堀井　章弘</option><%}%>									
								<%if(mseq==82){%><option value="82"  selected>大野　隆弘</option><%}else{%><option value="82">大野　隆弘</option><%}%>
								<%if(mseq==62){%><option value="62"  selected>伊藤　志穂</option><%}else{%><option value="62">伊藤　志穂</option><%}%>
								<%if(mseq==63){%><option value="63"  selected>小堀　綾子</option><%}else{%><option value="63">小堀　綾子</option><%}%>
								<%if(mseq==68){%><option value="68"  selected>戸川　祐一</option><%}else{%><option value="68">戸川　祐一</option><%}%>
								<%if(mseq==71){%><option value="71"  selected>小林　佐代子</option><%}else{%><option value="71">小林　佐代子</option><%}%>
								<%if(mseq==78){%><option value="78"  selected>小松　希</option><%}else{%><option value="78">小松　希</option><%}%>	
								<%if(mseq==61){%><option value="61"  selected>土田　裕基</option><%}else{%><option value="61">土田　裕基</option><%}%>	
																					
							</select>	
									
									
<!--									
							<select name="mseq"  id="mseq">	
								<option value="0">---選択して下さい---</option>								
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${member.mseq==mem.mseq}">						            							
				<option value="${mem.mseq}" selected>${mem.nm}</option>	
		</c:if>	
		<c:if test="${member.mseq!=mem.mseq}">						            							
				<option value="${mem.mseq}" >${mem.nm}</option>	
		</c:if>				
	</c:forEach>
</c:if>				
							</select>		
-->					
									</td>
								</tr>								
								<tr>
									<td width="10%" rowspan="2" >&nbsp;</td>
									<td ><img src="<%=urlPage%>image/icon_s.gif" >コメント</td>
									<td>:</td>
									<td>
										<input type=text size="30" class="input02"  name="comment" maxlength="100" >				
									</td>
								</tr>		
</table>
<table  width="90%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:10px 0px 0px 0px;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage2%>images/common/btn_off_submit.gif"  title="登録"></a>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage2%>images/common/btn_off_cancel.gif"  title="キャンセル"></a>
			</td>			
	</tr>
</form>					
</table>		
</center>
</body>
</html>							
<script language="javascript">				
function doEnter(){
	var frm=document.frmp;
	frm.docontact.value=frm.search_cond.value;					
	frm.action = "<%=urlPage%>admin/payment/addListAllForm_pop.jsp";	
	frm.submit();
}			
</script>