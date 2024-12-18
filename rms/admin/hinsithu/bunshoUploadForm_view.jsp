<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>

<%	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
if(id.equals("candy") || id.equals("ohtagaki") || id.equals("kishi") || id.equals("togashi")){
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

%>

<script type="text/javascript">
// 카테고리 코드 가져오기
function checkCode(){		
	openNoScrollWin("cate_pop.jsp", "category", "category", "800", "700","");
}
function returnPopcode(code01,code02,sgroup){
var frm = document.memberInput;
		frm.lgroup_name.value = code01;
		frm.mgroup_name.value = code02;
		frm.sgroup_name.value = sgroup;		
		frm.title.focus();	
}		
	
function goWrite() {
var frmCate=document.memberInput;	
    with (document.memberInput) {
    	if (chkSpace(f_title.value)) {    		
   	    	alert("ファイルのタイトルを書いてください.");
            f_title.focus();    return ;        
        }else if (f_title.value.length<5) {
   	    	alert("５文字以上ではありません！！");
            f_title.focus();   return ;
        }else if (chkSpace(fileNm.value)) {
   	    	alert("ファイルを選択してください.");
            fileNm.focus();   return ;
         }else if (chkSpace(fname.value)) {
            alert("責任者を書いてください.");
            fname.focus();   return ;
          }else if (chkSpace(fname_digi.value)) {
            alert("責任者/デジタルファイルを書いてください.");
            fname_digi.focus();   return ;
          }else if (chkSpace(fname_bun.value)) {
            alert("責任者/文書ファイルを書いてください");
            fname_bun.focus();   return ;
          }else if (chkSpace(basho.value)) {
            alert("保管場所を書いてください");
            basho.focus();   return ;
          }else if (chkSpace(basho_digi.value)) {
            alert("保管場所/デジタルファイルを書いてください.");
            basho_digi.focus();   return ;
          }else if (chkSpace(basho_bun.value)) {
            alert("保管場所/文書ファイルを書いてください.");
            basho_bun.focus();   return ;
          }            
    }
   
    frmCate.cate_code.value=frmCate.lgroup_code.value;
    frmCate.cate_code_det.value=frmCate.mgroup_code.value;
    frmCate.cate_code_s.value=frmCate.sgroup_code.value;    
	if(frmCate.content.value==""){frmCate.content.value=".";	}	
	
   if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frmCate.action = "upload.jsp";	
	frmCate.submit(); 
 }   

function goInit(){
	document.forminput.reset();
}
function chkSpace(strValue) {
    var flag=true;
    if (strValue!="") {
        for (var i=0; i < strValue.length; i++) {
            if (strValue.charAt(i) != " ") {
	        	flag=false;
	        	break;
	    	}
        }
    }
    return flag;
}

</script>	

<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"> <span class="calendar7">品質試験書QA  <font color="#A2A2A2">   >   </font> 新規登録</span> 	
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/bunshoUploadForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="項目登録" onClick="checkCode();">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="マニュアル" onClick="location.href='<%=urlPage%>rms/admin/file/bun_down.jsp?filename=orms20090223admin.ppt'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="データ出力(Excel)" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/listForm.jsp'">	
</div>


<div id="boxNoLine_850"  >		
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=60);">
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=30);">ファイル情報
</label>	
<table width="850"  class="tablebox" cellspacing="5" cellpadding="5">	
	<form name="memberInput" method="post"  action="<%=urlPage%>rms/admin/hinsithu/upload.jsp" enctype="multipart/form-data">												
	<input type="hidden" name="parentMoto" value="0">	
	<input type="hidden" name="parentId" value="0">	
	<input type="hidden" name="kind_yn" value="0">	
	<input type="hidden" name="bseq" value="0">
	<input type="hidden" name="no" value="0">	
	<input type='hidden' name="lgroup_code">
	<input type='hidden' name="mgroup_code">
	<input type='hidden' name="sgroup_code">			
	<input type='hidden' name="cate_code">
	<input type='hidden' name="cate_code_det">
	<input type='hidden' name="cate_code_s">	
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >翻訳段階の選択:</td>
		<td>
				<input type="radio" name="file_kind"  value="1"  onfocus="this.blur()"  checked>試験書原文(ORMS) &nbsp;
				<input type="radio" name="file_kind"  value="2" onfocus="this.blur()" disabled>QAチェック本(OT)	&nbsp;
				<input type="radio" name="file_kind"  value="3" onfocus="this.blur()" disabled>QA確認本&nbsp;
				<input type="radio" name="file_kind"  value="4" onfocus="this.blur()" disabled>最終完成本&nbsp;
		
		</td>
	</tr>
	<tr   height=20>
		<td align=""  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルのタイトル:</td>
		<td><input type="text" maxlength="200" name="f_title" value="" class="input02" style="width:200px"><font color="#807265">(▷5文字以上～200文字以下)</font></td>
	</tr>	
	<tr   height=20>
		<td align=""  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイル選択:</td>
		<td width="82%">
			<input  type='file' name="fileNm" size="80" class="file_solid" >
			</span>
		</td>
	</tr>		
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの大項目:</td>
		<td><input type=text size="70" class=input02  readonly name="lgroup_name" onClick="JavaScript:checkCode()">  
		<a href="JavaScript:checkCode()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/btn_coment_mil.gif"  align="absmiddle"></a>
								<font color="#807265">(▷項目を検索する)</font>
		</td>
	</tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの中項目:</td>
		<td><input type=text size="70" class=input02 readonly name="mgroup_name" onClick="JavaScript:checkCode()">  </td>
	</tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの小項目:</td>
		<td><input type=text size="70" class=input02 readonly name="sgroup_name" onClick="JavaScript:checkCode()"> </td>	
