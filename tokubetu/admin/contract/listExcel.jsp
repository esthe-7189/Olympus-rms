<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "mira.contract.DownMgr" %>
<%@ page import = "mira.contract.Category" %>
<%@ page import = "mira.contract.CateMgr" %>
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
	ContractMgr manager=ContractMgr.getInstance();			
	List  list=manager.listExcel();		
	Member memseq=null;   
	int pageArrowCon=0;
	if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin") || id.equals("hamano") || id.equals("funakubo")){ pageArrowCon=1;	}else{pageArrowCon=2;}
	
%>
<c:set var="list" value="<%= list %>" />	
<c:set var="pageArrowCon" value="<%= pageArrowCon %>" />
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
		<td align="center" class="calendarLarge" colspan="12" style="mso-number-format:\@">契約書一覧</td>							
	</tr>		
</table>				
<table width="98%" border="1"  >	 	 	
	<tr bgcolor=#F1F1F1 align=center height=26>		    	    
	    <th  align="center" >管理No.</th>	    
	    <th  align="center" >契約区分</th>	
	　 <th  align="center" >契約形態</th>	    
	    <th  align="center" >契約内容</th>
	    <th  align="center" >タイトル</th>
	    <th  align="center" >契約先</th>
	    <th  align="center" >契約日</th>
	    <th  align="center" >
		<table width=100% 　cellpadding="0" cellspacing="0" border="1">
			<tr bgcolor=#F1F1F1 align=center height=14>	
				<th  align="center"  colspan="2" >契約期間</th>		
			</tr>
			<tr bgcolor=#F1F1F1 align=center height=15>	
				<th  align="center" >開始</th>
				<th  align="center" >終了</th>
			</tr>		
		</table>	
		</th>    
	    <th  align="center" >更新</th>
	    <th  align="center" >担当者</th>	   		
		<th  align="center" >契約書</th>
	</tr>
<c:if test="${empty list}">
				<tr height="25" align="center">
					<th  align="center" >-</th>
					<th  align="center" >-</th>
					<th  align="center" >-</th>
					<th  align="center" >-</th>					
					<th  align="center" >-</th>
					<th  align="center" >-</th>
					<th  align="center" >-</th>
					<th  align="center" >-</th>		
					<th  align="center" >-</th>
					<th  align="center" >-</th>
					<th  align="center" >-</th>	
					<th  align="center" >-</th>		
				</tr>
								
</c:if>
<c:if test="${! empty list}">
<%
int i=1; String conCode=""; int conCodeInt=0; int kubunVal=0;
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		ContractBeen db=(ContractBeen)listiter.next();
		int seq=db.getBseq();
		String aadd=dateFormat.format(db.getRegister());
		int mseqDb=db.getMseq();
		int getLevel=db.getLevel();		
		conCode=db.getKanri_no();       
		kubunVal=db.getKubun_bseq(); 								
		
		if(pageArrowCon==1){	       								
%>										
				
	<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	    
	    <td style="mso-number-format:\@"><%=conCode%></td>	    
	    <td style="mso-number-format:\@"><%=db.getKubun()%></td>	
	    <td  align="center" style="mso-number-format:\@"><%=db.getContract_kind()%></td>    
	    <td style="mso-number-format:\@"> <%=db.getContent()%></td>
	    <td style="mso-number-format:\@"><%if(db.getTitle()!=null){%><%=db.getTitle()%><%}else{%>-<%}%></td>
	    <td style="mso-number-format:\@"><%=db.getContact()%>  </td>
	    <td  align="center"style="mso-number-format:\@"><%=db.getHizuke()%></td>
	    <td>
	    		<table width=100% cellpadding="0" cellspacing="0">
			<tr height=24 bgcolor=#F1F1F1 align=center >	
				<td style="mso-number-format:\@"><font color="#007AC3"><%=db.getDate_begin()%></font></td>
				<td style="mso-number-format:\@"><%=db.getDate_end()%></td>				
			</tr>			
			</table>		    
	    </td>
	    <td style="mso-number-format:\@"><%=db.getRenewal()%> </td>    
	    <td style="mso-number-format:\@"><%if(db.getSekining_nm()!=null){%><%=db.getSekining_nm()%><%}else{%>&nbsp;<%}%> </td>		    	    	    
	    <td style="mso-number-format:\@"><%=db.getFile_nm()%></td>	   
	</tr>
<%}%>
<% if(pageArrowCon==2){%>								
	<% if(kubunVal!=1){%>				
	<tr>	    
	    <td style="mso-number-format:\@"><%=conCode%></td>	    
	    <td style="mso-number-format:\@"><%=db.getKubun()%></td>	
	    <td  align="center" style="mso-number-format:\@"><%=db.getContract_kind()%></td>    
	    <td style="mso-number-format:\@"> <%=db.getContent()%></td>
	    <td style="mso-number-format:\@"><%if(db.getTitle()!=null){%><%=db.getTitle()%><%}else{%>-<%}%></td>
	    <td style="mso-number-format:\@"><%=db.getContact()%>  </td>
	    <td  align="center"style="mso-number-format:\@"><%=db.getHizuke()%></td>
	    <td>
	    		<table width=100% cellpadding="0" cellspacing="0">
			<tr height=24 bgcolor=#F1F1F1 align=center >	
				<td style="mso-number-format:\@"><font color="#007AC3"><%=db.getDate_begin()%></font></td>
				<td style="mso-number-format:\@"><%=db.getDate_end()%></td>				
			</tr>			
			</table>		    
	    </td>
	    <td style="mso-number-format:\@"><%=db.getRenewal()%> </td>    
	    <td style="mso-number-format:\@"><%if(db.getSekining_nm()!=null){%><%=db.getSekining_nm()%><%}else{%>&nbsp;<%}%> </td>		    	    	    
	    <td style="mso-number-format:\@"><%=db.getFile_nm()%></td>
	</tr>			
<% }}		
i++;	
}
%>				
</c:if>
</table>
</body>
</html>
		
	
	
	
