<%@ page contentType = "text/html; charset=utf-8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("acc")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
MemberManager mgr = MemberManager.getInstance();
	String id=(String)session.getAttribute("ID");	
	int level=0;
	Member member2=mgr.getMember(id);
	if(member2!=null){ level=member2.getLevel();}

	
String member_id=request.getParameter("member_id");
MemberManager manager=MemberManager.getInstance();
Member member=manager.getMember(member_id);
%>
<c:set var="member" value="<%=member%>" />

<SCRIPT LANGUAGE="JavaScript">
<!--


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


function goWrite(){
var frm=document.memberInput;
var member_id = Replace_Blank(frm.member_id.value);

if(isEmpty(frm.nm, "名前を入力して下さい。!")) return;
if(isEmpty(frm.hurigana, "名前(ふりがな)を入力して下さい。!")) return;
if(isOutOfRange(frm.member_id, 3, 20, "idは英語と数字の3~20字のみ可能です。")) return;
if(isOutOfRange(frm.password, 3, 20, "秘密番号は英語と数字の3~20字のみ可能です。")) return;
if(isNotValidPassword(frm)) return;

if(isEmpty(frm.mail_address, "メールを記入して下さい。!")) return;
if(!isVaildMail(frm.mail_address.value)) {
    window.alert("メールを正しく書いて下さい。特殊文字などは入力不可能です。!");
    return;
  }
 
if(isEmpty(frm.tel, "電話番号を入力して下さい。!")) return;
if(isEmpty(frm.himithu_2, "秘密の答えを入力して下さい。!")) return;

/*
frm.member_id.value = member_id;
if (frm.CHECK_FG.value != 'Y' || member_id != frm.CHECKED_EMAIL.value) {
		alert("IDcheckのButtonを押してください");
		return;
	}
*/

if ( confirm("修正しますか?") != 1 ) {	return;}

if (frm.bir_day.value==""){ frm.bir_day.value="0000-00-00"; }
if (frm.zip.value==""){ frm.zip.value="000-0000"; }
if (frm.address.value==""){ frm.address.value="No Data"; }


frm.action = "<%=urlPage%>accounting/admin/member/updateView_admin.jsp";	
frm.submit();
}
//-->
</SCRIPT>
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  <span class="calendar7">会員登録  <font color="#A2A2A2">></font> 会員情報の修正</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<%if(level==1){%>
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>accounting/admin/member/listForm.jsp'">	
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>accounting/member/writeForm.jsp'">		
	<%}else{%>.<%}%>	
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
				
	
<!-- 내용 시작 *****************************************************************-->
<table width="800"  class="tablebox" cellspacing="5" cellpadding="5">		
<form name="memberInput" action="<%=urlPage%>accounting/admin/member/updateView_admin.jsp" method="post" >	 
	 <input type="hidden" name="member_yn" value="${member.member_yn}"> <!-- 2는 승인된 번호*-->	 
	 <input type="hidden" name="mseq" value="${member.mseq}">
	 <input type="hidden" name="level" value="${member.level}">
	 <input type="hidden" name="CHECK_FG" value="N">
	 <input type="hidden" name="CHECKED_EMAIL">
	 <input type="hidden" name="member_id" value="${member.member_id}">
	
