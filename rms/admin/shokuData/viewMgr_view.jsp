<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<%		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	
MemberManager member=MemberManager.getInstance();
List listSign=member.selectListSchedule(1,6);

CateMgr cateMgr=CateMgr.getInstance();
List listMCate=cateMgr.listMcate();
Category cateDb;
%>
<c:set var="listSign" value="<%= listSign %>" />
<c:set var="listMCate" value="<%= listMCate%>"/>


<script type="text/javascript" >
	
function goWrite(){	
var frm = document.memberInput;	
	
	if ( confirm("登録しますか?") != 1 ) { return; }	
	
	frm.action = "<%=urlPage%>rms/admin/shokuData/memInsert.jsp";	
	frm.submit();

}

</script>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">月報・週報開発/QMS<font color="#A2A2A2">&nbsp;>&nbsp;</font>新規登録</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="開発会議&QMSデータメイン " onClick="location.href='<%=urlPage%>rms/admin/shokuData/mainForm.jsp'">		
	<%if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){%>			  
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="職員閲覧可否決定" onClick="location.href='<%=urlPage%>rms/admin/shokuData/viewMgr.jsp'">					
	<%}%>		
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/shokuData/cateAddForm.jsp'">
<div id="boxNoLineBig"  > 	
<table  width="98%" border="0" cellspacing="2" cellpadding="2" >								
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">  チェックされた方は下のページが閲覧できます。							
		</tr>	
</table>

<form name="memberInput" action="<%=urlPage%>rms/admin/shokuData/memInsert.jsp" method="post"  onSubmit="return goWrite(this)">	
<table width="98%"  class="tablebox_list" cellpadding="2" cellspacing="2" >	 	 
	<tr bgcolor="#eeeeee" align=center height=26>				
				<td><span class="titlename_e">Category</span></td>
				<td><span class="titlename_e">All Check</span></td>
				<td><span class="titlename_e">Names</span></td>
			</tr>
<c:if test="${! empty  listMCate}">	
	<% int im=1; int bseqq=0;
		Iterator listiter2=listMCate.iterator();					
			while (listiter2.hasNext()){
				Category catee=(Category)listiter2.next();
				bseqq=catee.getBseq();								
	%>
		
		<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""  height="22">	    	    
		<td width="10%"  align="left" class="clear_dot"><img src="<%=urlPage%>rms/image/icon_s.gif" ><%=catee.getName()%>:</td>
		<td width="3%"  align="center" class="clear_dot"><input type="checkbox" name="chkAll" value="chkBoxName<%=im%>" onFocus="this.blur();" onClick="javascript:allchked(<%=im%>);"></td>
		<td width="82%"  align="left" class="clear_dot">
		<c:if test="${! empty  listSign}">
				<%	int i=1; int dmseq=0; 
					Iterator listiter=listSign.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();	
						dmseq=mem.getMseq();						
						cateDb=cateMgr.getMem(dmseq,bseqq);																			
				%>	
					<%if(cateDb!=null ){%>
						<input type="checkbox" name="chkBoxName"  id="chkBoxName<%=im%>"  value="<%=mem.getMseq()%>,<%=bseqq%>" onFocus="this.blur();" checked	>					
					<%}else{%>	
						<input type="checkbox" name="chkBoxName"  id="chkBoxName<%=im%>"  value="<%=mem.getMseq()%>,<%=bseqq%>" onFocus="this.blur();" >
					<%}%><%=mem.getNm()%>
						
						<input type='hidden' name="bseq" value="<%=bseqq%>">
						<input type='hidden' name="mseq" value="<%=mem.getMseq()%>">	
				<%i++;}%>	
									
			</c:if>
			<c:if test="${empty listSign}">
				--
			</c:if>			
		</td>		
	</tr>
<%im++;}%>				
</c:if>		
</table>
<div class="clear_margin"></div>				  
<table  align="center" width="98%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">		
	<tr align="center">
			<td style="padding:0px 0px 15px 0px;"  >
				<a href="javascript:goWrite();"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></A>
				&nbsp;
				<a href="javascript:history.go(-1);"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>
</form>										
</table>
		
</div>


<script type="text/javascript">	
function allchked(cnt){
	var frm=document.memberInput;	
	var checkboxList = document.getElementsByName('chkAll'); 
	var chkBoxName = document.getElementsByName('chkAll'); 
	var cntint= eval(cnt)-1;	
	
	 for(var i=0; i<checkboxList.length; i++) { 
	  if(checkboxList[i].checked==true && cntint==i) { 	  	  	  	 
	  	  allcheck(chkBoxName[i].value); 		  	  
	  }else if(checkboxList[i].checked==false && cntint==i){	  	  
	  	  allclear(chkBoxName[i].value);
	  }
	 }

}

function allcheck(chkBoxName){	
	var checkboxSmall = document.getElementsByName(chkBoxName); 
	var chcount=0;
	var i=0;
	
	for(i=0; i< checkboxSmall.length;i++){
		chcount++;
	}

	if(chcount==0){
		checkboxSmall.checked=true;
	}else{
		for(i=0; i<checkboxSmall.length;i++){
			checkboxSmall[i].checked=true;
		}
	}
}	
function allclear(chkBoxName){		
		var checkboxSmall = document.getElementsByName(chkBoxName); 
		var chcount=0;
		var i=0;
		for(i=0; i< checkboxSmall.length;i++){
			chcount++;
		}
		if(chcount==0){
			checkboxSmall.checked=false;
		}else{
			for(i=0; i<checkboxSmall.length;i++){
				checkboxSmall[i].checked=false;
			}
		}
	}




</script>