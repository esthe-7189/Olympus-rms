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
static int PAGE_SIZE=15; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>

<%
String urlPage2=request.getContextPath()+"/orms/";	
String urlPage=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");	
String kind=(String)session.getAttribute("KIND");
String inDate=dateFormat.format(new java.util.Date());

String pay_items=request.getParameter("pay_item");
if(pay_items==null){pay_items="1";}
int pay_item=Integer.parseInt(pay_items);

String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);          
String[] searchCond=request.getParameterValues("search_cond");
String searchKey=request.getParameter("search_key");

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

int mseq=0; 
MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}

	List whereCond = null;
	Map whereValue = null;
	
	boolean searchCondTitle = false;		

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("client_nm")){
				whereCond.add("client_nm LIKE '%"+searchKey+"%'");		
				searchCondTitle = true;
			}
		}
	}
CateMgr manager = CateMgr.getInstance();	  
      int count = manager.countAdd(pay_item,whereCond, whereValue);
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

	List  list=manager.listAdd(pay_item,whereCond, whereValue,startRow,endRow);	
	
	

%>

<c:set var="member" value="<%= member %>" />
<c:set var="list" value="<%= list %>" />
<c:set var="pay_item" value="<%= pay_item %>" />
	
<script language="javascript">
function formSubmit(){        
	var frm = document.formn;		
 	if(isEmpty(frm.client_nm, "取引先名を入力して下さい")) return ; 
	 		 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>rms/admin/payment/add.jsp";	
	frm.submit(); 
   }   

function goInit(){
	document.formn.reset();
}
</script>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">  <span class="calendar7">請求書手続き管理 <font color="#A2A2A2">></font> 取引先登録及び管理 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 月別リスト "  onClick="location.href='<%=urlPage%>rms/admin/payment/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 年別リスト "  onClick="location.href='<%=urlPage%>rms/admin/payment/listYearForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 取引先登録及び管理 " onClick="location.href='<%=urlPage%>rms/admin/payment/addForm.jsp'">			
</div>
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
	<input type="hidden" name="pay_item" value="${pay_item}">														
	<tr>	
		<td  width="12%"><font color="#CC0000">※</font><span class="titlename">支払い方選択</span></td>
		<td width="30%" align="left">
	<%if(pay_item==1){%>
			<input type="radio" name="pay_type"  value="1"  onfocus="this.blur()" checked  onChange="return doKind('1');"> 毎月支払い分 &nbsp;
			<input type="radio" name="pay_type"  value="2"  onfocus="this.blur()"  onChange="return doKind('2');"> 随時支払い分
	<%}else if(pay_item==2){%>
			<input type="radio" name="pay_type"  value="1"  onfocus="this.blur()"  onChange="return doKind('1');"> 毎月支払い分 &nbsp;
			<input type="radio" name="pay_type"  value="2"  onfocus="this.blur()"  checked onChange="return doKind('2');"> 随時支払い分 &nbsp;&nbsp;
	<%}%>
		</td>
		<td  width="10%">
			<font color="#CC0000">※</font><span class="titlename">取引先 入力</span> 
		</td>
		<td width="48%" align="left">
			<input type=text size="60" class="input02"  name="client_nm" maxlength="500" >
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
<div class="clear_margin"></div>		
			
<table  width="95%" border="0" cellspacing="2" cellpadding="2" >								
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage2%>images/common/jirusi.gif" align="absmiddle">
			<%if(pay_item==1){%> 
				毎月支払い分のリスト			
			<%}else if(pay_item==2){%>
			 	随時支払い分のリスト
			<%}%>
							
			</td>					
		</tr>	
</table>	
<table width="98%" border="0" cellpadding="0" cellspacing="0"   bgcolor="">
<form name="move" method="post" action="<%=urlPage%>rms/admin/schedule/horiForm.jsp">
    <input type="hidden" name="cseq" value="">      
    <input type="hidden" name="pay_item" value="${pay_item}">	
    <input type="hidden" name="page" value="${currentPage}">               	
    <c:if test="<%= searchCondTitle%>">
    <input type="hidden" name="search_cond" value="client_nm">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>    
