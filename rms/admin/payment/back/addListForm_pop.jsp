<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
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
String cseq=request.getParameter("cseq");
String seq=request.getParameter("seq");
String docontact=request.getParameter("docontact");

int mseq=0;
	MemberManager manager=MemberManager.getInstance();
	Member member=manager.getMember(id);
	if(member!=null){		
		mseq=member.getMseq();
	}
List listFollow=manager.selectListSchedule(1,6);
CateMgr mgrpay=CateMgr.getInstance();	
Category pay=mgrpay.select(Integer.parseInt(cseq));
%>
<c:set var="member" value="<%= member %>" />	
<c:set var="listFollow" value="<%=listFollow%>"/>
<c:set var="pay" value="<%=pay%>"/>
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
$(function() {
   $("#pay_day").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
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
	 		 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>admin/payment/addList_pop.jsp";	
	frm.submit(); 
   }   

function goInit(){
	document.formn.reset();
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('450','550') ;">
<center>

	<table width="100%"  border="0" cellpadding=1 cellspacing=0 >
			<tr>
				<td align="center"  class="calendar15" style="padding: 10px 0px 0px 0px;">請求書手続き登録</td>							
			</tr>		
	</table>
<table width="90%"  border=0 >
	<tr>
		<td align="right" >
<input type="button" class="cc" onClick="window.close();" onfocus="this.blur();" style=cursor:pointer value=" 閉じる >>">
		</td>							
	</tr>		
</table>
<table width="90%" class="tablebox" cellspacing="3" cellpadding="3">
<form name="frmp" method="post" action="<%=urlPage%>admin/payment/addList_pop.jsp">
    <input type="hidden" name="client" value="<%=cseq%>">              
    <input type="hidden" name="seq" value="<%=seq%>"> 
    <input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
								<tr>								
									<td width="36%"><img src="<%=urlPage%>image/icon_s.gif" >取引先</td>
									<td width="1%">:</td>
									<td width="63%">${pay.client_nm}	</td>
								</tr>								
								<tr> 
									<td><img src="<%=urlPage%>image/icon_s.gif" >支払月分</td>
									<td>:</td>									
									<td><input type=text size="5" class="input02"  name="pay_kikan" maxlength="100" ></td>
								</tr>
								<tr> 
									<td><img src="<%=urlPage%>image/icon_s.gif" >支払日</td>
									<td>:</td>									
									<td><input type="text" size="8%" name="pay_day" id="pay_day" value="" style="text-align:center" ></td>
								</tr>								
								<tr>									
									<td><img src="<%=urlPage%>image/icon_s.gif" >請求金額</td>
									<td>:</td>
									<td><input type=text size="10" class="input02"  name="price" id="price" maxlength="100"  onkeyup="clean(this.value)" onkeydown="clean(this.value)">	</td>
								</tr>								
								<tr>									
									<td><img src="<%=urlPage%>image/icon_s.gif" >請求書受取、申請日</td>
									<td>:</td>
									<td>									
										<input type="radio" name="receive_yn_sinsei"  value="1"  onfocus="this.blur()" checked  > 未確認 &nbsp;
										<input type="radio" name="receive_yn_sinsei"  value="2"  onfocus="this.blur()"  >確認		<br>
	    									<input type="text" size="8%" name="sinsei_day" id="sinsei_day" value="" style="text-align:center" >	 							
									</td>
								</tr>								
								<tr>									
									<td><img src="<%=urlPage%>image/icon_s.gif" >担当者</td>
									<td>:</td>
									<td>
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
					
									</td>
								</tr>								
								<tr>	
									<td><img src="<%=urlPage%>image/icon_s.gif" >郵便発送日(予定日)</td>
									<td>:</td>
									<td><input type="text" size="8%" name="post_send_day" id="post_send_day" value="" style="text-align:center" ></td>
								</tr>								
								<tr>
									<td><img src="<%=urlPage%>image/icon_s.gif" >OT郵便受取</td>
									<td>:</td>
									<td>
										<input type="radio" name="receive_yn_ot"  value="1"  onfocus="this.blur()" checked  > 未受領 &nbsp;
										<input type="radio" name="receive_yn_ot"  value="2"  onfocus="this.blur()"  >受領完了										
									</td>
								</tr>
								<tr>
									<td><img src="<%=urlPage%>image/icon_s.gif" >処理状態</td>
									<td>:</td>
									<td>
										<input type="radio" name="shori_yn"  value="1"  onfocus="this.blur()" checked  > 未処理 &nbsp;
										<input type="radio" name="shori_yn"  value="2"  onfocus="this.blur()"  >処理完了				
									</td>
								</tr>
								<tr>
									<td><img src="<%=urlPage%>image/icon_s.gif" >コメント</td>
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