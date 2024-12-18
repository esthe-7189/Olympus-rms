<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/error/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>

<%! static int PAGE_SIZE=8; %>
<%
String urlPage=request.getContextPath()+"/orms/";	
String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	
String cate="3";


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

<form name="move03" method="post">
    <input type="hidden" name="pseq" value="">       
    <input type="hidden" name="page" value="${currentPage}">    
</form>
	
					     
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
										<a href="javascript:goView03('${product.pseq}')">
										<img src="<%=urlPage%>images/product/${product.pimg}_sub.jpg" alt="${product.title_m}" title="${product.title_m}"  width="134" height="100" class="img_border"/></a>
									</li>										
									<li class="con">
										<ol >
											<li class="title"><a href="javascript:goView03('${product.pseq}')">${product.title_m}</a></li>												
											<li class="content">${product.title_s}</li>
											<li class="date"><fmt:formatDate value="${product.register}" pattern="yyyy-MM-dd" /></li>
											<li class="more"><a href="javascript:goView03('${product.pseq}')">read more</a></li>							
										</ol>
									</li>
								</ul>
					</c:if>	
					<c:if test="${empty product.pimg}">					    						
								<ul>																		
									<li class="con">
										<ol  class="noimg">
											<li class="title"><a href="javascript:goView03('${product.pseq}')">${product.title_m}</a></li>												
											<li class="content">${product.title_s}</li>
											<li class="date"><fmt:formatDate value="${product.register}" pattern="yyyy-MM-dd" /></li>
											<li class="more"><a href="javascript:goView03('${product.pseq}')">read more</a></li>							
										</ol>
									</li>
								</ul>
					</c:if>	
				</c:forEach>
			</c:if>	     																	
								<div class="paging_bg">
								<table cellspacing='0' cellpadding='0' align='center'><tr><td></td></tr></table>							
   <!-- *****************************page No end******************************-->	
							</div>												              
					    	
									 



<script language="JavaScript">
function goView03(pseq) {
    document.move03.action = "<%=urlPage%>product/item_product.jsp";    
    document.move03.pseq.value = pseq;
    document.move03.submit();
}

</script>