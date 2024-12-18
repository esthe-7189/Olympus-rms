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

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String seq=request.getParameter("seq");
String yn=request.getParameter("yn");
String pgkind=request.getParameter("pgkind");
String docontact=request.getParameter("docontact");
String urlPage=request.getContextPath()+"/";
String urlPage2=request.getContextPath()+"/orms/";	
String pageNum=request.getParameter("page");
String btn=request.getParameter("btn");
	if(btn==null){btn="A";}
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");

MemberManager member=MemberManager.getInstance();
Member memTop=member.getMember(id);

FileMgr mana = FileMgr.getInstance();
Category board = mana.select(Integer.parseInt(seq));  ;             
        
%>
<c:set var="memTop" value="<%=memTop%>"/>	
<c:set var="board" value="<%=board%>"/>	
	
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
	frm.action = "<%=urlPage%>rms/admin/payment/on_off.jsp";			
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
	

<body  style="background-color:transparent;">

<div class="passpop_inner" >	
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<form name="memberInput" action="<%=urlPage%>rms/admin/payment/on_off.jsp" method="post"  onSubmit="return goWrite(this)" >		
	<input type="hidden" name="yn" value="<%=yn%>">
	<input type="hidden" name="pgkind" value="<%=pgkind%>">
	<input type="hidden" name="seq" value="<%=seq%>">
	<input type="hidden" name="docontact" value="<%=docontact%>">
	<input type="hidden" name="page"   value="<%=pageNum%>">
	<input type="hidden" name="btn"   value="<%=btn%>">	
	<input type="hidden" name="yyVal"   value="<%=yyVal%>">	
	<input type="hidden" name="mmVal"   value="<%=mmVal%>">	
	<tr>
		<td width="12" style="background:url('<%=urlPage%>rms/image/admin/titlePop.gif') no-repeat;"></td>
		<td width="280" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">
			<img src="<%=urlPage%>rms/image/icon_ball.gif" >
			<%if(pgkind.equals("receive_yn_sinsei")){%>
				<span class="calendar7">請求書受領変更</span>
			<%}else if(pgkind.equals("receive_yn_ot")){%>
				<span class="calendar7">郵送変更</span>
			<%}else if(pgkind.equals("receive_yn_tokyo")){%>
				<span class="calendar7">東京(OT宇津木)/受領変更</span>			
			<%}else if(pgkind.equals("shori_yn")){%>
				<span class="calendar7">東京(OT宇津木)/処理変更</span>
			<%}%>				
		</td>	
		<td width="70">
			<a href="#"  onclick="formClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a>
		</td>
	</tr>
</table>
<div class="clear_margin"></div>
<table width="100%" border="0" cellspacing="5" cellpadding="5">	
	<tr>			
		<td width="100%"  align="center">
			<%if(pgkind.equals("receive_yn_sinsei")){%>
				<input type="radio" name="data_yn"  value="1"  onfocus="this.blur()" <%if(board.getReceive_yn_sinsei()==1){%>checked<%}%>>  未確認 &nbsp;
				<input type="radio" name="data_yn"  value="2"  onfocus="this.blur()" <%if(board.getReceive_yn_sinsei()==2){%>checked<%}%>>  確認完了 
			<%}else if(pgkind.equals("receive_yn_ot")){%>
				<input type="radio" name="data_yn"  value="1"  onfocus="this.blur()" <%if(board.getReceive_yn_ot()==1){%>checked<%}%>>  未郵送 &nbsp;
				<input type="radio" name="data_yn"  value="2"  onfocus="this.blur()" <%if(board.getReceive_yn_ot()==2){%>checked<%}%>>  郵送完了 
			<%}else if(pgkind.equals("receive_yn_tokyo")){%>
				<input type="radio" name="data_yn"  value="1"  onfocus="this.blur()" <%if(board.getReceive_yn_tokyo()==1){%>checked<%}%>>  未受領 &nbsp;
				<input type="radio" name="data_yn"  value="2"  onfocus="this.blur()" <%if(board.getReceive_yn_tokyo()==2){%>checked<%}%>>  紛失 &nbsp;
				<input type="radio" name="data_yn"  value="3"  onfocus="this.blur()" <%if(board.getReceive_yn_tokyo()==3){%>checked<%}%>>  受領完了 
			<%}else if(pgkind.equals("shori_yn")){%>
				<input type="radio" name="data_yn"  value="1"  onfocus="this.blur()" <%if(board.getShori_yn()==1){%>checked<%}%>>  未処理 &nbsp;
				<input type="radio" name="data_yn"  value="2"  onfocus="this.blur()" <%if(board.getShori_yn()==2){%>checked<%}%>>  処理完了
			<%}%>	
			
			
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

	
	
	
	
	
	
	
	