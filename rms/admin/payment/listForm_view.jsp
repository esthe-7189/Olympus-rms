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
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>

<%! 
//static int PAGE_SIZE=15; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
NumberFormat num= NumberFormat.getNumberInstance();
%>

<%	
String kind=(String)session.getAttribute("KIND");
String urlPage2=request.getContextPath()+"/orms/";	
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
		cal.add(cal.DATE,-7);	Date curTime7=cal.getTime();wdate=dateFormat.format(curTime7);
		
		Calendar cal2=new GregorianCalendar();
		cal2.setTime(trialTime);
		cal2.add(cal2.MONTH,-1);	Date curTime30=cal2.getTime();mdate=dateFormat.format(curTime30);
		cal2.add(cal2.MONTH,-5);	Date curTime6=cal2.getTime();sixmdate=dateFormat.format(curTime6);
		
		Calendar cal3=new GregorianCalendar();
		cal3.setTime(trialTime);
		cal3.add(cal3.YEAR,-1);	Date curTime12=cal3.getTime();yeardate=dateFormat.format(curTime12);
		
	String inDate=dateFormat.format(new java.util.Date());
	String bunDay=inDate.substring(0,4);
	int bunDayInt=Integer.parseInt(bunDay)+1;

	String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	
    
    
	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");
	String[] searchRadio=request.getParameterValues("search_radio");
	String sel_bgndate=request.getParameter("sel_bgndate");
	String sel_enddate=request.getParameter("sel_enddate");
	String docontact=request.getParameter("docontact");
	if(docontact==null){docontact="1";}

	
	String kikanval=request.getParameter("kikanval");
	if(kikanval==null){kikanval="1";}
	
	String submit_yn=request.getParameter("submit_yn");
	if(submit_yn==null){submit_yn="1";}
	
	String btn=request.getParameter("btn");
	if(btn==null){btn="A";}	
	if(docontact=="1"){btn="A";}
	if(docontact=="2"){btn="B";}
	
	String pgSelect=request.getParameter("pgSelect");
	int pgSelectCnt=0;
	if(pgSelect==null){
		pgSelect="15";
	}else{	
%>
<c:remove var="PGLINE"  scope="session" />
<%
		session.setAttribute("PGLINE",pgSelect);
		session.setMaxInactiveInterval(60*60*12);					
	}
	int PAGE_SIZE=15;		
	String pgLine=(String)session.getAttribute("PGLINE");
	if(pgLine!=null){
		PAGE_SIZE=Integer.parseInt(pgLine);
	}
	
	String yyVal=request.getParameter("yyVal");
	String mmVal=request.getParameter("mmVal");
	String mgrYM=inDate.substring(0,7);
	String mgrYyyy=inDate.substring(0,4);
	String mgrMmmm=inDate.substring(5,7);
	if(mmVal !=null){
		mgrYM=yyVal+"-"+mmVal;
		mgrMmmm=mmVal;
	}
	if(yyVal==null){
		yyVal=mgrYyyy;		
	}
	if(mmVal==null){
		mmVal=mgrMmmm;		
	}
	int mgrYyyyInt=Integer.parseInt(mgrYyyy);
	int mgrMmmmInt=Integer.parseInt(mgrMmmm);
	
	
	List whereCond = null;
	Map whereValue = null;

	boolean searchCond01 = false; boolean searchCond02 = false; boolean searchCondDD = false;boolean searchCondWW = false;
	boolean searchCondMM = false; boolean searchCondSS = false; boolean searchCondYY = false; 
	boolean searchCondYMD = false; boolean searchCondPJ01= false; boolean searchCondPJ02= false;
	

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("1")){
				whereCond.add(" b.client_nm LIKE '%"+searchKey+"%'");				
				searchCond01=true;
			}else if (searchCond[i].equals("2")){
				whereCond.add(" b.client_nm LIKE '%"+searchKey+"%'");				
				searchCond02=true;
			}		
		}
	}else if (searchRadio !=null && searchRadio.length>0  && submit_yn.equals("1")){
		for (int y=0;y<searchRadio.length ;y++ ){
			if (searchRadio[y].equals("dd")){
				whereCond.add(" a.register LIKE '"+ddate+"%'");				
				searchCondDD=true;
			}else if (searchRadio[y].equals("ww")){
				whereCond.add(" (a.register BETWEEN '"+wdate+"' and '"+sdate+"')  ");				
				searchCondWW=true;			
			}else if (searchRadio[y].equals("mm"))	{
				whereCond.add(" (a.register BETWEEN '"+mdate+"' and '"+sdate+"')  ");						
				searchCondMM=true;
			}else if (searchRadio[y].equals("ss")){
				whereCond.add(" (a.register BETWEEN '"+sixmdate+"' and '"+sdate+"')  ");					
				searchCondSS=true;
			}else if (searchRadio[y].equals("yy")){
				whereCond.add(" (a.register BETWEEN '"+yeardate+"' and '"+sdate+"')  ");				
				searchCondYY=true;						
			}else if (searchRadio[y].equals("ymd")){				
				whereCond.add(" (a.register BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"') ");					
				searchCondYMD=true;
			}else if (searchRadio[y].equals("pj01")){				
				whereCond.add(" a.pj_yn=1");					
				searchCondPJ01=true;
			}else if (searchRadio[y].equals("pj02")){				
				whereCond.add(" a.pj_yn=2");					
				searchCondPJ02=true;
			}
		}
	}else if (searchRadio !=null && searchRadio.length>0  && submit_yn.equals("2")){
		for (int y=0;y<searchRadio.length ;y++ ){
			if (searchRadio[y].equals("dd")){
				whereCond.add(" register LIKE '"+ddate+"%'");				
				searchCondDD=true;
			}else if (searchRadio[y].equals("ww")){
				whereCond.add(" (register BETWEEN '"+wdate+"' and '"+sdate+"')  ");				
				searchCondWW=true;			
			}else if (searchRadio[y].equals("mm"))	{
				whereCond.add(" (register BETWEEN '"+mdate+"' and '"+sdate+"')  ");						
				searchCondMM=true;
			}else if (searchRadio[y].equals("ss")){
				whereCond.add(" (register BETWEEN '"+sixmdate+"' and '"+sdate+"')  ");					
				searchCondSS=true;
			}else if (searchRadio[y].equals("yy")){
				whereCond.add(" (register BETWEEN '"+yeardate+"' and '"+sdate+"')  ");				
				searchCondYY=true;						
			}else if (searchRadio[y].equals("ymd")){				
				whereCond.add(" (register BETWEEN '"+sel_bgndate+"' and '"+sel_enddate+"') ");					
				searchCondYMD=true;
			}else if (searchRadio[y].equals("pj01")){				
				whereCond.add(" a.pj_yn=1");					
				searchCondPJ01=true;
			}else if (searchRadio[y].equals("pj02")){				
				whereCond.add(" a.pj_yn=2");					
				searchCondPJ02=true;
			}
		}
	}



	CateMgr manager=CateMgr.getInstance();		
//	int count = manager.count(Integer.parseInt(kikanval),mgrYM,Integer.parseInt(docontact),whereCond, whereValue);	
	int count = manager.countt(Integer.parseInt(submit_yn),Integer.parseInt(kikanval),mgrYM,Integer.parseInt(docontact),whereCond, whereValue);
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
//	List  list=manager.selectList(Integer.parseInt(kikanval),mgrYM,Integer.parseInt(docontact),whereCond, whereValue,startRow,endRow);
List  list=manager.selectListt(Integer.parseInt(submit_yn),Integer.parseInt(kikanval),mgrYM,Integer.parseInt(docontact),whereCond, whereValue,startRow,endRow);
	FileMgr mgrItem=FileMgr.getInstance();		
	List list01=manager.listClient(1);
	List list02=manager.listClient(2);
%>
<c:set var="list" value="<%= list %>" />	
<c:set var="list01" value="<%= list01%>" />	
<c:set var="list02" value="<%= list02%>" />	

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
<div id="overlay"></div>	
<div class="clear"></div>
<img src="<%=urlPage%>rms/image/icon_ball.gif" > <span class="calendar7">請求書手続き管理 <font color="#A2A2A2">></font> 月別リスト</span>
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 月別リスト "  onClick="location.href='<%=urlPage%>rms/admin/payment/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 年別リスト "  onClick="location.href='<%=urlPage%>rms/admin/payment/listYearForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 取引先登録及び管理 " onClick="location.href='<%=urlPage%>rms/admin/payment/addForm.jsp'">			
</div>
<div id="boxNoLineBig"  >
	<div id="searchBox">			
<form name="search"  action="<%=urlPage%>rms/admin/payment/listForm.jsp" method="post"  >	
	<input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
	<input type="hidden" name="submit_yn" id="submit_yn"  value="<%=submit_yn%>">
	<input type="hidden" name="btn"  id="btn"  value="E">
	<input type="hidden" name="kikanval"  id="kikanval"  value="1">
	<input type="hidden" name="yyVal"  id="yyVal"  value="<%=yyVal%>">	
    	<input type="hidden" name="mmVal" id="mmVal"  value="<%=mmVal%>">		
	<div class="searchBox_all_l_30">	
		<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">支払周期 / 取引先名</span><br>						
			<select name="search_cond"  style="font-size:12px;color:#7D7D7D" onChange="return doEnter('');" >													
				<option name="" VALUE=""  >::::::: 検索 :::::::</option>							
	<%if(docontact.equals("1")){%><option name="search_cond" VALUE="1"   selected  >毎月支払</option><%}else{%><option name="search_cond" VALUE="1">毎月支払</option><%}%>
	<%if(docontact.equals("2")){%><option name="search_cond" VALUE="2"  selected>随時支払</option><%}else{%><option name="search_cond" VALUE="2"  >随時支払</option><%}%>											
			</select><br>
		<%if(docontact.equals("1")){%>
				<select name="search_key"  style="font-size:12px;color:#7D7D7D;" >														
					<option name="search_key" value="0" >::::::: 検索 :::::::</option>			
						<c:if test="${empty list01}">
					<option  name="search_key" value="0">データなし</option>					
						</c:if>
						<c:if test="${! empty list01}">
						<c:forEach var="code" items="${list01}" varStatus="index" >
					<option  name="search_key" value="${code.client_nm}"  >${code.client_nm}</option>								
						</c:forEach>
						</c:if>										
				</select>			
		<%}else if(docontact.equals("2")){%>
				<select name="search_key"  style="font-size:12px;color:#7D7D7D;" >														
					<option name="search_key" value="0" >::::::: 検索 :::::::</option>			
						<c:if test="${empty list02}">
					<option  name="search_key" value="0">データなし</option>					
						</c:if>
						<c:if test="${! empty list02}">
						<c:forEach var="code" items="${list02}" varStatus="index" >
					<option  name="search_key" value="${code.client_nm}"  >${code.client_nm}</option>								
						</c:forEach>
						</c:if>											
				</select>			
		<%}%>	    					
				<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">												
	</div>	
</form>	
<div class="searchBox_all_r_70">				
	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">受領日 検索</span>&nbsp;
			<font color="#CC0000">※</font>請求書受領基準
		<table  border="0" cellpadding="0" cellspacing="0" width="100%"  height="50">
			<form name="searchDate"   action="<%=urlPage%>rms/admin/payment/listForm.jsp" method="post"  >				
				<input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
				<input type="hidden" name="submit_yn" id="submit_yn"  value="<%=submit_yn%>">
				<input type="hidden" name="btn"  id="btn"  value="<%=btn%>">
				<input type="hidden" name="kikanval"  id="kikanval"  value="2">
				
				<tr>
					<td width="90%" >		
							<input type="radio" name="search_radio"  value="ymd"  onfocus="this.blur()" >期間指定: 			
<input type="text" size="8%" name="sel_bgndate" id="sel_bgndate" value="" style="text-align:center">	~ <input type="text" size="8%" name="sel_enddate" id="sel_enddate" value="" style="text-align:center">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<!--	<input type="radio" name="search_radio"  value="dd"  onfocus="this.blur()" ><font color="#009900">一日</font> &nbsp;-->
							<input type="radio" name="search_radio"  value="ww" onfocus="this.blur()"><font color="#009900">一週間</font> &nbsp;
							<input type="radio" name="search_radio"  value="mm" onfocus="this.blur()"><font color="#009900">一ヶ月間 </font>&nbsp;
							<input type="radio" name="search_radio"  value="ss" onfocus="this.blur()"><font color="#009900">六ヶ月間 </font>&nbsp;
							<input type="radio" name="search_radio"  value="yy" onfocus="this.blur()"><font color="#009900">一年間 </font>&nbsp;  <br>
				<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle"><span class="calendar9">PJ 検索</span>&nbsp;
							<input type="radio" name="search_radio"  value="pj01" onfocus="this.blur()">  通常 &nbsp;	   						
							<input type="radio" name="search_radio"  value="pj02" onfocus="this.blur()">  国家PJ 
						
					</td>								
					<td width="10%"    align="center" >
						<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="検索  >>">
						
					</td>
				</tr>				
					</form>									
			</table>					
	</div>				
</div><!--searchBox end-->						
<table width="900">
		<tr>					
			<td  align="left">  			
    		<font color="#CC0000">※</font>登録方法：リストの右上<input type="button"  class="cctopmenu2" onfocus="this.blur();" style="cursor:pointer"  value="::::: 登録 ::::: "  onClick="goAddAll();">をクリックし、取引先を選択してから登録する。					    		
			</td>			
		</tr>		
		<tr>					
			<td align="left">  			
    		<font color="#CC0000">※</font>直接に変更可能：(ORMS)-->受領確認、郵送 &nbsp;&nbsp; / &nbsp;&nbsp;    東京( OT宇津木 )-->受領確認、処理状態<br>					    		
			</td>	
		</tr>
<!--		<tr>					
			<td width="20%" align="left">  			
    		<font color="#CC0000">※</font><a href="javascript:excelDown()" onfocus="this.blur()">Excel ダウンロード<img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle" title="ダウンロードをする"></a>
    		<input type="submit" class="cc" onClick="excelExplain();" onfocus="this.blur();" style=cursor:pointer value="方法を見る">						    		
			</td>	
		</tr>
-->
</table>		
<div class="clear_margin"></div>
<table width="98%" border="0">
	<form name="search2"  action="<%=urlPage%>rms/admin/payment/listForm.jsp" method="post">	
	<input type="hidden" name="pagenm" value="<%=currentPage%>">
	<input type="hidden" name="yyVal"  id="yyVal"value="<%=yyVal%>">	
	<input type="hidden" name="mmVal" id="mmVal" value="<%=mmVal%>">	
	<input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
	<input type="hidden" name="submit_yn" id="submit_yn"  value="<%=submit_yn%>">
	<input type="hidden" name="btn"  id="btn"  value="<%=btn%>">
	<input type="hidden" name="kikanval"  id="kikanval"  value="1">
		<tr>		
			<td width="35%" align="left"  valign="bottom">				
		<%if(btn.equals("A") ){%>
				<input type="button"  class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
					class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');">
		<%}else if(btn.equals("B")){%>
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
					class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');">		
		
		<%}else{%>			
				<input type="button"  class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
					class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');">
		<%}%>	
					
			</td>
	
<!--	
			<td width="35%" align="left"  valign="bottom">				
		<%if(btn.equals("A") ){%>
				<input type="button"  class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
					class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
					class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
					class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">
		<%}else if(btn.equals("B")){%>
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
					class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
					class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
					class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">
		<%}else if(btn.equals("C")){%>
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
				class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">
		<%}else if(btn.equals("D")){%>
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
				class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">
		<%}else if(btn.equals("E") && submit_yn.equals("1") && docontact.equals("1")){%>
				<input type="button"  class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">
		<%}else if(btn.equals("E") && submit_yn.equals("1") && docontact.equals("2")){%>
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
				class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">
		<%}else if(btn.equals("E") && submit_yn.equals("2") && docontact.equals("1")){%>			
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
				class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">
		<%}else if(btn.equals("E") && submit_yn.equals("2") && docontact.equals("2")){%>			
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い" onClick="goKata('A','1','1');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い" onClick="goKata('B','1','2');"><input type="button"  
				class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="未登録(毎月)" onClick="goKata('C','2','1');"><input type="button"  
				class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="未登録(随時)" onClick="goKata('D','2','2');">	
		
		<%}%>			
			</td>
-->			
			
			<td width="15%" align="center"  >											
				
	<%if(kikanval.equals("2")){%>
		<c:if test="<%= searchCondDD %>" >			
		<%=ddate%>
		</c:if>
		<c:if test="<%= searchCondWW %>" >			
		<%=wdate%> ～ <%=sdate%>
		</c:if>
		<c:if test="<%= searchCondMM %>" >			
		<%=mdate%> ～ <%=sdate%>
		</c:if>
		<c:if test="<%= searchCondSS %>" >			
		<%=sixmdate%> ～ <%=sdate%>
		</c:if>
		<c:if test="<%= searchCondYY %>" >			
		<%=yeardate%> ～ <%=sdate%>
		</c:if>
		<c:if test="<%= searchCondYMD %>" >			
		<%=sel_bgndate%> ～ <%=sel_enddate%>
		</c:if>
	<%}%>
	<%if(kikanval.equals("1")){%>
		<span class="calendar5_01">		
		<%if(yyVal==null){%><%=mgrYM%> <%}%>
		<%if(yyVal!=null){%><%=yyVal%>-<%=mmVal%> <%}%> 月						
		</span>
	<%}%>
			</td>
			<td width="25%" align="left"  >
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="year_sch" class="select_type3" >
				  	  <option value="0" >0000</option>
				<%for(int i=2009;i<=mgrYyyyInt;i++){%>
					<%if(i==mgrYyyyInt){%>
						<option value="<%=i%>"  selected><%=i%></option>
					 <%}else{%> 			            							
						<option value="<%=i%>"  ><%=i%></option>
					<%}%>
				<%}%>																			
				  </select>年 
			</div>
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">							
				  <select name="menths_sch" class="select_type3"  onChange="return doSubmitOnEnter();">
				  	  	<option value="0" >00</option>
				  		<option value="01" >1</option>
				  		<option value="02" >2</option>
				  		<option value="03" >3</option>
				  		<option value="04" >4</option>
				  		<option value="05" >5</option>
				  		<option value="06" >6</option>
				  		<option value="07" >7</option>
				  		<option value="08" >8</option>
				  		<option value="09" >9</option>
				  		<option value="10" >10</option>
				  		<option value="11" >11</option>
				  		<option value="12" >12</option>				  									
				  </select>月  &nbsp;&nbsp;<font color="#CC0000">※</font>請求書受領基準
			</div>
		
		</form>	
			</td>
	<form name="frmGoLien"  action="<%=urlPage%>rms/admin/payment/listForm.jsp" method="post">				
    	<input type="hidden" name="yyVal"  id="yyVal"  value="<%=yyVal%>">	
    	<input type="hidden" name="mmVal" id="mmVal"  value="<%=mmVal%>">			
	<input type="hidden" name="pgSelect" id="pgSelect" value="<%=pgSelect%>">
	<input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
	<input type="hidden" name="submit_yn" id="submit_yn"  value="<%=submit_yn%>">
	<input type="hidden" name="btn"  id="btn"  value="<%=btn%>">
	<input type="hidden" name="kikanval"  id="kikanval"  value="1">
			<td width="15%" >      				 		
    				<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">							
				  <select name="pgSelect_sch" class="select_type3"  onChange="return doLine();">
				  	  	<option value="0" >選択</option>
				  	  	<%if(PAGE_SIZE==5){%><option value="5"  selected>5 </option><%}else{%><option value="5"  >5</option><%}%>
				  		<%if(PAGE_SIZE==10){%><option value="10"  selected>10 </option><%}else{%><option value="10"  >10</option><%}%> 
				  		<%if(PAGE_SIZE==15){%><option value="15"  selected>15</option><%}else{%><option value="15"  >15</option><%}%> 
				  		<%if(PAGE_SIZE==20){%><option value="20"  selected>20</option><%}else{%><option value="20"  >20</option><%}%> 
				  		<%if(PAGE_SIZE==30){%><option value="30"  selected>30</option><%}else{%><option value="30"  >30</option><%}%> 
				  		<%if(PAGE_SIZE==50){%><option value="50"  selected>50</option><%}else{%><option value="50"  >50</option><%}%> 
				  					  			  									
				  </select>個見る
				  / <font color="red"><%=count%>個 </font>
			</div>			
			</td>	
			<td width="10%" align="right">  			
				
    				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style="cursor:pointer"  value="      ::::: 登録 :::::     "  onClick="goAddAll();">	    		
			</td>	
		</tr>
		<input type="hidden" size="12%" name='yymmMove' class=calendarkin value="" style="text-align:center">	
	</form>		
</table>							
<table width="98%"  cellpadding="0" cellspacing="0" >	 	  
<form name="sform">
	<input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
	<input type="hidden" name="submit_yn" id="submit_yn"  value="<%=submit_yn%>">
	<input type="hidden" name="btn"  id="btn"  value="<%=btn%>">
	<input type="hidden" name="kikanval"  id="kikanval"  value="1">
    	<input type="hidden" name="page" value="${currentPage}">
    	<input type="hidden" name="kind" value="">
    	<input type="hidden" name="seq" value="">
    	<input type="hidden" name="yyVal"  id="yyVal"  value="<%=yyVal%>">	
    	<input type="hidden" name="mmVal" id="mmVal"  value="<%=mmVal%>">	
	<tr align=center height=29>
		<td  width=""  class="title_list_all" bgcolor="#F1F1F1">PJ 	    	  		
	     	<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">取引先 <br>
	<span class="calendar9">
			<% if(btn.equals("E") && submit_yn.equals("1") && docontact.equals("1")){%>毎月支払<%}%>
		     	<% if(btn.equals("E") && submit_yn.equals("1") && docontact.equals("2")){%>随時支払<%}%>
		     	<% if(btn.equals("E") && submit_yn.equals("2") && docontact.equals("1")){%>未登録(毎月)<%}%>
		     	<% if(btn.equals("E") && submit_yn.equals("2") && docontact.equals("2")){%>未登録(随時)<%}%>
		     	<c:if test="<%=searchCondPJ01 %>">  [通常]</c:if>  
   			<c:if test="<%=searchCondPJ02 %>"> [国家PJ]</c:if>  
	</span>	  	     	
		</td>	    
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">支払</td>			
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">検収月<br>受付日</td>	
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">請求金額</td>	
		<td  width=""  class="title_list_all_bold" colspan="3">
			<table width="100%" 　cellpadding="0" cellspacing="0" >
				<tr  align=center height=20>	
					<td  align="center" colspan="3" class="line_gray_bottom">ORMS</td>				
				</tr>
				<tr  align=center height=20>	
					<td width="50%" class="line_gray_right">受領確認</td>					
					<td width="50%" >
						<table width="100%" 　cellpadding="0" cellspacing="0" >
							<tr  align=center height=20>	
								<td width="20%"><input type="checkbox" name="postGetAll[]" value="postGet" onFocus="this.blur();" onClick="javascript:allchkedSend(3);"></td>
								<td width="80%">郵送</td>
							</tr>
						</table>										
					</td>
				</tr>		
			</table>	
		</td>		
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">担当者</td>			
		<td  width=""  class="title_list_all_bold">
			<table width="100%" 　cellpadding="0" cellspacing="0" >
				<tr  align=center height=20>	
					<td  align="center" colspan="2" class="line_gray_bottom">東京( OT宇津木 )</td>				
				</tr>
				<tr  align=center height=20>	
					<td width="50%" class="line_gray_right">
						<table width="100%" 　cellpadding="0" cellspacing="0" >
							<tr  align=center height=20>	
								<td width="20%"><input type="checkbox" name="tokyogetAll[]" value="tokyoget" onFocus="this.blur();" onClick="javascript:allchkedSend(4);"></td>
								<td width="80%">受領確認</td>
							</tr>
						</table>									
					</td>
					<td width="50%" >
						<table width="100%" 　cellpadding="0" cellspacing="0" >
							<tr  align=center height=20>	
								<td width="20%"><input type="checkbox" name="tokyoProcessAll[]" value="tokyoProcess" onFocus="this.blur();" onClick="javascript:allchkedSend(5);"></td>
								<td width="80%">処理状態</td>
							</tr>
						</table>				
					</td>
				</tr>		
			</table>	
		</td>		
		<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">コメント</td>	
	<%if(submit_yn.equals("1")){%>									
	    	<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">修正</td>	
    	    	<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1">削除</td>
    	<%}else{%>  	
    	    	<td  width=""  class="title_list_m_r" bgcolor="#F1F1F1"><input type="checkbox" name="chkAll[]" value="chkBoxNmAll" onFocus="this.blur();" onClick="javascript:allchkedSend(1);"> 登録</td>	
	<%}%>
	</tr>	
<c:if test="${empty list}">
			<tr height=29 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
				<td align="center" class="line_gray_b_l_r">-</td>
		<%if(submit_yn.equals("1")){%>	
				<td colspan="12" class="line_gray_bottomnright">データなし</td>
		<%}else{%>
				<td colspan="11" class="line_gray_bottomnright">データなし</td>	
		<%}%>
			</tr>
</c:if>
<c:if test="${! empty list}">			
<%
	int i=1;
		Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			Category dbb=(Category)listiter.next();
			int cseq=dbb.getCseq();											
			if(cseq!=0){
			//	Category dbList=mgrItem.selectMonth(cseq,mgrYM);
			//	if(dbList!=null){												
%>
	<tr height="20" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">		        	   
	    <td  class="line_gray_b_l_r" align="center">
	    	<%if(dbb.getPj_yn()==1){%>通常 <%}%>
		<%if(dbb.getPj_yn()==2){%><font color="red">国家PJ </font><%}%>
	    </td>	
	    <td  class="line_gray_bottomnright"><%=dbb.getClient_nm()%></td>			
	    <td  class="line_gray_bottomnright" align="center">
			<%if(dbb.getPay_type()==1){%>毎月<%}else if(dbb.getPay_type()==2){%>随時<%}%>
	    </td>	 
	    <td  class="line_gray_bottomnright" align="center">		
		<%if(dbb.getPay_kikan()!=null){%><%=dbb.getPay_kikan()%>月<%}else{%>-<%}%><br>
			<font color="#339900"><%=dateFormat.format(dbb.getRegister())%></font>
	    </td>	 
	    <td  class="line_gray_bottomnright" align="right">
	    		<%if(dbb.getPrice()!=0){%><font color="#007AC3"><%=num.format(dbb.getPrice())%></font><%}else{%>-<%}%>
	    </td>	     
	    <td  class="line_gray_bottomnright" align="center" colspan="3">
	    		<table width="100%" 　cellpadding="0" cellspacing="0" >				
				<tr  align=center height="34">	
					<td width="50%" class="line_gray_right">
			<%if(submit_yn.equals("1")){%>	
						<%if(dbb.getReceive_yn_sinsei()==1){%>
							<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value="未確認"  onClick="goReceive('1','<%=dbb.getSeq()%>','receive_yn_sinsei');"　title="直接に変更する">	
						<%}else{%>
							<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="確認完了"  onClick="goReceive('2','<%=dbb.getSeq()%>','receive_yn_sinsei');" title="直接に変更する">		
						<%}%><br>
				    		<%if(dbb.getSinsei_day()!=null){%><font color="#339900"><%=dbb.getSinsei_day()%></font><%}else{%>-<%}%>
			<%}else{%>-<%}%>
					</td>					
					<td width="50%" >
						<table width="100%" 　cellpadding="0" cellspacing="0" >
							<tr  align=center height=20>	
								<td width="20%"><%if(dbb.getReceive_yn_ot()==1){%><input type="checkbox" name="postGet[]" value="<%=dbb.getSeq()%>" onFocus="this.blur();" ><%}else{%>&nbsp;<%}%></td>
								<td width="80%">
			<%if(submit_yn.equals("1")){%>	
									<%if(dbb.getReceive_yn_ot()==1){%>
							    			<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value="未郵送"  onClick="goReceive('1','<%=dbb.getSeq()%>','receive_yn_ot');" title="直接に変更する">   		
							    		<%}else{%>
							    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="郵送完了"  onClick="goReceive('2','<%=dbb.getSeq()%>','receive_yn_ot');" title="直接に変更する">     		
							    		<%}%><br>
				    					<%if(dbb.getPost_send_day()!=null){%><font color="#339900"><%=dbb.getPost_send_day()%></font><%}%>
			<%}else{%>-<%}%>
								</td>
							</tr>
						</table>								
					</td>
				</tr>		
			</table>		    		    		
	    </td>	 
	    	<td  class="line_gray_bottomnright"><%if(dbb.getName()!=null){%><%=dbb.getName()%><%}else{%>-<%}%></td>	 
	    <td  class="line_gray_bottomnright" align="center">
	    		<table width="100%" cellpadding="0" cellspacing="0">
			<tr height="34"  align=center >	
				<td  width="50%"  align="center"  class="line_gray_right">
					<table width="100%" 　cellpadding="0" cellspacing="0" >
							<tr  align=center height=20>	
								<td width="20%"><%if(dbb.getReceive_yn_tokyo()==1){%><input type="checkbox" name="tokyoget[]" value="<%=dbb.getSeq()%>" onFocus="this.blur();" ><%}else{%>&nbsp;<%}%></td>
								<td width="80%">
					<%if(submit_yn.equals("1")){%>
									<%if(dbb.getReceive_yn_tokyo()==1){%>
							    			<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value="未受領"  onClick="goReceive('1','<%=dbb.getSeq()%>','receive_yn_tokyo');" title="直接に変更する">   		
							    		<%}else if(dbb.getReceive_yn_tokyo()==2){%>
							    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="紛失"  onClick="goReceive('2','<%=dbb.getSeq()%>','receive_yn_tokyo');" title="直接に変更する">     		
							    		<%}else if(dbb.getReceive_yn_tokyo()==3){%>
							    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="受領完了"  onClick="goReceive('3','<%=dbb.getSeq()%>','receive_yn_tokyo');" title="直接に変更する">     		
							    		<%}%>
					<%}else{%>-<%}%>
							    	</td>
							</tr>
						</table>	
			      </td>
				<td   width="50%" align="center" >
					<table width="100%" 　cellpadding="0" cellspacing="0" >
							<tr  align=center height=20>	
								<td width="20%"><%if(dbb.getShori_yn()==1){%><input type="checkbox" name="tokyoProcess[]" value="<%=dbb.getSeq()%>" onFocus="this.blur();" ><%}else{%>&nbsp;<%}%></td>
								<td width="80%">
						<%if(submit_yn.equals("1")){%>
									<%if(dbb.getShori_yn()==1){%>	    	
						    				<input type="button"  class="cc22" onfocus="this.blur();" style=cursor:pointer value="未処理"  onClick="goReceive('1','<%=dbb.getSeq()%>','shori_yn');" title="直接に変更する"> 	    			
							    		<%}else{%>
							    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="処理完了"  onClick="goReceive('2','<%=dbb.getSeq()%>','shori_yn');" title="直接に変更する"> 	
							    		<%}%>	
						<%}else{%>-<%}%>	  
							    	</td>
							</tr>
						</table>							
				</td>								
			</tr>			
			</table>		    		    		
	    </td>	 	    
	    <td  class="line_gray_bottomnright" ><%if(dbb.getComment()!=null){%><%=dbb.getComment()%><%}else{%>&nbsp;<%}%></td>	 
<%if(submit_yn.equals("1")){%>
		<td  align="center" class="line_gray_bottomnright" >	    		
	    	<%if(submit_yn.equals("1")){%>
	    		<a href="javascript:goModify('<%=cseq%>','<%=dbb.getSeq()%>');"  onFocus="this.blur()">
				<img src="<%=urlPage2%>images/admin/btn_admin_update.gif" alt="Modify" >
			</a>
		<%}else{%>-<%}%>	
	    </td>	
    	    <td  align="center" class="line_gray_bottomnright">
    	    	<%if(submit_yn.equals("1")){%>
    	    		<a href="javascript:goDelete('<%=dbb.getSeq()%>')"  onfocus="this.blur()">
    	    			<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" title="Cancel">				
			</a>	    	   
		<%}else{%>-<%}%>					
	    </td>
<%}else{%>  									    								
	    <td  align="center" class="line_gray_bottomnright" >	    		
	    		<input type="checkbox" name="chkBoxNmAll[]" value="<%=cseq%>" onFocus="this.blur();" > 
			<a href="javascript:goAdd('<%=cseq%>');"  onFocus="this.blur()">
			<img src="<%=urlPage2%>images/admin/icon_admin_submit.gif" alt="submit" >
			</a>	
	    </td>	 
<%}%>   		
	    		   	    
	</tr>

	
<%
}
i++;	
}
%>	
</c:if>
<%if(submit_yn.equals("1")){%>		
	<tr height="25" bgcolor="#ECFFFB">		    
	    <td  class="line_gray_b_l_r" align="center" colspan="2"><span class="calendar9">一括処理</span></td>	    	       
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center" colspan="3">
	    	<table width="100%" 　cellpadding="0" cellspacing="0" >				
				<tr  align=center height="34">	
					<td width="50%" class="line_gray_right">&nbsp;</td>					
					<td width="50%" ><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="一括郵送"  onClick="goProcess('receive_yn_ot')"></td>
				</tr>		
		</table>		    
	    </td>	 	    
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center">
	    	<table width="100%" cellpadding="0" cellspacing="0">
			<tr height="34"  align=center >	
				<td  width="50%"  align="center"  class="line_gray_right"><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="一括東京受領"  onClick="goProcess('receive_yn_tokyo')"></td>
				<td   width="50%" align="center" ><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="一括東京処理状態"  onClick="goProcess('shori_yn')"></td>								
			</tr>			
		</table>	    
	    </td>	 
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  align="center" class="line_gray_bottomnright">&nbsp;</td>	
    	    <td  align="center" class="line_gray_bottomnright">&nbsp;</td>
	</tr>
<%}else{%>		
	<tr height="25" bgcolor="#ECFFFB">		    
	    <td  class="line_gray_b_l_r" align="center"  colspan="2"><span class="calendar9">一括処理</span></td>	    	       	       
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center" colspan="3">&nbsp;</td>	 	    
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  class="line_gray_bottomnright" align="center">&nbsp;</td>	 
	    <td  align="center" class="line_gray_bottomnright"><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 一括登録 "  onClick="goSendAll()"></td>	    	    
	</tr>	
<%}%>
</form>
</table>
<!-- *****************************page No begin******************************-->			
		<div class="paging_topbg"><p class="mb60  mt7"><div class="pagingHolder module ">				
			<c:set var="count" value="<%= Integer.toString(count) %>" />
			<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
			<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
				<span class="defaultbold ml20">        Page No: </span>				
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
    <input type="hidden" name="cseq" value="">      
    <input type="hidden" name="seq" value="">      
    <input type="hidden" name="pay_item" value="">
    <input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
    <input type="hidden" name="submit_yn" id="submit_yn"  value="<%=submit_yn%>">
    <input type="hidden" name="btn"  id="btn"  value="<%=btn%>">
    <input type="hidden" name="page" value="${currentPage}">
    <input type="hidden" name="kikanval"  id="kikanval"  value="<%=kikanval%>">    	
	<input type="hidden" name="yyVal"  id="yyVal"  value="<%=yyVal%>">	
    	<input type="hidden" name="mmVal" id="mmVal"  value="<%=mmVal%>">							

    <c:if test="<%= searchCond01 %>">
    <input type="hidden" name="search_cond" value="1">
    </c:if>	
    <c:if test="<%= searchCond02 %>">
    <input type="hidden" name="search_cond" value="2">
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
    	<c:if test="<%=searchCondPJ01 %>">
    		<input type="hidden" name="search_radio" value="pj01">
   	</c:if>  
   	<c:if test="<%=searchCondPJ02 %>">
    		<input type="hidden" name="search_radio" value="pj02">
   	</c:if>  
