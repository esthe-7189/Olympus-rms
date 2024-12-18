<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "mira.info.Category" %>
<%@ page import = "mira.info.CateMgr" %>
<%@ page import = "mira.info.InfoBean" %>
<%@ page import = "mira.info.InfoMgr" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.sql.Timestamp" %>

<%! 
static int PAGE_SIZE=15; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
String urlPage=request.getContextPath()+"/orms/";	
String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	

	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");

	List whereCond = null;
	Map whereValue = null;
	
	boolean searchCondTitle = false;	
	boolean searchCondCateL=false;
	boolean searchCondCateM=false;

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("title")){
				whereCond.add("title LIKE '%"+searchKey+"%'");		
				searchCondTitle = true;
			}else if (searchCond[i].equals("cate_m")){
				whereCond.add(" cate_M_seq!=0 ");				
				searchCondCateM = true;
			}else if (searchCond[i].equals("cate_l")){
				whereCond.add(" cate_M_seq=0 ");					
				searchCondCateL = true;
			}	
		}
	}

	InfoMgr manager = InfoMgr.getInstance();		
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
//대,중분류 호출	
	CateMgr managerCate = CateMgr.getInstance();	
	Category cateDb;	
	String catestring="";	
	int cateseq=0;
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

<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">関連情報管理
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>	
</table>	
<p>

<table border="0" cellpadding="0" cellspacing="0" class=c width="100%"  bgcolor="#F7F5EF">				
		<tr>
			<td  style="padding-top:20px;" >						
				<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
					<tr>
					<td style="padding: 2 0 2 0">

<table width="95%" border='0' cellpadding='0' cellspacing='1'>
<form name="move" method="post">
    <input type="hidden" name="seq" value="">    
    <input type="hidden" name="page" value="${currentPage}">    
    <c:if test="<%= searchCondCateL%>">
    <input type="hidden" name="search_cond" value="cate_l">
    </c:if>	
    <c:if test="<%= searchCondCateM%>">
    <input type="hidden" name="search_cond" value="cate_m">
    </c:if>	
    <c:if test="<%= searchCondTitle%>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>
</form>
	<tr>
	<form name="search"  action="<%=urlPage%>admin/info/infoList.jsp?page=1" method="post">		
		<td valign="middle" width="17%">			
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="select_type2" onKeyPress="return doSubmitOnEnter()">
				  	 <option name="search_cond" VALUE="" >::::::::::::Search::::::::::::::::</OPTION>	
			            	<option name="search_cond" VALUE="cate_l" >大分類</OPTION>	
			          	<option name="search_cond" VALUE="cate_m" >中分類</OPTION>			          	
					<option name="search_cond" VALUE="title"  >タイトル</OPTION>		
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="20%" align="left">
		 	<input type=text  name="search_key" size="30"  class="input02" >
		 </td>
		 <td valign="middle" width="10%" align="left">		 			  
		 	<input type="submit" name="" value="検索"  id="Search" title="SEARCH!" class="button buttonBright" />
		 </td>
		 <td valign="middle" width="10%" align="left">
		 	<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>admin/info/infoList.jsp?page=1'" id="LIST!"  title="LIST!" class="button buttonBright" />		  
		 </td>
		 			
		<td align="right" width="43%">	
			<input type="button" name="" value="書く" onclick="location.href='<%=urlPage%>admin/info/cateAddForm.jsp'" id="Write!"  title="Write!" class="button buttonGeneral" />	
		</td>		
	</tr>
	</form>
</table>
		<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr bgcolor="" align=center height=26>				
				<td  width="5%" bgcolor=#F1F1F1>展示順番</td>
				<td  width="15%"  bgcolor=#F1F1F1>大分類</td>
				<td  width="20%"  bgcolor=#F1F1F1>中分類</td>				
				<td  width="32%"  bgcolor=#F1F1F1>タイトル</td>
				<td  width="8%" bgcolor=#F1F1F1>登録日</td>							
				<td   width="8%" bgcolor=#F1F1F1>展示可否</td>				
				<td   width="6%" bgcolor=#F1F1F1>修正</td>
				<td   width="6%" bgcolor=#F1F1F1>削除</td>				
			</tr>			
	<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td colspan="8">登録された内容がありません。</td></tr>
	</c:if>
