<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.kaigi.DataBean" %>
<%@ page import = "mira.kaigi.DataMgr" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>


<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String pg=request.getParameter("pg");
String seq=request.getParameter("seq");
String monthVal=request.getParameter("monthVal");
String yearVal=request.getParameter("yearVal");
int hanko=0;

if(kind!=null && ! kind.equals("kaigi")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
MemberManager member=MemberManager.getInstance();
Member memTop=member.getMember(id);
int owner=memTop.getMseq();
String nameown=memTop.getNm();
List list=member.selectListSchedule(1,4);
List listFollow=member.selectListSchedule(1,6);

DataMgr mgr=DataMgr.getInstance();
DataBean schedule=mgr.getDb(Integer.parseInt(seq));
Member memSign;
%>
<c:set var="list" value="<%=list%>"/>
<c:set var="listFollow" value="<%=listFollow%>"/>	
<html>
<head>
<title>OLYMPUS RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<%=urlPage%>rms/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/mainAdmin.css" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>fckeditor/_sample/sample.css" type="text/css">
<script  src="<%=urlPage%>fckeditor/fckeditor.js" type="text/javascript"></script>
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="<%=urlPage%>rms/js/QuickView.js"></script><!-- 퀵뷰 JS//-->
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
<style type="text/css">
	input.calendar { behavior:url(calendar.htc); }
</style>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>

<script type="text/javascript">
		<!--
		var mHeight			= 53;
		var gHeight1		= 0;
		var scrollbox;

		//scrollbox start
		function tInit()
		{
			if (scrollbox != null)
			{
				scrollbox	= null;
			}
		 
			scrollbox		= {};
			scrollbox.content1	= new Scrollbox();
			scrollbox.content1.touch("content-scrbox1", { overflowY : "scroll" });
		}

		function FuncGoDetail(code){
			parent.document.getElementById('qPop').style.display = 'none';
			parent.document.location.href = 'ZoomDetailPopup.jsp?code='+code;
		}


		function FuncClose(){
			parent.document.getElementById('qPop').style.display = 'none';
		}
		function FuncCloseV2(){
			parent.document.getElementById('lyQuick').style.display = 'none';
		}


		window.onload = function()
		{
			tInit();
			gHeight1 = document.getElementById("viewTable1").offsetHeight;
			document.getElementById("content-scrbox1").style.height = mHeight;
		}
		//-->
		</script>
<script type="text/javascript">
function goWrite() {
var frm=document.memberInput;
var cntFel=0; var cnt=0;
    with (document.memberInput) {
        if (chkSpace(title.value)) {
   	    	alert("タイトルを書いてください.");
              title.focus();    return ;                   
         }         
    }
 		
     		
     		
   if ( confirm("修正しますか?") != 1 ) {return ;}
	frm.action = "<%=urlPage%>kaigi/admin/schedule/update.jsp";	
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
	</head>
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
					<td width="430" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">[修正]..<%=yearVal%>年<%=monthVal%>月</td>
					<td width="70"><a href="javascript:calenderClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="close" ></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
		<!-- //상단 풀정보 -->	
		<!-- //상세내역 begin-->	
<table width="573" border="0" cellpadding="0" cellspacing="0" class=c bgcolor="#ffffff">
<form name="memberInput" action="<%=urlPage%>kaigi/admin/schedule/update.jsp" method="post"  onSubmit="return goWrite(this)" >		
	<input type="hidden" name="mseq" value="<%=memTop.getMseq()%>">	
	<input type="hidden" name="kintai_seq" value="0">	<!-- 출퇴근장에서 사용-->	
	<input type="hidden" name="pg" value="<%=pg%>">
	<input type="hidden" name="seq" value="<%=schedule.getSeq()%>">
	<input type="hidden" name="monthVal" value="<%=monthVal%>">
	<input type="hidden" name="yearVal" value="<%=yearVal%>">
<tr>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="25%"><img src="<%=urlPage%>rms/image/icon_s.gif" >期間指定</td>
	<td   style="padding: 3 3 3 3" width="75%">
	<!--<input type="text" size="13%" name='during_begin' class=calendar value="<%=schedule.getDuring_begin()%>" style="text-align:center">-->
	<input type="text" size="10%" name='during_begin' id="during_begin" value="<%=schedule.getDuring_begin()%>" style="text-align:center">
		<<select name="jikan_begin" ><!--ichinichi_begin-->
	<%for(int i=1;i<=24;i++){
		if(i <10){%>
			<option value="<%=i%>">0<%=i%></option>
		<%}else{%>		            							
			<option value="<%=i%>"><%=i%></option>
	<%}}%>													
		  </select> :
		  <select name="bun_begin" >				            							
			<option value="00">00</option>
			<option value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>	
			<option value="50">50</option>														
		  </select>		
		 ~ <input type="text" size="10%" name='during_end' id="during_end" value="<%=schedule.getDuring_end()%>" style="text-align:center">	
		 	  <!--<input type="text" size="13%" name='during_end' class=calendar value="<%=schedule.getDuring_end()%>" style="text-align:center">-->
		<select name="jikan_end" ><!--ichinichi_end-->
	<%for(int i=1;i<=24;i++){
		if(i <10){%>
			<option value="<%=i%>">0<%=i%></option>
		<%}else{%>		            							
			<option value="<%=i%>"><%=i%></option>
	<%}}%>													
		  </select> :
		  <select name="bun_end" >				            							
			<option value="00">00</option>
			<option value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>	
			<option value="50">50</option>														
		  </select>	
	</td>
</tr>		
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >場所</td>
	<td   style="padding: 3 3 3 3" >	
		<select name="basho" >			            							
			<option value="国内"  <%if(schedule.getBasho().equals("国内")){%> selected <%}%>>国内</option>
			<option value="海外"  <%if(schedule.getBasho().equals("海外")){%> selected <%}%>>海外</option>													
		  </select>	
		 <input type="text" size="13%" name='basho_detail' class="input02" value="<%=schedule.getBasho_detail()%>"  maxlength="50" style="width:295px">
		
	</td>
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
	<td   style="padding: 3 3 3 3"  >		
		<input type="text" name="title" value="<%=schedule.getTitle()%>" size="40" maxlength="50" class="input02" style="width:350px">	 
	</td> 
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<!-- //******************************同行者 end***************************************************-->	
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >既存の同行者:</td>
	<td   style="padding: 3 3 3 3" >
<c:if test="${! empty list}">	
<%	List list2=mgr.listFellow_seq(schedule.getSeq()); %>
<%	int i=1;
	Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
		Member mem=(Member)listiter.next();				
%>	
<c:set var="list2" value="<%= list2 %>" />		
<c:if test="${! empty list2}">		
	<%	
	int ii=1;
	Iterator listiter2=list2.iterator();					
		while (listiter2.hasNext()){
		DataBean data2=(DataBean)listiter2.next();		
		memSign=member.getDbMseq(data2.getMseq());	
		if(memSign!=null){			
	%>
		<%if(memSign.getMseq()==mem.getMseq()){%>
		
			<input type="hidden" name="fellowModi" value="aru">	
			<%=mem.getNm()%> 
		<%}%>
	<%}ii++;}%>  
</c:if>	
<%i++;}%>		
</c:if>
<c:if test="${empty list}">				
		--
</c:if>		
	</td>     
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >同行者修正:</td>
	<td   style="padding: 3 3 3 3" >
		<input type="radio" name="fellow_yn" value="1" onClick="fellow01()" onfocus="this.blur()" ><font  color="#FF6600">修正する</font>
		<input type="radio" name="fellow_yn" value="2" onClick="fellow02()" onfocus="this.blur()"  checked><font  color="#FF6600">しない</font>		 
				<div id="fellow" style="display:none;overflow:hidden ;width:420;border:1px solid #99CC00;" >	
<c:if test="${! empty listFollow}">	
<%	List list2=mgr.listFellow_seq(schedule.getSeq()); %>
<%	int i=1;
	Iterator listiter=listFollow.iterator();					
		while (listiter.hasNext()){
		Member mem=(Member)listiter.next();
		if(owner!=mem.getMseq()){				
%>	
<c:set var="list2" value="<%= list2 %>" />		
	<input type="checkbox" name="fellow" value="<%=mem.getMseq()%>" 
<c:if test="${! empty list2}">		
	<%	
	int ii=1;
	Iterator listiter2=list2.iterator();					
		while (listiter2.hasNext()){
		DataBean data2=(DataBean)listiter2.next();		
		memSign=member.getDbMseq(data2.getMseq());	
		if(memSign!=null){
						
	%>
		<%if(memSign.getMseq()==mem.getMseq()){%>checked <%}%>
	<%}else{%>--<%}%>
	<%ii++;}%>
</c:if>
	><%=mem.getNm()%>		
<%i++;}}%>
</c:if>
<c:if test="${empty listFollow}">
		--
</c:if>		
			</div> 
	</td>     
</tr>
<!-- //******************************決済者 end***************************************************-->					
		
		<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >既存の決済者:</td>
	<td   style="padding: 3 3 3 3" >
<c:if test="${! empty list}">	
<%	List list2=mgr.listSchedule_seq(schedule.getSeq()); %>
<%	int i=1;
	Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
		Member mem=(Member)listiter.next();						
%>	
<c:set var="list2" value="<%= list2 %>" />		
<c:if test="${! empty list2}">		
	<%	
	int ii=1;
	Iterator listiter2=list2.iterator();					
		while (listiter2.hasNext()){
		DataBean data2=(DataBean)listiter2.next();		
		memSign=member.getDbMseq(data2.getMseq());	
		if(memSign!=null){			
			hanko=data2.getSign_ok();
	%>
		<%if(memSign.getMseq()==mem.getMseq()){%>
			<input type="hidden" name="kesai" value="aru">	
			<%=mem.getNm()%> 
		<%}%>
	<%}ii++;}%>  
</c:if>	
<%i++;}%>		
</c:if>
<c:if test="${empty list}">				
	
		--
