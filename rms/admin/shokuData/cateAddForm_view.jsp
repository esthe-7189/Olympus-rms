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
String urlPage=request.getContextPath()+"/orms/";	
String urlPage2=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");
String parentId = request.getParameter("parentId");	
String bseqModi = request.getParameter("bseqModi");	
String modi = request.getParameter("modi");	
if(modi==null){modi="no";}

//int parantCode=0;
String hCateCode=request.getParameter("hCateCode");
if(hCateCode==null){hCateCode="1";}
String hCateNm=request.getParameter("hCateNm");
if(hCateNm==null){hCateNm="(1)の大分類を選択して下さい";}

int mseq=0; int grid=0; int levelVal=0; int bseq=0; int cateNo=0; 
String title=""; 

MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}
		
//page권한
int pageArrow=0;
if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){ pageArrow=1;	}else{pageArrow=2;}	

FileMgr manaPg=FileMgr.getInstance();
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
 List listView=manaPg.selectPageGo(mseq);
 	 
CateMgr manager = CateMgr.getInstance();
Category board = null;
    if (parentId != null) {        
        board = manager.select(Integer.parseInt(parentId));        
    } 

//항목 수정시 사용
Category boardModi = null;
if(bseqModi !=null){
	boardModi = manager.select(Integer.parseInt(bseqModi));
	title=boardModi.getName();        
}
List  list=manager.selectListAdminLevel(Integer.parseInt(hCateCode),1); //대분류 번호, 레벨
List listMCate=manager.listMcate();
int hCateCodein=Integer.parseInt(hCateCode);

%>
<c:set var="board" value="<%= board %>" />
<c:set var="boardModi" value="<%= boardModi %>" />
<c:set var="list" value="<%= list %>" />
<c:set var="listView" value="<%= listView %>" />
<c:set var="listMCate" value="<%= listMCate%>"/>
	
<script language="javascript">
window.onload = function() {
		StartData(); 		
}
function StartData() {
var groupcnt = document.formhgroup.selecthg.options[document.formhgroup.selecthg.selectedIndex].text;	
    	document.formcategory.hgroup_name.value=groupcnt;
}	

function goWrite01(){
var frmh=document.formhgroup
var frmL = document.formlgroup;
var groupcnt = document.formhgroup.selecthg.options[document.formhgroup.selecthg.selectedIndex].value;

	if(groupcnt=="0"){alert("(1)の大分類を選択して下さい"); return; 	} 
	if(isEmpty(frmL.viewNo, "順番を書いて下さい。")) return ; 
	if(isEmpty(frmh.selecthg, "(1)の大分類を選択して下さい")) return ; 
	if(isEmpty(frmL.name, "項目を入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点(,)は使わないで下さい")) return ;		
	frmL.lgroup_no.value=groupcnt ;  
	
	if ( confirm("登録しますか?") != 1 ) { return; }	
	frmL.action = "<%=urlPage2%>rms/admin/shokuData/cateInsert01_view.jsp";	
	frmL.submit();
}
function goInit(){
	var frm = document.frm;
	frm.reset();
}