</form>
	<tr>
	<form name="search"  action="<%=urlPage%>rms/admin/schedule/horiForm.jsp" method="post">		
		<input type="hidden" name="pay_item" value="${pay_item}">	
		<td valign="middle" width="13%">			
			<div  class="" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="" >
				  	<option name="search_cond" VALUE="" >:::::::Search:::::::</OPTION>			          		          	
					<option name="search_cond" VALUE="client_nm"  >取引先名</OPTION>		
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="20%" align="left">
		 	<input type=text  name="search_key" size="25"  class="input02" >
		 </td>
		 <td valign="middle" width="24%" align="left">		 			  
		 	<input type="button" value="    検索   "   class="search"  id="Search" title="SEARCH!" style=cursor:pointer 　onfocus="this.blur();" onClick="srcGo();">
		 	<input type="button"  class="search" onfocus="this.blur();" style=cursor:pointer value="  リスト  "  title="全体目録" onClick="location.href='<%=urlPage%>rms/admin/payment/addForm.jsp?pay_item=${pay_item}'">
		 </td>
		 <td width="59%" align="right">
			<%if(pay_item==1){%>
			<input type="radio" name="pay_type"  value="1"  onfocus="this.blur()" checked  onChange="return doKind('1');"> 毎月支払い分 &nbsp;
			<input type="radio" name="pay_type"  value="2"  onfocus="this.blur()"  onChange="return doKind('2');"> 随時支払い分
			<%}else if(pay_item==2){%>
			<input type="radio" name="pay_type"  value="1"  onfocus="this.blur()"  onChange="return doKind('1');"> 毎月支払い分 &nbsp;
			<input type="radio" name="pay_type"  value="2"  onfocus="this.blur()"  checked onChange="return doKind('2');"> 随時支払い分 &nbsp;&nbsp;
			<%}%>
			&nbsp;&nbsp;<font  color="#FF6600">( <%=count%>個 )</font>
		 </td>			
	</tr>
	</form>
</table>			
<table width="98%"  cellpadding="0" cellspacing="0" >	 	  
	<tr bgcolor="#F1F1F1" align=center height=29>	  	    
	    <td  width="80%"  class="title_list_all">取引先名</td>	    
	    <td  width="10%"  class="title_list_m_r">修正</td>	
    	    <td  width="10%"  class="title_list_m_r">削除</td>
	</tr>
<c:if test="${empty list}">
			<tr height=20 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
				<td align="center" class="line_gray_b_l_r">-</td>
				<td colspan="2" class="line_gray_bottomnright">登録された内容がありません。</td>
			</tr>
</c:if>
<c:if test="${! empty list}">						
	<c:forEach var="news" items="${list}" varStatus="idx">
	<tr height=20>		    
	    <td  class="line_gray_b_l_r">${news.client_nm}</td>	    
	    <td  align="center" class="line_gray_bottomnright">
	    		<a href="javascript:goModify(${news.cseq},'${pay_item}')" onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif" alt="Modify" >
			</a>
	    </td>	
    	    <td  align="center" class="line_gray_bottomnright">
    	    		<a href="javascript:goDelete('${news.cseq}','${pay_item}')"  onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" alt="Cancel">
			</a>	    	   
	    </td>
	</tr>
	</c:forEach>
</c:if>		
</table>
<!-- *****************************page No begin******************************-->			
		<div class="paging_topbg"><p class="mb60  mt7"><div class="pagingHolder module ">				
			<c:set var="count" value="<%= Integer.toString(count) %>" />
			<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
			<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
				<span class="defaultbold ml20">      Page No : </span>				
				<span >
			<c:if test="${count > 0}">
			    <c:set var="pageCount" value="${count / PAGE_SIZE + (count % PAGE_SIZE == 0 ? 0 : 1)}" />
			    <c:set var="startPage" value="${currentPage - (currentPage % 10) + 1}" />
			    <c:set var="endPage" value="${startPage + 10}" />    
			    <c:if test="${endPage > pageCount}">
			        <c:set var="endPage" value="${pageCount}" />
			    </c:if>    			
				<c:if test="${startPage > 10}">        	
						<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" ><<</a>		
			    	</c:if>  		
				<c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
			        	<c:if test="${currentPage == pageNo}"><span class="active">${pageNo}</span></c:if>
			        	<c:if test="${currentPage != pageNo}"><a href="javascript:goPage(${pageNo})" onfocus="this.blur()" >${pageNo}</a></c:if>        		
			    	</c:forEach>
			    					
				<c:if test="${endPage < pageCount}">        	
						<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" >>></a>		
			    	</c:if>				
			</c:if>			
				</span>				
			</div><p class="mb20"></div>			
<!-- ************************page No end***********************************-->		
		
</div>							
		
	
				
<script language="javascript">
function doKind(type){
	var frmkind=document.formn;	
	frmkind.pay_item.value=type;		
	frmkind.action = "<%=urlPage%>rms/admin/payment/addForm.jsp";	
	frmkind.submit();	
}
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/payment/addForm.jsp";
    document.move.page.value = pageNo;    
    document.move.submit();
}

function goModify(cseq,type) {
	document.move.action = "<%=urlPage%>rms/admin/payment/updateForm.jsp";
	document.move.cseq.value=cseq;
	document.move.pay_item.value=type;	
    	document.move.submit();
}
function goDelete(cseq,type) {
	document.move.cseq.value=cseq;	
	document.move.pay_item.value=type;		
	
	if ( confirm("削除しますか? (登録された請求書手続きリストも削除されます)") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>rms/admin/payment/delete.jsp";	
    	document.move.submit();
}
function srcGo(){        
	var frm = document.search;     
     	frm.action = "<%=urlPage%>rms/admin/payment/addForm.jsp";	
	frm.submit(); 
   } 
</script>	
			