<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CommentMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%! 	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	static int PAGE_SIZE=10; 
%>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String file_bseq=request.getParameter("file_bseq");
String openerPg=request.getParameter("openerPg");

String file_kind=request.getParameter("file_kind");
if (file_bseq == null) file_bseq = "0";
if (file_kind == null) file_kind = "0";

   String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	

	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");	

	List whereCond = null;
	Map whereValue = null;

	boolean searchCondName = false;
	boolean searchCondTitle = false;
	boolean searchCondContent = false;
	boolean searchCondBseq = false;
	
	whereCond = new java.util.ArrayList();
        whereValue = new java.util.HashMap();
    
    if (searchCond != null && searchCond.length > 0 && searchKey != null) {        
        for (int i = 0 ; i < searchCond.length ; i++) {
            if (searchCond[i].equals("name")) {
                whereCond.add("NM LIKE '%"+searchKey+"%'");                
                searchCondName = true;
            } else if (searchCond[i].equals("title")) {
                whereCond.add("TITLE LIKE '%"+searchKey+"%'");
                searchCondTitle = true;
            } else if (searchCond[i].equals("content")) {
                whereCond.add("CONTENT LIKE '%"+searchKey+"%'");
                searchCondContent = true;
            }else if (searchCond[i].equals("bseq")){
		 whereCond.add("BSEQ=?");
		 whereValue.put(new Integer(1),searchKey);
		 searchCondBseq = true;
		}	
        }
    }
    

	CommentMgr manager = CommentMgr.getInstance();    
	int count = manager.count(Integer.parseInt(file_bseq), Integer.parseInt(file_kind), whereCond, whereValue);
	int totalPageCount = 0; //전체 페이지 개수를 저장
	int startRow=0, endRow=0;
	if (count>0){
		totalPageCount=count/PAGE_SIZE;
		if (count % PAGE_SIZE > 0)totalPageCount++;
		
		startRow=(currentPage-1)*PAGE_SIZE+1;
		endRow=currentPage*PAGE_SIZE;
		if(endRow > count) endRow = count;
	}
	if(count<=0){
		startRow=startRow-0;
		endRow=endRow-0;
	}else if(count>0){
		startRow=startRow-1;
		endRow=endRow-1;
	}
	List  list=manager.selectList_item(Integer.parseInt(file_bseq), Integer.parseInt(file_kind), whereCond, whereValue,startRow,endRow);	
%>
<c:set var="list" value="<%= list %>" />
		
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
<script type="text/javascript">
function popup_Layer(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     // 좌우 위치 지정
     if(_marginx < 0){
        main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px";
     }
     else{
        main.style.left = event.clientX + document.body.scrollLeft-5+"px";
     }
     //높이 지정
     if(_marginy < 0){
        main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";
     }  
     else{
        main.style.top = event.clientY + document.body.scrollTop-5+"px";
     } 

}  

function Layer_popup_Off() { 
  var frm=document.frm;
  var pay_len = eval(frm.divPass.length);  
  var pay_val=frm.divPass;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
} 

</script> 	
</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center">
<center>				
<table width="100%" border="0" cellspacing="0" cellpadding="0">		
	<tr>		
		<td width="90%"  height="" style="padding: 5 0 0 20"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">コメントのリスト...
<c:choose>
	<c:when test="${param.file_kind=='1'}">			
		      	試験書原文(ORMS)	
	</c:when>
	<c:when test="${param.file_kind=='2'}">			
		      	QAチェック本(OT)		
	</c:when>
	<c:when test="${param.file_kind=='3'}">			
		      	QA確認本	
	</c:when>
	<c:when test="${param.file_kind=='4'}">			
		      	最終完成本	
	</c:when>	
	<c:otherwise>
	    		No Data!!
	</c:otherwise>
</c:choose>

    		</td>        			
	</tr>	
