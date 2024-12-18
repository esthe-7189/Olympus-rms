<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
<%  
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.KOREA );
%>
<%
String urlPage=request.getContextPath()+"/";		
String urlPageRms=request.getContextPath()+"/rms/home/home.jsp";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
Date creationTime = new Date(session.getCreationTime( ));
Date lastAccessed = new Date(session.getLastAccessedTime( )); 

int level=0;

//회계시스템
MemberManager manageracc=MemberManager.getInstance();
Member memberacc=manageracc.getMember(id);
	if(memberacc!=null){ level=memberacc.getLevel();}
%>

<script type="text/javascript">
var ma = ["dropmenu1"];
function dropMenu(x){
	 for (var m in ma) {
		 if(ma[m] != x){
			 document.getElementById(ma[m]).style.display = "none";
		 }
	 }
	 if(document.getElementById(x).style.display == 'block'){
		 fadeOut(x);
	 } else {
		 fadeIn(x);
	 }
	 
	  if(document.getElementById("layerpop").style.display == 'block'){
		 fadeOut(x);
	 } else {
		 fadeIn(x);
	 }	 	 
}
</script>	
	
		
        <div class="top_menu_cont" > 
    			<ul class="bio">
    				<li><a class="logonav_ff" href="<%=urlPageRms%>" onfocus="this.blur();">OLYMPUS-RMS </a></li>
    			</ul>      
    			<ul class="social">
    				<li><a class="homenav"	href="<%=urlPage%>accounting/admin/file/listForm.jsp" onfocus="this.blur();" title="home">HOME</a></li>
<%if(id !=null){
	if(kind.equals("acc")){%>							
		<%if(level==1){%>			
				<li><a class="homenav" href="http://weblog.olympus-rms.com/" onFocus="this.blur()"  target="_blank" title="orms/orms">WEB-LOG</a></li>	
				<li><a href="<%=urlPage%>accounting/member/logout.jsp" onfocus="this.blur();" title="logout">ログアウト</a></li> 						
				<li><a  href="<%=urlPage%>accounting/admin/member/listForm.jsp" onfocus="this.blur();"  title="会員管理"> 会員管理 </a></li>									
		<%}else{%>				
				<li><a href="<%=urlPage%>accounting/member/logout.jsp" onfocus="this.blur();"  title="logout">ログアウト</a></li>				
		<%}%>				
	<%}%>
<%}else{%>			
				<li><a href="<%=urlPage%>accounting/member/loginForm.jsp" onFocus="this.blur()" title="login">ログイン</a></li>				
<%}%>				
				<li><a  href="<%=urlPage%>accounting/admin/member/updateForm_admin.jsp?member_id=<%=id%>" onfocus="this.blur();" title="My情報"> My情報</a></li>  
			</ul> 
	<div class="clear"></div>
      </div><!--//top_menu_cont-->           
	   <div class="logo_bottom">
			<div class="logo_bottom_main">
				<div class="logo_bottom_main_left">				   	
				   	<a class="logonav_acc" href="<%=urlPage%>accounting/admin/file/listForm.jsp" onfocus="this.blur();"  title="経理・会計文書システム">経理・会計文書システム</a>			   
				</div>  
				<div class="logo_bottom_main_right">
					<a class="logo_groupware" href="<%=urlPage%>accounting/admin/file/listForm.jsp" onfocus="this.blur();"  title="経理・会計文書システム">
					<img src="<%=urlPage%>rms/image/admin_main_top.jpg">	</a>
					<!--<a href="<%=urlPage%>accounting/admin/file/listForm.jsp" onfocus="this.blur();"  title="経理・会計文書システム">
					<img src="<%=urlPage%>rms/image/sakura.jpg">
					<script> swfView('350','46','<%=urlPage%>rms/image/winter01.swf')</script>	-->	
														
				</div>   
			</div>
			<div class="logo_bottom_sub"> 
				<!--<div class="logo_bottom_main_right_inner">
					<script> swfView('200','23','<%=urlPage%>rms/image/topevent.swf')</script>
					</div>
				-->
			</div>				   
		</div>
	   </div>
<div id="headermenusystem_bg">
<%if(id !=null && kind.equals("acc")){%>     	   
	  <div id="headermenusystem">
		    <div id="cont1">
		      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu1')" onfocus="this.blur();">経理・会計文書システム </a>
			      <div id="dropmenu1" class="dropmenus">
			        <a class="stopnav" href="<%=urlPage%>accounting/admin/file/listForm.jsp" onfocus="this.blur();">全体目録</a>
			        <a class="stopnav" href="<%=urlPage%>accounting/admin/file/uploadForm.jsp" onfocus="this.blur();">新規登録</a>	        
			      </div>
		    </div>	    
	  </div> <!-- headermenusystem -->
<%}else{%>	
	 <div id="headermenusystem">
		    <div id="cont1">
		      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu1')" onfocus="this.blur();">経理・会計文書システム </a>
			      <div id="dropmenu1" class="dropmenus">
			        <a class="stopnav" href="#" onfocus="this.blur();">全体目録</a>
			        <a class="stopnav" href="#" onfocus="this.blur();">新規登録</a>	        
			      </div>
		    </div>	    
	 </div> <!-- headermenusystem -->
<%}%>
	 
	 <div id="headermenusystem_right">		  	    	  
	    	<div class="timeling"><img src="<%=urlPage%>rms/image/admin/icon_key.gif" align="absmiddle" border="0">
    			<%=id%>様の<font color="#CC6600">Login Time: </font><%=fmt.format(creationTime)%>    		
    		</div>
    	</div><!--headermenusystem_right -->
    </div> <!-- headermenusystem_bg -->    
          
        <div class="clear"></div>        
   

