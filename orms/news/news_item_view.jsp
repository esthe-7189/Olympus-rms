<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.news.NewsBean" %>
<%@ page import = "mira.news.NewsManager" %>
<%

String urlPage=request.getContextPath()+"/orms/";	
String seq=request.getParameter("seq");
NewsManager manager = NewsManager.getInstance();	
NewsBean news=manager.select(Integer.parseInt(seq));
%>
<c:set var="news" value="<%=news%>"/>
	
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

<!-- ***********box begin*************** -->
<div class="contentBox module productDirectory">	
<div class="topBarInactive">
<div class="titlebox"><h3>NEWS</h3>
</div>
</div>
<div class="inner" >	
<div class=" " >								
<ul class="column1">
	<li>
		<dl class="module mb50">
			<dt class="f_blue_b mb12">
				<b>${news.title}</b>
			</dt>			
			<dd class="mb50">${news.content}</dd>
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
