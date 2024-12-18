<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>


<%
String urlPage=request.getContextPath()+"/orms/";	

%>
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
	if (!frm.accept_yn[0].checked) {
		alert("利用規約に同意してください");
		frm.accept_yn[0].focus();
		return;
	}
	
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
	frm.target="";
	frm.action = "<%=urlPage%>member/memberOk.jsp";   	   
	frm.submit();
}
 function goInit(){
	var frm = document.venderChk;
	frm.reset();
}
</script>
 
<form id="Util_indexVO" name="insertForm" action="<%=urlPage%>member/memberOk.jsp" method="post">
<input type="hidden" name="CHECK_FG" value="N">
<input type="hidden" name="CHECKED_EMAIL">

<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a><img src="<%=urlPage%>images/common/overay.gif"> 会員登録　 </p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu_08.gif"></p>
		</div>
		
<!-- title end **********************************-->	
		<div id="content"><div class="join_boxtool" > 					
			<p class="l18 mb20 ">
	下の<span class="f_ora">利用規約</span>の各条項をよくお読みいただき、ご登録ください。 <br/>
	なお、フォームの送信後は、ここに入力された情報の全部または一部を、プライバシーポリシーに従って当社が使用する場合がございます。</p>
			<p class="join_title "><img src="<%=urlPage%>images/main/title_agreement.gif" alt="Terms Of Use" title="Terms Of Use"/></p>			
		<div id="join_checkbox">
		<div class="pad_l10 pad_t10 pad_b10" style="line-height:160%;">
<!-- 약관 -->
 
<br /><span style="font-size:14px;"><strong>第1章 総則</strong></span>
<br />
<br /><strong>1.当社のサービスのご利用</strong>
<br />本利用規約にご同意いただくことによって、当社のサービスをご利用いただくことができます。なお、無料で提供しているサービスにつきましては、本利用規約にご同意いただく手続に代えて、実際にご利用いただくことで本利用規約第1編基本ガイドラインにご同意いただいたものとみなします。
<br /><strong>2.サービス内容の保証および変更</strong>
<br />当社は提供するサービスの内容について、瑕疵（かし）やバグがないことは保証しておりません。また当社は、お客様にあらかじめ通知することなくサービスの内容や仕様を変更したり、提供を停止したり中止したりすることができるものとします。
<br /><strong>3.サービスの利用制限</strong>
<br />当社は、サービスのご利用を登録された方に限定したり、一定の年齢以上の方に限定したり、当社が定める本人確認などの手続を経て一定の要件を満たしたお客様のみに限定したりするなど、利用に際して条件を付すことができるものとします。
また、当社は反社会的勢力の構成員（過去に構成員であった方を含みます）およびその関係者の方や、サービスを悪用したり、第三者に迷惑をかけたりするようなお客様に対してはご利用をお断りしています。	
 <br /><strong>4.IDの登録情報</strong>
<br />IDを登録していただく場合、（1）真実かつ正確な情報を登録していただくこと、（2）登録内容が最新となるようお客様ご自身で適宜修正していただくことがお客様の義務となります。
<br /><strong>5.IDおよびパスワードに関するお客様の責任</strong>
<br />IDとパスワードの組み合わせが登録情報と一致してログインされた場合には、当社は、当該IDを登録されているお客様ご自身によるご利用であるとみなして、当該IDを用いたサービスの利用や商品の購入などによって料金や代金（当社のサービスのご利用にかかる代金、利用料、会費その他名目は問いません。また当社が第三者から回収を委託したお客様の債務を含みます。以下「代金」といいます）が発生した場合には、当該IDを登録されているお客様に課金いたします。



