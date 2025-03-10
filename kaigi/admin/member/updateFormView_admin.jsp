<%@ page contentType = "text/html; charset=utf-8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("kaigi")){
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
if(isEmpty(frm.em_number, "Noを入力して下さい。!")) return;
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


frm.action = "<%=urlPage%>kaigi/admin/member/update_admin.jsp";	
frm.submit();
}
//-->
</SCRIPT>


    	<img src="<%=urlPage%>rms/image/icon_ball.gif" >
	<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
	<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">会員情報の修正 </span>    		
<div class="clear_line_gray"></div>
<p>
<!-- 내용 시작 *****************************************************************-->
<table  width="95%" border="0" cellspacing="0" cellpadding="0" >
<form name="memberInput" action="<%=urlPage%>kaigi/admin/member/update_admin.jsp" method="post" >	 
	 <input type="hidden" name="member_yn" value="${member.member_yn}"> <!-- 2는 승인된 번호*-->	 
	 <input type="hidden" name="mseq" value="${member.mseq}">
	 <input type="hidden" name="level" value="${member.level}">
	 <input type="hidden" name="CHECK_FG" value="N">
	 <input type="hidden" name="CHECKED_EMAIL">
	 <input type="hidden" name="member_id" value="${member.member_id}">
	<tr>
		<td  style="padding: 5px 0px 5px 100px;" class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=60);">
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=30);">次の内容を書いてください！！</td>
		<td   align="right">
			<%if(level==1){%>
				<a href="<%=urlPage%>kaigi/admin/member/listForm.jsp" onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_list.gif" align="absmiddle" border="0" alt="List"></a>
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="リスト" onClick="location.href='<%=urlPage%>kaigi/admin/member/listForm.jsp'">
			<%}else{%>
					.
			<%}%>
			
		</td>
	</tr>
</table>
	
