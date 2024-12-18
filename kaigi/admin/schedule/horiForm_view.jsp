<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>

<%! 
static int PAGE_SIZE=15; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>	
<%	
String urlPage=request.getContextPath()+"/";
String urlPage2=request.getContextPath()+"/orms/";	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String inDate=dateFormat.format(new java.util.Date());	


if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
}
   String lineCntVal=request.getParameter("lineCntVal");
    int lineCnt=0;
	if(lineCntVal==null){lineCnt=1;}
	if(lineCntVal!=null){lineCnt=Integer.parseInt(lineCntVal);}   
  
    
    	String pageNum = request.getParameter("page");	
	    if (pageNum == null) pageNum = "1";
	    int currentPage = Integer.parseInt(pageNum);          
	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");
	
	List whereCond = null;
	Map whereValue = null;
	
	boolean searchCondTitle = false;		
	boolean searchCondCateM=false;

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("title")){
				whereCond.add("title LIKE '%"+searchKey+"%'");		
				searchCondTitle = true;
			}else if (searchCond[i].equals("filename")){
				whereCond.add("ymd LIKE '%"+searchKey+"%'");			
				searchCondCateM = true;
			}
		}
	}
DataMgr manager = DataMgr.getInstance();	  
      int count = manager.countHori(whereCond, whereValue);
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

	List  list=manager.listHori(whereCond, whereValue,startRow,endRow);
%>
<c:set var="list" value="<%= list %>" />

<style type="text/css">	input.calendar { behavior:url(calendar.htc); } </style>
	
<script language="javascript">

function formSubmit(frmNm){        
	var frm = document.calform;		 		 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>rms/admin/schedule/horiAdd.jsp";	
	frm.submit(); 
   }   
function srcGo(){        
	var frm = document.search;     
     	frm.action = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";	
	frm.submit(); 
   } 

function goInit(){
	var frm=document.calform;
	document.calform.reset();
	frm.lineCntVal.value="1";
	frm.action = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";
	frm.submit();	
}

function doSubmitOnEnter(){
	var frm=document.calform;
	frm.lineCntVal.value=frm.lineCnt.value;	
	frm.action = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";	
	frm.submit();
}
</script>		
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">日程管理（スケジュール）<font color="#A2A2A2">></font> 祝日・休日設定</span>
<div class="clear_line_gray"></div>

<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="リスト" onClick="location.href='<%=urlPage%>rms/admin/schedule/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="カレンダー" onClick="location.href='<%=urlPage%>rms/admin/schedule/monthForm.jsp'">		
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="祝日・休日設定" onClick="location.href='<%=urlPage%>rms/admin/schedule/horiForm.jsp'">		
</div>
<div id="boxNoLineBig"  >
	<div class="boxCalendar_80">		
<table width="800"  height="24" class="tablebox" >		
<tbody >
<form name="calform" method=post  action="<%=urlPage%>rms/admin/schedule/horiAdd.jsp">	
	<input type="hidden" name="lineCntVal" value="">	 
	<tr>
		<td  width="15%"><font color="#CC0000">※</font>項目数</td>
		<td width="85%" colspan="3">
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				<select name="lineCnt" class="select_type3" onChange="return doSubmitOnEnter();"  title="項目数">
			<%for(int i=1;i<=30;i++){%>		
				<option value="<%=i%>" <%if(i==lineCnt){%>selected<%}%> ><%=i%>　個</option>
			<%}%>	
				</select>
			</div>	
				&nbsp;&nbsp;<font color="#807265">(▷ライン生成)</font>
		</td>				
	</tr>  	
			
<%
int iSche=0;						
for(iSche=1;iSche<=lineCnt;iSche++){%>		
	<tr>
		<td ><img src="<%=urlPage%>rms/image/icon_s.gif" >祝日・休日</td>
  		<td width="20%" align="left" >
  			<input type="text" size="10%" name="during_begin" class=calendar value="<%=inDate%>" style="text-align:center"> 
  <!--			<input type="text" size="13%" name="during_begin" value="" class="box">-->
  		</td>
  		<td width="13%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル(休日名)</th>
  		<td width="60%" align="left" ><input type=text size="40" class="input02"  name="title" maxlength="40"><font color="#807265">(▷春分の日 / 20文字以下)</font></td>		
	</tr>						
<%}%>
		<input type="hidden" name="cntSchedule" value="<%=iSche-1%>">
	</tbody>											