</c:if>		
	</td>     
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >参考及び決済者修正:</td>			
	<td   style="padding: 3 3 3 3" >
<%if(hanko==1){ %>		
		<input type="radio" name="sign_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">修正する</font>
		<input type="radio" name="sign_yn" value="2" onClick="show02()" onfocus="this.blur()"  checked><font  color="#FF6600">しない</font>		 
			<div id="show" style="display:none;overflow:hidden ;width:420;border:1px solid #99CC00;" >	
				<c:if test="${! empty list}">	
				<%	List list2=mgr.listSchedule_seq(schedule.getSeq()); %>
				<%	int i=1;
					Iterator listiter=list.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
						if(owner!=mem.getMseq()){					
				%>	
				<c:set var="list2" value="<%= list2 %>" />		
					<input type="checkbox" name="signup" value="<%=mem.getMseq()%>" 
				<c:if test="${! empty list2}">		
					<%	
					int ii=1;
					Iterator listiter2=list2.iterator();					
						while (listiter2.hasNext()){
						DataBean data2=(DataBean)listiter2.next();		
						memSign=member.getDbMseq(data2.getMseq());	
						if(memSign!=null){			
					%>
					<%if(memSign.getMseq()==mem.getMseq()){%>checked <%}%>
					<%}else{%>--<%}%>
					<%ii++;}%>
				</c:if>
					><%=mem.getNm()%> 		
				<%i++;}}%>
				</c:if>
				<c:if test="${empty list}">
						--
				</c:if>		
			</div> 
	
	<%}else if(hanko==2){ %>	
		<font color="#007AC3">決裁済</font>
		<input type="hidden" name="sign_yn" value="2">		
	<%}else if(hanko==0){ %>	
			
		<input type="radio" name="sign_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">修正する</font>
		<input type="radio" name="sign_yn" value="2" onClick="show02()" onfocus="this.blur()"  checked><font  color="#FF6600">しない</font>		 
			<div id="show" style="display:none;overflow:hidden ;width:420;border:1px solid #99CC00;" >	
				<c:if test="${! empty list}">	
				<%	List list2=mgr.listSchedule_seq(schedule.getSeq()); %>
				<%	int i=1;
					Iterator listiter=list.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
						if(owner!=mem.getMseq()){					
				%>	
				<c:set var="list2" value="<%= list2 %>" />		
					<input type="checkbox" name="signup" value="<%=mem.getMseq()%>" ><%=mem.getNm()%>	
				
				<%}
				i++;}%>
				</c:if>					
				<c:if test="${empty list}">
						--
				</c:if>		
			</div> 			
	<%}%>
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
function show01(){	document.getElementById("show").style.display=''; }
function show02(){	document.getElementById("show").style.display='none'; }
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
