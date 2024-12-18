<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>

<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>

<%
/*-----DB Table: purchase_order
등록년월일 resister
발주처  contact_ordert
작성자 mseq
참조테이블  item_seq
합계  total_price
결재자1   sign_01
결재자2   sign_02
결재자3   sign_03
결재자승인여부1   sign_01_yn
결재자승인여부2   sign_02_yn
결재자승인여부3   sign_03_yn
기타        comment
시급/보통 kind_urgency    (1은 보통, 2는 시급)
주문날짜     hizuke

----참조 DB Table: purchase_order_item
seq
품명  product_nm
발주번호  order_no
발주량   product_qty
단가  unit_price
의뢰자 client_nm
----------------*/
String urlPage=request.getContextPath()+"/orms/";	
String urlPage2=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String inDate=dateFormat.format(new java.util.Date());
String src_item=request.getParameter("src_item");
if(src_item==null){src_item="0";}
int cnt_item=Integer.parseInt(src_item);

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}

int mseq=0;

MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}
Member memTop=managermem.getMember(id);		
List listFollow=managermem.selectListSchedule(1,6);
MgrOrderBunsho mgrOrder = MgrOrderBunsho.getInstance();
List listContact_order=mgrOrder.listContact_order();
%>
<c:set var="memTop" value="<%=memTop%>"/>	
<c:set var="listFollow" value="<%=listFollow%>"/>	
<c:set var="member" value="<%=member%>"/>
<c:set var="listContact_order" value="<%=listContact_order%>"/>
	
<link href="<%=urlPage2%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage2%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage2%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#hizuke").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage2%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

</script>	

<script language="javascript">
function goInit(){
	var frm = document.frm;
	frm.reset();
}
function clean(e){		    		
	 var regex = /[^0-9,]/gi;	
	 if(e.search(regex) > -1) {	 	 	 	
		 	 document.getElementById("memssage").value=" ※(発注数/単価)は 数字のみ入力して下さい";  return;    	 		 	 
	 	}				    			   
    	keisan();        	
}


  //숫자에서 콤마를 빼고 반환.
  function numbertogo(n){
   n=n.replace(/,/g,"");   if(isNaN(n)){return 0;} else{return n;}
  }
  // 숫자를 변환..
  function addComma(n) {
   if(isNaN(n)){return 0;}
    var reg = /(^[+-]?\d+)(\d{3})/;   
    n += '';
    while (reg.test(n))
      n = n.replace(reg, '$1' + ',' + '$2');
    return n;    
  }
    
function keisan(){
	var unit_price_total=document.getElementById("unit_price_total");	
	var product_qty = document.getElementsByName("product_qty");
	var unit_price = document.getElementsByName("unit_price");	
    	var unit_price_all = document.getElementsByName("unit_price_all");
	var qtyVal=0;
	var  priceVal=0;
	var totalM=0;
	var totalPrice=0;			    				    				    	
			    	for(var i = 0; i < product_qty.length; i++) {
			    		//if(product_qty[i].value==""){	product_qty[i].value="0";}
			    		//if(unit_price[i].value==""){ unit_price[i].value="0";}
			    		qtyVal =numbertogo(product_qty[i].value) +"*"+numbertogo(unit_price[i].value);    	    		
			    		totalM=  eval(qtyVal);  
			    		unit_price_all[i].value=  addComma(totalM);  					    		
			    	}  			    				    
			    	  			    	
			    	for(var i = 0; i < unit_price_all.length; i++) {    		
			    		totalPrice +=eval(numbertogo(unit_price_all[i].value) );   		      	
			    	}    	
			    	unit_price_total.value=totalPrice;    
			   	unit_price_total.value=addComma(totalPrice) ;    
			   	
			   
				
}

