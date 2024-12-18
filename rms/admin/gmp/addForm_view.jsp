<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
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
String urlPage=request.getContextPath()+"/orms/";	
String urlPage2=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");
String parentId = request.getParameter("parentId");	
String kanriNo = request.getParameter("kanriNo");	
String kind=(String)session.getAttribute("KIND");
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

int mseq=0; int levelVal=0; int bseq=0; 
String title=""; 

MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}

GmpBeen board = null;
    if (parentId != null) {
        GmpManager manager = GmpManager.getInstance();
        board = manager.select(Integer.parseInt(parentId));             
        kanriNo=board.getKanri_no();
        bseq=board.getBseq();
 }
 
GmpManager mana=GmpManager.getInstance();
List listKanri=mana.listKanri();	
GmpBeen kanriFirstNum = null;
if(kanriNo==null){
	kanriFirstNum=mana.getKanriLimit();
	if(kanriFirstNum !=null){
		kanriNo=kanriFirstNum.getKanri_no();
	}	
}

List listEda=mana.listEda(kanriNo);
List listGigi=mana.listGigi();
List listProductNm=mana.listProductNm();
List listSeizoMoto=mana.listSeizoMoto();
List listKatachiNo=mana.listKatachiNo();
List listPlace=mana.listPlace();

%>
<c:set var="board" value="<%= board %>" />
<c:set var="listKanri" value="<%= listKanri %>" />
<c:set var="listEda" value="<%= listEda %>" />
<c:set var="member" value="<%= member %>" />
<c:set var="listGigi" value="<%= listGigi %>" />
<c:set var="listProductNm" value="<%= listProductNm %>" />
	<c:set var="listSeizoMoto" value="<%= listSeizoMoto %>" />
	<c:set var="listKatachiNo" value="<%= listKatachiNo %>" />
	<c:set var="listPlace" value="<%= listPlace %>" />
	
<link href="<%=urlPage2%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage2%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage2%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#date01").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage2%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#date02").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage2%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
</script>		
<script language="javascript">
function formSubmit(frmNm){        
	  var frm = document.forminput;
	  if(isEmpty(frm.kanri_no, "管理番号を選択して下さい")) return ; 	  	  	  	 

	 if(frm.date01.value !=""){
	 	if(frm.date01.value.length >10){frm.date01.value=frm.date01.value.substring(0,10);}
	 	var yyyymmdd    = frm.date01.value.replace(/-/g, "");
	    	var week        = new Array("日", "月", "火", "水", "木", "金", "土");
	    	var yyyy        = yyyymmdd.substr(0, 4);
	    	var mm          = yyyymmdd.substr(4, 2);
	    	var dd          = yyyymmdd.substr(6, 2);
	    	var date        = new Date(yyyy, mm - 1, dd);
	    	frm.date01.value=frm.date01.value+"("+week[date.getDay()]+")";	    	
	 }
	 if(frm.date02.value !=""){
	 	 if(frm.date02.value.length >10){frm.date02.value=frm.date02.value.substring(0,10);}	 
	 	var yyyymmdd2    = frm.date02.value.replace(/-/g, "");
	    	var week2        = new Array("日", "月", "火", "水", "木", "金", "土");
	    	var yyyy2        = yyyymmdd2.substr(0, 4);
	    	var mm2          = yyyymmdd2.substr(4, 2);
	    	var dd2          = yyyymmdd2.substr(6, 2);
	    	var date2        = new Date(yyyy2, mm2 - 1, dd2);
	    	frm.date02.value=frm.date02.value+"("+week2[date2.getDay()]+")";	    	
	 } 	
	 		 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage2%>rms/admin/gmp/addNoFile.jsp";	
	frm.submit(); 
   }   


 //kanri 직접 입력
 function dataServ(id){ 
  var frm = document.forminput;
  	if(id=="gigiNm"){	  
	  var kanriNo = frm.gigi_nmVal.options[frm.gigi_nmVal.selectedIndex].text; 
	  frm.gigi_nm.value=kanriNo;	  	
	}else if(id=="place"){	  
	  var kanriNo3 = frm.placeVal.options[frm.placeVal.selectedIndex].text; 
	  frm.place.value=kanriNo3;	  
	}
  }
 

function goInit(){
	document.forminput.reset();
}
</script>	
<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  <span class="calendar7">校正対象設備等一覧 <font color="#A2A2A2">></font> 新規登録</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage2%>rms/admin/gmp/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage2%>rms/admin/gmp/addForm.jsp'">			
</div>
<div id="boxNoLine_900"  >		
<table  width="95%" border="0" cellspacing="2" cellpadding="2" >								
		<tr>
			<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" align="absmiddle">  情報入力				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。 				
			</td>			
		</tr>	
</table>	

