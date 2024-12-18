<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>

<jsp:useBean id="schedule" class="mira.schedule.DataBean">
    <jsp:setProperty name="schedule" property="*" />
</jsp:useBean>	

<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>	
<%	
String urlPage=request.getContextPath()+"/";
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String inDate=dateFormat.format(new java.util.Date());	


if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
}


// Global Vars
int action = 0;  // incoming request for moving calendar up(1) down(0) for month
int currYear = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
int currMonth = 0; // same as year

//build 2 calendars
Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();

	if (request.getParameter("action") == null) // Check to see if we should set the year and month to the current
	{
		currMonth = c.get(c.MONTH);
		currYear = c.get(c.YEAR);
		cal.set(currYear, currMonth,1);
	}

	else
	{
		if (!(request.getParameter("action") == null)) // Hove the calendar up or down in this if block
		{
			currMonth = Integer.parseInt(request.getParameter("month"));
			currYear = Integer.parseInt(request.getParameter("year"));

				if (Integer.parseInt( request.getParameter("action")) == 1 )
				{
					cal.set(currYear, currMonth, 1);
					cal.add(cal.MONTH, 1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}
				else
				{
					cal.set(currYear, currMonth ,1);
					cal.add(cal.MONTH, -1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}
		}
	} 
%>

<%!
    public boolean isDate(int m, int d, int y) // This method is used to check for a VALID date
    {
        m -= 1;
        Calendar c = Calendar.getInstance();
        c.setLenient(false);

        try{
                c.set(y,m,d);
                Date dt = c.getTime();
        }
          catch (IllegalArgumentException e){
                return false;

        }
                return true;
    }
%>
<%!
   public String getDateName (int monthNumber) // This method is used to quickly return the proper name of a month
   {
		String strReturn = "";
		switch (monthNumber)
		{ 
	case 0:
		strReturn = "01";
		break;
	case 1:
		strReturn = "02";
		break;
	case 2:
		strReturn = "03";
		break;
	case 3:
		strReturn = "04";
		break;
	case 4:
		strReturn = "05";
		break;
	case 5:
		strReturn = "06";
		break;
	case 6:
		strReturn = "07";
		break;
	case 7:
		strReturn = "08";
		break;
	case 8:
		strReturn = "09";
		break;
	case 9:
		strReturn = "10";
		break;
	case 10:
		strReturn = "11";
		break;
	case 11:
		strReturn = "12";
		break;
	}
	return strReturn;
    }
    
    DataMgr mgr = DataMgr.getInstance();	    
 	int ydataEnd=0; int mdataEnd=0;int ddataEnd=0; int ydata=0; int mdata=0;int ddata=0;
 	String name=""; String title=""; int fellowCnt=0; 	
%>

<%
String hizukeMove=request.getParameter("hizuke");
if(hizukeMove==null){hizukeMove="no";}	
%>
	

<%
Calendar afterYear = Calendar.getInstance();       	   								
afterYear.add(afterYear.YEAR, +10);
String yearAfter   = Integer.toString(afterYear.get(Calendar.YEAR));	
%>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script>
$(function() {
   $("#hizuke").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: true, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", 
    yearRange: 'c-10:c+10',showAnim: "slide" } );         
    });    
    //numberOfMonths: [2,3]  
