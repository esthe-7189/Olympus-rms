<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.product.ProductManager" %>
<%@ page import = "mira.info.CateMgr" %>
<%@ page import = "mira.news.NewsManager" %>
<%
String urlPage=request.getContextPath()+"/orms/";	
ProductManager manager = ProductManager.getInstance();	
List  list01=manager.selectMainSpecial(1,7);	//cate, 출력갯수
List  list02=manager.selectMainSpecial(2,7);	

CateMgr managerInfo=CateMgr.getInstance();
List list_info=managerInfo.selectMainSpecialInfo(1,7); //레벨, 출력갯수

NewsManager managerNews=NewsManager.getInstance();
List list_news=managerNews.selectMainSpecialNews(7); //출력갯수
	
%>
<c:set var="list01" value="<%= list01 %>" />
<c:set var="list02" value="<%= list02 %>" />	
<c:set var="list_info" value="<%= list_info %>" />
<c:set var="list_news" value="<%= list_news %>" />
	
<!-- tpp images BEGIN -->
<div id="maincontnet" class="contentBox Main_LeaderBoard">
<div class="softGrey">
<div class="inner module">
<div id="" style="display: inline">
<center>
<span id="">advertisement</span><br />
</center>
</div>
<div>  
	<div align="center" style="padding-top:0px;padding-left:0px;">
		<script type="text/javascript">
		/**
			@param1 : path 	= 플래시 파일경로
			@param2 : id 	= 플래시 아이디
			@param3 : width 	= 너비
			@param4 : height 	= 높이
			@param5 : wmode 	= 배경모드
			@param6 : bgcolor 	= 배경색
			@param7 : scale 	= 스케일
			@param8 : quality 	= 품질
		**/
		inserFlash("RotateCube.swf", "objFlash", "986", "315");
 	</script>	
	</div>
 </div>
</div>

</div>
</div>
<!--tpp images end **********************************-->	
<!--parentTwoColumn start***************************** -->		
<div id="maincontnet02" class="parentTwoColumn module">
<div class="mainContent module">
<!-- ************************************ -->
<div class="subTwoColumn module">
	<div class="column1">		
		<div class="contentBox featured module">
			<div id="" class="topBarInactive">
				<!-- can also be topBarActive -->
				<div class="titlebox">
					<h3>
						Best Product
					</h3>
				</div>
			</div>
			<div id="" class="">
				<!-- can also be highlight -->
				<div class="inner module imageAndDescription">
					<h5>
						<a id="" title="Sewon Cellontech" href="javascript:goView('2');">オリジナル..アテロコラーゲン濃縮液</a>
					</h5>
					<div class="subTwoColumn module">
						<div class="column1">
							<a id="" title="Sewon Cellontech" href="javascript:goView('2');">
							<img id="" title="Sewon Cellontech" src="<%=urlPage%>images/test/fill_img01.jpg" /></a>
						</div>
						<div class="column2">
							<p>
								ノボフィルは肌のハリ不足へ集中的にケアして欠損された皮膚組織に健康を与え、再生できるように導きます。								
							<br/><br/>
								<a id="" title="Sewon Cellontech" href="javascript:goView('2');">read more</a>
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
		
	</div><div class="column2">		
		<div class="contentBox featured module">
			<div id="" class="topBarInactive">
				<!-- can also be topBarActive -->
				<div class="titlebox">
					<h3>
						Focus
					</h3>
				</div>
			</div>
			<div id="" class="">
				<!-- can also be highlight -->
				<div class="inner module imageAndDescription">
					<h5>
						<a id="" title="Sewon Cellontech" href="javascript:goView('6');">自家軟骨細胞(開発コードCCI)とは？</a>
					</h5>
					<div class="subTwoColumn module">
						<div class="column1">
							<a id="" title="Sewon Cellontech" href="javascript:goView('6');">
							<img id="" title="Sewon Cellontech" class="generalBorder" src="<%=urlPage%>images/test/testmainsub01.jpg"/></a>
						</div>
						<div class="column2">
							<p>
								自家組織由来の軟骨細胞培養物である自家軟骨細胞は余り使わない患者の元気な軟骨組織を体外に取り出し、 ...
							<br/><br/>
								<a id="" title="Sewon Cellontech" href="javascript:goView('6');">read more</a>
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
								
	</div></div>	
	
<!-- ************************************ -->
<div class="contentBox ">
<div class="topBarInactive"><div class="titlebox"><h3>Special Menu </h3></div></div>
<div class="inner module imagesAndDescription">		<div class="mainOneColum  module imageAndDescriptionMainSpecial">
								<div class="subTwoColumn  " >									
									<ul class="column1">
											<li>
												<dl class="module ">
												<dt >
													自家軟骨細胞(開発コードCCI)
												</dt>
								<c:if test="${empty list01}">			
													<dd>
														No Data!! 
													</dd>						
								</c:if>
								<c:if test="${! empty list01}">
									<c:forEach var="product" items="${list01}">														    						
													<dd>
