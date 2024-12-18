<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/rms/error/error_admin.jsp"%>	
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.bunsho.BunshoBean" %>
<%@ page import="mira.bunsho.BunshoMgr" %>
<%@ page import="mira.bunsho.MgrException" %>
<%@ page import = "mira.bunsho.Category" %>
<%@ page import = "mira.bunsho.CateMgr" %>
<%@ page import = "mira.bunsho.CommentMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String kindpgkubun=(String)session.getAttribute("KIND");
if(kindpgkubun!=null && ! kindpgkubun.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
    //중요한 사항 : "attachment; filename=excel.xls" 로 적으면 excel.xls 파일이 생성되고 다운로드된다.    
    //모든 HTML은 Excel 파일형식으로 변환됨
     
    response.setHeader("Content-Disposition", "attachment; filename=excel.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data"); 
    
    String urlPage=request.getContextPath()+"/";

	BunshoMgr manager = BunshoMgr.getInstance();	
	CateMgr manager2 = CateMgr.getInstance();			
	List  list=manager.selectListAll();	
	
%>

<c:set var="list" value="<%= list %>" />	
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  >

<table width="95%" border="0">
	<tr><td  align="center" colspan="4"><h2>CHONDRON文書</h2><p></td></tr>
</table>

<c:if test="${empty list}">
	<table width="95%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2  class=c>				
	<tr>
		<td>NO DATA</td>
	</tr>
	</table>
</c:if>
				
<c:if test="${! empty list}">	
<%
	int i=1;			
%>
		
	<%
		Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					BunshoBean pdb=(BunshoBean)listiter.next();
					int or_seq=pdb.getNo();											
					if(or_seq!=0){	
						String aadd=dateFormat.format(pdb.getRegister());					
						String codeA=pdb.getCate_code();
						String codeB=pdb.getCate_code_det();		
						String codeC=pdb.getCate_code_s();							
	%>	

<table width="95%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2  >
				<tr>	
					<td align="right">(NO:<%=or_seq%>)</td>
				</tr>
				<tr>
					<td width="100%" >
						<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>							
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1 width="10%" align="center">大項目:</td>														
								<td style="padding: 5 0 5 0" width="90%" colspan="3">
	    <%Category codeVal1 = manager2.select(Integer.parseInt(codeA));
		if(codeVal1!=null){%>				
			<%=codeVal1.getName()%>
		<%}else{%>											
			No Data
		<%}%>		
								
								
								</td>
							</tr>	
							<tr>							
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1 width="10%" align="center" >中項目:</td>														
								<td style="padding: 5 0 5 0" width="90%" colspan="3">
	<%Category codeVal2 = manager2.select(Integer.parseInt(codeB));
		if(codeVal2!=null){%>				
			<%=codeVal2.getName()%>
		<%}else{%>											
			No Data
		<%}%>	
								</td>
							</tr>	
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1 width="10%" align="center">小項目:</td>														
								<td style="padding: 5 0 5 0" width="90%" colspan="3">
	    <%Category codeVal3 = manager2.select(Integer.parseInt(codeC));
		if(codeVal3!=null){%>				
			<%=codeVal3.getName()%>
		<%}else{%>											
			No Data
		<%}%>		
								
								
								</td>
							</tr>	
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1  align="center" >ファイルのタイトル:</td>
								<td style="padding: 5 0 5 0"  colspan="3"><%=pdb.getF_title()%></td>
							</tr>	
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1  align="center" >韓国原文(SW)</td>
								<td style="padding: 5 0 5 0"  colspan="3"><%=pdb.getFilename()%> &nbsp;<font color="#0066FF">(<%=aadd%>)</font></td>
							</tr>	
							
							
<%BunshoBean kindbun = manager.getKind2(or_seq , 2);%>		
<c:set var="kindbun" value="<%= kindbun %>" />
<c:if test="${! empty  kindbun}" >		
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1  align="center" >翻訳初本(NH)</td>
								<td style="padding: 5 0 5 0"  colspan="3">
<%=kindbun.getFilename()%>&nbsp;<font color="#0066FF">(<%=dateFormat.format(kindbun.getRegister())%>)</font>								
								</td>
							</tr>		
</c:if>

								
<%BunshoBean kindbun2 = manager.getKind2(or_seq , 3);%>		
<c:set var="kindbun2" value="<%= kindbun2 %>" />
<c:if test="${! empty  kindbun2}" >	
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1  align="center" >PG完成本(PG)</td>
								<td style="padding: 5 0 5 0"  colspan="3">
<%=kindbun2.getFilename()%>&nbsp;<font color="#0066FF">(<%=dateFormat.format(kindbun2.getRegister())%>)</font>							
								</td>
							</tr>		
</c:if>

							
<%BunshoBean kindbun3 = manager.getKind2(or_seq , 4);%>		
<c:set var="kindbun3" value="<%= kindbun3 %>" />
<c:if test="${! empty  kindbun3}" >		
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1  align="center" >ORMS最終本(OR)</td>
								<td style="padding: 5 0 5 0"  colspan="3">
<%=kindbun3.getFilename()%>&nbsp; <font color="#0066FF">(<%=dateFormat.format(kindbun3.getRegister())%>)</font>						
								</td>
							</tr>			    
</c:if>
																					
							<tr>	
								<td style="padding: 5 0 5 0" width="10%" rowspan="3" bgcolor=#F1F1F1  align="center">保管:</td>
								<td style="padding: 5 0 5 0" width="40%">場所:<%=pdb.getBasho()%></td>
								<td style="padding: 5 0 5 0" width="10%" rowspan="3" bgcolor=#F1F1F1  align="center">責任者:</td>
								<td style="padding: 5 0 5 0" width="40%">名前:<%=pdb.getFname()%></td>
							</tr>
							
							<tr>
								<td style="padding: 5 0 5 0">デジタル:<%=pdb.getBasho_digi()%></td>
								<td style="padding: 5 0 5 0">デジタル:<%=pdb.getFname_digi()%> </td>
							</tr>
							<tr>
								<td style="padding: 5 0 5 0">文書: <%=pdb.getBasho_bun()%></td>
								<td style="padding: 5 0 5 0">文書:<%=pdb.getFname_bun()%></td>
							</tr>	
							<tr>	
								<td style="padding: 5 0 5 0" bgcolor=#F1F1F1 width="10%" align="center" >備考:</td>							
								<td style="padding: 5 0 5 0" width="90%" colspan="3"><%=pdb.getContent()%></td>
							</tr>	
						</table>
					</td>
				</tr>					
			</table>		
 <table width=100% border=0 cellspacing=0 cellpadding=0 >	
	<tr><td background="<%=urlPage%>rms/image/dot_line_all.gif" style="padding: 3 5 3 5"></td>	</tr>
</table>	
<%	}
i++;	
}
%>		
</c:if>

</body>
</html>
<!-- *****************************page No start******************************-->		

		
