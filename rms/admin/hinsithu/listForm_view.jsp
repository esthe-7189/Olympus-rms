<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.hinsithu.HinsithuBean" %>
<%@ page import="mira.hinsithu.HinsithuMgr" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CommentMgr" %>
<%@ page import = "mira.hinsithu.CateMgr" %>

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
String id=(String)session.getAttribute("ID");
if(id.equals("candy") || id.equals("ohtagaki") || id.equals("kishi") || id.equals("togashi")){
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
    String urlPage=request.getContextPath()+"/";


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
	
	
	String orStatus=request.getParameter("orStatus");
	
	List whereCond = null;
	Map whereValue = null;

	boolean searchCondPcode = false; boolean searchCondPname = false; boolean searchCondOrderseq = false;boolean searchCondDD = false;boolean searchCondWW = false;
	boolean searchCondMM = false; boolean searchCondSS = false; boolean searchCondYY = false;	
	boolean searchCondStatus = false; boolean searchCondYMD = false; 

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("pcode")){
				whereCond.add(" filename  LIKE '%"+searchKey+"%'");				
				searchCondPcode=true;
			}else if (searchCond[i].equals("pname")){
				whereCond.add(" f_title LIKE '%"+searchKey+"%'");
				searchCondPname = true;			
			}else if (searchCond[i].equals("seq")){
				whereCond.add(" fno=? ");
				whereValue.put(new Integer(1),searchKey);
				searchCondOrderseq = true;
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
			}else if (searchRadio[y].equals("ymdStatus")){
				whereCond.add(" cate_code='"+orStatus+"' ");
				searchCondStatus=true;
			}else if (searchRadio[y].equals("ymd")){				
				whereCond.add(" register BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"' ");					
				searchCondYMD=true;
			}

		}
	}
	HinsithuMgr manager = HinsithuMgr.getInstance();	
	CateMgr manager2 = CateMgr.getInstance();	
	CommentMgr manaCom = CommentMgr.getInstance();	
				
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
	List  listCate=manager2.selectListAdminLevel(0,1);
%>

<c:set var="list" value="<%= list %>" />	
<c:set var="listCate" value="<%= listCate %>" />		

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
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#sel_bgndate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
$(function() {
   $("#sel_enddate").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });
    
</script>			
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">品質試験書QA </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/bunshoUploadForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="マニュアル" onClick="location.href='<%=urlPage%>rms/admin/file/bun_down.jsp?filename=orms20090223admin.ppt'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="データ出力(Excel)" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/excelList_view.jsp'">		
</div>
<div id="boxNoLineBig"  >
	<div id="searchBox">				
		<div class="searchBox_all">	
		<table  border="0" cellpadding="5" cellspacing="5" width="95%" >
			<form name="searchDate"   action="<%=urlPage%>rms/admin/hinsithu/listForm.jsp" method="post"  >
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
				<tr>
					<td style="padding: 2 0 2 0"　valign="middle">						
						<input type="radio" name="search_radio"  value="ymdStatus"  onfocus="this.blur()" >大項目: 	
						  <select name="orStatus" class="select_type3" >
					            				<c:if test="${empty listCate}">				
													    	<option value="0">No Data</option>			    		
										</c:if>													
										<c:if test="${! empty listCate}">
										<%
										int iCate=1;
										Iterator listiterCate=listCate.iterator();
											while (listiterCate.hasNext()){				
												Category cateCode=(Category)listiterCate.next();											
										%>	  
												<option value="<%=cateCode.getBseq()%>"><%=cateCode.getName()%></option>
										<%
										iCate++;
										}												  													  
										%>	
										</c:if>						
						  </select>		       																					
						</td>						
					</tr>
				</form>									
		</table>							
	</div><!--searchBox_all-->	
</div>																							
<div class="clear_margin"></div>
 <table width="960">
 	 <form name="search"  action="<%=urlPage%>rms/admin/hinsithu/listForm.jsp" method="post">	
		<tr>
			<td width="50%" align="left">
				※<img src="<%=urlPage%>rms/image/admin/btn_jp_mi.gif" align="absmiddle" alt="次の段階へ" title="次の段階へ">をクリックし、次のファイルをアップロードして下さい。				
			</td>
			<td width="50%" align="right">	
				<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
					<option name="" VALUE=""  >検索(選択!)</option>
					<option name="search_cond" VALUE="pcode"  >ファイル名</option>
					<option name="search_cond" VALUE="pname"  >ファイルのタイトル</option>									
					<option name="search_cond" VALUE="seq"  >ファイル番号</option>					
				</select>
				<input type="TEXT" NAME="search_key" VALUE="" SIZE="20" class="input02" >
				<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索">
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体リスト" onClick="location.href='<%=urlPage%>rms/admin/hinsithu/listForm.jsp'">
			</td>
		</tr>
	</form>
