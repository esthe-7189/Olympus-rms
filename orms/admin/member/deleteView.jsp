<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="/rms/error/error_common.jsp"%>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("home")){
%>			
	<jsp:forward page="/orms/template/tempMain.jsp">		    
		<jsp:param name="CSSPAGE1" value="/orms/home/home.jsp" />	
	</jsp:forward>
<%
	}
    String urlPage=request.getContextPath()+"/";
    String mseq =  request.getParameter("mseq"); 	 
    String member_id =  request.getParameter("member_id"); 	 
     
%>

<center>
<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>orms/images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>orms/images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">全会員リスト
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>	
</table>	

<p>
<!-- 내용 시작 *****************************************************************-->
<form action="<%=urlPage%>orms/admin/member/deleteOk.jsp" method="post">
<input type="hidden" name="mseq" value="<%= mseq%>">	
<input type="hidden" name="member_id" value="<%= member_id%>">	
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
          <td height="20" bgcolor="#f4f4f4"><img src="<%=urlPage%>rms/image/user/product_img02.gif" width="500" height="10"></td>
        </tr>
	 </table>
 </td>
 </tr>
 </table> 
</form>

