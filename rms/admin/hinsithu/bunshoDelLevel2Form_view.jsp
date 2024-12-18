<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.hinsithu.HinsithuBean" %>
<%@ page import="mira.hinsithu.HinsithuMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String fno = request.getParameter("fno");	
String file_kind = request.getParameter("file_kind");	
String bseq = request.getParameter("bseq");	
String parentId = request.getParameter("parentId");	

HinsithuMgr manager = HinsithuMgr.getInstance();
if(fno==null){ fno="0";}
HinsithuBean bunData=manager.getFile(Integer.parseInt(bseq));
String filename=bunData.getFilename();	
// int fileKind=bunData.getFile_kind();		

%>
<c:set var="bunData" value="<%= bunData %>" />
<c:if test="${! empty  bunData}" />
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">品質試験書QA <font color="#A2A2A2"> > </font> 削除 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/bunshoUploadForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="マニュアル" onClick="location.href='<%=urlPage%>rms/admin/file/bun_down.jsp?filename=orms20090223admin.ppt'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="データ出力(Excel)" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/listForm.jsp'">	
</div>

<div id="boxNoLine_850"  >		
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=60);">
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=30);">ファイル削除
</label>	
<table width="850"  class="tablebox" cellspacing="5" cellpadding="5">		
<form name="memberInput" action="<%=urlPage%>rms/admin/hinsithu/deleteLevel2.jsp" method="post"  >											
	<input type="hidden" name="fno" value="<%=fno%>">	
	<input type="hidden" name="file_kind" value="<%=file_kind%>">
	<input type="hidden" name="bseq" value="<%=bseq%>">
	<input type="hidden" name="parentId" value="<%=parentId%>">
	<tr>
	<td align="center" style="padding: 0 0 30 0" >	
	<table width="95%" height="160" border=0 cellpadding=0 cellspacing=0 bordercolor="#FFFFFF"  bordercolorlight="#A2A2A2"  class="c">
	<tr >		
		<td  style="padding: 3 0 3 5">	本当に<font color="#CC0000"><%=filename%></font>を削除しますか？</td>
	</tr>
	<tr>
		<td  style="padding: 3 0 3 5">
<c:choose>
	<c:when test="${param.file_kind=='2'}">			
		      	<img src="<%=urlPage%>rms/image/shop/order_denger.gif" >上のファイルを削除すると<font color="#807265">QAチェック本(OT) / PG完成本(PG)</font>のファイルも一緒に削除されます。	　	
	</c:when>
	<c:when test="${param.file_kind=='3'}">			
		      	<img src="<%=urlPage%>rms/image/shop/order_denger.gif" >上のファイルを削除すると<font color="#807265">最終完成本</font>のファイルも一緒に削除されます。
	</c:when>	
	<c:otherwise>
	    		&nbsp;
	</c:otherwise>
</c:choose>	
			
		</td>
	</tr>	
	</table>
	</td>
</tr>
</table>
<p>
<table width="880"  cellspacing="5" cellpadding="5">
	<tr>
		<td align="center" style="padding:5px100px 10px 0px;">
			<input type="image"  style=cursor:pointer  src="<%=urlPage%>rms/image/admin/btn_jp_del.gif" onfocus="this.blur()">
			<a href="javascript:javascript:history.go(-1)" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_jp_x.gif"></a>			
		</td>
	</tr>		
</form>				
</table>

</div>