function formSubmit(){	        	  
	  var inputs=document.getElementsByTagName("input");		   	
    	  var contact_order=document.getElementById("contact_order"); 
    	  var sign_02=document.getElementById("sign_02");
    	  var sign_03=document.getElementById("sign_03");    	  
    	  
    	  if(contact_order.value==""){alert("発注先を選択して下さい "); return;}
    	  if(sign_02.value=="0"){alert("部長承認を選択して下さい"); return;}
    	  if(sign_03.value=="0"){alert("注文者を選択して下さい"); return;}
    	  
    	   for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].type == "text") {	    
		     			if(inputs[i].name=="product_qty" || inputs[i].name=="unit_price"){
		     				if(inputs[i].value!=""){	 			     								
		     					inputs[i].value=numbertogo(inputs[i].value);		 				  						     			
		     			}	     			     			
	     			}	     						      			    		
	     		}
    		}  
    	  
    	   
    	    for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].type == "text") {	    
	     			if(inputs[i].value==""){
	     				if(inputs[i].name=="product_qty" || inputs[i].name=="unit_price"){
	     					inputs[i].value="0";	
	     				}else{
	     					inputs[i].value=".";
	     				}
	     			}	     					      			    		
	     		}
    		}  
    			      		 		
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
// check box
var newRow = document.createElement("tr");
newRow.setAttribute("align","center");

var newTd = document.createElement("td");
//newTd.className='tbcenter';

var newInput = document.createElement("input");
newInput.setAttribute("type", "checkbox")
newTd.appendChild(newInput);
newRow.appendChild(newTd);

// item 
newTd = document.createElement("td");
var newText = document.createElement("input");  
newTd.appendChild(newText);
newTd.innerHTML="<input type=text name=product_nm id=product_nm  class=input02 maxlength=100 size=45 >";
newRow.appendChild(newTd);

// order_no
newTd = document.createElement("td");
var newText2 = document.createElement("input");
newTd.innerHTML="<input type=text name=order_no id=order_no  class=input02 maxlength=100 size=16 >";
newRow.appendChild(newTd);

// qty
newTd = document.createElement("td");
var newText3 = document.createElement("input");
newTd.innerHTML="<input type=text name=product_qty id=product_qty class=input07  maxlength=20 size=12 onkeyup=clean(this.value) onkeydown=clean(this.value)>";
newRow.appendChild(newTd);

// unit_price
newTd = document.createElement("td");
var newText4 = document.createElement("input");
newTd.innerHTML="<input type=text name=unit_price id=unit_price class=input07  maxlength=20 size=18 onkeyup=clean(this.value) onkeydown=clean(this.value)>";
newRow.appendChild(newTd); 

// unit_price_all
newTd = document.createElement("td");
var newTextPriceAll = document.createElement("input");
newTd.innerHTML="<input type=text name=unit_price_all id=unit_price_all class=input05  maxlength=20 size=18 >";
newRow.appendChild(newTd); 


// client

var arr=new Array("---選択---",
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
			"${mem.nm}",								
	</c:forEach>
</c:if>
		"------");
	
var arrVal=new Array("0",
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
			"${mem.mseq}",								
	</c:forEach>
</c:if>
		"0");
					
newTd = document.createElement("td");
var sel=document.createElement("select");
sel.setAttribute("name","client_nm");

for(i=0;i<arr.length ;i++){
	var option=document.createElement("option");
	var text=document.createTextNode(arr[i]);		
	option.appendChild(text);		
	option.setAttribute("value",arrVal[i]);
	sel.appendChild(option);
}
newTd.appendChild(sel);
newRow.appendChild(newTd); 

/*
var newText5 = document.createElement("input");
newTd.innerHTML="<input type=text name=client_nm id=client_nm  class=input02 maxlength=50 size=12 value=<%=member.getNm()%>>";
newRow.appendChild(newTd); 
*/

newRow.appendChild(newTd);
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

 function dataServ(id){
  var frm = document.frm;
  	if(id=="con"){	  
	  var kanriNo = frm.gigi_nmVal.options[frm.gigi_nmVal.selectedIndex].text; 
	  frm.contact_order.value=kanriNo;	  
	}
 }
</script>

<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">社内用品申請 <font color="#A2A2A2">></font> 発注依頼書作成</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage2%>rms/admin/order/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規発注依頼書作成" onClick="location.href='<%=urlPage2%>rms/admin/order/writeForm.jsp'">			
</div>
<div id="boxCalendar"  >
<table width="970"  cellpadding="2" cellspacing="2" class=c  bgcolor="#F7F5EF">				
		<tr>
			<td  style="padding:5px 0px 0px 10px;" width="90%">						
				<table  border="0" cellpadding="2" cellspacing="2" width="100%">	
				<tr>
					<td align="left" >					
<font color="#339900">＜社内用品発注申請の記入期間＞</font></td>
				</tr>
				<tr><td align="left" >
