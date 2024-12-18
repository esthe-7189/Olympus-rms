<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
	
<jsp:useBean id="pds" class="mira.payment.Category" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	
String urlPage=request.getContextPath()+"/";
String seq=request.getParameter("seq");
String yn=request.getParameter("yn");
String data_yn=request.getParameter("data_yn");
String pgkind=request.getParameter("pgkind");
String docontact=request.getParameter("docontact");
String btn=request.getParameter("btn");
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");
String pageNum=request.getParameter("page");
if(pageNum==null){pageNum="1";}
String update_day=dateFormat.format(new java.util.Date());

	
	FileMgr mgr=FileMgr.getInstance();	
	
	if(pgkind.equals("receive_yn_sinsei")){
		mgr.shoriYnReceive(Integer.parseInt(seq),update_day,Integer.parseInt(data_yn)); 
	}else if(pgkind.equals("receive_yn_ot")){		
		mgr.shoriYnPost(Integer.parseInt(seq),update_day,Integer.parseInt(data_yn)); 
	}else if(pgkind.equals("receive_yn_tokyo")){
		mgr.shoriYn2(Integer.parseInt(seq),Integer.parseInt(data_yn),pgkind); 
	}else if(pgkind.equals("shori_yn")){
		mgr.shoriYn2(Integer.parseInt(seq),Integer.parseInt(data_yn),pgkind); 
	}
	
%>

	<script language="JavaScript">
		alert("処理しました");
		parent.location.href="<%=urlPage%>rms/admin/payment/listForm.jsp?docontact=<%=docontact%>&btn=<%=btn%>&yyVal=<%=yyVal%>&mmVal=<%=mmVal%>&page=<%=pageNum%>";			
	</script>