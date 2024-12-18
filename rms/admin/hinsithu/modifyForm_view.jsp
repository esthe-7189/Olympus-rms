<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>	
<%@ page import="mira.hinsithu.HinsithuBean" %>
<%@ page import="mira.hinsithu.HinsithuMgr" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CateMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>

<%	
String kindpgkubun=(String)session.getAttribute("KIND");
if(kindpgkubun!=null && ! kindpgkubun.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String fno=request.getParameter("fno");

HinsithuMgr manager = HinsithuMgr.getInstance();
HinsithuBean bunData=manager.getSeizo(Integer.parseInt(fno));
	String codeA=bunData.getCate_code();
	String codeB=bunData.getCate_code_det();
	String codeC=bunData.getCate_code_s();
	int filedan=bunData.getFile_kind();		
	
CateMgr manager2 = CateMgr.getInstance();		//항목 호출
%>
<c:set var="bunData" value="<%= bunData %>" />
<c:if test="${! empty  bunData}" />

<script type="text/javascript">
// 카테고리 코드 가져오기
function checkCode(seq){		
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
            f_title.focus();
            return false;        
         }else if (chkSpace(fname.value)) {
            alert("責任者を書いてください.");
            fname.focus();   return false;
          }else if (chkSpace(fname_digi.value)) {
            alert("責任者/デジタルファイルを書いてください.");
            fname_digi.focus();   return false;
          }else if (chkSpace(fname_bun.value)) {
            alert("責任者/文書ファイルを書いてください");
            fname_bun.focus();   return false;
          }else if (chkSpace(basho.value)) {
            alert("保管場所を書いてください");
            basho.focus();   return false;
          }else if (chkSpace(basho_digi.value)) {
            alert("保管場所/デジタルファイルを書いてください.");
            basho_digi.focus();   return false;
          }else if (chkSpace(basho_bun.value)) {
            alert("保管場所/文書ファイルを書いてください.");
            basho_bun.focus();   return false;
          }else if (chkSpace(content.value)) {
           	content.value="." ;
          }  
    }
    
	with (document.memberInput) {
    	    if(fileKind[0].checked==true){         	 
		fileNm.value="<%=bunData.getFilename()%>";		
	    }	  
	    if(fileKind[1].checked==true){         	 
		if (chkSpace(fileNmVal.value)) {
	            alert("ファイルを選択して下さい。");
	            fileNmVal.focus();   return false;	
	        }else{
	            fileNm.value="NO";	
	        }
	   }	 
       }   
     				
	          if(frmCate.pay_kind[0].checked==true){       	 	
			frmCate.cate_code.value=frmCate.cate_code.value;
			frmCate.cate_code_det.value=frmCate.cate_code_det.value;
			frmCate.cate_code_s.value=frmCate.cate_code_s.value;    
		   }else if(frmCate.pay_kind[1].checked==true){					
			frmCate.cate_code.value=frmCate.lgroup_code.value;
			frmCate.cate_code_det.value=frmCate.mgroup_code.value;
			frmCate.cate_code_s.value=frmCate.sgroup_code.value;    
		   }	  	   
            		  			
	 if ( confirm("修正しますか?") != 1 ) { return; }	
     	frmCate.action = "<%=urlPage%>rms/admin/hinsithu/modifyUpload.jsp";	
	frmCate.submit();  
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
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">品質試験書QA<font color="#A2A2A2">></font> 編集</span> 
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
<form name="memberInput" action="<%=urlPage%>rms/admin/hinsithu/modifyUpload.jsp" method="post" enctype="multipart/form-data" >	
	<input type="hidden" name="no" value="<%=fno%>">	
	<input type="hidden" name="kind_yn" value="<%=bunData.getKind_yn()%>">
	<input type="hidden" name="file_kind" value="1">	
	<input type="hidden" name="fileNm" value="">
	<input type='hidden' name="lgroup_code">
	<input type='hidden' name="mgroup_code">
	<input type='hidden' name="sgroup_code">		
	<input type='hidden' name="cate_code" value="<%=bunData.getCate_code()%>">	
	<input type='hidden' name="cate_code_det" value="<%=bunData.getCate_code_det()%>">	
	<input type='hidden' name="cate_code_s" value="<%=bunData.getCate_code_s()%>">		
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >段階:</td>
		<td>

				<input type="radio" name="file_kind"  value="1"  onfocus="this.blur()"  checked>試験書原文(ORMS) &nbsp;
				<input type="radio" name="file_kind"  value="2" onfocus="this.blur()" disabled>QAチェック本(OT)	&nbsp;
				<input type="radio" name="file_kind"  value="3" onfocus="this.blur()" disabled>QA確認本&nbsp;
				<input type="radio" name="file_kind"  value="4" onfocus="this.blur()" disabled>最終完成本&nbsp;
		
		</td>
	</tr>
	<tr   height=20>
		<td align=""  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイル名:</td>
		<td>	<%=bunData.getFilename()%></tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >ファイルの変更:</td>
		<td>
			<input type="radio" onfocus="this.blur()"  name="fileKind" value="1"  onClick="selectFile()"  checked>No&nbsp;
			<input type="radio" onfocus="this.blur()"  name="fileKind" value="2"  onClick="selectFile()" >Yes 	<br>			
					<div id="file_01"  style="display:none;">									
						<table border=0 cellspacing=0 cellpadding=1>
							<tr>
								<td>
									<font color="#CC3333" width="82%">									
									▷アップロードするファイル名に '&,%,^'などの記号は使わないで下さい!
									</font><br>				
									<input type="file" name="fileNmVal" size="80"  class="file_solid">
								</td>
							</tr>						
						</table>
					</div>			
		</td>
	</tr>	
	<tr   height=20>
		<td align=""  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
		<td><input type="text" maxlength="200" name="f_title" value="<%=bunData.getF_title()%>" class="input02" style="width:200px"></td>
	</tr>	
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >大項目:</td>
		<td>
	<%Category codeVal1= manager2.select(Integer.parseInt(codeA));
	if(codeVal1!=null){%>				
		<%=codeVal1.getName()%>
	<%}else{%>											
		...
	<%}%>		
		</td>
	</tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >中項目:</td>
		<td>
	<%Category codeVal2= manager2.select(Integer.parseInt(codeB));
	if(codeVal2!=null){%>				
		<%=codeVal2.getName()%>
	<%}else{%>											
		...
	<%}%>				
		</td>
	</tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >小項目:</td>
		<td>
	<%Category codeVal3= manager2.select(Integer.parseInt(codeC));
	if(codeVal3!=null){%>				
		<%=codeVal3.getName()%>
	<%}else{%>											
		...
	<%}%>					
		</td>
	</tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >項目の変更:</td>
		<td>
			<input type="radio" onfocus="this.blur()"  name="pay_kind" value="1"  onClick="selectBank()"	checked>No&nbsp;
			<input type="radio" onfocus="this.blur()"  name="pay_kind" value="2"  onClick="selectBank()" >Yes 	<br>			
					<div id="pay_01"  style="display:none;">									
						<table border=0 cellspacing=0 cellpadding=1>
							<tr >								
								<td><input type=text size="70" class="input02"  readonly name="lgroup_name" onClick="JavaScript:checkCode()">  
								<a href="JavaScript:checkCode()" onfocus="this.blur();"><img src="<%=urlPage%>rms/image/admin/btn_coment_mil.gif"  align="absmiddle"></a>
														<font color="#807265">(▷項目を検索する)</font>
								</td>
							</tr>
							<tr >								
								<td><input type=text size="70" class="input02" readonly name="mgroup_name" onClick="JavaScript:checkCode()">  </td>
							</tr>
							<tr >								
								<td><input type=text size="70" class="input02" readonly name="sgroup_name" onClick="JavaScript:checkCode()"> </td>
							</tr>
						</table>
					</div>				
		</td>
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
		<td align=""  width="18%"><img src="<%=urlPage%>rms/image/icon_s.gif" >責任者:</td>
		<td width="32%"><input type="text" maxlength="100" name="fname" value="<%=bunData.getFname()%>" class="input02" style="width:160px"></td>
		<td align=""  width="20%"><img src="<%=urlPage%>rms/image/icon_s.gif" >保管場所:</td>
		<td width="30%"><input type="text" maxlength="200" name="basho" value="<%=bunData.getBasho()%>" class="input02" style="width:160px"></td>
	</tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >責任者/デジタルファイル:</td>
		<td><input type="text" maxlength="200" name="fname_digi" value="<%=bunData.getFname_digi()%>" class="input02" style="width:160px"></td>
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >保管場所/デジタルファイル:</td>
		<td><input type="text" maxlength="200" name="basho_digi" value="<%=bunData.getBasho_digi()%>" class="input02" style="width:160px"></td>
	</tr>
	<tr >
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >責任者/文書ファイル:</td>
		<td><input type="text" maxlength="100" name="fname_bun" value="<%=bunData.getFname_bun()%>" class="input02" style="width:160px"></td>
		<td align="" ><img src="<%=urlPage%>rms/image/icon_s.gif" >保管場所/文書ファイル:</td>
		<td><input type="text" maxlength="200" name="basho_bun" value="<%=bunData.getBasho_bun()%>" class="input02" style="width:160px"></td>
	</tr>	
	<tr>
		<td align=""  ><img src="<%=urlPage%>rms/image/icon_s.gif" >展示可否(View):</td>
		<td colspan="3">
			<input type="radio" name="view_yn"  value="0"  onfocus="this.blur()"  <%if(bunData.getView_yn()==0){%>checked<%}%>>Yes &nbsp;
			<input type="radio" name="view_yn"  value="1"  onfocus="this.blur()" <%if(bunData.getView_yn()==1){%>checked<%}%>>No
		</td>
	<tr>
				<td align=""  ><img src="<%=urlPage%>rms/image/icon_s.gif" >コメント:</td>
				<td colspan="3">
					<textarea   name="content" cols="80" rows="3" class="textarea"><%=bunData.getContent()%></textarea>
				</td>			
		</tr>
	</table>
<div class="clear_margin"></div>				
	<table width="920"  cellspacing="5" cellpadding="5">				
		<tr>
		<td align="center" style="padding:15px 0px 100px 0px;">
			<a href="JavaScript:goWrite();"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></a>
				&nbsp;
			<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></a>
		</td>
	</tr>			
</table>
</form>
</div>			
<script language="JavaScript">
var f=document.memberInput;
var d=document.all;	
function selectBank(){	
	if (f.pay_kind[0].checked==true)	{				
		d.pay_01.style.display="none";		
	}else if (f.pay_kind[1].checked==true)	{		
		d.pay_01.style.display="";		
	}		
}
function selectFile(){		
	if (f.fileKind[0].checked==true)	{				
		d.file_01.style.display="none";		
	}else if (f.fileKind[1].checked==true)	{		
		d.file_01.style.display="";		
	}		
}
</script>