</script>
<style type="text/css">	
	/*input.calendar { behavior:url(calendarMove.htc); } */
	a:link    {text-decoration: none; color: #ffffff;}
	a:active  {text-decoration: none; color: #ffffff;}
	a:visited {text-decoration: none; color: #ffffff;}
	a:hover   {text-decoration: none ; color:#ffffff;}	
</style>	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">日程管理（スケジュール）</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="リスト" onClick="location.href='<%=urlPage%>rms/admin/schedule/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="カレンダー" onClick="location.href='<%=urlPage%>rms/admin/schedule/monthForm.jsp'">		
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="祝日・休日設定" onClick="location.href='<%=urlPage%>rms/admin/schedule/horiForm.jsp'">		
</div>
<div id="boxNoLine_977"  >		
<table width="100%">				
<form name="calform" >	
	<tr><td width="40%" align="left">	
	<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">:一日
	<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">:開始日
	<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">:終了日
	<img src="<%=urlPage%>rms/image/admin/icon_jangyo_01.gif" align="absmiddle">:残業申請	
<!--	<img src="<%=urlPage%>rms/image/admin/icon_hokoku.gif" align="absmiddle"> : 申請/報告-->
	</td>
	<td width="20%" align="left" class="calendarTMD">
<a href="<%=urlPage%>rms/admin/schedule/monthForm.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=0"><img src="<%=urlPage%>rms/image/admin/btn_calendar_ridou_01.gif" ></a>
&nbsp;
<%=cal.get(cal.YEAR)%>年<%=getDateName (cal.get(cal.MONTH))%>月
&nbsp;
<a href="<%=urlPage%>rms/admin/schedule/monthForm.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=1"><img src="<%=urlPage%>rms/image/admin/btn_calendar_ridou_02.gif" ></a>
</td>
<td width="40%" align="left" >	
		<div  class="f_left" style="padding:2px;background:#ffffff;margin:0px 0px 0px 0px;">				
				  <select name="year_sch" class="select_type3" >
				  	  <option value="0" >0000</option>
	<%	for(int i=2009;i<=cal.get(cal.YEAR);i++){%>
					<%if(i==cal.get(cal.YEAR)){%>
						<option value="<%=i%>"  selected><%=i%></option>
					 <%}else{%> 			            							
						<option value="<%=i%>"  ><%=i%></option>
					<%}%>
	<%}%>																			
				  </select>年 
			</div>
			<div  class="f_left" style="padding:2px;background:#ffffff;margin:0px 0px 0px 0px;">							
				  <select name="menths_sch" class="select_type3"  onChange="return doSubmitYM();">
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
				  </select>月
			</div>		
		</td>	
</tr>
</table>
<table  width="965" border="0" cellspacing="0" cellpadding="0">
<tbody > 
﻿  <tr>
    	<td  width="140" class='boxCalendar_title'><font color="red">日</font></td>
	<td  width="140" class='boxCalendar_title'>月</td>
	<td  width="140" class='boxCalendar_title'>火</td>
	<td  width="140" class='boxCalendar_title'>水</td>
	<td  width="140" class='boxCalendar_title'>木</td>
	<td  width="140" class='boxCalendar_title'>金</td>
	<td  width="140" class='boxCalendar_title'><font color="#3366FF">土</font></td>			
  </tr>

<%
//'Calendar loop
	int currDay; String todayColor; int count = 1; int dispDay = 1;
	for (int w = 1; w < 7; w++){
%>	
<tr align="left">
	<% 
  		for (int d = 1; d < 8; d++){
			if (! (count >= cal.get(c.DAY_OF_WEEK))){ 
	%>		
     <td width="140" class="boxCalendar_item_empty" >&nbsp; </td>
    <%	count += 1;
	} 
			else	{
				if (isDate ( currMonth + 1, dispDay, currYear) ) 	{ 
					if ( dispDay == c.get(c.DAY_OF_MONTH) && c.get(c.MONTH) == cal.get(cal.MONTH) && c.get(c.YEAR) == cal.get(cal.YEAR)) {
						todayColor = "#E9FEEA";
					}else{
						todayColor = "#ffffff";
					}
%>             
 
 
 <% 	 
//*************************휴일 start***********************
	String ymdList=""; int yyHori=0; int mmHori=0;  int ddHori=0;
	if(dispDay<10){ 
		ymdList=cal.get(cal.YEAR)+"-"+getDateName (cal.get(cal.MONTH))+"-0"+dispDay;
	}else{
		ymdList=cal.get(cal.YEAR)+"-"+getDateName (cal.get(cal.MONTH))+"-"+dispDay;
	}						
		
	String ymdList2="";
	if(dispDay<10){
		ymdList2="0000-"+getDateName (cal.get(cal.MONTH))+"-0"+dispDay;
	}else{
		ymdList2="0000-"+getDateName (cal.get(cal.MONTH))+"-"+dispDay;
	}
	
	DataBean beanHori=mgr.getHoriday(ymdList);
	DataBean beanHori2=mgr.getHoriday(ymdList2);
%>   
    
   		
   <%
   	   //-------------td color	----------------------
	if(beanHori !=null && beanHori2 ==null){
		yyHori=Integer.parseInt(beanHori.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori.getDuring_begin().substring(8,10)); 
		if(cal.get(cal.YEAR)==yyHori && cal.get(cal.MONTH)==mmHori-1 && dispDay==ddHori ){%>			
			<td width="140"  class="boxCalendar_item_holi"  bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">
		<%}else{%>			
			<td width="140" class="boxCalendar_item" bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">   
		<%}
								
	}else if(beanHori ==null && beanHori2 !=null){
		yyHori=Integer.parseInt(beanHori2.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori2.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori2.getDuring_begin().substring(8,10)); 			
			if(cal.get(cal.MONTH)==mmHori-1 && dispDay==ddHori ){%>
				<td width="140" class="boxCalendar_item_holi" bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">				
			<%}else{%>
				<td width="140" class="boxCalendar_item" bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">   			
			<%}
		
	}else if(beanHori !=null && beanHori2 !=null){
		yyHori=Integer.parseInt(beanHori.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori.getDuring_begin().substring(8,10)); 
		if(cal.get(cal.YEAR)==yyHori && cal.get(cal.MONTH)==mmHori-1 && dispDay==ddHori ){%>
			<td width="140" class="boxCalendar_item_holi" bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">				
		<%}else{%>
			<td width="140" class="boxCalendar_item" bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">   
		<%}		
	}else if(beanHori ==null && beanHori2 ==null){		
		yyHori=0; 
		mmHori=0; 
		ddHori=0; 
			 if(d==1 || d==7  || cal.get(cal.MONTH)==1-1 && dispDay==1){%>
			 	 <td width="140" class="boxCalendar_item_holi" bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">
			<%}else if(cal.get(cal.MONTH)==1-1 && dispDay==1){%><td class="boxCalendar_item_holi" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">
			<%}else{%><td width="140" class="boxCalendar_item" bgcolor="<%=todayColor%>" valign="top" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','cal','<%=currMonth+1%>','<%=currYear%>');">   
<%}}
	//-------------td color end	--------------------------------------	
%>			  	 	
    	
<%	
	//------------------------inner text--------------------------------
	if(beanHori !=null && beanHori2 ==null){
		yyHori=Integer.parseInt(beanHori.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori.getDuring_begin().substring(8,10)); 
		if(cal.get(cal.YEAR)==yyHori && cal.get(cal.MONTH)==mmHori-1 && dispDay==ddHori ){%>			
			<font color="red"><%=dispDay%></font>
			<font color="#808000"><%=beanHori.getTitle()%>&nbsp;</font>
		<%}else{%>			
			<%=dispDay%>
		<%}
								
	}else if(beanHori ==null && beanHori2 !=null){
		yyHori=Integer.parseInt(beanHori2.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori2.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori2.getDuring_begin().substring(8,10)); 			
			if(cal.get(cal.MONTH)==mmHori-1 && dispDay==ddHori ){%>
				<font color="red"><%=dispDay%></font>
				<font color="#808000"><%=beanHori2.getTitle()%>&nbsp;</font>							
			<%}else{%><%=dispDay%><%}
		
	}else if(beanHori !=null && beanHori2 !=null){
		yyHori=Integer.parseInt(beanHori.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori.getDuring_begin().substring(8,10)); 
		if(cal.get(cal.YEAR)==yyHori && cal.get(cal.MONTH)==mmHori-1 && dispDay==ddHori ){%>
			<font color="red"><%=dispDay%></font>
			<font color="#808000"><%=beanHori.getTitle()%>&nbsp;</font>						
		<%}else{%><%=dispDay%><%}		
	}else if(beanHori ==null && beanHori2 ==null){		
		yyHori=0; 
		mmHori=0; 
		ddHori=0; 
			 if(d==1 || d==7  || cal.get(cal.MONTH)==1-1 && dispDay==1){%><font color="red"><%=dispDay%></font>
	<%}else if(cal.get(cal.MONTH)==1-1 && dispDay==1){%><font color="red">元旦</font>
	<%}else{%><%=dispDay%>
<%}
	//------------------------inner text  end--------------------------------	
%>			 
	 
<%}	
	
 //스케줄 기간 출력 (오늘날짜, view_seq)
 List listDuring= mgr.getDateDuring(ymdList,0); 						
%>

<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif" align="absmiddle" alt="書く"  title="書く"> 
<br>

<c:set var="listDuring" value="<%=listDuring%>"/>
<c:set var="ymdList" value="<%=ymdList%>"/>
<c:set var="mmmday" value="<%=currMonth+1%>"/>
<c:set var="currYear" value="<%=currYear%>"/>
<c:if test="${!empty listDuring}">

<%
	int i=1; 
		Iterator listiterCol=listDuring.iterator();					
				while (listiterCol.hasNext()){
					DataBean duringdata=(DataBean)listiterCol.next();
					int seq=duringdata.getSeq();				
					ydata=Integer.parseInt(duringdata.getDuring_begin().substring(0,4));
					mdata=Integer.parseInt(duringdata.getDuring_begin().substring(5,7));
					ddata=Integer.parseInt(duringdata.getDuring_begin().substring(8,10));
					name=duringdata.getNm();
					title=duringdata.getTitle();							
					ydataEnd=Integer.parseInt(duringdata.getDuring_end().substring(0,4));
					mdataEnd=Integer.parseInt(duringdata.getDuring_end().substring(5,7));
					ddataEnd=Integer.parseInt(duringdata.getDuring_end().substring(8,10));	
					List listFellowdu=mgr.listFel_Name(seq);
%>
<c:set var="name" value="<%=name%>"/> 
<c:set var="title" value="<%=title%>"/>
<c:set var="listFellowdu" value="<%=listFellowdu%>"/>
<a  href="javascript:FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');" style="cursor:pointer;">					
				
<%if(duringdata.getMember_id().equals("moriyama")){%>	
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>							
				<div class="colorBar_begin" style="background:#2892BC; color:#ffffff; margin-top:0px;"  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style="color:#666666; margin-top:0px;"  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">																
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">					
			<%}%>
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#2892BC; color:#ffffff; margin-top:0px;"  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">	
		<%}else{%>	
			<div class="colorBar_middle" style="background:#2892BC; color:#ffffff; margin-top:0px;"  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">				
		<%}%>
<%}else if(duringdata.getMember_id().equals("juc0318")){%>
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>
			<%if(ddata!=ddataEnd){%>					
				<div class="colorBar_begin" style="background:#CE9000; color:#ffffff; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style="color:#666666; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">	
			<%}%>						
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#CE9000; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
		<%}else{%>
			<div class="colorBar_middle" style="background:#CE9000; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">		
		<%}%>	
<%}else if(duringdata.getMember_id().equals("biofloc")){%>
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>					
				<div class="colorBar_begin" style="background:#FF41A7; color:#ffffff; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style="color:#666666; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">	
			<%}%>										
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#FF41A7; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
		<%}else{%>
			<div class="colorBar_middle" style="background:#FF41A7; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">		
		<%}%>	
<%}else if(duringdata.getMember_id().equals("tachi")){%>
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>					
				<div class="colorBar_begin" style="background:#F0857D; color:#ffffff; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style=" color:#666666; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">		
			<%}%>										
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#F0857D; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
		<%}else{%>
			<div class="colorBar_middle" style="background:#F0857D; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">		
		<%}%>				
<%}else if(duringdata.getMember_id().equals("lin")){%>
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>					
				<div class="colorBar_begin" style="background:#128D3D; color:#ffffff; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style="color:#666666; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">	
			<%}%>											
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#128D3D; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
		<%}else{%>
			<div class="colorBar_middle" style="background:#128D3D; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">		
		<%}%>
<%}else if(duringdata.getMember_id().equals("hazama")){%>
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>					
				<div class="colorBar_begin" style="background:#8328A1; color:#ffffff; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style="color:#666666; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">	
			<%}%>										
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#8328A1; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
		<%}else{%>
			<div class="colorBar_middle" style="background:#8328A1; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">		
		<%}%>
