<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
if(id==null ||  id.equals("candy")){
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
String src_item=request.getParameter("src_item");
if(src_item==null){src_item="1";}
int cnt_item=Integer.parseInt(src_item);

String title="";

MemberManager memManager=MemberManager.getInstance();
Member mem=memManager.getMember(id);
AccMgr tabmgr=AccMgr.getInstance();
List listTab=tabmgr.listTab();
int tab_count=tabmgr.tabCnt();
%>
<c:set var="mem" value="<%= mem %>" />
<c:set var="listTab" value="<%=listTab %>" />

<script language="javascript">

function contentWite(){
  var frm = document.formContent;    
  var frm2 = document.formn;
  var inputs=document.getElementsByTagName("input");	
  var fileCnt = 0;
  var dbfileCnt = 0;	       	   
  
       if(isEmpty(frm2.seq_tab, "タブ(TAB)を選択して下さい")) return ; 
       if(isEmpty(frm.cate_nm, "手順書NOを入力して下さい")) return ;        
	 if(isEmpty(frm.title, "タイトルを入力して下さい")) return ; 	
	 if(isEmpty(frm.name, "お名前を入力して下さい。!")) return ;		
	  frm.seq_tab.value= frm2.seq_tab.value;  
        	for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].type == "file") {
	      			fileCnt++;
	      			if(inputs[i].value==""){ alert(fileCnt+"番目のファイルをアップロードしない場合は、削除してください\n "); return; }
	     		}
    		}
    		
    		for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].type == "file") {	      			
	      			if(inputs[i].value!=""){ 	      				
	      				var filenm=inputs.item(i).getAttribute("name");
	      				filenm="file"+dbfileCnt;
	      				inputs.item(i).setAttribute("name", filenm);	      					
	      				dbfileCnt++;
	      			}
	     		}
    		}
    	if(frm.content.value==""){frm.content.value="no data";}
         	
  	 if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
	 frm.action = "<%=urlPage%>rms/admin/sop/add.jsp";	
	 frm.submit();
}

function goInit(){
	var frm = document.formContent;
	frm.reset();
}

 function NewRow(){
	var tBody = tbl.getElementsByTagName("tbody")[0];
	var row = MakeNewRow();
		tBody.appendChild(row);		
}

function InsertUpper(){
	InsertRow (event.srcElement, true);		
}

function InsertLower(){
	InsertRow(event.srcElement, false);	
}

function InsertRow(obj, ToUpper){
	var TargetRow;
	TargetRow = obj.parentNode;
	while(TargetRow != null){
		if( TargetRow.nodeName == "TR" ){	break;}
		TargetRow = TargetRow.parentNode;
		if(TargetRow == document){
			TargetRow = null;
			break;
		}
	}
	if(TargetRow == null)	return;
	var newRow = MakeNewRow();
	var tBody = tbl.getElementsByTagName("tbody")[0];

	if (ToUpper == true){
		tBody.insertBefore(newRow, TargetRow);
	}else{
		TargetRow = TargetRow.nextSibling;
		if(TargetRow != null){
			tBody.insertBefore(newRow, TargetRow);
		}else{
			tBody.appendChild(newRow);
		}
	}		
}



function MakeNewRow(){ 
var newRow = document.createElement("tr");

var newTd = document.createElement("td");
newTd.setAttribute("align","center");
var newInput = document.createElement("input");
newTd.appendChild(newInput);
newTd.innerHTML="<input type=checkbox>";
newRow.appendChild(newTd);


// File
newTd = document.createElement("td");
newTd.setAttribute("align","left");
var newFile = document.createElement("input");
newTd.appendChild(newFile);
newTd.innerHTML="<input type=file size=80 name=file id=file  class=file_solid >";
newRow.appendChild(newTd);


// buttons
/*
newTd = document.createElement("td");
newInput = document.createElement("input");
newInput.setAttribute("type", "button");
newInput.setAttribute("value", "△");
newInput.attachEvent("onclick", InsertUpper);
newTd.appendChild(newInput);

newInput = document.createElement("input");
newInput.setAttribute("type", "button")
newInput.setAttribute("value", "▽")
newInput.attachEvent("onclick", InsertLower);
newTd.appendChild(newInput);
newRow.appendChild(newTd);
*/
return newRow; 
}

function deleteCheckedRow(){	
	var inputList = document.getElementsByTagName("input");
	var tBody = tbl.getElementsByTagName("tbody")[0];
	var checkItem;
	for(var i=inputList.length-1; i >= 0; i--){
		checkItem = inputList.item(i);
		if( checkItem.checked == true){
			var nodeParent = checkItem.parentNode.parentNode;
			if(nodeParent.nodeName == "TR"){
				tBody.removeChild(nodeParent);								
			}
			
		}
	}
	
}
function ontest(){
	alert("aaaa");
}
</script>	
<div class="con_top_title" onmousedown="dropMenu()">	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><%=src_item%><span class="calendar7">標準作業手順書(SOP)<font color="#A2A2A2">     >     </font>新規登録</span> 
</div>
<div class="clear"></div>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/sop/cateAddForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録" onClick="location.href='<%=urlPage%>rms/admin/sop/listForm.jsp'">	
</div>

