<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import=  "com.oreilly.servlet.MultipartRequest" %>
<%@ page import=  "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*"%>
<%
 String urlPage=request.getContextPath()+"/";	
 String id=(String)session.getAttribute("ID");
%>
<jsp:useBean id="category" class="mira.contract.ContractBeen">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
			
	ContractMgr manager=ContractMgr.getInstance();	
 	String seq=request.getParameter("seq");  	
 	String pgkind=request.getParameter("pgkind");  
 	String renewal_yn=request.getParameter("renewal_yn"); 	
 	String mseq=request.getParameter("mseq"); 
 	   	
	manager.dateView(Integer.parseInt(seq),Integer.parseInt(renewal_yn),Integer.parseInt(mseq)); 		
	
	if(pgkind.equals("main")){
 %>
	<SCRIPT LANGUAGE="JavaScript">
	alert("処理しました");
	location.href="<%=urlPage%>tokubetu/admin/admin_main.jsp";
	</SCRIPT>			
 <%}else{%>	
 	<SCRIPT LANGUAGE="JavaScript">
	alert("処理しました");
	location.href="<%=urlPage%>tokubetu/admin/contract/listForm.jsp";
	</SCRIPT>		
 <%}%>