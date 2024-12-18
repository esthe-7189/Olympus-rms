<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>	
<%@ page import="mira.acc.AccBean" %>
<%@ page import="mira.acc.AccMgr" %>
<%@ page import="mira.acc.AccDownMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.text.SimpleDateFormat" %>

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
String seq = request.getParameter("seq");	
AccMgr manager = AccMgr.getInstance();
if(seq==null){ seq="0";}
AccBean accBean=manager.getAcc(Integer.parseInt(seq));

%>
<c:set var="accBean" value="<%= accBean %>" />
<c:if test="${! empty  accBean}" />



<script type="text/javascript">
function goWrite(){
var frm=document.input;
if(isEmpty(frm.title, "タイトルを入力して下さい。!")) return ;
if(isEmpty(frm.name, "お名前を入力して下さい。!")) return ;
    if(frm.fileKind[0].checked==true){frm.fileNm.value="No";   }	  
    if(frm.fileKind[1].checked==true){ 
	  if(isEmpty(frm.fileNmVal, "ファイルを選択して下さい。!")) return ;  	        
	  else{ frm.fileNm.value="Yes";}	
	}	   	 
if ( confirm("修正しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>accounting/admin/file/modify.jsp";	
	frm.submit(); 	
}

</script>

<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">経理・会計文書システム <font color="#A2A2A2">></font> 修正</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録  >>" onClick="location.href='<%=urlPage%>accounting/admin/file/uploadForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録  >>" onClick="location.href='<%=urlPage%>accounting/admin/file/listForm.jsp'">		
</div>	
<div id="boxNoLine_100"  >		
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >	ファイル情報
</label>		
		
	<table width="800"  class="tablebox" cellspacing="5" cellpadding="5" >		
	<form name="input" action="<%=urlPage%>accounting/admin/file/modify.jsp" method="post" enctype="multipart/form-data" >				
		<input type="hidden" name="seq" value="<%=seq%>">
		<input type="hidden" name="fileNm" value=""> 	
			<tr>		
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルのタイトル:</td>
				<td><input type="text" maxlength="100" name="title" value="${accBean.title}" class="input02" style="width:300px"><font color="#807265">(▷100文字以下)</font></td>
			</tr>
			<tr   height=20>
				<td  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >既存ファイル名:</td>
				<td>${accBean.filename}</tr>
			<tr>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの変更:</td>
				<td>
					<input type="radio" onfocus="this.blur()"  name="fileKind" value="1"  onClick="selectFile()"  checked>No&nbsp;
					<input type="radio" onfocus="this.blur()"  name="fileKind" value="2"  onClick="selectFile()" >Yes 	<br>			
							<div id="file_01"  style="display:none;">									
								<table border=0 cellspacing=0 cellpadding=1>
									<tr>
										<td>
											<font color="#CC3333" width="82%">									
											▷アップロードするファイル名に '&,%,^'などの記号は使わないで下さい!
											</font><br>				
											<input type="file" name="fileNmVal" size="80" class="file_solid" >
										</td>
									</tr>						
								</table>
							</div>			
				</td>
			</tr>	
			<tr>
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >アップロードする人のお名前:</td>
				<td><input type="text" maxlength="30" name="name" value="${accBean.name}" class="input02" style="width:300px"><font color="#807265">(▷30文字以下)</font></td>
			</tr>
			<tr>
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
				<td colspan="3">
					<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()"  <%if(accBean.getView_yn()==0){%>checked<%}%>>Yes &nbsp;
					<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" <%if(accBean.getView_yn()==1){%>checked<%}%>>No				
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

<textarea id="comment" name="comment" style="width:100%;height:200px;">${accBean.comment}</textarea>
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

<script language="JavaScript">
var f=document.input;
var d=document.all;	

function selectFile(){		
	if (f.fileKind[0].checked==true)	{				
		d.file_01.style.display="none";		
	}else if (f.fileKind[1].checked==true)	{		
		d.file_01.style.display="";		
	}		
}
</script>