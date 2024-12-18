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
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String seq=request.getParameter("seq");
String position=request.getParameter("position");
int positionInt=Integer.parseInt(position);

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
DataMgrTripHokoku mgrKin=DataMgrTripHokoku.getInstance();
DataBeanHokoku pdb=mgrKin.getDb(Integer.parseInt(seq));

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

	
function goSignHokoku(seq,sign_ok) {	
	var noriyu=document.getElementsByName("noRiyuh")[0].value; 		
	
	if(sign_ok=="2"){
		if ( confirm("承認しますか?") != 1 ) {return;}
	}else if(sign_ok=="3"){
		if(noriyu ==""){alert("差戻し理由を書いて下さい");return;}
		if ( confirm("差し戻ししますか?") != 1 ) {return;}
	}
		
	document.memberInput.action = "<%=urlPage%>rms/admin/hokoku/writeTripBogo/signOk.jsp";
	document.memberInput.seq.value = seq;	
	document.memberInput.sign_ok.value = sign_ok;
	document.memberInput.noRiyumo.value = noriyu;			
	document.memberInput.submit();
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
	<form name="memberInput"  method="post"  >		
	<input type="hidden" name="mseq" value="<%=memTop.getMseq()%>">	
	<input type="hidden" name="seq" value="<%=seq%>">
	<input type="hidden" name="sign_ok" value="">
	<input type="hidden" name="noRiyumo" value="">
	<input type="hidden" name="sign_ok_mseq" value="">			
	<input type="hidden" name="position" value="<%=position%>">	
	<tr>
		<td width="12" style="background:url('<%=urlPage%>rms/image/admin/titlePop.gif') no-repeat;"></td>
		<td width="280" background="<%=urlPage%>rms/image/admin/titlePop_bg.gif" class="calendar5_03">
			<img src="<%=urlPage%>rms/image/icon_ball.gif" ><span class="calendar7">出張報告書 > 決裁処理 </span>
		</td>	
		<td width="70">
			<a href="#"  onclick="formClose();"  onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/titlePop_calendar_close.gif"  alt="Close" ></a>
		</td>
	</tr>
</table>
<div class="clear_margin"></div>
<table border="0" width="100%" height="20" bgcolor="#ffffff"   cellspacing=0 cellpadding=0  >	     	
         	<tr>
       <%if(positionInt==1){%>        	  
         	<%if(pdb.getSign_ok_yn_boss()==1){%>         	  	
                 <td valign="middle" style="padding:2px 0px 2px 20px;" >
                 	 	<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">承認する==>
                 	 	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="承認" onClick="goSignHokoku('<%=seq%>',2);" >                 	 		
            <tr><td background="<%=urlPage%>rms/image/dot_line_all.gif" ></td></tr>
            <tr>
                 <td valign="middle" style="padding:2px 0px 2px 20px;" >
                		<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">差戻しする==>            		
			      <input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="差戻し" onClick="goSignHokoku('<%=seq%>',3);" >	
                		<br><br>    
				差戻し理由:<input type="text" size="2" name='noRiyuh'  value="" class="input02" maxlength="100" style="width:120px">
                </td>
              <%}%>
              <%if(pdb.getSign_ok_yn_boss()==3 ){%>                 
                 <td valign="middle" style="padding:2px 0px 2px 20px;" ><img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">承認==>
              		<a href="javascript:goSignHokoku('<%=seq%>',2);" onfocus="this.blur()" style="CURSOR: pointer;">
    					<img src="<%=urlPage%>rms/image/admin/btn_kesai_ok.gif"  align="absmiddle"></a>						
                </td>
                 <input type="hidden" name="noRiyuh" value="">                 
              <%}%>
    <%}%>         
    <%if(positionInt==2){%>        
               <%if(pdb.getSign_ok_yn_bucho()==1){%>
                 <td valign="middle" style="padding:2px 0px 2px 20px;" >
                 	 	<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">承認する==>
                 	 	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="承認" onClick="goSignHokoku('<%=seq%>',2);" >          
                 	 
            <tr><td background="<%=urlPage%>rms/image/dot_line_all.gif" ></td></tr>
            <tr>
                 <td valign="middle" style="padding:2px 0px 2px 20px;" >
                		<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">差戻しする==>            		
			      <input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="差戻し" onClick="goSignHokoku('<%=seq%>',3);" >	
                		<br><br>    
				差戻し理由:<input type="text" size="2" name='noRiyuh'  value="" class="input02" maxlength="100" style="width:120px">
                
                </td>
              <%}%>
              <%if(pdb.getSign_ok_yn_bucho()==3 ){%>                 
                 <td valign="middle" style="padding:2px 0px 2px 20px;" >
                 	 	<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">承認する==>
                 	 	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="承認" onClick="goSignHokoku('<%=seq%>',2);" >                       	 					
                </td>
                 <input type="hidden" name="noRiyuh" value="">                 
              <%}%>
   <%}%>
           </tr>            
     </table>
</form>

</div>
</body>
</html>

	
	
	
	
	
	
	
	