<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CommentMgr" %>
<%@ page errorPage="/rms/error/error_view.jsp"%>

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
	String pass=request.getParameter("pass");
	String bseq=request.getParameter("bseq");		
	String file_bseq=request.getParameter("file_bseq");		

	CommentMgr manager = CommentMgr.getInstance();
	int chValue=manager.checkPass(Integer.parseInt(bseq),pass);
		
	if(chValue ==1){		
	%>
		<script language="JavaScript">		
		location.href = "<%=urlPage%>rms/admin/hinsithu/commentLead_pop.jsp?pg=Lead&file_bseq=<%=file_bseq%>&bseq=<%=bseq%>";
		</script>

	<%}else if(chValue ==0){%>		
			<script language=javascript>
				alert("パスワードが正しくありません。");
				history.go(-1);
			</script>
		
	<%}else if(chValue ==-1){%>
			<script language=javascript>
				alert("パスワードに一致するユーザが存在しません。");
				history.go(-1);
			</script>
	<%}%>
