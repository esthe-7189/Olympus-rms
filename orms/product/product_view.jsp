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

<%
String urlPage=request.getContextPath()+"/orms/";		
%>



<SCRIPT LANGUAGE="JavaScript">
function premier(n) {
    for(var i = 1; i < 4; i++) {
        obj = document.getElementById('premier'+i);        
        if ( n == i ) {
            obj.style.display = "block";                        
        } else {
            obj.style.display = "none";                       
        }
    }
}

</SCRIPT>
<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif"/> product </p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu_02.gif" align="absmiddle"></p>
		</div>
<!-- tpp images BEGIN -->
<div id="" class="contentBox BC_LeaderBoard">
<div class="softGrey">
<div class="top"><div></div></div>
<div class="inner module">
	<div id="" style="display: inline"><center><span id="">advertisement</span><br /></center></div>
	<div><div id="flash_1953"><p><img src="<%=urlPage%>images/main/top_img_gell_box.jpg" /></a></p></div></div>
</div>
<div class="bottom"><div></div></div>
</div>
</div>		
<!--tpp images end **********************************-->			
<!-- title end **********************************-->	
<div id="content">		
			<div id="tabs5">
				<ul>					                                
					<li><a href="javascript:goCate('1');">
						<span OnClick='premier(1);' OnMouseOver='this.style.cursor="hand";premier(1);' OnMouseOut='this.style.cursor="default"' id='premier_button1'>......自家軟骨細胞......</span></a></li>
					<li><a href="javascript:goCate('2');">
						<span OnClick='premier(2);' OnMouseOver='this.style.cursor="hand";premier(2);' OnMouseOut='this.style.cursor="default"' id='premier_button2'>.....コラーゲン......</span></a></li>
					<li><a href="javascript:goCate('3');">
						<span OnClick='premier(3);' OnMouseOver='this.style.cursor="hand";premier(3);' OnMouseOut='this.style.cursor="default"' id='premier_button3'>.....医療機器......</span></a></li>					
				</ul>
			<p class="join_title_tab"></p>								
			</div>	
			<div class="img_txt_list">
				<div id="tablayer">
					<span id='premier1' style='display:;'>
						<div class="product_con">	
						<!-- tab premier1 begin -->
						<jsp:include page="/orms/module/product_tab_cate01.jsp" flush="false"/>
						<!--tab premier1 end-->	
						</div>
					</span>	
					<span id='premier2' style='display:none;'>
						<div class="product_con">	
						<!-- tab premier2 begin -->
						<jsp:include page="/orms/module/product_tab_cate02.jsp" flush="false"/>
						<!--tab premier2 end -->	
						</div>																						      
					</span>
						<span id='premier3' style='display:none;'>
						<div class="product_con">	
						<!-- tab premier3 begin -->
						<jsp:include page="/orms/module/product_tab_cate03.jsp" flush="false"/>
						<!--tab premier3 end -->
						</div>																							      
					</span>										
				</div>			
			</div>								 
<!-- right begin -->
<div class="subPro01">
<div class="subContent1 module"> 	
<jsp:include page="/orms/module/right_common.jsp" flush="false"/>
<p class="pad_t10"><a href=""><img src="<%=urlPage%>images/css_img/picture/biocollagen.jpg" alt="Boi Collagen" /></a></p>
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->		
</div>
<hr />
<form name="moveCate" method="post">
    <input type="hidden" name="cate" value="">       
</form>

<script language="JavaScript">
function goCate(cate) {
    document.moveCate.action = "<%=urlPage%>product/sub_product.jsp";    
    document.moveCate.cate.value = cate;
    document.moveCate.submit();
}

</script>	