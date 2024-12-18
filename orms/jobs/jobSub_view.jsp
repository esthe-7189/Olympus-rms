<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.job.Category" %>
<%@ page import = "mira.job.CateMgr" %>
<%@ page import = "mira.job.JobBean" %>
<%@ page import = "mira.job.JobMgr" %>

<%
String urlPage=request.getContextPath()+"/orms/";

CateMgr manager=CateMgr.getInstance();
List  list=manager.selectListAdminLevel(0,1);
List  list_2; 
JobMgr manager_job=JobMgr.getInstance();
List  list_3;
int bseq=0; int bseqM=0;
%>
<c:set var="list" value="<%= list %>" />
	

<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif"/> jobs </p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu_05.gif"></p>
		</div>
<!-- title end **********************************-->	
<!-- tpp images BEGIN -->
<div id="" class="contentBox BC_LeaderBoard">
<div class="softGrey">
<div class="top">
<div>
</div>
</div>
<div class="inner module">
<div id="" style="display: inline">
<center>
<span id="">advertisement</span><br />
</center>
</div>
<div>  <div id="flash_1953">
<p><img src="<%=urlPage%>images/main/top_img_jobs.gif" /></a>
</p>
</div>
 </div>
</div>
<div class="bottom">
<div>
</div>
</div>
</div>
</div>		
<!--tpp images end **********************************-->			
	
<!--parentTwoColumn start***************************** -->		
<div class="parentTwoColumn module">
<div class="mainContent module">

<c:if test="${empty list}">
<!-- ***********box begin*************** -->
<div class="contentBox module productDirectory">	
<div class="topBarInactive">
<div class="titlebox"><h3>Title </h3>
</div>
</div>
<div class="inner" >	
<div class="subTwoColumn " >									
<ul class="column1">
	<li>
		<dl class="module">
			<dt >
				<b>NO DATA !!</b>
			</dt>
			<dd>
				登録された内容がありません。
			</dd>													
		</dl>
	</li>															
</ul>
</div>
</div>
<div class="bottom">
<div></div></div></div>
<!-- *************box end****************** -->	
</c:if>
<c:if test="${! empty list}">
<%
int i=1;
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		Category cate=(Category)listiter.next();
		bseq=cate.getBseq();					
%>	  
<!-- ***********box begin*************** -->
<div class="contentBox module productDirectory">	
<div class="topBarInactive">
<div class="titlebox"><h3><%=cate.getName()%></h3>
</div>
</div>
<div class="inner" >	
<div class="subTwoColumn " >

<%
list_2=manager.selectListAdminLevel(bseq,2);
%>
<c:set var="list_2" value="<%= list_2 %>" />
<%
int i2=1;
Iterator listiter2=list_2.iterator();
	while (listiter2.hasNext()){				
		Category cate2=(Category)listiter2.next();
		bseqM=cate2.getBseq();
		String title=cate2.getName();
		if(title!=null){
			if(i2%2==1){			
%>	  										
<ul class="column1">	
<%}else{%>
<ul class="column2">
<%}%>
	<li>
		<dl class="module">
			<dt >
				<b><%=cate2.getName()%></b>
			</dt>
<%
list_3=manager_job.selectItemTitle(bseqM);
%>
<c:set var="list_3" value="<%= list_3 %>" />
<%
int i3=1;
Iterator listiter3=list_3.iterator();
	while (listiter3.hasNext()){				
		JobBean job=(JobBean)listiter3.next();
		int mseq=job.getCate_M_seq();
		String title3=job.getTitle();
		if(title3!=null){	
%>	
			<dd><img src="<%=urlPage%>images/bg/ol_icon01.gif" >
				<a href="javascript:goPage('<%=mseq%>','<%=cate.getName()%>','<%=cate2.getName()%>')" ><%=title3%> </a>	
			</dd>
<%}else{%>
<dd>準備中です</dd>
<%}				
i3++;
}												  													  
%>							
			
													
		</dl>
	</li>	
</ul>
<%}else{%>
<ul class="column1"><li><dl class="module"><dt><b>準備中です</b></dt></dl></li></ul>
<%}				
i2++;
}												  													  
%>										
		
	
</div>
</div>
<div class="bottom">
<div></div></div></div>
<!-- *************box end****************** -->
<%
i++;
}												  													  
%>	
</c:if>														
																												
</div>	
<!-- right begin -->
<div class="subContent1 module"> 	
<jsp:include page="/orms/module/right_common.jsp" flush="false"/>
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->	


</div> 

<form id="move" name="move" method="post">
    <input type="hidden" name="mseq" value="">    
    <input type="hidden" name="mtitle" value="">    
    <input type="hidden" name="ltitle" value="">    
</form>
	
<script language="JavaScript">
function goPage(mseq,ltitle,mtitle) {
    document.getElementById("move").action = "<%=urlPage%>jobs/job_item.jsp";
    document.getElementById("move").mseq.value = mseq;
    document.getElementById("move").ltitle.value = ltitle;
    document.getElementById("move").mtitle.value = mtitle;
    document.getElementById("move").submit();
}

</script>