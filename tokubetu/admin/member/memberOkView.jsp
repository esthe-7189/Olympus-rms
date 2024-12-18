<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page import = "java.sql.Timestamp" %>
	
<jsp:useBean id="member" class="mira.tokubetu.Member" >
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String ip_info=(String)request.getRemoteAddr();
String nm=member.getNm();	    
    
    MemberManager manager = MemberManager.getInstance();            
    Member memId=manager.idCh(member.getMember_id());
    
    if(memId==null ){
    	member.setRegister(new Timestamp(System.currentTimeMillis()) );
    	member.setIp_info(ip_info);
    	member.setLevel(2);
    	manager.insertMember(member);
%>

<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  <span class="calendar7">会員登録  <font color="#A2A2A2">></font> 登録完了</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>tokubetu/admin/member/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>tokubetu/member/writeForm.jsp'">			
</div>
<div id="boxNoLineBig"  >
	<div class="boxCalendar_80">			
<table width="800"  class="tablebox" cellspacing="5" cellpadding="5">
<!-- 내용 시작 *****************************************************************-->		
		 <tr>
			<td class="cho_01">
<font color="#3366CC"><%=nm%></font>様の会員登録が済みました。　<br>
システムに入るためには管理者からの許可が必要です。
			</td>
		</tr>		
		<tr>
			   <td height="1" colspan="2" background="<%=urlPage%>rms/image/user/product_bg.gif" style="padding:0 0 0 0;"></td>
		</tr>
		<tr>
			<td colspan=2   align="center"　style="padding:20 0 0 5;">
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="登録された情報を確認する" onClick="location.href='<%=urlPage%>tokubetu/admin/member/listForm.jsp'">		
			</td>
		</tr>		
</table>

 
 <!-- 내용 끝 *****************************************************************-->	
<%}else{%>
	<script language=javascript>			
		alert("もう使われているIDです。再び実行して頂ます。");
			history.go(-1);
	</script>
<%}%>