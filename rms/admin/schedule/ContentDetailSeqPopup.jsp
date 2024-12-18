<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>

<%	
String urlPage=request.getContextPath()+"/";
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String ymdVal=request.getParameter("ymdList");
String seq=request.getParameter("seq");
String pg=request.getParameter("pg");
String monthVal=request.getParameter("monthVal");
String yearVal=request.getParameter("yearVal");

if(kind!=null && ! kind.equals("bun")){
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
DataBean schedule=mgr.getDb(Integer.parseInt(seq));
Member memSign; Member memFellow;
%>
<c:set var="schedule" value="<%=schedule%>"/>	
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
		frames[i].setAttribute("allowTransparency","true");  // allowTransparency 속성을 true로 만든다.  [詳しい内容]..
	}
}
</script>
	</head>
<body  style="background-color:transparent;">
<center>
<div class="layerpop_inner">
<table width="573" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" style="padding: 0px 0px 0px 0px;">
	<tr>
		<td align="center" style="padding: 0px 0px 0px 0px;">
		<!-- 상단풀정보 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="90" style="background:url('<%=urlPage%>rms/image/admin/titlePop_calendar_new.gif') no-repeat;"></td>
					<td width="100" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">
						<c:if test="${! empty  schedule}">${schedule.nm}様</c:if>						
					</td>
					<td width="330" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" align="right" >
<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 一件 " onClick="location.href='<%=urlPage%>rms/admin/schedule/ContentDetailSeqPopup.jsp?ymdList=<%=ymdVal%>&seq=<%=seq%>&pg=<%=pg%>&monthVal=<%=monthVal%>&yearVal=<%=yearVal%>'">
<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="当日全体リスト" onClick="location.href='<%=urlPage%>rms/admin/schedule/ContentDetailPopup.jsp?ymdList=<%=ymdVal%>&seq=<%=seq%>&pg=<%=pg%>&monthVal=<%=monthVal%>&yearVal=<%=yearVal%>'">				
					</td>
					<td width="70"><a href="javascript:calenderClose();" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Cose" ></a></td>
				</tr>
			</table>　
		</td>
	</tr><tr><td><%=ymdVal%></td></tr>
</table>
		<!-- //상단 풀정보 -->	
		<!-- //상세내역 begin-->	
<table width="573" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
<form name="memberInput" action="<%=urlPage%>rms/admin/schedule/insert.jsp" method="post"  onSubmit="return goWrite(this)" >		
	<input type="hidden" name="mseq" value="">
	<input type="hidden" name="sign_ok" value="1">	<!-- /1==ok, 2==no-->	
	<input type="hidden" name="kintai_seq" value="0">	<!-- 출퇴근장에서 사용-->	
	<input type="hidden" name="pg" value="<%=pg%>">
	
<tr height=30 bgcolor=#F1F1F1 align=center>		
	<td>登録日</td>
	<td>氏名</td>
	<td>場所</td>
	<td>最初日</td>
	<td>最終日</td>
	<td>タイトル</td>
	<td>同行者</td>
	<td>決裁</td>
	<td>修正</td>			
	<td>削除</td>
</tr>
<c:if test="${empty schedule}">
	<tr><td colspan="10">No Data</td></tr>
</c:if>
		
<c:if test="${! empty  schedule}">	
			<tr>
				<td align="center"><fmt:formatDate value="${schedule.register}" pattern="yyyy-MM-dd" /></td>
				<td>${schedule.nm}</td>
				<td>
	<%if(!schedule.getIchinichi_begin().equals("no data") && schedule.getView_seq()==0){%><font color="#007AC3">(<%=schedule.getBasho()%>)</font><%=schedule.getBasho_detail()%><%}%>.
	<%if(schedule.getView_seq()==1){%><img src="<%=urlPage%>rms/image/admin/icon_taikin_schdule.gif" align="absmiddle"><%}%>
	<%if(schedule.getView_seq()==2){%><img src="<%=urlPage%>rms/image/admin/icon_jangyo_01.gif" align="absmiddle"><%}%>
	<%if(schedule.getView_seq()==3 || schedule.getView_seq()==4 || schedule.getView_seq()==5){%><img src="<%=urlPage%>rms/image/admin/icon_hokoku.gif" align="absmiddle"><font color="#007AC3">(<%=schedule.getBasho()%>)</font><%}%>
				</td>
				<td><%=schedule.getDuring_begin()%><%if(!schedule.getIchinichi_begin().equals("no data")){%><br>(<%=schedule.getIchinichi_begin()%>)<%}%></td>
				<td><%=schedule.getDuring_end()%><%if(!schedule.getIchinichi_begin().equals("no data")){%><br>(<%=schedule.getIchinichi_end()%>)<%}%></td>				
				<td>${schedule.title}</td>
				<td>