<%}else if(duringdata.getMember_id().equals("funakubo")){%>
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>					
				<div class="colorBar_begin" style="background:#01A79B; color:#ffffff; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style="color:#666666; "  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">		
			<%}%>										
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#01A79B; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
		<%}else{%>
			<div class="colorBar_middle" style="background:#01A79B; color:#ffffff; "  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">		
		<%}%>									
<%}else{%>
		<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>					
				<div class="colorBar_begin" style="background:#DD1E3A; color:#ffffff;"  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
			<%}else{%>
				<div class="colorBar_begin" style="color:#666666;"  title="<%=title%>(<%=name%>) " onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">
				<img src="<%=urlPage%>rms/image/icon_s.gif" align="absmiddle">		
			<%}%>										
		<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
			<div class="colorBar_end" style="background:#DD1E3A; color:#ffffff;"  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
			<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
		<%}else{%>
			<div class="colorBar_middle" style="background:#DD1E3A; color:#ffffff;"  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">	
		<%}%>	
<%}%>		
	<%if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){%>			
			<%if(ddata!=ddataEnd){%>							
				<span class="schenav">
					<c:if test="${fn:length(title)>=10}"> ${fn:substring(title, 0, 10)}</c:if>
					<c:if test="${fn:length(title)<10}"> ${title}</c:if>(${fn:substring(name, 0, 1)})<% int ifel=1;Iterator listiterFel03=listFellowdu.iterator();
							while (listiterFel03.hasNext()){DataBean dbb=(DataBean)listiterFel03.next();	
								int mseqint=dbb.getSeq();if(mseqint!=0){%>/<%=dbb.getNm().substring(0,1)%><%}ifel++;}%>
				</span>
			<%}else{%>
				<span class="topnav">
					<c:if test="${fn:length(title)>=10}"> ${fn:substring(title, 0, 10)}</c:if>
					<c:if test="${fn:length(title)<10}"> ${title}</c:if><font color="#007AC3">(${fn:substring(name, 0, 1)})</font><% int ifel=1;Iterator listiterFel03=listFellowdu.iterator();
							while (listiterFel03.hasNext()){DataBean dbb=(DataBean)listiterFel03.next();	
								int mseqint=dbb.getSeq();if(mseqint!=0){%><font color="#999900">/</font><span class="calendar1_3"><%=dbb.getNm().substring(0,1)%></span><%}ifel++;}%>
				</span>				
			<%}%>
	<%}else if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){%>
				<span class="schenav">
					<%if(!duringdata.getDuring_begin().equals(duringdata.getDuring_end())){%>
						<c:if test="${fn:length(title)>=10}"> ${fn:substring(title, 0, 10)}</c:if><c:if test="${fn:length(title)<10}"> ${title}</c:if>(${fn:substring(name, 0, 1)}) 
					<%}%>	
				</span>	
	<%}%>		
		
	</div></a>		
