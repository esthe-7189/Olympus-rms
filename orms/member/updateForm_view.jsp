<%@ page contentType = "text/html; charset=utf-8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>

<%	String urlPage=request.getContextPath()+"/orms/";	
	

	String member_id=(String)session.getAttribute("ID");
	MemberManager manager=MemberManager.getInstance();
	Member member=manager.getMember(member_id);

if(member==null ){
%>			
	<jsp:forward page="/orms/template/tempSub.jsp">    
		<jsp:param name="CONTENTPAGE3" value="/orms/home/home.jsp" />	
	</jsp:forward>
<%
	}

%>
<c:set var="member" value="<%=member%>" />

<script> 
function check_email() {
	var frm = document.insertForm;
 
	var mail_address = Replace_Blank(frm.mail_address.value);
	if (mail_address == '') {
		alert("使えるE-mailを正確に書いて下さい。");
		frm.mail_address.focus();
		return;
	}
	var SH_mail_address = mail_address.split("@");
	if (SH_mail_address.length != 2) {
		alert("E-mailを正確に書いて下さい。");
		frm.mail_address.focus();
		return;
	}
	if (!MailCheck(SH_mail_address[0], SH_mail_address[1])) {
		alert("E-mailを正確に書いて下さい。");
		frm.mail_address.focus();
		return;
	}	
	frm.mail_address.value = mail_address;
 
	// popup open
	var winwidth = 500;
	var winheight = 240;
	var windowOpenState = "directories=no,menubar=no,scrollbars=no,status=no,resizable=no,toolbar=no,height=" + winheight + ",width=" + winwidth;
	windowOpenState = windowOpenState + ",left=" + ((screen.availWidth - winwidth) / 2) + ",top=" + ((screen.availHeight - winheight)/2);
	winopen = window.open("","mailCheck",windowOpenState);
	
	frm.target="mailCheck";
	frm.action="<%=urlPage%>member/member_id.jsp";
	frm.submit();
}
 
/* 회원 가입 */
function signup_confirm() {
	var frm = document.insertForm;
	
	if(frm.cateKind[0].checked==true){frm.mailVal.value="no";  }	  
      if(frm.cateKind[1].checked==true){         
		var mail_address = Replace_Blank(frm.mail_address.value);
		if (mail_address == '') {
			alert("ご連絡先Eメールアドレスを入力してください");
			frm.mail_address.focus();
			return;
		}		
		var SH_mail_address = mail_address.split("@");
		if (SH_mail_address.length != 2) {
			alert("ご連絡先Eメールアドレスを正確に入力してください 。");
			frm.mail_address.focus();
			return;
		}
		if (!MailCheck(SH_mail_address[0], SH_mail_address[1])) {
			alert("ご連絡先Eメールアドレスを正確に入力してください。");
			frm.mail_address.focus();
			return;
		}	
		frm.mail_address.value = mail_address;
		if (frm.CHECK_FG.value != 'Y' || mail_address != frm.CHECKED_EMAIL.value) {
			alert("checkのButtonを押してください");
			return;
		}
		frm.mailVal.value="yes"; 
	   }	 
	var password = Replace_Blank(frm.password.value);
	if (password == '') {
		alert("passwordを入力してください");
		frm.password.focus();
		return;
	}
	
	if (password.length < 4 || password.length > 20) {
		alert("passwordは４～２０字までお願いします");
		frm.password.focus();
		return;
	}

	frm.password.value = password;
	
	var password2 = Replace_Blank(frm.password2.value);
	if (password != password2) {
		alert("入力された2つのpasswordが異なっています");
		frm.password2.focus();
		return;
	}
 
	var name1 = Replace_Blank(frm.name1.value);
	if (name1 == '') {
		alert("お名前を入力してください");
		frm.name1.focus();
		return;
	}
	frm.name1.value = name1;
 
	var name2 = Replace_Blank(frm.name2.value);
	if (name2 == '') {
		alert("お名前(アルファベット)を入力してください");
		frm.name2.focus();
		return;
	}
	frm.name2.value = name2;
 
	var age = Replace_Blank(frm.age.value);
	if (age == '') {
		alert("年齢を入力してください");
		frm.age.focus();
		return;
	} 
	if (!containsCharsOnly(frm.age, "0123456789")) {
		alert("年齢を正確に入力してください");
		frm.age.focus();
		return;
	}
	frm.age.value = age; 
	if (frm.kuni.value == '') {
		alert("お住まいの地域をお選びください");
		frm.kuni.focus();
		return;
	}
	if(frm.news_yn.checked==true){
		frm.news_yn.value="1";  
	}else{
		frm.news_yn.value="0";  
	}	  	
	frm.target="";
	frm.action = "<%=urlPage%>member/update.jsp";   	   
	frm.submit();
}
 function goInit(){
	var frm = document.venderChk;
	frm.reset();
}
</script>
 
