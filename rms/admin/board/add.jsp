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
String kindboard = request.getParameter("kindboard");	
   board.setRegister(new Timestamp(System.currentTimeMillis()));     
   BoardManager manager = BoardManager.getInstance();    
   if(board.getContent()==null){
   	   board.setContent("No Data");
    }
   manager.insertBoard(board);
%>

<script language="JavaScript">
alert("登録済み");
location.href = "<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=<%=kindboard%>";
</script>