<%i++;}%>	
</c:if>	
		


<%
List list=mgr.listSchedule(ymdList);
%>	

<c:set var="list" value="<%= list %>" />	
<c:if test="${! empty list}">	
<%
	int i=1; int ifel=0; 	
		Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					DataBean dbbean=(DataBean)listiter.next();
					int seq=dbbean.getSeq();				
					int viewCnt=dbbean.getView_seq();
					ydata=Integer.parseInt(dbbean.getDuring_begin().substring(0,4));
					mdata=Integer.parseInt(dbbean.getDuring_begin().substring(5,7));
					ddata=Integer.parseInt(dbbean.getDuring_begin().substring(8,10));
					name=dbbean.getNm();
					title=dbbean.getTitle();							
					ydataEnd=Integer.parseInt(dbbean.getDuring_end().substring(0,4));
					mdataEnd=Integer.parseInt(dbbean.getDuring_end().substring(5,7));
					ddataEnd=Integer.parseInt(dbbean.getDuring_end().substring(8,10));	
					List listFellow=mgr.listFel_Name(seq);
				
if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata ){	%>		    	
		<!--당일 스케줄 -->				
		<a class="topnav"  href="javascript:FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');" style="cursor:pointer;" onfocus="this.blur()">
			<div   title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','cal','<%=currMonth+1%>','<%=currYear%>');">						
			<%if(viewCnt==1){%>
				<img src="<%=urlPage%>rms/image/admin/icon_taikin_schdule.gif" align="absmiddle">
				<%if(title.length()>10){%><%=title.substring(0,10)%>
				<%}else{%><%=title%><%}%>				
				<font color="#007AC3">(<%=name.substring(0,1)%></font><font color="#999900"><% ifel=1;Iterator listiterFel03=listFellow.iterator();while (listiterFel03.hasNext()){DataBean dbb=(DataBean)listiterFel03.next();
				int mseqint=dbb.getSeq();if(mseqint!=0){%>/<a href="mailto:${dbb.mail_address}?subject=Hello!!" title="<%=dbb.getNm()%>様にメールを送る"><%=dbb.getNm().substring(0,1)%></a><%}ifel++;}%></font>
				<font color="#007AC3">)</font>				
			<%}%>			
			<%if(viewCnt==2){%>
				<img src="<%=urlPage%>rms/image/admin/icon_jangyo_01.gif" align="absmiddle">
				<%if(title.length()>10){%><%=title.substring(0,10)%>
				<%}else{%><%=title%><%}%>
				<font color="#007AC3">(<%=name.substring(0,1)%></font><font color="#999900"><% ifel=1;Iterator listiterFel04=listFellow.iterator();while (listiterFel04.hasNext()){DataBean dbb=(DataBean)listiterFel04.next();
				int mseqint=dbb.getSeq();if(mseqint!=0){%>/<a href="mailto:${dbb.mail_address}?subject=Hello!!" title="<%=dbb.getNm()%>様にメールを送る"><%=dbb.getNm().substring(0,1)%></a><%}ifel++;}%></font>
				<font color="#007AC3">)</font>
			<%}%>
			<%if(viewCnt==3 || viewCnt==4 || viewCnt==5){%>
				<img src="<%=urlPage%>rms/image/admin/icon_hokoku.gif" align="absmiddle">
				<%if(title.length()>10){%><%=title.substring(0,10)%>
				<%}else{%><%=title%><%}%>
				<font color="#007AC3">(<%=name.substring(0,1)%></font><font color="#999900"><% ifel=1;Iterator listiterFel05=listFellow.iterator();while (listiterFel05.hasNext()){DataBean dbb=(DataBean)listiterFel05.next();
				int mseqint=dbb.getSeq();if(mseqint!=0){%>/<a href="mailto:${dbb.mail_address}?subject=Hello!!" title="<%=dbb.getNm()%>様にメールを送る"><%=dbb.getNm().substring(0,1)%></a><%}ifel++;}%></font>
				<font color="#007AC3">)</font>
			<%}%>					
		</div>
		</a>									
			
		
<%		
}
	i++;	
}
%>	
</c:if>	
			
         </td>																																																