</form>			
<!-- 팝업 start-->				
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->					 
</div>	
<div class="clear_margin"></div>	<div class="clear_margin"></div>	

<script language="javascript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/payment/listForm.jsp";
    document.move.page.value = pageNo;    
    document.move.submit();
}	
function allchkedSend(kind){
	var frm=document.sform;	
	var checkboxList ="";
	var chkBoxName ="";
	if(kind==1){
		checkboxList = document.getElementsByName('chkAll[]'); 
		chkBoxName = document.getElementsByName('chkAll[]'); 	
	}else if(kind==3){
		checkboxList = document.getElementsByName('postGetAll[]'); 
		chkBoxName = document.getElementsByName('postGetAll[]'); 	
	}else if(kind==4){
		checkboxList = document.getElementsByName('tokyogetAll[]'); 
		chkBoxName = document.getElementsByName('tokyogetAll[]'); 	
	}else if(kind==5){
		checkboxList = document.getElementsByName('tokyoProcessAll[]'); 
		chkBoxName = document.getElementsByName('tokyoProcessAll[]'); 	
	}
	 for(var i=0; i<checkboxList.length; i++) { 
		  if(checkboxList[i].checked==true ) { 	  	  	  	 
		  	  allcheck(chkBoxName[i].value); 		  	  
		  }else if(checkboxList[i].checked==false){	  	  
		  	  allclear(chkBoxName[i].value);
		  }
	 }
}

