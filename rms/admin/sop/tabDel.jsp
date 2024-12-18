<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>


<jsp:useBean id="pds" class="mira.sop.AccBean">
    <jsp:setProperty name="pds" property="*" />
</jsp:useBean>
	
<%
	String urlPage=request.getContextPath()+"/";		
	String seq_tab=request.getParameter("seq_tab");	
	String stayPg=request.getParameter("stayPg");
	
	int seq_tabInt=Integer.parseInt(seq_tab);	
	int stayPgeInt=Integer.parseInt(stayPg);	
	
	AccMgr manager = AccMgr.getInstance();

	if(seq_tab !=null){		
		manager.deleteTab(seq_tabInt);							
		if(stayPgeInt==1){
%>
		<script language="JavaScript">
			alert("削除しました");
		 	parent.location.href = "<%=urlPage%>rms/admin/sop/listForm.jsp?cate_tab=0";
		</script>		
	
	<%}
	 if(stayPgeInt==2){%>
		<script language="JavaScript">
			alert("削除しました");
		 	parent.location.href = "<%=urlPage%>rms/admin/sop/cateAddForm.jsp";
		</script>

<%}}%>
	
	