</tr>
</table>
<div class="clear_margin"></div>	
<label class="calendar9">
			<img src="<%=urlPage%>rms/image/icon_s.gif" >
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=60);">
			<img src="<%=urlPage%>rms/image/icon_s.gif" style="filter:Alpha(Opacity=30);">責任者の情報
</label>																

<table width="850"  class="tablebox" cellspacing="5" cellpadding="5">
			<tr >
				<td align=""  width="13%"><img src="<%=urlPage%>rms/image/icon_s.gif" >責任者:</td>
				<td width="37%"><input type="text" maxlength="120" name="fname" value="" class="input02" style="width:160px"><font color="#807265">(▷120文字以下)</font></td>
				<td align=""  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" >保管場所:</td>
				<td width="35%"><input type="text" maxlength="200" name="basho" value="" class="input02" style="width:160px"><font color="#807265">(▷200文字以下)</font></td>
			</tr>
			<tr >
				<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >責任者/デジタル:</td>
				<td><input type="text" maxlength="200" name="fname_digi" value="" class="input02" style="width:160px"><font color="#807265">(▷200文字以下)</font></td>
				<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >保管場所/デジタル:</td>
				<td><input type="text" maxlength="200" name="basho_digi" value="" class="input02" style="width:160px"><font color="#807265">(▷200文字以下)</font></td>
			</tr>
			<tr >
				<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >責任者/文書:</td>
				<td><input type="text" maxlength="120" name="fname_bun" value="" class="input02" style="width:160px"><font color="#807265">(▷120文字以下)</font></td>
				<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >保管場所/文書:</td>
				<td><input type="text" maxlength="200" name="basho_bun" value="" class="input02" style="width:160px"><font color="#807265">(▷200文字以下)</font></td>
			</tr>	
			<tr>
				<td align=""  ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
				<td colspan="3">
					<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()"  checked>Yes &nbsp;
					<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" >No
				</td>			
			</tr>
			<tr>
				<td align=""  ><img src="<%=urlPage%>rms/image/icon_s.gif" >コメント:</td>
				<td colspan="3">
					<textarea   name="content" cols="80" rows="3" class="textarea"></textarea>
				</td>			
		</tr>
	</table>
<div class="clear_margin"></div>
				
<table width="920"  cellspacing="5" cellpadding="5">
	<tr>
		<td align="center" style="padding:15px 0px 100px 0px;">
				<a href="JavaScript:goWrite()"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></A>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></A>
			</td>	
	</tr>
</form>		
</table>
</div>



