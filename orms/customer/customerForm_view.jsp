<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>


<%
String urlPage=request.getContextPath()+"/orms/";
String id=(String)session.getAttribute("ID");	
String kind=(String)session.getAttribute("KIND");
MemberManager manager = MemberManager.getInstance();            
Member mem=manager.getMember(id);
   
%>
<c:set var="mem" value="<%=mem%>" />

<script>  
function signup_confirm() {
	var frm = document.insertForm;
	if (!frm.accept_yn[0].checked) {
		alert("個人情報の取扱いに同意してください");
		frm.accept_yn[0].focus();
		return;
	}
	
	var mail_address = Replace_Blank(frm.mail_address.value);
	if (mail_address == '') {
		alert("E-mailを書いて下さい。");
		frm.mail_address.focus();
		return;
	}
	var SH_mail_address = mail_address.split("@");
	if (SH_mail_address.length != 2) {
		alert("E-mailを正確に書いて下さい。.");
		frm.mail_address.focus();
		return;
	}
	if (!MailCheck(SH_mail_address[0], SH_mail_address[1])) {
		alert("E-mailを正確に書いて下さい。.");
		frm.mail_address.focus();
		return;
	}	
	frm.mail_address.value = mail_address;	 
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
 
	if (frm.kuni.value == '') {
		alert("お住まいの地域をお選びください");
		frm.kuni.focus();
		return;
	}	
	frm.target="";
	frm.action = "<%=urlPage%>customer/add.jsp";   	   
	frm.submit();
}
 function goInit(){
	var frm = document.venderChk;
	frm.reset();
}
</script>
 <script type="text/javascript">
function FCKeditor_OnComplete( editorInstance )
{
	window.status = editorInstance.Description ;
}
</script>
<form id="Util_indexVO" name="insertForm" action="<%=urlPage%>customer/add.jsp" method="post">
	<!-- answer_yn 1=미처리, 2=처리완료-->
<input type="hidden" name="answer_yn" value="1">
<input type="hidden" name="mseq" value="${mem.mseq}">
<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a><img src="<%=urlPage%>images/common/overay.gif">customer</p>
<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu_06.gif"></p>
		</div>
		
<!-- title end **********************************-->	
<div id="content"><div class="join_boxtool" > 				
<p class="l18 mb20 ">
<span class="f_ora">営業時間は、</span>祝祭日、年末年始・夏期休暇等を除く月～金曜日の9：00～17：00です。<br>
必ず下記の注意事項をご確認のうえ、メール送信してください。
</p>
<p class="join_title "><img src="<%=urlPage%>images/main/title_customer_agree.gif"></p>			
		<div id="join_checkbox">
		<div class="pad_l10 pad_t10 pad_b10" style="line-height:160%;">
<!-- 약관 -->
 
<br /><span style="font-size:14px;"><strong>個人情報の取扱いの同意</strong></span>
<br />
<br />
<strong>*お問い合わせにつきましては、</strong>
<br />順次対応させていただいておりますが、営業時間外に送信いただいたものへのお返事にはお時間を頂戴する場合がございます。また、お問い合わせの内容によりましてはお時間を頂戴する場合やお返事を差し上げられない場合がございます。Eメールではなく、当社からの回答は、お問い合わせいただいたお客さまの特定のご質問にお答えするものです。当社の許可なく、回答内容の一部分もしくは全体を転用、二次利用し、または当該お客さま以外に開示することは固くお断り致します。
<br />
<br/>
<strong>お客さまのメール設定で、</strong>
<br/>着信制御をされている場合、当社からの返信が届かないことがございます。あらかじめご了承ください。 
<br/>	
<br />お問い合わせ内容に応じてお客さまとの早急なコミュニケーションを図るために、お問い合わせの際には、お名前、メールアドレスお電話番号（以下、個人情報）、居住地域を全てご入力いただくこととしております。これらの情報をご入力いただけない場合は、メールによるお問い合わせをお受けいたしかねますので、フリーダイヤルにお問い合わせください。 
<br />
 <br /><strong>お客さまの個人情報は、以下の目的のために利用いたします。 </strong>
<br />1)お問い合わせに対する対応・回答のため  2)お問い合わせに対する対応・回答のために必要なお客さまとの連絡・コミュニケーションのため
<br />
<br />お客さまの個人情報は、弊社受信後6ヵ月以内に削除いたします（お問い合わせへの回答が完了していない場合を除く）。 
<br />当社の個人情報保護に関する責任者および各種申し出先等につきましては、個人情報保護方針をご参照ください。
<br />
<br/>お電話やお手紙でお答えする場合もございますので、あらかじめご了承ください。 

