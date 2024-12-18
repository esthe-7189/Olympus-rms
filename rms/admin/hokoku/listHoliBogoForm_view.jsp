<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
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
String inDate=dateFormat.format(new java.util.Date());		
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");

String title= ""; String name=""; String mailadd=""; String pass=""; String position=""; String busho="";
int mseq=0; int level=0; int dbPosiLevel=0;  
	
	String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	    
    
	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");
	String[] searchRadio=request.getParameterValues("search_radio");
	String sel_bgndate=request.getParameter("sel_bgndate");
	String sel_enddate=request.getParameter("sel_enddate");	

	MemberManager mem = MemberManager.getInstance();	
	Member member=mem.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();
		 mailadd=member.getMail_address();
		 pass=member.getPassword();
		 mseq=member.getMseq();
		 position=member.getPosition();
		 busho=member.getBusho();
		 dbPosiLevel=member.getPosition_level();
	}	


//부서별 출력
String bushopg=request.getParameter("bushopg");
if(bushopg==null){bushopg="1";}
String bushoVal="";
	 if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){	
		 bushoVal=bushopg;	
	}else{
		bushoVal=busho;
	}	


if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
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

	
	
	List whereCond = null;
	Map whereValue = null;

	boolean searchCondPcode = false; boolean searchCondPname = false; 
	boolean searchCondDD = false; boolean searchCondWW = false;
	boolean searchCondMM = false; boolean searchCondSS = false; 
	boolean searchCondYY = false; boolean searchCondYMD = false; 

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("pcode")){
				whereCond.add(" c.nm LIKE '%"+searchKey+"%'");				
				searchCondPcode=true;
			}else if (searchCond[i].equals("pname")){
				whereCond.add(" a.comment LIKE '%"+searchKey+"%'");
				searchCondPname = true;			
			}		
		}
	}else if (searchRadio !=null && searchRadio.length>0 ){
		for (int y=0;y<searchRadio.length ;y++ ){
			if (searchRadio[y].equals("dd")){
				whereCond.add(" a.register LIKE '"+ddate+"%' ");				
				searchCondDD=true;
			}else if (searchRadio[y].equals("ww")){
				whereCond.add(" a.register BETWEEN '"+wdate+"' and '"+sdate+"' ");				
				searchCondWW=true;			
			}else if (searchRadio[y].equals("mm"))	{
				whereCond.add(" a.register BETWEEN '"+mdate+"' and '"+sdate+"' ");					
				searchCondMM=true;
			}else if (searchRadio[y].equals("ss")){
				whereCond.add(" a.register BETWEEN '"+sixmdate+"' and '"+sdate+"' ");					
				searchCondSS=true;
			}else if (searchRadio[y].equals("yy")){
				whereCond.add(" a.register BETWEEN '"+yeardate+"' and '"+sdate+"' ");					
				searchCondYY=true;			
			}else if (searchRadio[y].equals("ymd")){				
				whereCond.add(" a.register BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"' ");					
				searchCondYMD=true;
			}

		}
	}
	DataMgrHoliHokoku manager = DataMgrHoliHokoku.getInstance();	
				
	int count = manager.count(bushoVal,whereCond, whereValue);	
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
	List  list=manager.selectList(bushoVal,whereCond, whereValue,startRow,endRow);					
	Member memSign;	
%>
<c:set var="member" value="<%=member%>"/>
<c:set var="list" value="<%=list %>" />	


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
function excelDown(){		
	openNoScrollWin("<%=urlPage%>rms/admin/hokoku/excelDown_pop.jsp", "ExcelDown", "signAdd", "500", "350","");
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
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">出張/休日勤務 > 休日出勤申請書/報告書 > 全体目録 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<jsp:include page="/rms/admin/hokoku/middleMenuView.jsp" flush="false"/>		
</div>
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">	
	<tr>			
		<td style="padding: 0px 0px 0px 10px" ><img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 
			<span class="calendar7">休日出勤申請書/報告書</span>			
    		</td> 		
		<td align="right">
			<a class="topnav"  href="javascript:goJumpWrite('<%=bushoVal%>'); " onfocus="this.blur();">[:::::新規登録:::::]</a>				
    		</td>  				
	</tr>		
</table>
			
				
<div id="boxNoLineBig"  >
	<div id="searchBox">				
		<div class="searchBox_all">	
		<table  border="0" cellpadding="5" cellspacing="5" width="95%" >
			<form name="searchDate"   action="<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp" method="post"  >		
			<input type="hidden" name="bushopg" value="<%=bushoVal%>">		
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
																									
					</td>						
				</tr>
			</form>									
		</table>							
	</div><!--searchBox_all-->	
</div>																							
<div class="clear_margin"></div>

<table width="100%" cellpadding="0" cellspacing="0">			
  <tr>      
    <td style="padding: 0 0 2 5;">
    	<font color="#807265">※出張者氏名をクリックすると下に詳しい内容が見えます。</font><br>
    	<font color="#807265">※<img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle">の上にマウスを置くと返還理由が分かります。</font><br>
    	<font color="#807265">※社長の決裁を受けると</font><font color="#FF5285">日程管理に</font><font color="#807265">自動的に登録されます。</font><br>
    	<font color="#807265">※Excelのダウンロード方法。</font>====>
    		<a href="javascript:excelDown()" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle"></a>
    </td>
    </tr>    		
</table>		
			
<table width="100%">
	<form name="search"  action="<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp" method="post">
	<input type="hidden" name="bushopg" value="<%=bushoVal%>">
	<tr>
		<td colspan="4" >		
			<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
				<option name="" VALUE=""  >検索(選択!)</option>
				<option name="search_cond" VALUE="pcode">氏名</option>
				<option name="search_cond" VALUE="pname">業務内容</option>				
			</select>
				<input type="TEXT" NAME="search_key" VALUE="" SIZE="20" class="logbox" >				
				<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索">
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体リスト" onClick="javascript:goJumpHoliBogo('<%=bushoVal%>');">
		</td>		
		<%if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){%>			
			<td align="right">
						<a class="topnav"  href="javascript:goJumpHoliBogo('1');" onfocus="this.blur();">[品質管理部]</a>
						<a class="topnav"  href="javascript:goJumpHoliBogo('2');" onfocus="this.blur();">[製造部]</a>					
						<a class="topnav"  href="javascript:goJumpHoliBogo('0');" onfocus="this.blur();">[経営役員]</a>
						<a class="topnav"  href="javascript:goJumpHoliBogo('4');" onfocus="this.blur();">[その他]</a>
						<!--<a class="topnav"  href="javascript:goJumpHoliBogo('3');" onfocus="this.blur();">[管理部]</a>			-->
		    </td>			
		<%}%>				
	</tr>
	</form>	
</table>		
	
<table width="100%"  class="tablebox_list" cellpadding="0" cellspacing="0" >	
<tr height=26>	
    <td  align="center" colspan="13">    	
					<% if(bushoVal.equals("1")){%>(品質管理部)<%}%>
					<% if(bushoVal.equals("2")){%>(製造部)<%}%>									
					<% if(bushoVal.equals("0")){%>(経営役員)<%}%>						
					<% if(bushoVal.equals("4")){%>(その他部)<%}%>
			<!--  <% if(bushoVal.equals("3")){%>(管理部)<%}%>		-->			
    </td>
</tr>
<tr bgcolor=#F1F1F1 align=center height=26>	
    <td  align="center" width="11%" class="title_list_all">登録日</td>		
    <td  align="center" width="7%" class="title_list_m">所 属</td>
    <td  align="center" width="8%" class="title_list_m">氏 名</td>
    <td  align="center" width="8%" class="title_list_m">日 付</td>    
    <td  align="center" width="9%" class="title_list_m">予定時間</td>
    <td  align="center" width="9%" class="title_list_m">休憩時間</td>
    <td  align="center" width="7%" class="title_list_m">承認(社長)</td>
    <td  align="center" width="6%" class="title_list_m">承認(2)</td>
    <td  align="center" width="6%" class="title_list_m">承認(3)</td>
    <td  align="center" width="6%" class="title_list_m">承認(4)</td>    
    <td  align="center" width="8%" class="title_list_m">申請書</td>
    <td  align="center" width="8%" class="title_list_m"><font color="#FF5285">報告書</font></td>	
    <td  align="center" width="8%" class="title_list_m">印刷</td>
	
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="13">-----</td>
	</tr>
</c:if>
				
<c:if test="${! empty list}">	
<% 	int i=1; 	
	int btotalHHMM=0;
	int bresultHH=0;
	int bresultMM=0;
	int btotalHHMM2=0;
	int bresultHH2=0;
	int bresultMM2=0;
		Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			DataBeanHokoku pdb=(DataBeanHokoku)listiter.next();
			int or_seq=pdb.getSeq();
			int totalHHMM=(pdb.getRest_end_hh()*60+pdb.getRest_end_mm())-(pdb.getRest_begin_hh()*60+pdb.getRest_begin_mm());
			int resultHH=totalHHMM/60;
			int resultMM=totalHHMM%60;	
			int totalHHMM2=(pdb.getPlan_end_hh()*60+pdb.getPlan_end_mm())-(pdb.getPlan_begin_hh()*60+pdb.getPlan_begin_mm());
			int resultHH2=totalHHMM2/60;
			int resultMM2=totalHHMM2%60;							
			String bushoDb=pdb.getBusho();															
		if(or_seq!=0){																			
			DataBeanHokoku beanBogo=manager.getDbBogo(or_seq); 		
%>
<c:set var="beanBogo" value="<%=beanBogo%>"/>	
	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" ><font color="#FF5285">[申請書]</font><%=dateFormat.format(pdb.getRegister())%>
	</td>
	<td align="center" >
		<% if(bushoDb.equals("0")){%>経営役員<%}%>	
		<% if(bushoDb.equals("4")){%>その他<%}%>		
		<% if(bushoDb.equals("1")){%>品質管理部<%}%>
		<% if(bushoDb.equals("2")){%>製造部<%}%>
		<% if(bushoDb.equals("3")){%>管理部<%}%>	
		<% if(bushoDb.equals("no data")){%>その他<%}%>	
	</td>	
	<td align="center">
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>
	<td align="center">
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');" onFocus="this.blur()"><font color="#009900"><%=pdb.getTheday()%></font></a>
	</td>		
	<td align="center"><%=pdb.getPlan_begin_hh()%>:<%=pdb.getPlan_begin_mm()%><font color="#009900">～</font><%=pdb.getPlan_end_hh()%>:<%=pdb.getPlan_end_mm()%>(<%=resultHH2%>:<%=resultMM2%>)</td>
	<td align="center"><%=pdb.getRest_begin_hh()%>:<%=pdb.getRest_begin_mm()%><font color="#009900">～</font><%=pdb.getRest_end_hh()%>:<%=pdb.getRest_end_mm()%>(<%=resultHH%>:<%=resultMM%>)</td>		
	<td align="center">
		<%
			memSign=mem.getDbMseq(pdb.getSign_ok_mseq_boss()); 
			if(memSign!=null){		
			 if(pdb.getSign_ok_yn_boss() !=0){		
				if(pdb.getSign_ok_yn_boss()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(pdb.getSign_ok_yn_boss()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>
	<td align="center">
		<%
			memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
			if(memSign!=null){		
			 if(pdb.getSign_ok_yn_bucho() !=0){		
				if(pdb.getSign_ok_yn_bucho()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(pdb.getSign_ok_yn_bucho()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>	
	<td align="center">
		<%
			memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho2()); 
			if(memSign!=null){		
			 if(pdb.getSign_ok_yn_bucho2() !=0){		
				if(pdb.getSign_ok_yn_bucho2()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(pdb.getSign_ok_yn_bucho2()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(pdb.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho2()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>
	<td align="center">
		<%
			memSign=mem.getDbMseq(pdb.getSign_ok_mseq_kanribu()); 
			if(memSign!=null){		
			 if(pdb.getSign_ok_yn_kanribu() !=0){		
				if(pdb.getSign_ok_yn_kanribu()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(pdb.getSign_ok_yn_kanribu()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(pdb.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_kanribu()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>
	<td align="center">	
		<%if(pdb.getMseq()==mseq){%>					
		<a href="javascript:goModify(<%=or_seq%>)" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>&nbsp;
		<a href="javascript:goDelete('<%=or_seq%>','<%=pdb.getTheday()%>')"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>	
		<%}else{%>---<%}%>
	</td>	
	<td align="center">		
		<%if(pdb.getMseq()==mseq){%>
			<%if(pdb.getSeqcnt()==0){%><a class="topnav"  href="javascript:goBogo(<%=or_seq%>)"　onfocus="this.blur();">[作成]</a><%}else{%>---<%}%>			
		<%}else{%>---<%}%>		
	</td>
	<td align="center"  >		
		<a href="javascript:goExcel(<%=or_seq%>)" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle" ></a>&nbsp;
		<a href="javascript:popPrint(<%=or_seq%>)" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle" ></a>
	</td>				
</tr>
<c:if test="${! empty beanBogo}">	
<%	 btotalHHMM=(beanBogo.getRest_end_hh()*60+beanBogo.getRest_end_mm())-(beanBogo.getRest_begin_hh()*60+beanBogo.getRest_begin_mm());
	 bresultHH=btotalHHMM/60;
	 bresultMM=btotalHHMM%60;	
	 btotalHHMM2=(beanBogo.getPlan_end_hh()*60+beanBogo.getPlan_end_mm())-(beanBogo.getPlan_begin_hh()*60+beanBogo.getPlan_begin_mm());
	 bresultHH2=btotalHHMM2/60;
	 bresultMM2=btotalHHMM2%60;
%>
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" ><font color="#0099FF">[報告書]</font><%=dateFormat.format(beanBogo.getRegister())%></td>
	<td align="center" >
		<% if(bushoDb.equals("0")){%>経営役員<%}%>	
		<% if(bushoDb.equals("4")){%>その他<%}%>		
		<% if(bushoDb.equals("1")){%>品質管理部<%}%>
		<% if(bushoDb.equals("2")){%>製造部<%}%>
		<% if(bushoDb.equals("3")){%>管理部<%}%>	
		<% if(bushoDb.equals("no data")){%>その他<%}%>	
	</td>	
	<td align="center" >
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=beanBogo.getNm()%></font>
		</a> 
	</td>
	<td align="center" >
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');" onFocus="this.blur()"><font color="#009900"><%=beanBogo.getTheday()%></font></a> 
	</td>		
	<td align="center" ><%=beanBogo.getPlan_begin_hh()%>:<%=beanBogo.getPlan_begin_mm()%><font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>:<%=beanBogo.getPlan_end_mm()%>(<%=bresultHH2%>:<%=bresultMM2%>)</td>
	<td align="center" ><%=beanBogo.getRest_begin_hh()%>:<%=beanBogo.getRest_begin_mm()%><font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>:<%=beanBogo.getRest_end_mm()%>(<%=resultHH%>:<%=resultMM%>)</td>		
	<td align="center" >
		<%
			memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
			if(memSign!=null){		
			 if(beanBogo.getSign_ok_yn_boss() !=0){		
				if(beanBogo.getSign_ok_yn_boss()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(beanBogo.getSign_ok_yn_boss()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>
	<td align="center" >
		<%
			memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
			if(memSign!=null){		
			 if(beanBogo.getSign_ok_yn_bucho() !=0){		
				if(beanBogo.getSign_ok_yn_bucho()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(beanBogo.getSign_ok_yn_bucho()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>	
	<td align="center" >
		<%
			memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
			if(memSign!=null){		
			 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
				if(beanBogo.getSign_ok_yn_bucho2()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(beanBogo.getSign_ok_yn_bucho2()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho2()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>
	<td align="center" >
		<%
			memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
			if(memSign!=null){		
			 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
				if(beanBogo.getSign_ok_yn_kanribu()==2 ){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(beanBogo.getSign_ok_yn_kanribu()==1){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 				
				<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_kanribu()%>"><%}%>				
		<%}}else{%>--<%}%>
	</td>
	<td align="center" >	
		---
	</td>	
	<td align="center" >
		<%if(pdb.getMseq()==mseq){%>			
			<%if(pdb.getSeqcnt()!=0){%>						
			<a href="javascript:goModifyBogo(<%=pdb.getSeqcnt()%>)" onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>&nbsp;
			<a href="javascript:goDeleteBogo('<%=pdb.getSeqcnt()%>','<%=beanBogo.getTheday()%>')"  onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>	
			<%}else{%>---<%}%>
		<%}else{%>---<%}%>		
	</td>	
	<td align="center"  >		
		<a href="javascript:goExcel(<%=or_seq%>)" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle" ></a>&nbsp;
		<a href="javascript:popPrint(<%=or_seq%>)" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle" ></a>
	</td>				
</tr>
</c:if>
<tr><td colspan="13" class="clear_dot">&nbsp;</td></tr>			
<tr>							
	<td  style="padding: 5px 5px 5px 5px;"  colspan="13" align="center" width="90%" >
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 5px 0px 0px 0px">休日出勤申請書</td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(pdb.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			<tr height="29" >			
				<td align="center" bgcolor="#f7f7f7" width="15%" >所 属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoDb.equals("4")){%>その他<%}%>
					<% if(bushoDb.equals("0")){%>経営役員<%}%>		
					<% if(bushoDb.equals("1")){%>品質管理部<%}%>
					<% if(bushoDb.equals("2")){%>製造部<%}%>
					<% if(bushoDb.equals("3")){%>管理部<%}%>	
					<% if(bushoDb.equals("no data")){%>その他<%}%>
				</td>
				<td align="center" bgcolor="#f7f7f7" width="15%">氏 名</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdb.getNm()%></td>
    		</tr>
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getTheday()%></td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=pdb.getPlan_begin_hh()%>時<%=pdb.getPlan_begin_mm()%>分<font color="#009900">～</font><%=pdb.getPlan_end_hh()%>時<%=pdb.getPlan_end_mm()%>分
					（<%=resultHH2%>時 <%=resultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=pdb.getRest_begin_hh()%>時<%=pdb.getRest_begin_mm()%>分<font color="#009900">～</font><%=pdb.getRest_end_hh()%>時<%=pdb.getRest_end_mm()%>分
					（<%=resultHH%>時 <%=resultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>							
						</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho2() !=0){		
			if(pdb.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_kanribu() !=0){		
			if(pdb.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
		<%}}else{%>--<%}%>						
						</td>
						</tr>							
						</table>
				</td>				
				</tr>
				</table>
		</td>								
		</tr>					
		</table>
</td>								
</tr>					
</table>
<!-----content end**************************--------->		
<!-----休日出勤報告書 end**************************--------->	
<p>
<c:if test="${! empty beanBogo}" >
<%	 btotalHHMM=(beanBogo.getRest_end_hh()*60+beanBogo.getRest_end_mm())-(beanBogo.getRest_begin_hh()*60+beanBogo.getRest_begin_mm());
	 bresultHH=btotalHHMM/60;
	 bresultMM=btotalHHMM%60;	
	 btotalHHMM2=(beanBogo.getPlan_end_hh()*60+beanBogo.getPlan_end_mm())-(beanBogo.getPlan_begin_hh()*60+beanBogo.getPlan_begin_mm());
	 bresultHH2=btotalHHMM2/60;
	 bresultMM2=btotalHHMM2%60;
%>
<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 10px 0px 0px 0px">休日出勤報告書</td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(beanBogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">	
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getTheday()%>	</td>				
			</tr>			
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=beanBogo.getPlan_begin_hh()%>時<%=beanBogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>時<%=beanBogo.getPlan_end_mm()%>分
					（<%=bresultHH2%>時 <%=bresultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=beanBogo.getRest_begin_hh()%>時<%=beanBogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>時<%=beanBogo.getRest_end_mm()%>分
					（<%=bresultHH%>時 <%=bresultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
							<td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>
					</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
			if(beanBogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
			if(beanBogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">	
	    <%	
		if(beanBogo.getMimg()!=null){		
		 if(!beanBogo.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=beanBogo.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
		<%}}else{%>--<%}%>						
							</td>
						</tr>							
						</table>
				</td>				
				</tr>
				</table>
		</td>								
		</tr>					
		</table>
</td>								
</tr>					
</table>
</c:if>
<!-----content end**************************--------->					
		</span>
	</td>
</tr>
<%	}
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
</form>

<script language="JavaScript">
function goPage(pageNo) {    
    document.move.page.value = pageNo;
	document.move.action = "<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp";
    document.move.submit();
}

function goJump(busho) {    
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/listForm.jsp";
    document.searchDate.submit();
}
function goJumpTripBogo(busho) {    	
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/listTripBogoForm.jsp";
    document.searchDate.submit();
}
function goJumpHoliBogo(busho) {    	
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp";
    document.searchDate.submit();
}
function goJumpWrite(busho) {    
	document.searchDate.bushopg.value =busho;    
	document.searchDate.action = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/writeTripForm.jsp";
    document.searchDate.submit();
}
function goJumpSrc(busho) {   	
	document.search.bushopg.value =busho;      
	document.search.action = "<%=urlPage%>rms/admin/hokoku/listTripBogoForm.jsp";
    document.search.submit();
}
function goDelete(fno,ymd) {
	if ( confirm("月日==> ["+ymd+"]のデータを削除しましょうか?") != 1 ) {return ;}
	document.move.action = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/delete.jsp";
	document.move.fno.value=fno;	
    document.move.submit();
}
function goModify(fno) {	
    document.move.action = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp";
	document.move.fno.value=fno;	
    document.move.submit();
}
function goDeleteBogo(fno,ymd) {
	if ( confirm("月日==> ["+ymd+"]のデータを削除しましょうか?") != 1 ) {return ;}
	document.move.action = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/deleteBogo.jsp";
	document.move.fno.value=fno;	
    document.move.submit();
}
function goModifyBogo(fno) {	
    document.move.action = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp";
	document.move.fno.value=fno;	
    document.move.submit();
}
function goBogo(fno) {	
    document.move.action = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/bogoForm.jsp";
	document.move.fno.value=fno;	
    document.move.submit();
}
function popPrint(fno){				
	var param="&fno="+fno;
	openScrollWin("<%=urlPage%>rms/admin/hokoku/excelForms/formHoriBogo.jsp", "signAdd", "signAdd", "500", "700",param);
}
function goExcel(fno) {	
    document.move.action = "<%=urlPage%>rms/admin/hokoku/excelForms/formHoriExcel.jsp";
	document.move.fno.value=fno;	
    document.move.submit();
}
</script>
	
	
	