</table>
<table width="95%"  border="0" cellspacing="0" cellpadding="0" align="center">
	<form name="frmList" action="<%=urlPage%>rms/admin/hinsithu/commentWrite_pop.jsp" method="post" >
		<input type="hidden" name="file_bseq" value="<%=file_bseq%>">
		<input type="hidden" name="file_kind" value="<%=file_kind%>">
		<input type="hidden" name="pg" value="write">					
		<input type="hidden" name="openerPg" value="<%=openerPg%>">		
		<tr>
	    		<td style="padding: 0 0 0 20" align="right">  
			    	<input type="image" src="<%=urlPage%>rms/image/admin/btn_coment_write.gif" onfocus="this.blur()">   			    	   				
	    		</td> 
		</tr>	
	</form>						
</table>
<table  width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F5EF">			
<tr>
	<td align="center" style="padding: 5 0 10 0" >				
		<table width="98%" border="0" cellpadding="0" cellspacing="0" class="c" >
<form name="move" method="post" >
	<input type="hidden" name="pass" value="">	
	<input type="hidden" name="groupId" value="">			
    	<input type="hidden" name="bseq" value="">
    	<input type="hidden" name="file_bseq" value="${param.file_bseq}">
       <input type="hidden" name="pg"  value="">	
       <input type="hidden" name="openerPg" value="<%=openerPg%>">		
	<input type="hidden" name="file_kind" value="${param.file_kind}">	
	<input type="hidden" name="level" value="">
	 <input type="hidden" name="page" value="${currentPage}">
	    <c:if test="<%= searchCondName %>">
	    <input type="hidden" name="search_cond" value="name">
	    </c:if>
	    <c:if test="<%= searchCondTitle %>">
	    <input type="hidden" name="search_cond" value="title">
	    </c:if>
	    <c:if test="<%= searchCondContent %>">
	    <input type="hidden" name="search_cond" value="content">
	    </c:if>	
	    <c:if test="<%= searchCondBseq %>">
	    <input type="hidden" name="search_cond" value="bseq">
	    </c:if>	
	    <c:if test="${! empty param.search_key}">
	    <input type="hidden" name="search_key" value="${param.search_key}">
	    </c:if>
</form>
	<tr>
	<form name="search"  action="<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp" method="post">		
		 <input type="hidden" name="file_bseq" value="${param.file_bseq}"> 
	       <input type="hidden" name="pg"  value="${param.pg}">	
		<input type="hidden" name="file_kind" value="${param.file_kind}">
		<input type="hidden" name="page" value="${currentPage}">
		<input type="hidden" name="openerPg" value="${openerPg}">	
		<td valign="middle" width="6%" style="padding 3 0 3 0;">			
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="select_type2" onKeyPress="return doSubmitOnEnter()">
			            	<option name="search_cond" VALUE="title" >タイトル</option>
					<option name="search_cond" VALUE="name" >作成者</option>
					<option name="search_cond" VALUE="content">コメント</option>					
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="28%">				
		<input type=text  name="search_key" size="20"  class="input02" >				
			<input type="submit" style='border:0' align=absmiddle class="cc" onfocus="this.blur();"  style=cursor:pointer value="検索">
			<input type="button"  style='border:0' align=absmiddle class="cc" onfocus="this.blur();"  style=cursor:pointer value="リスト" 
			onClick="javascript:goPage(1);">		
		</td>
</form>
		<td valign="middle" width="30%">			
	<c:if test="<%= searchCondTitle || searchCondContent || searchCondBseq || searchCondName%>">
	検索条件: <br>[
	<c:if test="<%= searchCondTitle %>">タイトル</c:if>
	<c:if test="<%= searchCondName %>">作成者</c:if>
	<c:if test="<%= searchCondContent %>">コメント</c:if>
	<c:if test="<%= searchCondBseq %>">番号</c:if>
	= 
	<%=searchKey%> ]
			
</c:if>
		</td>			
	</tr>	
</form>
</table>
<table width="98%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2  bgcolor="#ffffff">
<form name="frm" >    	
	<tr height=30 bgcolor=#F1F1F1 align=center>	
    		<td height="34" style="padding: 0 0 0 0" align="center" width="5%">No</td>
    		<td height="34" style="padding: 0 0 0 0"  align="center" width="5%">返事要求</td>	
    		<td height="34" style="padding: 0 0 0 0"  align="center" width="40%">タイトル</td>
    		<td height="34" style="padding: 0 0 0 0"  align="center" width="15%">作成者</td>
    		<td height="34" style="padding: 0 0 0 0"  align="center" width="15%">作成日</td> 
    		<td height="34" style="padding: 0 0 0 0"  align="center" width="10%">処理現況</td>
    		<td height="34" style="padding: 0 0 0 0"  align="center" width="5%"><img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></td>
		<td height="34" style="padding: 0 0 0 0"  align="center" width="5%"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></td>
	</tr>	 		
