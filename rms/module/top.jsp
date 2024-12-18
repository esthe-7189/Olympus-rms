<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>

<%
String urlPage=request.getContextPath()+"/";	
String urlPageRms=request.getContextPath()+"/rms/home/home.jsp";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");

%>
<form name="move">
<div class="cat_menu_cont">
<ul>	
	 <%if(id !=null && kind !=null){
    		if(kind.equals("bun")){%>				
				<li ><a class="topnav"  href="<%=urlPageRms%>" onfocus="this.blur();"> ホーム</a></li>						
				<li><a class="topnav"  href="<%=urlPage%>rms/admin/admin_main.jsp" onfocus="this.blur();">グループウェア</a></li>					
	    <%}else if(kind.equals("acc")){%>			
				<li><a class="topnav"  href="<%=urlPageRms%>" onfocus="this.blur();"> ホーム</a></li>				
				<li><a class="topnav"  href="<%=urlPage%>accounting/admin/file/listForm.jsp" onFocus="this.blur()"> 会計システム</a></li>	
	    <%}else if(kind.equals("toku")){%>			
				<li><a class="topnav"  href="<%=urlPageRms%>" onfocus="this.blur();"> ホーム</a></li>				
				<li><a class="topnav"  href="<%=urlPage%>tokubetu/admin/file/listForm.jsp" onFocus="this.blur()"> 特別文書システム</a></li>
	    <%}else if(kind.equals("kaigi")){%>			
				<li><a class="topnav"  href="<%=urlPageRms%>" onfocus="this.blur();"> ホーム</a></li>				
				<li><a class="topnav"  href="<%=urlPage%>kaigi/admin/schedule/monthForm.jsp" onFocus="this.blur()"> 会議室予約システム</a></li>
         <%}else{%>
         		
         	 	       <li><a class="topnav"  href="<%=urlPageRms%>" onfocus="this.blur();"> ホーム</a></li>
				<li><a class="topnav"  href="javascript:goRms()" onfocus="this.blur()"> グループウェア</a></li> 
				<li><a class="topnav"  href="javascript:goAcc()" onfocus="this.blur()"> 会計システム</a></li>
				<li><a class="topnav"  href="javascript:goToku()" onfocus="this.blur()"> 特別文書システム</a></li>
				<li><a class="topnav"  href="javascript:goKaigi()" onfocus="this.blur()"> 会議室予約システム</a></li>
						   
 <% }}else{%>
 			
				<li><a class="topnav"  href="<%=urlPageRms%>" onfocus="this.blur();"> ホーム</a></li>
				<li><a class="topnav"  href="javascript:goRms()" onfocus="this.blur()"> グループウェア </a></li> 
				<li><a class="topnav"  href="javascript:goAcc()" onfocus="this.blur()"> 会計システム</a></li>
				<li><a class="topnav"  href="javascript:goToku()" onfocus="this.blur()"> 特別文書システム</a></li>
				<li><a class="topnav"  href="javascript:goKaigi()" onfocus="this.blur()"> 会議室予約システム</a></li>
 <%}%>	
		
 			
		<%if(id !=null && kind !=null){
	    		if(kind.equals("bun")){%>					
					<li><a class="topnav" href="<%=urlPage%>rms/member/logout.jsp" onfocus="this.blur();"> ログアウト</a></li>								
		    <%}else if(kind.equals("acc")){%>					
					<li><a class="topnav" href="<%=urlPage%>accounting/member/logout.jsp" onFocus="this.blur()"> ログアウト</a></li>				
		    <%}else if(kind.equals("toku")){%>						
					<li><a class="topnav" href="<%=urlPage%>tokubetu/member/logout.jsp" onFocus="this.blur()"> ログアウト</a></li>
		    <%}else if(kind.equals("kaigi")){%>						
					<li><a class="topnav" href="<%=urlPage%>kaigi/member/logout.jsp" onFocus="this.blur()"> ログアウト</a></li>				
	         <%}
	         }%>		
	 			
</ul>
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
function goKaigi() {
    document.move.action = "<%=urlPage%>kaigi/member/loginForm.jsp";    
    document.move.submit();
}
</script>




