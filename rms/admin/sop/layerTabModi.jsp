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
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");		
String pg_seq_tab = request.getParameter("seq_tab");
String stayPg=request.getParameter("stayPg");


	
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
	
AccMgr tabmgr=AccMgr.getInstance();
List listTab=tabmgr.listTab();
int tab_count=tabmgr.tabCnt();	
%>
<c:set var="listTab" value="<%= listTab %>" />
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
 var frm=document.frmList;
 	if(isEmpty(frm.junbang, "読点(,)は使わないで下さい")) return ;	
	if(isEmpty(frm.all_seq_tab, "タブを選択して下さい")) return ;	
	if(isEmpty(frm.name_tab, "タブ名を書いて下さい")) return ;	
 
   if ( confirm("修正しますか?") != 1 ) {return ;}
	frm.action = "<%=urlPage%>rms/admin/sop/modifyTab.jsp";	
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
	<form name="frmList" action="<%=urlPage%>rms/admin/sop/modifyTab.jsp" method="post" onSubmit="return goWrite(this)">		
		<input type="hidden" name="stayPg" value="">	
		<input type="hidden" name="pg_seq_tab" value="<%=pg_seq_tab%>">
		<input type="hidden" name="seq_tab" value="">						
			
	<tr>
		<td width="12" style="background:url('<%=urlPage%>rms/image/admin/titlePop.gif') no-repeat;"></td>
		<td width="280" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">
			<img src="<%=urlPage%>rms/image/icon_ball.gif" ><span class="calendar7">タブ修正</span> 
		</td>	
		<td width="70">
			<a href="#"  onclick="formClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a>
		</td>
	</tr>
</table>
<div class="clear_margin"></div>
<table width="95%"  border="0" cellspacing="0" cellpadding="0" >	
		<tr>
	    		<td style="padding: 5px 0px 0px 3px;" ><img src="<%=urlPage%>rms/image/icon_s.gif" >タブを選択:
			    	<select  name="all_seq_tab" onChange="doselectLcode();">
		    			<option value="">選択して下さい</option>
					    	<c:if test="${empty listTab}">
					<option value="">No Data</option>
						</c:if>	
					      <c:if test="${! empty listTab}">
							<c:forEach var="tab" items="${listTab}" varStatus="idx" >
					<option value="${tab.junbang},${tab.seq_tab}">[${tab.junbang}]_${tab.name_tab}</option>				
							</c:forEach>
						</c:if>				
			       </select>		    	   				
	    		</td> 
		</tr>	
		<tr>
	    		<td style="padding: 2px 0px 0px 3px;" ><img src="<%=urlPage%>rms/image/icon_s.gif" >順&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;番:
			    <input type="taxt" name="junbang" value="" maxlength="2" size="20" class="logbox" style="width:50px;ime-mode:disabled">			
	    		</td> 
		</tr>
		<tr>
	    		<td style="padding: 2px 0px 0px 3px;" ><img src="<%=urlPage%>rms/image/icon_s.gif" >新しく&nbsp;&nbsp;書く:
			    <input type="taxt" name="name_tab" value="" maxlength="12" size="20" class="logbox" style="width:140px;">			
	    		</td> 
		</tr>	
</table>
<div class="clear_margin"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">		 
		<tr>
		<td align=center style="padding: 5 0 0 0">		
			<a href="javascript:goWrite()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>
			<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif" align="absmiddle"></a>				
	  		<!--<a href="javascript:opener.location.href='<%=urlPage%>rms/admin/sop/listForm.jsp';window.close();"  onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>-->			
					
		</td>
	</tr>
</table>	
</form>			
</div>
</body>
</html>
<script language='JavaScript'>
function doselectLcode(kind) {	
  var selVal = document.frmList.all_seq_tab.options[document.frmList.all_seq_tab.selectedIndex].value;
  var selNm = document.frmList.all_seq_tab.options[document.frmList.all_seq_tab.selectedIndex].text;    	 
  var arr=selVal.split(",");
  var arrTitle=selNm.split("_");
  	document.frmList.junbang.value  = arr[0];  
  	document.frmList.seq_tab.value  = arr[1];  	
	document.frmList.name_tab.value  = arrTitle[1];	
}
function cateReset() {  
	document.frmList.reset();	 
	var oEditor=FCKeditorAPI.GetInstance('name_tab');
	var div=document.createElement("DIV");
		div.innerHTML=oEditor.GetXHTML();
	 	oEditor.SetHTML(" "); 	 	
}
</script>
	
	
	
	
	
	
	
	