<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<%
String urlPage=request.getContextPath()+"/orms/";	
String urlPagemain=request.getContextPath()+"/";	


%>






<!--right Email Page -->	
<script type="text/javascript" language="javascript">
	function validateCheckBox(objSrc, args)
	{
		var retVal = false;
        var cnt = 18;
        var cblid = 'ctl00_cphPageSpecific_phRightSideColumn_SubControl_5_chklNLTypes';
        var i = 0;
        for(i=0; i < cnt ; i++)
        {
            if(document.getElementById(cblid + '_' + i).checked)
            {
                retVal = true;
                break;
            }
        }
        args.IsValid = retVal;
	}
</script>
<script type="text/javascript"> 
//뉴스레터 신청
function fn_goLetter() {
	if ('' == '') {
		if (confirm("Sign in to use this service. Would you like to go back to Sign in page?")) {
			fn_Gologin();
		}
	} else {
		if ('' == 'Y') {
			alert("Already subscribed to newsletter.");
		} else {
			// news letter popup open
			var winwidth = 500;
			var winheight = 262;
			var windowOpenState = "directories=no,menubar=no,scrollbars=no,status=no,resizable=no,toolbar=no,height=" + winheight + ",width=" + winwidth;
			windowOpenState = windowOpenState + ",left=" + ((screen.availWidth - winwidth) / 2) + ",top=" + ((screen.availHeight - winheight)/2);
			winopen = window.open('/en/util/util_letter_pop.do',"newsletter",windowOpenState);
		}
	}
}
</script>
<div class="contentBox module newsletterSignUp">
	<div class="topBarInactive">
		<div class="titlebox"><h3>Email Newsletters</h3></div>
	</div>
	<div class="inner module">
		<div id="" style="color:Red;display:none;">

</div>
		<p>次の内容をチェックし、メールのアドレスを送ると求める情報がもらえます。<br /></p>		
		<div id="" onkeypress="javascript:return WebForm_FireDefaultButton(event, 'ctl00_cphPageSpecific_phRightSideColumn_SubControl_5_btnSubscribe')">
	
			<div class="checkBoxList module">
				<span id="" style="color:Red;display:none;"></span>
				<a href="http://www.iwakikorea.com" id='selectAll' class="button buttonGeneral" onclick="return false;" onfocus="this.blur()">Select
					All</a>
				<span id="" class="columnCheckBoxList sub2 module">
				<input id="" onfocus="this.blur()" type="checkbox" name="" />
				<label for="">製品情報</label><br>
				<input id="" onfocus="this.blur()" type="checkbox" name="" />
				<label for="">関連情報 </label><br>
				<input id="" onfocus="this.blur()" type="checkbox" name="" />
				<label for="">ニュース </label>				
				</span>				
			</div>
			<div class="inputFields">
				<label for="" id="">Email Address</label>
				<span id="" style="color:Red;display:none;"></span>
				<span id="" title="Invalid E-mail address" style="color:Red;display:none;"></span>
				<div class="module">
					<input name="emailAddress" type="text" id="" class="textBox" />
					<a href="javascript:alert('工事中');">
						<img src="<%=urlPage%>images/admin/btn_red_ok.gif" align="absmiddle" />
					</a>
				</div>
			</div>			
		</div>
	</div>
	<div class="bottom"><div></div></div>
</div>
<!--right Email Page -->	
				
			
			
			
			
			
			
			