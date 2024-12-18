<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>	
<%@ page import = "java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>

<%! 
static int PAGE_SIZE=50; 
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>
<%	

String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
if(id==null){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(kind!=null && ! kind.equals("toku") ){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String today=formatter.format(new java.util.Date());

int mseq=0;String usernm="";
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();
		 usernm=member.getNm();
	}	

	ContractMgr mgrContract=ContractMgr.getInstance();
	
	
//GMP
DecimalFormat df = new DecimalFormat("00");

Calendar calEnd = Calendar.getInstance();       	   								
    calEnd.add(calEnd.DATE, +45);
    String strYearEnd   = Integer.toString(calEnd.get(Calendar.YEAR));
    String strMonthEnd  = df.format(calEnd.get(Calendar.MONTH) + 1);
    String strDayEnd   = df.format(calEnd.get(Calendar.DATE));
    String strDateEnd = strYearEnd+"-"+strMonthEnd+"-"+strDayEnd;	
   
 Calendar calEndBeforeYear = Calendar.getInstance();       	   								
    calEndBeforeYear.add(calEndBeforeYear.YEAR, -1);
    String strYYBefore   = Integer.toString(calEndBeforeYear.get(Calendar.YEAR));
    String strMMBefore  = df.format(calEndBeforeYear.get(Calendar.MONTH) + 1);
    String strDDBefore   = df.format(calEndBeforeYear.get(Calendar.DATE));
    String strDateBefore = strYYBefore+"-"+strMMBefore+"-"+strDDBefore;									

	List  listContract=mgrContract.listDate_end(today,strDateEnd); // 怨꾩빟??由ъ뒪???곗씠??異쒕젰	

%>
<c:set var="listContract" value="<%= listContract %>" />													
	
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script language="javascript" type="text/javascript">
// run the function below once the DOM(Document Object Model) is ready 
$(document).ready(function() {
    // trigger the function when clicking on an assigned element
    $(".toggle").click(function () {
        // check the visibility of the next element in the DOM
        if ($(this).next().is(":hidden")) {
            $(this).next().slideDown("fast"); // slide it down
        } else {
            $(this).next().hide(); // hide it
        }
    });
});

function goPre(){
	alert("準備中です。");
}
window.onload = function() {
	cdtd(); 	
}	
</script>
	
<div id="overlay"></div>	
<div id="conten_middleToku"  >
	<div class="middleToku_left">

<script type="text/javascript">					
function cdtd() {	
	var inputs=document.getElementsByTagName("input");	
		for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].name == "contractdate" ) {	 	     			     				      			   		
	      			var myArray = inputs[i].value.split("-"); 
				var monthVal="";
				
				if(myArray[1]=="01"){monthVal="January";}	if(myArray[1]=="02"){monthVal="February";}if(myArray[1]=="03"){monthVal="March";}if(myArray[1]=="04"){monthVal="April";}
				if(myArray[1]=="05"){monthVal="May";}if(myArray[1]=="06"){monthVal="June";}if(myArray[1]=="07"){monthVal="July";}if(myArray[1]=="08"){monthVal="August";}	
				if(myArray[1]=="09"){monthVal="September";}if(myArray[1]=="10"){monthVal="October";}if(myArray[1]=="11"){monthVal="November";}
				if(myArray[1]=="12"){monthVal="December";}
				
				 var todayVal = new Date(monthVal+" "+myArray[2]+" , "+myArray[0]+" 00:01:00");
				 var now = new Date();
				 var timeDiff = todayVal.getTime() - now.getTime();
				 var menu= "daysBoxCon-"+myArray[3]+"-"+myArray[4];	
				 if (timeDiff <= 0) { document.getElementById(menu).innerHTML = timeDiff+1;}				 	
				 var seconds = Math.floor(timeDiff / 1000);
				 var minutes = Math.floor(seconds / 60);
				 var hours = Math.floor(minutes / 60);
				 var days = Math.floor(hours / 24);		 
				 	hours %= 24;
				    	minutes %= 60;
				    	seconds %= 60;
				 document.getElementById(menu).innerHTML = days+1;	 
			//	 var timer = setTimeout('cdtd()',1000);	      				      			
	       		}
    		}
  		
}
</script>
	<a href="<%=urlPage%>tokubetu/admin/contract/listForm.jsp" onfocus="this.blur();">
	<img src="<%=urlPage%>rms/image/admin/main/contractTitle.jpg" align="absmiddle" ></a>			
	<div class="boxTable">	
	<table width="100%"  cellpadding="0" cellspacing="0">
			<thead>	
				<tr height="22" align="center" bgcolor="#eeeeee">															
					<td  class="title_list_s_r">契約終了日</td>
					<td  class="title_list_s_r">終了迄の日数</td>		
					<td  class="title_list_s_r">管理No</td>	
					<td  class="title_list_s_r">契約先</td>	
					<td  class="title_list_s_r">契約内容</td>		
					<td  class="title_list_s_r">契約日</td>
					<td  class="title_list_s_r">担当者</td>								
					<td  class="title_list">アラート<br>変更</td>
				</tr>
			</thead>				
			<tbody width="100%" >					
		<!--prepare -------------------------->

