<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.seizo.Category" %>
<%@ page import = "mira.seizo.CommentMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
	
<jsp:useBean id="category" class="mira.seizo.Category">
    <jsp:setProperty name="category" property="*" />
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
String openerPg=request.getParameter("openerPg");
CommentMgr manager = CommentMgr.getInstance();
int bseq=category.getFile_bseq();
int file_kind=category.getFile_kind();


if(category!=null){    	
	category.setRegister(new Timestamp(System.currentTimeMillis()));	
	manager.insertBoard(category);
%>

	<script language="JavaScript">
	  location.href = "<%=urlPage%>rms/admin/seizo/commentList_pop.jsp?file_bseq=<%=bseq%>&file_kind=<%=file_kind%>&openerPg=<%=openerPg%>";
	</script>

<%}else{%>
	<script language="JavaScript">
	alert("登録を失敗しました。");
	  location.href = "<%=urlPage%>rms/admin/seizo/commentList_pop.jsp?file_bseq=<%=bseq%>&file_kind=<%=file_kind%>&openerPg=<%=openerPg%>";
	</script>

<%}%>

<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

