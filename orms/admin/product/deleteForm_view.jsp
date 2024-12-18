<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>
<%@ page import = "java.util.*,java.text.*" %>
<%! SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");%>	

<%
String today=formatter.format(new java.util.Date());	
String urlPage=request.getContextPath()+"/orms/";	
int pseq = Integer.parseInt(request.getParameter("pseq"));

    ProductManager manager = ProductManager.getInstance();
    ProductBean product = manager.getProduct(pseq);
%>
<c:set var="product" value="<%= product %>" />	


<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">製品情報管理
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
</table>	
<p>
<!-- 내용 시작 *****************************************************************-->
<c:if test="${empty product}">
	<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF" height="250">		
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">DATA IS NOT!!
			</td>
		</tr>	
	</table>	
</c:if>
<c:if test="${! empty product}">					  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF" >
	<form action="<%=urlPage%>admin/product/delete.jsp" method="post"  name="resultform"  >		
		<input type="hidden" name="pseq" value="${product.pseq}">						
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=30);">削除する</td>
			<td align="left" width="75%" style="padding-top:10px" ></td>
			<td align="right" width="10%" style="padding-right:30px;padding-top:10px" >
				<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/product/product.jsp'" id="List!"  title="List!" class="button buttonGeneral" />	
			</td>
		</tr>
		<tr>
			<td align="center" colspan="3" >						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2 height="200">
								<tr>
									<td  align="left" style="padding-left:150px"  width="15%" bgcolor="#F1F1F1" class="calendar7"><font color="#CC0000">※</font>
	区分:<FONT COLOR="#CC3300">
		<c:if test="${product.category==1}">Chondron</c:if>
		<c:if test="${product.category==2}">Collagen</c:if>
		<c:if test="${product.category==3}">医療機器</c:if></FONT><br>
	メイン　タイトル: <FONT COLOR="#CC3300">${product.title_m}</FONT><br>
	上の内容を削除しましょうか？
									</td>
								</tr>								
					</table>
				</td>
			</tr>
	</table>
	<p>		
	
<table align=center>									   
	<tr align="center">
			<td >
				<input type="image"  style=cursor:pointer  src="<%=urlPage%>images/common/btn_off_submit.gif"  onfocus="this.blur()">		
				<a href="javascript:javascript:history.go(-1)" onfocus="this.blur()"><img src="<%=urlPage%>images/common/btn_off_cancel.gif"></a>		
			</td>			
	</tr>
</form>
</table>			

</c:if>			
			
			
			
			