<c:if test="${empty listContract }">		
				<tr height="20"><td colspan="7" >---</td></tr>
</c:if>
<c:if test="${! empty listContract}">
<%        
    String conCode=""; 
    String date02="";     
			int i=0;							
			Iterator listiter=listContract.iterator();
				while (listiter.hasNext()){				
					ContractBeen db_item=(ContractBeen)listiter.next();
					int bseq=db_item.getBseq();	
					
				if(db_item.getDate_end()!=null){
					if(db_item.getDate_end().length()>10){
						date02=db_item.getDate_end().substring(0,10);
					}else if(db_item.getDate_end().length()==10){
						date02=db_item.getDate_end();
					}				
				}else{
					date02="0000-00-00";
				}										
					conCode=db_item.getKanri_no();             									
		%>
							
			<input type="hidden" name="contractdate" id="contractdate" value="<%=date02%>-<%=bseq%>-1">									
			<tr>				
				<td class="line_gray_bottomnright"><font color="#CC0000"><%=db_item.getDate_end()%></font><img src="<%=urlPage%>rms/image/admin/main/attentionGmp.gif" width="30" height="14" align="asbmiddle"></td>
				<td class="line_gray_bottomnright" align="center" ><font color="#CC0000"><div id="daysBoxCon-<%=bseq%>-1"></div></font></td>
				<td class="line_gray_bottomnright" align="center" ><a class="fileline" href="javascript:goReadCon(<%=bseq%>)"  onfocus="this.blur()"><%=conCode%></a></td>	
				<td class="line_gray_bottomnright"><a class="fileline" href="javascript:goReadCon(<%=bseq%>)"  onfocus="this.blur()"><%=db_item.getContact()%></a></td>
				<td class="line_gray_bottomnright"><a class="fileline" href="javascript:goReadCon(<%=bseq%>)"  onfocus="this.blur()"><%=db_item.getContent()%></a></td>															
				<td class="line_gray_bottomnright"><%=db_item.getHizuke()%></td>				
				<td class="line_gray_bottomnright"><%if(db_item.getSekining_nm()!=null){%><%=db_item.getSekining_nm()%><%}else{%>&nbsp;<%}%>  </td>			       
				<td class="line_gray_bottom" align="center">
				<%if(db_item.getSekining_mseq()==mseq || id.equals("funakubo") || id.equals("juc0318") || id.equals("admin")){%>		   	   
					   	<%if(db_item.getRenewal_yn()==1 ){%>			   		   			
								<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" ON " onClick="popupOnOff('<%=bseq%>');">			
					   	<%}else{%>
					   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF " onClick="popupOnOff('<%=bseq%>');"> 
					   	<%}%>		
				<%}else{%>	
						<%if(db_item.getRenewal_yn()==1 ){%>			   		   			
								<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" ON "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
					   	<%}else{%>
					   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
					   	<%}%>	
				<%}%>										
				</td>		
			</tr>			
	<%
	i++;
	}												  													  
	%>	
</c:if>					
		</tbody>
		</table>									
	</div>		
