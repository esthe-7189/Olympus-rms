<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>

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
	onload = function() {
	var frames = document.getElementsByTagName('iframe');   // iframe태그를 하고 있는 모든 객체를 찾는다.
	for(var i = 0; i < frames.length; i++)  {
		frames[i].setAttribute("allowTransparency","true");  // allowTransparency 속성을 true로 만든다.
	}	
}
//참석자수 지정
 function NewRow(){
	var tBody = tbl.getElementsByTagName("tbody")[0];
	var row = MakeNewRow();
		tBody.appendChild(row);		
}
function InsertUpper(){
	InsertRow (event.srcElement, true);		
}
function InsertLower(){
	InsertRow(event.srcElement, false);	
}
function InsertRow(obj, ToUpper){
	var TargetRow;
	TargetRow = obj.parentNode;
	while(TargetRow != null){
		if( TargetRow.nodeName == "TR" ){	break;}
		TargetRow = TargetRow.parentNode;
		if(TargetRow == document){
			TargetRow = null;
			break;
		}
	}
	if(TargetRow == null)	return;
	var newRow = MakeNewRow();
	var tBody = tbl.getElementsByTagName("tbody")[0];

	if (ToUpper == true){
		tBody.insertBefore(newRow, TargetRow);
	}else{
		TargetRow = TargetRow.nextSibling;
		if(TargetRow != null){
			tBody.insertBefore(newRow, TargetRow);
		}else{
			tBody.appendChild(newRow);
		}
	}		
}

function MakeNewRow(){ 
var newRow = document.createElement("tr");
var newTd = document.createElement("td");
newTd.setAttribute("align","center");
var newInput = document.createElement("input");
newTd.appendChild(newInput);
newTd.innerHTML="<input type=checkbox>";
newRow.appendChild(newTd);

newTd = document.createElement("td");
newTd.setAttribute("align","left");
var newFile = document.createElement("input");
newTd.appendChild(newFile);
newTd.innerHTML="<input type=text name=sansekisha2[]  id=sansekisha2[] size=12 maxlength=50 class=input02 style=width:100px>";
newRow.appendChild(newTd);
return newRow; 
}

