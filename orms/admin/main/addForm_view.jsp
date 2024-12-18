<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.main.Bean" %>
<%@ page import = "mira.main.Mgr" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>
<%! 
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");	
 	static int PAGE_SIZE=15; 
 %>
<%
String today=formatter.format(new java.util.Date());	
String urlPage=request.getContextPath()+"/orms/";	
String urlPage2=request.getContextPath()+"/";	


String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	

	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");

	List whereCond = null;
	Map whereValue = null;

	boolean searchCondContent = false;
	boolean searchCondTitle = false;	

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("title")){
				whereCond.add("title LIKE '%"+searchKey+"%'");		
				searchCondTitle = true;
			}else if (searchCond[i].equals("content")){
				whereCond.add("content LIKE '%"+searchKey+"%'");		
				searchCondContent = true;
			}
		}
	}

	Mgr manager = Mgr.getInstance();	
	int count = manager.count(1,whereCond, whereValue);
	int totalPageCount = 0; //전체 페이지 개수를 저장
	int startRow=0, endRow=0;
	if (count>0){
		totalPageCount=count/PAGE_SIZE;
		if (count % PAGE_SIZE > 0)totalPageCount++;
		
		startRow=(currentPage-1)*PAGE_SIZE+1;
		endRow=currentPage*PAGE_SIZE;
		if(endRow > count) endRow = count;
	}
	if(count<=0){
		startRow=startRow-0;
		endRow=endRow-0;
	}else if(count>0){
		startRow=startRow-1;
		endRow=endRow-1;
	}
	
	List  list=manager.selectList(1,whereCond, whereValue,startRow,endRow);	
	ProductManager tabmgr=ProductManager.getInstance();
	List listTab=tabmgr.selectMainBest(1);  //1(selectMainBest 1=自家軟骨細胞,2=collagen), 3(focus)
	List listTab2=tabmgr.selectMainBest(2);
	List listTab3=tabmgr.selectMainBest(3);
	
%>
<c:set var="list" value="<%= list %>" />
<c:set var="listTab" value="<%= listTab %>" />
<c:set var="listTab2" value="<%= listTab2 %>" />
<c:set var="listTab3" value="<%= listTab3 %>" />


<script language="javascript">
// 한줄쓰기 토글 함수
function ShowHidden(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.itemData_block" + i + ".style");		
		if ( i == ShowMenuID ){
			if ( menu.display == "block" )
				menu.display	= "none";
			else 
				menu.display	= "block";
		} 
		else 
			menu.display	= "none";
	}
	frame_init();
} 

function popup_Layer(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     // 좌우 위치 지정
     if(_marginx < 0){
        main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px";
     }
     else{
        main.style.left = event.clientX + document.body.scrollLeft-5+"px";
     }
     //높이 지정
     if(_marginy < 0){
        main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";
     }  
     else{
        main.style.top = event.clientY + document.body.scrollTop-5+"px";
     } 
}  
function Layer_popup_Off() { 
  var frm=document.frm;
  var pay_len = eval(frm.divPassTab.length);  
  var pay_val=frm.divPassTab;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
} 
</script>		
<script type="text/javascript">
// 카테고리 코드 가져오기


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
frm.action = "<%=urlPage%>admin/main/add.jsp";	
frm.submit();		
}	
	
function goInit(){
	var frm = document.venderChk;
	frm.reset();
}
function CheckStr(maxlen,field){
	var temp;
	var msglen;
	msglen=maxlen*2;
	var value=field.value;
	
	giri=field.value.length;
	tempstr="";
	if(giri==0){
		value=maxlen*2;
	}else{
		for(k=0;k<giri;k++){
			temp=value.charAt(k);
			if(escape(temp).length>4){
				msglen -=2;
			}else{
				msglen--;
			}
			if(msglen <0){
				alert("アルファベット"+(maxlen*2)+"字, ひらがな及び漢字"+maxlen+"字まで書けます.");
				field.value=tempstr;
				break;
			}else{
				tempstr +=temp;
			}
		}
	}
	
}
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">メインデザイン 
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" >
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=80);"> Best Product
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>
</table>	
<p>
<!-- 내용 시작 *****************************************************************-->
				  