<!-- 약관 -->	
 
				</div>
			</div>	
			
			<div class="agree">
				<ul>	
					<li><input type="radio" name="accept_yn" value="Y"/></li>
					<li class="txt">はい</li>
					<li><input type="radio" name="accept_yn" value="N"/></li>
					<li class="txt">いいえ </li>
				</ul>
			</div>
			<p class="dashed"></p>
			<p class="join_title"><img src="<%=urlPage%>images/main/title_customer_input.gif" alt="Required" title="Required"/></p>
			<div class="customer_box">
				<ul>
					<li class="title"><label for="email">Eメール</label></li>
					<li class="blank">:</li>
					<li class="in"><input type="text" name="mail_address" value="${mem.mail_address}" maxlength="50" style="width:310px"/></li>					
				</ul>				
				<ul>
					<li class="title"><label for="name01">お名前</label></li>
					<li class="blank">:</li>
					<li class="in2"><input type="text" name="name1" value="${mem.name1}" maxlength="50" style="width:185px"/></li>
					<li class="title2"><label for="name02">アルファベット</label></li>
					<li class="blank">:</li>
					<li class="in3"><input type="text" name="name2" value="${mem.name2}" maxlength="50" style="width:185px"/></li>
				</ul>				
				<ul>
					<li class="title"><label for="home">お住まいの地域 </label></li>
					<li class="blank">:</li>
					<li class="in2">
						<select name="kuni" style="height:20px;">
