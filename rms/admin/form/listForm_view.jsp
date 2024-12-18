<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.form.FormBeen" %>
<%@ page import = "mira.form.FormManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>

<%! 
static int PAGE_SIZE=20; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String kind=(String)session.getAttribute("KIND");
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
    	
	int level_mem=0;int mseq=0;
	MemberManager managermem=MemberManager.getInstance();
	Member member=managermem.getMember(id);
	if(member!=null){
		level_mem=member.getLevel();
		mseq=member.getMseq();
	}


	String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	
    
    
	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");
	String[] searchRadio=request.getParameterValues("search_radio");	
	
	List whereCond = null;
	Map whereValue = null;

	boolean searchCondFilename = false; boolean searchCondTitle = false;

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("filename")){
				whereCond.add(" filenm LIKE '%"+searchKey+"%'");				
				searchCondFilename=true;
			}else if (searchCond[i].equals("title")){
				whereCond.add(" title LIKE '%"+searchKey+"%'");
				searchCondTitle = true;
			}			
		}
	}

	FormManager manager=FormManager.getInstance();		
	
	int count = manager.count(whereCond, whereValue);	
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
	List  list=manager.selectList(whereCond, whereValue,startRow,endRow);			
	
%>
<c:set var="list" value="<%= list %>" />	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">各種文書フォーム </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>rms/admin/form/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>rms/admin/form/addForm.jsp'">			
</div>
<div id="boxNoLineBig"  >
	
<!--********search begin-->
<table border="0" cellpadding="0" cellspacing="0" width="960"  >		
	<form name="search"  action="<%=urlPage%>rms/admin/form/listForm.jsp" method="post">	
		<tr>
			<td align="left" style="padding:5px 0px 0px 2px;" >						
				<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
					<option name="" VALUE=""  >::::::: 検索 :::::::</option>
					<option name="search_cond" VALUE="title" >タイトル</option>	
					<option name="search_cond" VALUE="filename"  >ファイル</option>											
				</select>
					<input type="TEXT" NAME="search_key" VALUE="" SIZE="30" class="input02" >
					<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">							
			</td>
			<td  align="left" style="padding:5 0 5 10;" >	
				<font  color="#FF6600">(<%=count%>個)</font>
			</td>
		</tr>
	</form>						
</table>
<!--********search end-->							
<table width="960" class="tablebox_list" cellpadding="2" cellspacing="2" >	 
	
	<tr bgcolor=#F1F1F1 align=center height=23>		    
	    <td width="15%"  class="title_list_m">登録日</td>	    
	    <td width="25%" class="title_list_m">タイトル</td>    
	    <td width="15%" class="title_list_m">登録者</td>
	    <td width="38%" class="title_list_m">ファイル</td>	    
	    <td width="7%" class="title_list_m">削除</td>				
	</tr>
<c:if test="${empty list}">
				<td colspan="5" class="clear_dot">no data</td>			
</c:if>
<c:if test="${! empty list}">
<%
int i=1; 
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		FormBeen db_item=(FormBeen)listiter.next();
		int seq=db_item.getBseq();
		String aadd=dateFormat.format(db_item.getRegister());						
		Member memNm=managermem.getDbMseq(db_item.getMseq());
%>								
				
	<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	    
	    <td align="center" class="clear_dot"><%=aadd%></td>	    	    
	    <td align="left" class="clear_dot">
	    	<%=db_item.getTitle()%>	    	
	    </td>
	    <td class="clear_dot"><%=memNm.getNm()%>	</td>
	    <td align="left" class="clear_dot">
	    	<a class="fileline" href="javascript:goDown('<%=seq%>','<%=db_item.getFilenm()%>')"  onfocus="this.blur()"><%=db_item.getFilenm()%></a>	    	
	   </td>	      	   
	    <td align="center" class="clear_dot">									
			<a href="javascript:goDelete('<%=seq%>','<%=db_item.getFilenm()%>')"  onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>		
	   </td>	
	</tr>
<%
i++;	
}
%>				
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
	
<p><p> 
</div>
<form name="move" method="post">
    <input type="hidden" name="seq" value="">        
    <input type="hidden" name="filenm" value="">        
    <input type="hidden" name="page" value="${currentPage}">
    <c:if test="<%= searchCondFilename %>">
    <input type="hidden" name="search_cond" value="filename">
    </c:if>
    <c:if test="<%= searchCondTitle %>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	    
</form>	
		
<script language="JavaScript">
function goPage(pageNo) {    
    	document.move.page.value = pageNo;
	document.move.action = "<%=urlPage%>rms/admin/form/listForm.jsp";
    	document.move.submit();
}
function goDelete(seq,filename) {
	if(confirm(filename+"のデータを削除しますか?")!=1){return;}
	document.move.action = "<%=urlPage%>rms/admin/form/delete.jsp";
	document.move.seq.value = seq;	
	document.move.filenm.value = filename;  
    	document.move.submit();
}
	
function goDown(seq,filename) {		
	document.move.action = "<%=urlPage%>rms/admin/form/down.jsp";	
	document.move.seq.value = seq;	
	document.move.filenm.value = filename;		
	document.move.submit();
}

</script>

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
