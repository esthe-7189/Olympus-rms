<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import = "mira.shokudata.FileMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
static int PAGE_SIZE=15; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

<%	
String title = ""; String name=""; String mailadd=""; String pass=""; 
int mseq=0; int level=0; int posiLevel=0; String busho=""; String Hcate=""; int parentNo=0;


String inDate=dateFormat.format(new java.util.Date());		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	MemberManager mem = MemberManager.getInstance();	
	Member member=mem.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();		 
		 mseq=member.getMseq();		
		 busho=member.getBusho();		
	}	
String pageNum = request.getParameter("page");	
FileMgr manager = FileMgr.getInstance();

//대분류
 List listView=manager.selectPageGo(mseq);

    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	

	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");	
	List whereCond = null;
	Map whereValue = null;
	
	boolean searchCondTitle = false;		
	boolean searchCondCateM=false;
//	boolean searchCondCateH=false;
//	boolean searchCondCateView=false;

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("title")){
				whereCond.add(" LGROUP_NO ="+searchKey);		
				searchCondTitle = true;
			}else if (searchCond[i].equals("filename")){
				whereCond.add(" filename LIKE '%"+searchKey+"%'");			
				searchCondCateM = true;
			}
		}
	}
/*	
	else{
		if(cate_sch!=null){
			whereCond = new java.util.ArrayList();
			whereValue = new java.util.HashMap();
			whereCond.add("a.LGROUP_NO="+cate_sch);			
			searchCondCateH = true;
		}
		
		else if(mseq!=0 && pageArrow==2){
			whereCond = new java.util.ArrayList();
			whereValue = new java.util.HashMap();
			whereCond.add("a.mseq="+mseq);			
			searchCondCateView = true;
		}
	
	}	
*/

      int count = manager.countAll(whereCond, whereValue);
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

	List  list=manager.selectListAll(whereCond, whereValue,startRow,endRow);
//대,중분류 호출	
	CateMgr managerCate = CateMgr.getInstance();	
	Category cateDb;	Category cateDb2;
	String catestring="";	
	int cateseq=0;
//	Category cateMenu=managerCate.getCateParent(pgInt);
%>
<c:set var="list" value="<%= list %>" />
<c:set var="listView" value="<%= listView %>" />
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">月報・週報開発/QMS<font color="#A2A2A2">&nbsp;>&nbsp;</font>全体リスト</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="開発会議&QMSデータメイン" onClick="location.href='<%=urlPage%>rms/admin/shokuData/mainForm.jsp'">	
		 	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体リスト" onClick="location.href='<%=urlPage%>rms/admin/shokuData/listFormAll.jsp'">			
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="職員閲覧可否決定" onClick="location.href='<%=urlPage%>rms/admin/shokuData/viewMgr.jsp'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/shokuData/cateAddForm.jsp'">				
</div>
<div id="boxNoLine"  >
	
	
<table width="975" border="0" cellpadding="0" cellspacing="0"   bgcolor="">								
<form name="move" method="post">
    <input type="hidden" name="seq" value="">  
    <input type="hidden" name="fileNm" value="">  
    <input type="hidden" name="groupId" value="">  
    <input type="hidden" name="pg" value="">   
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
	<form name="search"  action="<%=urlPage%>rms/admin/shokuData/listFormAll.jsp" method="post">			
		<td valign="middle" width="13%">			
			<div  class="" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="" >
				  	 <option name="search_cond" VALUE="" >:::::::Search:::::::</OPTION>				            	
			          	<option name="search_cond" VALUE="filename" >ファイル名</OPTION>			          	
					<option name="search_cond" VALUE="title"  >固有No</OPTION>		
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="14%" align="left">
		 	<input type=text  name="search_key" size="20"  class="input02" >
		 </td>
		 <td valign="middle" width="9%" align="center">		 			  
		 	<input type="submit" name="" value="    検索   "   class="cc" id="Search" title="SEARCH!" class="button buttonBright" />
		 </td>	    			
		 <td width="64%"  valign="bottom"  align="right" style="padding:5 0 5 15">		
		 	&nbsp;		
	    </td>				
	</tr>
	</form>
</table>

