<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String urlPage=request.getContextPath()+"/orms/";
String urlPage2="https://olympus-rms.com/orms/";

	Cookie [] cookies=request.getCookies();
	Cookie cookie=null;
	int cheOk=1;
	String idvalue="";
	String cookiesNameCk="";
	
	if(cookies != null){
    		for(int i = 0; i < cookies.length; i++){
     			if(cookies[i].getName().equals("idNameHome")){      
				cheOk=2;
				idvalue= cookies[i].getValue() ;
				cookiesNameCk=cookies[i].getName();				
     			}
    		}    		
  	 }
%>


<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif">Login</p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu_07.gif"></p>
		</div>
<form action="<%=urlPage2%>member/login.jsp" method="post"  name="memberInput"  onSubmit = "">
	<input type="hidden" name="cooki_mail" >	 		
<!-- title end **********************************-->	
		<div id="content"> 		
			<p class="l18 mb20 ">
				予め会員登録し、IDのお持ち方はログインしてください。<span class="f_ora">IDはメールのアドレスです。</span><br/>
			</p>			
			<div class="sign_box" style="padding:">
				<p><img src="<%=urlPage%>images/common/log_text_title.jpg" alt="Registered Users" title="Registered Users"/></p>				
				<div class="login_box">
					<ul class="box">
						<li class="ip">
							<ol>
								<li class="title">メール:</li>								
								<li class="in">				
				<input type="text" name="mail_address"  value="<c:forTokens items='<%=idvalue%>' delims='_' var='sel' varStatus='idx' >${sel}<c:if test='${idx.index%2==0}'>@</c:if></c:forTokens>"  maxlength="100" style="width:186px"/></li>								
							</ol>
							<ol class="pad_t10">
								<li class="title">パスワード:</li>								
								<li class="in"><input type="password" name="password" maxlength="50" style="width:186px" onKeyDown="javascript:if(event.keyCode == 20) submit_signin();" /></li>
							</ol>
						</li>
						<li class="btn"><img src="<%=urlPage%>images/common/btn_login.gif" onClick="javascript:goPage('idName');" style="cursor:pointer;" alt="sign in" title="sign in"/></li>
						<li class="password"><a href="javascript:forgot_password()">パスワードを忘れましたか？</a></li>
					</ul>		
					<p class="remember"><input type="checkbox" name="idSave" value="save" <%if(cheOk==2){%>checked <%}%>/> 次回からIDの入力を省略</p>
				</div>
				<div class="register">					
					<div class="reg_txt">
						<a href="<%=urlPage%>member/memberForm.jsp" >
						<img src="<%=urlPage%>images/bg/log_id_new.gif" onClick="signup_form();" style="cursor:pointer;" alt="register" title="register" border="0"/></a>						
					</div>
				</div>				
			</div>	
			<div class="sign_txt01">
				<ul>
					<li><span>Welcome to OLYMPUS-RMS.COM!<br />OLYMPUS-RMS.COM allows you to use most of the menus without signing up.</span>
						<dl>
							<dt>But if you sign up, you can enjoy additional services as follows:</dt>
							<dd>- You can participate in online surveys of olympus-rms.com, and be rewarded for the participation. </dd>							
							<dd>- You will receive olympus-rms.com newsletters by e-mail. </dd>
							<dd>- We will be offering a variety of additional services and benefits to the members.</dd>
							<dd>Thank you.</dd>
						</dl>
					</li>
				</ul>
			</div>			
	</div>
 </form>
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

<script language="JavaScript">
 function goPage(cookieName){
 	var frm=document.memberInput;
  	var expireDate = new Date();
  	var coValue1="";
  	var coValue2="";
  	var cookieNamePlus="";

 	
  	var cookie_mail = frm.mail_address.value.split("@");
	if (cookie_mail.length == 2) {
		coValue1=cookie_mail[0];
		coValue2=cookie_mail[1];
		cookieNamePlus=coValue1+"_"+ coValue2;
	}
	 
  	if (frm.idSave.checked != true){		
		expireDate.setDate( expireDate.getDate() - 1 );
  		document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
	  }	
	  
  	  if (chkSpace(frm.mail_address.value)) {
   	    	alert("IDを入力して下さい!!");
              frm.mail_address.focus();    return ;                   
         }else if (chkSpace(frm.password.value)) {
            alert("パスワードを 入力して下さい!!");
            frm.password.focus();   return ;         
         }
  frm.cooki_mail.value=cookieNamePlus;
  frm.action="<%=urlPage2%>member/login.jsp"
  frm.submit();
 }

function chkSpace(strValue) {
    var flag=true;
    if (strValue!="") {
        for (var i=0; i < strValue.length; i++) {
            if (strValue.charAt(i) != " ") {
	        	flag=false;
	        	break;
	    	}
        }
    }
    return flag;
}

</script>