<form id="Util_indexVO" name="insertForm" action="<%=urlPage%>member/update.jsp" method="post">
<input type="hidden" name="CHECK_FG" value="N">
<input type="hidden" name="CHECKED_EMAIL">
<input type="hidden" name="mseq" value="${member.mseq}">
<input type="hidden" name="mailVal">
<input type="hidden" name="level" value="${member.level}">

<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a><img src="<%=urlPage%>images/common/overay.gif"> My情報 </p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu_11.gif"></p>
		</div>
		
<!-- title end **********************************-->	
		<div id="content"><div class="join_boxtool" > 					
			<p class="l18 mb20 ">
	<span class="f_ora">お客様</span>の情報は次のようです。 
	もしかして、書き直したい所がございましたら、下のフォームにて修正して下さい。<br>
	なお、ここに入力された情報の全部または一部を、プライバシーポリシーに従って当社が使用する場合がございます。</p>
							
			<p class="join_title"><img src="<%=urlPage%>images/main/title_join_input_modi.gif" alt="Required" title="Required"/></p>
			<div class="join_box3">
				<ul>					
					<li class="title"><label for="name01">Eメール</label></li>
					<li class="blank">:</li>
					<li class="in2"><input type="text" name="email" value="${member.mail_address}" maxlength="50" style="width:200px" readOnly/></li>
					<li class="title2"><label for="name02">Eメール修正</label></li>
					<li class="blank">:</li>
					<li class="in3">
						<input type="radio" onfocus="this.blur()"  name="cateKind" value="1"  onClick="selectCate()"  checked>修正しない&nbsp;
						<input type="radio" onfocus="this.blur()"  name="cateKind" value="2"  onClick="selectCate()" >修正する
					</li>
				</ul>				
			<div id="file_02"  style="display:none;">	
				<ul>
					<li class="title"><label for="email">Eメール修正</label></li>
					<li class="blank">:</li>
					<li class="in"><input type="text" name="mail_address" value="" maxlength="50" style="width:310px"/></li>
					<li class="btn"><img src="<%=urlPage%>images/common/btn__check.gif" onClick="check_email();" style="cursor:pointer;" alt="check" title="check"/></li>
				</ul>
			</div>	
				<ul>
					<li class="title"><label for="psw">パスワード</label></li>
					<li class="blank">:</li>
					<li class="in"><input type="password" name="password" value="${member.password}" maxlength="20" style="width:310px"/></li>
				</ul>
				<ul>
					<li class="title"><label for="conf_psw">パスワード確認</label></li>
					<li class="blank">:</li>
					<li class="in"><input type="password" name="password2" maxlength="12" style="width:310px"/></li>
				</ul>
				<ul>
					<li class="title"><label for="name01">お名前</label></li>
					<li class="blank">:</li>
					<li class="in2"><input type="text" name="name1" value="${member.name1}" maxlength="50" style="width:185px"/></li>
					<li class="title2"><label for="name02">アルファベット</label></li>
					<li class="blank">:</li>
					<li class="in3"><input type="text" name="name2" value="${member.name2}" maxlength="50" style="width:185px"/></li>
				</ul>
				<ul>
					<li class="title"><label for="age">年齢</label></li>
					<li class="blank">:</li>
					<li class="in2"><input type="text" name="age" value="${member.age}" maxlength="3" style="width:70px"/></li>
					<li class="title2"><label for="gen">性別</label></li>
					<li class="blank">:</li>
					<li class="in3">
						<select name="sex" style="width:70px">
				<c:if test="${member.sex=='F'}" >
							<option value="F" selected>女性</option>
							<option value="M">男性</option>
				</c:if>
				<c:if test="${member.sex=='M'}" >
							<option value="F" >女性</option>
							<option value="M" selected>男性</option>
				</c:if>
						</select>
					</li>
				</ul>
				<ul>
					<li class="title"><label for="home">お住まいの地域</label></li>
					<li class="blank">:</li>
					<li class="in2">
						<select name="kuni" style="height:20px;">
				<option value="回答なし" selected="selected">選択してください。</option>