function deleteCheckedRow(){	
	var inputList = document.getElementsByTagName("input");
	var tBody = tbl.getElementsByTagName("tbody")[0];
	var checkItem;
	for(var i=inputList.length-1; i >= 0; i--){
		checkItem = inputList.item(i);
		if( checkItem.checked == true){
			var nodeParent = checkItem.parentNode.parentNode;
			if(nodeParent.nodeName == "TR"){
				tBody.removeChild(nodeParent);								
			}
			
		}
	}
	
}
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
    var len=document.getElementsByName("sansekisha1").length;        
    if (frm.fellow_yn[0].checked ) {   
    		for(var i=0; i<len;i++){
    			if(document.getElementsByName("sansekisha1")[i].checked==true) cntFel++;       		 					
    		}    
    	if(cntFel==0){
    		alert("出席者を選択しますか？　いいえを押して下さい");
		frm.fellow_yn[0].focus();
		return;
    	}
  }
   /*
    var len=document.getElementsByName("sansekisha2[]").length;    
    var nn=document.getElementsByName("sansekisha2[]");
    alert(len);
    */    
    var nn=document.getElementsByName("sansekisha2");
    if (frm.fellow2_yn[0].checked ) {       	
    			if (nn.value=="") {
    				alert("出席者を直接に書きますか？　いいえを押して下さい");
				frm.fellow2_yn[0].focus();
				return;				
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
					<td width="90" style="background:url('<%=urlPage%>rms/image/admin/titlePop_kaigi_new.jpg') no-repeat;"></td>
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
<form name="memberInput" action="<%=urlPage%>kaigi/admin/schedule/insert.jsp" method="post"  onSubmit="return goWrite(this)" >		
	<input type="hidden" name="mseq" value="<%=memTop.getMseq()%>">	
	<input type="hidden" name="pg" value="<%=pg%>">
	<input type="hidden" name="monthVal" value="<%=monthVal%>">
	<input type="hidden" name="yearVal" value="<%=yearVal%>">
	<input type="hidden" name="sanNmVal" value="">
	

<tr>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >場所区分</td>
	<td   style="padding: 3 3 3 3" width="80%">	
		<select name="basho" >			            							
			<option value="1">会議室1</option>
			<option value="2">会議室2</option>
			<option value="3">応接室1</option>
			<option value="4">応接室2</option>													
		  </select>	
		<img src="<%=urlPage%>rms/image/icon_s.gif" >予約者 : <%=memTop.getNm()%>		
	</td>
</tr>
<tr>
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >使用日・時間指定</td>
	<td   style="padding: 3 3 3 3" width="80%">
	<input type="text" size="10%" name='during_begin' id="during_begin" value="<%=ymdVal%>" style="text-align:center">
	<!--<input type="text" size="13%" name='during_begin' class=calendar value="<%=ymdVal%>" style="text-align:center">-->
		<select name="jikan_begin" ><!--ichinichi_begin-->
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
		 ~ <input type="text" size="10%" name='during_end' id="during_end" value="<%=ymdVal%>" style="text-align:center">		 			
		 <!--<input type="text" size="13%" name='during_end' class=calendar value="<%=ymdVal%>" style="text-align:center">-->		
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
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >申請タイトル:</td>
	<td   style="padding: 3 3 3 3"  >		
		<input type="text" name="title" value="" size="40" maxlength="50" class="input02" style="width:350px">	 
	</td> 
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >会議出席者(1):</td>
	<td   style="padding: 3 3 3 3" >選択しますか？　　
		<input type="radio" name="fellow_yn" value="1" onClick="fellow01()" onfocus="this.blur()" ><font  color="#FF6600">はい</font>
		<input type="radio" name="fellow_yn" value="2" onClick="fellow02()" onfocus="this.blur()"  checked><font  color="#FF6600">いいえ</font>		 
				<div id="fellow" style="display:none;overflow:hidden ;width:420;border:1px solid #99CC00;padding:3px 3px 3px 3px;" >	
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${mem.mseq!=memTop.mseq}">		
			<input type="checkbox" name="sansekisha1" value="${mem.mseq}">${mem.nm}  <!-- fellow-->			
		</c:if>
	</c:forEach>
</c:if>
											
		</div>		 
	</td>     
</tr>
<tr><td colspan="2" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >会議出席者(2):</td>
	<td   style="padding: 3 3 3 3" >直接に書きますか？　
		<input type="radio" name="fellow2_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">はい</font>
		<input type="radio" name="fellow2_yn" value="2" onClick="show02()" onfocus="this.blur()"  checked><font  color="#FF6600">いいえ</font>		 
			<div id="show" style="display:none;overflow:hidden ;width:100%;padding:3px 1px 3px 3px;">	
				<input type="text" name="sansekisha2"  id="sansekisha2" value="" size="12" maxlength="100" class="input02" style="width:350px">(ex) data1/data2
			</div>
			
			
			<!--
			<div id="show" style="display:none;overflow:hidden ;width:420;padding:3px 3px 3px 3px;border:1px solid #99CC00;">	
			<table width="100%"   id="tbl">
			<tr>	
				<td align="center" ><input type="button"  class="cc" onfocus="this.blur();" style="cursor:pointer" value=" 削除 "  onclick="javascript:deleteCheckedRow()"></td>							
				<td align="left"><input type="button"  class="cc" onfocus="this.blur();" style="cursor:pointer" value="挿入 "  onclick="javascript:NewRow()"></td>			
			<tr>
			</div>			
			<tr>	
				<td align="center" ><input type="checkbox" /></td>							
				<td align="left"><input type="text" name="sansekisha2[]"  id="sansekisha2[]" value="" size="12" maxlength="50" class="input02" style="width:100px"></td>							
			</tr>				
			</table> 
			-->				 
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
	
<!--	
<script language=javascript>
function AutoInsert() {
 var f = document.all;
 var rowLen = f.trTable.rows.length;
 var r  = f.trTable.insertRow(rowLen++);
 r.height=25;
 var c0 = r.insertCell(0);
 var Html;

 c0.innerHTML = "&nbsp;";
 Html = "<input type=text name=sansekisha2 > 제목";
 c0.innerHTML = Html;
}
</script>	
	
<table id="trTable">
<form name="myfrm" method="post" action="">
<tr>
<td><font  style=cursor:hand  onClick="AutoInsert()">추가</font> <input type=submit>
</td>
</tr>
</form>
</table>			
-->	
	
	
	
	
	