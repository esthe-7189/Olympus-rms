<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ page import = "mira.memberuser.MemberManagerException" %>
<%@ page errorPage="/orms/error/error.jsp"%>	

<%
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
Date creationTime = new Date(session.getCreationTime( ));
Date lastAccessed = new Date(session.getLastAccessedTime( )); 

int level=0;
MemberManager manager=MemberManager.getInstance();
Member member=manager.getMember(id);
	if(member!=null){
		level=member.getLevel();
	}

%>		

<form name="move"  method="post"  >	
<div style="width:986px; margin:0 auto;">
	<p class="left ss">Copyright  &copy; 2009-2010	 Olympus-rms All rights reserved.          
 &nbsp;&nbsp;&nbsp;  関係者ページ				
				<img src="<%=urlPage%>orms/images/bg/sign_icon01.gif" align="absmiddle"/><a href="javascript:goRms()" onfocus="this.blur()" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" > グループウェア </a> 
				<img src="<%=urlPage%>orms/images/bg/sign_icon01.gif" align="absmiddle"/><a href="javascript:goAcc()" onfocus="this.blur()"onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" > 会計システム</a>
				<img src="<%=urlPage%>orms/images/bg/sign_icon01.gif" align="absmiddle"/><a href="javascript:goToku()" onfocus="this.blur()"onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" > 特別文書システム</a>
	<%if(id !=null && kind.equals("home")){    	
		if(level==3){%>		                                
		               .	               
		<%}else{%>
				   <img src="<%=urlPage%>orms/images/bg/sign_icon01.gif" align="absmiddle"/><a href="javascript:goHome()" onfocus="this.blur()" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >ホームページ管理</a>		               
		<%}%>
	<%}else{%>
				<img src="<%=urlPage%>orms/images/bg/sign_icon01.gif" align="absmiddle"/><a href="javascript:goLogin()" onfocus="this.blur()" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >ホームページ</a>				
	<%}%>			                       
	 </p>			
</div>
</form>	
<script language="JavaScript">
function goRms() {
    document.move.action = "<%=urlPage%>rms/member/loginForm.jsp";    
    document.move.submit();
}
function goAcc() {
    document.move.action = "<%=urlPage%>accounting/member/loginForm.jsp";   
    document.move.submit();
}

function goToku() {
    document.move.action = "<%=urlPage%>tokubetu/member/loginForm.jsp";    
    document.move.submit();
}
function goHome() {
    document.move.action = "<%=urlPage%>orms/admin/main.jsp";    
    document.move.submit();
}
function goLogin() {
    document.move.action = "<%=urlPage%>orms/member/loginForm.jsp";    
    document.move.submit();
}

</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	