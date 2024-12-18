<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>

<%
String urlPage=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");

String kind=(String)session.getAttribute("KIND");
String inDate=dateFormat.format(new java.util.Date());

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}

int mseq=0; String name="";
MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
		 name=member.getNm();
	}

%>

	
<script language="javascript">
function formSubmit(){        
  var frm = document.forminput;	 
   if(isEmpty(frm.filenm, "ファイルを入力して下さい")) return ; 	
   if(frm.title.value==""){ 	frm.title.value="."; }		 	
	 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>rms/admin/form/add.jsp";	
	frm.submit(); 
 }   

function goInit(){
	document.forminput.reset();
}
</script>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">各種文書フォーム <font color="#A2A2A2">></font> 新規登録</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>rms/admin/form/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>rms/admin/form/addForm.jsp'">			
</div>
<div id="boxNoLine_900"  >	

<table  width="920" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">								
		<tr>
			<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" width="9" height="9" align="absmiddle">情報入力				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
			</td>			
		</tr>	
</table>		
<table width="920"  class="tablebox" cellspacing="5" cellpadding="5">				
	<form name="forminput" method=post  action="<%=urlPage%>rms/admin/gmp/add.jsp" enctype="multipart/form-data">		
		<input type="hidden" name="mseq" value="<%=mseq%>"> 		
	<tr height="22">	
		<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">お名前</span></td>
		<td width="85%" align="left"><input type=text size="15" class="input02"  name="nm" maxlength="30" value="<%=name%>"></td>			
	</tr>
	<tr height="22">
		<td><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">タイトル</span></td>
		<td align="left"><input type=text size="60" class="input02"  name="title" maxlength="100"></td>
	</tr>					
	<tr height="22">	
		<td><font color="#CC0000">※</font><span class="titlename">ファイル</span></td>
		<td align="left"><input type="file" size="80"  name="filenm" class="file_solid"></td>		
	</tr>
</table>	
<div class="clear_margin"></div>						
<table  width="920" >												
	<tr>				
			<td align="center" style="padding:15 0 100 0;">
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  登録する  >>" onClick="formSubmit();">						
				&nbsp;
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  取り消し  >> " onClick="goInit();">
				
			</td>			
	</tr>
</form>				
</table>	
					
			

			