<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page errorPage="/orms/error/error.jsp"%>	
<%
String urlPage=request.getContextPath()+"/";
String urlPage2="https://olympus-rms.com/";
	Cookie [] cookies=request.getCookies();
	Cookie cookie=null;
	int cheOk=1;
	String idvalue="";
	String cookiesNameCk="";
	
	if(cookies != null){
    		for(int i = 0; i < cookies.length; i++){
     			if(cookies[i].getName().equals("idNameToku")){      
				cheOk=2;
				idvalue= cookies[i].getValue() ;
				cookiesNameCk=cookies[i].getName();
     			}
    		}
  	 }
%>

<script language="javascript">
function isNotValidChk(e) {	
	var field = document.getElementById(e); 	 	
   	var NotPermitChar = "<>\"^&|'\\%";  
	   for (var i = 0; i < field.value.length; i++) {
		      for (var j = 0; j < NotPermitChar.length; j++) {
			         if(field.value.charAt(i) == NotPermitChar.charAt(j)) {			         	 
			         	 alert("<>\"^&|'\\%などの特殊文字は避けて下さい。");
			           	field.value ="";
			         }
		      }
	   }   	   
}
</script>
<table width="656" border="0" align="center" cellpadding="0" cellspacing="0" height="99%">
<form name="memberInput"  action="<%=urlPage%>tokubetu/member/login.jsp" method="post"   >	 
  <tr>
    <td  align="center" valign=middle>
   <table width="656" height="426" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top" background="<%=urlPage%>rms/image/user/loginbg_toku.jpg">          
          <table width="656" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="190" colspan="4">&nbsp;</td>
          </tr>
          <tr height="35">
            <td width="105" rowspan="2">&nbsp;</td>
            <td width="100" class="calendar12">アイディー :</td>
            <td width="117" >
              <input type="text" class="tf_txt3"  name="member_id" id="member_id"  onkeyup="isNotValidChk('member_id')" onkeydown="isNotValidChk('member_id')" value="<%=idvalue%>" tabIndex=2 style="ime-mode:disabled;" maxlength="45" ></td>
            <td width="303" rowspan="2" align="left">
    			<a href="javascript:goPage('idvalue');" onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/user/login_ok.gif" width="66" height="50" border="0"  alt="Login" onfocus="this.blur()"  align="absmiddle" ></a>	
    		
            </td>
          </tr>          
          <tr height="35">
            <td class="calendar12">パスワード :</td>
            <td><input type="password" class="tf_txt3"  name="password" id="password"  onkeyup="isNotValidChk('password')" onkeydown="isNotValidChk('password')"　tabIndex=3 style="ime-mode:disabled;" maxlength="50"></td>    
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td height="24" colspan="2" class="t2" style="padding: 0 0 0 10">
                  <div align="center">                   
                  <input name="idSave" type="checkbox" value="save"  onfocus="this.blur()" <%if(cheOk==2){%>checked <%}%> >
                次回からIDの入力を省略</div></td>
            <td>&nbsp;</td>
          </tr>
          <tr>            
            <td colspan="4" align="center" style="padding: 10px 20px 10px 0"><img src="<%=urlPage%>rms/image/user/loginLine.gif" width="462" height="8"></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="4" class="t2" align="left">              
              <img src="<%=urlPage%>rms/image/user/icon_warning_big.jpg" align="absmiddle">
				パスワードを忘れた方は管理者へ。<br>
              
              </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table>    
    </td>
  </tr>
  </form>
</table>
<script language="JavaScript">

 function goPage(cookieName){
 	var frm=document.memberInput;
  	var expireDate = new Date();
  
  	if (frm.idSave.checked != true){		
		expireDate.setDate( expireDate.getDate() - 1 );
  		document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
	  }	
	  
  	  if (chkSpace(frm.member_id.value)) {
   	    	alert("IDを入力して下さい!!");
              frm.member_id.focus();    return ;                   
         }else if (chkSpace(frm.password.value)) {
            alert("パスワードを 入力して下さい!!");
            frm.password.focus();   return ;         
         }
  frm.action="<%=urlPage%>tokubetu/member/login.jsp";
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

</script>  		










									