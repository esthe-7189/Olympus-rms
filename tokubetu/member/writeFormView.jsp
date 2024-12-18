<%@ page contentType = "text/html; charset=utf-8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>

<%
String urlPage=request.getContextPath()+"/";
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
//이메일 직접 입력
function emailserv(){
  var frm = document.memberInput;
  var value = frm.email2.value;
  if( value == "etc")  {
    emailservEtc();
  }
  return;
}

// 중복ID체크
function checkId(){
	var member_id = document.memberInput.member_id;	

	if (!isLoginname(member_id)) {
      alert("使えるidを正確に書いて下さい。");
	  member_id.focus();
      return ;
    }
	var param = "&member_id="+member_id.value;
	openNoScrollWin("member_id.jsp", "member_pop_id", "id探し", "430", "340", param);
}

function emailservEtc() {
  var urlname = "pop_email.jsp";
  addr_etc = window.open(urlname, "win1","status=no,resizable=no,menubar=no,scrollbars=no,width=430,height=340");
  addr_etc.focus();
}

function goWrite(){
var frm=document.memberInput;
var member_id = Replace_Blank(frm.member_id.value);

if(isEmpty(frm.nm, "名前を入力して下さい。!")) return;
if(isEmpty(frm.hurigana, "名前(ふりがな)を入力して下さい。!")) return;
if(isOutOfRange(frm.member_id, 4, 8, "idは英語と数字の4~8字のみ可能です。")) return;
if(isOutOfRange(frm.password, 4, 8, "秘密番号は英語と数字の4~8字のみ可能です。")) return;
if(isNotValidPassword(frm)) return;

if(isEmpty(frm.email1, "メールを記入して下さい。!")) return;
if(!isVaildMail(frm.email1.value+frm.email2.value)) {
    window.alert("メールを正しく書いて下さい。特殊文字などは入力不可能です。!");
    return;
  }
  if(frm.email1.value.substring(frm.email1.value.lastIndexOf("@"))){
    if (frm.email1.value.substring(frm.email1.value.lastIndexOf("@")).search("@") != -1){
      alert("めーるアドレスに '@'を抜いて入力して下さい。!");
      return;
    }
  } 

if(isEmpty(frm.tel, "電話番号を入力して下さい。!")) return;
if(isEmpty(frm.himithu_2, "秘密の答えを入力して下さい。!")) return;

frm.member_id.value = member_id;
if (frm.CHECK_FG.value != 'Y' || member_id != frm.CHECKED_EMAIL.value) {
		alert("IDcheckのButtonを押してください");
		return;
	}

if ( confirm("会員に登録しますか?") != 1 ) {	return;}

frm.mail_address.value=frm.email1.value+frm.email2.value;
if (frm.bir_day.value==""){ frm.bir_day.value="0000-00-00"; }
if (frm.zip.value==""){ frm.zip.value="000-0000"; }
if (frm.address.value==""){ frm.address.value="No Data"; }


frm.action = "<%=urlPage%>tokubetu/member/memberOk.jsp";	
frm.submit();
}
//-->
</SCRIPT>

<center>
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="100%"  height="30" style="padding: 0 0 0 0"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">会員登録 
    		</td>    	
	</tr>		
</table>

<p>
<!-- 내용 시작 *****************************************************************-->
<table  width="70%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">
<form name="memberInput" action="<%=urlPage%>tokubetu/member/memberOk.jsp" method="post" >
	 <input type="hidden" name="mail_address" value="">
	 <input type="hidden" name="member_yn" value="1">	 
	 <input type="hidden" name="CHECK_FG" value="N">
	 <input type="hidden" name="CHECKED_EMAIL">
<tr>
		<td bgcolor= "#F7F5EF" style="padding: 5 0 5 10" class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=60);">
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=30);">次の内容を書いてください！！</td>
		<td bgcolor= "#F7F5EF" style="padding: 5 30 5 0;" align="right">
			<a href="<%=urlPage%>tokubetu/admin/member/listForm.jsp" onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_cate_list.gif" align="absmiddle" border="0" alt="List"></a>
		</td>
