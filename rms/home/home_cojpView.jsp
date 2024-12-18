<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "java.util.*,java.text.*"%>
<%  
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA );
%>

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
     			if(cookies[i].getName().equals("idName")){      
				cheOk=2;
				idvalue= cookies[i].getValue() ;
				cookiesNameCk=cookies[i].getName();
     			}
    		}
  	 }
%>



<table width="656" border="0" align="center" cellpadding="0" cellspacing="0" height="99%">
  <tr>
    <td  align="center" valign=middle>
   		<a href="http://www.olympus-rms.co.jp"> <img src="<%=urlPage%>rms/image/rmsmain.jpg"> </a>
    </td>
  </tr>  
</table>







									