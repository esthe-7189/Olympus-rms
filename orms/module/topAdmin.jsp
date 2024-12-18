<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ page import = "mira.memberuser.MemberManagerException" %>
<%@ page errorPage="/orms/error/error.jsp"%>	

<%
String urlPage=request.getContextPath()+"/orms/";		
String id=(String)session.getAttribute("ID");
Date creationTime = new Date(session.getCreationTime( ));
Date lastAccessed = new Date(session.getLastAccessedTime( )); 

int level=0;
MemberManager manager=MemberManager.getInstance();
Member member=manager.getMember(id);
	if(member!=null){
		level=member.getLevel();
	}

%>


<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">	
   	<tr>
		<td width="100%" align="center" style="padding: 0 0 0 0">
			<table  border="0" cellspacing="0" cellpadding="0" >
				<tr>
    					<td width="12%" class="calendar15" style="padding:2 0 5 5"><a href="<%=urlPage%>admin/main.jsp" onfocus="this.blur();">OLYMPUS RMS </a></td>    	
    					<td width="10%" style="padding:2 0 5 0">(管理システム) </a></td>    				
					<td width="78%" style="padding:2 20 5 15">		
	
		<table width="95%" border="0" cellspacing="0" cellpadding="0" >
		   <tr>		     
<%if(id !=null){%>
			<td align="right" valign="top" style="padding:0 30 0 0;" class="sub06_blue">
				
		<%if(level==1){%><img src="<%=urlPage%>images/common/icon_ball.gif" >
				<a href="<%=urlPage%>" onfocus="this.blur();">Home</a> |
				<a href="<%=urlPage%>member/logout.jsp" onfocus="this.blur();">ログアウト</a> |				
				<a href="<%=urlPage%>admin/member/updateForm.jsp" onfocus="this.blur();">My情報</a> 							
				
		<%}else{%>
				<img src="<%=urlPage%>images/common/icon_ball.gif" >
				<a href="<%=urlPage%>" onfocus="this.blur();">Home</a> |
				<a href="<%=urlPage%>member/logout.jsp" onfocus="this.blur();">ログアウト</a> |				
				<a href="<%=urlPage%>admin/member/updateForm.jsp" onfocus="this.blur();">My情報</a>
		<%}%>
				
<%}else{%>
			<td align="right" valign="top" style="padding:0 0 0 0;" class="sub06_blue">
				<img src="<%=urlPage%>images/common/icon_ball.gif" >
				<a href="<%=urlPage%>" onfocus="this.blur();">Home</a> |
				<a href="<%=urlPage%>member/loginForm.jsp" onFocus="this.blur()">ログイン</a> |
				<a href="<%=urlPage%>member/writeForm.jsp" onFocus="this.blur()">会員登録 </a> |	
				アイディー探し
<%}%>
				
								
						
		    </td>
		   </tr>
		</table>
				
    					</td>
    				</tr> 
    				<tr>
    					<td align="center" colspan="3"><img src="<%=urlPage%>images/admin/top_menu_admin.jpg" usemap="#list"></td>
    					<map name="list">
				      	  	<area shape="rect" coords="84,13,183,41" href="<%=urlPage%>admin/product/product.jsp" onfocus="this.blur();" alt="product">
				      	  	<area shape="rect" coords="207,13,304,39" href="<%=urlPage%>admin/info/infoList.jsp" onfocus="this.blur();" alt="infomation">				      	  	
				      	  	<area shape="rect" coords="328,16,421,40" href="<%=urlPage%>admin/news/newsForm.jsp" onfocus="this.blur();" alt="news release">				      	  	
				      	  	<area shape="rect" coords="439,15,540,42" href="<%=urlPage%>admin/job/jobList.jsp" onfocus="this.blur();" alt="job">
				      	  	<area shape="rect" coords="564,12,693,40" href="<%=urlPage%>admin/customer/customerForm.jsp" onfocus="this.blur();" alt="contact">
				      	  	<area shape="rect" coords="713,12,781,40" href="<%=urlPage%>admin/member/listForm.jsp" onfocus="this.blur();" alt="member">
				      	  	<area shape="rect" coords="797,14,897,41" href="<%=urlPage%>admin/main/mainForm.jsp" onfocus="this.blur();" alt="member">
				      	  </map>
    				</tr>   									
    			</table>							
		</td>    		
	</tr>		
</table>