<c:choose>
	<c:when test="${mem.kuni=='北海道'}">
			<option value="北海道" selected="selected">北海道</option>
	</c:when>
	<c:when test="${mem.kuni=='青森県'}">
			<option value="青森県" selected="selected">青森県</option>
	</c:when>
	<c:when test="${mem.kuni=='岩手県'}">
			<option value="岩手県" selected="selected">岩手県</option>
	</c:when>
	<c:when test="${mem.kuni=='宮城県'}">
			<option value="宮城県" selected="selected">宮城県</option>
	</c:when>
	<c:when test="${mem.kuni=='秋田県'}">
			<option value="秋田県" selected="selected">秋田県</option>
	</c:when>
	<c:when test="${mem.kuni=='山形県'}">
			<option value="山形県" selected="selected">山形県</option>
	</c:when>
	<c:when test="${mem.kuni=='福島県'}">
			<option value="福島県" selected="selected">福島県</option>
	</c:when>
	<c:when test="${mem.kuni=='茨城県'}">
			<option value="茨城県" selected="selected">茨城県</option>
	</c:when>
	<c:when test="${mem.kuni=='栃木県'}">
			<option value="栃木県" selected="selected">栃木県</option>
	</c:when>
	<c:when test="${mem.kuni=='群馬県'}">
			<option value="群馬県" selected="selected">群馬県</option>
	</c:when>
	<c:when test="${mem.kuni=='埼玉県'}">
			<option value="埼玉県" selected="selected">埼玉県</option>
	</c:when>
	<c:when test="${mem.kuni=='千葉県'}">
			<option value="千葉県" selected="selected">千葉県</option>
	</c:when>
	<c:when test="${mem.kuni=='東京都'}">
			<option value="東京都" selected="selected">東京都</option>
	</c:when>
	<c:when test="${mem.kuni=='神奈川県'}">
			<option value="神奈川県" selected="selected">神奈川県</option>
	</c:when>
	<c:when test="${mem.kuni=='新潟県'}">
			<option value="新潟県" selected="selected">新潟県</option>
	</c:when>
	<c:when test="${mem.kuni=='富山県'}">
			<option value="富山県" selected="selected">富山県</option>
	</c:when>
	<c:when test="${mem.kuni=='石川県'}">
			<option value="石川県" selected="selected">石川県</option>
	</c:when>
	<c:when test="${mem.kuni=='福井県'}">
			<option value="福井県" selected="selected">福井県</option>
	</c:when>
	<c:when test="${mem.kuni=='山梨県'}">
			<option value="山梨県" selected="selected">山梨県</option>
	</c:when>
	<c:when test="${mem.kuni=='長野県'}">
			<option value="長野県" selected="selected">長野県</option>
	</c:when>
	<c:when test="${mem.kuni=='岐阜県'}">
			<option value="岐阜県" selected="selected">岐阜県</option>
	</c:when>
	<c:when test="${mem.kuni=='静岡県'}">
			<option value="静岡県" selected="selected">静岡県</option>
	</c:when>
	<c:when test="${mem.kuni=='愛知県'}">
			<option value="愛知県" selected="selected">愛知県</option>
	</c:when>
	<c:when test="${mem.kuni=='三重県'}">
			<option value="三重県" selected="selected">三重県</option>
	</c:when>
	<c:when test="${mem.kuni=='滋賀県'}">
			<option value="滋賀県" selected="selected">滋賀県</option>
	</c:when>
	<c:when test="${mem.kuni=='京都府'}">
			<option value="京都府" selected="selected">京都府</option>
	</c:when>
	<c:when test="${mem.kuni=='大阪府'}">
			<option value="大阪府" selected="selected">大阪府</option>
	</c:when>
	<c:when test="${mem.kuni=='兵庫県'}">
			<option value="兵庫県" selected="selected">兵庫県</option>
	</c:when>
	<c:when test="${mem.kuni=='奈良県'}">
			<option value="奈良県" selected="selected">奈良県</option>
	</c:when>
	<c:when test="${mem.kuni=='和歌山県'}">
			<option value="和歌山県" selected="selected">和歌山県</option>
	</c:when>
	<c:when test="${mem.kuni=='鳥取県'}">
			<option value="鳥取県" selected="selected">鳥取県</option>
	</c:when>
	<c:when test="${mem.kuni=='島根県'}">
			<option value="島根県" selected="selected">島根県</option>
	</c:when>
	<c:when test="${mem.kuni=='岡山県'}">
			<option value="岡山県" selected="selected">岡山県</option>
	</c:when>
	<c:when test="${mem.kuni=='広島県'}">
			<option value="広島県" selected="selected">広島県</option>
	</c:when>
	<c:when test="${mem.kuni=='山口県'}">
			<option value="山口県" selected="selected">山口県</option>
	</c:when>
	<c:when test="${mem.kuni=='徳島県'}">
			<option value="徳島県" selected="selected">徳島県</option>
	</c:when>
	<c:when test="${mem.kuni=='香川県'}">
			<option value="香川県" selected="selected">香川県</option>
	</c:when>
	<c:when test="${mem.kuni=='愛媛県'}">
			<option value="愛媛県" selected="selected">愛媛県</option>
	</c:when>
	<c:when test="${mem.kuni=='高知県'}">
			<option value="高知県" selected="selected">高知県</option>
	</c:when>
	<c:when test="${mem.kuni=='福岡県'}">
			<option value="福岡県" selected="selected">福岡県</option>
	</c:when>
	<c:when test="${mem.kuni=='佐賀県'}">
			<option value="佐賀県" selected="selected">佐賀県</option>
	</c:when>
	<c:when test="${mem.kuni=='長崎県'}">
			<option value="長崎県" selected="selected">長崎県</option>
	</c:when>
	<c:when test="${mem.kuni=='熊本県'}">
			<option value="熊本県" selected="selected">熊本県</option>
	</c:when>
	<c:when test="${mem.kuni=='大分県'}">
			<option value="大分県" selected="selected">大分県</option>
	</c:when>
	<c:when test="${mem.kuni=='宮崎県'}">
			<option value="宮崎県" selected="selected">宮崎県</option>
	</c:when>
	<c:when test="${mem.kuni=='鹿児島県'}">
			<option value="鹿児島県" selected="selected">鹿児島県</option>
	</c:when>
	<c:when test="${mem.kuni=='沖繩県'}">
			<option value="沖繩県" selected="selected">沖繩県</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・ヨーロッパ（ロシア含む）地域'}">
			<option value="海外・ヨーロッパ（ロシア含む）地域" selected="selected">海外・ヨーロッパ（ロシア含む）地域</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・中近東地域'}">
			<option value="海外・中近東地域" selected="selected">海外・中近東地域</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・アフリカ地域'}">
			<option value="海外・アフリカ地域" selected="selected">海外・アフリカ地域</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・北米地域'}">
			<option value="海外・北米地域" selected="selected">海外・北米地域</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・中南米地域'}">
			<option value="海外・中南米地域" selected="selected">海外・中南米地域</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・アジア地域'}">
			<option value="海外・アジア地域" selected="selected">海外・アジア地域</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・オセアニア地域'}">
			<option value="海外・オセアニア地域" selected="selected">海外・オセアニア地域</option>
	</c:when>
	<c:when test="${mem.kuni=='海外・上記以外'}">
			<option value="海外・上記以外" selected="selected">海外・上記以外</option>
	</c:when>	
	<c:otherwise>
	    		<option value="回答なし" selected="selected">選択してください。</option>
	</c:otherwise>
</c:choose>				
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
			</div>
			<p class="join_title"><img src="<%=urlPage%>images/main/title_customer_coment.gif" alt="Required" title="Required"/></p>
			<p class="fdkbox">
				<%
					FCKeditor fck = new FCKeditor( request, "comment" ) ;
					fck.setBasePath("/fckeditor/" ) ;
					fck.setToolbarSet("Basic");			
					fck.setValue( "内容!!" );
					out.println( fck.create() ) ;
				%>		
			
			</p>
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
<div class="subPro02">
<div class="subContent1 module"> 	
<jsp:include page="/orms/module/right_common.jsp" flush="false"/>
<p class="pad_t10"><a href=""><img src="<%=urlPage%>images/css_img/picture/biocollagen.jpg" alt="Boi Collagen" /></a></p>
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->		
</div>
<hr />
</form>