<table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">
		<form action="<%=urlPage%>admin/main/add.jsp" method="post"  name="resultform"  enctype="multipart/form-data">		
						<input type="hidden" name="seq" >		
						<input type="hidden" name="ymd" value="<%=today%>">
						<input type="hidden" name="pcode_pg" value="">		
						<input type="hidden" name="navi_kind" >	<!-- category  1(自家軟骨細胞) , 2(コラーゲン),3(医療機器)-->
						<input type="hidden" name="pg_kind" value="1">	<!-- 1(商品) , 2(関連情報)-->	
						<input type="hidden" name="item_seq" >
						
		<tr>
			<td align="left"  width="15%"  style="padding-left:30px;padding-top:10px" class="calendar9">
				<img src="<%=urlPage%>images/common/ArrowNews.gif">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=30);">書く</td>
			<td align="left" width="75%" style="padding-top:10px" ><font color="#CC0000">※</font>必修項目</td>				
			<td align="right" width="10%" style="padding-right:30px;padding-top:10px" >
				<input type="button" name="" value="メインデザイン" onclick="location.href='<%=urlPage%>admin/main/mainForm.jsp'" id="main design!"  title="List!" class="button buttonGeneral" />					
			</td>
		</tr>
		<tr>
			<td align="center" colspan="3">						
						<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
								<tr>
									<td align="left"  style="padding-left:10px"  width="15%" bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										商品選択</td>																	
									<td align="left"  style="padding-left:10px"  width="85%">
										<select name="item_seq_val">
<c:if test="${empty listTab}">
	<option value="">No Data</option>
</c:if>	
<c:if test="${! empty listTab}">
	<c:forEach var="tab" items="${listTab}" varStatus="idx" >
<option value="${tab.pseq}_${tab.category}">[<c:if test="${tab.category==1}">自家軟骨細胞</c:if>
					<c:if test="${tab.category==2}">コラーゲン</c:if>
					<c:if test="${tab.category==3}">医療機器</c:if>]${tab.title_m}
</option>				
	</c:forEach>
</c:if>	
			
<c:if test="${empty listTab2}">
	<option value="">--------------</option>
</c:if>	
<c:if test="${! empty listTab2}">
	<c:forEach var="tab" items="${listTab2}" varStatus="idx" >
<option value="${tab.pseq}_${tab.category}">[<c:if test="${tab.category==1}">自家軟骨細胞</c:if>
					<c:if test="${tab.category==2}">コラーゲン</c:if>
					<c:if test="${tab.category==3}">医療機器</c:if>]${tab.title_m}
</option>				
	</c:forEach>
</c:if>	
<c:if test="${empty listTab3}">
	<option value="">----------------</option>
</c:if>	
	
<c:if test="${! empty listTab3}">
	<c:forEach var="tab" items="${listTab3}" varStatus="idx" >
<option value="${tab.pseq}_${tab.category}">[<c:if test="${tab.category==1}">自家軟骨細胞</c:if>
					<c:if test="${tab.category==2}">コラーゲン</c:if>
					<c:if test="${tab.category==3}">医療機器</c:if>]${tab.title_m}
</option>				
	</c:forEach>
