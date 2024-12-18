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
String seq = request.getParameter("seq");	
String kind=(String)session.getAttribute("KIND");
String read=request.getParameter("read");
if(read==null){read="list";}
String inDate=dateFormat.format(new java.util.Date());

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
GmpManager mana=GmpManager.getInstance();
GmpBeen board = mana.select(Integer.parseInt(seq));  

List listEda=mana.listEda(board.getKanri_no());

%>
<c:set var="listEda" value="<%= listEda %>" />
<c:set var="board" value="<%= board %>" />


<script language="javascript">

function formSubmit(frmNm){        
	  var frm = document.forminputUp;	 
	  if(isEmpty(frm.seizomoto, "導入部門を書いて下さい!")) return ;
	 
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
	 
	  if ( confirm("上の内容を修正しますか?") != 1 ) { return; }	
	  frm.action = "<%=urlPage2%>rms/admin/gmp/updateNoFile.jsp";	
	  frm.submit(); 
	  
   }    

function goDelCalendar(id){
	var frm = document.forminputUp;
	if(id=="date01"){		  
		frm.date01.value="";
	}else if(id=="date02"){		  
		frm.date02.value="";
	}
}

function goInit(){	
	var frm = document.forminputUp;
	var seq=frm.seq.value;	
	frm.action = "<%=urlPage2%>rms/admin/gmp/updateForm.jsp?seq="+seq;	
	frm.submit();
}
</script>	
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
	
<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  <span class="calendar7">校正対象設備等一覧<font color="#A2A2A2">></font> 
	<%if(!read.equals("read")){%> 修正する <%}%>	
	</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage2%>rms/admin/gmp/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage2%>rms/admin/gmp/addForm.jsp'">			
</div>
<div id="boxNoLine_900"  >	
	
<table  width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">										
		<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif"  align="absmiddle"> 基本情報				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
		</td>			
</table>		
<table width="920"  class="tablebox" cellspacing="5" cellpadding="5">				
	<form name="forminputUp" method=post  action="<%=urlPage2%>rms/admin/gmp/updateNoFile.jsp" >				
		<input type='hidden' name="seq" value="<%=seq%>">						
		<input type='hidden' name="bseq" value="<%=seq%>">	
	<!--2017 04 25 
		<input type='hidden' name="fileNm" value="">-->
		<input type='hidden' name="comment" value="${board.comment}">
		<input type='hidden' name="sekining_nm" value="${board.sekining_nm}">  <!-----글쓴이------>
		<input type='hidden' name="katachi_no" value="${board.katachi_no}">	
		<input type='hidden' name="product_nm" value="${board.product_nm}">		
	<!--end-->	

																				
	<tr height="30">	
		<td width="15%"><font color="#CC0000">※</font><span class="titlename">管理番号</span></td>
		<td width="40%" align="left"><input type=text size="40" class="input01"  name="kanri_no" maxlength="20" value="${board.kanri_no}"></td>
		<td width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">設置場所</span></td>
		<td width="40%" align="left"><input type=text size="40" class="input01"  name="place" value="${board.place}" maxlength="30"></td>		
	</tr>
	<tr height="30">		
		<td width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">設備等名称</span></td>
		<td width="40%" align="left"><input type=text size="40" class="input02"  name="gigi_nm" maxlength="30" value="${board.gigi_nm} "></td>
		<td  width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">導入部門</span></td>
		<td width="40%" align="left"><input type=text size="40" class="input02"  name="seizomoto" value="${board.seizomoto}"  maxlength="20"></td>		
	</tr>
</table>
<div class="clear_margin"></div>
<table  width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">										
		<td width="100%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif"  align="absmiddle"> 実施日				
		</td>			
