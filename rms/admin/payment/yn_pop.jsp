<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ page import = "java.sql.Timestamp" %>

	
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
String seqList=request.getParameter("seqList");
String pgkind=request.getParameter("pgkind");
String docontact=request.getParameter("docontact");
String pageNum=request.getParameter("page");
if(pageNum==null){pageNum="1";}
	
	FileMgr mgr=FileMgr.getInstance();	
 if(pgkind.equals("receive_yn_tokyo")){
 	 String data_yn=request.getParameter("data_yn");
 	 String[] seq=seqList.split(";");	
		if(seq.length==1){
				mgr.shoriYn2(Integer.parseInt(seq[0]),Integer.parseInt(data_yn),pgkind); 	 				  				
		}else{
			for(int i=0; i< seq.length; i++){
				mgr.shoriYn2(Integer.parseInt(seq[i]),Integer.parseInt(data_yn),pgkind); 	 		
			}
		} 	 
}
	
%>

	<script language="JavaScript">
		alert("処理しました");
		parent.location.href="<%=urlPage%>rms/admin/payment/listForm.jsp?docontact=<%=docontact%>&page=<%=pageNum%>";						
	</script>