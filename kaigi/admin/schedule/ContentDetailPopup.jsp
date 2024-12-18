<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.kaigi.DataBean" %>
<%@ page import = "mira.kaigi.DataMgr" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String urlPage=request.getContextPath()+"/";
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String ymdVal=request.getParameter("ymdList");
String seq=request.getParameter("seq");
String pg=request.getParameter("pg");
String monthVal=request.getParameter("monthVal");
String yearVal=request.getParameter("yearVal");
if(kind!=null && ! kind.equals("kaigi")){
%>				
<script language="JavaScript">
	alert("Loginして下さい");
  	parent.document.location.href = "<%=urlPage%>;	
	parent.document.getElementById('qPop').style.display = 'none';
</script>
<%
	}

int dbMseq=0; String pass="";
MemberManager manager = MemberManager.getInstance();	
Member member=manager.getMember(id);
	if(member!=null){		 
		 pass=member.getPassword();
		 dbMseq=member.getMseq();
	}
DataMgr mgr=DataMgr.getInstance();
List list=mgr.listScheduleBeginEndAll(ymdVal);
Member memSign; Member memFellow;
%>
<c:set var="list" value="<%=list%>"/>	
<html>
<head>
<title>OLYMPUS RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<%=urlPage%>rms/css/style.css" type="text/css">
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
    with (document.memberInput) {
        if (chkSpace(title.value)) {
   	    	alert("タイトルを書いてください.");
              title.focus();    return ;                   
         }         
    }
     		
   if ( confirm("登録しましょうか?") != 1 ) {return ;}
	frm.action = "<%=urlPage%>kaigi/admin/schedule/insert.jsp";	
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
		frames[i].setAttribute("allowTransparency","true");  // allowTransparency 속성을 true로 만든다.  [詳しい内容]..
	}
}
</script>
	</head>
<body  style="background-color:transparent;">
<center>
<div class="layerpop_inner">
<table width="573" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td align="center" style="padding: 0px 0px 0px 0px;">
		<!-- 상단풀정보 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="90" style="background:url('<%=urlPage%>rms/image/admin/titlePop_kaigi_new.jpg') no-repeat;"></td>
					<td width="120" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">
						当日全体リスト					
					</td>
					<td width="310" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" align="right" >
<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 一件 " onClick="location.href='<%=urlPage%>kaigi/admin/schedule/ContentDetailSeqPopup.jsp?ymdList=<%=ymdVal%>&seq=<%=seq%>&pg=<%=pg%>&monthVal=<%=monthVal%>&yearVal=<%=yearVal%>'">
<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="当日全体リスト" onClick="location.href='<%=urlPage%>kaigi/admin/schedule/ContentDetailPopup.jsp?ymdList=<%=ymdVal%>&seq=<%=seq%>&pg=<%=pg%>&monthVal=<%=monthVal%>&yearVal=<%=yearVal%>'">				
					</td>
					<td width="70"><a href="javascript:calenderClose();" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a></td>
				</tr>				
			</table>　
		</td>
	</tr><tr><td><%=ymdVal%></td></tr>
</table>
		<!-- //상단 풀정보 -->	
		<!-- //상세내역 begin-->	
<table  border="0" width="573" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#E6E6E6">
<form name="memberInput" action="<%=urlPage%>kaigi/admin/schedule/insert.jsp" method="post"  onSubmit="return goWrite(this)" >		
	<input type="hidden" name="mseq" value="">	
	<input type="hidden" name="pg" value="<%=pg%>">
	
<tr height=30 align=center>		
	<td bgcolor="#F5F5F5">登録日</td>
	<td bgcolor="#F5F5F5">予約者</td>
	<td bgcolor="#F5F5F5">場所</td>
	<td bgcolor="#F5F5F5">使用期間</td>
	<td bgcolor="#F5F5F5">タイトル</td>
	<td bgcolor="#F5F5F5">出席者(1)</td>
	<td bgcolor="#F5F5F5">出席者(2)</td>	
</tr>
<c:if test="${empty list}">
	<tr><td colspan="8" bgcolor="#FFFFFF">No Data</td></tr>
</c:if>
<c:if test="${! empty  list}">
<%
	int i=1;
	Iterator listiter=list.iterator();					
	while (listiter.hasNext()){
		DataBean data=(DataBean)listiter.next();
		String aadd=dateFormat.format(data.getRegister());
		String bashoStr="";		
		int basho=data.getBasho();
					if(basho==1){
						bashoStr="会議室1";
					}else if(basho==2){
						bashoStr="会議室2";
					}else if(basho==3){
						bashoStr="応接室1";
					}else if(basho==4){
						bashoStr="応接室2";
					}							
%>	
			<tr>
				<td bgcolor="#FFFFFF"><%=aadd%></td>
				<td bgcolor="#FFFFFF"><%=data.getNm()%></td>
				<td bgcolor="#FFFFFF"><font color="#007AC3"><%=bashoStr%></font></td>
				<td bgcolor="#FFFFFF"><%=data.getDuring_begin()%>(<%=data.getJikan_begin()%>:<%=data.getBun_begin()%>)~<%=data.getDuring_end()%>(<%=data.getJikan_end()%>:<%=data.getBun_end()%>)
				<td bgcolor="#FFFFFF"><%=data.getTitle()%></td>
				<td bgcolor="#FFFFFF">
<%
List listFellow=mgr.listFellow_seq(data.getSeq());
%>
<c:set var="listFellow" value="<%= listFellow %>" />	
<c:if test="${! empty listFellow}">	
				<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;"><select name="sign_ok_mseq" class="select_type3" >
<%	
	int ii=1;
	Iterator listiter2=listFellow.iterator();					
		while (listiter2.hasNext()){
		DataBean data3=(DataBean)listiter2.next();		
		int mseqq=data3.getMseq();		
		if(mseqq!=0){		
	%>
		<option value=""><%=data3.getNm_sanseki()%></option>
	<%}ii++;}%>
				</select></div>		
</c:if>
<c:if test="${empty listFellow}">
		--
</c:if>			
				</td>	
				<td bgcolor="#FFFFFF">
<%
List listFellow2=mgr.listFellow_seq(data.getSeq());
%>
<c:set var="listFellow2" value="<%= listFellow2%>" />	
<c:if test="${! empty listFellow2}">						
<%	
	int ii2=1;
	Iterator listiter3=listFellow2.iterator();					
		while (listiter3.hasNext()){
		DataBean data4=(DataBean)listiter3.next();
		int mseqq4=data4.getMseq();		
		if(mseqq4==0){			
	%>
		<%=data4.getNm_sanseki()%>
	<%}ii2++;}%>					
</c:if>
<c:if test="${empty listFellow2}">
		--
</c:if>		
				</td>							
			</tr>
<%i++;}%>	
</c:if>
</table>
	<!-- //상세내역 end-->	
		</td>
	</tr>
</table>
</form>
	<p>
	</div>
</center>
</body>
</html>
