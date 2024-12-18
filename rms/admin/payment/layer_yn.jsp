<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String urlPage=request.getContextPath()+"/";	
String urlPage2=request.getContextPath()+"/orms/";	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String pgkind=request.getParameter("pgkind");
String seqList=request.getParameter("seqList");
String count=request.getParameter("count");
String docontact=request.getParameter("docontact");
String inDate=dateFormat.format(new java.util.Date());
String pageNum=request.getParameter("page");

MemberManager member=MemberManager.getInstance();
Member memTop=member.getMember(id);
        
%>
<c:set var="memTop" value="<%=memTop%>"/>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">	

<head>
<title>OLYMPUS RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<%=urlPage%>rms/css/style.css" type="text/css">
<script type="text/javascript" src="<%=urlPage%>rms/js/fadeEffects.js"></script>
<link rel="stylesheet" href="<%=urlPage%>fckeditor/_sample/sample.css" type="text/css">
<script  src="<%=urlPage%>fckeditor/fckeditor.js" type="text/javascript"></script>
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.min.js"></script>


<script type="text/javascript">
onload = function() {
	var frames = document.getElementsByTagName('iframe');   // iframe태그를 하고 있는 모든 객체를 찾는다.
	for(var i = 0; i < frames.length; i++)  {
		frames[i].setAttribute("allowTransparency","true");  // allowTransparency 속성을 true로 만든다.
	}
}	

function goWrite() {	
 var frm=document.memberInput;
     		
   if ( confirm("処理しますか？") != 1 ) {return ;}
	frm.action = "<%=urlPage%>rms/admin/payment/yn_pop.jsp";		
	frm.submit();
	
	var overlay = parent.document.getElementById('overlay');	
	 if(parent.document.getElementById("passpop").style.display == 'block'){
	 	overlay.style.display = "none";
		parent.document.getElementById("passpop").style.display="none";		
	 } 
}


function formClose(){
	var overlay = parent.document.getElementById('overlay');	
	 if(parent.document.getElementById("passpop").style.display == 'block'){
	 	overlay.style.display = "none";
		parent.document.getElementById("passpop").style.display="none";		
	 } 
}

</script>
	</head>
	
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#post_send_day").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
</script>	
<body  style="background-color:transparent;">

<div class="passpop_inner" >	
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<form name="memberInput" action="<%=urlPage%>rms/admin/payment/on_off.jsp" method="post"  onSubmit="return goWrite(this)" >			
	<input type="hidden" name="pgkind" value="<%=pgkind%>">		
	<input type="hidden" name="docontact" value="<%=docontact%>">
	<input type="hidden" name="seqList" value="<%=seqList%>">		
	<input type="hidden" name="page"   value="<%=pageNum%>">
	<tr>
		<td width="12" style="background:url('<%=urlPage%>rms/image/admin/titlePop.gif') no-repeat;"></td>
		<td width="280" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">
			<img src="<%=urlPage%>rms/image/icon_ball.gif" >			
				<span class="calendar7">東京(OT宇津木)/ 受領変更</span>						
		</td>	
		<td width="70">
			<a href="#"  onclick="formClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a>
		</td>
	</tr>
</table>
<div class="clear_margin"></div>		
<table width="100%" border="0" cellspacing="5" cellpadding="5">	
	<tr height="30">			
		<td width="100%" >
				<font color="#339900">（<%=count%>）</font>個のデータを処理します。<br>
		</td>
	</tr>
	<tr>			
		<td width="100%"  align="center">
				<input type="radio" name="data_yn"  value="1"  onfocus="this.blur()" checked>  未受領 &nbsp;
				<input type="radio" name="data_yn"  value="2"  onfocus="this.blur()" >  紛失 &nbsp;
				<input type="radio" name="data_yn"  value="3"  onfocus="this.blur()" >  受領完了						
		</td>
	</tr>
	<tr height="50">
		<td  align="center">
			<a href="JavaScript:goWrite()"><img src="<%=urlPage2%>images/common/btn_off_submit.gif"  title="修正する"></a>			
		</td>			
	</tr>				
	</form>			
</table>
</div>
</body>
</html>

	
	
	
	
	
	
	
	