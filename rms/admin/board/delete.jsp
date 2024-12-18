<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.board.Board" %>
<%@ page import = "mira.board.BoardManager" %>

<jsp:useBean id="board" class="mira.board.Board">
    <jsp:setProperty name="board" property="*" />
</jsp:useBean>
<%
	String urlPage=request.getContextPath()+"/";
	String bseq=request.getParameter("bseq");
	String level=request.getParameter("level");
	String groupId=request.getParameter("groupId");
	String kindboard = request.getParameter("kindboard");	

	BoardManager manager = BoardManager.getInstance();
	Board oldBean = manager.select(Integer.parseInt(bseq));	        
	manager.delete(Integer.parseInt(bseq),Integer.parseInt(level)); 
    
%>

	<script language="JavaScript">
	alert("削除完了");
	location.href = "<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=<%=kindboard%>";
	</script>