<div id="formBar">				
<c:if test="${! empty member}" />					
		<table width="95%" border=0 cellpadding=0 cellspacing=2 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>	
			<tr>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>氏名(漢字) :</td>
				<td style="padding: 5px 0px 5px 0px;" width="30%">
					<input type="text" name="nm"  value="${member.nm}"  maxlength="20"  class="logbox" style="width:100px">
				</td>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>社員NO :</td>
				<td style="padding: 5px 0px 5px 0px;" width="30%">
					<input type="text" name="em_number"  value="${member.em_number}"  maxlength="20"  class="logbox" style="width:100px">
				</td>
			</tr>	
			<tr>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>ふりがな(全角カタガナ) :</td>
				<td style="padding: 5px 0px 5px 0px;" width="30%">
					<input type="text" name="hurigana"  value="${member.hurigana}"  maxlength="20"  class="logbox" style="width:100px">
				</td>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>部署選択 :</td>
				<td style="padding: 5px 0px 5px 0px;" width="30%">														
				  <select name="busho" class="select_type3" >					
				    	<option value="0" <% if(member.getBusho().equals("0")){%>selected<%}%>>経営役員</option>	
					<option value="1" <% if(member.getBusho().equals("1")){%>selected<%}%>>企画部</option>
					<option value="2" <% if(member.getBusho().equals("2")){%>selected<%}%>>事業統括部</option>
					<option value="3" <% if(member.getBusho().equals("3")){%>selected<%}%>>開発部</option>	
					<option value="4" <% if(member.getBusho().equals("4")){%>selected<%}%>>製造部</option>	
					<option value="5" <% if(member.getBusho().equals("5")){%>selected<%}%>>品質保証部</option>	
					<option value="6" <% if(member.getBusho().equals("6")){%>selected<%}%>>臨床開発部</option>	
					<option value="7" <% if(member.getBusho().equals("7")){%>selected<%}%>>安全管理部</option>	
					<option value="8" <% if(member.getBusho().equals("8")){%>selected<%}%>>その他</option>														
				  </select>					
				</td>
				
			</tr>	
			<tr>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>User ID :</td>
				<td style="padding: 5px 0px 5px 0px;" width="80%" colspan="3">${member.member_id}	<font color="#807265">(IDは修正できません)</font>
				</td>
		<!--*****************>			
				<td style="padding: 5px 0px 5px 0px;" width="80%">
					<INPUT TYPE="TEXT" NAME="member_id"  VALUE="${member.member_id}" SIZE="20" maxlength="8"   class="logbox" style="width:100px;ime-mode:disabled" readonly onClick="JavaScript:checkId()" >
					<a href="JavaScript:checkId()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/btn_search_j.gif"  align="absmiddle"></a>
					<font color="#807265">( 4～8字の半角英数字)</font>
				</td>
		<*************-->				
			</tr>	
			<tr>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>パスワード :</td>
				<td style="padding: 5px 0px 5px 0px;" width="80%" colspan="3">
					<INPUT TYPE="password" NAME="password"  VALUE="${member.password}" SIZE="20" maxlength="30"   class="logbox" style="width:250px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>	
			<tr>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>パスワード 2 :</td>
				<td style="padding: 5px 0px 5px 0px;" width="80%" colspan="3">
					<INPUT TYPE="password" NAME="password2"  VALUE="" SIZE="20" maxlength="30"   class="logbox" style="width:250px"><font color="#807265">( 4～30字の半角英数字)</font>
				</td>
			</tr>				
			<tr>
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>メールアドレス :</td>
				<td style="padding: 5px 0px 5px 0px;" width="80%" colspan="3">
					<input type="text" name="mail_address"  value="${member.mail_address}"  maxlength="50" class="logbox" style="width:200px;ime-mode:disabled"> 
				</td>
			</tr>	
			<tr>    
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>電話(携帯)番号:</td>
			    	<td style="padding: 5px 0px 5px 0px;" colspan="3"><input type="text" name="tel"  value="${member.tel}"  maxlength="15"  class="logbox" style="width:100px"><font color="#807265">( 例：03-3347-6081)</font>
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >郵便番号:</td>
			    	<td colspan="3"><input type="text" name="zip"  value="${member.zip}"  maxlength="20"  class="logbox" style="width:80px"><font color="#807265">（半角数字７桁）（例：<img src="<%=urlPage%>rms/image/user/zip_jirusi_03.gif" valign="top">123-0001）</font>
			    	</td>   
			</tr>
		    	<tr>    
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >住所:</td>
			    	<td colspan="3"><input type="text" name="address"  value="${member.address}"  maxlength="200"  class="logbox" style="width:400px">
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >性別:</td>
			    	<td colspan="3">
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
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >生年月日:</td>
			    	<td colspan="3"><input type="text" name="bir_day"  value="${member.bir_day}"  maxlength="10" class="logbox" style="width:100px;ime-mode:disabled"> <font color="#807265">( 例：0000-00-0000)</font>
			    		
			    	</td>   
			</tr>
			<tr>    
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#F1F1F1"><img src="<%=urlPage%>rms/image/icon_s.gif" >職名:</td>
			    	<td colspan="3">
			    		<input type="text" name="position"  value="${member.position}"  maxlength="80"  class="logbox" style="width:250px">レベルの順番をご選択！！
			    		<select name="position_level">
			    				<option value="1" <%if(member.getPosition_level()==1){%>selected<%}%> >Grade4</option>
								<option value="2" <%if(member.getPosition_level()==2){%>selected<%}%> >Grade3</option>
								<option value="3" <%if(member.getPosition_level()==3){%>selected<%}%> >Grade2</option>
								<option value="4" <%if(member.getPosition_level()==4){%>selected<%}%> >Grade1</option>
								<option value="5" <%if(member.getPosition_level()==5){%>selected<%}%> >その他1 </option>
								<option value="6" <%if(member.getPosition_level()==6){%>selected<%}%> >その他2</option>
								<option value="7" <%if(member.getPosition_level()==7){%>selected<%}%> >その他3</option>
								<option value="8" <%if(member.getPosition_level()==8){%>selected<%}%> >その他4</option>														
					</select>			    		
			    	</td>   			    		
			</tr>
			<tr>    
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#ffffff" colspan="4"><font color="#CC0000">※</font>秘密の質問と答え 
					<font color="#807265">( パスワードの再発行に使えます。)</font>
				</td>			    	
			</tr>
			<tr>    
				<td style="padding: 5px 0px 5px 0px;" width="20%" bgcolor="#ffffff" colspan="4">
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
							-秘密の答えを書いてください:<input type="text" name="himithu_2"  value="${member.himithu_2}"  maxlength="50"  class="logbox" style="width:130px">
				
				</td>			    	
			</tr>
			<tr>
				<td colspan=4 align="center"><br><br>
					<a href="JavaScript:goWrite()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif"></a>				
				</td>
		</tr>	
	</form>
</table>
<!-- 내용 끝 *****************************************************************-->				                            	
 </div>