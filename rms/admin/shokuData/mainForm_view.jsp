<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import = "mira.shokudata.FileMgr" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>


<%
String urlPage2=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");

if(id.equals("candy")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
int mseq=0; int grid=0; int levelVal=0; int bseq=0; int cateNo=0; 

MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}
		
//page권한
int pageArrow=0;
if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){ pageArrow=1;	}else{pageArrow=2;}	

FileMgr manaPg=FileMgr.getInstance();
CateMgr manager = CateMgr.getInstance();
int countPg=0;
if(pageArrow==2){
	countPg=manaPg.kindCnt(mseq);
	if(countPg==0){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
}
//대분류
 List listView=manaPg.selectPageGo(mseq);  //페이지 노출 여부
 List listMCate=manager.listMcate();

%>
<c:set var="listMCate" value="<%= listMCate %>" />
<c:set var="listView" value="<%= listView %>" /> 
<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">月報・週報開発/QMS<font color="#A2A2A2">&nbsp;>&nbsp;</font>メイン</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<%if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){%>	
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="職員閲覧可否決定" onClick="location.href='<%=urlPage2%>rms/admin/shokuData/viewMgr.jsp'">
	<%}%>
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage2%>rms/admin/shokuData/cateAddForm.jsp'">	
</div>
<div id="boxCalendar"  > 

<table width="960"  cellspacing="3" cellpadding="3" bgcolor="#F7F5EF">					
		<tr>
			<td  style="padding:5 0 5 10;" width="90%">						
				<table  border="0" cellpadding="2" cellspacing="2" width="100%">	
				<tr>
					<td align="left">				
	<font color="#339900">※</font> <font color="#807265"> 大項目に対してはアクセス制限がかかっているところがあります。解除する為には各部署の上長に承認がいりますのでご了承お願い致します。</font>
					</td> 
				</tr>     			      
				<tr>
					<td align="left">
	<font color="#339900">※</font> <font color="#807265"> システムを利用する際、システムのエラー、機能追加など提案があれば 管理者（張晶旭、juc@olympus-rms.co.jp / Tel: 078-335-5171）にメールか</font>
					</td>
				</tr>     			      
				<tr>
					<td align="left"  style="padding:0px 0px 0px 15px;">
	<font color="#807265">お電話で問合せして下さい。		(大項目は管理者にて追加できますのでご連絡下さい。)</font>
					</td>
				</tr>											
				</table>							
			</td>
			<td  style="padding:20 5 0 0;" width="10%" align="right">						
				<img src="<%=urlPage2%>rms/image/admin/bg_tab.jpg" align="absmiddle">
			</td>
		</tr>	
</table>
<div class="clear_margin"></div>	
<div class="box_170">							
<table width="700"   class="tablebox_fff" cellspacing="5" cellpadding="5">								
<%if( id.equals("juc0318") || id.equals("admin")){%>	
	<tr bgcolor="" height=26 >
		<td style="padding:5 10 5 5" align="center">	
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="     全体リストページ    " onClick="location.href='<%=urlPage2%>rms/admin/shokuData/listFormAll.jsp'"><br>
		</td>
	</tr>
						
<%}%>										
					
<tr bgcolor="" height=26 >
		<td style="padding:0 10 5 15" align="center"><br><br>	
					
<% if(pageArrow==1){%>		
		<c:if test="${! empty  listMCate}">	
				<% int im=1; int bseqq=0;
					Iterator listiterm=listMCate.iterator();					
						while (listiterm.hasNext()){
							Category catee=(Category)listiterm.next();
							bseqq=catee.getBseq();			
				%>		
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="     <%=catee.getName()%>      " onClick="location.href='<%=urlPage2%>rms/admin/shokuData/listForm.jsp?pg=<%=bseqq%>'"><br><br>		
					
				<%im++;}%>	
		</c:if>		
		<c:if test="${empty  listMCate}">
			-------------------- CATEGOGY 準備中 -------------------				
		</c:if>
	 
<%}else{%>			
		
	<c:if test="${empty listView}">				
				    	-------------------- CATEGOGY 準備中 ------------------- 			    		
	</c:if>			
	<c:if test="${! empty listView}">
	<%
	int i=1; int memView=0; int memCate=0;
	Iterator listiter2=listView.iterator();
		while (listiter2.hasNext()){				
			Category cateMem=(Category)listiter2.next();
			memView=cateMem.getMseq();
			memCate=cateMem.getCate_cnt();			
	%>	  
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="    <%=cateMem.getName()%>    " onClick="location.href='<%=urlPage2%>rms/admin/shokuData/listForm.jsp?pg=<%=cateMem.getBseq()%>'"><br><br>	
			
	<%
	i++;
	}												  													  
	%>	
	</c:if>	
<%}%>	
		&nbsp;
		</td>			  
	  </tr>  	
 </table>
 </div>