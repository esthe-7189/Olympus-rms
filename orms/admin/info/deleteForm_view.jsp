<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.info.InfoBean" %>
<%@ page import = "mira.info.InfoMgr" %>
<%@ page import = "java.util.*,java.text.*" %>


<%	
String urlPage=request.getContextPath()+"/orms/";	
String seq=request.getParameter("seq");
InfoMgr managerMain = InfoMgr.getInstance();		
InfoBean info=managerMain.getInfo(Integer.parseInt(seq));
%>
<c:set var="info" value="<%= info %>" />	


<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">関連情報管理
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
</table>	
<p>
<!-- 내용 시작 *****************************************************************-->
<c:if test="${empty info}">
	<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF" height="250">		
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">No DATA!!
			</td>
		</tr>	
	</table>	
</c:if>
<c:if test="${! empty info}">					  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF" >
	<form action="<%=urlPage%>admin/info/delete.jsp" method="post"  name="resultform"  >		
		<input type="hidden" name="seq" value="${info.seq}">						
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=30);">削除する</td>
			<td align="left" width="75%" style="padding-top:10px" ></td>
			<td align="right" width="10%" style="padding-right:30px;padding-top:10px" >
				<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/info/infoList.jsp'" id="List!"  title="List!" class="button buttonGeneral" />	
			</td>
		</tr>
		<tr>
			<td align="center" colspan="3" >						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2 height="200">
								<tr>
									<td  align="left" style="padding-left:150px"  width="15%" bgcolor="#F1F1F1" class="calendar7"><font color="#CC0000">※</font>
タイトル: <FONT COLOR="#CC3300">${info.title}</FONT><br>
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
			
			
			
			