<a  onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')"  href="javascript:goView('${product.pseq}');"  onfocus="this.blur();">
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>  ${product.title_m}</a>	
													</dd>
									</c:forEach>
								</c:if>	 																		
																							
												</dl>
											</li>															
											<li>
												<dl class="module ">
												<dt >
													アテロコラーゲン(COLLAGEN)
												</dt>
								<c:if test="${empty list02}">			
													<dd>
														No Data!! 
													</dd>						
								</c:if>
								<c:if test="${! empty list02}">
									<c:forEach var="product" items="${list02}">														    						
													<dd>
<a  onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" href="javascript:goView('${product.pseq}');"  onfocus="this.blur();">
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>  ${product.title_m}</a>	
													</dd>
									</c:forEach>
								</c:if>	 																		
																							
												</dl>
											</li>																							
											</ul>
											<ul class="column2">											
											<li>
												<dl class="module">
												<dt>
													関連情報
												</dt>
									<c:if test="${empty list_info}">			
													<dd>
														No Data!! 
													</dd>						
									</c:if>
									<c:if test="${! empty list_info}">
										<c:forEach var="info" items="${list_info}">														    						
														<dd>
<a  onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" href="<%=urlPage%>info/infoSub.jsp"  onfocus="this.blur();">
															<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>  ${info.name}</a>	
														</dd>
										</c:forEach>
									</c:if>	 															
												</dl>
											</li>					
											<li>
												<dl class="module">
												<dt>
													ニュースリリーズ
												</dt>
									<c:if test="${empty list_news}">			
													<dd>
														No Data!! 
													</dd>						
									</c:if>
									<c:if test="${! empty list_news}">
										<c:forEach var="info" items="${list_news}">														    						
														<dd>
															<a  onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')" href="<%=urlPage%>news/news_item.jsp?seq=${info.seq}"  onfocus="this.blur();">
															<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>  ${info.title}</a>	
														</dd>
										</c:forEach>
									</c:if>	 												
												</dl>
											</li>	
											</ul>
										</div>
									</div>
								</div>
					<div class="bottom"><div></div></div>
		</div><!-- ******************************************* -->
		<div class="contentBox module productDirectory">
<div class="topBarInactive"><div class="titlebox"><h3>ACT(自家組織由来の軟骨細胞移植術)関連論文 </h3></div></div>
<div class="inner module imagesAndDescription">		<div class="mainOneColum  module imageAndDescriptionMain">
								<div class="subTwoColumn  " >									
									<ul class="column1">
											<li>
												<dl class="module ">
												<dt >
													<a  onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')"  href="javascript:alert('工事中');"  onfocus="this.blur();">2003年 論文</a>
												</dt>																			    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Peterson L. などの報告
													</dd>																														    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Yates JW Jr. などの報告
													</dd>														    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Lindahl A. などの報告
													</dd>															    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Bentley G. などの報告
													</dd>	
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年  Jurvelin JS. などの報告
													</dd>																														    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Briggs TW. などの報告
													</dd>														    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Henderson IJ. などの報告
													</dd>															    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Bentley G. などの報告
													</dd>								
												</dl>
											</li>													
										</ul>
										<ul class="column2">											
											<li>
												<dl class="module">
												<dt >
													<a  onMouseover="highlight(this,'#F0F0F0')" onMouseout="highlight(this,'')"  href="javascript:alert('工事中');"  onfocus="this.blur();">2003年 論文</a>
												</dt>																			    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Peterson L. などの報告
													</dd>																    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Peterson L. などの報告
													</dd>																		    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Peterson L. などの報告
													</dd>																	    						
													<dd>
														<img src="<%=urlPage%>images/bg/sign_icon01.gif" align="absmiddle"/>2003年 Peterson L. などの報告
													</dd>												
												</dl>
											</li>																				
											</ul>
										</div>
								</div></div>
					<div class="bottom"><div></div></div>
		</div><!-- ******************************************* -->																												
	</div><!--mainContent end***************************** -->	
<!-- right begin -->
<div class="subContent1 module"> 	
<jsp:include page="/orms/module/right_common.jsp" flush="false"/>
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->	

</div> 
<form name="move01" method="post">
    <input type="hidden" name="pseq" value="">              
</form>
<script language="JavaScript">
function goView(pseq) {
    document.move01.action = "<%=urlPage%>product/item_product.jsp";    
    document.move01.pseq.value = pseq;
    document.move01.submit();
}
function goView_info(pseq) {
    document.move01.action = "<%=urlPage%>product/item_product.jsp";    
    document.move01.pseq.value = pseq;
    document.move01.submit();
}
</script>	
	
	
	
	
	
	
	
	
	
	