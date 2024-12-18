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


// Global Vars
int action = 0;  // incoming request for moving calendar up(1) down(0) for month
int currYear = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
int currMonth = 0; // same as year
String boxSizeW = "18";  String boxSizeH = "18";

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
 	String name=""; String title="";
 
%>

	
	
<html>
<head>
<title>OLYMPUS RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>
	
<body  leftmargin="0"  topmargin="0"  marginwidth="0"  marginheight="0"  border="0" align="center" >
<center>
<table id = "table" border="0" cellpadding="0" cellspacing="0"  width="180">
<tr>
<td >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr>		
		<td width="33%" align="right"><a href="<%=urlPage%>rms/admin/admin_main.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=0"><img src="<%=urlPage%>rms/image/admin/btn_calendar_ridou_01.gif" ></a></td>
		<td width="34%"  style="padding:0 0 0 0" align="center">
			<b><%=cal.get(cal.YEAR)%>-<%=getDateName (cal.get(cal.MONTH))%></b>
		</td>
		<td width="33%" align="left"><a href="<%=urlPage%>rms/admin/admin_main.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=1"><img src="<%=urlPage%>rms/image/admin/btn_calendar_ridou_02.gif" ></a></td>		
	</tr>
	</table>
</td>	
</tr>
</table>
<table id = "valueTable" width='180'  height="" border="0" cellpadding="0" cellspacing="0" >
<tr id = "tr" >
<th  class='sch_month_sunday'>日</th>
<th  class='sch_month_weekday'>月</th>
<th  class='sch_month_weekday'>火</th>
<th  class='sch_month_weekday'>水</th>
<th  class='sch_month_weekday'>木</th>
<th  class='sch_month_weekday'>金</th>
<th  class='sch_month_saturday'>土</th>
</tr>
</table>


<table border="1" width='180'  height="" bordercolorlight="#C0C0C0" bordercolordark="#807265" style="border-collapse: collapse" bordercolor="#f4f4f4" cellpadding="0" cellspacing="0" bgcolor="#f4f4f4">
	<form name="calform" >			
<%
//'Calendar loop
	int currDay;
	String todayColor;
	int count = 1;
	int dispDay = 1;
	for (int w = 1; w < 7; w++){
%>
  	<tr>
<% 
  		for (int d = 1; d < 8; d++){
			if (! (count >= cal.get(c.DAY_OF_WEEK))){ 

%>
				<td width="<%=boxSizeW%>" height="<%=boxSizeH%>" valign="top" align="left">&nbsp;</td>
<%	count += 1;
	} 
			else
			{
				if (isDate ( currMonth + 1, dispDay, currYear) ) // use the isDate method
				{ 
					if ( dispDay == c.get(c.DAY_OF_MONTH) && c.get(c.MONTH) == cal.get(cal.MONTH) && c.get(c.YEAR) == cal.get(cal.YEAR)) // Here we check to see if the current day is today
        				{
							todayColor = "#99CC00";
						}
						else
						{
							todayColor = "#ffffff";
						}
%> 
		<td  width="<%=boxSizeW%>" height="<%=boxSizeH%>"  bgcolor="<%=todayColor%>" onMouseEnter="FuncQuickToggle('<%=dispDay%>')" onMouseLeave="FuncQuickToggle('<%=dispDay%>')">	
			<table cellpadding="0" cellspacing="0" border="0" height="100%" width="100%"><tr>
	<td height="" style="padding:0 0 0 3" valign="top" align="left">
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
<%}	

List list=mgr.listSchedule(ymdList);
%>
<c:set var="list" value="<%= list %>" />	
<c:if test="${! empty list}">	
<%
	int i=0;
		Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					DataBean dbbean=(DataBean)listiter.next();					
		
					i++;	
				}%>	
				
				<a class="topnav" href="<%=urlPage%>rms/admin/schedule/monthForm.jsp?month=<%=cal.get(cal.MONTH)+1%>&year=<%=cal.get(cal.YEAR)%>&action=0" onfocus="this.blur();"><font color="#64A219">(<%=i%>)</font></a>

</c:if>


			</td>
			</tr>
			
		</table>
         </td>																																																
<%
					count += 1;
					dispDay += 1;
				}
				else
				{
%>
		<td width="<%=boxSizeW%>" height="<%=boxSizeH%>" valign="top" align="left">&nbsp;</td>
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
</table>
