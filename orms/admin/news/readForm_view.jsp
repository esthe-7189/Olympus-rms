<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.news.NewsBean" %>
<%@ page import = "mira.news.NewsManager" %>

<%

String urlPage=request.getContextPath()+"/orms/";	
String seq=request.getParameter("seq");
NewsManager manager = NewsManager.getInstance();	
NewsBean news=manager.select(Integer.parseInt(seq));
%>
<c:set var="news" value="<%=news%>"/>
	
<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">ニュース管理
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
</table>	
<p>
<!-- 내용 시작 *****************************************************************-->
<c:if test="${empty news}">
	<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">DATA IS NOT!!
			</td>
		</tr>	
	</table>	
</c:if>
<c:if test="${! empty news}">				  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">						
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">
				<img src="<%=urlPage%>images/common/ArrowNews.gif">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=30);">内容</td>
			<td align="left" width="65%" style="padding-top:10px" ></td>
			<td align="right" width="10%" style="padding-right:1px;padding-top:10px" >
				<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/news/newsForm.jsp'" id="List!"  title="List!" class="button buttonGeneral" />	
			</td>
			<td align="right" width="10%" style="padding-right:30px;padding-top:10px" >								
				<input type="button" name="" value="書く" onclick="location.href='<%=urlPage%>admin/news/addForm.jsp'" id="Write!"  title="Write!" class="button buttonGeneral" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="4">						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>																					
								<tr>
									<td align="left" width="20%"  style="padding-left:10px"   bgcolor="#F1F1F1">
										<img src="<%=urlPage%>images/common/ArrowNews.gif" >タイトル</td>																	
									<td align="left"  width="80%"  style="padding-left:10px" colspan="3">${news.title}</td>
								</tr>										
								<tr>
									<td align="left"  width="20%" style="padding-left:10px"   bgcolor="#F1F1F1">
										<img src="<%=urlPage%>images/common/ArrowNews.gif" >ユーザーのページで見える</td>
									<td align="left"  width="50%" style="padding-left:10px">
										<c:if test="${news.view_yn==1}">はい</c:if>
										<c:if test="${news.view_yn==2}">いいえ</c:if>	
									</td>
									<td align="left"  width="10%" style="padding-left:10px"   bgcolor="#F1F1F1">
										<img src="<%=urlPage%>images/common/ArrowNews.gif" >DATE</td>
									<td align="left"  width="20%" style="padding-left:10px">
										<fmt:formatDate value="${news.register}" pattern="yyyy-MM-dd" />
									</td>																	
								</tr>			
					</table>
				</td>
			</tr>
	</table>
<p>
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
				<tr>
					<td bgcolor= "#F7F5EF" align="left"  style="padding-left:30px;padding-top:10px">
					<img src="<%=urlPage%>images/common/ArrowNews.gif" >詳しい内容
					</td>						
				</tr>				
				<tr>
					<td>											
						<table width="95%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>										
							<tr>
								<td style="padding-bottom:10px;padding-top:10px"  width="100%" bgcolor="#ffffff" align="left">${news.content}</td>							
							</tr>
						</table>
					</td>			
				</tr>									 		
</table>	
</c:if>			
			
			
			
			
			
			
			
			