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
		<td align="center" class="calendarLarge" colspan="15" style="mso-number-format:\@">GMP管理機器一覧</td>							
	</tr>		
</table>				
<table width="98%" border="1"  >	 	 
	<tr bgcolor="" align=center height=26>	
	    <td  align="center" colspan="11" class="calendar5_03" >機器情報</td>
	    <td  align="center" colspan="3" class="calendar5_03" >機器校正</td>
	    <td  align="center" rowspan="2" class="calendar5_03" >取扱説明書</td>	    	    
	</tr>
	<tr bgcolor=#F1F1F1 align=center height=26>		    
	    <th  align="center" >管理番号</th>	    
	    <th  align="center" >枝番</th>    
	    <th  align="center" >機器名称</th>
	    <th  align="center" >製品名</th>
	    <th  align="center" >製造元</th>
	    <th  align="center" >製造番号</th>
	    <th  align="center" >型番</th>    
	    <th  align="center" >設置場所</th>	
	    <th  align="center" >登録日</th>	
	    <th  align="center" >機器管理責任者</th>		    
	    <th  align="center" >備考</th>	
		<th  align="center" >頻度</th>  
		<th  align="center" >前回実施日</th>
		<th  align="center" >次回実施日</th>				
	</tr>
<c:if test="${empty list}">
				<td colspan="15" style="mso-number-format:\@">no data</td>			
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
	    <td  align="center" style="mso-number-format:\@"><%if(db_item.getEda_no()<10){%>0<%}%><%=db_item.getEda_no()%></td>    
	    <td style="mso-number-format:\@"> <%if(db_item.getGigi_nm()!=null){%><%=db_item.getGigi_nm()%><%}else{%>&nbsp;<%}%>&nbsp;</td>
	    <td style="mso-number-format:\@"><%if(db_item.getProduct_nm()!=null){%><%=db_item.getProduct_nm()%><%}else{%>&nbsp;<%}%></td>
	    <td style="mso-number-format:\@"><%if(db_item.getSeizomoto()!=null){%><%=db_item.getSeizomoto()%><%}else{%>&nbsp;<%}%>   </td>
	    <td  align="center"style="mso-number-format:\@"><%if(db_item.getSeizo_no()!=null){%><%=db_item.getSeizo_no()%><%}else{%>&nbsp;<%}%></td>
	    <td style="mso-number-format:\@"><%if(db_item.getKatachi_no()!=null){%><%=db_item.getKatachi_no()%><%}else{%>&nbsp;<%}%>  </td>    
	    <td style="mso-number-format:\@"><%if(db_item.getPlace()!=null){%><%=db_item.getPlace()%><%}else{%>&nbsp;<%}%> </td>		    
	    <td  align="center" style="mso-number-format:\@"><%=aadd%></td>
	    <td  align="center" style="mso-number-format:\@"><%if(db_item.getSekining_nm()!=null){%><%=db_item.getSekining_nm()%><%}else{%>&nbsp;<%}%> </td>
	    <td  align="center" style="mso-number-format:\@"><%if(db_item.getComment()!=null){%><%=db_item.getComment()%><%}else{%>&nbsp;<%}%> </td>	    		    	    
	    <td  align="center" style="mso-number-format:\@"><%=db_item.getHindo()%></td>  	    
	    <td  style="mso-number-format:\@"><%if(db_item.getDate01()!=null){%><%=db_item.getDate01()%><%}else{%>&nbsp;<%}%> 
	    		<%if(db_item.getDate01_yn()==1  && db_item.getDate01()!=null){%>
			<font color="#FF6600">[未]</font>
			<%}else if(db_item.getDate01_yn()==2 && db_item.getDate01()!=null){%><font color="#007AC3">[完]</font><%}%>
	    </td>
	    <td  style="mso-number-format:\@"><%if(db_item.getDate02()!=null){%><%=db_item.getDate02()%><%}else{%>&nbsp;<%}%> 
	    		<%if(db_item.getDate02_yn()==1 && db_item.getDate02()!=null){%>
			<font color="#FF6600">[未]</a>
			<%}else if(db_item.getDate02_yn()==2 && db_item.getDate02()!=null){%><font color="#007AC3">[完]</font><%}%>
	    </td>
	    <td style="mso-number-format:\@"><%if(!db_item.getFile_manual().equals("no data")){%><%=db_item.getFile_manual()%>
		    <%}else{%>
		    		&nbsp;
		    <%}%>
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
		
	
	
	