</div>
<div class="middleToku_right">		
<script language="javascript" type="text/javascript">  
var maxAmount = 200; 
function textCounter(textField, showCountField) { 
    if (textField.value.length > maxAmount) { textField.value = textField.value.substring(0, maxAmount); } else {  showCountField.value = maxAmount - textField.value.length; } 
}

function goWrite(){
	var frm = document.inputVal;	
	frm.content.value=frm.ta.value;		
if ( confirm("登録しますか?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>tokubetu/admin/add.jsp";	
frm.submit();		
}	
</script>		

	<div class="boxTable_messege">			
		<form name="inputVal" method="post">	 			
		    	<input type="hidden" name="view_yn" value="2">
			<input type="hidden" name="nm" value="<%=usernm%>">
			<input type="hidden" name="content" value="">
			<input type="hidden" name="gopage" value="toku">	    
		    	<input type="hidden" name="title" value="バグやエラーなどの不具合について">  	            
		    	<input type="hidden" name="mseq" value="<%=mseq%>"> 
		    	
				<textarea class="textarea_main"  id="ta" name="ta" rows="4" style="width:180px;" onKeyDown="textCounter(this.form.ta,this.form.countDisplay);" onKeyUp="textCounter(this.form.ta,this.form.countDisplay);" value="バグやエラーなどの不具合についてご記入下さい。" 	onfocus="if(this.value=='バグやエラーなどの不具合についてご記入下さい。'){this.value=''}" onblur="if(this.value==''){this.value='バグやエラーなどの不具合についてご記入下さい。'}">バグやエラーなどの不具合についてご記入下さい。</textarea> 			
				<img src="<%=urlPage%>rms/image/admin/neko.gif" name="imgTemp01"  	onMouseOver="imgTemp01.src='<%=urlPage%>rms/image/admin/neko_on.gif';" onMouseOut="imgTemp01.src='<%=urlPage%>rms/image/admin/neko.gif';"  style="cursor:pointer;" onClick="goWrite();" alt="転送" title="転送"/><input class="input_nosolid" readonly type="text" name="countDisplay" id="countDisplay" size="1" maxlength="3" value="">  	 
			
		</form>			
		
	</div><!--boxTable_messege -->		
</div>	
<div class="middleToku_left">
	<img src="<%=urlPage%>rms/image/admin/main/osirase.gif" align="absmiddle" >
	<div class="boxTable">	
	<table width="100%"  cellpadding="0" cellspacing="0">
			<thead>	
		<!--		<tr height="22" >										
					<td ><font color="#CC0000">2013-06-18</font></td>
					<td >決裁書/契約書文書ファイル管理  <font color="#CC6600">----</font> 担当者を新しく追加し,登録者は出ないようにしました。（修正ページでは出力！！）&nbsp;&nbsp;&nbsp;<font color="007AC3">new!!</font>	</td>
				</tr> 
		-->			
				<tr height="22" >										
					<td ><font color="#CC0000">2013-06-18</font>&nbsp;  </td>
					<td >決裁書 / 契約書 / 特別文書  <font color="#CC6600">---></font> エクセルのダウンロードと印刷の機能を追加しました。	</td>
				</tr>				
			</thead>
	</table>
</div>
			
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 

</div>
<form name="move" method="post">
    <input type="hidden" name="seq" value="">        
    	<input type="hidden" name="dateKind" value="">
    	<input type="hidden" name="dateYn" value="">
    	<input type="hidden" name="mseq" value="<%=mseq%>">
      <input type="hidden" name="read" value="">
   	<input type="hidden" name="renewal_yn" value="">
   	<input type="hidden" name="pgkind" value="">
</form>
<script language="JavaScript">

function goReadCon(seq) {		
    	document.move.action = "<%=urlPage%>tokubetu/admin/contract/updateForm.jsp";
	document.move.seq.value=seq;
	document.move.read.value="read";		
    	document.move.submit();
}
function popupOnOff(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;		
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>tokubetu/admin/contract/popup_OnOff.jsp?seq="+seq+"&mseq=<%=mseq%>&pgkind=main"; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}

</script>		


