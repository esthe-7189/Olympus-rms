<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page errorPage="/rms/error/error-common.jsp"%>
<%@ page import = "java.text.SimpleDateFormat" %>	
<%! 
static int PAGE_SIZE=10; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");	
%>
<%
int level=0;		
MemberManager manager = MemberManager.getInstance();
	String id=(String)session.getAttribute("ID");	
	Member member2=manager.getMember(id);
	if(member2!=null){ level=member2.getLevel();}
	
	String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("home")){
%>			
	<jsp:forward page="/orms/template/tempMain.jsp">		    
		<jsp:param name="CSSPAGE1" value="/orms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	if(level!=1){
%>			
	<jsp:forward page="/orms/template/tempMain.jsp">		    
		<jsp:param name="CSSPAGE1" value="/orms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String urlPage=request.getContextPath()+"/";	
	
	
%>


<center>
<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>orms/images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>orms/images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">メインデザイン  
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>	
</table>	
<p>	

<table border="0" cellpadding="0" cellspacing="0" class=c width="100%"  >				
		<tr>
			<td  style="padding-top:20px;" >						
				<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
					<tr>
					<td style="padding: 2 0 2 0"><img src="<%=urlPage%>orms/images/admin/best_main.gif"  usemap="#best"></td>
					<map name="best">
<area shape="rect"  coords="221,129,281,148" href="<%=urlPage%>orms/admin/main/addForm.jsp" onfocus="this.blur();" alt="Best Product">
<area shape="rect"  coords="536,128,595,147" href="JavaScript:alert('工事中');" onfocus="this.blur();" alt="Focus">
<area shape="rect"  coords="802,169,862,186" href="JavaScript:alert('工事中');" onfocus="this.blur();" >
<area shape="rect"  coords="536,375,594,393" href="JavaScript:alert('工事中');" onfocus="this.blur();" >
<area shape="rect"  coords="800,373,862,389" href="JavaScript:alert('工事中');" onfocus="this.blur();" >
					</map>
					</tr>			
				</table>
		</td> 		
	</tr>
</table>





















