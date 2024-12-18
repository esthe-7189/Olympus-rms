<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>

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
날짜     hizuke

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
%>
<c:set var="memTop" value="<%=memTop%>"/>	
<c:set var="listFollow" value="<%=listFollow%>"/>	


<script language="javascript">

function goInit(){
	var frm = document.frm;
	frm.reset();
}


function clean(e){			
	 var inputs=document.getElementsByTagName("input");
	 var messa=document.getElementById("memssage");		 	
	 var regex = /[^0-9,]/gi;	 
		 
	 for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].type == "text") {	      					      		
	    				var textnm=inputs[i].getAttribute("name");
	    				var textnmVal=inputs[i].getAttribute("value");	    			
	    				if(textnm=="product_qty" || textnm=="unit_price" ){	    					
		    				if(textnmVal.search(regex) > -1){			    							    						    								
	    						inputs[i].setAttribute("value","");  	    						
	    						messa.value=" ※ 数字のみ入力して下さい。";    						
	    					}
	    				}
	    			
	     		}
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
        var frmh=document.frm;		  
	  var inputs=document.getElementsByTagName("input");		   	
    	    
    	    for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].type == "text") {	      					      		
	    				var textnm=inputs[i].getAttribute("name");
	    				var textnmVal=inputs[i].getAttribute("value");
	    				
	    				if(textnm=="product_nm" || textnm=="order_no" ){	    					
		    				if(textnmVal==""){		    					
	    						inputs[i].setAttribute("value",".");      						
	    					}
	    				}	    	
	    				if(textnm=="product_qty" || textnm=="unit_price" ){	    					
		    				if(textnmVal==""){		    					
	    						inputs[i].setAttribute("value","0");      						
	    					}
	    					if(textnmVal!=""){		    						 					    
	    						var nn=numbertogo(textnmVal);
	    						inputs[i].setAttribute("value",nn);      	
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
newTd.innerHTML="<input type=text name=product_qty id=product_qty class=input07  maxlength=20 size=12 onkeyup=clean('product_qty') onkeydown=clean('product_qty')>";
newRow.appendChild(newTd);

// unit_price
newTd = document.createElement("td");
var newText4 = document.createElement("input");
newTd.innerHTML="<input type=text name=unit_price id=unit_price class=input07  maxlength=20 size=18 onkeyup=clean('unit_price') onkeydown=clean('unit_price')>";
newRow.appendChild(newTd); 

// unit_price_all
newTd = document.createElement("td");
var newTextPriceAll = document.createElement("input");
newTd.innerHTML="<input type=text name=unit_price_all id=unit_price_all class=input05  maxlength=20 size=18  readonly disabled>";
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

// buttons
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
					    					
<center>
	
<table width="960" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="100%"  style="padding: 0 0 3 0"  class="calendar7" align="left">
    				<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">社内用品発注依頼書 <font color="#A2A2A2">></font> 発注依頼書作成
	
    		</td>    	
	</tr>		
</table>
<table width="960" border="0" cellpadding="0" cellspacing="0"   bgcolor="">						
	<tr>					
		 <td width=""  valign="bottom"  align="right" style="padding:0 0 5 15">		
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage2%>rms/admin/order/listForm.jsp'">			
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規発注依頼書作成 " onClick="location.href='<%=urlPage2%>rms/admin/order/writeForm.jsp'">					
							
	    </td>				
	</tr>	
</table>

<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">								
		<tr>
			<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">情報入力				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
			</td>			
		</tr>	
</table>		
<table  width="960" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>				
<form id="frm"  method="post"  action="<%=urlPage2%>rms/admin/order/add.jsp"  >
	<input type='hidden' name="mseq" value="<%=mseq%>">
	<input type='hidden' name="sign_01_yn" value="1">
	<input type='hidden' name="sign_02_yn" value="1">
	<input type='hidden' name="sign_03_yn" value="1">		
	<input type='hidden' name="del_yn" value="1">
	<input type='hidden' name="del_yn_item" value="1">							
	<tr height="30">	
		<tr height="30">	
		<td width="8%" bgcolor="#f7f7f7">お名前</td>
		<td align="left" ><%=member.getNm()%></td>
		<td width="8%" bgcolor="#f7f7f7">タイトル</td>
		<td align="left" colspan="3"><input type=text size="40" name="title" id="title" maxlength="200" value="" class="input02"></td>		
	</tr>	
		<td width="8%" bgcolor="#f7f7f7"><font color="#CC0000">※</font>年/月/日</td>
		<td width="17%" align="left"><input type="text" size="15%" name='hizuke' class=calendar  value="<%=inDate%>"></td>
		<td width="12%" bgcolor="#f7f7f7"><font color="#CC0000">※</font>発注先</td>
		<td width="28%" align="left">
				<select name="contact_order" >	
					<option value="0">---選択して下さい---</option>
					<option value="カウネット">カウネット</option>
					<option value="アスクル">アスクル</option>		
				</select>					
			<!--	<br>	<input type=text size="30" name="contact_order" id="contact_order" maxlength="200" value="" class="input02">-->
					
		</td>
		<td width="15%" bgcolor="#f7f7f7"><font color="#CC0000">※</font>発注要請</td>
		<td width="20%" align="left">
				<input type="radio" name="kind_urgency" value="1"  onfocus="this.blur()" checked>普通
				<input type="radio" name="kind_urgency" value="2"  onfocus="this.blur()" ><font  color="#FF6600">至急</font></td>	
	</tr>	
	<tr height="30">			
		<td width="8%" bgcolor="#f7f7f7"><font color="#CC0000">※</font>社長承認 </td>
		<td width="12%" align="left">
				<select name="sign_01" >	
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${mem.member_id=='moriyama'}">										            							
				<option value="${mem.mseq}">${mem.nm}</option>				
		</c:if>
	</c:forEach>
</c:if>				
				</select>				
		</td>		
		<td width="12%" bgcolor="#f7f7f7"><font color="#CC0000">※</font>本部長承認 </td>
		<td width="28%" align="left">
				<select name="sign_02" >						
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${mem.member_id=='juc0318'}">							            							
				<option value="${mem.mseq}">${mem.nm}</option>				
		</c:if>
	</c:forEach>
</c:if>				
				</select>
		</td>
		<td width="15%" bgcolor="#f7f7f7"><font color="#CC0000">※</font>課長/部長承認</td>
		<td width="25%" align="left">
				<select name="sign_03" >	
					<option value="0">---選択して下さい---</option>	
<c:if test="${! empty  listFollow}">
	<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
		<c:if test="${mem.member_id=='hamano' || mem.member_id=='lin' || mem.member_id=='biofloc' || mem.member_id=='tachi' || mem.member_id=='akikino'}">					            							
				<option value="${mem.mseq}">${mem.nm}</option>				
		</c:if>
	</c:forEach>
</c:if>				
				</select>		
		</td>			
	</tr>
	<tr height="30">	
		<td width="8%" bgcolor="#f7f7f7">備　　考</td>
		<td align="left" colspan="5"><input type=text size="100" name="comment" id="comment" maxlength="200" value="" class="input02"></td>		
	</tr>	
</table>	

<!-- item begin *****************************************************************-->				  
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">								
		<tr>	
			<td align="left" style="padding:20 0 1 2;" rowspan="2">			
	<font color="#339900">※</font> 作成方法 ： <font color="#CC0000"> [ アイテム追加 ]</font>をクリックし,順番に書き込む。<br>	      
	<font color="#339900">※</font> 削除方法 ：  チェックボックスを選択してから<font color="#CC0000">[ アイテム削除 ]</font>をおしてください。　<br>	
	<font color="#339900">※</font> 次の合計 / 価格は、自動的に計算できるので書かなくてもよろしいです。<br>
	<font color="#CC0000">※</font> 計算結果が表示されない場合 ： 順番に書かないとリアルタイムの機能が効かないこともあります。<br>
					&nbsp;&nbsp;&nbsp;&nbsp;その時は<font color="#CC0000">「計算機能」</font>をクリックして下さい。				
			</td>		
			<td align="left" style="padding:20 0 1 0;">&nbsp;</td>			
		</tr>
		<tr>					
			<td align="right" style="padding:40 0 1 0;">			
				<input type="button" value="アイテム追加" onclick="javascript:NewRow()"  onfocus="this.blur();"/>
				<input type="button" value="アイテム削除" onclick="javascript:deleteCheckedRow()"  onfocus="this.blur();"/>
			</td>			
		</tr>				
</table>								
<table  id="tbl" width="960" align="center" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>				
			<tr bgcolor=#F1F1F1 align=center >	
				<td width="4%" > 削除</td>
				<td width="28%" ><font color="#CC0000">※</font>品　　名</td>
				<td width="10%" >発注NO.</td>
				<td width="10%"><font color="#CC0000">※</font>発注数</td>
				<td width="15%"><font color="#CC0000">※</font>単価(\)</td>
				<td width="16%">価格(\)</td>
				<td width="8%">依頼者</td>
				<td width="6%">追加</td>									
			</tr>
			<tr align=center>	
				<td><input type="checkbox"   onfocus="this.blur();"/></td>
				<td><input type="text" maxlength="100"  size="45"  name="product_nm"  id="product_nm" class="input02"></td>
				<td><input type="text" maxlength="100"  size="16"  name="order_no"  id="order_no" class="input02"></td>
				<td><input type="text" maxlength="100"  size="12"   name="product_qty"  id="product_qty" class="input07" onkeyup="clean('product_qty')" onkeydown="clean('product_qty')"></td>
				<td><input type="text" maxlength="20"    size="18"  name="unit_price"  id="unit_price" class="input07" onkeyup="clean('unit_price')" onkeydown="clean('unit_price')"></td>
				<td><input type="text" maxlength="20"    size="18"  name="unit_price_all"  id="unit_price_all" class="input05" readonly disabled></td>							
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
				<td>	<input type="button" value="△" onclick="javascript:InsertRow(this, true)"   onfocus="this.blur();"/><input type="button" value="▽" onclick="javascript:InsertRow(this, false)"   onfocus="this.blur();"/></td>
			</tr>					
</table>
<table  width="960" align="center" border=0 >				
			<tr height="35">				
				<td width="55%" align="right"><input type="text"  name="memssage"  id="memssage" value=""  size="26" class="messageFont"></td>				
				<td width="40%"   style="padding: 0 10 0 0; font-size:14px ;font-weight: bold;">
					<table  width="100%" align="center" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>					
					<tr height="40">
						合   計&nbsp;&nbsp;&nbsp; \ 
						<input type="text"  name="unit_price_total"  id="unit_price_total" value=""   maxlength="100" size="25" class="input05" readonly disabled>
							<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 　計算機能　 " onClick="keisan();"></td>																			
					</tr></table>
				</td>
			</tr>					
</table>
<table  align="center" width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15 0 100 0;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage%>images/common/btn_off_submit.gif" ></A>
		<!--		<input type="Button" value="DONE" onclick="JavaScript:formSubmit(this.form)">  -->
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>
</form>				
</table>	
</center>							
<!-- item end *****************************************************************-->				
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>			