<table width="975"  cellpadding="2" cellspacing="2" class="tablebox_list">
	<tr bgcolor=#F1F1F1 align=center height=26>			
				<td  width="3%" class="clear_dot">固有No</td>
				<td  width="9%" class="clear_dot">大分類</td>
				<td  width="13%"  class="clear_dot">中分類</td>
				<td  width="12%"  class="clear_dot">小分類</td>				
				<td  width="7%"  class="clear_dot">お名前</td>				
				<td  width="15%"  class="clear_dot">タイトル</td>
				<td  width="29%"  class="clear_dot">ファイル</td>
				<td  width="8%" class="clear_dot">登録日</td>							
				<td   width="4%" class="clear_dot">削除</td>											
			</tr>			
	<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td colspan="9">登録された内容がありません。</td></tr>
	</c:if>
	<c:if test="${! empty list}">				
<%	int i=1; 
	int groupId=0; //삭제시 구룹id
%>		
		
	<%Iterator listiter=list.iterator();					

		while (listiter.hasNext()){
			Category job=(Category)listiter.next();
			int seq=job.getBseq();											
			if(seq!=0){	
				String yymmdd=dateFormat.format(job.getRegister());
				int del_yn=job.getOk_yn();  //삭제여부 2는 삭제요청, 1은 기본
				int cateH=job.getKind();  //대분류
				Category cateMenu2=managerCate.getCateParent(cateH);
				int cateM=job.getCate_cnt();	
				groupId=job.getHenji_yn();  // 삭제시 그룹id		
				Member mem2=mem.getDbMseq(job.getMseq());				
	%>
			 <tr  align="left" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">				 
				 <td class="clear_dot" align="center"><%=cateMenu2.getBseq()%></td>
				 <td class="clear_dot"><%=cateMenu2.getName()%></td>
				 <td class="clear_dot" align="left">
	<%
		cateDb=managerCate.select(cateM);
		if(cateDb.getBseq() !=0){
			parentNo=cateDb.getParentId();
			if(parentNo!=0){
				cateDb2=managerCate.select(parentNo);			
				catestring=cateDb2.getName();%><%=catestring%>
	<%}}else{%> ---
	<%}%>			
				</td>
				 <td class="clear_dot" align="left">
	<%
		cateDb=managerCate.select(cateM);
		if(cateDb.getBseq() !=0){
			cateseq=cateDb.getBseq();
			catestring=cateDb.getName();%><%=catestring%>
	<%}else{%> ---
	<%}%>				
				</td>
				<td class="clear_dot"><%if(mem2==null){%>-- <%}else{%><%=mem2.getNm()%><%}%></td>				
				<td  class="clear_dot" align="left"><%=job.getTitle()%>&nbsp;</td>				
				<td class="clear_dot"><a class="fileline" href="javascript:goDown2('<%=job.getFile()%>')"  onfocus="this.blur()">
					<%=job.getFile()%>
					</a>
				</td>
				<td class="clear_dot" align="center"><%=yymmdd%></td>				
				<td class="clear_dot" align="center">
					<%if(job.getMseq()==mseq){%>							
					<a href="javascript:goDelete('<%=job.getFile_bseq()%>','<%=job.getFile()%>','<%=groupId%>')"  onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>	
					<%}else{%>---<%}%>
				</td>								
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
<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/shokuData/listFormAll.jsp";
    document.move.page.value = pageNo;    
    document.move.submit();
}
function goDown2(filename) {		
    	document.move.action = "<%=urlPage%>rms/admin/shokuData/down.jsp";
	document.move.fileNm.value=filename;	
    	document.move.submit();	
}
function goModify(seq) {
	document.move.action = "<%=urlPage%>rms/admin/shokuData/listFormAll.jsp";
	document.move.seq.value=seq;
    	document.move.submit();
}
function goDelete(seq,fileNm,groupId) {

alert("準備中");
/*
	document.move.seq.value=seq;
	document.move.fileNm.value=fileNm;	
	document.move.pg.value="";	
	document.move.groupId.value=groupId;
		
	if ( confirm("本内容を削除しましょうか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>rms/admin/shokuData/delete.jsp";	
    	document.move.submit();
  */
}

</script>

