<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "mira.contract.DownMgr" %>
<%@ page import = "mira.contract.Category" %>
<%@ page import = "mira.contract.CateMgr" %>
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

if(kind!=null && ! kind.equals("toku")){
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
	String docontact=request.getParameter("docontact");
	String[] searchRadio=request.getParameterValues("search_radio");
	String sel_bgndate=request.getParameter("sel_bgndate");
	String sel_enddate=request.getParameter("sel_enddate");
	String search_cate=request.getParameter("search_cate");
	String search_kind=request.getParameter("search_kind");
	String search_kousin=request.getParameter("search_kousin");
	if(docontact==null){docontact="0";}
	
	List whereCond = null;
	Map whereValue = null;
    
	boolean searchCondContact = false; boolean searchCondFilename = false; boolean searchCondTitle = false; 
	boolean searchCondOrderseq = false;boolean searchCondDD = false;boolean searchCondWW = false;
	boolean searchCondMM = false; boolean searchCondSS = false; boolean searchCondYY = false;	
	boolean searchCondYMD = false; boolean searchCate=false; boolean searchKousin=false; boolean searchKind=false;
	
	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();	
	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("filename")){
				whereCond.add(" a.file_nm LIKE '%"+searchKey+"%'");				
				searchCondFilename=true;
			}else if (searchCond[i].equals("contact")){
				whereCond.add(" a.contact LIKE '%"+searchKey+"%'");
				searchCondContact = true;				
			}else if (searchCond[i].equals("title")){
				whereCond.add(" a.title LIKE '%"+searchKey+"%'");
				searchCondTitle = true;
			}			
		}
	}else if (searchRadio !=null && searchRadio.length>0 ){
		for (int y=0;y<searchRadio.length ;y++ ){
			if (searchRadio[y].equals("dd")){
				whereCond.add(" a.date_end LIKE '"+ddate+"%' ");				
				searchCondDD=true;
			}else if (searchRadio[y].equals("ww")){
				whereCond.add(" a.date_end BETWEEN '"+sdate+"' and '"+wdate+"' ");				
				searchCondWW=true;			
			}else if (searchRadio[y].equals("mm"))	{
				whereCond.add(" a.date_end BETWEEN '"+sdate+"' and '"+mdate+"' ");					
				searchCondMM=true;
			}else if (searchRadio[y].equals("ss")){
				whereCond.add(" a.date_end BETWEEN '"+sdate+"' and '"+sixmdate+"' ");					
				searchCondSS=true;
			}else if (searchRadio[y].equals("yy")){
				whereCond.add(" a.date_end BETWEEN '"+sdate+"' and '"+yeardate+"' ");					
				searchCondYY=true;		
			}else if (searchRadio[y].equals("ymd")){				
				whereCond.add(" a.date_end BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"' ");					
				searchCondYMD=true;
			}

		}
	}
	if(search_cate !=null){				
		whereCond.add(" a.kubun_bseq=?");
		whereValue.put(new Integer(1),search_cate);
		searchCate=true;
	}
	if(search_kousin !=null){				
		whereCond.add(" a.renewal LIKE '%"+search_kousin+"%'");
		searchKousin=true;
	}
	if(search_kind !=null){				
		whereCond.add(" a.contract_kind LIKE '%"+search_kind+"%'");
		searchKind=true;
	}
	
	
	ContractMgr manager=ContractMgr.getInstance();			
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
	
	CateMgr mgrCate = CateMgr.getInstance();	 
 	List listKubun=mgrCate.listMcate();	
 
	List listkousin=manager.listKousin(); 
	List listKind=manager.listKind(); 
	List listContact=manager.listContact();			
	DownMgr mgrDown = DownMgr.getInstance();
	List  listDown;
	int pageArrowCon=0;
	if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin") || id.equals("hamano") || id.equals("funakubo")){ pageArrowCon=1;	}else{pageArrowCon=2;}
%>
<c:set var="list" value="<%= list %>" />	
<c:set var="listKubun" value="<%= listKubun %>" />
<c:set var="listkousin" value="<%= listkousin %>" />
<c:set var="listKind" value="<%=listKind%>"/>
<c:set var="listContact" value="<%= listContact %>" />
<c:set var="pageArrowCon" value="<%= pageArrowCon %>" />
	
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script language="javascript">
$(function() {
   $("#jitsidate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

$(function() {
   $("#sel_bgndate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
$(function() {
   $("#sel_enddate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
  
  
function ShowHidden(MenuName, ShowMenuID,kind){
	var menu="";
	for ( i = 1; i <= 30;  i++ ){
		if(kind=="title"){
			menu= eval("document.all.itemData_block" + i + ".style");	
		}				
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

<div id="overlay"></div>	
	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">契約書リスト管理</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>tokubetu/admin/contract/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規登録 " onClick="location.href='<%=urlPage%>tokubetu/admin/contract/addForm.jsp'">			
</div>
<div id="boxNoLineBig"  >
	
<div id="searchBox">
	<div class="searchBox_left">
		<form name="searchCate"  action="<%=urlPage%>tokubetu/admin/contract/listForm.jsp" method="post">		
			<div class="searchBox_left01">
			<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">契約区分 検索</span></br>				
				<select name="search_cate"  style="font-size:12px;color:#7D7D7D;" >														
							<option name="search_cate" value="0" >::::::: 検索 :::::::</option>			
					<c:if test="${empty listKubun}">
							<option  value="0">データなし</option>					
					</c:if>
					<c:if test="${! empty listKubun}">
						<c:forEach var="code" items="${listKubun}" varStatus="index" >
							<c:if test="${pageArrowCon==1}">
								<option  value="${code.bseq}"  >${code.name}</option>								
							</c:if>
							<c:if test="${pageArrowCon==2 &&  code.bseq!=1}">
								<option  value="${code.bseq}"  >${code.name}</option>								
							</c:if>
						</c:forEach>
					</c:if>									
					</select>												
					<input type="submit" class="ccsmal" onfocus="this.blur();" style=cursor:pointer value="検索 >>">			
			</div>	
	</form>
	
	<form name="searchKind"  action="<%=urlPage%>tokubetu/admin/contract/listForm.jsp" method="post">			
		<div class="searchBox_left02">
			<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">契約形態 検索 </span></br>
			<select name="search_kind"  style="font-size:12px;color:#7D7D7D;" >														
			<option name="search_kind" value="0" >::::::: 検索 :::::::</option>			
				<c:if test="${empty listKind}">
					<option  value="0">データなし</option>					
				</c:if>
				<c:if test="${! empty listKind}">
				<c:forEach var="code" items="${listKind}" varStatus="index" >
						<option  value="${code.contract_kind}"  >${code.contract_kind}</option>								
				</c:forEach>
				</c:if>									
			</select>	<input type="submit" class="ccsmal" onfocus="this.blur();" style=cursor:pointer value="検索>>">					
		</div>
	</form>									
</div>		
<form name="search"  action="<%=urlPage%>tokubetu/admin/contract/listForm.jsp" method="post">
	<input type="hidden" name="docontact" id="docontact" >		
	<div class="searchBox_right">	
		<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">		
			<span class="calendar9">契約先 / タイトル / 契約書 検索</span><br>							
			<select name="search_cond"  style="font-size:12px;color:#7D7D7D" onChange="return doEnter('');"  >														
				<option name="" VALUE="0"  >::::::: 検索 :::::::</option>
		<%if(docontact.equals("contact")){%><option name="search_cond" VALUE="contact"   selected  >契約先</option><%}else{%><option name="search_cond" VALUE="contact">契約先</option><%}%>
		<%if(docontact.equals("title")){%><option name="search_cond" VALUE="title"  selected>タイトル</option><%}else{%><option name="search_cond" VALUE="title"  >タイトル</option><%}%>
		<%if(docontact.equals("filename")){%><option name="search_cond" VALUE="filename"  selected>契約書</option><%}else{%><option name="search_cond" VALUE="filename"  >契約書</option><%}%>																						
			</select>
		<%if(docontact.equals("contact")){%>
				<select name="search_key"  style="font-size:12px;color:#7D7D7D;" >														
					<option name="search_key" value="0" >::::::: 検索 :::::::</option>			
						<c:if test="${empty listContact}">
					<option  name="search_key" value="0">データなし</option>					
						</c:if>
						<c:if test="${! empty listContact}">
						<c:forEach var="code" items="${listContact}" varStatus="index" >
					<option  name="search_key" value="${code.contact}"  >${code.contact}</option>								
						</c:forEach>
						</c:if>									
				</select>			
		<%}else{%>		
	    			<input type="TEXT" NAME="search_key" VALUE="" SIZE="25" class="input02" >
	      	<%}%>				
				<input type="submit" class="ccsmal" onfocus="this.blur();" style=cursor:pointer value="検索 >>">												
	</div>	
</form>	
	
	
<div class="clear"></div>	
<div class="searchBoxTwo_left50">				
	<form name="searchKousin"  action="<%=urlPage%>tokubetu/admin/contract/listForm.jsp" method="post">
	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">更新形態 検索</span></br>				
		<select name="search_kousin"  style="font-size:12px;color:#7D7D7D;" >														
			<option name="search_kousin" value="0" >::::::: 検索 :::::::</option>			
				<c:if test="${empty listkousin}">
					<option  value="0">データなし</option>					
				</c:if>
				<c:if test="${! empty listkousin}">
				<c:forEach var="code" items="${listkousin}" varStatus="index" >
						<option  value="${code.renewal}"  >${code.renewal}</option>								
				</c:forEach>
				</c:if>									
		</select>	<input type="submit" class="ccsmal" onfocus="this.blur();" style=cursor:pointer value="検索>>">			
		</form>
</div>					
<div class="searchBoxTwo_right50">	
	<form name="searchDate"   action="<%=urlPage%>tokubetu/admin/contract/listForm.jsp" method="post"  >				
	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">契約終了日 検索</span><br>
		<input type="radio" name="search_radio"  value="ymd"  onfocus="this.blur()" >期間指定: 			
		<input type="text" size="8%" name="sel_bgndate" id="sel_bgndate" value="" style="text-align:center">	~ <input type="text" size="8%" name="sel_enddate" id="sel_enddate" value="" style="text-align:center">
		&nbsp;
		<input type="radio" name="search_radio"  value="dd"  onfocus="this.blur()" ><font color="#009900">一日</font> &nbsp;
		<input type="radio" name="search_radio"  value="ww" onfocus="this.blur()"><font color="#009900">一週</font> &nbsp;
		<input type="radio" name="search_radio"  value="mm" onfocus="this.blur()"><font color="#009900">一ヶ月 </font>&nbsp;
		<input type="radio" name="search_radio"  value="ss" onfocus="this.blur()"><font color="#009900">六ヶ月 </font>&nbsp;
		<input type="radio" name="search_radio"  value="yy" onfocus="this.blur()"><font color="#009900">一年</font>	<input type="submit" class="ccsmal" onfocus="this.blur();" style=cursor:pointer value="検索 >>">
	</form>							
	</div>			
</div><!--searchBox-->
<div class="clear_margin"></div>
<table width="100%" cellpadding="0" cellspacing="0">			
  <tr>      
    <td>    	
    	<font color="#807265">※ 契約書一覧　ダウンロード</font>====>
    		<input type="button" class="cc" onClick="excelExplain();" onfocus="this.blur();" style=cursor:pointer value="方法を見る">
    		<img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle"><input type="button" class="cc" onClick="excelDown();" onfocus="this.blur();" style=cursor:pointer value="ダウンロードをする">
    		<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle"  title="Print"><input type="button" class="cc" onClick="printDown();" onfocus="this.blur();" style=cursor:pointer value="プリントをする">	
    </td>    	
    </tr>    		
</table>			
<!--********search end-->
<table width="98%">		
			<td width="90%" align="left">
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
			<td width="10%" align="right">			
			<font  color="#FF6600">(<%=count%>個)</font></td>	
		</tr>
</table>	

<table width="98%"  cellpadding="0" cellspacing="0" >	 	 	
	<%if(search_cate !=null){%>
		<tr height="25" align="center">
			<td class="line_gray_t_l_r" colspan="14" >
				<span class="calendar16_1">			
					<%Category catedb=mgrCate.getCateParent(Integer.parseInt(search_cate));if(catedb.getBseq()!=0){ %><%=catedb.getName()%>
					<%}%>
				</span>
			</td>					
		</tr>
	<%}%>
	<tr bgcolor="#F1F1F1" align=center height=29>	    	
	    <td width="6%"  class="title_list_all">管理No.</td>	    
	　 <td width="5%"  class="title_list_all">契約形態</td>		    
	    <td  width="11%"  class="title_list_m_r">契約内容</td>
	    <td  width="11%"  class="title_list_m_r">タイトル</td>
	    <td  width="15%"  class="title_list_m_r">契約先</td>
	    <td  width="7%" class="title_list_m_r">契約日</td>
	    <td  width="17%"  class="title_list_m_r">
		<table width=100% 　cellpadding="0" cellspacing="0" >
			<tr bgcolor=#F1F1F1 align=center height=14>	
				<td  align="center" colspan="2" class="line_gray_bottom">契約期間</td>				
			</tr>
			<tr bgcolor=#F1F1F1 align=center height=15>	
				<td class="line_gray_right">開始</td>
				<td >終了</td>
			</tr>		
		</table>	
		</td>    
	    <td  width="6%"  class="title_list_m_r">更新</td>	
	    <td  width="6%" class="title_list_m_r">担当者</td>		   		
		<td  width="7%"  class="title_list_m_r">契約書</td>		
		<td  width="5%" class="title_list_m_r">修正<br>削除</td>		
		<td  width="5%"  class="title_list_m_r">アラート<br>変更</td>				
	</tr>
<c:if test="${empty list}">
				<tr height="25" align="center">
					<td class="line_gray_b_l_r" align>-</td>
					<td class="line_gray_b_l_r" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>							
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>					
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
				</tr>
								
</c:if>
<c:if test="${! empty list}">
<%
int i=1; String conCode=""; int conCodeInt=0; int kubunVal=0;
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		ContractBeen db=(ContractBeen)listiter.next();
		int seq=db.getBseq();
		String aadd=dateFormat.format(db.getRegister());
		int mseqDb=db.getMseq();
		int getLevel=db.getLevel();		
		conCode=db.getKanri_no();       
		kubunVal=db.getKubun_bseq(); 								
		
		if(pageArrowCon==1){	       								
%>								
	 		
	<tr height=25 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	    
	    <td  class="line_gray_b_l_r">
	    	<a class="fileline" href="javascript:goReadCon('<%=seq%>')"  onfocus="this.blur()" title="登録日:<%=aadd%>"><%=conCode%></a>
	      <%if(level_mem==1){%>	
			<a href="javascript:ShowHidden('itemData_block','<%=i%>','title');"  onFocus="this.blur()" title="ダウンロード履歴を見る">
	    		<img src="<%=urlPage%>rms/image/admin/icon_rireki.gif" align="absmiddle" >
	      		</a>				
		<%}%>				      
	    </td>
	    <td class="line_gray_bottomnright">
	    	<%=db.getContract_kind()%>
	    </td>	    	     
	    <td class="line_gray_bottomnright">
	    	<a class="fileline" href="javascript:goReadCon('<%=seq%>')"  onfocus="this.blur()" ><%=db.getContent()%></a>    
	    </td>
	    <td class="line_gray_bottomnright">
	    	<a class="fileline" href="javascript:goReadCon('<%=seq%>')"  onfocus="this.blur()" ><%if(db.getTitle()!=null){%><%=db.getTitle()%><%}else{%>-<%}%></a>
	    </td>
	    <td class="line_gray_bottomnright"><%=db.getContact()%></td>
	    <td  align="center" class="line_gray_bottomnright"><%=db.getHizuke()%></td>
	    <td class="line_gray_bottomnright">
	    		<table width=100% cellpadding="0" cellspacing="0">
			<tr height=24 bgcolor=#F1F1F1 align=center >	
				<td  align="center" class="line_gray_right"><font color="#007AC3"><%=db.getDate_begin()%></font></td>
				<td  align="center" ><%=db.getDate_end()%></td>				
			</tr>			
			</table>	
	    </td>    
	    <td class="line_gray_bottomnright"><%=db.getRenewal()%></td>	
	    <td class="line_gray_bottomnright"><%if(db.getSekining_nm()!=null){%><%=db.getSekining_nm()%><%}else{%>&nbsp;<%}%>  
	    	<!--
	    		<%if(db.getComment()!=null || db.getComment()!=""){%><img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle" title="<%=db.getComment()%>"><%}%>
	    	-->
	    </td>		    
<!--
	    <td  align="center" class="line_gray_bottomnright">
	    	<%if(db.getRenewal_yn()==1){%>
			<font color="#FF6600">[未]</font>
		<%}else if(db.getRenewal_yn()==2){%><font color="#007AC3">[完]</font><%}%>
	   </td>  	    	    
-->
	    <td  class="line_gray_bottomnright">
	    	<%if(db.getFile_nm().equals("")){%>-<%}else{%>			
			<a class="fileline" href="#" onclick="popupSeq('<%=seq%>');"   onfocus="this.blur()"><%=db.getFile_nm()%></a>
			
		<%}%>	 			
	    </td>	    
	    <td align="center" class="line_gray_bottomnright">			
	    		<%if(db.getSekining_mseq()==mseq || id.equals("funakubo") || id.equals("juc0318") || id.equals("admin")){%>
				<a href="javascript:goModify(<%=seq%>)"  onfocus="this.blur()">		
				<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>&nbsp;	
				<a href="javascript:goDelete('<%=conCode%>','<%=seq%>','<%=db.getFile_nm()%>')"  onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>		
			<%}else{%>	
				---			
			<%}%>	    				
	   </td>
	   <td align="center" class="line_gray_bottomnright">	 	
<%if(db.getSekining_mseq()==mseq || id.equals("funakubo") || id.equals("juc0318") || id.equals("admin")){%>		   	   
	   	<%if(db.getRenewal_yn()==1 ){%>			   		   			
				<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value=" ON " onClick="popupOnOff('<%=seq%>');">			
	   	<%}else{%>
	   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF " onClick="popupOnOff('<%=seq%>');"> 
	   	<%}%>		
<%}else{%>	
		<%if(db.getRenewal_yn()==1 ){%>			   		   			
				<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value=" ON "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
	   	<%}else{%>
	   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
	   	<%}%>	
<%}%>	
	   </td>	
	</tr>
	<tr>
		<td  colspan="14" align="center" width="90%">
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#eeeeee;padding:5px 0px 5px 0px;">		
			<table width="60%"  class="tablebox_list"  cellspacing=2 cellpadding=2 bgcolor="#ffffff">				
							<tr height="23" bgcolor=#F1F1F1 align=center>	
							    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >日付</td>
							    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >お名前</td>
							    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >ID</td>
							    <td  class="clear_dot" width="40%"  bgcolor=#F1F1F1 >ipのアドレース</td>							    
							</tr>
					<% listDown=mgrDown.selectDownDtail(seq); %>
					<c:set var="listDown" value="<%= listDown %>" />			
					<c:if test="${empty listDown}">
							<tr><td class="clear_dot" colspan="4">---</td></tr>				
					</c:if>
					<c:if test="${! empty listDown}">
						<c:forEach var="code" items="${listDown}" varStatus="index" >
							<tr>													
								<td class="clear_dot">${code.register}</td>
								<td class="clear_dot">${code.name}</td>
								<td class="clear_dot">${code.title}</td>
								<td class="clear_dot">${code.ip_add}</td>
							</tr>														
						</c:forEach>
					</c:if>				
			</table>						
		</span>
	</td>
</tr>
<%}%>
								
<% if(pageArrowCon==2){%>								
	<% if(kubunVal==1){%>
				<tr height="25" align="center">
					<td class="line_gray_b_l_r" align>-</td>
					<td class="line_gray_b_l_r" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>										
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>					
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
					<td class="line_gray_bottomnright" align>-</td>
				</tr>				
								
	<%}else{%>
		<tr height=25 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	    
	    <td  class="line_gray_b_l_r">
	    	<a class="fileline" href="javascript:goReadCon('<%=seq%>')"  onfocus="this.blur()" title="登録日:<%=aadd%>"><%=conCode%></a>
	      <%if(level_mem==1){%>	
			<a href="javascript:ShowHidden('itemData_block','<%=i%>','title');"  onFocus="this.blur()" title="ダウンロード履歴を見る">
	    		<img src="<%=urlPage%>rms/image/admin/icon_rireki.gif" align="absmiddle" >
	      		</a>				
		<%}%>				      
	    </td>
	    <td class="line_gray_bottomnright">
	    	<%=db.getContract_kind()%>
	    </td>	    	     
	    <td class="line_gray_bottomnright">
	    	<a class="fileline" href="javascript:goReadCon('<%=seq%>')"  onfocus="this.blur()" ><%=db.getContent()%></a>    
	    </td>
	    <td class="line_gray_bottomnright">
	    	<a class="fileline" href="javascript:goReadCon('<%=seq%>')"  onfocus="this.blur()" ><%if(db.getTitle()!=null){%><%=db.getTitle()%><%}else{%>-<%}%></a>
	    </td>
	    <td class="line_gray_bottomnright"><%=db.getContact()%></td>
	    <td  align="center" class="line_gray_bottomnright"><%=db.getHizuke()%></td>
	    <td class="line_gray_bottomnright">
	    		<table width=100% cellpadding="0" cellspacing="0">
			<tr height=24 bgcolor=#F1F1F1 align=center >	
				<td  align="center" class="line_gray_right"><font color="#007AC3"><%=db.getDate_begin()%></font></td>
				<td  align="center" ><%=db.getDate_end()%></td>				
			</tr>			
			</table>	
	    </td>    
	    <td class="line_gray_bottomnright"><%=db.getRenewal()%></td>	
	    <td class="line_gray_bottomnright"><%if(db.getSekining_nm()!=null){%><%=db.getSekining_nm()%><%}else{%>&nbsp;<%}%>  
	    	<!--
	    		<%if(db.getComment()!=null || db.getComment()!=""){%><img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="absmiddle" title="<%=db.getComment()%>"><%}%>
	    	-->
	    </td>		    	    	    	    
	    <td  class="line_gray_bottomnright">
	    	<%if(db.getFile_nm().equals("")){%>-<%}else{%>			
			<a class="fileline" href="#" onclick="popupSeq('<%=seq%>');"   onfocus="this.blur()"><%=db.getFile_nm()%></a>
			
		<%}%>	 			
	    </td>	    
	    <td align="center" class="line_gray_bottomnright">			
	    		<%if(db.getSekining_mseq()==mseq || id.equals("funakubo") || id.equals("juc0318") || id.equals("admin")){%>
				<a href="javascript:goModify(<%=seq%>)"  onfocus="this.blur()">		
				<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>&nbsp;	
				<a href="javascript:goDelete('<%=conCode%>','<%=seq%>','<%=db.getFile_nm()%>')"  onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>		
			<%}else{%>	
				---			
			<%}%>	    				
	   </td>
	  <td align="center" class="line_gray_bottomnright">	 	
<%if(db.getSekining_mseq()==mseq || id.equals("funakubo") || id.equals("juc0318") || id.equals("admin")){%>		   	   
	   	<%if(db.getRenewal_yn()==1 ){%>			   		   			
				<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value=" ON " onClick="popupOnOff('<%=seq%>');">			
	   	<%}else{%>
	   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF " onClick="popupOnOff('<%=seq%>');"> 
	   	<%}%>		
<%}else{%>	
		<%if(db.getRenewal_yn()==1 ){%>			   		   			
				<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value=" ON "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
	   	<%}else{%>
	   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
	   	<%}%>	
<%}%>	
	   </td>	
	</tr>
	<tr>
		<td  colspan="14" align="center" width="90%">
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#eeeeee;padding:5px 0px 5px 0px;">		
			<table width="60%"  class="tablebox_list"  cellspacing=2 cellpadding=2 bgcolor="#ffffff">				
							<tr height="23" bgcolor=#F1F1F1 align=center>	
							    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >日付</td>
							    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >お名前</td>
							    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >ID</td>
							    <td  class="clear_dot" width="40%"  bgcolor=#F1F1F1 >ipのアドレース</td>							    
							</tr>
					<% listDown=mgrDown.selectDownDtail(seq); %>
					<c:set var="listDown" value="<%= listDown %>" />			
					<c:if test="${empty listDown}">
							<tr><td class="clear_dot" colspan="4">---</td></tr>				
					</c:if>
					<c:if test="${! empty listDown}">
						<c:forEach var="code" items="${listDown}" varStatus="index" >
							<tr>													
								<td class="clear_dot">${code.register}</td>
								<td class="clear_dot">${code.name}</td>
								<td class="clear_dot">${code.title}</td>
								<td class="clear_dot">${code.ip_add}</td>
							</tr>														
						</c:forEach>
					</c:if>				
			</table>						
		</span>
	</td>
</tr>							
		
	<%}%>
<%}%>											
								
								
								
								
<%
i++;	
}
%>				
</c:if>
</form>
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
    
    <c:if test="<%= searchCate %>">
    	<input type="hidden" name="search_cate" value="<%=search_cate%>">
    </c:if>
    <c:if test="<%= searchKousin %>">
    	<input type="hidden" name="search_kousin" value="<%=search_kousin%>">
    </c:if>
    <c:if test="<%= searchKind %>">
    	<input type="hidden" name="search_kind" value="<%=search_kind%>">
    </c:if>    	
    	
    <c:if test="<%= searchCondFilename %>">
    <input type="hidden" name="search_cond" value="filename">
    </c:if>
    <c:if test="<%= searchCondTitle %>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>
    <c:if test="<%= searchCondContact %>">
    <input type="hidden" name="search_cond" value="contact">
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
    	<input type="hidden" name="renewal_yn" value="">     
    	<input type="hidden" name="mseq" value="">     
    	<input type="hidden" name="pgkind" value="">     
    	<input type="hidden" name="pass" value="">    
</form>			
<!-- 팝업 start-->				
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->					 
</div>	
<div class="clear_margin"></div>	<div class="clear_margin"></div>	

<script language="JavaScript">
function goPage(pageNo) {    
    	document.move.page.value = pageNo;
	document.move.action = "<%=urlPage%>tokubetu/admin/contract/listForm.jsp";
    	document.move.submit();
}
function goDelete(code,seq,filename) {
	if(confirm(code+"のデータを削除しますか?")!=1){return;}
	document.move.action = "<%=urlPage%>tokubetu/admin/contract/delete.jsp";
	document.move.seq.value = seq;	
	document.move.filename.value = filename;
    	document.move.submit();
}
function goModify(seq) {		
    	document.move.action = "<%=urlPage%>tokubetu/admin/contract/updateForm.jsp";
	document.move.seq.value=seq;
	document.move.read.value="update";		
    	document.move.submit();
}
function goDown(seq,filename) {		
//	var passValue=document.getElementById("passValue_"+seq).value;
	document.move.action = "<%=urlPage%>tokubetu/admin/contract/down.jsp";
	document.move.seq.value = seq;	
	document.move.filename.value = filename;
//	document.move.pass.value = passValue; 
	document.move.submit();
}
function excelDown(){		
	document.move.action = "<%=urlPage%>tokubetu/admin/contract/listExcel.jsp";	
    	document.move.submit();    	
}
function excelExplain(){		
	openNoScrollWin("<%=urlPage%>tokubetu/admin/contract/excelDown_pop.jsp", "契約書", "契約書", "760", "525","");
}
function printDown(){			
	openScrollWin("<%=urlPage%>tokubetu/admin/contract/print_pop.jsp", "契約書", "契約書", "760", "700","");	
}
function goReadCon(seq) {		
    	document.move.action = "<%=urlPage%>tokubetu/admin/contract/updateForm.jsp";
	document.move.seq.value=seq;		
	document.move.read.value="read";		
    	document.move.submit();
}
function popupSeq(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>tokubetu/admin/contract/popup_downView.jsp?seq="+seq; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
function popupOnOff(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;		
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>tokubetu/admin/contract/popup_OnOff.jsp?seq="+seq+"&mseq=<%=mseq%>&pgkind=list"; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
/*
function goKakuninn(seq) {	
	if(confirm("処理しますか？")!=1){return;}
    	document.move.action = "<%=urlPage%>tokubetu/admin/contract/dateView.jsp";
	document.move.seq.value=seq;	
	document.move.renewal_yn.value="2";		
	document.move.mseq.value="<%=mseq%>";	
	document.move.pgkind.value="list";		
    	document.move.submit();    	
}
*/
function doEnter(){
	var frm=document.search;
	frm.docontact.value=frm.search_cond.value;	
	frm.search_key.value=frm.search_key.value;	
	frm.action = "<%=urlPage%>tokubetu/admin/contract/listForm.jsp";	
	frm.submit();
}
</script>

		
	