<c:if test="${! empty list}">				
<%int i=1;	%>		
		
	<%Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			InfoBean info=(InfoBean)listiter.next();
			int seq=info.getSeq();											
			if(seq!=0){	
				String yymmdd=dateFormat.format(info.getRegister());
				int view_yn=info.getView_yn();
				int cateL=	info.getCate_L_seq();
				int cateM=info.getCate_M_seq();			
	%>
			 <tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">				 
				 <td><%=info.getView_seq()%></td>
				 <td align="left">
					<%cateDb=managerCate.select(cateL); cateseq=cateDb.getBseq(); if(cateseq!=0){catestring=cateDb.getName();%><%=catestring%><%}%>
				</td>
				 <td align="left">
					<%if(cateM!=0){cateDb=managerCate.select(cateM);cateseq=cateDb.getBseq();catestring=cateDb.getName();%><%=catestring%>
					<%}else{%>...<%}%>				
				</td>				
				<td  align="left">
					<a href="javascript:goRead('<%=seq%>')"  onfocus="this.blur()">
					<%=info.getTitle()%></a>
				</td>
				<td><%=yymmdd%></td>
				<td  align="center">
					<%if (view_yn==1){%>					
						はい
					<%}else if(view_yn==2){%>					
						いいえ
					<%}%>	
				</td>							
				<td>
					<a href="javascript:goModify('<%=cateM%>')" onfocus="this.blur()">
					<img src="<%=urlPage%>images/admin/icon_admin_pen.gif" alt="Modify" >
					</a></td>
				<td>
					<a href="javascript:goDelete('<%=cateM%>')"  onfocus="this.blur()">
					<img src="<%=urlPage%>images/admin/icon_admin_x.gif" alt="Cancel">
					</a></td>
				</tr>							
	<%}
	i++;
}%>
	</c:if>
		</table>
<table>
<tr>
	<td height="14">&nbsp;<td>
</tr>
</table>

<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>admin/info/infoList.jsp";
    document.move.page.value = pageNo;
    document.move.submit();
}
function goRead(seq) {
    document.move.action = "<%=urlPage%>admin/info/read.jsp";
    document.move.seq.value = seq;
    document.move.submit();
}
function goModify(seq) {
	document.move.action = "<%=urlPage%>admin/info/updateForm.jsp";
	document.move.seq.value=seq;
    	document.move.submit();
}
function goDelete(seq) {
	document.move.seq.value=seq;	
	
	if ( confirm("本内容を削除しましょうか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>admin/info/deleteForm.jsp";	
    	document.move.submit();
}

</script>

<!-- *****************************page No start******************************-->		
<c:set var="count" value="<%= Integer.toString(count) %>" />
<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
		
<table cellpadding=0 cellspacing=0 border=0 height=20 align="center" width="45%">
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
			<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>images/admin/LeftBox.gif"></a>
		</td>
    	</c:if>    	
        	<td  style="padding-right:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<img src="<%=urlPage%>images/admin/LeftBox.gif" style="filter:Alpha(Opacity=40);">
		</td>  
		<td align=center valign=absmiddle width="70%">
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
        	<td width="" style="padding-left:8" valign=absmiddle style="padding-top:4px;">
			<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>images/admin/RightBox.gif"></a>
		</td>
    	</c:if>
		<td  style="padding-left:8" valign=absmiddle style="padding-top:4px;">			
			<img src="<%=urlPage%>images/admin/RightBox.gif" style="filter:Alpha(Opacity=40);">
		</td>			
</c:if>
		
		<c:if test="<%= count >= 0 %>">
		<td   width="50" style="padding-left:8" style="padding-top:4px;">			
			total:<font color="#807265">(<%= count %>)</font>		
		</td>	
		</c:if>
   </tr>
</table>
<!-- *****************************page No end-->					

<td>
</tr>
<tr>
	<td valign="middle" >	
<c:if test="<%= searchCondCateM || searchCondCateL || searchCondTitle %>">
	検索条件: [
	<c:if test="<%= searchCondCateL %>">大分類</c:if>
	<c:if test="<%= searchCondCateM %>">中分類</c:if>	
	<c:if test="<%= searchCondTitle %>">タイトル</c:if>	
	= 
	<%=searchKey%> ]
			
</c:if>
		</td> 		
</td>
</table>