<option value="北海道" <c:if test="${member.kuni=='北海道'}" >selected </c:if>>北海道</option>
<option value="青森県" <c:if test="${member.kuni=='青森県'}" >selected </c:if>>青森県</option>
<option value="岩手県" <c:if test="${member.kuni=='岩手県'}" >selected </c:if>>岩手県</option>
<option value="宮城県" <c:if test="${member.kuni=='宮城県'}" >selected </c:if>>宮城県</option>
<option value="秋田県" <c:if test="${member.kuni=='秋田県'}" >selected </c:if>>秋田県</option>
<option value="山形県" <c:if test="${member.kuni=='山形県'}" >selected </c:if>>山形県</option>
<option value="福島県" <c:if test="${member.kuni=='福島県'}" >selected </c:if>>福島県</option>
<option value="茨城県" <c:if test="${member.kuni=='茨城県'}" >selected </c:if>>茨城県</option>
<option value="栃木県" <c:if test="${member.kuni=='栃木県'}" >selected </c:if>>栃木県</option>
<option value="群馬県" <c:if test="${member.kuni=='群馬県'}" >selected </c:if>>群馬県</option>
<option value="埼玉県" <c:if test="${member.kuni=='埼玉県'}" >selected </c:if>>埼玉県</option>
<option value="千葉県" <c:if test="${member.kuni=='千葉県'}" >selected </c:if>>千葉県</option>
<option value="東京都" <c:if test="${member.kuni=='東京都'}" >selected </c:if>>東京都</option>
<option value="神奈川県" <c:if test="${member.kuni=='神奈川県'}" >selected </c:if>>神奈川県</option>
<option value="新潟県" <c:if test="${member.kuni=='新潟県'}" >selected </c:if>>新潟県</option>
<option value="富山県" <c:if test="${member.kuni=='富山県'}" >selected </c:if>>富山県</option>
<option value="石川県" <c:if test="${member.kuni=='石川県'}" >selected </c:if>>石川県</option>
<option value="福井県" <c:if test="${member.kuni=='福井県'}" >selected </c:if>>福井県</option>
<option value="山梨県" <c:if test="${member.kuni=='山梨県'}" >selected </c:if>>山梨県</option>
<option value="長野県" <c:if test="${member.kuni=='長野県'}" >selected </c:if>>長野県</option>
<option value="岐阜県" <c:if test="${member.kuni=='岐阜県'}" >selected </c:if>>岐阜県</option>
<option value="静岡県" <c:if test="${member.kuni=='静岡県'}" >selected </c:if>>静岡県</option>
<option value="愛知県" <c:if test="${member.kuni=='愛知県'}" >selected </c:if>>愛知県</option>
<option value="三重県" <c:if test="${member.kuni=='三重県'}" >selected </c:if>>三重県</option>
<option value="滋賀県" <c:if test="${member.kuni=='滋賀県'}" >selected </c:if>>滋賀県</option>
<option value="京都府" <c:if test="${member.kuni=='京都府'}" >selected </c:if>>京都府</option>
<option value="大阪府" <c:if test="${member.kuni=='大阪府'}" >selected </c:if>>大阪府</option>
<option value="兵庫県" <c:if test="${member.kuni=='兵庫県'}" >selected </c:if>>兵庫県</option>
<option value="奈良県" <c:if test="${member.kuni=='奈良県'}" >selected </c:if>>奈良県</option>
<option value="和歌山県" <c:if test="${member.kuni=='和歌山県'}" >selected </c:if>>和歌山県</option>
<option value="鳥取県" <c:if test="${member.kuni=='鳥取県'}" >selected </c:if>>鳥取県</option>
<option value="島根県" <c:if test="${member.kuni=='島根県'}" >selected </c:if>>島根県</option>
<option value="岡山県" <c:if test="${member.kuni=='岡山県'}" >selected </c:if>>岡山県</option>
<option value="広島県" <c:if test="${member.kuni=='広島県'}" >selected </c:if>>広島県</option>
<option value="山口県" <c:if test="${member.kuni=='山口県'}" >selected </c:if>>山口県</option>
<option value="徳島県" <c:if test="${member.kuni=='徳島県'}" >selected </c:if>>徳島県</option>
<option value="香川県" <c:if test="${member.kuni=='香川県'}" >selected </c:if>>香川県</option>
<option value="愛媛県" <c:if test="${member.kuni=='愛媛県'}" >selected </c:if>>愛媛県</option>
<option value="高知県" <c:if test="${member.kuni=='高知県'}" >selected </c:if>>高知県</option>
<option value="福岡県" <c:if test="${member.kuni=='福岡県'}" >selected </c:if>>福岡県</option>
<option value="佐賀県" <c:if test="${member.kuni=='佐賀県'}" >selected </c:if>>佐賀県</option>
<option value="長崎県" <c:if test="${member.kuni=='長崎県'}" >selected </c:if>>長崎県</option>
<option value="熊本県" <c:if test="${member.kuni=='熊本県'}" >selected </c:if>>熊本県</option>
<option value="大分県" <c:if test="${member.kuni=='大分県'}" >selected </c:if>>大分県</option>
<option value="宮崎県" <c:if test="${member.kuni=='宮崎県'}" >selected </c:if>>宮崎県</option>
<option value="鹿児島県" <c:if test="${member.kuni=='鹿児島県'}" >selected </c:if>>鹿児島県</option>
<option value="沖繩県" <c:if test="${member.kuni=='沖繩県'}" >selected </c:if>>沖繩県</option>
<option value="海外・ヨーロッパ（ロシア含む）地域" <c:if test="${member.kuni=='海外・ヨーロッパ（ロシア含む）地域'}" >selected </c:if>>海外・ヨーロッパ（ロシア含む）地域</option>
<option value="海外・中近東地域" <c:if test="${member.kuni=='海外・中近東地域'}" >selected </c:if>>海外・中近東地域</option>
<option value="海外・アフリカ地域" <c:if test="${member.kuni=='海外・アフリカ地域'}" >selected </c:if>>海外・アフリカ地域</option>
<option value="海外・北米地域" <c:if test="${member.kuni=='海外・北米地域'}" >selected </c:if>>海外・北米地域</option>
<option value="海外・中南米地域" <c:if test="${member.kuni=='海外・中南米地域'}" >selected </c:if>>海外・中南米地域</option>
<option value="海外・アジア地域" <c:if test="${member.kuni=='海外・アジア地域'}" >selected </c:if>>海外・アジア地域</option>
<option value="海外・オセアニア地域" <c:if test="${member.kuni=='海外・オセアニア地域'}" >selected </c:if>>海外・オセアニア地域</option>
<option value="海外・上記以外" <c:if test="${member.kuni=='海外・上記以外'}" >selected </c:if>>海外・上記以外</option>
</select>
					</li>						
				</ul>
				<p>Would you like to subscribe newsletter to receive most recent  information? &nbsp;
							<input type="checkbox" name="news_yn" value="1" <c:if test="${member.news_yn==1}" >checked </c:if>/></p>
			</div>
			<div class="btn_area4">
			<img src="<%=urlPage%>images/common/btn_off_submit.gif" name="imgTemp01"  
				onMouseOver="imgTemp01.src='<%=urlPage%>images/common/btn_on_submit.gif';" 
				onMouseOut="imgTemp01.src='<%=urlPage%>images/common/btn_off_submit.gif';" align="absmiddle" style="cursor:pointer;" onClick="signup_confirm();" alt="送信" title="送信"/>
			<a href="JavaScript:goInit();">
			<img src="<%=urlPage%>images/common/btn_off_cancel.gif" name="imgTemp02"  
				onMouseOver="imgTemp02.src='<%=urlPage%>images/common/btn_on_cancel.gif';" 
				onMouseOut="imgTemp02.src='<%=urlPage%>images/common/btn_off_cancel.gif';" align="absmiddle" style="cursor:pointer;" alt="取り消し" title="取り消し"/></a></div>
		</div>
 </div> 
<hr /> 
<h2 class="blind">right_area</h2>
<!-- right begin -->
<div class="subPro01">
<div class="subContent1 module">
<jsp:include page="/orms/module/rightEmail.jsp" flush="false"/>
<p class="pad_t5 mb5"><a href=""><img src="<%=urlPage%>images/css_img/picture/biocollagen.jpg" alt="Boi Collagen" /></a></p> 	
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->	
<hr />
</form>
					
<script language="JavaScript">
var f=document.insertForm;
var d=document.all;	

function selectCate(){		
	if (f.cateKind[0].checked==true)	{				
		d.file_02.style.display="none";		
	}else if (f.cateKind[1].checked==true)	{		
		d.file_02.style.display="";		
	}		
}
</script>					