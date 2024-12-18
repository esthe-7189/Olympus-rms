<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.main.Bean" %>
<%@ page import = "mira.main.Mgr" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
	
<%	
String urlPage=request.getContextPath()+"/orms/";	
String urlPage2=request.getContextPath()+"/";	
String seq = request.getParameter("seq");

Mgr manager = Mgr.getInstance();	
Bean best=manager.getMainBestFocus(Integer.parseInt(seq)); 
int itemSeq=best.getItem_seq();

ProductManager tabmgr=ProductManager.getInstance();
	List listTab=tabmgr.selectMainBest(1);  //1(selectMainBest 1=自家軟骨細胞,2=collagen), 3(focus)
	List listTab2=tabmgr.selectMainBest(2);
	List listTab3=tabmgr.selectMainBest(3);
	
%>
<c:set var="listTab" value="<%= listTab %>" />
<c:set var="listTab2" value="<%= listTab2 %>" />
<c:set var="listTab3" value="<%= listTab3 %>" />
<c:set var="best" value="<%= best %>" />
<c:set var="itemSeq" value="<%= itemSeq %>" />
		
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Olympus RMS</title>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="title" content="olympus-rms.com" />
<meta name="author" content="www.ableu.com" />
<meta name="keywords" content="OLYMPUS RMS, BIO, collagen, chondron, cosmetic" />
<link href="<%=urlPage%>common/admin/css/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=urlPage%>common/admin/js/common.js"></script>
<script language="javascript" src="<%=urlPage%>common/admin/js/Commonjs.js"></script>
<script language="javascript" src="<%=urlPage%>fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="<%=urlPage%>hoan-jsp/castle.js"></script>

<script language="JavaScript">
				
				function codeMake(obj){					
					i = 0;					
					result = 0;				
					while (true){
						i = parseInt(Math.random()*9999);
						if (i > 1000){
							result = i;
							break;
						}
					}					
					   document.resultform.pcode_pg.value= document.resultform.ymd.value+result;					
									
				}

function goWrite(){
	var frm = document.resultform;	
	if(isEmpty(frm.title, "タイトルを書いて下さい!")) return;
	var str=frm.item_seq_val.value;
	var navi=str.split("_")
	frm.item_seq.value=navi[0];		
	frm.navi_kind.value=navi[1];	
	
if ( confirm("登録しましょうか?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>admin/main/update_local.jsp";	
frm.submit();		
}	
function resize(width, height){	
	window.resizeTo(width, height);
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center" onload="codeMake(document.resultform)">
<center>				
<table width="100%" border="0" cellspacing="0" cellpadding="0" >		
	<tr>		
		<td width="90%"  align="left"  style="padding-left:10px"  class="calendar7" >
    				<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">メインデザイン 書き直す
		</td>
	</tr>	  
</table>
<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
	<form name="frmList" action="<%=urlPage%>admin/main/update.jsp" method="post" onSubmit="return goWrite(this)">				
		<input type="hidden" name="seq" value="<%=seq%>">	
								<tr>
									<td align="left"  style="padding-left:2px"  width="15%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										商品選択</td>																	
									<td align="left"  style="padding-left:2px"  width="85%">
										<select name="item_seq_val">
	
<c:if test="${empty listTab}">
	<option value="">-----------</option>
</c:if>	
<c:if test="${! empty listTab}">
	<c:forEach var="tab" items="${listTab}" varStatus="idx" >
<option value="${tab.pseq}_${tab.category}"  <c:if test="${itemSeq==tab.pseq}">selected</c:if>>[自家軟骨細胞]${tab.title_m} </option>				
	</c:forEach>
</c:if>
		
		

<c:if test="${empty listTab2}">	
	<option value="">--------------</option>
</c:if>	
<c:if test="${! empty listTab2}">
	<c:forEach var="tab" items="${listTab2}" varStatus="idx" >
<option value="${tab.pseq}_${tab.category}"  <c:if test="${itemSeq==tab.pseq}">selected</c:if>>[コラーゲン]${tab.title_m} </option>						
	</c:forEach>
</c:if>	
	

	
<c:if test="${empty listTab3}">
	<option value="">----------------</option>
</c:if>	
	
<c:if test="${! empty listTab3}">
	<c:forEach var="tab" items="${listTab3}" varStatus="idx" >
<option value="${tab.pseq}_${tab.category}"  <c:if test="${itemSeq==tab.pseq}">selected</c:if>>[医療機器]${tab.title_m} </option>				
	</c:forEach>
</c:if>				
										</select>
										
									</td>
								</tr>																
								<tr>
									<td align="left"  style="padding-left:2px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										タイトル</td>																	
									<td align="left"  style="padding-left:2px"  >
										<input type="text" NAME="title"  VALUE="${best.title}" SIZE="20" maxlength="120"  class="logbox" style="width:320px">
										<font color="#807265">(▷100字まで)</font>
									</td>
								</tr>								
								<tr>
									<td align="left"  style="padding-left:2px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										内容</td>																	
									<td align="left"  style="padding-left:2px"  >
										<TEXTAREA  name="content"  cols="50" rows="3" wrap="hard"  onChange="CheckStr('55',this);" onKeyUp="CheckStr('55',this)">${best.content}</TEXTAREA>
										<font color="#807265">(▷55字まで)</font>
									</td>
								</tr>		
								<tr>
									<td align="left"  style="padding-left:2px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
										展示可否</td>																	
									<td align="left"  style="padding-left:2px"  >
										<c:if test="${best.view_yn==1}">
												<input type="radio" name="view_yn"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">はい</font>
												<input type="radio" name="view_yn"  value="2"  onfocus="this.blur();" >いいえ
										</c:if>										
										<c:if test="${best.view_yn==2}">
												<input type="radio" name="view_yn"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">はい</font>
												<input type="radio" name="view_yn"  value="2"  checked onfocus="this.blur();" >いいえ
										</c:if>	
									</td>
								</tr>	
								<tr>
									<td align="left"  style="padding-left:2px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
									イメージ</td>																	
									<td align="left"  style="padding-left:2px"  >
										<input type="file" name="imageFile" value="Find" size="50" style="cursor:pointer"  onChange='dreamkos_imgview()' class="logbox"><br>
										<font color="#807265">(▷イメージのサイズは <b>133*108 </b>pixelにしないとクォリティ－が低くなる可能性があります)</font>
														
									</td>
								</tr>			
					</table> 
<table align=center>									   
	<tr align="center">
			<td >
				<A HREF="JavaScript:alert('工事中');"><IMG SRC="<%=urlPage%>images/common/btn_off_submit.gif" ></A>
				&nbsp;
				<A HREF="JavaScript:goInit()"><IMG SRC="<%=urlPage%>images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>
</table>	
</center>	
</form>
</body>
</html>
	
<script language='JavaScript'>
function doselectLcode(kind) {	
  var selVal = document.frmList.all_seq_tab.options[document.frmList.all_seq_tab.selectedIndex].value;
  var selNm = document.frmList.all_seq_tab.options[document.frmList.all_seq_tab.selectedIndex].text;    	 
  var arr=selVal.split(",");
  var arrTitle=selNm.split("_");
  	document.frmList.junbang.value  = arr[0];  
  	document.frmList.seq_tab.value  = arr[1];  	
	document.frmList.name_tab.value  = arrTitle[1];	
}
function cateReset() {  
	document.frmList.reset();	 
	var oEditor=FCKeditorAPI.GetInstance('name_tab');
	var div=document.createElement("DIV");
		div.innerHTML=oEditor.GetXHTML();
	 	oEditor.SetHTML(" "); 	 	
}
</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			
			