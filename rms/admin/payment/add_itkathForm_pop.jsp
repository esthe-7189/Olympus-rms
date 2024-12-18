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
String seqList=request.getParameter("seqList");
String docontact=request.getParameter("docontact");
	if(docontact==null){docontact="1";}	
String btn=request.getParameter("btn");
	if(btn==null){btn="A";}
String yyVal=request.getParameter("yyVal"); 
String mmVal=request.getParameter("mmVal");
String submit_yn=request.getParameter("submit_yn");
String page_list=request.getParameter("page");
//	if(page_list==null){page_list="1";}	
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
String[] seq=seqList.split(";");

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
<link rel="stylesheet" href="<%=urlPage%>css/style.css" type="text/css">
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
	 		 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>admin/payment/add_itkath_pop.jsp";	
	frm.submit(); 
   }   

function goInit(){
	document.formn.reset();
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('700','450') ;">
<center>

	<table width="100%"  border="0" cellpadding=1 cellspacing=0 >
			<tr>
				<td align="center"  class="calendar15" style="padding: 10px 0px 0px 0px;">請求書手続き登録</td>							
			</tr>		
	</table>
<table width="90%"  border=0 >
	<tr>
		<td width="50%"><img src="<%=urlPage2%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">
<%if(docontact.equals("1")){%>毎月支払<%}else{%>随時支払 <%}%>
		</td>
		<td align="right" width="50%">
<input type="button" class="cc" onClick="window.close();" onfocus="this.blur();" style=cursor:pointer value=" 閉じる >>">
		</td>							
	</tr>	
</table>
<table width="96%" cellspacing="0" cellpadding="0">
<form name="frmp" method="post" action="<%=urlPage%>admin/payment/add_itkath_pop.jsp">    
    <input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
    <input type="hidden" name="btn"   value="<%=btn%>">	
    <input type="hidden" name="yyVal"   value="<%=yyVal%>">	
    <input type="hidden" name="mmVal"   value="<%=mmVal%>">	
    <input type="hidden" name="submit_yn"   value="<%=submit_yn%>">
    <input type="hidden" name="pagenm"   value="<%=page_list%>">
    <input type="hidden" name="pay_day" value="0000-00-00">     
    <input type="hidden" name="receive_yn_sinsei" value="2">     
    	
    	<tr align=center height=29>	  	    	  		
	     	<td  width=""  class="title_list_all" bgcolor="#F1F1F1">取引先</td>	    				
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">PJ 選択</td>	
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">検収月</td>	
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">請求金額</td>			
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">担当者</td>	
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">コメント</td>    		
	</tr>		
<%
	for(int i=0;i<seq.length;i++){											
	 Category pay=mgrpay.select(Integer.parseInt(seq[i]));	
%>
<input type="hidden" name="seq" value="<%=seq[i]%>"> 
	<tr height="20" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">		        	   
	    <td  class="line_gray_b_l_r"><%=pay.getClient_nm()%></td>	   
	    <td  class="line_gray_b_l_r">
			<select name="pj_yn"  style="font-size:12px;color:#7D7D7D" onChange="return doEnter('');" >									
				<option name="pj_yn" VALUE="1"   selected  >通常</option>
				<option name="pj_yn" VALUE="2"    >国家PJ</option>										
			</select>	
		</td>	  
	    <td  class="line_gray_bottomnright" align="center">
			<select name="pay_kikan"  style="font-size:12px;color:#7D7D7D;" >													
										<%											
											for(int iq=1;iq<13;iq++){												
										%>											
												<%if(monv==iq){%><option name="pay_kikan" value="<%=iq%>"  selected><%=iq%></option>
												<%}else{%><option name="pay_kikan" value="<%=iq%>"  ><%=iq%><%}%>																								
										<%}%>														
			</select>	月	
	    </td>	   
	    <td  class="line_gray_bottomnright" align="center"><input type=text size="5" class="input02"  name="price" id="price" maxlength="100"  onkeyup="clean(this.value)" onkeydown="clean(this.value)"></td>	    
	    <td  class="line_gray_bottomnright" align="center">
	    						<select name="mseq"  id="mseq">	
								<option value="0">-選択-</option>															            							
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
								<%if(mseq==78){%><option value="78"  selected>小松　希</option><%}else{%><option value="78">小松　希</option><%}%>
								<%if(mseq==76){%><option value="76"  selected>峯　美沙子</option><%}else{%><option value="76">峯　美沙子</option><%}%>								
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
	    <td  class="line_gray_bottomnright" align="center"><input type=text size="15" class="input02"  name="comment" maxlength="100" ></td>
	</tr>
<%}%>	
		<tr>				
			<td class="line_gray_b_l_r" bgcolor="#F1F1F1"  align="center"><font color="#CC0000">※</font><span class="titlename">共通内容</span></td>
			<td colspan="6" class="line_gray_bottomnright"><img src="<%=urlPage%>image/icon_s.gif" >受付日 : <input type="text" size="8%" name="sinsei_day" id="sinsei_day" value="<%=inDate%>" style="text-align:center" ></td>
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