</table>	
    
<table width="98%"  class="tablebox_list" cellpadding="0" cellspacing="0" >
<tr height=26>		
	<td  align="center" width="4%"><font  color="#FF6600">(<%=count%>個)</font></td>
    	<td  align="center" width="96%"　colspan="1５"><span class="calendar7"> 品質試験書</span> </td>
</tr>
</table>
<table width="98%"  cellpadding="3" cellspacing="0" >
<form>
<tr  align=center height=26 bgcolor="#eeeeee">	
    <td width="3%" class="title_list_all">固有番号</td>
    <td  width="12%" class="title_list_m">大項目</td>
    <td  width="12%" class="title_list_m">中項目</td>
    <td  width="10%" class="title_list_m">タイトル</td>
    <td  width="15%">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1" >
			<tr  align=center height=26>	
				<td  align="center"  class="clear_dot_gray">試験書原文(ORMS)</td>
			</tr>			
			<tr height=2  style=color:#336699;>
				<td align="center"><font color="#0066FF">履歴</font></td>					
			</tr>
		</table>	
	</td>	
	<td width="15%">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1" >
		<tr  align=center height=26>	
				<td  align="center" class="clear_dot_gray">QAチェック本(OT)</td>
			</tr>			
			<tr height=2  style=color:#336699;>
				<td align="center"  ><font color="#0066FF">履歴</font></td>					
			</tr>
		</table>	
	</td>	
	<td width="15%">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1" >
		<tr  align=center height=26>	
				<td  align="center" class="clear_dot_gray">QA確認本</td>
			</tr>			
			<tr height=2  style=color:#336699;>
				<td align="center"  ><font color="#0066FF">履歴</font></td>					
			</tr>
		</table>	
	</td>	
	<td width="15%">
		<table width=100% class="tablebox_list" cellpadding="1" cellspacing="1" >
		<tr  align=center height=26>	
				<td  align="center" class="clear_dot_gray">最終完成本</td>
			</tr>			
			<tr height=2  style=color:#336699;>
				<td align="center"  ><font color="#0066FF">履歴</font></td>					
			</tr>
		</table>	
	</td>	
	<td width="3%" class="title_list_m">全体削除</td>
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="9" class="title_list_s_3all">---</td>
	</tr>
</c:if>
				
<c:if test="${! empty list}">	
<%
	int i=1;			
%>
		
	<%
		Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					HinsithuBean pdb=(HinsithuBean)listiter.next();
					int or_seq=pdb.getNo();											
					if(or_seq!=0){	
						String aadd=dateFormat.format(pdb.getRegister());					
						String codeA=pdb.getCate_code();
						String codeB=pdb.getCate_code_det();		
						String codeC=pdb.getCate_code_s();
						String titleVal=pdb.getF_title().substring(0,3);				
	%>
	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="title_list_s_3all"><%=or_seq%></td>
	<td align="center" class="title_list_s_r">					
<%Category codeVal4 = manager2.select(Integer.parseInt(codeA));
	if(codeVal4!=null){%>				
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');"  onFocus="this.blur()"><%=codeVal4.getName()%></a>
	<%}else{%>											
			No Data
	<%}%>		
	</td>
	<td align="center" class="title_list_s_r">
<%Category codeVal5 = manager2.select(Integer.parseInt(codeB));
	if(codeVal5!=null){%>				
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');"  onFocus="this.blur()"><%=codeVal5.getName()%></a>
	<%}else{%>											
			No Data
	<%}%>					
	
	</td>
	<td align="center"  class="title_list_s_r">
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');"  onFocus="this.blur()">
<%if(titleVal.equals("[1]")){%>   
	<font color="#CC6600"><%=pdb.getF_title()%></font>
<%}else{%>
	<%=pdb.getF_title()%>
<%}%>
		  </a> 
	</td>	
	<td align="center" class="title_list_s_r">
	<%if(pdb.getView_yn()==0){%>		
		<a href="javascript:goDown2('<%=pdb.getFilename()%>')"  onfocus="this.blur()">				
		<%=pdb.getFilename()%></a><br>
	<%}else{%>
	<img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"><br>
	<%}%>
		<font color="#0066FF"><%=aadd%></font><br>
		<%if (pdb.getKind_yn()==0){%>
			<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/kindCh_pop.jsp','read','상세보기','720','290',
					'&bseq=0&fileKind=2&fno=<%=or_seq %>');" onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_jp_mi.gif" align="absmiddle" alt="QAチェック本(OT)へ"  title="QAチェック本(OT)へ"></a>
			
		<%}%>
		<%if (pdb.getKind_yn()==1){%><img src="<%=urlPage%>rms/image/admin/btn_jp_owari.gif" align="absmiddle"><%}%>
		
		<a href="javascript:goModify(<%=or_seq%>)" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"  alt="修正" title="修正"></a>&nbsp;
		<a href="javascript:goDelete(<%=or_seq%>)"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"  alt="削除" title="削除"></a>
		
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp','popUpdate','상세보기','720','400',
					'&file_bseq=<%=or_seq%>&file_kind=1&openerPg=<%=currentPage%>');" onfocus="this.blur()">	
		<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle">			
			<%int commentCnt01 = manaCom.HenjiCnt(or_seq,1);
				if(commentCnt01!=0){%>	
					<font color="#FF6600">(<%=commentCnt01%>)</font>
				<%}%>			
		</a>
	</td>
	<td align="center" class="title_list_s_r">				
