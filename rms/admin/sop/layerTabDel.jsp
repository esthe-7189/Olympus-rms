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
%>
<c:set var="listTab" value="<%=listTab %>" />

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
	if(isEmpty(frm.seq_tab, "タブ名を選択して下さい")) return ;	
 
   if ( confirm("本当に削除しますか？") != 1 ) {return ;}
	frm.action = "<%=urlPage%>rms/admin/sop/tabDel.jsp";	
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
	<form name="frmList" action="<%=urlPage%>rms/admin/sop/tabDel.jsp" method="post" onSubmit="return goWrite(this)">		
		<input type="hidden" name="stayPg" value="<%=stayPg%>">											
	<tr>
		<td width="12" style="background:url('<%=urlPage%>rms/image/admin/titlePop.gif') no-repeat;"></td>
		<td width="280" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">
			<img src="<%=urlPage%>rms/image/icon_ball.gif" ><span class="calendar7">タブ削除</span> 
		</td>	
		<td width="70">
			<a href="#"  onclick="formClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a>
		</td>
	</tr>
</table>
<div class="clear_margin"></div>
<table width="95%"  border="0" cellspacing="0" cellpadding="0" >	
		<tr >
	    		<td style="padding: 5px 0px 0px 3px;"  align="center"><img src="<%=urlPage%>rms/image/icon_s.gif" >タブを選択:
			    	<select  name="seq_tab"  id="seq_tab"　onChange="doselectLcode();">
		    			<option value="">選択して下さい</option>
		    	<c:if test="${empty listTab}">
				<option value="">No Data</option>
			</c:if>	
		    	<c:if test="${! empty listTab}">
				<c:forEach var="tab" items="${listTab}" varStatus="idx" >
					<option value="${tab.seq_tab}">${tab.name_tab}</option>				
				</c:forEach>
			</c:if>				
		       </select>		       		
	    		</td> 
		</tr>		
		<tr>
	    		<td style="padding: 10px 0px 0px 0px;"  align="center">
			    <input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="   削除する >> " onClick="goWrite();">  					
	    		</td> 
		</tr>			
</table>
<div class="clear_margin"></div>
</form>			
</div>
</body>
</html>

	
	
	
	
	
	
	
	