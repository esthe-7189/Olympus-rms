<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>

<%
String urlPage=request.getContextPath()+"/";

String id=(String)session.getAttribute("ID");
String seq = request.getParameter("seq");	
String kind=(String)session.getAttribute("KIND");
String read=request.getParameter("read");
String inDate=dateFormat.format(new java.util.Date());


if(id.equals("candy")){
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

int mseq=0; int levelVal=0;
String title=""; 

MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}

ContractMgr mana = ContractMgr.getInstance();
ContractBeen board = mana.select(Integer.parseInt(seq));  ;             
        String kubun=board.getKubun();               
        String kanri_no=board.getKanri_no();  
        String contract_kind=board.getContract_kind();  
        String renewal=board.getRenewal();  
        String contact=board.getContact();  
        int sekining_mseq=board.getSekining_mseq();  
        int bseq=board.getBseq(); 	
        
String conCode=""; 
String con[]=kanri_no.split("-");              
 conCode=con[1];
 
 ContractBeen codeItem=mana.getCodeLimit();
 
 List listCode=mana.listCode(); 
 List listContractKind=mana.listContractKind();
 List listRenewal=mana.listRenewal();	
 List listContact=mana.listContact();	
 List listFollow=managermem.selectListSchedule(1,6);  //level 2부터