</c:if>				
										</select>
										
									</td>
								</tr>																
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										タイトル</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="text" NAME="title"  VALUE="" SIZE="20" maxlength="120"  class="logbox" style="width:550px">
										<font color="#807265">(▷100字まで入力できます。)</font>
									</td>
								</tr>								
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><font color="#CC0000">※</font>
										内容</td>																	
									<td align="left"  style="padding-left:10px"  >
										<TEXTAREA  name="content"  cols="80" rows="2" wrap="hard"  onChange="CheckStr('55',this);" onKeyUp="CheckStr('55',this)"></TEXTAREA>
										<font color="#807265">(▷55字まで入力できます。)</font>
									</td>
								</tr>		
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
										メインに見える</td>																	
									<td align="left"  style="padding-left:10px"  >
										<input type="radio" name="view_yn" value="1" checked>はい									
										<input type="radio" name="view_yn" value="2"  >いいえ						
									</td>
								</tr>	
								<tr>
									<td align="left"  style="padding-left:10px"   bgcolor="#F1F1F1"><img src="<%=urlPage%>images/common/ArrowNews.gif" >
										メイン　イメージ</td>																	
									<td align="left"  style="padding-left:15px"  >
										<input type="file" name="imageFile" value="Find" size="80" style="cursor:pointer"  onChange='dreamkos_imgview()' class="logbox"><br><br>
										<font color="#807265">(▷イメージのサイズは <b>133*108 </b>pixelにしないとクォリティ－が低くなる可能性があります)</font>
														
									</td>
								</tr>			
					</table>
				</td>
			</tr>
	</table>
<table align=center>									   
	<tr align="center">
			<td >
				<A HREF="JavaScript:goWrite()"><IMG SRC="<%=urlPage%>images/common/btn_off_submit.gif" ></A>
				&nbsp;
				<A HREF="JavaScript:goInit()"><IMG SRC="<%=urlPage%>images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>
</form>
</table>			
<p>								
<table border="0" cellpadding="0" cellspacing="0" class=c width="100%"  bgcolor="#F7F5EF">
		<tr>
			<td align="left"  style="padding-left:30px;padding-top:10px" class="calendar9">
				<img src="<%=urlPage%>images/common/ArrowNews.gif">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=30);">全体リスト</td>			
		</tr>
		<tr>
			<td  style="padding-top:5px;" >							
				<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
					<tr>
					<td style="padding: 2 0 2 0">

<table width="95%" border='0' cellpadding='0' cellspacing='1'>
<form name="move" method="post">
    <input type="hidden" name="seq" value="">    
    <input type="hidden" name="okYn">
    <input type="hidden" name="page" value="${currentPage}">
    <c:if test="<%= searchCondContent %>">
    <input type="hidden" name="search_cond" value="content">
    </c:if>    
    <c:if test="<%= searchCondTitle%>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>
</form>
	<tr>
	<form name="search"  action="<%=urlPage%>admin/main/addForm.jsp?page=1" method="post">		
		<td valign="middle" width="17%">			
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="select_type2" onKeyPress="return doSubmitOnEnter()">
			            <option name="search_cond" VALUE="title"  >タイトル</OPTION>
			          	<option name="search_cond" VALUE="content"  >内容</OPTION>			          	
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="20%" align="left">
		 	<input type=text  name="search_key" size="30"  class="input02" >
		 </td>
		 <td valign="middle" width="10%" align="left">		 			  
		 	<input type="submit" name="" value="検索"  id="Search" title="SEARCH!" class="button buttonBright" />
		 </td>
		 <td valign="middle" width="53%" align="left">
		 	<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/main/addForm.jsp?page=1'" id="LIST!"  title="LIST!" class="button buttonBright" />		  
		 </td>		 		
	</tr>
	</form>