function allcheck(chkBoxNmAll){	
	var checkboxSmall = document.getElementsByName(chkBoxNmAll+'[]'); 
	var chcount=0;
	var i=0;
	
	for(i=0; i< checkboxSmall.length;i++){
		chcount++;
	}

	if(chcount==0){
		checkboxSmall.checked=true;
	}else{
		for(i=0; i<checkboxSmall.length;i++){
			checkboxSmall[i].checked=true;
		}
	}
}	
function allclear(chkBoxNmAll){		
		var checkboxSmall = document.getElementsByName(chkBoxNmAll+'[]'); 
		var chcount=0;
		var i=0;
		for(i=0; i< checkboxSmall.length;i++){
			chcount++;
		}
		if(chcount==0){
			checkboxSmall.checked=false;
		}else{
			for(i=0; i<checkboxSmall.length;i++){
				checkboxSmall[i].checked=false;
			}
		}
}	

function goProcess(kind) {	
	var frm=document.sform;	
	var checkboxSmall = "";
	if(kind=="receive_yn_ot"){
		checkboxSmall = document.getElementsByName('postGet[]'); 		
	}else if(kind=="receive_yn_tokyo"){
		checkboxSmall = document.getElementsByName('tokyoget[]'); 		
	}else if(kind=="shori_yn"){
		checkboxSmall = document.getElementsByName('tokyoProcess[]'); 		
	}
	
	var count=0;	
	
	for(var i=0;i<checkboxSmall.length;i++){
		if(checkboxSmall[i].checked==true){
			count++;
		}
	}
	var countVal=count-1;
	if(kind=="receive_yn_ot"){
		if(count==0){alert("郵送を一個以上チェックしてください。"); return;}	
		if(confirm("("+count+")個のデータを郵送完了しますか?") != 1 ) {return;}	
	}else if(kind=="receive_yn_tokyo"){
		if(count==0){alert("東京(OT宇津木)/ 受領確認を一個以上チェックしてください。"); return;}	
		if(confirm("("+count+")個のデータを受領完了しますか?") != 1 ) {return;}	
	}else if(kind=="shori_yn"){
		if(count==0){alert("東京(OT宇津木)/ 処理状態を一個以上チェックしてください。"); return;}	
		if(confirm("("+count+")個のデータを処理完了しますか?") != 1 ) {return;}	
	}	
	frm.kind.value=kind;					
	frm.page.value=<%=currentPage%>;
	frm.action = "<%=urlPage%>rms/admin/payment/processAll.jsp";	
	frm.submit();	
}	
/*
function goProcessLayer(pgkind){	
	var checkboxSmall = "";
	 if(pgkind=="receive_yn_tokyo"){
		checkboxSmall = document.getElementsByName('tokyoget[]'); 	
	}
	
	var count=0;		
	var seqList="";
	for(var i=0;i<checkboxSmall.length;i++){
		if(checkboxSmall[i].checked==true){
			count++;
			seqList +=checkboxSmall[i].value+";";
		}
	}
	
	var countVal=count-1;
	 if(pgkind=="receive_yn_tokyo"){
		if(count==0){alert("東京(OT宇津木)/ 受領確認を一個以上チェックしてください。"); return;}
	}
			
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;		
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/payment/layer_yn.jsp?pgkind="+pgkind+"&docontact=<%=docontact%>&seqList="+seqList+"&count="+count+"&page=<%=currentPage%>"; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
*/

