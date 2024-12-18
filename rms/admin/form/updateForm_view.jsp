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
	  if(isEmpty(frm.eda_no, "枝番/数字を入力して下さい")) return ;    	     	  	  
	  if(isNotValidCharNum(frm.eda_no, "枝番/数字を入力して下さい")) return ;	  
 /*	  if(isEmpty(frm.gigi_nm, "機器名称を選択して下さい")) return ; 
	  if(isEmpty(frm.product_nm, "製品名を選択して下さい")) return ;    	     	  	  
	  if(isEmpty(frm.seizomoto, "製造元を選択して下さい")) return ;
	  if(isEmpty(frm.katachi_no, "型番を選択して下さい")) return ;
	  if(isEmpty(frm.seizo_no, "製造番号を選択して下さい")) return ;
	  if(isEmpty(frm.place, "設置場所を選択して下さい")) return ;
	  if(isEmpty(frm.sekining_nm, "機器管理責任者を選択して下さい")) return ;	  
*/	  
	  with (document.forminputUp) {
    	    if(fellow_yn[0].checked==true){         	 
    	    	
		file_manual.value="<%=board.getFile_manual()%>";		
	    }	  
	    if(fellow_yn[1].checked==true){         	 
		if (fileNmVal.value=="") {
	            alert("ファイルを選択して下さい。　あるいは「取扱説明書修正」の「しない」をチェックしてください");
	            fileNmVal.focus();   return;	
	        }else{
	            file_manual.value="NO";	
	            file_manualMoto.value="<%=board.getFile_manual()%>";
	        }
	   }	 
	 } 
	  if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
	  frm.action = "<%=urlPage2%>rms/admin/gmp/update.jsp";	
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
	
					    					
<center>
<table width="960" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="100%"  style="padding: 0 0 0 0"  class="calendar7" align="left">
    				<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">GMP管理機器一覧  <font color="#A2A2A2">></font>
					<%if(!read.equals("read")){%> 修正する <%}%>	
    		</td>    	
	</tr>		
</table>					
<table width="960" border='0' cellpadding='0' cellspacing='1'>
	<tr>					
		 <td width=""  valign="bottom"  align="right" style="padding:0 10 5 15">
				<a class="topnav"  href="<%=urlPage2%>rms/admin/gmp/listForm.jsp" onfocus="this.blur();">[:::::全体目録:::::]</a>														
	    </td>				
	</tr>	
</table>
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">										
		<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">基本情報				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
		</td>			
</table>		
<table  width="960" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>				
	<form name="forminputUp" method=post  action="<%=urlPage2%>rms/admin/gmp/update.jsp" enctype="multipart/form-data">				
		<input type='hidden' name="seq" value="<%=seq%>">		
		<input type='hidden' name="file_manual" value="${board.file_manual}">	
		<input type='hidden' name="file_manualMoto" value="${board.file_manual}">	
		<input type='hidden' name="kanri_no" value="${board.kanri_no}">			
		<input type='hidden' name="bseq" value="<%=seq%>">																			
	<tr>	
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >管理番号</td>
		<td width="40%" align="left">${board.kanri_no}</td>
		<td bgcolor="#f7f7f7" width="15%"><font color="#CC0000">※</font>枝番</td>
		<td width="30%" align="left">
			<select name="eda_noVal">
				<c:if test="${empty listEda}">
						<option  value="0">既存データなし</option>					
				</c:if>
				<c:if test="${! empty listEda}">
						<option  value="0">既存データをみる</option>
	
		<%			
		int i=1;
		Iterator listiter=listEda.iterator();
			while (listiter.hasNext()){				
				GmpBeen dbb=(GmpBeen)listiter.next();	
																	
		%>							
						<option  value="<%=dbb.getEda_no()%>" ><%if(dbb.getEda_no()<10){%>0<%}%><%=dbb.getEda_no()%></option>
		<%
		i++;	
		}
		%>				
				
				</c:if>								
					</select>	
					<input type=text size="10" class="box"  name="eda_no" maxlength="30" value="<%if(board.getEda_no() <10){%>0<%}%>${board.eda_no}">
			</td>
	</tr>
	<tr>	
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >機器名称</td>
		<td width="40%" align="left"><input type=text size="40" class="box"  name="gigi_nm" maxlength="30" value="${board.gigi_nm} "></td>
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >製品名</td>
		<td width="30%" align="left"><input type=text size="40" class="box"  name="product_nm" value="${board.product_nm}" maxlength="60">	</td>
	</tr>
	<tr>	
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >設置場所</td>
		<td width="40%" align="left"><input type=text size="40" class="box"  name="place" value="${board.place}" maxlength="30"></td>
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >機器管理責任者</td>
		<td width="40%" align="left"><input type=text size="40" class="box"  name="sekining_nm" value="${board.sekining_nm}" maxlength="20"></td>				
	</tr>
</table>				
<table  width="960" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>				
	<tr>	
		<td bgcolor="#f7f7f7" width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >製造元</td>
		<td width="90%" align="left" colspan="3"><input type=text size="60" class="box"  name="seizomoto" value="${board.seizomoto}" maxlength="60"></td>
	</tr>
	<tr>
		<td bgcolor="#f7f7f7" width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >型番</td>
		<td width="40%" align="left"><input type=text size="60" class="box"  name="katachi_no" value="${board.katachi_no}" maxlength="60">	</td>
		<td bgcolor="#f7f7f7" width="10%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >製造番号</td>
		<td width="40%" align="left"><input type=text size="60" class="box"  name="seizo_no" value="${board.seizo_no}" maxlength="60"></td>
	</tr>		