</table>
<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
	<form name="frm">
			<tr bgcolor="" align=center height=26>				
				<td  width="20%"  bgcolor=#F1F1F1>区分</td>
				<td  width="45%"  bgcolor=#F1F1F1>タイトル</td>						
				<td  width="15%" bgcolor=#F1F1F1>登録日</td>				
				<td   width="10%" bgcolor=#F1F1F1>展示可否</td>				
				<td   width="5%" bgcolor=#F1F1F1>修正</td>
				<td   width="5%" bgcolor=#F1F1F1>削除</td>				
			</tr>			
			<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td colspan="6">登録された内容がありません。</td></tr>
			</c:if>
			<c:if test="${! empty list}">
			<c:forEach var="product" items="${list}" varStatus="idx">
			<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" >						
				<td>
					<c:if test="${product.navi_kind==1}">自家軟骨細胞</c:if>
					<c:if test="${product.navi_kind==2}">コラーゲン</c:if>
					<c:if test="${product.navi_kind==3}">医療機器</c:if>
				</td>
				<td  align="left">					
					<a href="javascript:ShowHidden('itemData_block','${idx.index+1}');"  onFocus="this.blur()">
					${product.title}</a>
				</td>				
				<td><fmt:formatDate value="${product.register}" pattern="yyyy-MM-dd" /></td>
				<td  align="center">	
	<input type="hidden" name="divPassTab" value="popupCo_${idx.index+1}">	
<!-- *****************************레이어 view start-->
<div id="popupCo_${idx.index+1}" style="border:1px solid #CC3300;position:absolute; left:0px; top:0px; z-index:999;display:none;filter: alpha(opacity=95);" >
	<table border="0" width="190" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td class="calendar9" >展示可否変更</td>
		     	<td align="right"><a onclick="Layer_popup_Off();"  style="CURSOR: pointer;"><img src="<%=urlPage2%>orms/images/common/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="190" bgcolor="#f4f4f4" class=c  cellspacing=0 cellpadding=0  >	     	
         <tr> 
    		<td  style="padding:2 0 2 2;" >
 	<c:if test="${product.view_yn==1}">
			<input type="radio" name="levelVal_${product.seq}"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">はい</font>
			<input type="radio" name="levelVal_${product.seq}"  value="2"  onfocus="this.blur();" >いいえ
	</c:if>										
	<c:if test="${product.view_yn==2}">
			<input type="radio" name="levelVal_${product.seq}"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">はい</font>
			<input type="radio" name="levelVal_${product.seq}"  value="2"  checked onfocus="this.blur();" >いいえ
	</c:if>		
    		
	    	</td>                	
            <td  style="padding:2 3 5 0;" >
			<a href="javascript:goChange('${product.seq}');" onfocus="this.blur()"><img src="<%=urlPage2%>rms/image/ic_go.gif" align="asbmiddle"></a>
            </td>
            </tr>            	
     </table>
</div>
<!-- ********************************레이어view end -->	
				<a onclick="popup_Layer(event,'popupCo_${idx.index+1}');" style="CURSOR: pointer;">	
					<c:if test="${product.view_yn==1}">はい</c:if>
					<c:if test="${product.view_yn==2}">いいえ</c:if></a>
				</td>				
				<td>				
					<a href="javascript:openScrollWin('<%=urlPage%>admin/main/updateForm_pop.jsp','popUpdate','상세보기','550','250',
					'&seq=${product.seq}');"  onfocus="this.blur()">
						<img src="<%=urlPage%>images/admin/icon_admin_pen.gif" alt="Modify" >
					</a>
				</td>
				<td>
					<a href="javascript:goDelete('${product.seq}')"  onfocus="this.blur()">
					<img src="<%=urlPage%>images/admin/icon_admin_x.gif" alt="Cancel">
					</a></td>
			</tr>
			<tr>
				<td  style="padding-top: 0px;" colspan="8" align="center" width="90%" valign="top">
					<span id="itemData_block${idx.index+1}" style="DISPLAY:none; xCURSOR:hand">								
									<table width=80% border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2 >																									　　　　　　　　　								
										<tr>	
											<td style="padding: 5 5 5 5" bgcolor=#F1F1F1 width="10%" align="center">内容:</td>							
											<td style="padding: 5 5 5 5" bgcolor=#FFFFFF width="60%" align="left">						
												${product.content}
											</td>
											<td style="padding: 5 5 5 5" bgcolor=#F1F1F1 width="10%" align="center">image:</td>							
											<td style="padding: 5 5 5 5" bgcolor=#FFFFFF width="20%">						
												<img src="<%=urlPage%>images/main/best/${product.img}_sub.jpg" >
											</td>
										</tr>																
									</table>								
					</span>
				</td>
			</tr>									
			</c:forEach>
			</c:if>
		</table>