<%HinsithuBean kindbun = manager.getKind2(or_seq , 2);%>		
<c:set var="kindbun" value="<%= kindbun %>" />
<c:if test="${! empty  kindbun}" >		
	<%if(kindbun.getView_yn()==0){%>		
		<a href="javascript:goDown2('<%=kindbun.getFilename()%>')"  onfocus="this.blur()">					
		<%=kindbun.getFilename()%></a><br>
	<%}else{%>
	<img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"> <br>
	<%}%>		
						
		<font color="#0066FF"><%=dateFormat.format(kindbun.getRegister())%></font><br>
		<%if (kindbun.getKind_yn()==0){%>
			<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/kindCh_pop.jsp','read','상세보기','720','290',
					'&bseq=<%=kindbun.getBseq()%>&fileKind=3&fno=<%=or_seq %>');" onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_jp_mi.gif" align="absmiddle" alt="QA確認本へ" title="QA確認本へ"></a>
			
		<%}%>
		<%if (kindbun.getKind_yn()==1){%><img src="<%=urlPage%>rms/image/admin/btn_jp_owari.gif" align="absmiddle"><%}%>
		
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/modifyFormLevel2_pop.jsp','popUpdate','상세보기','720','290',
					'&bseq=<%=kindbun.getBseq()%>&file_kind=2&fno=<%=or_seq %>');" onfocus="this.blur()">		
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"　alt="修正" title="修正"></a>&nbsp;
		<a href="javascript:goDeleteLevel2('<%=or_seq%>','<%=kindbun.getFile_kind()%>','<%=kindbun.getBseq()%>','<%=kindbun.getNo()%>')"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"　alt="削除" title="削除"></a>
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp','popUpdate','상세보기','720','400',
					'&file_bseq=<%=kindbun.getBseq()%>&file_kind=2&openerPg=<%=currentPage%>');" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle">
			<%int commentCnt02 = manaCom.HenjiCnt(kindbun.getBseq(),2);
				if(commentCnt02 !=0){%>	
					<font color="#FF6600">(<%=commentCnt02%>)</font>
			<%}%></a>		
</c:if>
<c:if test="${ empty  kindbun}" >
		...
</c:if>				
	</td>
	<td align="center" class="title_list_s_r">