<% count += 1;
	    dispDay += 1;
	}else{
%>
		<td class="boxCalendar_item_empty" valign="top" >&nbsp;</td>
<%
				} 
			}

       } 
%>
  	</tr> 
<% 
}
%>		
</tbody>
</form>
</table>
</div>	  
<!-- 팝업 start-->				
		<div id="layerpop"  >
		<iframe  name="iframe_inner" class="nobg" width="640" height="100%" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->				
	</div>  			
</div>
<p><p>

<script language="JavaScript">
function prdListView_pop_open(yVal,mVal,dVal,pg,monthVal,yearVal){
	var dValue="";
	if(dVal.length==1){
		dValue="0"+dVal;
	}else{
		dValue=dVal;
	}	
				
	 if(document.getElementById("layerpop").style.display == 'none'){
		document.getElementById("layerpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/schedule/ZoomDetailPopup.jsp?yVal="+yVal+"&mVal="+mVal+"&dVal="+dValue+"&pg="+pg+"&monthVal="+monthVal+"&yearVal="+yearVal;
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	document.getElementById("layerpop").style.display = "none";
	 }	 	
}
function FuncDetailPopupSeq(ymdList,seq,pg,monthVal,yearVal){	
	 if(document.getElementById("layerpop").style.display == 'none'){
		document.getElementById("layerpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/schedule/ContentDetailSeqPopup.jsp?ymdList="+ymdList+"&seq="+seq+"&pg="+pg+"&monthVal="+monthVal+"&yearVal="+yearVal; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	document.getElementById("layerpop").style.display = "none";
	 }	 	
}


function doSubmitYM(){
	var frm=document.calform;
	var im_sYear=frm.year_sch.value;
	var im_sMonth=frm.menths_sch.value;
		im_sMonth = im_sMonth.length == 1 ? "0" + im_sMonth : im_sMonth;		

	location.href ="<%=urlPage%>rms/admin/schedule/monthForm.jsp?month="+im_sMonth+"&year="+im_sYear+"&action=0";
}
</script>

