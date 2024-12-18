<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
<%@ page import = "java.sql.Timestamp" %>
	
<jsp:useBean id="member" class="mira.memberacc.Member" >
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

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
<center>
<table width="80%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="100%"  height="30" style="padding: 0 0 0 0"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">会員登録の完了　
    		</td>    	
	</tr>		
</table>

<p>
<!-- 내용 시작 *****************************************************************-->
	
<table width="100%" height="300" border="0" cellspacing="0" cellpadding="0">
	<tr><td align="center">
		<table width="500" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	              <td height="7"><img src="<%=urlPage%>rms/image/user/product_img01.gif" width="500" height="7"></td>
	            </tr>
	            <tr>
              	<td align="center" valign="top" bgcolor="E7DFCF" class="calendar7">
              		<table width="500" border="0" cellspacing="0" cellpadding="0">
		                <tr>
		                  <td height="21" bgcolor="F6F3EC" style="padding:0 0 0 15;"></td>
		                </tr>
		                <tr>
		                  <td align="center" bgcolor="F6F3EC"　style="padding:15 0 0 0;">
		            		<table width="450" border="0" cellspacing="0" cellpadding="0">
			                    <tr>
			                      <td><img src="<%=urlPage%>rms/image/user/product_img03.gif" width="450" height="4"></td>
			                    </tr>
			                    <tr>
			                      <td align="center" bgcolor="F0E8D8">
						<table width="450" border="0" cellpadding="5" cellspacing="0" bgcolor="#FFFFFF">
			                          <tr>
			                            <td width="100%" height="82" rowspan="4" style="padding:4 0 0 5;">
<!-- 내용 시작 *****************************************************************-->

 <table  width="100%" border="0" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF" >		
		 <tr>
			<td class="cho_01">
<font color="#3366CC"><%=nm%></font>様の会員登録が済みました。　<br>
文書システムに入るためには管理者からの許可が必要です。
			</td>
		</tr>		
		<tr>
			   <td height="1" colspan="2" background="<%=urlPage%>rms/image/user/product_bg.gif" style="padding:0 0 0 0;"></td>
		</tr>
		<tr>
			<td colspan=2   align="center"　style="padding:20 0 0 5;">
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="登録された情報を確認する" onClick="location.href='<%=urlPage%>accounting/admin/member/listForm.jsp'">		
			</td>
		</tr>		
</table>
<!-- 내용 끝 *****************************************************************-->	
			                            	</td>
		                            </tr>
		                      	</table>
		            		</td>
                    		</tr>
                    		<tr>
                      		<td><img src="<%=urlPage%>rms/image/user/product_img04.gif" width="450" height="5"></td>
                    		</tr>
                  	  </table>
    			</td>
                </tr>
              </table>
    	   </td>
        </tr>            
        <tr>
          <td height="10" bgcolor="#f4f4f4"><img src="<%=urlPage%>rms/image/user/product_img02.gif" width="500" height="10"></td>
        </tr>
	 </table>
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