<%HinsithuBean kindbun2 = manager.getKind2(or_seq , 3);%>		
<c:set var="kindbun2" value="<%= kindbun2 %>" />
<c:if test="${! empty  kindbun2}" >					
	<%if(kindbun2.getView_yn()==0){%>
		<a href="javascript:goDown2('<%=kindbun2.getFilename()%>')"  onfocus="this.blur()">						
		<%=kindbun2.getFilename()%></a><br>
	<%}else{%>
	<img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"> <br>
	<%}%>	
		<font color="#0066FF"><%=dateFormat.format(kindbun2.getRegister())%></font><br>
		<%if (kindbun2.getKind_yn()==0){%>
			<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/kindCh_pop.jsp','read','상세보기','720','290',
					'&bseq=<%=kindbun2.getBseq()%>&fileKind=4&fno=<%=or_seq %>');" onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_jp_mi.gif" align="absmiddle" alt="最終完成本へ" title="最終完成本へ"></a>
			
		<%}%>
		<%if (kindbun2.getKind_yn()==1){%><img src="<%=urlPage%>rms/image/admin/btn_jp_owari.gif" align="absmiddle"><%}%>
		
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/modifyFormLevel2_pop.jsp','popUpdate','상세보기','720','290',
					'&bseq=<%=kindbun2.getBseq()%>&file_kind=3&fno=<%=or_seq %>');" onfocus="this.blur()">	
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"　alt="修正" title="修正"></a>&nbsp;
		<a href="javascript:goDeleteLevel2('<%=or_seq%>','<%=kindbun2.getFile_kind()%>','<%=kindbun2.getBseq()%>','<%=kindbun2.getParentId()%>')"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"　alt="削除" title="削除"></a>
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp','popUpdate','상세보기','720','400',
					'&file_bseq=<%=kindbun2.getBseq()%>&file_kind=3&openerPg=<%=currentPage%>');" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle">
			<%int commentCnt03 = manaCom.HenjiCnt(kindbun2.getBseq(),3);
				if(commentCnt03!=0){%>	
					<font color="#FF6600">(<%=commentCnt03%>)</font>
			<%}%> </a>	
</c:if>
<c:if test="${ empty  kindbun2}" >
		...
</c:if>				
	</td>
	<td align="center" class="title_list_s_r">
<%HinsithuBean kindbun3 = manager.getKind2(or_seq , 4);%>		
<c:set var="kindbun3" value="<%= kindbun3 %>" />
<c:if test="${! empty  kindbun3}" >		
	<%if(kindbun3.getView_yn()==0){%>		
		<a href="javascript:goDown2('<%=kindbun3.getFilename()%>')"  onfocus="this.blur()">								
		<%=kindbun3.getFilename()%></a><br>
	<%}else{%>
	<img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"> <br>
	<%}%>	
		<font color="#0066FF"><%=dateFormat.format(kindbun3.getRegister())%></font><br>
			
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/modifyFormLevel2_pop.jsp','popUpdate','상세보기','720','290',
					'&bseq=<%=kindbun3.getBseq()%>&file_kind=4&fno=<%=or_seq %>');" onfocus="this.blur()">	
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"　alt="修正" title="修正"></a>&nbsp;
		<a href="javascript:goDeleteLevel2('<%=or_seq%>','<%=kindbun3.getFile_kind()%>','<%=kindbun3.getBseq()%>','<%=kindbun3.getParentId()%>')"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="削除" title="削除"></a>
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp','popUpdate','상세보기','720','400',
					'&file_bseq=<%=kindbun3.getBseq()%>&file_kind=4&openerPg=<%=currentPage%>');" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle">
			<%int commentCnt04 = manaCom.HenjiCnt(kindbun3.getBseq(),4);
				if(commentCnt04!=0){%>	
					<font color="#FF6600">(<%=commentCnt04%>)</font>
			<%}%> 	</a>	
</c:if>
<c:if test="${ empty  kindbun3}" >
		...
</c:if>				
	</td>	
	<td  align="center" class="title_list_s_r">
		<a href="javascript:goDelete(<%=or_seq%>)"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="削除" title="削除"></a>
	</td>
