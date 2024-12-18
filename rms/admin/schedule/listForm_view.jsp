<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>

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
String boxSizeW = "118";  String boxSizeH = "85";

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
 	String name=""; String title=""; String endYMD; int fellowCnt=0;
 
%>
	

<style type="text/css">	input.calendar { behavior:url(calendarMoveList.htc); } </style>
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
<div id="boxCalendar"  >
			
<table width="100%">				
<form name="calform" >	
	<tr><td width="40%" align="left">	
	<img src="<%=urlPage%>rms/image/admin/bul_title02.gif" align="absmiddle">:一日
	<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">:開始日
	<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">:終了日
	<img src="<%=urlPage%>rms/image/admin/icon_jangyo_01.gif" align="absmiddle">:残業申請	
	</td>
	<td width="20%" align="left" class="calendarTMD">
<a href="<%=urlPage%>rms/admin/schedule/listForm.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=0"><img src="<%=urlPage%>rms/image/admin/btn_calendar_ridou_01.gif" ></a>
&nbsp;
<%=cal.get(cal.YEAR)%>年<%=getDateName (cal.get(cal.MONTH))%>月
&nbsp;
<a href="<%=urlPage%>rms/admin/schedule/listForm.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=1"><img src="<%=urlPage%>rms/image/admin/btn_calendar_ridou_02.gif" ></a>
</td>
<td width="40%" align="left" >	
	<div  class="f_left" style="padding:2px;background:#ffffff;margin:0px 0px 0px 0px;">				
				  <select name="year_sch" class="select_type3" >
				  	  <option value="0" >0000</option>
	<%	for(int i=2009;i<=cal.get(cal.YEAR)+7;i++){%>
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
<div class="boxCalendar_80">
<table width="100%"  class="box_100_line" cellspacing="2" cellpadding="2"  >
	<tbody >
		<tr bgcolor=#F1F1F1 align=center height=22  >	        			
		    <td  class="clear_dot" width="10%">曜日 </td>
		    <td  class="clear_dot" width="15%">日付 </td>
		    <td  class="clear_dot" width="70%">タイトル     /      氏名 </td>    		
		    <td  class="clear_dot" width="5%">ww</td>    
  </tr>
	<form name="calform" >			
<%
//'Calendar loop
	int currDay;
	String todayColor;
	int count = 1;
	int dispDay = 1;	
	for (int w = 1; w < 7; w++){
%>
  	
<% 
  		for (int d = 1; d < 8; d++){
			if (! (count >= cal.get(c.DAY_OF_WEEK))){ 

%>
				<tr height="20" >	
					<td align="center" class="calendar17" >
	<%switch(d){
						case 1:
					%>
							日
					<%   	
							break;
						case 2:
					%>
							月
					<%
							break;
						case 3:
					%>
							火
					<%
							break;
						case 4:
					%>
							水
					<%   	
							break;
						case 5:
					%>
							木
					<%
							break;
						case 6:
					%>
							金
					<%
							break;
						case 7:
					%>
							土
					<%
							break;
						default:
					%>
							日
					<%}%>		
					</td>
				    <td class="clear_dot_gray">&nbsp;</td>    
				    <td class="clear_dot_gray">&nbsp;</td>	
				    <td class="clear_dot_gray">&nbsp;</td>			   			
<%	count += 1;
	} 
			else
			{
				if (isDate ( currMonth + 1, dispDay, currYear) ) // use the isDate method
				{ 
					if ( dispDay == c.get(c.DAY_OF_MONTH) && c.get(c.MONTH) == cal.get(cal.MONTH) && c.get(c.YEAR) == cal.get(cal.YEAR)) // Here we check to see if the current day is today
        				{
							todayColor = "#E9FEEA";
						}
						else
						{
							todayColor = "";
						}
%> 
		<tr height="20"   onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
			<td align="center"  bgcolor="<%=todayColor%>"  class="clear_dot">
	
					<%switch(d){
						case 1:
					%>
						<font color="red">日</font>
					<%   	
							break;
						case 2:
					%>
							月
					<%
							break;
						case 3:
					%>
							火
					<%
							break;
						case 4:
					%>
							水
					<%   	
							break;
						case 5:
					%>
							木
					<%
							break;
						case 6:
					%>
							金
					<%
							break;
						case 7:
					%>
							<font color="#007AC3">土</font>
					<%
							break;
						default:
					%>
							<font color="red">日</font>
					<%}%>			
				
			</td>	
			<td  align="center"   bgcolor="<%=todayColor%>"  class="clear_dot">	
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
	
	
	if(beanHori !=null && beanHori2 ==null){
		yyHori=Integer.parseInt(beanHori.getDuring_begin().substring(0,4)); 
		mmHori=Integer.parseInt(beanHori.getDuring_begin().substring(5,7)); 
		ddHori=Integer.parseInt(beanHori.getDuring_begin().substring(8,10)); 
		if(cal.get(cal.YEAR)==yyHori && cal.get(cal.MONTH)==mmHori-1 && dispDay==ddHori ){%>
			<font color="red"><%=dispDay%></font>
			<font color="#808000"><%=beanHori.getTitle()%>&nbsp;</font>
		<%}else{%><%=dispDay%><%}
								
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
			<%}else{%><%=dispDay%><%}%>			 
<%}%>	
</td>	
<td class="clear_dot" style="padding:0px 0px 0px 3px;" align="left"  bgcolor="<%=todayColor%>" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','list','<%=currMonth+1%>','<%=currYear%>');">
<%
List list=mgr.listSchedule(ymdList);
%>
<c:set var="list" value="<%= list %>" />	
<c:if test="${! empty list}">	
<%
	int i=1;
		Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					DataBean dbbean=(DataBean)listiter.next();
					int seq=dbbean.getSeq();
					int viewCnt=dbbean.getView_seq();
					ydata=Integer.parseInt(dbbean.getDuring_begin().substring(0,4));
					mdata=Integer.parseInt(dbbean.getDuring_begin().substring(5,7));
					ddata=Integer.parseInt(dbbean.getDuring_begin().substring(8,10));
					name=dbbean.getNm().trim();
					title=dbbean.getTitle();		
					
					ydataEnd=Integer.parseInt(dbbean.getDuring_end().substring(0,4));
					mdataEnd=Integer.parseInt(dbbean.getDuring_end().substring(5,7));
					ddataEnd=Integer.parseInt(dbbean.getDuring_end().substring(8,10));
					endYMD=dbbean.getDuring_end();		
					List listFellow=mgr.listFel_Name(seq);									
if(cal.get(cal.YEAR)==ydata && cal.get(cal.MONTH)==mdata-1 && dispDay==ddata){
	if(ddata==ddataEnd){
%> 		
		<a class="topnav" href="javascript:FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','list','<%=currMonth+1%>','<%=currYear%>');" style="cursor:pointer;"  onfocus="this.blur()">
		<div class="topnav"  title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','list','<%=currMonth+1%>','<%=currYear%>');">		
			<%if(viewCnt==0){%><img src="<%=urlPage%>rms/image/icon_s.gif"><%}%>
			<%if(viewCnt==1){%><img src="<%=urlPage%>rms/image/admin/icon_taikin_schdule.gif" align="absmiddle"><%}%>
			<%if(viewCnt==2){%><img src="<%=urlPage%>rms/image/admin/icon_jangyo_01.gif" align="absmiddle"><%}%>	
			<%if(viewCnt==3 || viewCnt==4 || viewCnt==5){%><img src="<%=urlPage%>rms/image/admin/icon_hokoku.gif" align="absmiddle"><%}%>	
			<%=title%>
		<font color="#007AC3"><%=name%></font><font color="#999900"><%int ifel=1;Iterator listiterFel=listFellow.iterator();while (listiterFel.hasNext()){DataBean dbb=(DataBean)listiterFel.next();
		int mseqint=dbb.getSeq();if(mseqint!=0){%>/<a href="mailto:${dbb.mail_address}?subject=Hello!!" title="<%=dbb.getNm()%>様にメールを送る"><%=dbb.getNm().substring(0,1)%></a><%}ifel++;}%></font>&nbsp;&nbsp;&nbsp;
		</div></a>
		<input type="hidden" name="divPass" value="popup_<%=seq%>">
	<%}else{%> 					

		<a class="topnav" href="javascript:FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','list','<%=currMonth+1%>','<%=currYear%>');" style="cursor:pointer;"  onfocus="this.blur()">
		<div class="topnav"   title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq%>','list','<%=currMonth+1%>','<%=currYear%>');">									
			<%if(viewCnt==0){%><img src="<%=urlPage%>rms/image/icon_s.gif">
			<%}else if(viewCnt==1){%><img src="<%=urlPage%>rms/image/admin/icon_taikin_schdule.gif" align="absmiddle">
			<%}else if(viewCnt==2){%><img src="<%=urlPage%>rms/image/admin/icon_jangyo_01.gif" align="absmiddle">
			<%}else if(viewCnt==3 || viewCnt==4 || viewCnt==5){%><img src="<%=urlPage%>rms/image/admin/icon_hokoku.gif" align="absmiddle"><%}%>									
		<img src="<%=urlPage%>rms/image/admin/icon_cal_begin.gif" align="absmiddle">
		<%=title%>&nbsp;<font color="#007AC3"><%=name%></font><font color="#999900"><%int ifel=1;Iterator listiterFel=listFellow.iterator();while (listiterFel.hasNext()){DataBean dbb=(DataBean)listiterFel.next();
		int mseqint=dbb.getSeq();if(mseqint!=0){%>/<a href="mailto:${dbb.mail_address}?subject=Hello!!" title="<%=dbb.getNm()%>様にメールを送る"><%=dbb.getNm().substring(0,1)%></a><%}ifel++;}%></font><font color="#CC66FF">(<%=dbbean.getDuring_end()%>まで)</font>
		</div>
		</a>
		<input type="hidden" name="divPass" value="popup_<%=seq%>">							
	
<%	
		}
	}
i++;	
}
%>	
	
</c:if>
<%
List list2=mgr.listScheduleEnd(ymdList);
%>
<c:set var="list2" value="<%= list2 %>" />	
<c:if test="${! empty list2}">	
<%
	int ii=1;
		Iterator listiter2=list2.iterator();					
				while (listiter2.hasNext()){
					DataBean dbbean2=(DataBean)listiter2.next();
					int seq2=dbbean2.getSeq();					
					name=dbbean2.getNm();
					title=dbbean2.getTitle();
					int viewCnt=dbbean2.getView_seq();		
					ddata=Integer.parseInt(dbbean2.getDuring_begin().substring(8,10));
					ydataEnd=Integer.parseInt(dbbean2.getDuring_end().substring(0,4));
					mdataEnd=Integer.parseInt(dbbean2.getDuring_end().substring(5,7));
					ddataEnd=Integer.parseInt(dbbean2.getDuring_end().substring(8,10));		
					List listFellow=mgr.listFel_Name(seq2);										
					if(cal.get(cal.YEAR)==ydataEnd && cal.get(cal.MONTH)==mdataEnd-1 && dispDay==ddataEnd){
						if(ddata!=ddataEnd){					
		%> 			
<a class="topnav" href="javascript:FuncDetailPopupSeq('<%=ymdList%>','<%=seq2%>','list','<%=currMonth+1%>','<%=currYear%>');" style="cursor:pointer;" onfocus="this.blur()">
<div class="topnav"   title="<%=title%>(<%=name%>)" onclick="FuncDetailPopupSeq('<%=ymdList%>','<%=seq2%>','list','<%=currMonth+1%>','<%=currYear%>');">					
	<%if(viewCnt==0){%><img src="<%=urlPage%>rms/image/icon_s.gif">
	<%}else if(viewCnt==1){%><img src="<%=urlPage%>rms/image/admin/icon_taikin_schdule.gif" align="absmiddle">
	<%}else if(viewCnt==2){%><img src="<%=urlPage%>rms/image/admin/icon_jangyo_01.gif" align="absmiddle">
	<%}else if(viewCnt==3 || viewCnt==4 || viewCnt==5){%><img src="<%=urlPage%>rms/image/admin/icon_hokoku.gif" align="absmiddle"><%}%>
<img src="<%=urlPage%>rms/image/admin/icon_cal_end.gif" align="absmiddle">
<%=title%>
&nbsp;
<font color="#007AC3"><%=name%></font><font color="#999900"><%int ifel=1;Iterator listiterFel=listFellow.iterator();while (listiterFel.hasNext()){DataBean dbb=(DataBean)listiterFel.next();
int mseqint=dbb.getSeq();if(mseqint!=0){%>/<a href="mailto:${dbb.mail_address}?subject=Hello!!" title="<%=dbb.getNm()%>様にメールを送る"><%=dbb.getNm().substring(0,1)%></a><%}ifel++;}%></font>&nbsp;<font color="#CC66FF">(終了)</font>

				
<%					}
					}
		
	ii++;	
}

%>	
</c:if>
			&nbsp;
			</td>
			<td class="clear_dot"  bgcolor="<%=todayColor%>" onclick="prdListView_pop_open('<%=cal.get(cal.YEAR)%>','<%=getDateName (cal.get(cal.MONTH))%>','<%=dispDay%>','list','<%=currMonth+1%>','<%=currYear%>');"><img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif" align="absmiddle" alt="書く"  title="書く"> </td>
										
	</tr>																	
<%
					count += 1;
					dispDay += 1;
				}
				else
				{
%>
		
		
<%
				} 
			}

       } 
%>
  	</tr> 
  	
<% 
}
%>		

</form>
</tbody>
</table>
	</div>
</div>	  
<!-- 팝업 start-->				
		<div id="layerpop"  onclick="javascritp:pop_detail_click_close();">
		<iframe  name="iframe_inner"  width="640" height="100%" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
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

	location.href ="<%=urlPage%>rms/admin/schedule/listForm.jsp?month="+im_sMonth+"&year="+im_sYear+"&action=0";
}
</script>