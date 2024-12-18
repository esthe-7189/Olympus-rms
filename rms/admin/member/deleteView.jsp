<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.member.MemberManagerException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String urlPage=request.getContextPath()+"/";
    String mseq =  request.getParameter("mseq"); 	 
    String member_id =  request.getParameter("member_id"); 	 
     
%>


<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">会員削除</span>
   <div class="clear_line_gray"></div>
<p>
<!-- 내용 시작 *****************************************************************-->
<form action="<%=urlPage%>rms/admin/member/deleteOk.jsp" method="post">
<input type="hidden" name="mseq" value="<%= mseq%>">	
<input type="hidden" name="member_id" value="<%= member_id%>">	
<center>
<div id="formBar">	
 <table  width="100%" border="0" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF" style="padding:20px 20px 20px 20px;">		
		 <tr>
			<td class="cho_01" style="padding:10px 20px 20px 10px;">
			<font color="#3366CC"><%=member_id%></font>様の情報を削除しますか？。　
			</td>
		</tr>		
		<tr>
			   <td height="1" colspan="2" background="<%=urlPage%>rms/image/user/product_bg.gif" style="padding:0 0 0 0;"></td>
		</tr>
		<tr>
			<td colspan=2   align="center"　style="padding:20 0 0 5;">
		<input type="image"  style=cursor:pointer  src="<%=urlPage%>rms/image/admin/btn_jp_del.gif"  onfocus="this.blur()">		
		<a href="javascript:javascript:history.go(-1)" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_jp_x.gif"></a>	
				
			</td>
		</tr>		
</table>
</div>
<!-- 내용 끝 *****************************************************************-->	
</center>
</form>

