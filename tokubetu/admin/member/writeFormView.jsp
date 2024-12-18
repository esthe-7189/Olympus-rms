<%@ page contentType = "text/html; charset=utf-8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>

<%
int level=0;		
MemberManager manager = MemberManager.getInstance();
	String id=(String)session.getAttribute("ID");	
	Member member2=manager.getMember(id);
	if(member2!=null){ level=member2.getLevel();}
	
	String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	if(level!=1){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
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
if(isOutOfRange(frm.member_id, 4, 15, "idは英語と数字の4~15字のみ可能です。")) return;
if(isOutOfRange(frm.password, 4, 15, "秘密番号は英語と数字の4~15字のみ可能です。")) return;
if(isNotValidPassword(frm)) return;

if(isEmpty(frm.email1, "メールを記入して下さい。!")) return;
if(!isVaildMail(frm.email1.value+frm.email2.value)) {
    window.alert("メールを正しく書いて下さい。特殊文字などは入力不可能です。!");
    return;
  }
  if(frm.email1.value.substring(frm.email1.value.lastIndexOf("@"))){
    if (frm.email1.value.substring(frm.email1.value.lastIndexOf("@")).search("@") != -1){
      alert("メールアドレスに '@'を抜いて入力して下さい。!");
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


frm.action = "<%=urlPage%>tokubetu/admin/member/memberOk.jsp";	
frm.submit();
}
//-->
</SCRIPT>
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#bir_day").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-90:c+2' ,showAnim: "slide"}); });

</script>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  <span class="calendar7">会員登録  <font color="#A2A2A2">></font> 新規登録</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>tokubetu/admin/member/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>tokubetu/member/writeForm.jsp'">			
</div>
<div id="boxNoLineBig"  >
	<div class="boxCalendar_80">			
<table  width="800" border="0" cellspacing="2" cellpadding="2" >								
		<tr>
			<td width="20%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">  情報入力				
			</td>
			<td width="80%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
			</td>			
		</tr>	
</table>	
<table width="800"  class="tablebox" cellspacing="5" cellpadding="5">
<form name="memberInput" action="<%=urlPage%>tokubetu/member/memberOk.jsp" method="post" >
	 <input type="hidden" name="mail_address" value="">
	 <input type="hidden" name="member_yn" value="1">	 
	 <input type="hidden" name="CHECK_FG" value="N">
	 <input type="hidden" name="CHECKED_EMAIL">
			<tr >
				<td  width="20%" ><font color="#CC0000">※</font><span class="titlename">氏名(漢字) :</span></td>
				<td  width="80%">
					<input type="text" name="nm"  value=""  maxlength="20"  class="input02" style="width:150px">
				</td>
			</tr>	
			<tr>
				<td  width="20%" ><font color="#CC0000">※</font><span class="titlename">ふりがな(全角カタガナ) :</span></td>
				<td  width="80%">
					<input type="text" name="hurigana"  value=""  maxlength="20"  class="input02" style="width:150px">
				</td>
			</tr>	
			<tr>
				<td  width="20%" ><font color="#CC0000">※</font><span class="titlename">User ID :</span></td>
				<td  width="80%">
					<INPUT TYPE="TEXT" NAME="member_id"  VALUE="" SIZE="20" maxlength="15"   class="input02" style="width:150px;ime-mode:disabled">
					<a href="JavaScript:checkId();" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/btn_search_j.gif"  align="absmiddle"></a>
					<font color="#807265">( 4～15字の半角英数字)</font>
				</td>
			</tr>	
			<tr>
				<td  width="20%" ><font color="#CC0000">※</font><span class="titlename">パスワード :</span></td>
				<td  width="80%">
					<INPUT TYPE="password" NAME="password"  VALUE="" SIZE="20" maxlength="30"   class="input02" style="width:150px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>	
			<tr>
				<td  width="20%" ><font color="#CC0000">※</font><span class="titlename">パスワード 2 :</span></td>
				<td  width="80%">
					<INPUT TYPE="password" NAME="password2"  VALUE="" SIZE="20" maxlength="30"   class="input02" style="width:150px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>				
			<tr>
				<td  width="20%" ><font color="#CC0000">※</font><span class="titlename">メールアドレス :</span></td>
				<td  width="80%">
					<input type="text" name="email1"  onChange="emailserv()" maxlength="17" class="input02" style="width:80px;ime-mode:disabled"> @
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
				<td  width="20%" ><font color="#CC0000">※</font><span class="titlename">電話(携帯)番号:</span></td>
			    	<td ><input type="text" name="tel"  value=""  maxlength="15"  class="input02" style="width:150px"><font color="#807265">( 例：03-3347-6081)</font>
			    	</td>   
			</tr>
			<tr>    
				<td  width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">郵便番号:</span></td>
			    	<td><input type="text" name="zip"  value=""  maxlength="20"  class="input02" style="width:80px"><font color="#807265">（半角数字７桁）（例：<img src="<%=urlPage%>rms/image/user/zip_jirusi_03.gif" valign="top">123-0001）</font>
			    	</td>   
			</tr>
		    	<tr>    
				<td  width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">住所:</span></td>
			    	<td><input type="text" name="address"  value=""  maxlength="200"  class="input02" style="width:280px">
			    	</td>   
			</tr>
			<tr>    
				<td  width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">性別:</span></td>
			    	<td><input type="radio" name="sex" value="1" checked onfocus="this.blur();">男   <input type="radio" name="sex" value="2" onfocus="this.blur();">女
			    	</td>   
			</tr>
			<tr>    
				<td  width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">生年月日:</span></td>
			    	<td><input type="text" size="13%" name="bir_day" id="bir_day"  value="" style="text-align:center">
			    	</td>   
			</tr>
			<tr>    
				<td  width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">職名:</span></td>
			    	<td><input type="text" name="position"  value=""  maxlength="80"  class="input02" style="width:280px">
			    	</td>   
			</tr>
			<tr>    
				<td  width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">職責レベル指定:</span></td>
			    	<td>
			    		<select name="position_level">
						<option value="0">レベルの順番をご選択！！</option>
						<option value="1">Grade4</option>
						<option value="2">Grade3</option>
						<option value="3">Grade2</option>
						<option value="4">Grade1</option>
						<option value="5">その他1 </option>
						<option value="6">その他2</option>
						<option value="7">その他3</option>
						<option value="8">その他4</option>						
					</select>
			    	</td>   
			</tr>
			<tr>    
				<td  width="20%"  colspan="2"><font color="#CC0000">※</font>秘密の質問と答え 
	<font color="#807265">( パスワードの再発行に使えます。)</font></td>			    	
			</tr>
			<tr>    
				<td  width="20%"  colspan="2">
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
							-秘密の答えを書いてください:<input type="text" name="himithu_2"  value=""  maxlength="50"  class="input02" style="width:150px">
				
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
 	</div>
</div>	