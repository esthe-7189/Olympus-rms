<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "mira.board.Board" %>
<%@ page import = "mira.board.BoardManager" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>	
<%! 
static int PAGE_SIZE=50; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>
<%	
String inDate=dateFormat.format(new java.util.Date());				
MemberManager memmgr = MemberManager.getInstance();
	String id=(String)session.getAttribute("ID");	
	Member member2=memmgr.getMember(id);
	String kind=(String)session.getAttribute("KIND");
	
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String urlPage=request.getContextPath()+"/";		
	String pageNum = request.getParameter("page");	
	String kindboard = request.getParameter("kindboard");	
	int kindbInt=Integer.parseInt(kindboard);
	
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

	BoardManager manager = BoardManager.getInstance();    
	int count = manager.count(whereCond, whereValue,kindbInt);
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
	List  list=manager.selectList(whereCond, whereValue,startRow,endRow,kindbInt);		//1은 사내게시판, 2는 제조품질 3은 OT-orms연락사항
	int countCom=0; 	
%>
<c:set var="list" value="<%= list %>" />


<script language="javascript">
// 한줄쓰기 토글 함수
function ShowHidden(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.itemData_block" + i + ".style");		
		if ( i == ShowMenuID ){
			if ( menu.display == "block" )
				menu.display	= "none";
			else 
				menu.display	= "block";
		} 
		else 
			menu.display	= "none";
	}
	frame_init();
} 
</script>		
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">
<span class="calendar7">
<%if(kindbInt==1){%>
	5S 掲示板 
<%}else if(kindbInt==2){%>
	製造 掲示板	
<%}else if(kindbInt==3){%>		
	品質 掲示板
<%}%>				
	<font color="#A2A2A2">></font>全体目録</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="   書く   >>" onClick="location.href='<%=urlPage%>rms/admin/board/addForm.jsp?kindboard=<%=kindboard%>'">
</div>

<table  width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
<form name="search"  action="<%=urlPage%>rms/admin/board/listForm.jsp?page=1&kindboard=<%=kindboard%>" method="post">	
	<tr>
		<td>
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">
		<select name="search_cond" class="select_type3" >								
			<option name="search_cond" VALUE="" >:::Search:::</OPTION>	
				<option name="search_cond" VALUE="name" >お名前</OPTION>								          				          	
				<option name="search_cond" VALUE="title"  >タイトル</OPTION>
				<option name="search_cond" VALUE="content" >内容</OPTION>												
			</select>
		</div>
			<input type=text  name="search_key" size=25  class="input02" >
			<input type="submit"  style=cursor:pointer align=absmiddle value="検索 >>" class="cc" onfocus="this.blur();" >
			<input type="button"   style=cursor:pointer align=absmiddle value="全体目録 >>" class="cc" onfocus="this.blur();"  onClick="location.href='<%=urlPage%>rms/admin/board/listForm.jsp?page=1kindboard=<%=kindboard%>'">		
		</td>										
		
		</tr>
	</form>
</table>
									
			
<table width="80%"  class="box_100" cellspacing="2" cellpadding="2"  >
	<thead >
		<tr bgcolor=#F1F1F1 align=center height=22>	        				
				<td  width="8%" class="clear_dot">NO</td>						
				<td  width="50%"  class="clear_dot">タイトル</td>							
				<td   width="10%" class="clear_dot">お名前</td>
				<td  width="14%" class="clear_dot">日付</td>							
				<td   width="10%" class="clear_dot">展示可否</td>
				<td  width="8%" class="clear_dot">HIT</td>							
			</tr>
	<thead>
	<tbody>
			<tr>					
<c:if test="${empty list}">
			<tr ><td colspan="6" align="center" class="clear_dot">登録された内容がありません。</td></tr>			
</c:if>
<c:if test="${! empty list}">
<%
int i=1;
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		Board board=(Board)listiter.next();
		int bseq=board.getBseq();			
%>
<input type="hidden" name="bseq" value="<%=bseq%>">	
		<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" height="25">			
			<td align="center" width="8%" style="padding: 3 0 3 0"  class="clear_dot"><%=(count-i)+1%></td>			
	<%if(board.getLevel()==2 ){%><td width="50%" style="padding: 2 0 2 10" class="clear_dot"><img src="<%=urlPage%>rms/image/user/icon_re.gif" align="asbmiddle">
	<%} else if(board.getLevel()==1 ){%><td width="50%" style="padding: 2 0 2 0"  class="clear_dot">
	<%} else if(board.getLevel()==3 ){%><td width="50%" style="padding: 2 0 2 20" class="clear_dot"><img src="<%=urlPage%>rms/image/user/icon_re.gif" align="asbmiddle">
	<%} else if(board.getLevel()==4 ){%><td width="50%" style="padding: 2 0 2 30" class="clear_dot"><img src="<%=urlPage%>rms/image/user/icon_re.gif" align="asbmiddle">
	<%} else if(board.getLevel()==5 ){%><td width="50%" style="padding: 2 0 2 40" class="clear_dot"><img src="<%=urlPage%>rmsimage/user/icon_re.gif" align="asbmiddle">
	<%} else if(board.getLevel()==6 ){%><td width="50%" style="padding: 2 0 2 50" class="clear_dot"><img src="<%=urlPage%>rms/image/user/icon_re.gif" align="asbmiddle"><%}%>
	<a href="javascript:goView('<%=bseq%>',<%=kindboard%>)" onfocus="this.blur()">
	<%=board.getTitle()%></a>
				<font color="#FF9900">
					<%countCom=manager.commentCnt(bseq);
						if(countCom !=0){
					%>
					(<%=countCom%>)
					<%}%>
				</font>	&nbsp;&nbsp;
		<%if(dateFormat.format(board.getRegister()).equals(inDate)){%>
					<img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="asbmiddle"> <font color="007AC3">new!!</font><%}%>			
											
			</td>
			<td align="" width="10%" style="padding: 2 0 2 0" class="clear_dot"><%=board.getName()%></td>
			<td align="center" width="14%" style="padding: 2 0 2 0" class="clear_dot"><%=dateFormat.format(board.getRegister())%></td>					
			<td align="center" width="10%" style="padding: 2 0 2 0" class="clear_dot">
				<%if(board.getView_yn()==1){%>はい<%}%>
				<%if(board.getView_yn()==2){%>いいえ<%}%>				
			</td>
			<td align="center" width="8%" style="padding: 2 0 2 0" class="clear_dot"><%=board.getHit_cnt()%></td>	
		</tr>	
				
<%
i++;
}												  													  
%>	
</c:if>
	</tbody>	
</table>

<table  width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
		<tr>
			<td >													
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
			</td>
		</tr>
	</table>
<form name="move" method="post">
    <input type="hidden" name="pass" value="">   
    <input type="hidden" name="pg" value="">    
    <input type="hidden" name="bseq" value=""> 
    <input type="hidden" name="kindboard" value="<%=kindboard%>">      
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
		
<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/board/listForm.jsp";
    document.move.page.value = pageNo;    
    document.move.submit();
}
function goView(bseq,kindboard) {
	document.move.action = "<%=urlPage%>rms/admin/board/leadForm.jsp";
	document.move.bseq.value = bseq;
	document.move.pg.value = "cLead";
	document.move.kindboard.value = kindboard;
	document.move.submit();
}


</script>