<c:if test="${empty list}">
	<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
		<td colspan="8">No Data</td>
	</tr>
</c:if>
<% int pgcount=count;%>
	<c:if test="${! empty list}">
		<c:forEach var="com" items="${list}"  varStatus="idx">		
			<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
			<td style="padding: 0 0 0 0" align="center" >${com.bseq}</td>
	    		<td style="padding: 0 0 0 0" align="center"  >
	    			<c:if test="${com.henji_yn==1}">No </c:if>
	    			<font color="#FF6600"><c:if test="${com.henji_yn==0}">Yes</c:if></font>		
	    		</td>
	    	<c:if test="${com.level==1}"><td  style="padding: 2 0 2 0"></c:if>	
	    	<c:if test="${com.level==2}"><td  style="padding: 2 0 2 10"><img src="<%=urlPage%>rms/image/icon_re.gif" align="asbmiddle">	</c:if>	
	    	<c:if test="${com.level==3}"><td  style="padding: 2 0 2 20"><img src="<%=urlPage%>rms/image/icon_re.gif" align="asbmiddle">	</c:if>	
	    	<c:if test="${com.level==4}"><td  style="padding: 2 0 2 30"><img src="<%=urlPage%>rms/image/icon_re.gif" align="asbmiddle">	</c:if>	
	    	<c:if test="${com.level==5}"><td  style="padding: 2 0 2 40"><img src="<%=urlPage%>rms/image/icon_re.gif" align="asbmiddle">	</c:if>	
	    	<c:if test="${com.level==6}"><td  style="padding: 2 0 2 50"><img src="<%=urlPage%>rms/image/icon_re.gif" align="asbmiddle">	</c:if>	    				    			
	    			<a href="javascript:goLeadView(${com.bseq})" onfocus="this.blur()">${com.title}</a>
	    		</td>
	    		<td style="padding: 0 0 0 0"  align="center" >${com.name}</td>
	    		<td style="padding: 0 0 0 0"  align="center"  ><fmt:formatDate value="${com.register}" pattern="yyyy-MM-dd" /></td>
	    		<td style="padding: 0 0 0 0"  align="center"  >
	    			<font color="#FF6600"><c:if test="${com.ok_yn==0}">未決</c:if></font>
				<c:if test="${com.ok_yn==1}">完了</c:if>
	    			
	    		</td>
	    		<td style="padding: 0 0 0 0"  align="center" >
	    			<a href="javascript:goModify(${com.bseq})" onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>
			</td>
	    		<td style="padding: 0 0 0 0"  align="center"  >
<input type="hidden" name="divPass" value="popup_${com.bseq}">		
<!-- *****************************레이어 start-->
<div id="popup_${com.bseq}" style="position:absolute; left:0px; top:0px; z-index:999;display:none;border:#FFCCCC;filter: alpha(opacity=95);" >
	<table border="0" width="170" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td ><img src="<%=urlPage%>rms/image/user/title_board_passLayer.gif" ></td>
		     	<td align="right"><a onclick="Layer_popup_Off();"  style="CURSOR: pointer;"><img src="<%=urlPage%>rms/image/user/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="170" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	
         <tr>
                 	<td valign="top" width="80%" valign="middle" style="padding:5 0 5 10;" ><img src="<%=urlPage%>rms/image/icon_s.gif" >password</td>
            		<td valign="top" width="20%" valign="bottom" style="padding:15 0 5 3;" rowspan="2">
			<a href="javascript:goDelete('${com.bseq}','${com.level}','${com.groupId}');" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/ic_go.gif" align="asbmiddle"></a>
            		</td>
            </tr>
            <tr>			         
			<td  valign="top" valign="middle" style="padding:0 0 5 10;" ><input type="text" name="passVal_${com.bseq}" value="" size="20" class="logbox" style="width:100px;ime-mode:disabled"></td>
	</tr>	
     </table>
