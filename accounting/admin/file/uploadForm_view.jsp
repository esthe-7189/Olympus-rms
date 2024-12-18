<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("acc")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
MemberManager manager=MemberManager.getInstance();
Member member=manager.getMember(id);
%>
<c:set var="member" value="<%=member%>" />

<script type="text/javascript">
function goWrite(){
var frm=document.input;
if(isEmpty(frm.title, "タイトルを入力して下さい。!")) return ;
if(isEmpty(frm.fileNm, "ファイル選択して下さい。!")) return ;
if(isEmpty(frm.name, "お名前を入力して下さい。!")) return ;
if ( confirm("ファイルを登録しますか?") != 1 ) {	return ;}

 if ( confirm("登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>accounting/admin/file/upload.jsp";	
	frm.submit(); 
}

function goInit(){
	document.forminput.reset();
}
</script>

<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">経理・会計文書システム </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録 >>" onClick="location.href='<%=urlPage%>accounting/admin/file/uploadForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録 >>" onClick="location.href='<%=urlPage%>accounting/admin/file/listForm.jsp'">		
</div>	
<div id="boxNoLine_100"  >		
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >	ファイル情報
</label>		
		
	<table width="800"  class="tablebox" cellspacing="5" cellpadding="5" >
		<form name="input" action="<%=urlPage%>accounting/admin/file/upload.jsp" method="post"  enctype="multipart/form-data">		
		<input type="hidden" name="hit_cnt" value="0">
			<tr >
				<td width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルのタイトル:</td>
				<td><input type="text" maxlength="100" name="title" value="" class="input02" style="width:300px"><font color="#807265">(▷100文字以下)</font></td>
			</tr>
			<tr>	
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの選択:</td>
				<td><font color="#807265">(▷アップロードするファイル名に '&,%,^'などの記号は使わないで下さい!)</font>					
					<input  type='file' name="fileNm" size="80" class="file_solid"  >
					
				</td>
			</tr>	
			<tr>
				<td width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >アップロードする人のお名前:</td>
				<td><input type="text" maxlength="30" name="name" value="${member.nm}" class="input02" style="width:300px"><font color="#807265">(▷30文字以下)</font></td>
			</tr>
			<tr>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
				<td colspan="3">
					<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()" checked>Yes &nbsp;
					<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" >No
				</td>
			</tr>				
		</table>
						
<div class="clear_margin"></div>							
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >	コメント
</label>			
<table  width="800" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
		<tr>
			<td style="padding: 5 0 0 0" width="50%" >	
							
<textarea id="comment" name="comment" style="width:100%;height:200px;"></textarea>
<script type="text/javascript">
//<![CDATA[
CKEDITOR.replace( 'comment', {
	customConfig : '<%=urlPage%>ckeditor/config.js',   	
   	width: '100%',
   	height: '300px'
} );
//]]>
</script>								
															
			</td>							
	</tr>									 		
</table>
<table width="800"  cellspacing="5" cellpadding="5">
	<tr>
		<td align="center" style="padding:15px 0px 100px 0px;">
				<a href="JavaScript:goWrite();"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></A>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></A>
			</td>	
	</tr>	
</form>		
</table>

</div>