function goSendAll(){	
	var checkboxSmall = "";
	checkboxSmall = document.getElementsByName('chkBoxNmAll[]'); 				
	var count=0;		
	var seqList="";
	for(var i=0;i<checkboxSmall.length;i++){
		if(checkboxSmall[i].checked==true){
			count++;
			seqList +=checkboxSmall[i].value+";";
		}
	}
	
	var countVal=count-1;
	if(count==0){alert("登録を一個以上チェックしてください。"); return;}				
	
	var docontact=document.move.docontact.value;
	var btn=document.move.btn.value;
	var yyVal=document.move.yyVal.value;
	var mmVal=document.move.mmVal.value;
	var submit_yn=document.move.submit_yn.value;
	var page=document.move.page.value;
	var param = "&seqList="+seqList+"&docontact="+docontact+"&btn="+btn+"&yyVal="+yyVal+"&mmVal="+mmVal+"&submit_yn="+submit_yn+"&page="+page;
	openScrollWin("add_itkathForm_pop.jsp", "請求書手続き", "請求書手続き", "500", "340", param);			
}
function doKind(type){
	var frmkind=document.formn;	
	frmkind.pay_item.value=type;		
	frmkind.action = "<%=urlPage%>rms/admin/payment/addForm.jsp";	
	frmkind.submit();	
}

