<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "org.apache.poi.*" %>

<%! 
//static int PAGE_SIZE=20; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String kind=(String)session.getAttribute("KIND");
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");

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

	String today=dateFormat.format(new java.util.Date());	
	GmpManager manager=GmpManager.getInstance();			
	List  list=manager.listExcel();		
	
%>
<c:set var="list" value="<%= list %>" />	
<html>
<head>
<title>OLYMPUS-RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="http://olympus-rms.com/rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="http://olympus-rms.com/rms/css/main.css" type="text/css">
<script  src="http://olympus-rms.com/rms/js/common.js" language="JavaScript"></script>
<script  src="http://olympus-rms.com/rms/js/Commonjs.js" language="javascript"></script>	

<%
	response.setHeader("Content-Disposition", "attachment; filename=GMPolympus-rms.xls"); 
    	response.setHeader("Content-Description", "JSP Generated Data"); 	
%>	

<style type="text/css">
	br{mso-data=placement:same-cell;}
</style>
</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('595','860') ;">
<center>	
<table width="98%"  border="0" >
	<tr>
		<td align="center" class="calendarLarge" colspan="7" style="mso-number-format:\@">校正対象設備等一覧 </td>							
	</tr>		
</table>				
<table width="98%" border="1"  >	 	 
	<tr bgcolor="" align=center height=26>		
	    <td  align="center" colspan="4" class="calendar5_03" >設備等情報</td>
	    <td  align="center" colspan="3" class="calendar5_03" >校正</td>	    
	</tr>
	<tr bgcolor=#F1F1F1 align=center height=26>	
	    <th  align="center" >管理番号</th>	    
	    <th  align="center" >設備等名称</th>    
	    <th  align="center" >設置場所</th>
	    <th  align="center" >導入部門</th>
	    <th  align="center" >校正頻度(使用前点検)</th>
	    <th  align="center" >実施日</th>
	    <th  align="center" >実施期限(ステータス)</th>    	    			
	</tr>
<c:if test="${empty list}">
				<td colspan="7" style="mso-number-format:\@">no data</td>			
</c:if>
<c:if test="${! empty list}">
<%
int i=1; 
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		GmpBeen db_item=(GmpBeen)listiter.next();
		int seq=db_item.getBseq();
		String aadd=dateFormat.format(db_item.getRegister());
		int mseqDb=db_item.getMseq();
		int getLevel=db_item.getLevel();
						
%>								
				
	<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	    
	    <td style="mso-number-format:\@"><%=db_item.getKanri_no()%></td>	    	    
	    <td style="mso-number-format:\@"> <%if(db_item.getGigi_nm()!=null){%><%=db_item.getGigi_nm()%><%}else{%>&nbsp;<%}%>&nbsp;</td>
	    <td style="mso-number-format:\@"><%if(db_item.getPlace()!=null){%><%=db_item.getPlace()%><%}else{%>&nbsp;<%}%> </td>	
	    <td style="mso-number-format:\@"><%if(db_item.getSeizomoto()!=null){%><%=db_item.getSeizomoto()%><%}else{%>&nbsp;<%}%>   </td> 	   	    	    	    
	    <td  align="center" style="mso-number-format:\@"><%=db_item.getHindo()%>	    
	    <%if(db_item.getSeizo_no().equals("1")){%><font color="#009900">(Yes)</font><%}else{%><font color="#fd8024">(No)</font> <%}%></td> 
	    <td  style="mso-number-format:\@"><%if(db_item.getDate01()!=null){%><%=db_item.getDate01()%><%}else{%>&nbsp;<%}%>  </td>	 	   
	    <td  style="mso-number-format:\@"><%if(db_item.getDate02()!=null){%><%=db_item.getDate02()%><%}else{%>&nbsp;<%}%> 
	    	<%if(db_item.getEda_no()==1){%>
			<font color="#007AC3">[使用可]</font></a>
			<%}else{%><font color="#FF6600">[使用不可]</font><%}%>
	    </td>	    	    	    
	</tr>
<%
i++;	
}
%>				
</c:if>
</table>
</body>
</html>
		
	
	
	