毎週、<font color="#CC6600">水曜日</font>に発注します。</td>
				</tr>
				<tr><td align="left" >
(例、普通の場合2012年11月28日(水)～12月4日(火)１週間に社内用品依頼発注書に記入、部長の承認をえて12月5日(水)にまとめて舟久保さんにて
外部に注文します。</td>
				</tr>
				<tr><td align="left" >
<font color="#CC0000">*</font>至急の場合は新規発注依頼書を記入し、部長の承認をえて素早く進めます。
(舟久保さんに別途メールでお知らせする。)
					</td>
				</tr>
				<tr>
					<td align="left"  >					
<font color="#339900">＜発注先指定＞</font>
					</td>
				</tr>
				<tr>	
					<td align="left"  >
発注先が異なる場合、<font color="#CC6600">新規発注依頼書</font>を作成して下さい。登録されてない発注先以外の注文依頼に発注先を直接記入し、部長承認をえてネット注文か
					</td>
				</tr>
				<tr>	
					<td align="left"  >
売店購入して従業員精算して下さい。(例．切手、ヤマダ電機、楽天など)
					</td>
				</tr>
				<tr>	
			<td align="left" style="padding:10px 0px 1px 2px;" >			
	<font color="#339900">※</font> 作成方法 ： <font color="#CC0000"> [ アイテム追加 ]</font>を選択し,順番に書き込む。<br><br>	      
	<font color="#339900">※</font> 削除方法 ：  チェックボックスを選択してから<font color="#CC0000">[ アイテム削除 ]</font>をおしてください。　<br><br>	
	<font color="#339900">※</font> 次の合計 / 価格は、自動的に計算できるので書かなくてもよろしいです。<br><br>
	<font color="#CC0000">※</font> 計算結果が表示されない場合 ： 順番に書かないとリアルタイムの機能が効かないこともあります。その時は<font color="#CC0000">「計算機能」</font>をクリックして下さい。<br><br>				
			</td>						
		</tr>																								
				</table>							
			</td>
			<td  style="padding:30 5 0 0;" width="10%" align="right" valign="bottom" rowspan="6">						
				<img src="<%=urlPage2%>rms/image/admin/bg_tab.jpg" align="absmiddle">
			</td>
		</tr>	
</table>
<p>
<table  width="970" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">								
	<form id="frm" name="frm" method="post"  action="<%=urlPage2%>rms/admin/order/add.jsp"  >
	<input type='hidden' name="mseq" value="<%=mseq%>">
	<input type='hidden' name="sign_01" value="64">  <!--후나쿠보--->
	<input type='hidden' name="sign_01_yn" value="1"><!--후나쿠보--->
	<input type='hidden' name="sign_02_yn" value="1"><!--부장--->
	<input type='hidden' name="sign_03_yn" value="1"><!--담당자--->
	<input type='hidden' name="del_yn" value="1">
	<input type='hidden' name="get_yn" value="1">
	<input type='hidden' name="del_yn_item" value="1">	
	<input type="hidden" name="src_item" value="">	
		<tr>
			<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">情報入力準備				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
				<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">							
				  <select name="src_itemSel" class="select_type3"  onChange="return doCnt();">
				  	  <option value="0" > アイテム追加</option>
				  	  <%for(int i=1;i<21;i++){%>
				  	  	<option value="<%=i%>" ><%=i%>個</option>
				  	  <%}%>				  		 									
				  </select>
				</div>			
			</td>			
		</tr>	
</table>
<div class="clear_margin"></div>
<table  width="970" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">							
		<tr>
			<td width="15%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">情報入力 				
			</td>
			<td width="85%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
			</td>								
		</tr>	
</table>					
<table width="960"  class="tablebox" align="center" cellspacing="5" cellpadding="5">							
	<tr height="30">			
		<td width="8%"  align="center"><span class="titlename">お名前</span></td>
		<td width="26%" align="left"><%=member.getNm()%></td>
		<td width="8%"  align="center"><span class="titlename">タイトル</span></td>
		<td width="30%" align="left"><input type=text size="40" name="title" id="title" maxlength="200" value="" class="input02"></td>
		<td width="10%"  style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">発注要請</span></td>
		<td width="18%" align="left">
				<input type="radio" name="kind_urgency" value="1"  onfocus="this.blur()" checked>普通
				<input type="radio" name="kind_urgency" value="2"  onfocus="this.blur()" ><font  color="#FF6600">至急</font></td>												
	</tr>	
		<td   align="center"><span class="titlename">注文期間</span></td>
		<td  align="left">
			<%=inDate%> ～ <input type="text" size="13%" name="hizuke" id="hizuke" value="<%=inDate%>" style="text-align:center" class="input02">
		</td>
		<td   align="center"><font color="#CC0000">※</font><span class="titlename">発注先</span></td>
		<td  align="left">
<!--アスクル / カウネット  /  オカムラ  -->
			<select name="gigi_nmVal" onChange="return dataServ('con');">
				<c:if test="${empty listContact_order}">
						<option  value="0">no data</option>					
				</c:if>
				<c:if test="${! empty listContact_order}">
							<option  value="0">既存データをみる</option>	
							<option  value="アスクル" >カウネット</option>
							<option  value="カウネット" >アスクル</option>
							<option  value="オカムラ" >オカムラ</option>								
	
		<%			
		int i=1;
		Iterator listiter=listContact_order.iterator();
			while (listiter.hasNext()){				
				BeanOrderBunsho dbbOrder=(BeanOrderBunsho)listiter.next();	
				if(dbbOrder.getContact_order()!=null && !dbbOrder.getContact_order().equals("カウネット") && !dbbOrder.getContact_order().equals("アスクル") && !dbbOrder.getContact_order().equals("オカムラ")){
																	
		%>							
					<option  value="<%=dbbOrder.getContact_order()%>" ><%=dbbOrder.getContact_order()%></option>
		<%}
		i++;	
		}
		%>				
				            
				</c:if>									
					</select>	<input type=text size="25" class="input02"  name="contact_order"  id="contact_order" maxlength="100" >								
		</td>
		<td   style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">部長</span></td>
		<td  align="left">
			<!--mem.member_id=='hamano' || mem.member_id=='lin' || mem.member_id=='biofloc' || mem.member_id=='tachi' || mem.member_id=='akikino'-->
				<select name="sign_02"  id="sign_02">	
					<option value="0">---選択して下さい---</option>	
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >			
		<c:if test="${mem.member_id=='hamano' || mem.member_id=='lin' || mem.member_id=='biofloc' || mem.member_id=='tamura'}">					            							
				<option value="${mem.mseq}">${mem.nm}</option>				   
		</c:if>
	</c:forEach>
</c:if>				
				</select>	
			</td>	
	</tr>	
	<tr height="30">			
		<td   align="center"><span class="titlename">備　　考</span> </td>
		<td  align="left" colspan="3"><input type=text size="80" name="comment" id="comment" maxlength="200" value="" class="input02"></td>					
		<td   style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">注文者</span></td>
		<td  align="left">
				<select name="sign_03"  id="sign_03">	
					<option value="0">---選択して下さい---</option>								
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${member.mseq==mem.mseq}">						            							
				<option value="${mem.mseq}" selected>${mem.nm}</option>	
		</c:if>	
		<c:if test="${member.mseq!=mem.mseq}">						            							
				<option value="${mem.mseq}" >${mem.nm}</option>	
		</c:if>				
	</c:forEach>
</c:if>				
				</select>		
		</td>			
	</tr>		
</table>	
<div class="clear_margin"></div>					
<table  width="970" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">							
		<tr>
			<td width="15%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">アイテム追加 				
			</td>
			<td width="60%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
			</td>
			<td width="25%" align="right" style="padding:5px 10px 1px 0px;" >							
				<!--<input type="button" class="cc" value="アイテム追加" onclick="javascript:NewRow()"  onfocus="this.blur();"/>-->									
				<input type="button" class="cc" value="アイテム削除" onclick="javascript:deleteCheckedRow()"  onfocus="this.blur();"/>
			</td>					
		</tr>	
</table>														
<table  id="tbl" width="960" align="center" class="tablebox" cellspacing="3" cellpadding="3">		
			<tr height="30" bgcolor=#F1F1F1 align=center >	
				<td width="5%" > 削除</td>
				<td width="24%" ><font color="#CC0000">※</font>品　　名</td>
				<td width="12%" >発注NO.</td>
				<td width="12%"><font color="#CC0000">※</font>発注数</td>
				<td width="16%"><font color="#CC0000">※</font>単価(\)</td>
				<td width="17%">価格(\)</td>
				<td width="11%">依頼者</td>												
			</tr>
			<tr align=center>	
				<td><input type="checkbox"   onfocus="this.blur();"/></td>
				<td><input type="text" maxlength="100"  size="45"  name="product_nm"  id="product_nm" class="input02"></td>
				<td><input type="text" maxlength="100"  size="16"  name="order_no"  id="order_no" class="input02"></td>
				<td><input type="text" maxlength="100"  size="12"   name="product_qty"  id="product_qty" class="input07" onkeyup="clean(this.value)" onkeydown="clean(this.value)"></td>
				<td><input type="text" maxlength="20"    size="18"  name="unit_price"  id="unit_price" class="input07" onkeyup="clean(this.value)" onkeydown="clean(this.value)"></td>
				<td><input type="text" maxlength="20"    size="18"  name="unit_price_all"  id="unit_price_all" class="input05" ></td>							
				<td>
					<select name="client_nm" >
					<option value="0" >---選択---</option>	
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${mem.mseq==mseq}">							            							
					<option value="${mem.mseq}" selected>${mem.nm}</option>				
		</c:if>
		<c:if test="${mem.mseq!=mseq}">							            							
					<option value="${mem.mseq}" >${mem.nm}</option>				
		</c:if>
	</c:forEach>
</c:if>			
					</select>					 
			</tr>
			<% for(int iitme=0;iitme<cnt_item;iitme++){	%>			
				<tr align=center>	
					<td><input type="checkbox"   onfocus="this.blur();"/></td>
					<td><input type="text" maxlength="100"  size="45"  name="product_nm"  id="product_nm" class="input02" value=""></td>
					<td><input type="text" maxlength="100"  size="16"  name="order_no"  id="order_no" class="input02" value=""></td>
					<td><input type="text" maxlength="100"  size="12"   name="product_qty"  id="product_qty" class="input07" value="" onkeyup="clean(this.value)" onkeydown="clean(this.value)"></td>
					<td><input type="text" maxlength="20"    size="18"  name="unit_price"  id="unit_price" class="input07" value="" onkeyup="clean(this.value)" onkeydown="clean(this.value)"></td>
					<td><input type="text" maxlength="20"    size="18"  name="unit_price_all"  id="unit_price_all" class="input05" value="" ></td>							
					<td>
						<select name="client_nm" >
						<option value="0" >---選択---</option>			
					<%	int i=1;
						Iterator listiter=listFollow.iterator();					
							while (listiter.hasNext()){
							Member mem2=(Member)listiter.next();	
							if(mem2!=null){										
											
					%>					
								<option value="<%=mem2.getMseq()%>" ><%=mem2.getNm()%></option>	
					<%}	i++;}%>						
						
						</select>					 
				</tr>
			<%}%>						
</table>
<table  width="960" align="center" border=0 >				
			<tr height="50">				
				<td width="55%" align="right"><input type="text"  name="memssage"  id="memssage" value=""  size="50" class="messageFont"></td>				
				<td width="45%"   style="padding: 0 10 0 0; font-size:14px ;font-weight: bold;">					
						合   計&nbsp;&nbsp;&nbsp; \ 
						<input type="text"  name="unit_price_total"  id="unit_price_total" value=""   maxlength="100" size="25" class="input05" >
							<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 　計算機能　 " onClick="keisan();">																	
					
				</td>
			</tr>					
</table>	
<div class="clear_margin"></div>
<table  align="center" width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15 0 100 0;">
				<a href="JavaScript:formSubmit();"><img src="<%=urlPage%>images/common/btn_off_submit.gif" ></a>
		<!--		<input type="Button" value="DONE" onclick="JavaScript:formSubmit(this.form)">  -->
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>images/common/btn_off_cancel.gif" ></a>
			</td>			
	</tr>
</form>				
</table>	
</div>							
<!-- item end *****************************************************************-->				
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>			
<script language="javascript">
function doCnt(){
	var frm=document.frm;
	frm.src_item.value=frm.src_itemSel.value;	
	frm.action = "<%=urlPage2%>rms/admin/order/writeForm.jsp";	
	frm.submit();
}
</script>	 