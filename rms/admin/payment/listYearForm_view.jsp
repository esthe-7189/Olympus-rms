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
static int PAGE_SIZE=15; 
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
		cal.add(cal.DATE,+7);	Date curTime7=cal.getTime();wdate=dateFormat.format(curTime7);
		
		Calendar cal2=new GregorianCalendar();
		cal2.setTime(trialTime);
		cal2.add(cal2.MONTH,+1);	Date curTime30=cal2.getTime();mdate=dateFormat.format(curTime30);
		cal2.add(cal2.MONTH,+5);	Date curTime6=cal2.getTime();sixmdate=dateFormat.format(curTime6);
		
		Calendar cal3=new GregorianCalendar();
		cal3.setTime(trialTime);
		cal3.add(cal3.YEAR,+1);	Date curTime12=cal3.getTime();yeardate=dateFormat.format(curTime12);
	String inDate=dateFormat.format(new java.util.Date());
	String bunDay=inDate.substring(0,4);
	int bunDayInt=Integer.parseInt(bunDay)+1;

	String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	
    	
	String docontact=request.getParameter("docontact");
	if(docontact==null){docontact="1";}
	
	String yyVal=request.getParameter("yyVal");	
	String mgrYM=inDate.substring(0,7);
	String mgrYyyy=inDate.substring(0,4);
	String mgrMmmm=inDate.substring(5,7);
	if(yyVal !=null){
		mgrYM=yyVal;		
	}else{yyVal=mgrYyyy;}
	int mgrYyyyInt=Integer.parseInt(mgrYyyy);
	int yyyData=Integer.parseInt(mgrYyyy)+3;
	int mgrMmmmInt=Integer.parseInt(mgrMmmm);
	
	
	List whereCond = null;
	Map whereValue = null;

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	CateMgr manager=CateMgr.getInstance();		
	int count = manager.countYear(Integer.parseInt(docontact),whereCond, whereValue);	
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
	List  list=manager.selectListYear(Integer.parseInt(docontact),whereCond, whereValue,startRow,endRow);
	FileMgr mgrItem=FileMgr.getInstance();		
	List list01=manager.listClient(1);
	List list02=manager.listClient(2);
%>
<c:set var="list" value="<%= list %>" />	
<c:set var="list01" value="<%= list01%>" />	
<c:set var="list02" value="<%= list02%>" />	

<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">請求書手続き管理 <font color="#A2A2A2">></font> 年別リスト</span>
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 月別リスト " onClick="location.href='<%=urlPage%>rms/admin/payment/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 年別リスト " onClick="location.href='<%=urlPage%>rms/admin/payment/listYearForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 取引先登録及び管理 " onClick="location.href='<%=urlPage%>rms/admin/payment/addForm.jsp'">			
</div>
<div id="boxNoLineBig"  >	
	<!--
<table width="98%">
		<tr>					
			<td width="20%" align="left">  			
    		<font color="#CC0000">※</font>Excel<a href="javascript:excelDown()" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle" title="ダウンロードをする"></a>
    		<input type="submit" class="cc" onClick="excelExplain();" onfocus="this.blur();" style=cursor:pointer value="方法を見る">						    		
			</td>	
		</tr>
</table>		
-->
<table width="98%" border="0">
	<form name="search2"  action="<%=urlPage%>rms/admin/payment/listYearForm.jsp" method="post">			
	<input type="hidden" name="yyVal"  id="yyVal"value="">		
	<input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
		<tr>		
			<td width="30%" align="left" style="padding-top:10px;" >				
		<%if(docontact.equals("1")){%>
				<input type="button"  class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="毎月支払い分のリスト" onClick="goKata('1');"><input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="随時支払い分のリスト" onClick="goKata('2');">	
		<%}else{%>
				<input type="button"  class="cctopmenu2" onfocus="this.blur();" style=cursor:pointer value="毎月支払い分のリスト" onClick="goKata('1');"><input type="button"  class="cctopmenu" onfocus="this.blur();" style=cursor:pointer value="随時支払い分のリスト" onClick="goKata('2');">		
		<%}%>					
							
			</td>
			<td width="15%" align="right"  class="calendar5_01">
		<%if(yyVal==null){%><%=mgrYyyy%> <%}%>
		<%if(yyVal!=null){%><%=yyVal%><%}%> 年					
			</td>
			<td width="25%" align="left"  >
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
				  <select name="year_sch" class="select_type3"  onChange="return doSubmitOnEnter();">
				  	  <option value="0" >0000</option>
				<%for(int i=2009;i<=yyyData;i++){%>					
						<option value="<%=i%>" ><%=i%></option>					 
				<%}%>																			
				  </select>年 
			</div>			
			</td>
			<td width="30%" align="right">  			
    				&nbsp;			    		
			</td>	
		</tr>
		<input type="hidden" size="12%" name='yymmMove' class=calendarkin value="" style="text-align:center">	
	</form>		
</table>	
							
<table width="98%"  cellpadding="0" cellspacing="0" >	 	  
<form name="sform">
	<tr bgcolor="#F1F1F1" align=center height=29>	  	    	
		<td  width=""  class="title_list_m_r">支払周期</td>	    
	     	<td  width=""  class="title_list_m_r">取引先</td>	    
		<td  width=""  class="title_list_m_r">1月</td>	
		<td  width=""  class="title_list_m_r">2月</td>	
		<td  width=""  class="title_list_m_r">3月</td>	
		<td  width=""  class="title_list_m_r">4月</td>	
		<td  width=""  class="title_list_m_r">5月</td>	
		<td  width=""  class="title_list_m_r">6月</td>
		<td  width=""  class="title_list_m_r">7月</td>	
		<td  width=""  class="title_list_m_r">8月</td>	
		<td  width=""  class="title_list_m_r">9月</td>	
	    	<td  width=""  class="title_list_m_r">10月</td>	
    	    	<td  width=""  class="title_list_m_r">11月</td>
    	　　 <td  width=""  class="title_list_m_r">12月</td>
	</tr>
