<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
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
String urlPage2=request.getContextPath()+"/orms/";	
String urlPage=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");
String cseq = request.getParameter("cseq");	
String pay_item=request.getParameter("pay_item");
String kind=(String)session.getAttribute("KIND");
String inDate=dateFormat.format(new java.util.Date());

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
CateMgr mana=CateMgr.getInstance();
Category board = mana.select(Integer.parseInt(cseq));  

%>

<c:set var="board" value="<%= board %>" />

<script language="javascript">

function formSubmit(frmNm){        
	 var frm = document.forminputUp;		  	
	 var frm = document.formn;		
 	  if(isEmpty(frm.client_nm, "取引先名を入力して下さい")) return ; 
	 		 	
      if ( confirm("修正しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>rms/admin/payment/update.jsp";	
	frm.submit(); 
   }    

function goInit(){	
	var frm = document.forminputUp;
	var cseq=frm.cseq.value;	
	frm.action = "<%=urlPage%>rms/admin/payment/updateForm.jsp?cseq="+cseq+"?pay_item="+pay_item;	
	frm.submit();
}
</script>	
	
	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  <span class="calendar7">請求書手続き管理 <font color="#A2A2A2">></font> 修正する</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 月別リスト "  onClick="location.href='<%=urlPage%>rms/admin/payment/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 年別リスト "  onClick="location.href='<%=urlPage%>rms/admin/payment/listYearForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 取引先登録及び管理 " onClick="location.href='<%=urlPage%>rms/admin/payment/addForm.jsp'">				
</div>
<c:if test="${! empty board}" />			
<div id="boxNoLine_900"  >		
<table  width="95%" border="0" cellspacing="2" cellpadding="2" >								
		<tr>
			<td width="10%" align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage2%>images/common/jirusi.gif" align="absmiddle">  情報入力				
			</td>
			<td width="90%" align="left"  style="padding-left:10px;padding-top:10px" >
			<font color="#CC0000">※</font>必修です。				
			</td>			
		</tr>	
</table>	

<table width="920"  class="tablebox" cellspacing="5" cellpadding="5">				
<form name="formn"  method="post"   >	
	<input type='hidden' name="cseq" value="<%=cseq%>">	
	<input type='hidden' name="pay_item" value="<%=pay_item%>">													
	<tr>	
		<td  width="12%"><font color="#CC0000">※</font><span class="titlename">支払い方選択</span></td>
		<td width="30%" align="left">
		<c:if test="${board.pay_type==1}">
			<input type="radio" name="pay_type"  value="1"  onfocus="this.blur()"  onChange="return doKind('1');"  checked> 毎月支払い分 &nbsp;
			<input type="radio" name="pay_type"  value="2"  onfocus="this.blur()"  onChange="return doKind('2');"> 随時支払い分	
		</c:if>
		<c:if test="${board.pay_type==2}">
			<input type="radio" name="pay_type"  value="1"  onfocus="this.blur()"   onChange="return doKind('1');"> 毎月支払い分 &nbsp;
			<input type="radio" name="pay_type"  value="2"  onfocus="this.blur()"   onChange="return doKind('2');"  checked> 随時支払い分	
		</c:if>
			
		</td>
		<td  width="10%">
			<font color="#CC0000">※</font><span class="titlename">取引先 入力</span> 
		</td>
		<td width="48%" align="left">
			<input type=text size="60" class="input02"  name="client_nm" maxlength="500" value="${board.client_nm}">
		</td>
	</tr>	
</table>
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">												
	<tr>				
			<td align="center" style="padding:15px 0px 0px 0px;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage2%>images/common/btn_off_submit.gif" ></a>		
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage2%>images/common/btn_off_cancel.gif" ></a>
			</td>			
	</tr>
</form>				
</table>						
	
</div>							

			