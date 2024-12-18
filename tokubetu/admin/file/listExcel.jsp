<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page import="mira.tokubetu.AccBean" %>
<%@ page import="mira.tokubetu.AccMgr" %>
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

if(kind!=null && ! kind.equals("toku")){
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
	AccMgr manager=AccMgr.getInstance();			
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
	response.setHeader("Content-Disposition", "attachment; filename=olympus-rms.xls"); 
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
		<td align="center" class="calendarLarge" colspan="5" style="mso-number-format:\@">決裁書/契約書文書ファイル一覧</td>							
	</tr>		
</table>				
<table width="98%" border="1"  >	 	 	
	<tr bgcolor=#F1F1F1 align=center height=26>		    	    	
	    <th  align="center" >日付</th>	    
	    <th  align="center" >文書区分</th>	
	　 <th  align="center" >タイトル</th>	    
	    <th  align="center" >ファイル名</th>
	    <th  align="center" >コメント</th>	    
	</tr>
<c:if test="${empty list}">
				<tr height="25" align="center">
					<th  align="center" >-</th>					
					<th  align="center" >-</th>					
					<th  align="center" >-</th>					
					<th  align="center" >-</th>
					<th  align="center" >-</th>						
				</tr>
								
</c:if>
<c:if test="${! empty list}">
<%
int i=1; 
	Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			AccBean pdb=(AccBean)listiter.next();
			int seq=pdb.getSeq();														
			if(seq!=0){	
				String aadd=dateFormat.format(pdb.getRegister());			   	       								
%>										
				
	<tr>	    
		<td style="mso-number-format:\@"  align="center" ><%=aadd%></td>
		<td style="mso-number-format:\@"><%=pdb.getCate_nm()%></td>	
		<td style="mso-number-format:\@"><%=pdb.getTitle()%></td>					
		<td style="mso-number-format:\@">	<%if(pdb.getView_yn()==0){%><%=pdb.getFilename()%> 	<%}else{%>--	<%}%></td>
		<td style="mso-number-format:\@"><%=pdb.getComment()%></td>		
	</tr>			
<% }		
i++;	
}
%>				
</c:if>
</table>
</body>
</html>
		
	
	
	