</table>
<table  width="960" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
	<tr>			
		<td colspan="2"><img src="<%=urlPage2%>rms/image/icon_s.gif" >既存の取扱説明書 : <font color="#993300">
			<%if(!board.getFile_manual().equals("no data")){%>			    
			    	<%=board.getFile_manual()%>
		    <%}else{%>
		    		--
		    <%}%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
			<img src="<%=urlPage2%>rms/image/icon_s.gif" >取扱説明書修正 :
			<input type="radio" name="fellow_yn" value="1" onClick="fellow02()" onfocus="this.blur()" checked><font  color="#FF6600">しない</font>
			<input type="radio" name="fellow_yn" value="2" onClick="fellow01()" onfocus="this.blur()"><font  color="#FF6600">修正する</font>
				<br>
				<div id="fellow" style="display:none;overflow:hidden ;border:1px solid #99CC00;" >
				<img src="<%=urlPage2%>rms/image/icon_s.gif" >ニュー取扱説明書 : <input type="file" size="80"  name="fileNmVal">
				</div>
		</td>		
	</tr>
	<tr>			
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >備　　考</td>
		<td width="85%" ><input type=text size="60" class="box"  name="comment" maxlength="100" value="${board.comment}"></td>	
	</tr>
			
</table>		
<p>	
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">								
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">実施日</td>			
		</tr>	
</table>	
<table  width="960" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
	<tr>
			<td bgcolor="#f7f7f7" width="10%" rowspan="2"><img src="<%=urlPage2%>rms/image/icon_s.gif" >頻度</td>
			<td width="16%" align="left" rowspan="2">
			<select name="hindo">		
				<option name="" value="1" <%if(board.getHindo()==1){%>selected<%}%>>   1   </option>		
				<option name="" value="2" <%if(board.getHindo()==2){%>selected<%}%>>   2   </option>						
			</select>	
				回/年（±１ヶ月）</td>
			<td bgcolor="#f7f7f7" width="12%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >前回実施日</td>
			<td width="25%" align="left"><input type="text" size="12%" name='date01' value="${board.date01}" class=calendar  style="text-align:center">
				&nbsp;&nbsp;<a href="JavaScript:goDelCalendar('date01');" onfocus="this.blur()">[削除]</a>
			</td>
			<td bgcolor="#f7f7f7" width="12%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >次回実施日</td>
			<td width="25%" align="left"><input type="text" size="12%" name='date02' value="${board.date02}" class=calendar  style="text-align:center">
				&nbsp;&nbsp;<a href="JavaScript:goDelCalendar('date02');" onfocus="this.blur()">[削除]</a>
			</td>
	</tr>
	<tr>					
			<td bgcolor="#f7f7f7" ><img src="<%=urlPage2%>rms/image/icon_s.gif" >アラート機能(前回)</td>
			<td align="left">
				<input type="radio" name="date01_yn" value="1"  onfocus="this.blur()" <%if(board.getDate01_yn()==1){%>checked<%}%>><font  color="#FF6600">ON</font>
				<input type="radio" name="date01_yn" value="2"  onfocus="this.blur()" <%if(board.getDate01_yn()==2){%>checked<%}%>><font  color="#FF6600">OFF</font>			
			</td>
			<td bgcolor="#f7f7f7" ><img src="<%=urlPage2%>rms/image/icon_s.gif" >アラート機能(次回)</td>
			<td align="left">
				<input type="radio" name="date02_yn" value="1"  onfocus="this.blur()" <%if(board.getDate02_yn()==1){%>checked<%}%>><font  color="#FF6600">ON</font>
				<input type="radio" name="date02_yn" value="2"  onfocus="this.blur()" <%if(board.getDate02_yn()==2){%>checked<%}%>><font  color="#FF6600">OFF</font>
			</td>
	</tr>
</table>	
<p>	

<!--***********>
<table  width="960" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
	<tr>	
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >前回実施処理</td>
		<td width="40%" align="left">
			<input type="radio" name="date01_yn" value="1"  onfocus="this.blur()" <%if(board.getDate01_yn()==1){%>checked<%}%>><font  color="#FF6600">実施していません</font>
			<input type="radio" name="date01_yn" value="2"  onfocus="this.blur()" <%if(board.getDate01_yn()==2){%>checked<%}%>><font  color="#FF6600">実施しました</font>	
		</td>
		<td bgcolor="#f7f7f7" width="15%"><img src="<%=urlPage2%>rms/image/icon_s.gif" >次回実施処理</td>
		<td width="30%" align="left">
			<input type="radio" name="date02_yn" value="1"  onfocus="this.blur()" <%if(board.getDate02_yn()==1){%>checked<%}%>><font  color="#FF6600">実施していません</font>
			<input type="radio" name="date02_yn" value="2"  onfocus="this.blur()" <%if(board.getDate02_yn()==2){%>checked<%}%>><font  color="#FF6600">実施しました</font>
		</td>			
	</tr>		
</table>	
<-->		
				
<table  align="center" width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15 0 100 0;">
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
</center>							
<!-- item end *****************************************************************-->				
			
<script type="text/javascript">
function fellow01(){document.getElementById("fellow").style.display=''; }
function fellow02(){document.getElementById("fellow").style.display='none'; }

</script> 
			