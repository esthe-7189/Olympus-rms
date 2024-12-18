<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CommentMgr" %>
<%@ page import = "java.sql.Timestamp" %>
	
<jsp:useBean id="category" class="mira.hinsithu.Category">
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
int file_bseq=category.getFile_bseq();
int file_kind=category.getFile_kind();

CommentMgr manager = CommentMgr.getInstance();
if(category !=null){    			
	manager.update(category);
%>

	<script language="JavaScript">	
	  location.href = "<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp?file_bseq=<%=file_bseq%>&file_kind=<%=file_kind%>&openerPg=<%=openerPg%>";
	</script>

<%}else{%>
	<script language="JavaScript">
	alert("登録を失敗しました。");
	  location.href = "<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp?file_bseq=<%=file_bseq%>&file_kind=<%=file_kind%>&openerPg=<%=openerPg%>";
	</script>

<%}%>


