<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/error/error.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	

%>

				
<!--right tab menu end-->
<div id="" class="accordion module">		
<div class="contentBox featured module">
	<div id="" class="topBarInactive">
		<div class="titlebox">
			<h3>細胞治療剤とは？</h3>
		</div>
	</div>
	<div class="inner module imagesAndDescription">		
		<div class="subTwoColumn module imageAndDescriptionBg">			
			<p>
				細胞治療剤とは、細胞と組職の機能を修復させるために生きている自家(autologus)、同種(allogenic)、異種(xenogenic)細胞を体外で増殖や選別など、...		
			<br/><br/>
				<a id="" title="" href="<%=urlPage%>info/info_item.jsp?seq=9&mtitle=軟骨欠損 &ltitle=診断"  onfocus="this.blur();">read more</a>
			</p>
		
	</div>						
	</div>
	<div class="bottom"><div></div></div>
</div>		

<div id="" class="accordion module">		
<div class="contentBox featured module">
	<div id="" class="topBarInactive">
		<div class="titlebox">
			<h3>関節炎健康常識</h3>
		</div>
	</div>
	<div class="inner module imagesAndDescription twoBoxes">
		<h5>
			<a id="" title="" href="javascript:alert('工事中');"  onfocus="this.blur();">
		関節炎痛症を減らす生活守則</a>
								</h5>
								<div class="subTwoColumn module">
									<div class="column1">
										<a id="" title="" href="<%=urlPage%>info/info_item.jsp?seq=10&mtitle=健康常識&ltitle=関節炎関連"  onfocus="this.blur();">
										<img id="" title="" src="<%=urlPage%>images/test/kansetu01.gif" /></a>
									</div>
									<div class="column2">
										<p class="mr3">
1. 適当に運動をし、 規則的な生活をする。<br>
2. 硬いベッドで寝るが、 軽くて暖かい布団を覆って楽に睡眠を取る。<br>
3. 暑さ、寒さ、 湿り気などにすごく敏感なので細心な注意が必要。<br>
4. 性生活は無理しない範囲内にする。<br>
5. ひざまずいて正座する姿勢より椅子に座るほうが良い。...
											<br/><br/>
											<a id="" title="" href="<%=urlPage%>info/info_item.jsp?seq=10&mtitle=健康常識&ltitle=関節炎関連"  onfocus="this.blur();">read more</a>
										</p>
									</div>
								</div>					
						
	</div>
	<div class="bottom"><div></div></div>
</div>		
</div>		
<jsp:include page="/orms/module/rightEmail.jsp" flush="false"/>