<table>
<tr>
	<td height="14">&nbsp;<td>
</tr>
</table>

<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>admin/main/addForm.jsp";
    document.move.page.value = pageNo;
    document.move.submit();
}
function goChange(seq) {    
      var jinoValue=eval("document.frm.levelVal_"+seq); 
	var valueMseq=(jinoValue[0].checked==true) ?  "1" : "2";		
	document.move.action = "<%=urlPage%>admin/main/viewOk.jsp";
      document.move.seq.value = seq;	
	document.move.okYn.value = valueMseq;
	document.move.submit();
}
function goModify(seq) {
	document.move.action = "<%=urlPage%>admin/main/updateForm.jsp";
	document.move.seq.value=seq;
    	document.move.submit();
}
function goDelete(seq) {
	document.move.seq.value=seq;	
	
	if ( confirm("本内容を削除しましょうか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>admin/main/deleteOk.jsp";	
    	document.move.submit();
}

</script>

<!-- *****************************page No start******************************-->		
<c:set var="count" value="<%= Integer.toString(count) %>" />
<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
		
<table cellpadding=0 cellspacing=0 border=0 height=20 align="center" width="45%">
	<tr>
<c:if test="${count > 0}">
    <c:set var="pageCount" value="${count / PAGE_SIZE + (count % PAGE_SIZE == 0 ? 0 : 1)}" />
    <c:set var="startPage" value="${currentPage - (currentPage % 10) + 1}" />
    <c:set var="endPage" value="${startPage + 10}" />
    
    
    <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}" />
    </c:if>
    			
	<c:if test="${startPage > 10}">
        	<td  style="padding-right:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>images/admin/LeftBox.gif"></a>
		</td>
    	</c:if>    	
        	<td  style="padding-right:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<img src="<%=urlPage%>images/admin/LeftBox.gif" style="filter:Alpha(Opacity=40);">
		</td>  
		<td align=center valign=absmiddle width="70%">
			<table cellpadding=0 cellspacing=0 border=0 style='table-layout:fixed;'>
				<tr><td width="" align="center">
	<c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
        	<c:if test="${currentPage == pageNo}">
					<b><font class="red"></c:if>
						<a href="javascript:goPage(${pageNo})" onfocus="this.blur()" class="paging">${pageNo}</a>						
		<c:if test="${currentPage == pageNo}"></font></b></c:if>
    	</c:forEach>
    					</td>
				</tr>
			</table>
		</td>
	<c:if test="${endPage < pageCount}">
        	<td width="" style="padding-left:8" valign=absmiddle style="padding-top:4px;">
			<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>images/admin/RightBox.gif"></a>
		</td>
    	</c:if>
		<td  style="padding-left:8" valign=absmiddle style="padding-top:4px;">			
			<img src="<%=urlPage%>images/admin/RightBox.gif" style="filter:Alpha(Opacity=40);">
		</td>			
</c:if>
		
		<c:if test="<%= count >= 0 %>">
		<td   width="50" style="padding-left:8" style="padding-top:4px;">			
			total:<font color="#807265">(<%= count %>)</font>		
		</td>	
		</c:if>
   </tr>
</table>
<!-- *****************************page No end-->					

<td>
</tr>
<tr>
	<td valign="middle" >	
<c:if test="<%= searchCondContent ||  searchCondTitle %>">
	検索条件: [	
	<c:if test="<%= searchCondContent %>">内容</c:if>
	<c:if test="<%= searchCondTitle %>">タイトル</c:if>	
	= 
	<%=searchKey%> ]
			
</c:if>
		</td> 		
</td>
</table>
			
			
			
			
			
			
			
			