</tr>
<tr>
	<td colspan="9" align="center" width="100%">
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;padding:5px 0px 5px 0px;border-bottom: 1px solid #ccc;" >		
			<table width="60%"  class="tablebox" cellpadding="3" cellspacing="3" >
				<tr>	
								<td   width="20%" align="center"><span class="calendar11">大項目 : </span></td>							
								<td  width="80%" colspan="3" align="left">
	<%Category codeVal1 = manager2.select(Integer.parseInt(codeA));
		if(codeVal1!=null){%>				
			<%=codeVal1.getName()%>
		<%}else{%>											
			No Data
		<%}%>						
		
								</td>
							</tr>	
							<tr>	
								<td align="center"><span class="calendar11">中項目 : </span></td>							
								<td colspan="3" align="left">
	<%Category codeVal2 = manager2.select(Integer.parseInt(codeB));
		if(codeVal2!=null){%>				
			<%=codeVal2.getName()%>
		<%}else{%>											
			No Data
		<%}%>					
			
								</td>
							</tr>	
							<tr>	
								<td align="center" class="clear_dot"><span class="calendar11">小項目 : </span></td>							
								<td colspan="3" align="left" class="clear_dot">
	<%Category codeVal3 = manager2.select(Integer.parseInt(codeC));
		if(codeVal3!=null){%>				
			<%=codeVal3.getName()%>
		<%}else{%>											
			No Data
		<%}%>						</td>
				</tr>						
				<tr>					
								<td  width="10%" rowspan="3"   align="center" class="clear_dot"><span class="calendar11">保管 : </span></td>
								<td  width="40%" align="left"><font color="#9C751A">場所:</font> &nbsp; <%=pdb.getBasho()%></td>
								<td  width="10%" rowspan="3"   align="center" class="clear_dot"><span class="calendar11">責任者 : </span></td>
								<td  width="40%" align="left"><font color="#9C751A">名前:</font> &nbsp; <%=pdb.getFname()%></td>
							</tr>
							
							<tr>
								<td align="left"><font color="#9C751A" >デジタル:</font> &nbsp;  <%=pdb.getBasho_digi()%></td>
								<td align="left"><font color="#9C751A">デジタル:</font> &nbsp;<%=pdb.getFname_digi()%> </td>
							</tr>
							<tr>
								<td align="left" class="clear_dot"><font color="#9C751A">文書: </font> &nbsp; <%=pdb.getBasho_bun()%></td>
								<td align="left" class="clear_dot"><font color="#9C751A">文書:</font> &nbsp;<%=pdb.getFname_bun()%></td>
				</tr>							
				<tr>					
								<td  width="20%" align="center"><span class="calendar11">コメント : </span></td>							
								<td  width="80%" colspan="3" align="left"><%=pdb.getContent()%></td>							
				</tr>	
			</table>
		</span>
	</td>
</tr>
<%	}
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
    <input type="hidden" name="fno" value="">    
    <input type="hidden" name="file_bseq" value="">  
    <input type="hidden" name="filename" value="">    
    <input type="hidden" name="bseq" value="">  
    <input type="hidden" name="file_kind" value="">  
    <input type="hidden" name="parentId" value="">  
    <input type="hidden" name="page" value="${currentPage}">
    <c:if test="<%= searchCondPcode %>">
    <input type="hidden" name="search_cond" value="pcode">
    </c:if>
    <c:if test="<%= searchCondPname %>">
    <input type="hidden" name="search_cond" value="pname">
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
    
    <c:if test="<%= searchCondStatus %>">
    	<input type="hidden" name="search_radio" value="ymdStatus">
    </c:if>
    <c:if test="<%= searchCondOrderseq %>">
    	<input type="hidden" name="search_radio" value="seq">
    </c:if>
</form>
<script language="JavaScript">
function goPage(pageNo) {    
    	document.move.page.value = pageNo;
	document.move.action = "<%=urlPage%>rms/admin/hinsithu/listForm.jsp";
    	document.move.submit();
}
function goDelete(fno) {
	document.move.action = "<%=urlPage%>rms/admin/hinsithu/bunshoDelForm.jsp";
	document.move.fno.value=fno;	
    	document.move.submit();
}
function goModify(fno) {	
    	document.move.action = "<%=urlPage%>rms/admin/hinsithu/modifyForm.jsp";
	document.move.fno.value=fno;	
    	document.move.submit();
}
function goModifyLevel_2(fno,file_kind,bseq) {					
			var param="&fno="+fno+"&file_kind="+file_kind+"&bseq="+bseq;
			openNoScrollWin("<%=urlPage%>ms/admin/hinsithu/modifyFormLevel2_pop.jsp", "update", "update", "720", "290", param);					
}
function goDeleteLevel2(fno,file_kind,bseq,parentId) {	
    	document.move.action = "<%=urlPage%>rms/admin/hinsithu/bunshoDelLevel2Form.jsp";
	document.move.fno.value=fno;	
	document.move.file_kind.value=file_kind;
	document.move.bseq.value=bseq;
	document.move.parentId.value=parentId;
    	document.move.submit();
}

function goDown2(filename) {		
    	document.move.action = "<%=urlPage%>rms/admin/hinsithu/down.jsp";
	document.move.filename.value=filename;	
    	document.move.submit();
	
}
function goComment(fno,file_kind,bseq) {					
			var param="&fno="+fno+"&fileKind="+file_kind+"&bseq="+bseq;
			openNoScrollWin("<%=urlPage%>ms/admin/hinsithu/comentList_pop.jsp", "update", "update", "720", "290", param);					
}

</script>