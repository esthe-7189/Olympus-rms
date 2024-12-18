<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
	
<%	
String kindpgkubun=(String)session.getAttribute("KIND");
if(kindpgkubun!=null && ! kindpgkubun.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String pg_seq_tab = request.getParameter("seq_tab");
String stayPg=request.getParameter("stayPg");


AccMgr tabmgr=AccMgr.getInstance();
List listTab=tabmgr.listTab();
int tab_count=tabmgr.tabCnt();	
%>
<c:set var="listTab" value="<%= listTab %>" />

		
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

<script type="text/javascript">
function goWrite(){
	var frmL = document.frmList;		
	if(isNoChar(frmL.junbang, "読点(,)は使わないで下さい")) return ;	
//	if(f_chkOnlyNum(frmL.junbang.value)) return;
	if(isEmpty(frmL.all_seq_tab, "タブを選択して下さい")) return ;	
	if(isEmpty(frmL.name_tab, "タブ名を書いて下さい")) return ;	
	
	frmL.action = "<%=urlPage%>rms/admin/sop/modifyTab.jsp";	
	frmL.submit();
}
function resize(width, height){	
	window.resizeTo(width, height);
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center" >
<center>				
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="fdfdfd">		
	<tr>		
		<td width="90%"  height="" style="padding: 5 0 0 20"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">タブ(TAB)を書き直す
		</td>
	</tr>
	 <tr>
	    <td  bgcolor="#c9c9c9" height="2" ><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="2" border="0"></td>
	  </tr>   
</table>

<table width="95%"  border="0" cellspacing="0" cellpadding="0" >
	<form name="frmList" action="<%=urlPage%>rms/admin/sop/modifyTab.jsp" method="post" onSubmit="return goWrite(this)">		
		<input type="hidden" name="stayPg" value="">	
		<input type="hidden" name="pg_seq_tab" value="<%=pg_seq_tab%>">
		<input type="hidden" name="seq_tab" value="">						
		<tr>
	    		<td style="padding: 5 0 0 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >タブを選択:
			    	<select  name="all_seq_tab" onChange="doselectLcode();">
		    			<option value="">選択して下さい</option>
					    	<c:if test="${empty listTab}">
					<option value="">No Data</option>
						</c:if>	
					      <c:if test="${! empty listTab}">
							<c:forEach var="tab" items="${listTab}" varStatus="idx" >
					<option value="${tab.junbang},${tab.seq_tab}">[${tab.junbang}]_${tab.name_tab}</option>				
							</c:forEach>
						</c:if>				
			       </select>		    	   				
	    		</td> 
		</tr>	
		<tr>
	    		<td style="padding: 2 0 0 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >順&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;番:
			    <input type="taxt" name="junbang" value="" maxlength="2" size="20" class="logbox" style="width:50px;ime-mode:disabled">			
	    		</td> 
		</tr>
		<tr>
	    		<td style="padding: 2 0 0 3" ><img src="<%=urlPage%>rms/image/icon_s.gif" >新しく&nbsp;&nbsp;書く:
			    <input type="taxt" name="name_tab" value="" maxlength="12" size="20" class="logbox" style="width:140px;">			
	    		</td> 
		</tr>	
</table>
 <p><p>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
		 <tr>
		    <td  bgcolor="#c9c9c9" height="2" ><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="2" border="0"></td>
		  </tr> 
		<tr>
		<td align=center style="padding: 5 0 0 0">		
			<a href="javascript:goWrite()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>
			<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif" align="absmiddle"></a>				
	  		<a href="javascript:opener.location.href='<%=urlPage%>rms/admin/sop/listForm.jsp';window.close();"  onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>		
		</td>
	</tr>
</table>
</center>	
</form>
</body>
</html>
	
<script language='JavaScript'>
function doselectLcode(kind) {	
  var selVal = document.frmList.all_seq_tab.options[document.frmList.all_seq_tab.selectedIndex].value;
  var selNm = document.frmList.all_seq_tab.options[document.frmList.all_seq_tab.selectedIndex].text;    	 
  var arr=selVal.split(",");
  var arrTitle=selNm.split("_");
  	document.frmList.junbang.value  = arr[0];  
  	document.frmList.seq_tab.value  = arr[1];  	
	document.frmList.name_tab.value  = arrTitle[1];	
}
function cateReset() {  
	document.frmList.reset();	 
	var oEditor=FCKeditorAPI.GetInstance('name_tab');
	var div=document.createElement("DIV");
		div.innerHTML=oEditor.GetXHTML();
	 	oEditor.SetHTML(" "); 	 	
}
</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			
			