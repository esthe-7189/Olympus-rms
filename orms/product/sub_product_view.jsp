<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>

<%! static int PAGE_SIZE=10; %>
<%
String urlPage=request.getContextPath()+"/orms/";	
String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	
String cate=request.getParameter("cate");;
    if(cate==null) cate="1";


	List whereCond = null;
	Map whereValue = null;
	
	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();	
	if(cate!=null){
		whereCond.add("cate="+Integer.parseInt(cate));		
	}

	ProductManager manager = ProductManager.getInstance();	
	int count = manager.countUser(whereCond, whereValue);
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
	List  list=manager.selectListUser(whereCond, whereValue,startRow,endRow);	
	
%>
<c:set var="list" value="<%= list %>" />


<form name="move01" method="post">
    <input type="hidden" name="pseq" value="">       
    <input type="hidden" name="page" value="${currentPage}">
    <input type="hidden" name="cate" value="<%=cate%>">           
</form>
<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif"/> <a href="<%=urlPage%>product/product.jsp">product </a>
	<img src="<%=urlPage%>images/common/overay.gif"/>
	<c:choose>
		<c:when test="${param.cate=='1'}">
			自家軟骨細胞
		</c:when>
		<c:when test="${param.cate=='2'}">
			collagen
		</c:when>
		<c:when test="${param.cate=='3'}">
			医療機器
		</c:when>
		<c:otherwise>
			...
		</c:otherwise>
	</c:choose>
	</p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20  " ><a href="<%=urlPage%>product/product.jsp"><img src="<%=urlPage%>images/menu/menu_02.gif" ></a> <img src="<%=urlPage%>images/common/title_jirusi.gif" align="absmiddle"/>
				<a href="<%=urlPage%>product/sub_product.jsp?cate=<%=cate%>">
				<c:choose>
					<c:when test="${param.cate=='1'}">
						自家軟骨細胞
					</c:when>
					<c:when test="${param.cate=='2'}">
						コラーゲン
					</c:when>
					<c:when test="${param.cate=='3'}">
						医療機器
					</c:when>
					<c:otherwise>
						...
					</c:otherwise>
				</c:choose>		
				</a>
			</p>
		</div>
		
<!-- title end **********************************-->	
<!-- tpp images BEGIN -->
<div id="maincontnet" class="contentBox BC_LeaderBoard">
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
<p><img src="<%=urlPage%>images/main/top_img_gell.jpg" /></a>
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
<div id="content">
<p class="join_title_tab"></p>				
<div class="img_txt_list"><div id="tablayer">
<!-- *****************************page No begin******************************-->			
<div class="paging_topbg"><p class="mb60  mt7"><div class="pagingHolder module ">
	
<c:set var="count" value="<%= Integer.toString(count) %>" />
<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
	<span class="defaultbold ml20">      ページのナンバー : </span>				
	<span >
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
</div><p class="mb20"></div>			
<!-- ************************page No end***********************************-->								
<div class="product_con">				     
			<c:if test="${empty list}">			
								<ul>																		
									<li class="con">
										<ol  class="noimg">
											<li class="title">登録された内容がありません。</li>												
											<li class="content">.....</li>
											<li class="date">0000,00,00</li>
											<li class="more">read more</li>							
										</ol>
									</li>
								</ul>								
			</c:if>
			<c:if test="${! empty list}">
				<c:forEach var="product" items="${list}">
					<c:if test="${!empty product.pimg}">					    						
								<ul>						
									<li class="s_img">										
										<a href="javascript:goView01('${product.pseq}')">
										<img src="<%=urlPage%>images/product/${product.pimg}_sub.jpg" alt="${product.title_m}" title="${product.title_m}"  width="134" height="100" class="img_border"/></a>
									</li>										
									<li class="con">
										<ol >
											<li class="title"><a href="javascript:goView01('${product.pseq}')">${product.title_m}</a></li>												
											<li class="content">${product.title_s}</li>
											<li class="date"><fmt:formatDate value="${product.register}" pattern="yyyy-MM-dd" /></li>
											<li class="more"><a href="javascript:goView01('${product.pseq}')">read more</a></li>							
										</ol>
									</li>
								</ul>
					</c:if>	
					<c:if test="${empty product.pimg}">					    						
								<ul>																		
									<li class="con">
										<ol  class="noimg">
											<li class="title"><a href="javascript:goView01('${product.pseq}')">${product.title_m}</a></li>												
											<li class="content">${product.title_s}</li>
											<li class="date"><fmt:formatDate value="${product.register}" pattern="yyyy-MM-dd" /></li>
											<li class="more"><a href="javascript:goView01('${product.pseq}')">read more</a></li>							
										</ol>
									</li>
								</ul>
					</c:if>	
				</c:forEach>
			</c:if>	 
</div>
<!-- *****************************page No begin******************************-->																										    											
<div class="paging_nobg"><p class="mb60 mt7"><div class="pagingHolder module ">
	<span class="defaultbold ml20">      ページのナンバー : </span>
	<span >
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
</div><p class="mb20"></div>		
<!-- ************************page No end***********************************-->										              
</div>				    	
</div>	
</div>
<!-- right begin -->
<div class="subPro02">
<div class="subContent1 module"> 	
<jsp:include page="/orms/module/right_common.jsp" flush="false"/>
<p class="pad_t10"><a href=""><img src="<%=urlPage%>images/css_img/picture/biocollagen.jpg" alt="Boi Collagen" /></a></p>
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->	
<div>
<hr />
<script language="JavaScript">
function goPage(pageNo) {
    document.getElementById("move01").action = "<%=urlPage%>product/sub_product.jsp";
    document.getElementById("move01").page.value = pageNo;
    document.getElementById("move01").page.value = <%=cate%>;
    document.getElementById("move01").submit();
}
function goView01(pseq) {
    document.getElementById("move01").action = "<%=urlPage%>product/item_product.jsp";    
    document.getElementById("move01").pseq.value = pseq;
    document.getElementById("move01").submit();
}

</script>	
	
