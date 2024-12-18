<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hitokoto.NewsBean" %>
<%@ page import = "mira.hitokoto.NewsManager" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%! SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");	%>
<%
String today=formatter.format(new java.util.Date());	
String urlPage=request.getContextPath()+"/";
String urlPageOrms=request.getContextPath()+"/orms/";	
String memberId=(String)session.getAttribute("ID");	
String nameWrot="";
Member member=null;
	if (memberId !=null){	
		MemberManager manager2=MemberManager.getInstance();
		member=manager2.getMember(memberId);
		nameWrot=member.getNm();		
	}
%>


<script type="text/javascript">
function goWrite(){
	var frm = document.resultform;	
	if(isEmpty(frm.title, "タイトルを書いて下さい!")) return;	
		
if ( confirm("登録しますか?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>rms/admin/hitokoto/add.jsp";	
frm.submit();		
}	
</script>



<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">管理者に一言 </span> 
<div class="clear_line_gray"></div>
<p>
<c:if test="${empty news}"/>
<div id="botton_position">		
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録 >>" onClick="location.href='<%=urlPage%>rms/admin/hitokoto/listForm.jsp'">
</div>	

<!-- 내용 시작 *****************************************************************-->
<table width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
	<tr  height=26>
    		<td  class="clear_dot">    	 
    			<img src="<%=urlPageOrms%>images/common/jirusi.gif"  align="absmiddle">  <span class="titlename">書く   </span>       	
    		</td> 
	</tr>	
</table>
	
<!-- 내용 시작 *****************************************************************-->
				  
<table width="80%" class="box_100" cellspacing="2" cellpadding="2" >	
	<form action="<%=urlPage%>rms/admin/hitokoto/add.jsp" method="post"  name="resultform"  >	
	<input type="hidden" name="view_yn" value="2">
	<input type="hidden" name="nm" value="<%=nameWrot%>">		
	<tr>
		<td align="left"  style="padding-left:10px;"  ><font color="#CC0000">※</font>タイトル</td>																	
		<td align="left"  style="padding-left:10px;"  >
				<input type="text" NAME="title"  value=""  maxlength="100"  class="input02" style="width:300px">
				<font color="#807265">(▷100字まで入力できます。)</font>
		</td>
	</tr>	
</table>	
<p>
<table width="80%" class="box_100" cellspacing="2" cellpadding="2" >		
	<tr>
		<td  align="left"  style="padding-left:10px"  >
			<font color="#CC0000">※</font>詳しい内容
		</td>											
	</tr>				
	<tr>
		<td>	
<textarea id="content" name="content" style="width:100%;height:200px;"></textarea>
<script type="text/javascript">
//<![CDATA[
CKEDITOR.replace( 'content', {
	customConfig : '<%=urlPage%>ckeditor/config.js',   	
   	width: '100%',
   	height: '300px'
} );
//]]>
</script>	
										
			</td>			
		</tr>									 		
</table>
<table align=center>									   
	<tr align="center">
			<td >
				<A HREF="JavaScript:goWrite()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif"></A>				
			</td>			
	</tr>
</form>
</table>			

			
			
			