<div class="boxCalendar_80">		
<table width="800"   >	
		<tr>
			<td>
			  <span class="calendar9"><img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">&nbsp;
			    入力の手順 : タブ(TAB)選択<font color="#FF9900"> ==> </font>ファイルの情報</span>
		 	</td>
	 	</tr>
	 	<tr>
			<td style="padding-left:25px;">
			  <font color="#CC3333" >	▷アップロードするファイル名に '&,%,^'などの特修記号は使わないで下さい!</font>
		 	</td>
	 	</tr>
</table>	
<table width="800"   class="tablebox" >	  
	<form name="formn"  method="post"   >						
		<input type="hidden" name="src_item" value="">		
		    <tr align="left">
		       <td   width="25%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイル数選択:</td>
		    	<td align="left">   
		    		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">							
					  <select name="src_itemSel" class="select_type3"  onChange="return doCnt();">					  	  
					  	  <%for(int i=1;i<11;i++){%>
					  	  	  <%if(cnt_item==i){%> <option value="<%=i%>" selected >　　　<%=i%>　　個　　　</option> 
					  	  	  <%}else{%><option value="<%=i%>" >　　　<%=i%>　　個　　　</option> <%}%>
					  	  <%}%>				  		 									
					  </select>
					</div>	
		        </td>
		    </tr>       
		    <tr align="left">
		       <td   width="25%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タブ(TAB)選択:</td>
		    	<td align="left">   
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
	</form>
 </table> 
 <div class="clear_margin"></div>    						
<table width="800"   class="tablebox" id="tbl">							
	<form name="formContent" action="<%=urlPage%>rms/admin/sop/add.jsp" method="post"  enctype="multipart/form-data"  >		
		<input type="hidden" name="hit_cnt" value="0">			
		<input type="hidden" name="seq_tab" value="">		
			<tr align="left">
				<td align=""  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >手順書の番号:</td>
				<td align="left" width="80%"><input type="text" maxlength="100" name="cate_nm" value="" class="input02" style="width:300px">
					<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/sop/tensuNo_pop.jsp','read','상세보기','745','380','');" onfocus="this.blur()">	
					<img src="<%=urlPage%>rms/image/admin/btn_tesun_no.gif" align="absmiddle"></a>
				</td>
			</tr>
			<tr align="left">
				<td align=""  ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルのタイトル:</td>
				<td align="left"><input type="text" maxlength="100" name="title" value="" class="input02" style="width:300px"><font color="#807265">(▷100文字以下)</font></td>
			</tr>							
			<tr align="left">
				<td align=""  ><img src="<%=urlPage%>rms/image/icon_s.gif" >登録者:</td>
				<td align="left"><input type="text" maxlength="30" name="name" value="${mem.nm}" class="input02" style="width:300px"><font color="#807265">(▷30文字以下)</font></td>
			</tr>
			<tr align="left">
				<td align=""  ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
				<td align="left">
					<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()" checked>Yes &nbsp;
					<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" >No
				</td>
			</tr>
			<tr align="left">	
				<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >コメント:</td>
				<td align="left"><textarea   name="content" cols="80" rows="3" class="textarea"></textarea></td>
			</tr>
				<tr>
					<td  align="left" >
						<img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの選択:
					</td>
					<td  align="right"  >	
						<!--<input type="button"  class="cc" onfocus="this.blur();" style="cursor:pointer" value=" ファイル追加 " onclick="javascript:NewRow()">-->
						<input type="button"  class="cc" onfocus="this.blur();" style="cursor:pointer" value=" ファイル削除 "  onclick="javascript:deleteCheckedRow()">								
					</td>							
				</tr>				
									
						<tr >	
							<td align="center"> 削除</td>							
							<td style="padding-left:200px;"><b><font color="#CC0000">※</font>     ファイル</b></td>							
						</tr>												
					<% for(int iitme=0;iitme<cnt_item;iitme++){%>	
						<tr>	
							<td align="center" ><input type="checkbox" /></td>							
							<td align="left"><input type="file" name="file"  id="file" class="file_solid" size="95"></td>							
						</tr>
					<%}%>	
									 		
</table>	
<div class="clear_margin"></div>						
<table width="800" >								   
	<tr align="center">
			<td style="padding-top:0px;">								
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  登録する  >>" onClick="contentWite();">						
				&nbsp;
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  取り消し  >> " onClick="goInit();">		
						
			</td>			
	</tr>
</form>
</table>
	</div>
<script language="javascript">
function doCnt(){
	var frm=document.formn;
	frm.src_item.value=frm.src_itemSel.value;		
	frm.action = "<%=urlPage%>rms/admin/sop/cateAddForm.jsp";	
	frm.submit();	
}
</script>	 