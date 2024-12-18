<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
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

String seq_list = request.getParameter("seq_list");	
String seq_item = request.getParameter("seq_item");	
String filename = request.getParameter("filename");				
String kubun = request.getParameter("kubun");
%>
<div class="con_top_title" onmousedown="dropMenu()">	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">標準作業手順書(SOP) <font color="#A2A2A2">></font> 削除 <%=seq_list%>,,,<%=seq_item%></span> 
</div>
<div class="clear"></div>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/sop/cateAddForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録" onClick="location.href='<%=urlPage%>rms/admin/sop/listForm.jsp'">	
</div>
<div id="boxNoLine_850"  >		
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=60);">
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=30);">ファイル削除
</label>	
<table width="850"  class="tablebox" cellspacing="2" cellpadding="2">	
	<form name="memberInput" action="<%=urlPage%>rms/admin/sop/delete.jsp" method="post"  onSubmit="">													
		<input type="hidden" name="filename" value="<%=filename%>">	
		<input type="hidden" name="kubun" value="<%=kubun%>">	
		<input type="hidden" name="seq_list" value="<%=seq_list%>">	
		<input type="hidden" name="seq_item" value="<%=seq_item%>">									
		<tr>
			<td align="center"  class="titlename">						
				<font color="#CC0000">※</font>本当に<font color="#CC0000"><%=filename%></font>を削除しますか？									
				</td>
			</tr>
			<tr>
				<td align="center"  >上のファイルを削除すると <font color="#807265">ダウンロードされた情報も</font>一緒に削除されます。		</td>
			</tr>
	</table>
<table width="880"  cellspacing="5" cellpadding="5">
	<tr>
		<td align="center" style="padding:15px100px 100px 0px;">
	
			<input type="image"  style=cursor:pointer  src="<%=urlPage%>rms/image/admin/btn_jp_del.gif" onfocus="this.blur()">
			<a href="javascript:javascript:history.go(-1)" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_jp_x.gif"></a>
			
		</td>
	</tr>
</form>
</table>
</div>		
	