<c:if test="${! empty member}" />	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" ><font color="#CC0000">※</font><span class="titlename">氏名(漢字) :</span></td>
				<td style="padding: 5 0 0 0" width="80%">
					<input type="text" name="nm"  value="${member.nm}"  maxlength="20"  class="input02" style="width:100px">
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" ><font color="#CC0000">※</font><span class="titlename">ふりがな(全角カタガナ) :</span></td>
				<td style="padding: 5 0 0 0" width="80%">
					<input type="text" name="hurigana"  value="${member.hurigana}"  maxlength="20"  class="input02" style="width:100px">
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" ><font color="#CC0000">※</font><span class="titlename">User ID :</span></td>
				<td style="padding: 5 0 0 0" width="80%">${member.member_id}	<font color="#807265">(IDは修正できません)</font>
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" ><font color="#CC0000">※</font><span class="titlename">パスワード :</span></td>
				<td style="padding: 5 0 0 0" width="80%">
					<INPUT TYPE="password" NAME="password"  VALUE="${member.password}" SIZE="20" maxlength="30"   class="input02" style="width:250px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>	
			<tr>
				<td style="padding: 5 0 0 0" width="20%" ><font color="#CC0000">※</font><span class="titlename">パスワード 2 :</span></td>
				<td style="padding: 5 0 0 0" width="80%">
					<INPUT TYPE="password" NAME="password2"  VALUE="" SIZE="20" maxlength="30"   class="input02" style="width:250px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>				
			<tr>
				<td style="padding: 5 0 0 0" width="20%" ><font color="#CC0000">※</font><span class="titlename">メールアドレス :</span></td>
				<td style="padding: 5 0 0 0" width="80%">
					<input type="text" name="mail_address"  value="${member.mail_address}"  maxlength="50" class="input02" style="width:200px;ime-mode:disabled"> 
				</td>
			</tr>	
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" ><font color="#CC0000">※</font><span class="titlename">電話(携帯)番号:</span></td>
			    	<td style="padding: 5 0 0 0"><input type="text" name="tel"  value="${member.tel}"  maxlength="15"  class="input02" style="width:100px"><font color="#807265">( 例：03-3347-6081)</font>
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">郵便番号:</span></td>
			    	<td><input type="text" name="zip"  value="${member.zip}"  maxlength="20"  class="input02" style="width:80px"><font color="#807265">（半角数字７桁）（例：<img src="<%=urlPage%>rms/image/user/zip_jirusi_03.gif" valign="top">123-0001）</font>
			    	</td>   
			</tr>
		    	<tr>    
				<td style="padding: 5 0 0 0" width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">住所:</span></td>
			    	<td><input type="text" name="address"  value="${member.address}"  maxlength="200"  class="input02" style="width:400px">
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">性別:</span></td>
			    	<td>
			    		<c:if test="${member.sex=='1'}">
			    			<input type="radio" name="sex" value="1" checked onfocus="this.blur();">男   
			    			<input type="radio" name="sex" value="2" onfocus="this.blur();">女
			    		</c:if>
			    		<c:if test="${member.sex=='2'}">
			    			<input type="radio" name="sex" value="1" onfocus="this.blur();">男   
			    			<input type="radio" name="sex" value="2" checked onfocus="this.blur();">女
			    		</c:if>
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">生年月日:</span></td>
			    	<td><input type="text" name="bir_day"  id="bir_day"  value="${member.bir_day}"  maxlength="10" class="input02" style="width:100px;ime-mode:disabled"> <font color="#807265">( 例：0000-00-0000)</font>
			    		
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%" ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">職名:</span></td>
			    	<td><input type="text" name="position"  value="${member.position}"  maxlength="80"  class="input02" style="width:250px">
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%"  colspan="2"><font color="#CC0000">※</font>秘密の質問と答え 
	<font color="#807265">( パスワードの再発行に使えます。)</font></td>			    	
			</tr>
			<tr>    
				<td style="padding: 5 0 0 0" width="20%"  colspan="2">
					-秘密の質問を選択して下さい:
						<select name="himithu_1">			
							<option value="1"  <c:if test="${member.himithu_1=='1'}">selected</c:if>>飼っているペットの名前は？</option>	
							<option value="2"  <c:if test="${member.himithu_1=='2'}">selected</c:if>>旅行に行きたい場所は？</option>
							<option value="3"  <c:if test="${member.himithu_1=='3'}">selected</c:if>>子ども時代のヒーローは？</option>	
							<option value="4"  <c:if test="${member.himithu_1=='4'}">selected</c:if>>嫌いな食べ物は？</option>	
							<option value="5"  <c:if test="${member.himithu_1=='5'}">selected</c:if>>応援しているチームは？</option>	
							<option value="6"  <c:if test="${member.himithu_1=='6'}">selected</c:if>>名前を変えるとしたら何？</option>
							<option value="7"  <c:if test="${member.himithu_1=='7'}">selected</c:if>>よくドライブした場所は？</option>
							<option value="8"  <c:if test="${member.himithu_1=='8'}">selected</c:if>>一番好きな映画は？</option>	
						</select>
							-秘密の答えを書いてください:<input type="text" name="himithu_2"  value="${member.himithu_2}"  maxlength="50"  class="input02" style="width:130px">
				
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
 </div>
</div>