</div>
<!-- ********************************레이어 end -->
	<a onclick="popup_Layer(event,'popup_${com.bseq}');" style="CURSOR: pointer;">		
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
		    	</td>
	</tr>		
	<% pgcount--;%>
	</c:forEach>
</c:if>
</form>
</table>
<p>
<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp";
    document.move.page.value = pageNo;    
    document.move.submit();
}

function goModify(bseq) {
	var frm=document.move;
	document.move.action = "<%=urlPage%>rms/admin/hinsithu/commentLead_pop.jsp";
	frm.bseq.value=bseq;
	frm.pg.value="mody";	
  	frm.submit();
}
function goLeadView(bseq) {
	var frm=document.move;
	document.move.action = "<%=urlPage%>rms/admin/hinsithu/commentLead_pop.jsp";
	frm.bseq.value=bseq;	
	frm.pg.value="lead";	
  	frm.submit();
}
function goDelete(bseq,level,groupId) {
	
	var passValue=eval("document.frm.passVal_"+bseq+".value");  			
	document.move.bseq.value = bseq;
	document.move.pass.value = passValue;		
	document.move.level.value=level;	
	document.move.groupId.value=groupId;	
	document.move.file_bseq.value=<%=file_bseq%>;	
	document.move.file_kind.value=<%=file_kind%>;			
    	document.move.action = "<%=urlPage%>rms/admin/hinsithu/commentDel_pop.jsp";	
    	document.move.submit();
}

function doSubmitOnEnter(){
	var frm=document.search2;	
	frm.action = "<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp";
	frm.submit();
}
</script>

<!-- *****************************page No start******************************-->		
<c:set var="count" value="<%= Integer.toString(count) %>" />
<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
		
<table cellpadding=0 cellspacing=0 border=0 height=20 align="center" width="35%">
	<tr>
<c:if test="${count > 0}">
    <c:set var="pageCount" value="${count / PAGE_SIZE + (count % PAGE_SIZE == 0 ? 0 : 1)}" />
    <c:set var="startPage" value="${currentPage - (currentPage % 10) + 1}" />
    <c:set var="endPage" value="${startPage + 10}" />
    
    
    <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}" />
    </c:if>
    			
	<c:if test="${startPage > 10}">
        	<td  style="padding-right:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>rms/image/LeftBox.gif"></a>
		</td>
    	</c:if>    	
        	<td  style="padding-right:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<img src="<%=urlPage%>rms/image/LeftBox.gif" style="filter:Alpha(Opacity=40);">
		</td>  
		<td align=center valign=absmiddle>
			<table cellpadding=0 cellspacing=0 border=0 style='table-layout:fixed;'>
				<tr><td width="" align="center">
	<c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
        	<c:if test="${currentPage == pageNo}">
					<b><font class="red"></c:if>
						<a href="javascript:goPage(${pageNo})" onfocus="this.blur()" class="paging">${pageNo}</a>
		<c:if test="${currentPage == pageNo}"></font></b></c:if>
    	</c:forEach>
    					</td>
				</tr>
			</table>
		</td>
	<c:if test="${endPage < pageCount}">
        	<td width=10 style="padding-left:8" valign=absmiddle style="padding-top:4px;">
			<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>rms/image/RightBox.gif"></a>
		</td>
    	</c:if>
		<td  style="padding-left:8" valign=absmiddle style="padding-top:4px;">			
			<img src="<%=urlPage%>rms/image/RightBox.gif" style="filter:Alpha(Opacity=40);">
		</td>			
</c:if>
   </tr>
</table>
<!-- *****************************page No end-->					
</td>
</tr>
</table>

<p>
<table width="90%" border="0" cellpadding="2" cellspacing="0">
		<tr>
		<td align=center>		
	  		<a href="javascript:opener.location.href='<%=urlPage%>rms/admin/hinsithu/listForm.jsp?page=<%=openerPg%>';window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>		
		</td>
	</tr>
</table>
</center>
</body>
</html>

















