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
	String content=request.getParameter("content");
	String kindboard = request.getParameter("kindboard");	
if(board.getContent()!=null){		

	BoardManager manager = BoardManager.getInstance();
	Board oldBean= manager.select(board.getBseq());		
	manager.update(board);  
	%>
		<script language="JavaScript">
		alert("修正完了 ");
		location.href = "<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=<%=kindboard%>";
		</script>
<%}else{%>
		<script language=javascript>
			alert("内容を書いて下さい");
			history.go(-1);
		</script>

<%}%>

