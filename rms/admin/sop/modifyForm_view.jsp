<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
if(id==null){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";	
String urlPagemain=request.getContextPath()+"/";	
String seq=request.getParameter("seq");

AccMgr manager = AccMgr.getInstance();
if(seq==null){ seq="0";}
AccBean accBean=manager.getAcc(Integer.parseInt(seq));

MemberManager memManager=MemberManager.getInstance();
Member mem=memManager.getMember(id);
AccMgr tabmgr=AccMgr.getInstance();
	AccBean accTab;
	int nametab=0;
List listTab=tabmgr.listTab();
int tab_count=tabmgr.tabCnt();
List listFileItem=manager.listFileItem(Integer.parseInt(seq));																
%>
<c:set var="listFileItem" value="<%=listFileItem %>" />
<c:set var="mem" value="<%= mem %>" />
<c:set var="listTab" value="<%=listTab %>" />
<c:set var="accBean" value="<%= accBean %>" />
<c:if test="${! empty  accBean}" />

<script language="javascript">

function contentWite(){
  var frm = document.formContent;   	   
       if(isEmpty(frm.cate_nm, "手順書NOを入力して下さい")) return ;        
	 if(isEmpty(frm.title, "タイトルを入力して下さい")) return ;
	 if(isEmpty(frm.name, "お名前を入力して下さい。!")) return ;

	 if(frm.cateKind[0].checked==true){frm.seq_tab.value=frm.seq_tabVal.value;   }	  
       if(frm.cateKind[1].checked==true){ 
	   if(isEmpty(frm.seq_tab, "タブ(TAB)を選択して下さい。!")) return ;  	        	   		
	}
	   	 
         	
  	 if ( confirm("上の内容を修正しますか?") != 1 ) { return; }	
	 frm.action = "<%=urlPage%>rms/admin/sop/modify.jsp";	
	 frm.submit();
}

function goInit(){
	var frm = document.formContent;
	frm.reset();
}

</script>	
<script type="text/javascript">
function FCKeditor_OnComplete( editorInstance )
{
	window.status = editorInstance.Description ;
}
</script>
<div class="con_top_title" onmousedown="dropMenu()">	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">標準作業手順書(SOP)<font color="#A2A2A2">></font>修正</span> 
</div>
<div class="clear"></div>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/sop/cateAddForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録" onClick="location.href='<%=urlPage%>rms/admin/sop/listForm.jsp'">
</div>

<div class="boxCalendar_80">		
<table width="800"  cellspacing="2" cellpadding="2">							
	<tr>
		<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar9">
		<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">ファイルの情報<br></td>			
	</tr>	
</table>				

<table width="800" class="tablebox"   cellspacing="3" cellpadding="3" >	
	<form name="formContent" action="<%=urlPage%>rms/admin/sop/modify.jsp" method="post"  onSubmit="return contentWite(this)">				
		<input type="hidden" name="seq" value="<%=seq%>">		
		<input type='hidden' name="seq_tabVal" value="${accBean.seq_tab}">	
	<tr   height=20 align="left">
		<td  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >既存タブ(TAB)名:</td>
		<td>	
	<% nametab=accBean.getSeq_tab();
		accTab=tabmgr.getTab(nametab);
	%>
		<%=accTab.getName_tab()%>	
				</td>
			<tr align="left">
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >タブ変更:</td>
				<td>
					<input type="radio" onfocus="this.blur()"  name="cateKind" value="1"  onClick="selectCate()"  checked>No&nbsp;
					<input type="radio" onfocus="this.blur()"  name="cateKind" value="2"  onClick="selectCate()" >Yes<br>
							<div id="file_02"  style="display:none;">									
								<table border=0 cellspacing=0 cellpadding=1>
									<tr>
										<td>
<table  width="100%" border="0" cellspacing="0" cellpadding="0" >	
    <tr>
    	<td bgcolor="#F7F5EF" style="padding:2 0 5 50;">   
    		<select  name="seq_tab">
    			<option value="">選択して下さい</option>
    <c:if test="${empty listTab}">
		<option value="">No Data</option>
	</c:if>	
    <c:if test="${! empty listTab}">
		<c:forEach var="tab" items="${listTab}" varStatus="idx" >
			<option value="${tab.seq_tab}">${tab.name_tab}</option>				
		</c:forEach>
	</c:if>				
	       </select>
        </td>
    </tr>    
 </table>										
											
										</td>
									</tr>						
								</table>
							</div>			
				</td>
			</tr>	
			<tr align="left">
				<td  width="25%"><img src="<%=urlPage%>rms/image/icon_s.gif" >手順書番号:</td>
				<td><input type="text" maxlength="50" name="cate_nm" value="${accBean.cate_nm}" class="input02" style="width:300px"><font color="#807265">(▷50文字以下)</font></td>
			</tr>
			<tr align="left">
				<td  width="25%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルのタイトル:</td>
				<td><input type="text" maxlength="100" name="title" value="${accBean.title}" class="input02" style="width:300px"><font color="#807265">(▷100文字以下)</font></td>
			</tr>			
			<tr align="left">
				<td  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >登録者:</td>
				<td><input type="text" maxlength="30" name="name" value="${accBean.name}" class="input02" style="width:300px"><font color="#807265">(▷30文字以下)</font></td>
			</tr>
			<tr align="left">
				<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
				<td colspan="3">
					<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()"  <%if(accBean.getView_yn()==0){%>checked<%}%>>Yes &nbsp;
					<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" <%if(accBean.getView_yn()==1){%>checked<%}%>>No
				</td>
			</tr>				
			<tr align="left">	
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >コメント:</td>
				<td><textarea  name="content" cols="75" rows="2">${accBean.content}</textarea></td>
			</tr>
				
			<tr  align="left"  height=20>
				<td  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >既存ファイル名:</td>
				<td>
	<c:if test="${empty listFileItem}">
		<c:if test="${accBean.filename=='Data'}">--</c:if>		
		<c:if test="${accBean.filename!='Data'}">${accBean.filename}</c:if>					
	</c:if>			
	<c:if test="${!empty listFileItem}">	
		<c:forEach var="item" items="${listFileItem}" varStatus="idx">								
					${item.filename}<br>
		</c:forEach>									
	</c:if>							
				
	</tr>			
</table>
<div class="clear_margin"></div>												
<table  width="100%" border="0" cellspacing="0" cellpadding="0" >									   
	<tr align="center">
			<td style="padding-top:0px;">								
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  修正する  >>" onClick="contentWite();">						
				&nbsp;
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  取り消し  >> " onClick="goInit();">								
			</td>		
	</tr>
</form>
</table>
				
</div>				
				
				
<script language="JavaScript">
var f=document.formContent;
var d=document.all;	

function selectCate(){		
	if (f.cateKind[0].checked==true)	{				
		d.file_02.style.display="none";		
	}else if (f.cateKind[1].checked==true)	{		
		d.file_02.style.display="";		
	}		
}
</script>