<c:if test="${empty list}">
			<tr height=20 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
				<td align="center" class="line_gray_b_l_r">-</td>
				<td colspan="13" class="line_gray_bottomnright">登録された内容がありません。</td>
			</tr>
</c:if>
<c:if test="${! empty list}">			
<%
	int i=1; String yydata="";
		Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			Category dbb=(Category)listiter.next();
			int cseq=dbb.getCseq();	
			int seq=dbb.getSeq();											
			if(yyVal==null){
				yydata=mgrYyyy;
			}else if(yyVal!=null){
				yydata=yyVal;
			}
			if(cseq!=0){																							
%>
	<tr height=20 >	
	    <td  align="center" class="line_gray_b_l_r" ><%if(dbb.getPay_type()==1){%>毎月<%}else if(dbb.getPay_type()==2){%>随時<%}%></td>	    
	    <td  class="line_gray_bottomnright"><%=dbb.getClient_nm()%></td>	    
	    <td  class="line_gray_bottomnright" align=""> 
<%Category dbList1=mgrItem.selectMonthYear(seq,yydata,"01");	
	if(dbList1!=null){
%>	    	
		    	<%if(dbList1.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList1.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList1.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	    							
	    </td>	 
	    <td  class="line_gray_bottomnright" >
<%Category dbList2=mgrItem.selectMonthYear(seq,yydata,"02");	
	if(dbList2!=null){
%>	    	
		    	<%if(dbList2.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList2.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList2.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >
<%Category dbList3=mgrItem.selectMonthYear(seq,yydata,"03");	
	if(dbList3!=null){
%>	    	
		    	<%if(dbList3.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList3.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList3.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList4=mgrItem.selectMonthYear(seq,yydata,"04");	
	if(dbList4!=null){
%>	    	
		    	<%if(dbList4.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList4.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList4.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList5=mgrItem.selectMonthYear(seq,yydata,"05");	
	if(dbList5!=null){
%>	    	
		    	<%if(dbList5.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList5.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList5.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList6=mgrItem.selectMonthYear(seq,yydata,"06");	
	if(dbList6!=null){
%>	    	
		    	<%if(dbList6.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList6.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList6.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList7=mgrItem.selectMonthYear(seq,yydata,"07");	
	if(dbList7!=null){
%>	    	
		    	<%if(dbList7.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList7.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList7.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList8=mgrItem.selectMonthYear(seq,yydata,"08");	
	if(dbList8!=null){
%>	    	
		    	<%if(dbList8.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList8.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList8.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList9=mgrItem.selectMonthYear(seq,yydata,"09");	
	if(dbList9!=null){
%>	    	
		    	<%if(dbList9.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList9.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList9.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList10=mgrItem.selectMonthYear(seq,yydata,"10");	
	if(dbList10!=null){
%>	    	
		    	<%if(dbList10.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList10.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList10.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList11=mgrItem.selectMonthYear(seq,yydata,"11");	
	if(dbList11!=null){
%>	    	
		    	<%if(dbList11.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList11.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList11.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	    <td  class="line_gray_bottomnright" >	    		
<%Category dbList12=mgrItem.selectMonthYear(seq,yydata,"12");	
	if(dbList12!=null){
%>	    	
		    	<%if(dbList12.getReceive_yn_sinsei()==1){%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#CC0000">No</font>	
			<%}else{%>
				<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> 請求書受領-<font color="#007AC3">完了</font>		
			<%}%>
		<br>		
			<%if(dbList12.getReceive_yn_ot()==1){%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#CC0000">No</font>				
		    	<%}else{%>
		    		<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#CC6600">郵送</font>-<font color="#007AC3">完了</font>		     		
		    	<%}%>
	     <br>
	    		<%if(dbList12.getShori_yn()==1){%>	    	
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#CC0000">No</font>		
	    		<%}else{%>
	    			<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle"> <font color="#339900">処理</font>-<font color="#007AC3">完了</font>		
	    		<%}%>
	<%}else{%>-<%}%>	
	    </td>	 
	</tr>
<%
}
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
    <input type="hidden" name="cseq" value="">      
    <input type="hidden" name="seq" value="">      
    <input type="hidden" name="pay_item" value="">
    <input type="hidden" name="docontact"  id="docontact"  value="<%=docontact%>">
    <input type="hidden" name="yyVal"  id="yyVal"value="<%=yyVal%>">			
    <input type="hidden" name="page" value="${currentPage}">
</form>			
				 
</div>	
<div class="clear_margin"></div>	<div class="clear_margin"></div>	

<script language="javascript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/payment/listYearForm.jsp";
    document.move.page.value = pageNo;    
    document.move.submit();
}


function excelDown(){	alert("工事中");	
//	document.move.action = "<%=urlPage%>rms/admin/gmp/listExcel.jsp";	
 //   	document.move.submit();
}

function doSubmitOnEnter(){
	var frm=document.search2;
	frm.yyVal.value=frm.year_sch.value;
//	frm.mmVal.value=frm.menths_sch.value;
	frm.action = "<%=urlPage%>rms/admin/payment/listYearForm.jsp";	
	frm.submit();
}

function goKata(type){	
    	location.href="<%=urlPage%>rms/admin/payment/listYearForm.jsp?docontact="+type;	    
}

</script>

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
