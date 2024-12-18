<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.shokudata.FileMgr" %>
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

	int level=0; int levelPosi=0; int mseq=0; 
	//String password="";
//문서시스템
MemberManager manager=MemberManager.getInstance();
Member member=manager.getMember(id);
	if(member!=null){
		level=member.getLevel();
		levelPosi=member.getPosition_level();
		mseq=member.getMseq();
	//	password=member.getPassword();
	}
//page권한
int pageArrow=0;  int pageArrowCon=0;
if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){ pageArrow=1;	}else{pageArrow=2;}	
if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin") || id.equals("hamano") || id.equals("funakubo")){ pageArrowCon=1;	}else{pageArrowCon=2;}
int nointit=0;
if(id.equals("candy") || id.equals("ohtagaki") || id.equals("kishi") || id.equals("togashi")){ nointit=1;	}else{nointit=2;}

FileMgr manaPg=FileMgr.getInstance();
int countPg=0; int viewPg=0;
if(pageArrow==2){	countPg=manaPg.kindCnt(mseq);}
 
%>

<script type="text/javascript">
var ma = ["dropmenu1","dropmenu2","dropmenu3","dropmenu4"];
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

var ma3 = ["dropmenu1","dropmenu2","dropmenu3"];
function dropMenu3(x){
	 for (var m in ma3) {
		 if(ma3[m] != x){
			 document.getElementById(ma3[m]).style.display = "none";
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

function goPre(){
	alert("準備中です。");
}
</script>	

		
        <div class="top_menu_cont" > 
    		<ul class="bio">
    			<li><a class="logonav_ff" href="<%=urlPageRms%>" onfocus="this.blur();">OLYMPUS-RMS </a></li>
    		</ul>      
    		<ul class="social">
<%if(id !=null){
	if(kind.equals("bun")){
		if(level==1){%>
			
				<li><a  class="homenav" href="<%=urlPage%>rms/admin/admin_main.jsp" onfocus="this.blur();" title="home">HOME</a></li>
				<li><a  class="homenav" href="http://weblog.olympus-rms.com/" onFocus="this.blur()"  target="_blank" title="orms/orms">WEB-LOG</a></li>				
				<li><a  href="<%=urlPage%>rms/member/logout.jsp" onfocus="this.blur();" title="logout">ログアウト</a></li>
				<li><a  href="<%=urlPage%>rms/admin/member/listForm.jsp" onfocus="this.blur();"  title="会員管理"> 会員管理 </a></li>											
		<%}else{%>
				<li><a  class="homenav" href="<%=urlPage%>rms/admin/admin_main.jsp" onfocus="this.blur();"  title="home">HOME</a></li>					
				<li><a  href="<%=urlPage%>rms/member/logout.jsp" onfocus="this.blur();" title="logout">ログアウト</a></li>							
		<%}%>
				
<%     }
	}else{%>			
				<li><a  class="homenav" href="<%=urlPage%>rms/admin/admin_main.jsp" onfocus="this.blur();"  title="home">HOME</a></li>			
				<li><a  href="<%=urlPage%>rms/member/loginForm.jsp" onFocus="this.blur()" title="login">ログイン</a></li>			
<%}%>											
			   
<%if(!id.equals("candy")){%><li><a  href="<%=urlPage%>rms/admin/member/updateForm_admin.jsp?member_id=<%=id%>" onfocus="this.blur();" title="My情報">My情報</a></li><%}%>	            	          	
            		   <li><a  href="<%=urlPage%>rms/admin/notice/listForm.jsp" onFocus="this.blur()" title="お知らせ">お知らせ</a></li>
 <%if(!id.equals("candy")){%><li><a  href="<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=2" onFocus="this.blur()" title="製造/品質掲示板">製造掲示板</a></li>
            		   <li><a  href="<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=3" onFocus="this.blur()" title="OT-ORMS連絡事項">品質掲示板</a></li><%}%>
			   <li><a  href="<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=1" onFocus="this.blur()" title="社内掲示板">5S掲示板</a></li>
			   <li><a  href="<%=urlPage%>rms/admin/hitokoto/listForm.jsp" onFocus="this.blur()" title="管理者に一言">管理者に一言</a></li>            	                                                   
            		</ul>               	         	  
            <div class="clear"></div>
        </div><!--//top_menu_cont-->           
	   <div class="logo_bottom">
			<div class="logo_bottom_main">
				<div class="logo_bottom_main_left">				   	
				   	<a class="logonav" href="<%=urlPage%>rms/admin/admin_main.jsp" onfocus="this.blur();"  title="GROUPWARE HOME">GROUPWARE </a>			   
				</div>  
				<div class="logo_bottom_main_right">
					<a class="logo_groupware" href="<%=urlPage%>rms/admin/admin_main.jsp" onfocus="this.blur();"  title="GROUPWARE HOME"></a>
					<img src="<%=urlPage%>rms/image/admin_main_top.jpg">					
					<!--<img src="<%=urlPage%>rms/image/2013.gif">
					<script> swfView('350','46','<%=urlPage%>rms/image/winter01.swf')</script>-->										
				</div>   
			</div>
<!--			<div class="logo_bottom_sub"> 
	<%if(!id.equals("candy")){%>
				<div class="logo_bottom_main_right_inner">
					<script> swfView('200','23','<%=urlPage%>rms/image/topevent.swf')</script>
				</div>
	<%}%>
			</div>
-->				  
		</div>
	   </div>
<div id="headermenusystem_bg"  >
<%if(id !=null && kind.equals("bun") && level==1 && !id.equals("candy")){%>     	   
	  <div id="headermenusystem">
	    <div id="cont1">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu1')" onfocus="this.blur();">開発部 </a>
	      <div id="dropmenu1" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/sop/listForm.jsp" onfocus="this.blur();">標準作業手順書</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/gmp/listForm.jsp" onfocus="this.blur();">校正対象設備等一覧 </a>
	        <%if(pageArrow==1 || countPg !=0){%><a class="stopnav" href="<%=urlPage%>rms/admin/shokuData/mainForm.jsp" onfocus="this.blur();">月報・週報開発/QMS</a><% }else{%><a class="stopnav" href="#" onfocus="this.blur();">月報・週報開発/QMS</a><%}%>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/seizo/listForm.jsp"   onfocus="this.blur();">製造記録書QA</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/hinsithu/listForm.jsp"   onfocus="this.blur();">品質試験書QA</a>
     	             	        
     <%if(id.equals("akikino") || id.equals("biofloc") || id.equals("juc0318") || id.equals("admin")){%>	        
     	        <a class="stopnav" href="<%=urlPage%>rms/admin/bunsho/listForm.jsp" onfocus="this.blur();">CHONDRON文書</a>
     <%}%>
	      </div>
	    </div>
	    <div id="cont2">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu2')" onfocus="this.blur();">管理部 </a>
	      <div id="dropmenu2" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/order/listForm.jsp" onfocus="this.blur();">社内用品申請</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/form/listForm.jsp" onfocus="this.blur();">各種文書フォーム</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/hokoku/listForm.jsp" onfocus="this.blur();">出張/休日勤務</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/approval/listForm.jsp"  onfocus="this.blur();">決裁書リスト管理</a>
<%if(pageArrowCon==1){%><a class="stopnav" href="<%=urlPage%>rms/admin/contract/listForm.jsp"  onfocus="this.blur();">契約書リスト管理</a><%}%>
		 <a class="stopnav" href="<%=urlPage%>rms/admin/payment/listForm.jsp"  onfocus="this.blur();">請求書手続管理</a>
	      </div>
	    </div>	    	  
	    <div id="cont3">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu3')" onfocus="this.blur();">出勤管理</a>
	      <div id="dropmenu3" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/kintai/listForm.jsp" onfocus="this.blur();">出勤管理</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/kintai/listFormAll.jsp" onfocus="this.blur();">部署出勤リスト</a>	        
	      </div>
	    </div>	    	  
	    <div id="cont4">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu4')" onfocus="this.blur();">残業申請</a>
	      <div id="dropmenu4" class="dropmenus">	        
	        <a class="stopnav" href="<%=urlPage%>rms/admin/jangyo/listForm.jsp" onfocus="this.blur();">残業申請</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/jangyo/listFormAll.jsp" onfocus="this.blur();">部署残業リスト</a>	        
	      </div>
	    </div>	   
	    <div>
	      		<a class="mtopnav" href="<%=urlPage%>rms/admin/schedule/monthForm.jsp" onfocus="this.blur();">日程管理</a>
	    </div> 	  
	    <div>
	      		<a class="mtopnav" href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">決裁管理</a>
	    </div>	  
<%}else if(id !=null && kind.equals("bun") && level!=1 && !id.equals("candy")){%>	
		 <div id="headermenusystem">
	    <div id="cont1">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu1')" onfocus="this.blur();">開発部 </a>
	      <div id="dropmenu1" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/sop/listForm.jsp" onfocus="this.blur();">標準作業手順書</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/gmp/listForm.jsp" onfocus="this.blur();">校正対象設備等一覧 </a>
	        <%if(pageArrow==1 || countPg !=0){%><a class="stopnav" href="<%=urlPage%>rms/admin/shokuData/mainForm.jsp" onfocus="this.blur();">月報・週報開発/QMS</a><% }else{%><a class="stopnav" href="#" onfocus="this.blur();">月報・週報開発/QMS</a><%}%>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/seizo/listForm.jsp"  onfocus="this.blur();">製造記録書QA</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/hinsithu/listForm.jsp"  onfocus="this.blur();">品質試験書QA</a>	        	
     <%if(id.equals("akikino") || id.equals("biofloc") || id.equals("juc0318") || id.equals("admin")){%>	        
     	        <a class="stopnav" href="<%=urlPage%>rms/admin/bunsho/listForm.jsp" onfocus="this.blur();">CHONDRON文書</a>
     <%}%>
	      </div>
	    </div>
	    <div id="cont2">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu2')" onfocus="this.blur();">管理部 </a>
	      <div id="dropmenu2" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/order/listForm.jsp" onfocus="this.blur();">社内用品申請</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/form/listForm.jsp" onfocus="this.blur();">各種文書フォーム</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/hokoku/listForm.jsp" onfocus="this.blur();">出張/休日勤務</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/approval/listForm.jsp"   onfocus="this.blur();">決裁書リスト管理</a>
<%if(pageArrowCon==1){%><a class="stopnav" href="<%=urlPage%>rms/admin/contract/listForm.jsp"   onfocus="this.blur();">契約書リスト管理</a><%}%>
	 	 <a class="stopnav" href="<%=urlPage%>rms/admin/payment/listForm.jsp"  onfocus="this.blur();">請求書手続管理</a>
	      </div>
	    </div>	    	  
	    <div id="cont3">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu3')" onfocus="this.blur();">出勤管理</a>
	      <div id="dropmenu3" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/kintai/listForm.jsp" onfocus="this.blur();">出勤管理</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/kintai/listFormAll.jsp" onfocus="this.blur();">部署出勤リスト</a>	        
	      </div>
	    </div>	    	  
	    <div id="cont4">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu('dropmenu4')" onfocus="this.blur();">残業申請</a>
	      <div id="dropmenu4" class="dropmenus">	        
	        <a class="stopnav" href="<%=urlPage%>rms/admin/jangyo/listForm.jsp" onfocus="this.blur();">残業申請</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/jangyo/listFormAll.jsp" onfocus="this.blur();">部署残業リスト</a>	        
	      </div>
	    </div>	   
	    <div>
	      		<a class="mtopnav"  href="<%=urlPage%>rms/admin/schedule/monthForm.jsp" onfocus="this.blur();">日程管理</a>
	    </div> 	  
	    <div>
	      		<a class="mtopnav" href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">決裁管理</a>
	    </div>	  	    	  
<%}else if(id.equals("candy")){%>	
		 <div id="headermenusystem">	   
	    <div id="cont1">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu3('dropmenu1')" onfocus="this.blur();">管理部 </a>
	      <div id="dropmenu1" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/order/listForm.jsp" onfocus="this.blur();">社内用品申請</a>
	        <a class="stopnav" href="<%=urlPage%>rms/admin/form/listForm.jsp" onfocus="this.blur();">各種文書フォーム</a>	        
	      </div>
	    </div>	    	  
	    <div id="cont2">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu3('dropmenu2')" onfocus="this.blur();">出勤管理</a>
	      <div id="dropmenu2" class="dropmenus">
	        <a class="stopnav" href="<%=urlPage%>rms/admin/kintai/listForm.jsp" onfocus="this.blur();">出勤管理</a>	          
	      </div>
	    </div>	    	  
	    <div id="cont3">
	      <a class="mtopnav" href="#" onclick="return false;" onmousedown="dropMenu3('dropmenu3')" onfocus="this.blur();">残業申請</a>
	      <div id="dropmenu3" class="dropmenus">	        
	        <a class="stopnav" href="<%=urlPage%>rms/admin/jangyo/listForm.jsp" onfocus="this.blur();">残業申請</a>	            
	      </div>
	    </div>	   
	    <div>
	      		<a class="mtopnav"  href="<%=urlPage%>rms/admin/schedule/monthForm.jsp" onfocus="this.blur();">日程管理</a>
	    </div>	    	    	  
<%}%>
			
	 </div> <!-- headermenusystem -->
	 <div id="headermenusystem_right">		  	    	  
	    	<div class="timeling"><img src="<%=urlPage%>rms/image/admin/icon_key.gif" align="absmiddle" border="0">
    			<%=id%>様の<font color="#CC6600">Login Time: </font><%=fmt.format(creationTime)%>
    		</div>
    	</div><!--headermenusystem_right -->    	 
    </div> <!-- headermenusystem_bg -->    
          
        <div class="clear"></div>        
    
    