</table>
			
 <table  align="center" width="800" border="0" cellspacing="0" cellpadding="0">												
	<tr>				
			<td align="center" style="padding:5 0 2 0;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage2%>images/common/btn_off_submit.gif" ></A>
		<!--		<input type="Button" value="DONE" onclick="JavaScript:formSubmit(this.form)">  <-->
				&nbsp;
				<a href="javascript:goInit();"><img src="<%=urlPage2%>images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>	
</form>				
</table>
<div class="clear_margin"></div>
<table width="800" border="0" cellpadding="0" cellspacing="0"   bgcolor="">
<form name="move" method="post" action="<%=urlPage%>rms/admin/schedule/horiForm.jsp">
    <input type="hidden" name="seq" value="">      
    <input type="hidden" name="page" value="${currentPage}">            
    <c:if test="<%= searchCondCateM%>">
    <input type="hidden" name="search_cond" value="filename">
    </c:if>	
    <c:if test="<%= searchCondTitle%>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>    
</form>
	<tr>
	<form name="search"  action="<%=urlPage%>rms/admin/schedule/horiForm.jsp" method="post">		
		<td valign="middle" width="13%">			
			<div  class="" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="" >
				  	 <option name="search_cond" VALUE="" >:::::::Search:::::::</OPTION>				            	
			          	<option name="search_cond" VALUE="filename" >日付</OPTION>			          	
					<option name="search_cond" VALUE="title"  >タイトル</OPTION>		
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="20%" align="left">
		 	<input type=text  name="search_key" size="25"  class="input02" >
		 </td>
		 <td valign="middle" width="24%" align="left">		 			  
		 	<input type="button" value="    検索   "   class="search"  id="Search" title="SEARCH!" style=cursor:pointer 　onfocus="this.blur();" onClick="srcGo();">
		 	<input type="button"  class="search" onfocus="this.blur();" style=cursor:pointer value="  リスト  "  title="全体目録" onClick="location.href='<%=urlPage%>rms/admin/schedule/horiForm.jsp'">
		 </td>
		 <td width="59%">&nbsp;</td>			
	</tr>
	</form>
</table>
<table width="800" class="tablebox_list">
	<tbody>
			<tr bgcolor="" align=center height=26>				
				<td  width="20%" bgcolor=#F1F1F1 class="clear_dot">日付</td>
				<td  width="50%"  bgcolor=#F1F1F1 class="clear_dot">タイトル</td>								
				<td   width="15%" bgcolor=#F1F1F1 class="clear_dot">修正</td>				
				<td   width="15%" bgcolor=#F1F1F1 class="clear_dot">削除</td>						
			</tr>			
<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td colspan="4">登録された内容がありません。</td></tr>
</c:if>
<c:if test="${! empty list}">						
	<c:forEach var="news" items="${list}" varStatus="idx">
			<tr height=20  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">				
				<td align="center" class="clear_dot">${news.during_begin}&nbsp;</td>				
				<td  align="left" class="clear_dot">${news.title}&nbsp;</td>				
				<td align="center" class="clear_dot">
					<a href="javascript:goModify(${news.seq})" onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif" alt="Modify" >
					</a>
				</td>
				<td align="center" class="clear_dot">
					<a href="javascript:goDelete('${news.seq}')"  onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" alt="Cancel">
					</a></td>
			</tr>
	</c:forEach>
</c:if>
</tbody>
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
</div>	
						
<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";
    document.move.page.value = pageNo;
    document.move.submit();
}

function goModify(seq) {
	document.move.action = "<%=urlPage%>rms/admin/schedule/horiUpdateForm.jsp";
	document.move.seq.value=seq;
    	document.move.submit();
}
function goDelete(seq) {
	document.move.seq.value=seq;	
	
	if ( confirm("本内容を削除しましょうか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>rms/admin/schedule/horiDelete.jsp";	
    	document.move.submit();
}

</script>	