function formSubmit(){
        var frmh=document.formhgroup;	
	  var frmCate = document.formcategory;
	  var groupcnt = document.formhgroup.selecthg.options[document.formhgroup.selecthg.selectedIndex].value;
	  var inputs=document.getElementsByTagName("input");	  
	  var cate_seq=document.getElementById("cate_seq");	  

	  var fileCnt = 0;
	  var dbfileCnt = 0;
	  var dbTitleCnt = 0;
	  	 
	  if(groupcnt=="0"){alert("(1)の大分類を選択して下さい"); return; }      
 	  if(isEmpty(frmCate.lgroup_name, "中分類カテゴリを選択して下さい")) return ; 
	  if(isEmpty(frmCate.mgroup_name, "小分類カテゴリを選択して下さい")) return ;
    	  
   	  	  
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
  		var inputTitle=document.getElementsByTagName("textarea");	  
    		for(var i = 0; i < inputTitle.length; i++) {
    			var textarea=inputTitle.item(i);
    			var textnm=textarea.getAttribute("name");
    				if(textnm=="title" ){     					
    					if(textarea.getAttribute("value") ==""){
    						textarea.setAttribute("value","...");      						
    					}
    				}     			
    		}	
    		
   		var cate_L=document.getElementById("cate_L");
    			cate_L.value=groupcnt;
 		
 		var inputCateM=document.getElementById("mgroup_code");
 		      cate_seq.value=inputCateM.value;
 		      
 		var lgroupcate = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;	
		var arr_value=lgroupcate.split(',');    
		var cate_group=document.getElementById("cate_group");	  
 			cate_group.value=arr_value[1];
 		
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     document.getElementById("frm").submit();   
   }
   
  
</script>	
<script type="text/javascript" >
  
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
		if( TargetRow.nodeName == "TR" ){
			break;
		}

		TargetRow = TargetRow.parentNode;
		if(TargetRow == document){
			TargetRow = null;
			break;
		}
	}

	if(TargetRow == null)
		return;

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

