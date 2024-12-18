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
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif"/> <a href="<%=urlPage%>product/product.jsp">product </a>
	<img src="<%=urlPage%>images/common/overay.gif"/>
	<c:choose>
		<c:when test="${product.category==1}">
			自家軟骨細胞
		</c:when>
		<c:when test="${product.category==2}">
			collagen
		</c:when>
		<c:when test="${product.category==3}">
			医療機器
		</c:when>
		<c:otherwise>
			...
		</c:otherwise>
	</c:choose>
	</p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20  " > <a href="<%=urlPage%>product/product.jsp"><img src="<%=urlPage%>images/menu/menu_02.gif"></a> <img src="<%=urlPage%>images/common/title_jirusi.gif" align="absmiddle"/>
				<a href="<%=urlPage%>product/sub_product.jsp?cate=${product.category}">
				<c:choose>
					<c:when test="${product.category==1}"> 
						自家軟骨細胞
					</c:when>
					<c:when test="${product.category==2}">
						コラーゲン
					</c:when>
					<c:when test="${product.category==3}">
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
<p><img src="<%=urlPage%>images/main/top_img_gell_box.jpg" /></a>
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

<!-- ***********box begin*************** -->
<div class="contentBox module productDirectory">		
<div class="topBarInactive">	
<div class="titlebox">
<h3>
<c:choose>
<c:when test="${product.category==1}">
自家軟骨細胞
</c:when>
<c:when test="${product.category==2}">
コラーゲン
</c:when>
<c:when test="${product.category==3}">
医療機器
</c:when>
<c:otherwise>
...
</c:otherwise>
</c:choose>			
</h3>	
</div>
</div>
<div class="inner" >	
<div class=" " >
<c:if test="${!empty product}">									
<ul class="column1">
	<li>
		<dl class="module mb50">
			<dt class="f_blue_b mb12">
				<b>${product.title_m}</b>
			</dt>			
			<dd class="mb50">${product.content}			
			</dd>
			<dd><img src="<%=urlPage%>images/bg/ol_icon02.gif" >前のコンテンツ==></dd>
			<dd><img src="<%=urlPage%>images/bg/ol_icon02.gif" >次のコンテンツ==></dd>			
			<dd class="ml500">
<!--북마크툴begin***************************** -->			
	<div>
<!-- AddThis Button BEGIN -->
<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;username=xa-4b6dcacc02ef50f1">
<img src="http://s7.addthis.com/static/btn/v2/lg-bookmark-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=xa-4b6dcacc02ef50f1"></script>
<!-- AddThis Button END -->
	</div>		
<!--북마크툴 ***************************** -->					
				
			</dd>												
		</dl>
	</li>															
</ul>
</c:if>
<c:if test="${empty product}">
<ul class="column1">
	<li>
		<dl class="module mb50">
			<dt class="f_blue_b mb12">
				<b>No Data</b>
			</dt>			
			<dd class="mb50">...</dd>														
		</dl>
	</li>															
</ul>			
</c:if>			
</div>
</div>
<div class="bottom">
<div></div></div></div>
<!-- *************box end****************** -->	
																									
</div>	
<!-- right begin -->
<div class="subContent1 module"> 	
<jsp:include page="/orms/module/right_common.jsp" flush="false"/>
<p class="pad_t10"><a href=""><img src="<%=urlPage%>images/css_img/picture/biocollagen.jpg" alt="Boi Collagen" /></a></p>
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->	


</div> 	
	
	