</table>							
<table width="920"  class="tablebox_fff" cellspacing="5" cellpadding="5">				
	<tr height="30">	
			<td  width="6%" rowspan="2"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">頻度</span></td>
			<td width="24%" align="left" rowspan="2">	
		<c:if test="${board.seizo_no==1}">
				 <input type="radio" name="seizo_no"  value="1"  onfocus="this.blur()" checked="checked">使用前点検&nbsp;				
				 <input type="radio" name="seizo_no"  value="2"  onfocus="this.blur()" >
		</c:if>
		<c:if test="${board.seizo_no==2}">
				 <input type="radio" name="seizo_no"  value="1"  onfocus="this.blur()" >使用前点検&nbsp;				
				 <input type="radio" name="seizo_no"  value="2"  onfocus="this.blur()" checked="checked">
		</c:if>
			１回/
			<select name="hindo">		
						<option name="" value="1" <%if(board.getHindo()==1){%>selected<%}%>>1</option>		
						<option name="" value="2" <%if(board.getHindo()==2){%>selected<%}%>>2</option>	
						<option name="" value="3" <%if(board.getHindo()==3){%>selected<%}%>>3</option>	
						<option name="" value="4" <%if(board.getHindo()==4){%>selected<%}%>>4</option>	
						<option name="" value="5" <%if(board.getHindo()==5){%>selected<%}%>>5</option>	
						<option name="" value="6" <%if(board.getHindo()==6){%>selected<%}%>>6</option>
						<option name="" value="7" <%if(board.getHindo()==7){%>selected<%}%>>7</option>		
						<option name="" value="8" <%if(board.getHindo()==8){%>selected<%}%>>8</option>
						<option name="" value="9" <%if(board.getHindo()==9){%>selected<%}%>>9</option>
						<option name="" value="10" <%if(board.getHindo()==10){%>selected<%}%>>10</option>
						<option name="" value="11" <%if(board.getHindo()==11){%>selected<%}%>>11</option>
						<option name="" value="12" <%if(board.getHindo()==12){%>selected<%}%>>12</option>
						<option name="" value="13" <%if(board.getHindo()==13){%>selected<%}%>>13</option>		
						<option name="" value="14" <%if(board.getHindo()==14){%>selected<%}%>>14</option>
						<option name="" value="15" <%if(board.getHindo()==15){%>selected<%}%>>15</option>
						<option name="" value="16" <%if(board.getHindo()==16){%>selected<%}%>>16</option>
						<option name="" value="17" <%if(board.getHindo()==17){%>selected<%}%>>17</option>
						<option name="" value="18" <%if(board.getHindo()==18){%>selected<%}%>>18</option>
						<option name="" value="19" <%if(board.getHindo()==19){%>selected<%}%>>19</option>		
						<option name="" value="20" <%if(board.getHindo()==20){%>selected<%}%>>20</option>
						<option name="" value="21" <%if(board.getHindo()==21){%>selected<%}%>>21</option>
						<option name="" value="22" <%if(board.getHindo()==22){%>selected<%}%>>22</option>
						<option name="" value="23" <%if(board.getHindo()==23){%>selected<%}%>>23</option>
						<option name="" value="24" <%if(board.getHindo()==24){%>selected<%}%>>24</option>											
			</select>ヶ月</td>
			<td width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">実施日</span></td>
			<td width="25%" align="left"><input type="text" size="12%" name="date01" id="date01" value="${board.date01}"  style="text-align:center">
				&nbsp;&nbsp;<a href="JavaScript:goDelCalendar('date01');" onfocus="this.blur()">[削除]</a>
			</td>
			<td width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">実施期限</span></td>
			<td width="25%" align="left"><input type="text" size="12%" name="date02" id="date02" value="${board.date02}"   style="text-align:center">
				&nbsp;&nbsp;<a href="JavaScript:goDelCalendar('date02');" onfocus="this.blur()">[削除]</a>
			</td>
	</tr>	
	<tr height="30">	
		<td  width="12%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">アラート機能</span></td>
		<td width="25%" align="left">			
		<c:if test="${board.date02_yn==1}">
			<input type="radio" name="date02_yn"  value="1"  onfocus="this.blur()" checked="checked"><font color="#009900">ON</font> &nbsp;
			<input type="radio" name="date02_yn"  value="2"  onfocus="this.blur()" ><font color="#009900">OFF</font> 				
		</c:if>
		<c:if test="${board.date02_yn==2}">
			<input type="radio" name="date02_yn"  value="1"  onfocus="this.blur()" ><font color="#009900">ON</font> &nbsp;
			<input type="radio" name="date02_yn"  value="2"  onfocus="this.blur()" checked="checked"><font color="#009900">OFF</font> 				
		</c:if>
		</td>
		<td  width="12%"><img src="<%=urlPage2%>rms/image/icon_s.gif" ><span class="titlename">ステータス</span></td>
		<td width="25%" align="left">				
		<%if(board.getEda_no()==1){%>
			<input type="radio" name="eda_no"  value="1"  onfocus="this.blur()" checked="checked"><font color="#009900">使用可</font> &nbsp;
			<input type="radio" name="eda_no"  value="2"  onfocus="this.blur()" ><font color="#009900">使用不可</font> 				
		<%}else{%>				
			<input type="radio" name="eda_no"  value="1"  onfocus="this.blur()" ><font color="#009900">使用可</font> &nbsp;
			<input type="radio" name="eda_no"  value="2"  onfocus="this.blur()" checked="checked"><font color="#009900">使用不可</font> 				
		<%}%>
		</td>				
		
	</tr>
</table>
<div class="clear_margin"></div> 					
<table width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15px 0px 50px 0px;" >
	<%if(!read.equals("read")){%>
				<a href="JavaScript:formSubmit()" onfocus="this.blur()"><img src="<%=urlPage%>images/common/btn_off_submit.gif" ></A>
		<!--		<input type="Button" value="DONE" onclick="JavaScript:formSubmit(this.form)">  -->
				&nbsp;
				<a href="javascript:goInit();" onfocus="this.blur()"><img src="<%=urlPage%>images/common/btn_off_cancel.gif" ></A>
	<%}%>
			</td>			
	</tr>
</form>				
</table>	
</div>							
<!-- item end *****************************************************************-->				
			
<script type="text/javascript">
function fellow01(){document.getElementById("fellow").style.display=''; }
function fellow02(){document.getElementById("fellow").style.display='none'; }

</script> 
			