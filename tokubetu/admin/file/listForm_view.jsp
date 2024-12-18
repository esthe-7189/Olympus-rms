<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.tokubetu.AccBean" %>
<%@ page import="mira.tokubetu.AccMgr" %>
<%@ page import="mira.tokubetu.AccDownMgr" %>
<%@ page import="mira.tokubetu.CateMgr" %>
<%@ page import = "mira.tokubetu.Category" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>  
<%! 
static int PAGE_SIZE=10; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String kind=(String)session.getAttribute("KIND");
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
if(id==null){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(kind!=null && ! kind.equals("toku") ){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
    	
	int level_mem=0;
	MemberManager managermem=MemberManager.getInstance();
	Member member=managermem.getMember(id);
	if(member!=null){
		level_mem=member.getLevel();
	}

		Calendar calen=Calendar.getInstance();
		Date trialTime=calen.getTime();
		String ddate=dateFormat.format(trialTime);		
		String sdate="";	String	wdate="";String mdate="";String sixmdate="";String yeardate="";	
		
		Calendar cal=new GregorianCalendar();
		cal.setTime(trialTime);
		cal.add(cal.DATE,+1);	Date curTime=cal.getTime();sdate=dateFormat.format(curTime);
		cal.add(cal.DATE,-7);	Date curTime7=cal.getTime();wdate=dateFormat.format(curTime7);
		
		Calendar cal2=new GregorianCalendar();
		cal2.setTime(trialTime);
		cal2.add(cal2.MONTH,-1);	Date curTime30=cal2.getTime();mdate=dateFormat.format(curTime30);
		cal2.add(cal2.MONTH,-5);	Date curTime6=cal2.getTime();sixmdate=dateFormat.format(curTime6);
		
		Calendar cal3=new GregorianCalendar();
		cal3.setTime(trialTime);
		cal3.add(cal3.YEAR,-1);	Date curTime12=cal3.getTime();yeardate=dateFormat.format(curTime12);
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
	
	List whereCond = null;
	Map whereValue = null;

	boolean searchCondFilename = false; boolean searchCondTitle = false; boolean searchCondOrderseq = false;boolean searchCondDD = false;boolean searchCondWW = false;
	boolean searchCondMM = false; boolean searchCondSS = false; boolean searchCondYY = false;	
	boolean searchCondYMD = false; boolean searchCate=false;

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("filename")){
				whereCond.add(" a.filename  LIKE '%"+searchKey+"%'");				
				searchCondFilename=true;
			}else if (searchCond[i].equals("title")){
				whereCond.add(" a.title LIKE '%"+searchKey+"%'");
				searchCondTitle = true;
			}			
		}
	}else if (searchRadio !=null && searchRadio.length>0 ){
		for (int y=0;y<searchRadio.length ;y++ ){
			if (searchRadio[y].equals("dd")){
				whereCond.add(" register LIKE '"+ddate+"%' ");				
				searchCondDD=true;
			}else if (searchRadio[y].equals("ww")){
				whereCond.add(" register BETWEEN '"+wdate+"' and '"+sdate+"' ");				
				searchCondWW=true;			
			}else if (searchRadio[y].equals("mm"))	{
				whereCond.add(" register BETWEEN '"+mdate+"' and '"+sdate+"' ");					
				searchCondMM=true;
			}else if (searchRadio[y].equals("ss")){
				whereCond.add(" register BETWEEN '"+sixmdate+"' and '"+sdate+"' ");					
				searchCondSS=true;
			}else if (searchRadio[y].equals("yy")){
				whereCond.add(" register BETWEEN '"+yeardate+"' and '"+sdate+"' ");					
				searchCondYY=true;		
			}else if (searchRadio[y].equals("ymd")){				
				whereCond.add(" register BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"' ");					
				searchCondYMD=true;
			}

		}
	}
	if(search_cate !=null){				
		whereCond.add(" a.cate_seq="+search_cate);
		searchCate=true;
	}

	AccMgr manager = AccMgr.getInstance();	
	AccDownMgr manager2 = AccDownMgr.getInstance();	
	
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
	List  listDown;
	
	CateMgr managerCate = CateMgr.getInstance();	  	
	List  listCate=managerCate.selectListAdminLevel(0,1);
%>

<c:set var="list" value="<%= list %>" />	
<c:set var="listCate" value="<%= listCate %>" />	

<script language="javascript">
function ShowHidden(MenuName, ShowMenuID,kind){
	var menu="";
	for ( i = 1; i <= 30;  i++ ){
		if(kind=="title"){
			menu= eval("document.all.itemData_block" + i + ".style");	
		}else if(kind=="file"){
			menu= eval("document.all.fileData_block" + i + ".style");
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
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">決裁書/契約書文書ファイル管理 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">		
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/file/listForm.jsp'">			
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/file/cateAddForm.jsp'">
</div>
<div id="boxNoLineBig"  >
	<!---------------search begin------------------>	
<div id="searchBox">	
		<form name="search"  action="<%=urlPage%>tokubetu/admin/file/listForm.jsp" method="post">		
			<div class="searchBox_left50">		
			<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">タイトル / ファイル名検索</span></br>				
				<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
					<option name="" VALUE=""  >::::::::::::: 検索 :::::::::::::</option>
					<option name="search_cond" VALUE="filename"  >ファイル名</option>
					<option name="search_cond" VALUE="title"  >ファイルのタイトル</option>				
				</select>
				<input type="TEXT" NAME="search_key" VALUE="" SIZE="20" class="logbox" >
				<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">						
			</div>	
		</form>		
		
		<form name="searchCate"  action="<%=urlPage%>tokubetu/admin/file/listForm.jsp" method="post">			
		<div class="searchBox_right50">
				<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">文書区分検索</span></br>
				<select name="search_cate"  style="font-size:12px;color:#7D7D7D">														
						<option name="search_cate" value="0" >:::::::::::::::: 検索 ::::::::::::::::</option>
					<c:if test="${empty listCate}">				
			    			<option name="search_cate" value="0">no data!!</option>			    		
					</c:if>				
					<c:if test="${! empty listCate}">
					<%
					int i=1; 
					Iterator listiter=listCate.iterator();
						while (listiter.hasNext()){				
							Category cate=(Category)listiter.next();
							int bseq=cate.getBseq();					
					%>	  
						<option name="search_cate" value="<%=bseq%>"><%=cate.getName()%></option>
					<%
					i++;
					}												  													  
					%>	
					</c:if>												
						</select>							
						<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">						
		</div>
		</form>									

<div class="clear_margin"></div>
<div class="searchBox_all">		
	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">期間別検索</span>	
		<table  border="0" cellpadding="0" cellspacing="0" width="100%" >				
			<form name="searchDate"   action="<%=urlPage%>tokubetu/admin/file/listForm.jsp" method="post"  >
				<tr>
					<td colspan="2" style="padding: 3 0 3 3">
						<img src="<%=urlPage%>rms/image/icon_ball.gif" >
検索方法　: <font color="#807265">①丸をチェック</font> --> <font color="#807265">②内容を選択</font> --> <font color="#807265">③検索ボタンをクリックする</font>&nbsp;&nbsp;
<font color="#807265">(<font color="#009900">一日</font>から<font color="#009900">一年間</font>までは丸をチェックし、検索ボタンをクリックする)</font>
					</td>
				</tr>
				<tr>
					<td width="85%" style="padding: 2 0 2 2">		
							<input type="radio" name="search_radio"  value="ymd"  onfocus="this.blur()" >期間指定: 			
<input type="text" size="13%" name='sel_bgndate' class=calendar value="" style="text-align:center"> ~ <input type="text" size="13%" name='sel_enddate' class=calendar value="" style="text-align:center">
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
<div class="clear_margin"></div>
<table width="960" cellpadding="0" cellspacing="0">		
<tr>
    <td colspan="2">
    	<%if(level_mem==1){%>
   					<font color="#807265">※タイトルをクリックすると下にダウンロードされた詳しい内容が見えます。</font>      
      <%}%>
      	 <br>
      	 			<font color="#807265">※ファイル名をクリックし、パスワードを入力するとダウンロードができます。</font>
      	 <br>
      	 			<font color="#807265">※<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle">はファイルをアップロードした方からのお知らせです。</font>
    </td>     
  </tr>
   <tr>      
    <td style="padding: 0px 0px 2px 0px">    	
    	<font color="#807265">※ 特別文書一覧　ダウンロード</font>====>
    		<input type="button" class="cc" onClick="excelExplain();" onfocus="this.blur();" style=cursor:pointer value="方法を見る">
    		<img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle"><input type="button" class="cc" onClick="excelDown();" onfocus="this.blur();" style=cursor:pointer value="ダウンロードをする">
    		<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle"  title="Print"><input type="button" class="cc" onClick="printDown();" onfocus="this.blur();" style=cursor:pointer value="プリントをする">	
    </td>   		     		 
    <td align="right">
	    <c:if test="<%= count > 0 %>">
	        total:<font color="#CC6600"><%= count %></font>個
	    </c:if>
    </td>
</tr>
</table>
			 
<table width="98%"  cellpadding="3" cellspacing="0" >
<form name="frm" > 
<tr bgcolor=#F1F1F1 align=center height=26>	
    <td  align="center" width="8%" class="title_list_all">日付</td>
    <td  align="center" width="12%" class="title_list_m_r">文書区分</td>
    <td  align="center" width="33%" class="title_list_m_r">タイトル</td>
    <!--<td  align="center" width="21%" class="title_list_m_r">タイトル</td>
    <td  align="center" width="12%" class="title_list_m_r">担当者</td> -->           
    <td  align="center" width="20%" class="title_list_m_r">ファイル名</td>
    <td  align="center" width="12%" class="title_list_m_r">コメント</td>
    <td  align="center" width="5%" class="title_list_m_r">展示</td>
    <td  align="center" width="5%" class="title_list_m_r">修正</td>	
    <td  align="center" width="5%" class="title_list_m_r">削除</td>
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="7">--</td>
	</tr>
</c:if>
				
<c:if test="${! empty list}">	
<%
	int i=1;			
%>
		
	<%
		Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			AccBean pdb=(AccBean)listiter.next();
			int seq=pdb.getSeq();														
			if(seq!=0){	
				String aadd=dateFormat.format(pdb.getRegister());											
	%>
	
<tr height=23 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td class="line_gray_b_l_r" align="center"><%=aadd%></td>
	<td class="line_gray_bottomnright"><%=pdb.getCate_nm()%></td>	
	<td class="line_gray_bottomnright">
	<%if(level_mem==1){%>	
		<a href="javascript:ShowHidden('itemData_block','<%=i%>','title');"  onFocus="this.blur()">
		<font color="#CC6600"><%=pdb.getTitle()%></font>
		</a> 		
	<%}else{%>
		<%=pdb.getTitle()%>
	<%}%>
	</td>	
	<!--<td class="line_gray_bottomnright"><%=pdb.getSekining_nm()%> </td>	-->
<%if(pdb.getView_yn()==0){%>	
	<td class="line_gray_bottomnright">  
	<!--<a class="fileline" href="#" onclick="popupSeq('<%=seq%>');"   onfocus="this.blur()"><%=pdb.getFilename()%></a>-->
	<a class="fileline" href="#" onclick="goDownFile('<%=seq%>');"   onfocus="this.blur()"><%=pdb.getFilename()%></a>
	</td>
<%}else{%>
	<td class="line_gray_bottomnright"><img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"></td>
<%}%>		
	<td class="line_gray_bottomnright"><%=pdb.getComment()%></td>
	<td class="line_gray_bottomnright" align="center">
		<%if(pdb.getView_yn()==0){%>		
			YES
		<%}else{%>
			<font color="#0066FF">NO</font>
		<%}%>
				
	</td>										
	<td class="line_gray_bottomnright" align="center">
		<a href="javascript:goModify(<%=seq%>)"  onfocus="this.blur()">		
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>
	</td>
	<td class="line_gray_bottomnright" align="center">
		<a href="javascript:goDelete(<%=seq%>)"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
	</td>		
		
</tr>
<tr>
	<td  colspan="7" align="center" width="90%">			
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#eeeeee;padding:5px 0px 5px 0px;">		
			<table width="60%"  class="tablebox_list"  cellspacing=2 cellpadding=2 bgcolor="#ffffff">				
							<tr bgcolor=#F1F1F1 align=center>	
							    <td class="clear_dot" width="20%" style="padding: 2 5 2 5" bgcolor=#F1F1F1 >日付</td>
							    <td class="clear_dot" width="20%" style="padding: 2 5 2 5" bgcolor=#F1F1F1 >お名前</td>
							    <td class="clear_dot" width="20%" style="padding: 2 5 2 5" bgcolor=#F1F1F1 >ID</td>
							    <td  class="clear_dot" width="40%" style="padding: 2 5 2 5" bgcolor=#F1F1F1 >ipのアドレース</td>							    
							</tr>

<%
	int i2=1;			
%>
<% listDown=manager2.selectDownDtail(seq); %>
<c:set var="listDown" value="<%= listDown %>" />	
<%
		Iterator listiter2=listDown.iterator();					
				while (listiter2.hasNext()){
					AccBean pdb2=(AccBean)listiter2.next();
					int seq2=pdb2.getSeq();											
					if(seq2!=0){	
						String aadd2=dateFormat.format(pdb2.getRegister());														
	%>
							<tr>													
								<td class="clear_dot"><%=aadd2%></td>
								<td class="clear_dot"><%=pdb2.getName()%></td>
								<td class="clear_dot"><%=pdb2.getTitle()%></td>
								<td class="clear_dot"><%=pdb2.getIp_add()%></td>
							</tr>
<%}else{%>
							<tr>													
								<td class="clear_dot" style="padding: 2px 5px 2px 5px;" colspan="4">NO DATA</td>
								
							</tr>
<%}
i2++;	
}
%>			
													
						</table>						
		</span>
	</td>
</tr>
<%}
i++;	
}
%>		
</c:if>
</table><p>
</form>	
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
<!-- 팝업 start-->				
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->	
</div>	
<form name="move" method="post">
    <input type="hidden" name="seq" value="">    
    <input type="hidden" name="filename" value="">     
    <input type="hidden" name="pass" value="">     
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

    <c:if test="${! empty param.search_cate}">
    <input type="hidden" name="search_cate" value="${param.search_cate}">
    </c:if>
	<c:if test="<%= searchCondYMD %>">
    <input type="hidden" name="search_radio" value="ymd">
    <input type="hidden" name="sel_bgndate" value="<%=sel_bgndate%>">
    <input type="hidden" name="sel_enddate" value="<%=sel_enddate%>">
    </c:if>   
    <c:if test="<%= searchCondOrderseq %>">
    	<input type="hidden" name="search_radio" value="seq">
    </c:if>
</form>
<script language="JavaScript">
function goPage(pageNo) {    
    	document.move.page.value = pageNo;
	document.move.action = "<%=urlPage%>tokubetu/admin/file/listForm.jsp";
    	document.move.submit();
}
function goDelete(seq) {
	document.move.action = "<%=urlPage%>tokubetu/admin/file/delForm.jsp";
	document.move.seq.value=seq;	
    	document.move.submit();
}
function goModify(seq) {	
    	document.move.action = "<%=urlPage%>tokubetu/admin/file/modifyForm.jsp";
	document.move.seq.value=seq;	
    	document.move.submit();
}
//패스워드 검증후 파일 다운로드
function popupSeq(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>tokubetu/admin/file/popup_downView.jsp?seq="+seq; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
//바로 파일다운로드
function goDownFile(seq) {		
	document.move.action = "<%=urlPage%>tokubetu/admin/file/down.jsp";
	document.move.seq.value = seq;	
//	document.move.filename.value = filename;
	document.move.submit();
	
}

function excelDown(){		
	document.move.action = "<%=urlPage%>tokubetu/admin/file/listExcel.jsp";	
    	document.move.submit();    	
}
function excelExplain(){		
	openNoScrollWin("<%=urlPage%>tokubetu/admin/file/excelDown_pop.jsp", "特別文書", "特別文書", "760", "525","");
}
function printDown(){			
	openScrollWin("<%=urlPage%>tokubetu/admin/file/print_pop.jsp", "特別文書", "特別文書", "760", "700","");	
}
/*
function goDown(seq,filename) {	
	var passValue=eval("document.frm.passVal_"+seq+".value");  		
	document.move.action = "<%=urlPage%>tokubetu/admin/file/down.jsp";
	document.move.seq.value = seq;
	document.move.pass.value = passValue; 
	document.move.filename.value = filename;
	document.move.submit();
}
*/
</script>
