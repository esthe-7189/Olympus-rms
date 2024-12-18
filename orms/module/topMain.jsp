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



	      
	      <div id="gnb_top" >        
	         <div class="relative">
		         <div class="util">
		            <ul>
 <%if(id !=null && kind.equals("home")){    	
		if(level==3){%>		                                
		               <li><a href="<%=urlPage%>member/logout.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >ログアウト</a>&nbsp;|&nbsp;</li>                
		               <li><a href="<%=urlPage%>member/updateForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >My情報</a>&nbsp;|&nbsp;</li>  
		               <li><a href="<%=urlPage%>member/memberForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >サイトマップ</a>&nbsp;&nbsp;</li> 		               
		<%}else{%>
				 <li><a href="<%=urlPage%>member/logout.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >ログアウト</a>&nbsp;|&nbsp;</li>                
		               <li><a href="<%=urlPage%>member/updateForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >My情報</a>&nbsp;|&nbsp;</li>  
		               <li><a href="<%=urlPage%>member/memberForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >サイトマップ</a>&nbsp;&nbsp;</li>		               
		<%}%>
<%}else{%>
				 <li><a href="<%=urlPage%>member/loginForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >ログイン</a>&nbsp;|&nbsp;</li>                
		               <li><a href="<%=urlPage%>member/memberForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >会員登録 </a>&nbsp;|&nbsp;</li>  
		               <li><a href="<%=urlPage%>member/memberForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >サイトマップ</a>&nbsp;|&nbsp;</li>                
		               <li><a href="<%=urlPage%>member/memberForm.jsp" onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" >アイディー探し</a>&nbsp;&nbsp;</li>
<%}%>					
		            </ul>
		         </div>           
	         </div>          
	      </div>   
	   <div style="position:absolute;left:0px;top:20px;" >
	   		<a href="<%=urlPage%>"><img src="<%=urlPage%>images/main/mainlogo.jpg" /></a>
          </div>
        <div style="position:absolute;left:303px;top:23px;">
            <img src="<%=urlPage%>images/main/top_menu.jpg" usemap="#list"/>
        </div>
      	  <map name="list">
      	  	<area shape="rect" coords="53,15,122,45" href="<%=urlPage%>company/company.jsp" onfocus="this.blur();" alt="company">
      	  	<area shape="rect" coords="144,20,216,49" href="<%=urlPage%>product/product.jsp" onfocus="this.blur();" alt="product">
      	  	<area shape="rect" coords="235,20,306,41" href="<%=urlPage%>info/infoSub.jsp" onfocus="this.blur();" alt="infomation">
      	  	<area shape="rect" coords="323,18,438,44" href="<%=urlPage%>news/newsList.jsp" onfocus="this.blur();" alt="news release">
      	  	<area shape="rect" coords="453,19,532,42" href="<%=urlPage%>jobs/jobSub.jsp" onfocus="this.blur();" alt="jobs">
      	  	<area shape="rect" coords="543,17,649,44" href="<%=urlPage%>customer/customerForm.jsp" onfocus="this.blur();" alt="customer">
      	  </map>