<table width="920"  class="tablebox_fff" cellspacing="5" cellpadding="5">				
	<form name="forminput" method=post  action="<%=urlPage2%>rms/admin/gmp/addNoFile.jsp" >
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
			
		<input type="hidden" name="mseq" value="<%=mseq%>">  
		<input type="hidden" name="mseq2" value="">	
		<input type='hidden' name="date01_yn" value="1">	
		<input type='hidden' name="eda_no" value="1"> <!-----ステータス (1)使用可   (2)使用不可 ------>							 
		<input type='hidden' name="file_manual" value="no data">
	<!--2017 04 25 
		<input type='hidden' name="fileNm" value="">-->
		<input type='hidden' name="comment" value="">
		<input type='hidden' name="sekining_nm" value="${member.nm}">  <!-----글쓴이------>		
		<input type='hidden' name="katachi_no" value="">		
		<input type='hidden' name="product_nm" value="">	
	<!--end-->	
										
	<tr>	
		<td  width="10%"><font color="#CC0000">※</font><span class="titlename">管理番号</span><%=mseq%></td>
		<td width="40%" align="left" colspan="3"> <input type=text size="40" class="input02"  name="kanri_no" maxlength="20" ></td>			
	</tr>
	<tr>	
		<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">設備等名称</span></td>
		<td width="40%" align="left" >参&nbsp; &nbsp;&nbsp;      考:
				<select name="gigi_nmVal" onChange="return dataServ('gigiNm');">
					<c:if test="${empty listGigi}">
							<option  value="0">no data</option>					
					</c:if>
					<c:if test="${! empty listGigi}">
								<option  value="0">既存データをみる</option>	
		
			<%			
			int i=1;
			Iterator listiter=listGigi.iterator();
				while (listiter.hasNext()){				
					GmpBeen dbb=(GmpBeen)listiter.next();	
					if(dbb.getGigi_nm()!=null){
																		
			%>							
							<option  value="<%=dbb.getGigi_nm()%>" ><%=dbb.getGigi_nm()%></option>
			<%}
			i++;	
			}
			%>				
					            
					</c:if>									
						</select>	<br>
				直接入力:<input type=text size="40" class="input02"  name="gigi_nm" maxlength="30" >													
			</td>
			<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">設置場所 </span> </td>
			<td width="40%" align="left">参&nbsp; &nbsp;&nbsp;      考:
				<select name="placeVal" onChange="return dataServ('place');">
					<c:if test="${empty listPlace}">
							<option  value="0">no data</option>					
					</c:if>
					<c:if test="${! empty listPlace}">
							<option  value="0">既存データをみる</option>	
		
			<%			
			int i=1;
			Iterator listiter=listPlace.iterator();
				while (listiter.hasNext()){				
					GmpBeen dbb=(GmpBeen)listiter.next();	
					if(dbb.getPlace()!=null){
																		
			%>							
							<option  value="<%=dbb.getPlace()%>" ><%=dbb.getPlace()%></option>
			<%}
			i++;	
			}
			%>				
					
					</c:if>									
						</select>	<br>
				直接入力:<input type=text size="40" class="input02"  name="place" maxlength="30"></td>
	</tr>
	<tr>
		<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">導入部門</span></td>
		<td width="40%" align="left"><input type=text size="40" class="input02"  name="seizomoto" value="" maxlength="20"></td>		
		<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">アラート機能</span></td>
		<td width="40%" align="left">
			<input type="radio" name="date02_yn"  value="1"  onfocus="this.blur()" checked="checked"><font color="#009900">ON</font> &nbsp;
			<input type="radio" name="date02_yn"  value="2"  onfocus="this.blur()" ><font color="#009900">OFF</font> 
		</td>		
		
	</tr>
</table>
<div class="clear_margin"></div> 
		
<table width="920"  class="tablebox_fff" cellspacing="5" cellpadding="5">				
	<tr>
			<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">頻度</span></td>
			<td width="30%" align="left">	
				 <input type="radio" name="seizo_no"  value="1"  onfocus="this.blur()" checked="checked">使用前点検&nbsp;				
				 <input type="radio" name="seizo_no"  value="2"  onfocus="this.blur()" >１回/					
					<select name="hindo">		
						<option name="" value="1">1</option>		
						<option name="" value="2">2</option>
						<option name="" value="3">3</option>
						<option name="" value="4">4</option>
						<option name="" value="5">5</option>
						<option name="" value="6">6</option>
						<option name="" value="7">7</option>		
						<option name="" value="8">8</option>
						<option name="" value="9">9</option>
						<option name="" value="10">10</option>
						<option name="" value="11">11</option>
						<option name="" value="12">12</option>
						<option name="" value="13">13</option>		
						<option name="" value="14">14</option>
						<option name="" value="15">15</option>
						<option name="" value="16">16</option>
						<option name="" value="17">17</option>
						<option name="" value="18">18</option>
						<option name="" value="19">19</option>		
						<option name="" value="20">20</option>
						<option name="" value="21">21</option>
						<option name="" value="22">22</option>
						<option name="" value="23">23</option>
						<option name="" value="24">24</option>
					</select>ヶ月</td>
			<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">実施日</span></td>
			<td width="20%" align="left"><input type="text" size="12%" name="date01" id="date01"  value="" style="text-align:center"></td>
			<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">実施期限</span></td>
			<td width="20%" align="left"><input type="text" size="12%" name="date02" id="date02" value="" style="text-align:center"></td>
	</tr>	
</table>
<div class="clear_margin"></div>			
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15px 0px 50px 0px;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage%>images/common/btn_off_submit.gif" ></A>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage%>images/common/btn_off_cancel.gif" ></A>
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

			