<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.contract.Category" %>
<%@ page import = "mira.contract.CateMgr" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "mira.contract.DownMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.Timestamp" %>

<%
 String urlPage=request.getContextPath()+"/";	
 String id=(String)session.getAttribute("ID");
String seq=request.getParameter("seq");

	CateMgr manager=CateMgr.getInstance();
	ContractMgr manager2=ContractMgr.getInstance();		
	DownMgr manager3=DownMgr.getInstance();
	
				
		
		ContractBeen db=manager2.selectKubun(Integer.parseInt(seq));
	if(db==null){
		manager.deleteMCateSeq(Integer.parseInt(seq));					
 %>
	<script language="JavaScript">
	alert("削除しました");
	location.href="cateParent_pop.jsp";
	</script>			
 <%}else{ %>
 	<script language="JavaScript">
	alert("この契約区分を削除する前、全体目録 にて入力されたデータを先に削除して下さい。");
	opener.location.href="listForm.jsp";
	self.close();
	</script>		
 
 <%}%>