<!-- 약관 -->	
 
				</div>
			</div>	
			
			<div class="agree">
				<ul>	
					<li><input type="radio" name="accept_yn" value="Y"/></li>
					<li class="txt">はい</li>
					<li><input type="radio" name="accept_yn" value="N"/></li>
					<li class="txt">いいえ  </li>
				</ul>
			</div>
			<p class="dashed"></p>
			<p class="join_title"><img src="<%=urlPage%>images/main/title_join_input.gif" alt="Required" title="Required"/></p>
			<div class="join_box3">
				<ul>
					<li class="title"><label for="email">Eメール</label></li>
					<li class="blank">:</li>
					<li class="in"><input type="text" name="mail_address" maxlength="50" style="width:310px"/></li>
					<li class="btn"><img src="<%=urlPage%>images/common/btn__check.gif" onClick="check_email();" style="cursor:pointer;" alt="check" title="check"/></li>
				</ul>
				<ul>
					<li class="title"><label for="psw">パスワード</label></li>
					<li class="blank">:</li>
					<li class="in"><input type="password" name="password" maxlength="20" style="width:310px"/></li>
				</ul>
				<ul>
					<li class="title"><label for="conf_psw">パスワード確認</label></li>
					<li class="blank">:</li>
					<li class="in"><input type="password" name="password2" maxlength="12" style="width:310px"/></li>
				</ul>
				<ul>
					<li class="title"><label for="name01">お名前</label></li>
					<li class="blank">:</li>
					<li class="in2"><input type="text" name="name1" maxlength="50" style="width:185px"/></li>
					<li class="title2"><label for="name02">アルファベット</label></li>
					<li class="blank">:</li>
					<li class="in3"><input type="text" name="name2" maxlength="50" style="width:185px"/></li>
				</ul>
				<ul>
					<li class="title"><label for="age">年齢</label></li>
					<li class="blank">:</li>
					<li class="in2"><input type="text" name="age" maxlength="3" style="width:70px"/></li>
					<li class="title2"><label for="gen">性別</label></li>
					<li class="blank">:</li>
					<li class="in3">
						<select name="sex" style="width:70px">
							<option value="F">女性</option>
							<option value="M">男性</option>
						</select>
					</li>
				</ul>
				<ul>
					<li class="title"><label for="home">お住まいの地域</label></li>
					<li class="blank">:</li>
					<li class="in2">
						<select name="kuni" style="height:20px;">
				<option value="回答なし" selected="selected">選択してください。</option>
<option value="北海道">北海道</option>
<option value="青森県">青森県</option>
<option value="岩手県">岩手県</option>
<option value="宮城県">宮城県</option>
<option value="秋田県">秋田県</option>
<option value="山形県">山形県</option>
<option value="福島県">福島県</option>
<option value="茨城県">茨城県</option>
<option value="栃木県">栃木県</option>
<option value="群馬県">群馬県</option>
<option value="埼玉県">埼玉県</option>
<option value="千葉県">千葉県</option>
<option value="東京都">東京都</option>
<option value="神奈川県">神奈川県</option>
<option value="新潟県">新潟県</option>
<option value="富山県">富山県</option>
<option value="石川県">石川県</option>
<option value="福井県">福井県</option>
<option value="山梨県">山梨県</option>
<option value="長野県">長野県</option>
<option value="岐阜県">岐阜県</option>
<option value="静岡県">静岡県</option>
<option value="愛知県">愛知県</option>
<option value="三重県">三重県</option>
<option value="滋賀県">滋賀県</option>
<option value="京都府">京都府</option>
<option value="大阪府">大阪府</option>
<option value="兵庫県">兵庫県</option>
<option value="奈良県">奈良県</option>
<option value="和歌山県">和歌山県</option>
<option value="鳥取県">鳥取県</option>
<option value="島根県">島根県</option>
<option value="岡山県">岡山県</option>
<option value="広島県">広島県</option>
<option value="山口県">山口県</option>
<option value="徳島県">徳島県</option>
<option value="香川県">香川県</option>
<option value="愛媛県">愛媛県</option>
<option value="高知県">高知県</option>
<option value="福岡県">福岡県</option>
<option value="佐賀県">佐賀県</option>
<option value="長崎県">長崎県</option>
<option value="熊本県">熊本県</option>
<option value="大分県">大分県</option>
<option value="宮崎県">宮崎県</option>
<option value="鹿児島県">鹿児島県</option>
<option value="沖繩県">沖繩県</option>
<option value="海外・ヨーロッパ（ロシア含む）地域">海外・ヨーロッパ（ロシア含む）地域</option>
<option value="海外・中近東地域">海外・中近東地域</option>
<option value="海外・アフリカ地域">海外・アフリカ地域</option>
<option value="海外・北米地域">海外・北米地域</option>
<option value="海外・中南米地域">海外・中南米地域</option>
<option value="海外・アジア地域">海外・アジア地域</option>
<option value="海外・オセアニア地域">海外・オセアニア地域</option>
<option value="海外・上記以外">海外・上記以外</option>
</select>
					</li>						
				</ul>
				<p>Would you like to subscribe newsletter to receive most recent  information? &nbsp;<input type="checkbox" name="news_yn" value="1"/></p>
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