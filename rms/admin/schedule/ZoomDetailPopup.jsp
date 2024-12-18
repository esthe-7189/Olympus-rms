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

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String yVal=request.getParameter("yVal");
String mVal=request.getParameter("mVal");
String dVal=request.getParameter("dVal");
String pg=request.getParameter("pg");
String monthVal=request.getParameter("monthVal");
String yearVal=request.getParameter("yearVal");

String ymdVal=yVal+"-"+mVal+"-"+dVal;
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
MemberManager member=MemberManager.getInstance();
Member memTop=member.getMember(id);
List list=member.selectListSchedule(1,4);
List listFollow=member.selectListSchedule(1,6);
%>
<c:set var="list" value="<%=list%>"/>	
<c:set var="memTop" value="<%=memTop%>"/>	
<c:set var="listFollow" value="<%=listFollow%>"/>	
<html>
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
<style type="text/css">
	input.calendar { behavior:url(calendar.htc); }
</style>

<script type="text/javascript">
function goWrite() {	
var frm=document.memberInput;
var cntFel=0; var cnt=0;
    with (document.memberInput) {
        if (chkSpace(title.value)) {
   	    	alert("タイトルを書いてください.");
              title.focus();    return ;                   
         }   
          if (chkSpace(basho_detail.value)) {
   	    		basho_detail.value="なし";              
         }           
    }
    var len=document.getElementsByName("fellow").length;    
    if (frm.fellow_yn[0].checked ) {   
    		for(var i=0; i<len;i++){
    			if(document.getElementsByName("fellow")[i].checked==true) cntFel++;
    		}    
    	if(cntFel==0){
    		alert("複数人指定のいいえを押して下さい");
		frm.fellow_yn[0].focus();
		return;
    	}
  }
    
    var len=document.getElementsByName("signup").length;    
    if (frm.sign_yn[0].checked ) {   
    		for(var i=0; i<len;i++){
    			if(document.getElementsByName("signup")[i].checked==true) cnt++;
    		}    
    	if(cnt==0){
    		alert("決済者指定のいいえを押して下さい");
		frm.sign_yn[0].focus();
		return;
    	}
  }
     		
   if ( confirm("登録しましょうか?") != 1 ) {return ;}
	frm.action = "<%=urlPage%>rms/admin/schedule/insert.jsp";	
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
function resize(width, height){	
	window.resizeTo(width, height);
}

function calenderClose(){
	 if(parent.document.getElementById("layerpop").style.display == 'block'){
		parent.document.getElementById("layerpop").style.display="none";
	 } 
}
</script>
<script type="text/javascript">
	onload = function() {
	var frames = document.getElementsByTagName('iframe');   // iframe태그를 하고 있는 모든 객체를 찾는다.
	for(var i = 0; i < frames.length; i++)  {
		frames[i].setAttribute("allowTransparency","true");  // allowTransparency 속성을 true로 만든다.
	}
}
</script>
	</head>

	
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#during_begin").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#during_end").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
</script>
<body  style="background-color:transparent;">
<center>
<div class="layerpop_inner">
<table width="573" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td align="center" style="padding: 0 0 5 0;">
		<!-- 상단풀정보 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="90" style="background:url('<%=urlPage%>rms/image/admin/titlePop_calendar_new.gif') no-repeat;"></td>
					<td width="430" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">[登録]..<%=yearVal%>年<%=monthVal%>月</td>
					<td width="70"><a href="javascript:calenderClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
		<!-- //상단 풀정보 -->	
		<!-- //상세내역 begin-->	
<table width="573" border="0" cellpadding="0" cellspacing="0" class=c bgcolor="#ffffff">
<form name="memberInput" action="<%=urlPage%>rms/admin/schedule/insert.jsp" method="post"  onSubmit="return goWrite(this)" >		
	<input type="hidden" name="mseq" value="<%=memTop.getMseq()%>">
	<input type="hidden" name="sign_ok" value="1">	<!-- /1==ok, 2==no-->	
	<input type="hidden" name="kintai_seq" value="0">	<!-- 출퇴근장에서 사용-->	
	<input type="hidden" name="pg" value="<%=pg%>">
	<input type="hidden" name="monthVal" value="<%=monthVal%>">
	<input type="hidden" name="yearVal" value="<%=yearVal%>">
<tr>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >期間指定</td>
	<td   style="padding: 3 3 3 3" width="80%">
	<input type="text" size="13%" name='during_begin' id="during_begin" value="<%=ymdVal%>" style="text-align:center">
	<!--<input type="text" size="13%" name='during_begin' class=calendar value="<%=ymdVal%>" style="text-align:center">-->
		<select name="ichinichi_begin" >			            							
			<option value="一日中">一日中</option>
			<option value="午前">午前</option>
			<option value="午後">午後</option>												
		  </select>	
		 ~ <input type="text" size="13%" name='during_end' id="during_end" value="<%=ymdVal%>" style="text-align:center">		 			
		 <!--<input type="text" size="13%" name='during_end' class=calendar value="<%=ymdVal%>" style="text-align:center">-->
		<select name="ichinichi_end" >			            							
			<option value="一日中">一日中</option>
			<option value="午前">午前</option>
			<option value="午後">午後</option>												
		  </select>
	</td>
</tr>		
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >場所</td>
	<td   style="padding: 3 3 3 3" width="80%">	
		<select name="basho" >			            							
			<option value="国内">国内</option>
			<option value="海外">海外</option>													
		  </select>	
		 <input type="text" size="13%" name='basho_detail' class="input02" value=""  maxlength="50" style="width:295px">
		
	</td>
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
	<td   style="padding: 3 3 3 3"  >		
		<input type="text" name="title" value="" size="40" maxlength="50" class="input02" style="width:350px">	 
	</td> 
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >複数人指定:</td>
	<td   style="padding: 3 3 3 3" >
		<input type="radio" name="fellow_yn" value="1" onClick="fellow01()" onfocus="this.blur()" ><font  color="#FF6600">はい</font>
		<input type="radio" name="fellow_yn" value="2" onClick="fellow02()" onfocus="this.blur()"  checked><font  color="#FF6600">いいえ</font>		 
				<div id="fellow" style="display:none;overflow:hidden ;width:420;border:1px solid #99CC00;" >	
<!-- //복수인원 직원리스트-->		

<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${mem.mseq!=memTop.mseq}">		
			<input type="checkbox" name="fellow" value="${mem.mseq}">${mem.nm}
		</c:if>
	</c:forEach>
</c:if>
											
				</div>		 
	</td>     
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >参考/決済者指定:</td>
	<td   style="padding: 3 3 3 3" >
		<input type="radio" name="sign_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">はい</font>
		<input type="radio" name="sign_yn" value="2" onClick="show02()" onfocus="this.blur()"  checked><font  color="#FF6600">いいえ</font>		 
				<div id="show" style="display:none;overflow:hidden ;width:420;border:1px solid #99CC00;" >	
<!-- //직원리스트-->		

<c:if test="${! empty  list}">
	<c:forEach var="mem" items="${list}"  varStatus="idx"  >
		<c:if test="${mem.mseq!=memTop.mseq}">				
			<input type="checkbox" name="signup" value="${mem.mseq}">${mem.nm}
		</c:if>
	</c:forEach>
</c:if>
											
				</div>		 
	</td>     
</tr>					
</table><p>
<table width="90%" border="0" cellpadding="2" cellspacing="0">
		<tr>
		<td align=center>		
			<a href="javascript:goWrite();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>
			<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif" align="absmiddle"></a>	  		
		</td>
	</tr>
</table>
	<!-- //상세내역 end-->	
		</td>
	</tr>
</table>
</form>
</div>
</center>
</body>
</html>
<script type="text/javascript">
function show01(){document.getElementById("show").style.display=''; }
function show02(){document.getElementById("show").style.display='none'; }
function fellow01(){document.getElementById("fellow").style.display=''; }
function fellow02(){document.getElementById("fellow").style.display='none'; }					
function cateReset() {  
	document.memberInput.reset();	 
	var oEditor=FCKeditorAPI.GetInstance('content');
	var div=document.createElement("DIV");
		div.innerHTML=oEditor.GetXHTML();
	 	oEditor.SetHTML(" "); 	 	
}

</script> 
	
	
	
	
	
	
	
	