function MakeNewRow()
{
// check box
var newRow = document.createElement("tr");
var newTd = document.createElement("td");
var newInput = document.createElement("input");
newInput.setAttribute("type", "checkbox")
newTd.appendChild(newInput);
newRow.appendChild(newTd);

// Description  
newTd = document.createElement("td");
var newText = document.createElement("textarea");
newTd.appendChild(newText);
newTd.innerHTML="<textarea  id=title name=title class=textarea cols=25 rows=2></textarea>";
newRow.appendChild(newTd);

/*
newTd = document.createElement("td");
var newTextArea = document.createElement("textarea");
newTextArea.setAttribute("cols", "25");
newTextArea.setAttribute("rows", "2");
newTextArea.setAttribute("id", "title");
newTextArea.setAttribute("class", "textarea");
newTextArea.setAttribute("name","title");
newTd.appendChild(newTextArea);
newRow.appendChild(newTd);
*/
 
// File 
newTd = document.createElement("td");
var newFile = document.createElement("input");
newTd.appendChild(newFile);
newTd.innerHTML="<input type=file size=80 name=file id=file  class=file_solid >";
newRow.appendChild(newTd);
/*
newTd = document.createElement("td");
var newFile = document.createElement("input");
newFile.setAttribute("type", "file");
newFile.setAttribute("id", "file");
newFile.setAttribute("class", "file_solid");
newFile.setAttribute("size", "80");
newTd.appendChild(newFile);
newRow.appendChild(newTd);
*/
// buttons
/*
newTd = document.createElement("td");
newInput = document.createElement("input");
newInput.setAttribute("type", "button");
newInput.setAttribute("value", "△");
newInput.attachEvent("onclick", InsertUpper);
newTd.appendChild(newInput);

//var newBr = document.createElement("br");
//newTd.appendChild(newBr);

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
  </script>
					
					    					
<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">月報・週報開発/QMS<font color="#A2A2A2">&nbsp;>&nbsp;</font>新規登録</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="開発会議&QMSデータメイン" onClick="location.href='<%=urlPage2%>rms/admin/shokuData/mainForm.jsp'">			
	<%if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){%>			  
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="職員閲覧可否決定" onClick="location.href='<%=urlPage2%>rms/admin/shokuData/viewMgr.jsp'">					
	<%}%>		
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage2%>rms/admin/shokuData/cateAddForm.jsp'">
</div>
<div id="boxCalendar"  > 

<table width="960" border="0" cellpadding="0" cellspacing="0"   bgcolor="#F7F5EF">				
		<tr>
			<td  style="padding:5 0 5 10;" width="90%">						
				<table  border="0" cellpadding="3" cellspacing="3" width="100%">	
				<tr align="left">
					<td style="padding: 2 0 2 0">				
	<font color="#339900">※</font> <font color="#807265">大項目に対してはアクセス制限がかかっているところがあります。解除する為には各部署の上長に承認がいりますのでご了承お願い致します。</font>			      	
					</td>
				</tr>
				<tr align="left">
					<td style="padding: 2 0 2 0">					   			      
	<font color="#339900">※ </font> <font color="#807265">システムを利用する際、システムのエラー、機能追加など提案があれば 管理者（張晶旭、juc@olympus-rms.co.jp / Tel: 078-335-5171）にメールかお電話で<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;問合せして下さい。	</font>
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
<table  width="960" cellspacing="5" cellpadding="5">	
	<form name="formhgroup" method="post"  action="<%=urlPage2%>rms/admin/shokuData/cateAddForm.jsp" >				
		<input type="hidden" name="hCateCode" value="">
		<input type="hidden" name="hCateNm" value="">
		<tr>
			<td align="left"  style="padding-left:0px;padding-top:0px" >	
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">		
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:0px" class="calendar16_1">
			<font color="#007AC3">(1)</font> 大分類選択<br></td>			
		</tr>
		<tr>
			<td bgcolor="#F7F5EF" align="left"  style="padding-left:30px;padding-top:10px" >
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >  大分類を選択してから下の<font color="#007AC3">(2)</font>を書いて下さい。<br>		
			</td>			
		</tr>	
		<tr>							
			<td bgcolor="#F7F5EF" style="padding:10px 0px 20px 50px;"><b> [大分類]</b>  :   
    		<select  name="selecthg" onChange="doselectHcode();">
    			<option value="0"  <%if(hCateCodein==0){%> selected <%}%>>選択して下さい</option>
 <% if(pageArrow==1){%>  
 	 <c:if test="${! empty  listMCate}">	
		<% int im=1; int bseqq=0;
			Iterator listiterm=listMCate.iterator();					
				while (listiterm.hasNext()){
					Category catee=(Category)listiterm.next();
					bseqq=catee.getBseq();				
	 	%>    				
					<option value="<%=bseqq%>" <%if(hCateCodein==bseqq){%> selected <%}%>><%=catee.getName()%></option>	
		<%im++;}%>	
	</c:if>			
				
				
									
  <%}else{%>
<c:if test="${empty listView}">				
			    	<option value="0">---</option>			    		
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
	<option value="<%=cateMem.getBseq()%>"  <%if(hCateCodein==cateMem.getBseq()){%> selected <%}%>><%=cateMem.getName()%></option>	
								
<%
i++;
}												  													  
%>	
</c:if>				  
  	  
  <%}%> 			
    				
	       </select>
	       &nbsp; 
	       <a class="topnav"  href="javascript:goLCategory();" onfocus="this.blur();">[:::大分類の追加及び管理:::]</a>	   
	       	   
        </td>
		</tr>    
	</form>
</table> 
<!-- category begin *****************************************************************-->
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<form name="formlgroup" method="post"  action="<%=urlPage2%>rms/admin/shoku/cateInsert01_view.jsp" onSubmit="return goWrite01(this)" >	
			<c:if test="${! empty board}">
		<input type="hidden" name="bseq" value="${board.bseq}">	
			</c:if>
			<c:if test="${empty board}">
		<input type="hidden" name="bseq" value="0">	
			</c:if>			
			<c:if test="${! empty param.groupId}">
		<input type="hidden" name="groupId" value="${param.groupId}">
			</c:if>
			<c:if test ="${! empty param.parentId}">
		<input type="hidden" name="parentId" value="${param.parentId}">
			</c:if>						
		<input type="hidden" name="level" value="${board.level + 1}">
		<input type="hidden" name="cateNo" value="">	
		<input type="hidden" name="modi" value="">		
		<input type="hidden" name="bseqModi" value="">	
		<input type="hidden" name="groupIdDel" value="">					
		<input type="hidden" name="nameModi" value="">
		<input type="hidden" name="lgroup_no" value="<%=hCateCode%>">											
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<font color="#007AC3">(2)</font>　中小分類選択及び書く<br></td>			
		</tr>	
</table>							  
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">		
		<tr>
			<td align="left"  style="padding-left:30px;padding-top:10px" >			
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >   新しいカテゴリは [中分類]==> [小分類]の順番にご記入下さい。
			</td>			
		</tr>					
		<tr>
			<td align="center" >						
				<table width="75%" >					
					<tr>
						<td width="45%" bgcolor="#F1F1F1">
							<table width="100%" class="tablebox" cellspacing="5" cellpadding="5">																
								<tr>
								        <td height="20" align="center"><b> [中分類]</b></td>
								 </tr>
									<td align="left"  style="padding-left:10px" valign="middle" height="200">
<!-- 대분류 category begin-->	
	          <div align="center" > 
	            <select class="normal" style="border:0;HEIGHT:111px;WIDTH:200px;" onChange="doselectLcode();" multiple size="7" name="selectlg">
<c:if test="${empty list}">				
			    	<option value="0"></option>			    		
</c:if>	
		
<c:if test="${! empty list}">
<%
int i=1;
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		Category cate=(Category)listiter.next();
		bseq=cate.getBseq();	
		grid=cate.getGroupId();
		levelVal=cate.getLevel();		
		cateNo=cate.getCateNo();	
%>	  
		<option value="<%=bseq%>,<%=grid%>"><%=cateNo%>,<%=cate.getName()%></option>
<%
i++;
}												  													  
%>	
</c:if>			
	            </select><br>	
順番:<INPUT TYPE="TEXT" NAME="viewNo"  VALUE="" class="logbox" style="width:18px;height:25px;ime-mode:disabled"> <textarea name="name" cols="28" rows="2"><%=title%></textarea><br>	
				<a href="javascript:goWrite01();" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_write.gif"  align="absmiddle" alt="write"></a>
				<a href="javascript:goModify();" onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_update.gif"  align="absmiddle" alt="modify"></a>	
				<a href="javascript:cateDel('<%=levelVal%>')"  onfocus="this.blur()"><img src="<%=urlPage%>images/admin/icon_cancel.gif" align="absmiddle" alt="delete"></a>	
	          </div>				
<!-- 대분류 category end-->
</form>											
									</td>
								</tr>									
							</table>
						</td>
						<td width="10%" align="center"><img src="<%=urlPage%>images/admin/icon_jirusi.gif"  align="absmiddle" ></td>	
						<td width="45%" align="left" bgcolor="#F1F1F1">					
<!-- 중분류 category begin -->
	    <table width="100%" class="tablebox" cellspacing="5" cellpadding="5" >
	      <tr> 
	        <td height="20" align="center"><b> [小分類] </b></td>
	      </tr>
	      <tr>
	        <td align="left"  style="padding-left:10px" valign="middle" height="200">
	      <div align="center" > 
	       <%if(id!=null){%>
	        	<iframe name="mgroupframe" src="Mgroup.jsp" scrolling="no" frameborder="0" width="100%" height="180"></iframe>
	       <%}else{%>
	       	<img src="<%=urlPage%>images/admin/btn_admin_update.gif" align="absmiddle" alt="登録">
	       <%}%>
	       </div>
	        </td>
        </tr>
      </table>
<!-- /중 end -->
									
						</td>						
					</tr>											
				</table>
			</td>
		</tr>
</table>	
<table  width="960" border="0" cellspacing="0" cellpadding="0"  style="padding-top:10px">
	<form name=formcategory method=post >									
	<tr>
		<td height="10" valign="middle"  width="100%" style="padding-left:10px;">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle"><span class="fontBb"> 選択された項目: </span> 
			<input type=text size="40" class=input02 readonly name="hgroup_name" id="hgroup_name" value="<%=hCateNm%>"> > 
			<input type='hidden' name="hgroup_code" id="hgroup_code" value="<%=hCateCode%>">
			<input type=text size="40" class=input02 readonly name="lgroup_name"  id="lgroup_name">  
			<input type='hidden' name="lgroup_code" id="lgroup_code">
			<input type=text size="40" class=input02 readonly name="mgroup_name" id="mgroup_name"> 
			<input type='hidden' name="mgroup_code" id="mgroup_code">			
			<input type='hidden' name="list_cate_seq" id="list_cate_seq">			
		</td>
	</tr>	
</form>
</table>

<!-- item begin *****************************************************************-->				  
<table  width="960"  cellspacing="5" cellpadding="5">								
		<tr>
			<td width="70%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
				<font color="#007AC3">(2)</font>  ファイルアップロード<br></td>
			<td width="30%" rowspan="6" style="padding:2 10 0 30;" valign="bottom">
	<input type="button"  class="cc" onfocus="this.blur();" style="cursor:pointer" value=" ファイル追加 " onclick="javascript:NewRow()">
	<input type="button"  class="cc" onfocus="this.blur();" style="cursor:pointer" value=" ファイル削除 "  onclick="javascript:deleteCheckedRow()">		
				
			</td>			
		</tr>
			
		<tr>
			<td align="left"  style="padding:0px 0px 0px 30px;"　 >			
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >   100ＭＢ以上のファイルはシステム管理者に問い合わせてください。			
			</td>			
		</tr>
		<tr>
			<td align="left"  style="padding:0px 0px 0px 30px;" >			
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >   復数のファイルは、<font color="#E100E1">ファイルを追加</font>しながらアップロードしてください。				
			</td>			
		</tr>
		<tr>
			<td align="left"  style="padding:0px 0px 0px 30px;" >			
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >   <font color="red">削除方法：</font>　チェックボックスを選択してから<font color="#E100E1">[ファイル削除]</font>をおしてください。　				
			</td>			
		</tr>
		<tr>
			<td align="left"  style="padding:0px 0px 0px 30px;">			
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >   <font color="red">ファイル名：</font>　必ず、ファイル名は500文字以内にして下さい。			
			</td>			
		</tr>		
		<tr>
			<td align="left"  style="padding:0px 0px 0px 30px;" >			
			<img src="<%=urlPage%>images/bg/ol_dot.gif" >  <b><font color="#CC0000">※</font></b>は必修項目です。　				
			</td>			
		</tr>				
</table>
<form id="frm"  method="post"  enctype="multipart/form-data"  action="<%=urlPage2%>rms/admin/shokuData/add.jsp"  >								
	<input type='hidden' name="mseq" value="<%=mseq%>">	
	<input type='hidden' name="cate_L"  id="cate_L" value="">
	<input type='hidden' name="cate_seq"  id="cate_seq" value="">
	<input type='hidden' name="ok_yn" value="1">
	<input type="hidden" name="lgroup_no" id="lgroup_no"  value="<%=hCateCode%>">	
	<input type="hidden" name="cate_group" id="cate_group" value="">						
<table   id="tbl" width="800" class="tablebox_800" cellspacing="5" cellpadding="5">								
			<tr align=center height="25">	
				<td ><span class="titlename">削除</span> </td>
				<td ><span class="titlename">説明</span></td>
				<td ><font color="#CC0000">※</font><span class="titlename">ファイル</span></td>				
			</tr>
			<tr>	
				<td><input type="checkbox" /></td>
				<td><textarea  id="title" name="title" class="textarea" cols="25" rows="2"></textarea></td>
				<td><input type="file" name="file"  id="file" class="file_solid" size="80"></td>				
			</tr>						
</table>
<div class="clear_margin"></div>				  
<table  align="center" width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15px 0px 0px 0px;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage%>images/common/btn_off_submit.gif" ></a>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>images/common/btn_off_cancel.gif" ></a>
			</td>			
	</tr>
</form>				
</table>	
	</div>
</div>
<div class="clear_margin"></div>			
<div class="clear_margin"></div>							
<!-- item end *****************************************************************-->				
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>			
<script language='JavaScript'>
//각 iframe의 url
var mgroupurl  = "<%=urlPage2%>rms/admin/shokuData/Mgroup.jsp";
// var sgroupurl  = "<%=urlPage%>admin/job/Sgroup.jsp";
var delpage= "<%=urlPage2%>rms/admin/shokuData/cateDel.jsp";
var listForm="<%=urlPage2%>rms/admin/shokuData/cateAddForm.jsp";
var modiOk="<%=urlPage2%>rms/admin/shokuData/cateModi.jsp";

//대분류 목록을 선택 했을때
function doselectHcode(kind) {	
  var hgroup = document.formhgroup.selecthg.options[document.formhgroup.selecthg.selectedIndex].value;
  var hname = document.formhgroup.selecthg.options[document.formhgroup.selecthg.selectedIndex].text;     
   	    
	document.formhgroup.hCateCode.value=hgroup;
	document.formhgroup.hCateNm.value=hname;	
	document.formhgroup.submit();	
}
//중분류 목록을 선택 했을때
function doselectLcode(kind) {	  
  var hgroup = document.formhgroup.selecthg.options[document.formhgroup.selecthg.selectedIndex].value;  //대분류
  var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
  var lname = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].text;      
    	var arr_text=lname.split(','); 
    	var arr_value=lgroup.split(',');    	//bseq, groupId
	
	document.formlgroup.viewNo.value  = arr_text[0];   //순번
	document.formlgroup.name.value  = arr_text[1];     //카테고리
	document.formcategory.lgroup_name.value  = arr_text[1];  //카테고리
	document.formcategory.lgroup_code.value  = arr_value[0];  //bseq	
	
  	mgroupframe.document.location = mgroupurl + "?lgroup=" + arr_value[0]+"&lgroup_no="+hgroup;
//	sgroupframe.document.location = sgroupurl  + "?lgroup=" + lgroup;		
	
}
function cateDel(level) {
	var frmL = document.formlgroup;
	if(isEmpty(frmL.selectlg, "項目を選択して下さい")) return  ;
	var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;
	var arr_value=lgroup.split(',');    	

	if ( confirm("上の内容を本当に削除しますか?") != 1 ) { return; }	
		
	document.formlgroup.action = delpage;
    	document.formlgroup.bseqModi.value = arr_value[0];
    	document.formlgroup.level.value = level;
    	document.formlgroup.groupIdDel.value = arr_value[1];
    	document.formlgroup.lgroup_no.value ="<%=hCateCode%>"; 	//대분류
    	document.formlgroup.submit();
}

function goModify(){	
	var frmL = document.formlgroup;
	var lgroup = document.formlgroup.selectlg.options[document.formlgroup.selectlg.selectedIndex].value;	
	var arr_value=lgroup.split(',');    
 	
	if(isEmpty(frmL.name, "項目を選択及び入力して下さい")) return ;
	if(isNoChar(frmL.name, "読点( , )は使わないで下さい")) return ;		
	if ( confirm("上の内容を修正しますか?") != 1 ) { return; }	
	
	document.formlgroup.action = modiOk;
    	document.formlgroup.bseq.value = arr_value[0];
    	document.formlgroup.cateNo.value = document.formlgroup.viewNo.value;   
    	document.formlgroup.nameModi.value = frmL.name.value;     
    	document.formlgroup.lgroup_no.value ="<%=hCateCode%>"; 	//대분류
    	document.formlgroup.submit();
    	
}
function goLCategory(){	
	var param="";
	openScrollWin("<%=urlPage2%>rms/admin/shokuData/cateParent_pop.jsp", "categoryAdd", "categoryAdd", "350", "500",param);
}
</script>
	
							
			