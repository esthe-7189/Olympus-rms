<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.news.NewsBean" %>
<%@ page import = "mira.news.NewsManager" %>

<%! static int PAGE_SIZE=3; %>
<%
String urlPage=request.getContextPath()+"/orms/";	

String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	

	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");

	List whereCond = null;
	Map whereValue = null;
	
	boolean searchCondTitle = false;	
	boolean searchCondView_ok=false;
	boolean searchCondView_no=false;

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("title")){
				whereCond.add("title LIKE '%"+searchKey+"%'");		
				searchCondTitle = true;
			}else if (searchCond[i].equals("view_ok")){
				whereCond.add("view_yn=1");		
				searchCondView_ok = true;
			}else if (searchCond[i].equals("view_no")){
				whereCond.add("view_yn=2");		
				searchCondView_no = true;
			}	
		}
	}

	NewsManager manager = NewsManager.getInstance();	
	int count = manager.count(whereCond, whereValue);
	int totalPageCount = 0; //전체 페이지 개수를 저장
	int startRow=0, endRow=0;
	if (count>0){
		totalPageCount=count/PAGE_SIZE;
		if (count % PAGE_SIZE > 0)totalPageCount++;
		
		startRow=(currentPage-1)*PAGE_SIZE+1;
		endRow=currentPage*PAGE_SIZE;
		if(endRow > count) endRow = count;
	}
	if(count<=0){
		startRow=startRow-0;
		endRow=endRow-0;
	}else if(count>0){
		startRow=startRow-1;
		endRow=endRow-1;
	}
	List  list=manager.selectList(whereCond, whereValue,startRow,endRow);	
	
%>
<c:set var="list" value="<%= list %>" />


	
<!-- title  begin***************************-->
<div id="title">
<!-- navi ******************************--> 
<p id="navi">::: <a href="<%=urlPage%>">Home</a> 
<img src="<%=urlPage%>images/common/overay.gif"/><a href="<%=urlPage%>news/newsList.jsp"> ニュース </a></p>
	
<p id="catetop" class="b fs14 l18 pad_t10 mb20"><a href="<%=urlPage%>news/newsList.jsp"><img src="<%=urlPage%>images/menu/menu_04.gif"></a></p>
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
<p><img src="<%=urlPage%>images/main/top_img_news.jpg" /></a>
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
<div class="titlebox"><h3>Title</h3>
</div>
</div>
<div class="inner" >	
<div class="subTwoColumn " >									
<ul class="column1">
	<li>
		<dl class="module">
			<dt >
				<b>NO DATA</b>
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

<!-- ***********box begin*************** -->
<div class="contentBox module productDirectory">	
<div class="topBarInactive">
<div class="titlebox"><h3>News</h3>
</div>
</div>
<div class="inner" >	
<div class="subTwoColumn " >


<c:forEach var="news" items="${list}">
	
<h3 class="f_blue_b_14 mb5  mt20">
<a id="" href="javascript:goRead('${news.seq}');" >${news.title}</a>
</h3>
<span class="date">
Friday, February 05, 2010
</span>	

</c:forEach>

<!-- *****************************page No begin******************************-->		
<c:set var="count" value="<%= Integer.toString(count) %>" />
<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />			
<p class="mb60 ">
<div class="pagingHolder module ">
	<span class="defaultbold">ページのナンバー :  </span>				
	<span >
<!-- ***********************************************************-->	
<c:if test="${count > 0}">
    <c:set var="pageCount" value="${count / PAGE_SIZE + (count % PAGE_SIZE == 0 ? 0 : 1)}" />
    <c:set var="startPage" value="${currentPage - (currentPage % 10) + 1}" />
    <c:set var="endPage" value="${startPage + 10}" />
    
    
    <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}" />
    </c:if>
    			
	<c:if test="${startPage > 10}">        	
			<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" ><<</a>		
    	</c:if>    	
        	
		
	<c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
        	<c:if test="${currentPage == pageNo}"><span class="active">${pageNo}</span></c:if>
        	<c:if test="${currentPage != pageNo}"><a href="javascript:goPage(${pageNo})" onfocus="this.blur()" >${pageNo}</a></c:if>        		
    	</c:forEach>
    					
	<c:if test="${endPage < pageCount}">        	
			<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" >>></a>		
    	</c:if>				
</c:if>			
	</span>				
</div>
<p class="mb20">
<!-- ************************page No end***********************************-->

</div>
</div>
<div class="bottom">
<div></div></div></div>
<!-- *************box end****************** -->
</c:if>																										
</div>	
<!-- right begin -->
<div class="subContent1 module"> 	
<jsp:include page="/orms/module/right_common.jsp" flush="false"/>
<p class="pad_t10"><a href=""><img src="<%=urlPage%>images/css_img/picture/biocollagen.jpg" alt="Boi Collagen" /></a></p>
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->	
</div> 
	
<form id="move" name="move" method="post">
    <input type="hidden" name="seq" value="">    
    <input type="hidden" name="page" value="${currentPage}">        
    <c:if test="<%= searchCondTitle%>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>
</form>	
		
<script language="JavaScript">
function goPage(pageNo) {
    document.getElementById("move").action = "<%=urlPage%>news/newsList.jsp";
    document.getElementById("move").page.value = pageNo;
    document.getElementById("move").submit();
}
function goRead(seq) {
    document.getElementById("move").action = "<%=urlPage%>news/news_item.jsp";
    document.getElementById("move").seq.value = seq;
    document.getElementById("move").submit();
}

</script>