</tr>
<tr>
	<td align="center" style="padding: 0 0 30 0" colspan="2">						
		<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>氏名(漢字) :</td>
				<td style="padding: 5 0 0 0" width="80%">
					<input type="text" name="nm"  value=""  maxlength="20"  class="logbox" style="width:100px">
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>ふりがな(全角カタガナ) :</td>
				<td style="padding: 5 0 0 0" width="80%">
					<input type="text" name="hurigana"  value=""  maxlength="20"  class="logbox" style="width:100px">
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>User ID :</td>
				<td style="padding: 5 0 0 0" width="80%">
					<INPUT TYPE="TEXT" NAME="member_id"  VALUE="" SIZE="20" maxlength="15"   class="logbox" style="width:100px;ime-mode:disabled">
					<a href="JavaScript:checkId();" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/btn_search_j.gif"  align="absmiddle"></a>
					<font color="#807265">( 4～15字の半角英数字)</font>
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>パスワード :</td>
				<td style="padding: 5 0 0 0" width="80%">
					<INPUT TYPE="password" NAME="password"  VALUE="" SIZE="20" maxlength="30"   class="logbox" style="width:100px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>パスワード 2 :</td>
				<td style="padding: 5 0 0 0" width="80%">
					<INPUT TYPE="password" NAME="password2"  VALUE="" SIZE="20" maxlength="30"   class="logbox" style="width:100px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>				
			<tr>
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>メールアドレス :</td>
				<td style="padding: 5 0 0 0" width="80%">
					<input type="text" name="email1"  onChange="emailserv()" maxlength="17" class="logbox" style="width:70px;ime-mode:disabled"> @
						<select name="email2" onchange="emailserv()">
						<option value="@olympus-rms.co.jp" selected>olympus-rms.co.jp</option>																					
						<option value="@hanmail.com" >hanmail.com</option>
						<option value="@naver.com" >naver.com</option>
						<option value="@hotmail.com" >hotmail.com</option>
						<option value="@yahoo.co.kr" >yahoo.co.kr</option>
						<option value="@hanmir.com" >hanmir.com</option>
						<option value="@lycos.co.kr" >lycos.co.kr</option>
						<option value="@nate.com" >nate.com</option>
						<option value="@dreamwiz.com" >dreamwiz.com</option>
						<option value="@korea.com" >korea.com</option>
						<option value="@empal.com" >empal.com</option>
						<option value="@netian.com" >netian.com</option>
						<option value="@freechal.com" >freechal.com</option>
						<option value="etc">直接入力</option>
					</select>	
				</td>
			</tr>	
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>電話(携帯)番号:</td>
			    	<td style="padding: 5 0 0 0"><input type="text" name="tel"  value=""  maxlength="15"  class="logbox" style="width:100px"><font color="#807265">( 例：03-3347-6081)</font>
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >郵便番号:</td>
			    	<td><input type="text" name="zip"  value=""  maxlength="20"  class="logbox" style="width:80px"><font color="#807265">（半角数字７桁）（例：<img src="<%=urlPage%>rms/image/user/zip_jirusi_03.gif" valign="top">123-0001）</font>
			    	</td>   
			</tr>
		    	<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >住所:</td>
			    	<td><input type="text" name="address"  value=""  maxlength="200"  class="logbox" style="width:250px">
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >性別:</td>
			    	<td><input type="radio" name="sex" value="1" checked onfocus="this.blur();">男   <input type="radio" name="sex" value="2" onfocus="this.blur();">女
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >生年月日:</td>
			    	<td><input type="text" size="13%" name='bir_day' class=calendar value="" style="text-align:center">
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >職名:</td>
			    	<td><input type="text" name="position"  value=""  maxlength="80"  class="logbox" style="width:250px">
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#ffffff" colspan="2"><font color="#CC0000">※</font>秘密の質問と答え 
	<font color="#807265">( パスワードの再発行に使えます。)</font></td>			    	
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" bgcolor="#ffffff" colspan="2">
					-秘密の質問を選択して下さい:
						<select name="himithu_1">
							<option value="1"  selected>飼っているペットの名前は？</option>	
							<option value="2"  selected>旅行に行きたい場所は？</option>
							<option value="3"  selected>子ども時代のヒーローは？</option>	
							<option value="4"  selected>嫌いな食べ物は？</option>	
							<option value="5"  selected>応援しているチームは？</option>	
							<option value="6"  selected>名前を変えるとしたら何？</option>
							<option value="7"  selected>よくドライブした場所は？</option>
							<option value="8"  selected>一番好きな映画は？</option>	
						</select>
							-秘密の答えを書いてください:<input type="text" name="himithu_2"  value=""  maxlength="50"  class="logbox" style="width:130px">
				
				</td>			    	
			</tr>
			<tr>
				<td colspan=2 align="center"><br><br>
					<a href="JavaScript:goWrite()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif"></a>				
				</td>
		</tr>	
	</form>
</table>
<!-- 내용 끝 *****************************************************************-->				                            	
 </td>
 </tr>
 </table>