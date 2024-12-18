<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.sop.Category" %>
<%@ page import = "mira.sop.CateMgr" %>
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
	String bseq=request.getParameter("bseqModi");
	String level=request.getParameter("level");	
	
	int bseqInt=Integer.parseInt(bseq);	
	int levelInt=Integer.parseInt(level);
	
	CateMgr manager = CateMgr.getInstance();
//	AccMgr mgrCateItem = AccMgr.getInstance();        

	if(bseq !=null){		
//		mgrCateItem.deleteCate(seqInt);     //파일, 다운로드 이력 삭제
		manager.delete(bseqInt,levelInt);							

		if(levelInt==1){
%>
		<script language="JavaScript">
		alert("削除しました");
		  location.href = "<%=urlPage%>rms/admin/sop/cateAddForm.jsp";
		</script>		
	
	<%}
	 if(levelInt==2){%>
		<script language="JavaScript">
		alert("削除しました");
		location.href = "<%=urlPage%>rms/admin/sop/Mgroup.jsp?lgroup=<%=bseqInt%>&groupId=<%=bseqInt%>";
		</script>

<%}}%>
		