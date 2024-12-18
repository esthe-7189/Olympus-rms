<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>

<%
String urlPage=request.getContextPath()+"/orms/";		
String pseq=request.getParameter("pseq");
ProductManager manager = ProductManager.getInstance();	
ProductBean product=manager.getProduct(Integer.parseInt(pseq));
%>
<c:set var="product" value="<%=product%>"/>
<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif"/> product </p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20">::: 製品情報 </p>
		</div>
		
<!-- title end **********************************-->	
	<div id="content">			
	<c:if test="${empty product}">
			<p class="join_title_tab">Title</p>				
			<div class="img_txt_list">
				<ul>																		
					<li class="con">
						<ol  class="noimg">
							<li class="content">Content</li>						
						</ol>
					</li>
				</ul>	
			</div>
	</c:if>
	<c:if test="${! empty product}">	
			<p class="join_title_tab">${product.title_m}</p>				
			<div class="img_txt_list">
				<ul>																		
					<li class="con">
						<ol  class="noimg">
							<li class="content">${product.content}</li>						
						</ol>
					</li>
				</ul>	
			</div>
	</c:if>
	</div>								 

									 
<!-- right begin -->
<jsp:include page="/orms/module/right_product.jsp" flush="false"/>
<!-- right end -->	
<hr />
