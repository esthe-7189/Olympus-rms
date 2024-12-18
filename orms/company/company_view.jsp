<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/error/error.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	

%>

<script type="text/javascript"> 
jQuery(document).ready(function(){
  jQuery("#slider").easySlider({ vertical: false, controlsBefore: '<div id="sliderControls">', controlsAfter: '</div>', auto: false, continuous: true});
          jQuery("a#previewLink05").fancybox({'hideOnContentClick': false,'frameWidth':950,'frameHeight':300});
          jQuery("a#previewLink04").fancybox({'hideOnContentClick': false,'frameWidth':950,'frameHeight':300});
          jQuery("a#previewLink03").fancybox({'hideOnContentClick': false,'frameWidth':950,'frameHeight':300});
          jQuery("a#previewLink02").fancybox({'hideOnContentClick': false,'frameWidth':950,'frameHeight':300});
         
  });
</script>
<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif">about company </p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu01.gif"></p>
		</div>
		
<!-- title end **********************************-->	
		<div id="content"> 		
			<!-- magazine -->
			<div class="magazine_top1">
				<h2 class="stitle"><img src="<%=urlPage%>images/company/company_mtitle.gif" alt="‘World Friends Korea’ Reaches Out as Korea's Unified Brand for Overseas Volunteers" /></h2>
				<ul class="quickPick" id="num_area">
					<li><a class="jumpBtn" alt="1"><img src="<%=urlPage%>images/company/no01_on.gif" class="jumpBtn" alt="会社案内" /></a></li>
					<li><a class="jumpBtn" alt="2"><img src="<%=urlPage%>images/company/no02.gif" class="jumpBtn" alt="ご挨拶" /></a></li>					
					<li><a class="jumpBtn" alt="3"><img src="<%=urlPage%>images/company/no03.gif" class="jumpBtn" alt="アクセス" /></a></li>
					<li><a class="jumpBtn" alt="4"><img src="<%=urlPage%>images/company/no04.gif" class="jumpBtn" alt="関連会社" /></a></li>
				</ul>
			</div>
			<div class="container">
				<div id="slider"> 
					<ul>
						<li>
							<div class="magazinebox_title">
								<p><img src="<%=urlPage%>images/company/company_stitle_box.gif" alt="挨拶"/></p>
								<dl>
									<dt><img src="<%=urlPage%>images/company/company_stitle01.gif" alt="aaa" /></dt>
									<dd>"次世代・成長産業として位置づけた生命工学" </dd>
								</dl>
							</div>
							<div class="magazinebox_con">
								<dl class="innovative01_con04">
									<dt class="areaL">
										<img src="<%=urlPage%>images/company/company_tab01.jpg" id="imgb" alt="" />										
									</dt>
									<dd class="areaR txt_style1">
										<img src="<%=urlPage%>images/company/company_intro.gif" alt="" />
									</dd>
								</dl>
							</div>
						</li>
						<li>							
							<div class="magazinebox_title">								
								<dl>
									<dt><img src="<%=urlPage%>images/company/company_stitle02.gif" alt="挨拶" /></dt>
									<dd>"社長メッセージ" </dd>									
								</dl>
							</div>							
							<div class="magazinebox_con">
								<dl class="innovative01_con04">
									<dt class="areaL">
										<img src="<%=urlPage%>images/company/img_tab04_left.gif" id="imgb" alt="挨拶" />										
									</dt>
									<dd class="areaR txt_style1">
										<span class="b">弊社は、オリンパス株式会社(日本)およびセウォン･セロンテック株式会社(韓国)が</span><br/>
										出資する合弁会社であり、再生医療分野における新規医療技術の事業化を目指しております。<br /><br /> 
										
										<span class="b">特に、軟骨を中心とした培養細胞製品を用いて</span><br/>
										患者さんのＱＯＬを向上させることに取り組んでおり、<br/>
										高い有効性および安全性を有した製品を提供することにより、<br/>
										従来治療に難渋していた疾患を克服できるものと確信しております。<br><br>										
											
										代表取締役社長　森山　剛　  
									</dd>
								</dl>										
							</div>		
									
						</li>						
						<li>
							<div class="magazinebox_title">												
								<dl>
									<dt><img src="<%=urlPage%>images/company/company_stitle04.gif" alt="aaa" /></dt>
									<dd><br><span class="b">＜所在地＞</span><br>
									神戸市中央区港島南町1-5-2 キメックセンタービル5F<br><br>
									<span class="b">＜交　通＞</span><br>											
									ＪＲ三ノ宮駅、地下鉄･阪急･阪神各三宮駅下車、ポートライナー神戸空港行きに乗車、
										先端医療センター前下車、改札(２Ｆ)出て右側へ、<br>
										正面右側が神戸キメックセンタービル(１Ｆコンビニ、２Ｆ和食レストラン)です。 </dd>
								</dl>
							</div>
							<div class="magazinebox_con">								
								<p class="txt_style1_line3 ">..</p>
								<p class="txt_style1_line c"><img src="<%=urlPage%>images/company/company_accese_box.gif" alt="" /></p>
							</div>							
						</li>
						<li>
							<div class="magazinebox_title">								
								<dl>
									<dt><img src="<%=urlPage%>images/company/company_stitle05.gif" alt="関連会社" /></dt>
									<dd>未来のための約束...　生命のための約束...</dd>
								</dl>
							</div>
							<div class="magazinebox_con">
								<dl class="innovative01_con04">									
									<p class="txt_style1_line c">	
										<a href="http://www.olympus.co.jp" target="_blank"><img src="<%=urlPage%>images/company/com_tab03_logo_0.gif" id="imgb" alt="http://www.olympus.co.jp" /></a><br /><br />									
										<a href="http://www.sewoncellontech.com" target="_blank"><img src="<%=urlPage%>images/company/com_tab03_logo_1.gif" id="imgb" alt="http://www.sewoncellontech.com" /></a>								
 									</p>
 									<p class="txt_style1_line3 c">	<img src="<%=urlPage%>images/company/company_04_con_img.jpg" alt="site images"  align="absmiddle"/></p>									
								</dl>
							</div>
						</li>
					</ul>
				</div>
			</div>
			
 
<!-- ####################### real_contents end####################### -->
		</div>	
<!-- //center_area end  ******************** -->
<hr />