function goModify(cseq,seq) {		
	var docontact=document.move.docontact.value;
	var btn=document.move.btn.value;
	var yyVal=document.move.yyVal.value;
	var mmVal=document.move.mmVal.value;
	var page=document.move.page.value;
	var param = "&cseq="+cseq+"&seq="+seq+"&docontact="+docontact+"&page="+page+"&btn="+btn+"&yyVal="+yyVal+"&mmVal="+mmVal;
	openNoScrollWin("updateListForm_pop.jsp", "請求書手続き", "請求書手続き", "430", "450", param);	
}
function goDelete(seq) {
	document.move.seq.value=seq;			
	
	if ( confirm("削除しますか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>rms/admin/payment/del_item.jsp";	
    	document.move.submit();
}

function excelDown(){	alert("工事中");	
//	document.move.action = "<%=urlPage%>rms/admin/gmp/listExcel.jsp";	
 //   	document.move.submit();
}
function goAdd(cseq){
	var docontact=document.move.docontact.value; 
	var btn=document.move.btn.value;
	var yyVal=document.move.yyVal.value;
	var mmVal=document.move.mmVal.value;
	var submit_yn=document.move.submit_yn.value;
	var page=document.move.page.value;
	var param = "&cseq="+cseq+"&docontact="+docontact+"&btn="+btn+"&yyVal="+yyVal+"&mmVal="+mmVal+"&submit_yn="+submit_yn+"&page="+page;
	openNoScrollWin("addListForm_pop.jsp", "請求書手続き", "請求書手続き", "430", "340", param);		
}
function goAddAll(){ 
	var docontact=document.move.docontact.value;
	var btn=document.move.btn.value;
	var yyVal=document.move.yyVal.value;
	var mmVal=document.move.mmVal.value;
	var submit_yn=document.move.submit_yn.value;
	var page=document.move.page.value;
	var param = "&docontact="+docontact+"&btn="+btn+"&yyVal="+yyVal+"&mmVal="+mmVal+"&submit_yn="+submit_yn+"&page="+page;
	openNoScrollWin("addListAllForm_pop.jsp", "請求書手続き", "請求書手続き", "430", "340", param);		
}
function doSubmitOnEnter(){
	var frm=document.search2;
	frm.yyVal.value=frm.year_sch.value;
	frm.mmVal.value=frm.menths_sch.value;
	frm.action = "<%=urlPage%>rms/admin/payment/listForm.jsp";	
	frm.submit();
}

function doLine(){
	var frm=document.frmGoLien;
	frm.pgSelect.value=frm.pgSelect_sch.value;		
	frm.action = "<%=urlPage%>rms/admin/payment/listForm.jsp";	
	frm.submit();
}
function doEnter(){
	var frm=document.search;
	frm.docontact.value=frm.search_cond.value;					
	frm.action = "<%=urlPage%>rms/admin/payment/listForm.jsp";	
	frm.submit();
}
function goKata(btn,submit,docontact){		
	var frm=document.search2;
	frm.btn.value=btn;
	frm.docontact.value=docontact;
	frm.submit_yn.value=submit;	
 	frm.action = "<%=urlPage%>rms/admin/payment/listForm.jsp";	
	frm.submit();
}
function goReceive(yn,seq,pgkind){		
	var overlay = document.getElementById('overlay');	
	var btn=document.move.btn.value;
	var yyVal=document.move.yyVal.value;
	var mmVal=document.move.mmVal.value;
	
	//overlay.style.opacity = .8;		
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/payment/layer_on_off.jsp?seq="+seq+"&yn="+yn+"&pgkind="+pgkind+"&docontact=<%=docontact%>&page=<%=currentPage%>"+"&btn="+btn+"&yyVal="+yyVal+"&mmVal="+mmVal; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
</script>

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
