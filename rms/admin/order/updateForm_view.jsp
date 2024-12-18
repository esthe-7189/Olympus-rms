<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>

<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
NumberFormat numFormat = NumberFormat.getNumberInstance(); 
%>

<%
String urlPage=request.getContextPath()+"/orms/";	
String urlPage2=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String inDate=dateFormat.format(new java.util.Date());
String seq=request.getParameter("seq");
String src_item=request.getParameter("src_item");

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(src_item==null){src_item="0";}
int cnt_item=Integer.parseInt(src_item);
int mseq=0;
MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}
Member memTop=managermem.getMember(id);	
Member memKetsai;		
List listFollow=managermem.selectListSchedule(1,6);
//List listSign=manager.selectJangyo(1,levelKubun,bushoVal); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)

MgrOrderBunsho mgrOrder=MgrOrderBunsho.getInstance();
BeanOrderBunsho beanOrder=mgrOrder.getDbOrder(Integer.parseInt(seq));
int mseqOrder1=beanOrder.getSign_01();
int mseqOrder2=beanOrder.getSign_02();
int mseqOrder3=beanOrder.getSign_03();
List listCon=mgrOrder.listItem(beanOrder.getSeq());	
List listContact_order=mgrOrder.listContact_order();

%>
<c:set var="memTop" value="<%=memTop%>"/>	
<c:set var="listFollow" value="<%=listFollow%>"/>	
<c:set var="beanOrder" value="<%=beanOrder%>"/>
<c:set var="listCon" value="<%=listCon%>"/>
<c:set var="listContact_order" value="<%=listContact_order%>"/>

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
        var frmh=document.frm;		  
	  var inputs=document.getElementsByTagName("input");		   		  
	  var contact_order=document.getElementById("contact_order"); 
    	  var sign_02=document.getElementById("sign_02");
    	  var sign_03=document.getElementById("sign_03");    	      	  
    	  var product_qty = document.getElementsByName("product_qty");
    	  var unit_price = document.getElementsByName("unit_price");
    	   
    	  if(contact_order.value==""){alert("発注先を選択して下さい "); return;}    	   	
    	  if(sign_02.value=="0"){alert("部長承認を選択して下さい"); return;}    	   	
    	  if(sign_03.value=="0"){alert("注文者を選択して下さい"); return;}
 	  
   	   for(var i = 0; i < product_qty.length; i++) {	     	
		  if(product_qty[i].value!="" || unit_price[i].value!=""){		     										
		     		product_qty[i].value=numbertogo(product_qty[i].value);
		     		unit_price[i].value=numbertogo(unit_price[i].value);			     			    						      			    		
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
    		 		 
      if ( confirm("処理しますか?") != 1 ) { return; }	
      	frmh.action = "<%=urlPage2%>rms/admin/order/update.jsp";	
	frmh.submit();     
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
var newTd1 = document.createElement("td");
var newTd2 = document.createElement("td");
var newTd3 = document.createElement("td");
var newTd4 = document.createElement("td");
var newTd5 = document.createElement("td");
var newTd6 = document.createElement("td");
var newTd7 = document.createElement("td");
newRow.style.textAlign='center';
newRow.appendChild(newTd1);
newRow.appendChild(newTd2);
newRow.appendChild(newTd3);
newRow.appendChild(newTd4);
newRow.appendChild(newTd5);
newRow.appendChild(newTd6);
newRow.appendChild(newTd7);
newTd1.innerHTML="<input type=checkbox  onfocus=this.blur();>";
newTd2.innerHTML="<input type=text name=product_nm  id=product_nm  class=input02 maxlength=100 size=45 >";
newTd3.innerHTML="<input type=text name=order_no  id=order_no  class=input02 maxlength=100 size=16 >";
newTd4.innerHTML="<input type=text name=product_qty  id=product_qty class=input07  maxlength=20 size=12 onkeyup=clean(this.value) onkeydown=clean(this.value)>";
newTd5.innerHTML="<input type=text name=unit_price  id=unit_price  class=input07  maxlength=20 size=18 onkeyup=clean(this.value) onkeydown=clean(this.value)>";
newTd6.innerHTML="<input type=text name=unit_price_all  id=unit_price_all  class=input05  maxlength=20 size=18  >";
var str="";
	str +="<select name=client_nm>";
	str +="<option value=0>---選択---</option>";	
		<c:if test="${! empty  listFollow}">
			<c:forEach var="mem" items="${listFollow}"  varStatus="idx"  >
				str +="<option value=${mem.mseq}>${mem.nm} </option>";									
			</c:forEach>
		</c:if>	
	str +="</select>";

newTd7.innerHTML=str;
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
<link href="<%=urlPage2%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage2%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage2%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#hizuke").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage2%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

</script>			
<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">社内用品申請 <font color="#A2A2A2">></font> 修正</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage2%>rms/admin/order/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規発注依頼書作成" onClick="location.href='<%=urlPage2%>rms/admin/order/writeForm.jsp'">			
</div>
<div id="boxCalendar"  >
<table width="960" border="0" cellpadding="0" cellspacing="0" class=c  bgcolor="#F7F5EF">				
		<tr>
			<td  style="padding:5 0 0 10;" width="90%">						
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
				</table>							
			</td>
			<td  style="padding:30 5 0 0;" width="10%" align="right" valign="bottom" rowspan="6">						
				<img src="<%=urlPage2%>rms/image/admin/bg_tab.jpg" align="absmiddle">
			</td>
		</tr>	
</table>
<p>
<c:if test="${! empty beanOrder}" />
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">								
		<tr>
			<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">情報入力				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。							
			</td>			
		</tr>	
	<%if(beanOrder.getSign_01_yn()==3 || beanOrder.getSign_02_yn()==3  || beanOrder.getSign_03_yn()==3 ){%>		
		<tr>
			<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">差戻し理由: 			
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >			
				<%if(beanOrder.getSign_01_yn()==3 ){%><font color="#CC0000">===></font>担当者:  <%=beanOrder.getSign_no_riyu_01()%><br>  <%}%>	
				<%if(beanOrder.getSign_02_yn()==3 ){%><font color="#CC0000">===></font>部長:  <%=beanOrder.getSign_no_riyu_02()%><br>  <%}%>				
				<%if(beanOrder.getSign_03_yn()==3 ){%><font color="#CC0000">===></font>注文者:  <%=beanOrder.getSign_no_riyu_03()%>   <%}%>
			</td>			
		</tr>
	<%}%>	
</table>		
<table  width="960" class="tablebox" cellspacing="5" cellpadding="5">				
<form id="frm"  name="frm" method="post"  action="<%=urlPage2%>rms/admin/order/update.jsp"  >
	<input type='hidden' name="mseq" value="<%=mseq%>">
	<input type='hidden' name="sign_01" value="<%=mseqOrder1%>">	
	<input type='hidden' name="seq" value="<%=seq%>">	
	<input type="hidden" name="src_item" value="">						
	<tr height="30">			
		<td width="8%"  align="center"><span class="titlename">お名前</span></td>
		<td width="24%" align="left"><%=member.getNm()%></td>
		<td width="8%"  align="center"><span class="titlename">タイトル</span></td>
		<td width="32%" align="left"><input type=text size="40" name="title" id="title" maxlength="200" value=" <c:out value="${beanOrder.title}" default="-" />" class="input02"></td>
		<td width="10%"   style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">発注要請</span></td>
		<td width="18%" align="left">
			<input type="radio" name="kind_urgency" value="1"  onfocus="this.blur()"  <%if(beanOrder.getKind_urgency()==1){%> checked <%}%> >普通
			<input type="radio" name="kind_urgency" value="2"  onfocus="this.blur()" <%if(beanOrder.getKind_urgency()==2){%> checked <%}%>><font  color="#FF6600">至急</font>
		</td>						
	</tr>	
		<td   align="center"><span class="titlename">注文期間</span></td>
		<td  align="left"><%=dateFormat.format(beanOrder.getRegister())%> ～ <input type="text" size="10%" name="hizuke"  id="hizuke"  value="<%=beanOrder.getHizuke()%>"></td>
		<td   align="center"><font color="#CC0000">※</font><span class="titlename">発注先</span></td>
		<td  align="left">
									
			<select name="gigi_nmVal" onChange="return dataServ('con');">
				<c:if test="${empty listContact_order}">
						<option  value="0">no data</option>					
				</c:if>
				<c:if test="${! empty listContact_order}">
							<option  value="0">選択して下さい</option>	
					<option value="カウネット"  <%if(beanOrder.getContact_order().equals("カウネット")){%> selected <%}%>>カウネット</option>
					<option value="アスクル" <%if(beanOrder.getContact_order().equals("アスクル")){%> selected <%}%>>アスクル</option>
					<option value="オカムラ" <%if(beanOrder.getContact_order().equals("オカムラ")){%> selected <%}%>>オカムラ</option>						
	
		<%			
		int i=1; 
		Iterator listiter=listContact_order.iterator();
			while (listiter.hasNext()){				
				BeanOrderBunsho dbbOrder=(BeanOrderBunsho)listiter.next();					
				if(dbbOrder.getContact_order()!=null && !dbbOrder.getContact_order().equals("カウネット") && !dbbOrder.getContact_order().equals("アスクル") && !dbbOrder.getContact_order().equals("オカムラ")){
																	
		%>							
					<option  value="<%=dbbOrder.getContact_order()%>" <%if(dbbOrder.getContact_order().equals(beanOrder.getContact_order())){%> selected<%}%> ><%=dbbOrder.getContact_order()%></option>
		<%}
		i++;	
		}
		%>				
				            
				</c:if>									
					</select>	<input type=text size="25" class="box"  name="contact_order"  id="contact_order" maxlength="100" value="<%=beanOrder.getContact_order()%>">						
								
		</td>
		<td    style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">部長</span></td>
		<td  align="left">			
			<select name="sign_02"  id="sign_02">	
					<option value="0">---選択して下さい---</option>	
					<c:if test="${! empty  listFollow}">
						<%	int i=1;
							Iterator listiter=listFollow.iterator();					
								while (listiter.hasNext()){
								Member mem=(Member)listiter.next();
																									
						%>					
									<option value="<%=mem.getMseq()%>" <%if(mseqOrder2==mem.getMseq()){%>selected<%}%> ><%=mem.getNm()%></option>	
						<%i++;}%>	
					</c:if>
					<c:if test="${empty listFollow}">
						--
					</c:if>					
			</select>		
			
		</td>				
	</tr>	
	<tr height="30">			
		<td   align="center"><span class="titlename">備　　考</span> </td>
		<td  align="left" colspan="3"><input type=text size="80" name="comment" id="comment" maxlength="200" 
			value=" <c:out value="${beanOrder.comment}" default="-" />" class="input02"></td>					
		<td    style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">注文者</span></td>
		<td  align="left">
				<select name="sign_03"  id="sign_03">	
					<option value="0">---選択して下さい---</option>	
					<c:if test="${! empty  listFollow}">
						<%	int i=1;
							Iterator listiter=listFollow.iterator();					
								while (listiter.hasNext()){
								Member mem=(Member)listiter.next();
																									
						%>					
									<option value="<%=mem.getMseq()%>" <%if(mseqOrder3==mem.getMseq()){%>selected<%}%> ><%=mem.getNm()%></option>	
						<%i++;}%>	
					</c:if>
					<c:if test="${empty listFollow}">
						--
					</c:if>					
			</select>		
		</td>					
	</tr>	
</table>	

<!-- item begin *****************************************************************-->				  
<div class="clear_margin"></div>
<table  id="tbl" width="960" class="tablebox" cellspacing="5" cellpadding="5">				
			<tr bgcolor=#F1F1F1 align=center >	
				<td width="5%" > <span class="titlename">削除</span></td>
				<td width="24%" ><font color="#CC0000">※</font><span class="titlename">品　　名</span></td>
				<td width="12%" ><span class="titlename">発注NO.</span></td>
				<td width="12%"><font color="#CC0000">※</font><span class="titlename">発注数</span></td>
				<td width="16%"><font color="#CC0000">※</font><span class="titlename">単価(\)</span></td>
				<td width="17%"><span class="titlename">価格(\)</span></td>
				<td width="11%"><span class="titlename">依頼者</span></td>								
			</tr>				
<c:set var="listCon" value="<%=listCon %>" />					
	<c:if test="${!empty listCon}">
				<%	int ii=1; 	int totalPriceOrder=0;
					Iterator listiter2=listCon.iterator();					
						while (listiter2.hasNext()){
						BeanOrderBunsho dbCon=(BeanOrderBunsho)listiter2.next();
						int seqq=dbCon.getSeq();
						int pprice=dbCon.getProduct_qty()*dbCon.getUnit_price();
						totalPriceOrder +=pprice;
																	
				%>									
			<tr align=center>	
				<td><input type="checkbox"   onfocus="this.blur();"/></td>
				<td><input type="text" maxlength="100"  size="45"  name="product_nm"  id="product_nm" class="input02" value="<%=dbCon.getProduct_nm()%>"></td>
				<td><input type="text" maxlength="100"  size="16"  name="order_no"  id="order_no" class="input02" value="<%=dbCon.getOrder_no()%>"></td>
				<td><input type="text" maxlength="100"  size="12"   name="product_qty"  id="product_qty" class="input07" value="<%=dbCon.getProduct_qty()%>" onkeyup="clean(this.value)" onkeydown="clean(this.value)"></td>
				<td><input type="text" maxlength="20"    size="18"  name="unit_price"  id="unit_price" class="input07" value="<%=numFormat.format(dbCon.getUnit_price())%>" onkeyup="clean(this.value)" onkeydown="clean(this.value)"></td>
				<td><input type="text" maxlength="20"    size="18"  name="unit_price_all"  id="unit_price_all" class="input05" value="<%=numFormat.format(pprice)%>" ></td>							
				<td>
					<select name="client_nm" >
					<option value="0" >---選択---</option>			
				<%	int i=1;
					Iterator listiter=listFollow.iterator();					
						while (listiter.hasNext()){
						Member mem2=(Member)listiter.next();	
						if(mem2!=null){										
										
				%>					
							<option value="<%=mem2.getMseq()%>" <%if(dbCon.getClient_nm()==mem2.getMseq()){%>selected<%}%>><%=mem2.getNm()%></option>	
				<%}	i++;}%>						
					
					</select>					 
			</tr>
<%ii++;}%>
						
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
			<tr height="35">				
				<td width="55%" align="right"><input type="text"  name="memssage"  id="memssage" value=""  size="50" class="messageFont" ></td>				
				<td width="45%"   style="padding: 0 10 0 0; font-size:14px ;font-weight: bold;">
					合   計&nbsp;&nbsp;&nbsp; \ 
						<input type="text"  name="unit_price_total"  id="unit_price_total" value="<%=numFormat.format(totalPriceOrder)%>"   maxlength="100" size="25" class="input05" readonly disabled>
							<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 　計算機能　 " onClick="keisan();">												
				</td>
			</tr>					
</table>
</c:if>	
<table  align="center" width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15 0 100 0;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage%>images/common/btn_off_submit.gif" ></A>
		<!--		<input type="Button" value="DONE" onclick="JavaScript:formSubmit()">  -->
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
<script language="javascript">
function doCnt(){
	var frm=document.frm;
	frm.src_item.value=frm.src_itemSel.value;	
	frm.action = "<%=urlPage2%>rms/admin/order/updateForm.jsp";	
	frm.submit();
}
</script>	 