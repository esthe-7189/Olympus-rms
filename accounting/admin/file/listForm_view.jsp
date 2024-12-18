<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.acc.AccBean" %>
<%@ page import="mira.acc.AccMgr" %>
<%@ page import="mira.acc.AccDownMgr" %>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
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
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("acc")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
    	String urlPage=request.getContextPath()+"/";
	String id=(String)session.getAttribute("ID");

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
	
	
	List whereCond = null;
	Map whereValue = null;

	boolean searchCondFilename = false; boolean searchCondTitle = false; boolean searchCondOrderseq = false;boolean searchCondDD = false;boolean searchCondWW = false;
	boolean searchCondMM = false; boolean searchCondSS = false; boolean searchCondYY = false;	
	boolean searchCondYMD = false; 

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("filename")){
				whereCond.add(" filename  LIKE '%"+searchKey+"%'");				
				searchCondFilename=true;
			}else if (searchCond[i].equals("title")){
				whereCond.add("title '%"+searchKey+"%'");
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
	
%>

<c:set var="list" value="<%= list %>" />	

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

	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">経理・会計文書システム </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録 >>" onClick="location.href='<%=urlPage%>accounting/admin/file/uploadForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録 >>" onClick="location.href='<%=urlPage%>accounting/admin/file/listForm.jsp'">		
</div>
<div id="boxNoLineBig"  >
	<div id="searchBox">				
		<div class="searchBox_all">	
		<table  border="0" cellpadding="5" cellspacing="5" width="95%" >		
			<form name="searchDate"   action="<%=urlPage%>accounting/admin/file/listForm.jsp" method="post"  >
				<tr>
					<td colspan="2" style="padding: 2 0 2 0">
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
							<input type="image" style=cursor:pointer  src="<%=urlPage%>rms/image/admin/btn_jp_search.gif" onfocus="this.blur()" align="absmiddle" >
					</td>
				</tr>				
					</form>									
		</table>							
	</div><!--searchBox_all-->	
</div>																							
<div class="clear_margin"></div>
 <table width="960">
 	<form name="search"  action="<%=urlPage%>accounting/admin/file/listForm.jsp" method="post">				
	<tr>
		<td width="50%" align="left">
				<font  color="#FF6600">(<%=count%>個)</font>
	<%if(level_mem==1){%>
   				<font color="#807265">※タイトルをクリックすると下に詳しい内容が見えます。</font>      
      <%}%>
      	 <br>
      	 			<font color="#807265">※ファイル名をクリックし、パスワードを入力するとダウンロードができます。</font>
      	 <br>
      	 			<font color="#807265">※<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle">はファイルをアップロードした方からのお知らせです。</font> 				
			</td>
			<td width="50%" align="right">	
			<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
				<option name="" VALUE=""  >検索(選択!)</option>
				<option name="search_cond" VALUE="filename"  >ファイル名</option>
				<option name="search_cond" VALUE="title"  >ファイルのタイトル</option>				
			</select>
				<input type="TEXT" NAME="search_key" VALUE="" SIZE="20" class="logbox" >
				<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索">
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体リスト" onClick="location.href='<%=urlPage%>accounting/admin/file/listForm.jsp'">
		</td>			
	</tr>
	</form>					 		
</table>	


<table width="960" border=0 cellpadding="0" cellspacing="0" bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
<form name="frm" > 
<tr bgcolor=#F1F1F1 align=center height=26>	
    <td  align="center" width="10%" class="title_list_all">日付</td>
    <td  align="center" width="20%" class="title_list_m_r">タイトル</td>
    <td  align="center" width="10%" class="title_list_m_r">お名前</td>
    <td  align="center" width="45%" class="title_list_m_r">ファイル名</td>
    <td  align="center" width="5%" class="title_list_m_r">展示可否</td>
    <td  align="center" width="5%" class="title_list_m_r">修正</td>	
    <td  align="center" width="5%" class="title_list_m_r">削除</td>
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="7">NO DATA</td>
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
	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" height="22">
	<td width="10%" align="center" class="line_gray_b_l_r" ><%=aadd%></td>	
	<td width="20%" class="line_gray_bottomnright">
	<%if(level_mem==1){%>	
		<a href="javascript:ShowHidden('itemData_block','<%=i%>','title');"  onFocus="this.blur()">
		<font color="#CC6600"><%=pdb.getTitle()%></font>
		</a> 		
	<%}else{%>
		<%=pdb.getTitle()%>
	<%}%>
	</td>
	<td width="10%" class="line_gray_bottomnright"><%=pdb.getName()%>						 
		<%if(!pdb.getComment().equals("...")  ){%>					
			 	<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle" alt="<%=pdb.getComment()%>" title="<%=pdb.getComment()%>">		
		<%}%>
			 	
	</td>
<%if(pdb.getView_yn()==0){%>	
	<td width="45%"  class="line_gray_bottomnright" >
		<a href="javascript:goDownDirect('<%=seq%>');"  onFocus="this.blur()"><%=pdb.getFilename()%></a>
		<!--
		<a href="javascript:ShowHidden('fileData_block','<%=i%>','file');"  onFocus="this.blur()">										
			<%=pdb.getFilename()%></a>-->
	</td>			
<%}else{%>
	<td width="45%" class="line_gray_bottomnright"><img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"></td>
<%}%>		
	
	<td width="5%" align="center" class="line_gray_bottomnright">
		<%if(pdb.getView_yn()==0){%>		
			YES
		<%}else{%>
			<font color="#0066FF">NO</font>
		<%}%>
				
	</td>										
	<td width="5%" align="center" class="line_gray_bottomnright">
		<a href="javascript:goModify(<%=seq%>)"  onfocus="this.blur()">		
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>
	</td>
	<td width="5%" align="center" class="line_gray_bottomnright">
		<a href="javascript:goDelete(<%=seq%>)"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
	</td>		
		
</tr>
<tr>
	<td  style="padding: 5 5 5 5" colspan="7" align="center" width="90%">
	<!--	<span id="fileData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#eeeeee;padding:5px 0px 5px 0px;">		
			<table border="0" width="280" class="tablebox_list"  cellspacing=5 cellpadding=5  bgcolor="#ffffff">	
			     	<tr>
				     	<td width="90%">
						<img src="<%=urlPage%>orms/images/common/title_board_passLayer.gif" >						
					</td>
					<td width="10%">						
						<a href="javascript:ShowHidden('fileData_block','<%=i%>','file');"  onFocus="this.blur()">(X)</a>
					</td>				     	
				</tr> 
				<tr>
		                 	<td align="left" colspan="2">
		        		<img src="<%=urlPage%>orms/images/common/icon_ball.gif"align="asbmiddle" > password :　
		        		<input type="password" name="passVal_<%=seq%>" value="" size="20" class="input02" style="width:110px;ime-mode:disabled">
					<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 確認 " onClick="goDown('<%=seq%>','<%=pdb.getFilename()%>');">		        			
		        		</td>		            	
		            </tr>		              
		     </table>		
    		</span>-->
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#eeeeee;padding:5px 0px 5px 0px;">		
			<table width="60%"  class="tablebox_list"  cellspacing=2 cellpadding=2 bgcolor="#ffffff">								
							<tr bgcolor=#F1F1F1 align=center>	
							    <td  class="clear_dot" width="20%" >日付</td>
							    <td  class="clear_dot" width="20%"  >お名前</td>
							    <td  class="clear_dot" width="20%" >ID</td>
							    <td  class="clear_dot" width="40%"  >ipのアドレース</td>							    
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
								<td class="clear_dot"  colspan="4">NO DATA</td>
								
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
	document.move.action = "<%=urlPage%>accounting/admin/file/listForm.jsp";
    	document.move.submit();
}
function goDelete(seq) {
	document.move.action = "<%=urlPage%>accounting/admin/file/delForm.jsp";
	document.move.seq.value=seq;	
    	document.move.submit();
}
function goModify(seq) {	
    	document.move.action = "<%=urlPage%>accounting/admin/file/modifyForm.jsp";
	document.move.seq.value=seq;	
    	document.move.submit();
}

function goDown(seq,filename) {	
	var passValue=eval("document.frm.passVal_"+seq+".value");  		
	document.move.action = "<%=urlPage%>accounting/admin/file/down02.jsp";
	document.move.seq.value = seq;
	document.move.pass.value = passValue; 
	document.move.filename.value = filename;
	document.move.submit();
}
//바로 파일다운로드
function goDownDirect(seq) {		
	document.move.action = "<%=urlPage%>accounting/admin/file/down.jsp";
	document.move.seq.value = seq;	
	document.move.submit();
	
}
</script>
