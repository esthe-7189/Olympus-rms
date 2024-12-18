<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

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
String pgkind=request.getParameter("kind");
String docontact=request.getParameter("docontact");
String btn=request.getParameter("btn");
String yyVal=request.getParameter("yyVal");
String mmVal=request.getParameter("mmVal");
//String pagenm=request.getParameter("pagenm"); 
String submit_yn=request.getParameter("submit_yn");
String pageNum=request.getParameter("page");
String post_send_day=dateFormat.format(new java.util.Date());

FileMgr mgr=FileMgr.getInstance();

if(pgkind.equals("receive_yn_ot")){		
	if(request.getParameterValues("postGet[]") !=null){			
	String[] seq=request.getParameterValues("postGet[]"); 

		if(seq.length==1){			
				mgr.shoriYnPost(Integer.parseInt(seq[0]),post_send_day,2); 							  
		}else{
			for(int i=0; i< seq.length; i++){
				mgr.shoriYnPost(Integer.parseInt(seq[i]),post_send_day,2); 	   				
			}
		}
	}
}

if(pgkind.equals("shori_yn")){		
	if(request.getParameterValues("tokyoProcess[]") !=null){			
	String[] seq=request.getParameterValues("tokyoProcess[]"); 

		if(seq.length==1){
				mgr.shoriYn2(Integer.parseInt(seq[0]),2,pgkind); 				  				
		}else{
			for(int i=0; i< seq.length; i++){
				mgr.shoriYn2(Integer.parseInt(seq[i]),2,pgkind); 	   				
			}
		}
	}		
}


if(pgkind.equals("receive_yn_tokyo")){			
	if(request.getParameterValues("tokyoget[]") !=null){			
	String[] seq=request.getParameterValues("tokyoget[]"); 
	
		if(seq.length==1){
				mgr.shoriYn2(Integer.parseInt(seq[0]),3,pgkind); 				  				
		}else{
			for(int i=0; i< seq.length; i++){
				mgr.shoriYn2(Integer.parseInt(seq[i]),3,pgkind); 	   				
			}
		}
	}	
}
	
		
%>

	<script language="JavaScript">
		alert("処理しました");
	  	location.href = "<%=urlPage%>rms/admin/payment/listForm.jsp?docontact=<%=docontact%>&btn=<%=btn%>&yyVal=<%=yyVal%>&mmVal=<%=mmVal%>&page=<%=pageNum%>&submit_yn=<%=submit_yn%>";						  	
	</script>