<%
List listFellow=mgr.listFellow_seq(schedule.getSeq());
%>
<c:set var="listFellow" value="<%= listFellow %>" />	
<c:if test="${! empty listFellow}">	
				<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;"><select name="sign_ok_mseq" class="select_type3" >
<%	
	int ii=1;
	Iterator listiter2=listFellow.iterator();					
		while (listiter2.hasNext()){
		DataBean data3=(DataBean)listiter2.next();		
		memFellow=manager.getDbMseq(data3.getMseq());	
		if(memFellow!=null){			
	%>
		<option value=""><%=memFellow.getNm()%></option>
	<%}ii++;}%>
				</select></div>		
</c:if>
<c:if test="${empty listFellow}">
		--
</c:if>		
				</td>	
				<td>
<%
List list2=mgr.listSchedule_seq(schedule.getSeq());
%>
<c:set var="list2" value="<%= list2 %>" />	
<c:if test="${! empty list2}">	
				
<%	
	int ii=1;
	Iterator listiter2=list2.iterator();					
		while (listiter2.hasNext()){
		DataBean data2=(DataBean)listiter2.next();		
		memSign=manager.getDbMseq(data2.getMseq());	
		if(memSign!=null){			
	%>
	
			<%if(data2.getSign_ok()==2 ){%>
			<%if(!memSign.getMimg().equals("no")){%>
				<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
			<%}else{%><%=memSign.getNm()%><br><font color="#007AC3">決裁済</font><%}%>
			<%}%>	
				
					
			<%if(data2.getSign_ok()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle"><%}%> 
				
				
			<%if(data2.getSign_ok()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"><%}%> 		
		
	<%}ii++;}%>
					
</c:if>
<c:if test="${empty list2}">
		--
</c:if>		
				</td>
	<%if(schedule.getMseq()==dbMseq && schedule.getKintai_seq()==0){%>	
				<td align="center">	
					<%if(schedule.getView_seq()==0 ){%>
						<a href="javascript:goModify('<%=schedule.getSeq()%>','<%=pg%>');" onfocus="this.blur()">					
						<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif" alt="Modify" ></a>
					<%}%>
					<%if(schedule.getView_seq()!=0){%>-<%}%>		
				</td>
				<td align="center">
					<%if(schedule.getView_seq()==0){%>
						<a href="javascript:goDelete('<%=schedule.getSeq()%>','<%=pg%>');"  onfocus="this.blur()">
						<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" alt="Cancel">
					</a>
					<%}%>
					<%if(schedule.getView_seq()!=0){%>-<%}%>					
					
				</td>
	<%}else{%>
				<td align="center">--</td>
				<td align="center">--</td>
	<%}%>
			</tr>	
</c:if>
	<!-- //상세내역 end-->	
</table>
</form>
<p>
</div>
</center>
<p><p>
</body>
</html>
<form name="move" method="post">
    <input type="hidden" name="seq" value="">        
    <input type="hidden" name="pg" value="">
    <input type="hidden" name="monthVal" value="">
    <input type="hidden" name="yearVal" value="">        
 </form>
<script language="javascript">
function goDelete(seq,pg) {
	   if ( confirm("データを削除しましょうか?") != 1 ) {return ;}
	document.move.action = "<%=urlPage%>rms/admin/schedule/delete.jsp";
	document.move.seq.value=seq;
	document.move.pg.value=pg;
	document.move.monthVal.value=<%=monthVal%>;
	document.move.yearVal.value=<%=yearVal%>;
    document.move.submit();
}
function goModify(seq,pg) {	
    document.move.action = "<%=urlPage%>rms/admin/schedule/ModifyPopup.jsp";
	document.move.seq.value=seq;	
	document.move.pg.value=pg;
	document.move.monthVal.value=<%=monthVal%>;
	document.move.yearVal.value=<%=yearVal%>;
    document.move.submit();
}	

</script>	