%>
<c:set var="board" value="<%= board %>" />
<c:set var="codeItem" value="<%= codeItem %>" />
<c:set var="member" value="<%= member %>" />	
<c:set var="listCode" value="<%= listCode %>" />
<c:set var="listContractKind" value="<%= listContractKind %>" />
<c:set var="listRenewal" value="<%= listRenewal %>" />
<c:set var="listContact" value="<%= listContact %>" />
<c:set var="listFollow" value="<%= listFollow %>" />
<c:set var="kubun" value="<%= kubun %>" />
<c:set var="kanri_no" value="<%= kanri_no %>" />
<c:set var="contract_kind" value="<%= contract_kind %>" />
<c:set var="renewal" value="<%= renewal %>" />	
<c:set var="contact" value="<%= contact %>" />
<c:set var="sekining_mseq" value="<%= sekining_mseq %>" />
<c:set var="bseq" value="<%= bseq %>" />	
 
	
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#date_begin").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#date_end").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
 $(function() {
   $("#hizuke").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
</script>		
<script language="javascript">
 function numbertogo(n){
   n=n.replace(/,/g,"");   if(isNaN(n)){return 0;} else{return n;}
  }
function formSubmit(){        
	  var frm = document.forminput;			
	  var nameMseq=frm.sekiningNm.options[frm.sekiningNm.selectedIndex].value;	  

 	  if(isEmpty(frm.kanri_no, "管理番号を記入して下さい。")) return ; 	 
	  if(isEmpty(frm.contract_kind, "契約形態を記入して下さい。")) return ;    	     	  	  
	  if(isEmpty(frm.contact, "契約先を記入して下さい。")) return ;
	  if(isEmpty(frm.content, "契約内容を記入して下さい。")) return ;
	  if(isEmpty(frm.renewal, "更新を記入して下さい。")) return ;

//	frm.kanri_no.value ="契-"+frm.kanri_no.value; 
	frm.sekining_mseq.value =nameMseq;
//	frm.sekining_nm.value =frm.sekiningNm.options[frm.sekiningNm.selectedIndex].text;	  
	 if(nameMseq=="0"){alert("担当者を選択して下さい。"); return ;}						
	 
	 with (document.forminput) {
    	    if(fellow_yn[0].checked==true){         	     	    	
		file_manual.value="<%=board.getFile_nm()%>";		
	    }	  
	    if(fellow_yn[1].checked==true){         	 
		if (fileNm.value=="") {
	            alert("ファイルを選択して下さい。あるいは「契約書修正」の「しない」をチェックしてください。");
	            fileNm.focus();   return;	
	        }else{
	            file_manual.value="NO";	
	            file_manualMoto.value="<%=board.getFile_nm()%>";
	        }
	   }	 
	 } 	 

	 if(frm.date_begin.value !=""){
	 	if(frm.date_begin.value.length >10){frm.date_begin.value=frm.date_begin.value.substring(0,10);}
	 	var yyyymmdd    = frm.date_begin.value.replace(/-/g, "");
	    	var week        = new Array("日", "月", "火", "水", "木", "金", "土");
	    	var yyyy        = yyyymmdd.substr(0, 4);
	    	var mm          = yyyymmdd.substr(4, 2);
	    	var dd          = yyyymmdd.substr(6, 2);
	    	var date        = new Date(yyyy, mm - 1, dd);
	    	frm.date_begin.value=frm.date_begin.value+"("+week[date.getDay()]+")";	    	
	 }
	 if(frm.date_end.value !=""){
	 	 if(frm.date_end.value.length >10){frm.date_end.value=frm.date_end.value.substring(0,10);}	 
	 	var yyyymmdd2    = frm.date_end.value.replace(/-/g, "");
	    	var week2        = new Array("日", "月", "火", "水", "木", "金", "土");
	    	var yyyy2        = yyyymmdd2.substr(0, 4);
	    	var mm2          = yyyymmdd2.substr(4, 2);
	    	var dd2          = yyyymmdd2.substr(6, 2);
	    	var date2        = new Date(yyyy2, mm2 - 1, dd2);
	    	frm.date_end.value=frm.date_end.value+"("+week2[date2.getDay()]+")";	    	
	 } 
	 	
      if ( confirm("修正しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>rms/admin/contract/update.jsp";	
	frm.submit(); 
   }   


 //kanri 직접 입력
 function dataServ(id){
  var frm = document.forminput;
   	if(id=="contract_kindVal"){	  
	  var kanriNo2 = frm.contract_kindVal.options[frm.contract_kindVal.selectedIndex].text; 
	  frm.contract_kind.value=kanriNo2;	  
	}else if(id=="renewalVal"){	  
	  var kanriNo3 = frm.renewalVal.options[frm.renewalVal.selectedIndex].text; 
	  frm.renewal.value=kanriNo3;	  
	}else if(id=="contactVal"){	  
	  var kanriNo4 = frm.contactVal.options[frm.contactVal.selectedIndex].text; 
	  frm.contact.value=kanriNo4;	  
	}	
  }
   

function kanriservEtc(id) {
  var urlname = "kubunNew.jsp?kind="+id;
  addr_etc = window.open(urlname, "win1","status=no,resizable=no,menubar=no,scrollbars=no,width=200,height=120");
  addr_etc.focus();
} 

function goInit(){
	document.forminput.reset();
}
</script>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  
	<span class="calendar7">契約書リスト管理 <font color="#A2A2A2">    >   </font>
		<%if(read.equals("update")){%> 修正する <%}%>
		<%if(read.equals("read")){%> 内容 <%}%>
	</span> 
	
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>rms/admin/contract/listForm.jsp'">	
	<!--<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>rms/admin/contract/addForm.jsp'">-->			
</div>
<div id="boxNoLine_900"  >		
<%if(read.equals("update")){%>
<table  width="950" border="0" cellspacing="2" cellpadding="2" >								
		<tr>
			<td  align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">  情報入力		
			</td>						
		</tr>	
</table>	
<div class="clear_margin"></div>	
<table width="960" cellpadding="0" cellspacing="0">		
<tr>
    <td style="padding: 0px 0px 2px 15px">    	
   		<font color="#807265">※管理番号： <span class="calendar16_1"> 使っている番号</span>は重ねて使えません。それを参考して管理番号を決めて下さい。</font><br>
      	 	<font color="#807265">※契約期間 / 契約日：特定の日付を指定しない場合は[0000-00-00]のようにして下さい。</font>
    </td>     
    <td align="right" valign="bottom" style="padding: 0px 20px 0px 0px">
    		<font color="#CC0000">※</font>必修です。
    </td>
</tr>
</table>						
<%}%>

<table width="950"  class="tablebox" cellspacing="5" cellpadding="5" >				
	<form name="forminput" method=post  action="<%=urlPage%>rms/admin/contract/update.jsp" enctype="multipart/form-data">				
		<input type='hidden' name="seq" value="<%=seq%>">		
		<input type='hidden' name="file_manual" value="${board.file_nm}">	
		<input type='hidden' name="file_manualMoto" value="${board.file_nm}">				
		<input type='hidden' name="bseq" value="<%=seq%>">					
		<input type="hidden" name="sekining_mseq" value="">	
		<input type="hidden" name="sekining_nm" value="${board.sekining_nm}">		
		<input type='hidden' name="kanri_noVal" value="">								
		<input type='hidden' name="kubun" value="">												
			<tr >								
				<td width="10%"><font color="#CC0000">※</font><span class="titlename">契約区分</span></td>
				<td width="50%" >${board.kubun}</td>
				<td width="10%"><font color="#CC0000">※</font><span class="titlename">担当者</span></td>
				<td width="30%">${board.sekining_nm}</td>
			</tr>
			<tr >								
				<td ><font color="#CC0000">※</font><span class="titlename">管理No</span></td>
				<td> <span class="calendar16_1"> 使えない番号:</span>
				<select name="codeVal" >
<c:if test="${empty listCode}">
						<option  value="0">既存データなし</option>					
</c:if>
<c:if test="${! empty listCode}">
	<c:forEach var="code" items="${listCode}" varStatus="index" >
		<c:if test="${kanri_no==code.kanri_no}">
						<option  value="${code.kanri_no}"   selected>${code.kanri_no}</option>
		</c:if>	
		<c:if test="${kanri_no!=code.kanri_no}">
						<option  value="${code.kanri_no}" > ${code.kanri_no}</option>
		</c:if>		
	</c:forEach>
</c:if>									
					</select>&nbsp; &nbsp;&nbsp; <span class="calendar16_1"> 番号:	</span>	
					<span class="calendar15">契 - </span>
					<input type="text" maxlength="30" name="kanri_no" value="<%=conCode%>" class="input02" style="width:100px"><font color="#807265">(▷数字のみ入力)</font>				
				</td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">更新ｱﾗｰﾄ</span></td>
				<td >			
					<input type="radio" name="renewal_yn"  value="1"  onfocus="this.blur()" <%if(board.getRenewal_yn()==1){%>checked<%}%>>ON &nbsp;
					<input type="radio" name="renewal_yn"  value="2"  onfocus="this.blur()" <%if(board.getRenewal_yn()==2){%>checked<%}%>>OFF
				</td>
			</tr>			
			<tr >				
				<td ><font color="#CC0000">※</font><span class="titlename">契約期間</span></td>
				<td ><input type="text" size="12%" name="date_begin" id="date_begin"  value="${board.date_begin}" > 
					～ <input type="text" size="12%" name="date_end" id="date_end"  value="${board.date_end}">
				</td>
				<td ><font color="#CC0000">※</font><span class="titlename">契約日</span> </td>
				<td width="25%"><input type="text" size="12%" name="hizuke" id="hizuke"  value="${board.hizuke}"></td>
			</tr>			
</table>					
<div class="clear_margin"></div>								
<table width="950"   class="tablebox" cellspacing="2" cellpadding="2">													
			<tr>
				<td ><font color="#CC0000">※</font><span class="titlename">契約形態</span></td>
				<td colspan="3" >
					<select name="contract_kindVal" onChange="return dataServ('contract_kindVal');">
<c:if test="${empty listContractKind}">
						<option  value="0">既存データなし</option>					
</c:if>
<c:if test="${! empty listContractKind}">
						<option  value="0">既存データをみる</option>	
	<c:forEach var="code" items="${listContractKind}" varStatus="index" >
			<c:if test="${contract_kind==code.contract_kind}">						            							
					<option  value="${code.contract_kind}"  selected>${code.contract_kind}</option>   
			</c:if>	
			<c:if test="${contract_kind!=code.contract_kind}">				            							
					<option  value="${code.contract_kind}"  >${code.contract_kind}</option>	
			</c:if>						
	</c:forEach>
</c:if>									
					</select>										
				</td>										
			</tr>
			<tr>
				<td class="clear_dot">&nbsp;</td>
				<td class="clear_dot" colspan="3" >					
					<input type="text" maxlength="30" name="contract_kind" value="${board.contract_kind}" class="input02" style="width:370px"> 
					<font color="#807265">(▷例：契約書 / 覚書/ 申請書/ その他 )</font>					
				</td>										
			</tr>																		
			<tr >
				<td ><font color="#CC0000">※</font><span class="titlename">契約先</span></td>
				<td  colspan="3">
					<select name="contactVal" onChange="return dataServ('contactVal');">
<c:if test="${empty listContact}">
						<option  value="0">既存データなし</option>					
</c:if>
<c:if test="${! empty listContact}">
						<option  value="0">既存データをみる</option>	
	<c:forEach var="code" items="${listContact}" varStatus="index" >
			<c:if test="${contact==code.contact}">						            							
					<option  value="${code.contact}"  selected>${code.contact}</option>   
			</c:if>	
			<c:if test="${contact!=code.contact}">				            							
					<option  value="${code.contact}"  >${code.contact}</option>
			</c:if>								
	</c:forEach>
</c:if>									
					</select>								
				</td>
			</tr>
			<tr >
				<td class="clear_dot">&nbsp;</td>
				<td class="clear_dot" colspan="3">					
					<input type="text" maxlength="200" name="contact" value="${board.contact}"  class="input02" style="width:370px"> <font color="#807265">(▷200文字)</font>						
				</td>
			</tr>											
			<tr >
				<td class="clear_dot"><font color="#CC0000">※</font><span class="titlename">契約内容</span></td>
				<td class="clear_dot" colspan="3"><input type="text" maxlength="100" name="content" value="${board.content}" class="input02" style="width:370px"> <font color="#807265">(▷100文字以下)</font></td>
			</tr>
			<tr>
				<td ><font color="#CC0000">※</font><span class="titlename">更新</span></td>
				<td >
					<select name="renewalVal" onChange="return dataServ('renewalVal');">
<c:if test="${empty listRenewal}">
						<option  value="0">既存データなし</option>					
</c:if>
<c:if test="${! empty listRenewal}">
						<option  value="0">既存データをみる</option>	
	<c:forEach var="code" items="${listRenewal}" varStatus="index" >
			<c:if test="${renewal==code.renewal}">						            							
					<option  value="${code.renewal}"  selected>${code.renewal}</option>   
			</c:if>	
			<c:if test="${renewal!=code.renewal}">				            							
					<option  value="${code.renewal}"  >${code.renewal}</option>
			</c:if>																				
	</c:forEach>
</c:if>									
					</select>															
				</td>	
			</tr>
			<tr>
				<td class="clear_dot">&nbsp;</td>
				<td class="clear_dot"><input type="text" maxlength="100" name="renewal" value="${board.renewal}" class="input02" style="width:370px"> <font color="#807265">(▷100文字)</font></td>	
			</tr>
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">タイトル</span></td>
				<td  colspan="3"><input type="text" maxlength="100" name="title" value="${board.title}" class="input02" style="width:300px"> <font color="#807265">(▷100文字以下)</font></td>
			</tr>				
</table>				
<div class="clear_margin"></div>								
<table width="950"   class="tablebox" cellspacing="5" cellpadding="5">		
	<tr>			
		<td  width="10%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">既存の契約書</span></td>		
		<td width="90%">
				<font color="#993300">
<c:choose>
	<c:when test="${board.file_nm=='no data'}"> 
	    契約書なし
	</c:when>
	<c:when test="${empty board.file_nm}">
	    契約書なし
	</c:when>
	<c:when test="${!empty board.file_nm}">
	    ${board.file_nm}
	</c:when>
	<c:otherwise>
	    ${board.file_nm}
	</c:otherwise>
</c:choose></font>					
								
<%if(read.equals("update")){%>
			<font color="#993300">===></font>	 		
			契約書修正 :
			<input type="radio" name="fellow_yn" value="1" onClick="fellow02()" onfocus="this.blur()" checked><font  color="#FF6600">しない</font>
			<input type="radio" name="fellow_yn" value="2" onClick="fellow01()" onfocus="this.blur()"><font  color="#FF6600">修正する</font>
				<br>
				<div id="fellow" style="display:none;overflow:hidden ;border:1px solid #99CC00;width:90%;padding:5px 2px 5px 2px;"  >
				ニュー契約書 : <input type="file" size="80"  name="fileNm" class="file_solid">
				</div>
<%}%>			
		
		</td>		
	</tr>				
	
	<tr>	
		<td  ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">備　　考</span></td>
		<td  ><input type=text size="80" class="input02"  name="comment" maxlength="100" value="${board.comment}"></td>			
	</tr>
</table>
<%if(read.equals("update")){%>								
<table  width="950" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15px 0px 50px 0px;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage%>orms/images/common/btn_off_submit.gif" ></a>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>orms/images/common/btn_off_cancel.gif" ></a>
			</td>			
	</tr>			
</table>	
<%}%>				
</form>	
</div>							
<!-- item end *****************************************************************-->				
		
<script type="text/javascript">
function fellow01(){document.getElementById("fellow").style.display=''; }
function fellow02(){document.getElementById("fellow").style.display='none'; }

</script> 
			