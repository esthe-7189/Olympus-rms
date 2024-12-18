<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
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
    	
	int level_mem=0;int mseq=0;
	MemberManager managermem=MemberManager.getInstance();
	Member member=managermem.getMember(id);
	if(member!=null){
		level_mem=member.getLevel();
		mseq=member.getMseq();
	}

		Calendar calen=Calendar.getInstance();
		Date trialTime=calen.getTime();
		String ddate=dateFormat.format(trialTime);		
		String sdate="";	String	wdate="";String mdate="";String sixmdate="";String yeardate="";	
		
		Calendar cal=new GregorianCalendar();
		cal.setTime(trialTime);
		cal.add(cal.DATE,+1);	Date curTime=cal.getTime();sdate=dateFormat.format(curTime);
		cal.add(cal.DATE,+7);	Date curTime7=cal.getTime();wdate=dateFormat.format(curTime7);
		
		Calendar cal2=new GregorianCalendar();
		cal2.setTime(trialTime);
		cal2.add(cal2.MONTH,+1);	Date curTime30=cal2.getTime();mdate=dateFormat.format(curTime30);
		cal2.add(cal2.MONTH,+5);	Date curTime6=cal2.getTime();sixmdate=dateFormat.format(curTime6);
		
		Calendar cal3=new GregorianCalendar();
		cal3.setTime(trialTime);
		cal3.add(cal3.YEAR,+1);	Date curTime12=cal3.getTime();yeardate=dateFormat.format(curTime12);
	String today=dateFormat.format(new java.util.Date());
	String bunDay=today.substring(0,4);
	int bunDayInt=Integer.parseInt(bunDay)+1;

	String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	
    
    
	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");
	String[] searchRadio=request.getParameterValues("search_radio");
	String sel_bgndate=request.getParameter("sel_bgndate");
	String sel_enddate=request.getParameter("sel_enddate");
	String search_cate=request.getParameter("search_cate");
	String search_gigi=request.getParameter("search_gigi");
	
	List whereCond = null;
	Map whereValue = null;

	boolean searchCondFilename = false; boolean searchCondTitle = false; boolean searchCondOrderseq = false;boolean searchCondDD = false;boolean searchCondWW = false;
	boolean searchCondMM = false; boolean searchCondSS = false; boolean searchCondYY = false;	
	boolean searchCondYMD = false; boolean searchCate=false; boolean searchJitsi=false;

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("filename")){
				whereCond.add(" seizomoto LIKE '%"+searchKey+"%'");				
				searchCondFilename=true;
			}else if (searchCond[i].equals("title")){
				whereCond.add(" product_nm LIKE '%"+searchKey+"%'");
				searchCondTitle = true;
			}			
		}
	}else if (searchRadio !=null && searchRadio.length>0 ){
		for (int y=0;y<searchRadio.length ;y++ ){
			if (searchRadio[y].equals("dd")){
				whereCond.add(" date01 LIKE '"+ddate+"%'  or date02 LIKE '"+ddate+"%'");				
				searchCondDD=true;
			}else if (searchRadio[y].equals("ww")){
				whereCond.add(" (date01 BETWEEN '"+sdate+"' and '"+wdate+"') or (date02 BETWEEN '"+sdate+"' and '"+wdate+"') ");				
				searchCondWW=true;			
			}else if (searchRadio[y].equals("mm"))	{
				whereCond.add(" (date01 BETWEEN '"+sdate+"' and '"+mdate+"')  or  (date02 BETWEEN '"+sdate+"' and '"+mdate+"') ");					
				searchCondMM=true;
			}else if (searchRadio[y].equals("ss")){
				whereCond.add(" (date01 BETWEEN '"+sdate+"' and '"+sixmdate+"') or  (date02 BETWEEN '"+sdate+"' and '"+sixmdate+"') ");					
				searchCondSS=true;
			}else if (searchRadio[y].equals("yy")){
				whereCond.add(" (date01 BETWEEN '"+sdate+"' and '"+yeardate+"') or  (date02 BETWEEN '"+sdate+"' and '"+yeardate+"') ");					
				searchCondYY=true;		
			}else if (searchRadio[y].equals("ymd")){				
				whereCond.add(" (date01 BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"') or  (date02 BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"')");					
				searchCondYMD=true;
			}

		}
	}
	if(search_cate !=null){				
		whereCond.add(" kanri_no LIKE '%"+search_cate+"%'");
		searchCate=true;
	}
	
	if(search_gigi !=null){				
		whereCond.add(" gigi_nm LIKE '%"+search_gigi+"%'");
		searchJitsi=true;
	}

	GmpManager manager=GmpManager.getInstance();		
	
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
	List listKanri=manager.listKanri();			
	List listGigi=manager.listGigi();
	

