<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	
%>


<table width="99%" border="0" cellspacing="0" cellpadding="0">
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
	<tr>
    		<td align="center" style="padding-top:20px"><img src="<%=urlPage%>images/admin/img_admin_main.gif" usemap="#listmain"/></td>        
      	  <map name="listmain">
    			<area shape="rect" coords="136,15,205,78" href="<%=urlPage%>admin/main/mainForm.jsp" onfocus="this.blur();" alt="Best Product">
    			<area shape="rect" coords="258,18,320,74" href="<%=urlPage%>admin/main/mainForm.jsp" onfocus="this.blur();" alt="Focus">
    			<area shape="rect" coords="377,18,439,76" href="<%=urlPage%>admin/main/mainForm.jsp" onfocus="this.blur();" alt="Special Menu">
      	  	<area shape="rect" coords="70,131,169,222" href="<%=urlPage%>admin/product/product.jsp" onfocus="this.blur();" alt="Product">
      	  	<area shape="rect" coords="238,131,339,220" href="<%=urlPage%>admin/info/infoList.jsp" onfocus="this.blur();" alt="infomation">
      	  	<area shape="rect" coords="403,130,504,219" href="<%=urlPage%>admin/news/newsForm.jsp" onfocus="this.blur();" alt="news release">
      	  	<area shape="rect" coords="68,268,169,356" href="<%=urlPage%>admin/job/jobList.jsp" onfocus="this.blur();" alt="jobs">
      	  	<area shape="rect" coords="240,267,337,356" href="<%=urlPage%>admin/customer/customerForm.jsp" onfocus="this.blur();" alt="contact">
      	  	<area shape="rect" coords="404,268,502,355" href="<%=urlPage%>admin/member/listForm.jsp" onfocus="this.blur();" alt="member">
      	  </map>

  	</tr>
  	  	
</table>	
			