int pageArrowmodi=0; int pageArrowdel=0; 
if(id.equals("juc0318") || id.equals("admin") || id.equals("ueno") || id.equals("takeda") || id.equals("shiba")){ pageArrowmodi=1;}else{pageArrowmodi=2;}
if(id.equals("juc0318") || id.equals("admin") || id.equals("ueno") || id.equals("takeda") || id.equals("shiba")){ pageArrowdel=1;}else{pageArrowdel=2;}
%>
<c:set var="list" value="<%= list %>" />	
<c:set var="listKanri" value="<%= listKanri %>" />
<c:set var="listGigi" value="<%= listGigi %>" />
	
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#jitsidate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#sel_bgndate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
$(function() {
   $("#sel_enddate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
</script>	
	
	
	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">校正対象設備等一覧 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>rms/admin/gmp/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>rms/admin/gmp/addForm.jsp'">			
</div>
<div id="boxNoLineBig"  >
	<div id="searchBox">
	<div class="searchBox_left">
<form name="searchCate"  action="<%=urlPage%>rms/admin/gmp/listForm.jsp" method="post">		
		<div class="searchBox_left01">
<!--********search begin-->
<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">管理番号検索</span></br>				
		<select name="search_cate"  style="font-size:12px;color:#7D7D7D;" >														
			<option name="search_cate" value="0" >::::::: 検索 :::::::</option>
	<c:if test="${empty listKanri}">				
			 <option name="search_cate" value="0">no data!!</option>			    		
	</c:if>				
	<c:if test="${! empty listKanri}">
	<%
	int i=1; 
	Iterator listiter=listKanri.iterator();
		while (listiter.hasNext()){				
			GmpBeen dbb=(GmpBeen)listiter.next();
			int bseq=dbb.getBseq();	%>	  
			<option name="search_cate" value="<%=dbb.getKanri_no()%>"><%=dbb.getKanri_no()%></option>
	<%i++;}%>	
	</c:if>											
			</select>							
			<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">			
	</div>	
</form>
	<form name="searchjitsi"  action="<%=urlPage%>rms/admin/gmp/listForm.jsp" method="post">			
	<div class="searchBox_left02">
	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">設備等名 検索 </span></br>
			<select name="search_gigi"  style="font-size:12px;color:#7D7D7D;" >														
			<option name="search_gigi" value="0" >::::::: 検索 :::::::</option>			
				<c:if test="${empty listGigi}">
					<option  value="0">データなし</option>					
				</c:if>
				<c:if test="${! empty listGigi}">
				<c:forEach var="code" items="${listGigi}" varStatus="index" >
						<option  value="${code.gigi_nm}"  >${code.gigi_nm}</option>								
				</c:forEach>
				</c:if>									
			</select>	<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">				
	</div>
</form>									
</div>		
<form name="search"  action="<%=urlPage%>rms/admin/gmp/listForm.jsp" method="post">
	<div class="searchBox_right">	
		<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">導入部門　検索</span><br>						
			<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
				<option name="" VALUE=""  >::::::: 検索 :::::::</option>
				<!--<option name="search_cond" VALUE="title"  >製品名</option>-->	
				<option name="search_cond" VALUE="filename"  >導入部門</option>											
			</select>
				<input type="TEXT" NAME="search_key" VALUE="" SIZE="25" class="input02" >
				<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">												
	</div>	
</form>	
<div class="clear"></div>
<div class="searchBox_all">				
	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">実施日 検索</span>	
		<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
			<form name="searchDate"   action="<%=urlPage%>rms/admin/gmp/listForm.jsp" method="post"  >
				<tr >
					<td colspan="2" style="padding: 3px 0px 3px 3px;">
						<img src="<%=urlPage%>rms/image/icon_ball.gif" >
検索方法　: <font color="#807265">①丸をチェック</font> --> <font color="#807265">②内容を選択</font> --> <font color="#807265">③検索ボタンをクリックする</font>&nbsp;&nbsp;
<font color="#807265">(<font color="#009900">一日</font>から<font color="#009900">一年間</font>までは丸をチェックし、検索ボタンをクリックする)</font>
					</td>
				</tr>
				<tr>
					<td width="85%" style="padding: 2px 0px 2px 2px;">		
							<input type="radio" name="search_radio"  value="ymd"  onfocus="this.blur()" >期間指定: 			
<input type="text" size="13%" name="sel_bgndate" id="sel_bgndate" value="" style="text-align:center">	~ <input type="text" size="13%" name="sel_enddate" id="sel_enddate" value="" style="text-align:center">
						&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="search_radio"  value="dd"  onfocus="this.blur()" ><font color="#009900">一日</font> &nbsp;
							<input type="radio" name="search_radio"  value="ww" onfocus="this.blur()"><font color="#009900">一週間</font> &nbsp;
							<input type="radio" name="search_radio"  value="mm" onfocus="this.blur()"><font color="#009900">一ヶ月間 </font>&nbsp;
							<input type="radio" name="search_radio"  value="ss" onfocus="this.blur()"><font color="#009900">六ヶ月間 </font>&nbsp;
							<input type="radio" name="search_radio"  value="yy" onfocus="this.blur()"><font color="#009900">一年間 </font>&nbsp;     						
						
					</td>								
					<td width="15%"    align="center" rowspan="2">
						<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">
							
					</td>
				</tr>				
					</form>									
			</table>					
	</div>				
</div><!--searchBox-->
	
<!--********search end-->
<table width="85%">
		<tr>		
		<td width="80%" align="left">
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
			<td width="20%" align="right"><font  color="#FF6600">(<%=count%>個)</font>  			
    		※Excel<a href="javascript:excelDown()" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle" title="ダウンロードをする"></a>
    		<input type="submit" class="cc" onClick="excelExplain();" onfocus="this.blur();" style=cursor:pointer value="方法を見る">						
		</td>
	
		</tr>
</table>	
							
<table width="85%"  class="tablebox_list" cellpadding="2" cellspacing="2" >	 	 
	<tr bgcolor="#eeeeee" align=center height=26>	
	    <td  align="center" colspan="4" class="title_list_L" >設備等情報</td>
	    <td  align="center" colspan="3" class="title_list_L">校正</td>	    
	    <td  align="center" rowspan="2"  class="title_list_m">修正</td>	
    	    <td  align="center" rowspan="2" class="title_list_m">削除</td>
	</tr>
	<tr bgcolor=#F1F1F1 align=center height=26>		    
	    <td  align="center" class="title_list_m">管理番号</td>	    	    
	    <td  align="center" class="title_list_m">設備等名称</td>	    
	    <td  align="center" class="title_list_m">設置場所</td>	
	    <td  align="center" class="title_list_m">導入部門</td>		    
		<td  align="center" class="title_list_m">校正頻度(使用前点検)</td>  
		<td  align="center" class="title_list_m">実施日</td>
		<td  align="center" class="title_list_m">実施期限(ステータス)</td>				
	</tr>
<c:if test="${empty list}">
				<td colspan="7" class="clear_dot">no data</td>			
</c:if>
<c:if test="${! empty list}">
<%
int i=1; 
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		GmpBeen db_item=(GmpBeen)listiter.next();
		int seq=db_item.getBseq();
		String aadd=dateFormat.format(db_item.getRegister());
		int mseqDb=db_item.getMseq();
		int getLevel=db_item.getLevel();
						
%>								
				
	<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	    
	    <td  class="clear_dot"><%=db_item.getKanri_no()%>&nbsp;<img src="<%=urlPage%>rms/image/calSmall.gif" align="absmiddle" title="登録日:<%=aadd%>"></td>	    
	    
	    <td class="clear_dot"><a href="javascript:goRead(<%=seq%>)"  onfocus="this.blur()">
	    	<font color="#007AC3"><%if(db_item.getGigi_nm()!=null){%><%=db_item.getGigi_nm()%><%}else{%>&nbsp;<%}%>&nbsp; </font></a>	    	
	    </td>	    
	    <td class="clear_dot"><%if(db_item.getPlace()!=null){%><%=db_item.getPlace()%><%}else{%>&nbsp;<%}%> </td>	
	    <td  align="center" class="clear_dot"><%if(db_item.getSeizomoto()!=null){%><%=db_item.getSeizomoto()%><%}else{%>&nbsp;<%}%>  	    		
	    </td>		    
	    <td  align="center" class="clear_dot"><%=db_item.getHindo()%>
	    <%if(db_item.getSeizo_no().equals("1")){%><font color="#009900">(Yes)</font><%}else{%><font color="#fd8024">(No)</font> <%}%>
	    	</td>  	    
	    <td  align="center" class="clear_dot" ><%if(db_item.getDate01()!=null){%><%=db_item.getDate01()%><%}else{%>&nbsp;<%}%> 	    		
	    </td>
	    <td  align="center" class="clear_dot" ><%if(db_item.getDate02()!=null){%><%=db_item.getDate02()%><%}else{%>&nbsp;<%}%> 
	    		<%if(db_item.getEda_no()==1){%>
			<font color="#007AC3">[使用可]</font></a>
			<%}else{%><font color="#FF6600">[使用不可]</font><%}%>
	    </td>	    
	    <td align="center" class="clear_dot">
			<%if(pageArrowdel==1 || db_item.getMseq()==mseq){%>
		<a href="javascript:goModify(<%=seq%>)"  onfocus="this.blur()">		
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>			
<%}else{%>
		<a href="javascript:alert('担当者のみ処理出来ます。');"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>	
<%}%>			

		</td>
	   <td align="center" class="clear_dot">
<%if(pageArrowdel==1){%>			
		<a href="javascript:goDelete('<%=db_item.getKanri_no()%>','<%=seq%>','<%=db_item.getFile_manual()%>')"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>	
<%}else{%>	
		<a href="javascript:alert('担当者のみ処理出来ます。');"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>	
<%}%>	 	

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
<form name="move" method="post">
	<input type="hidden" name="read" value="">
    <input type="hidden" name="seq" value="">        
    <input type="hidden" name="filename" value="">        
    <input type="hidden" name="page" value="${currentPage}">
    <c:if test="<%= searchCondFilename %>">
    <input type="hidden" name="search_cond" value="filename">
    </c:if>
    <c:if test="<%= searchCondTitle %>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>
	<c:if test="<%= searchCondDD %>">
    <input type="hidden" name="search_radio" value="dd">
    </c:if>
	<c:if test="<%= searchCondWW %>">
    <input type="hidden" name="search_radio" value="ww">
    </c:if>
	<c:if test="<%= searchCondMM %>">
    <input type="hidden" name="search_radio" value="mm">
    </c:if>
	<c:if test="<%= searchCondSS %>">
    <input type="hidden" name="search_radio" value="ss">
    </c:if>
	<c:if test="<%= searchCondYY %>">
    <input type="hidden" name="search_radio" value="yy">
    </c:if>    
	<c:if test="<%= searchCondYMD %>">
    <input type="hidden" name="search_radio" value="ymd">
    <input type="hidden" name="sel_bgndate" value="<%=sel_bgndate%>">
    <input type="hidden" name="sel_enddate" value="<%=sel_enddate%>">
    </c:if>   
    <c:if test="<%= searchCondOrderseq %>">
    	<input type="hidden" name="search_radio" value="seq">
    </c:if>
    
    <c:if test="<%= searchCate %>">
    	<input type="hidden" name="search_cate" value="<%=search_cate%>">
    </c:if>
    <c:if test="<%= searchJitsi %>">
    	<input type="hidden" name="search_gigi" value="<%=search_gigi%>">
    </c:if>
</form>			
				 
</div>	
<div class="clear_margin"></div>	<div class="clear_margin"></div>	

<script language="JavaScript">
function goPage(pageNo) {    
    	document.move.page.value = pageNo;
	document.move.action = "<%=urlPage%>rms/admin/gmp/listForm.jsp";
    	document.move.submit();
}
function goDelete(code,seq,filename) {
	if(confirm(code+"のデータを削除しますか?")!=1){return;}
	document.move.action = "<%=urlPage%>rms/admin/gmp/delete.jsp";
	document.move.seq.value = seq;	
	document.move.filename.value = filename;
    	document.move.submit();
}
function goModify(seq) {	
    	document.move.action = "<%=urlPage%>rms/admin/gmp/updateForm.jsp";
	document.move.seq.value=seq;		
    	document.move.submit();
}
function goRead(seq) {
    	document.move.action = "<%=urlPage%>rms/admin/gmp/updateForm.jsp";    
	document.move.seq.value=seq;
	document.move.read.value="read";		
    	document.move.submit();
}
function goDown(seq,filename) {		
	document.move.action = "<%=urlPage%>rms/admin/gmp/down.jsp";
	document.move.seq.value = seq;	
	document.move.filename.value = filename;
	document.move.submit();
}
function excelDown(){		
	document.move.action = "<%=urlPage%>rms/admin/gmp/listExcel.jsp";	
    	document.move.submit();
}
function excelExplain(){		
	openNoScrollWin("<%=urlPage%>rms/admin/excelDown_pop.jsp", "ExcelDown", "signAdd", "500", "350","");
}
</script>

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
