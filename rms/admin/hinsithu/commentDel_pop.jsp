<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CommentMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page import="java.net.URLDecoder" %>

	
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
	String bseq=request.getParameter("bseq");
	String level=request.getParameter("level");
	String groupId=request.getParameter("groupId");
	String file_bseq=request.getParameter("file_bseq");
	String file_kind=request.getParameter("file_kind");
	String pass=request.getParameter("pass");	
	
	int bseqInt=Integer.parseInt(bseq);	
	int levelInt=Integer.parseInt(level);		
	int groupIdInt=Integer.parseInt(groupId);		
	
	CommentMgr manager = CommentMgr.getInstance();   
if(bseq !=null){		
	int chValue=manager.checkPass(bseqInt, pass);
	if(chValue ==1){		  		
		manager.delete(bseqInt,levelInt,groupIdInt);	
%>
			<%}else if(chValue ==0){%>		
					<script language=javascript>
						alert("登録されたパスワードではありません。");
						history.go(-1);
					</script>
				
			<%}else if(chValue ==-1){%>
						<script language=javascript>
							alert("存在しないパスワードです。");
							history.go(-1);
						</script>
			<%}%>


		<script language="JavaScript">
		alert("削除しました。");
		location.href = "<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp?file_bseq=<%=file_bseq%>&file_kind=<%=file_kind%>&openerPg=<%=openerPg%>";
		</script>
<%}else{%>
		<script language="JavaScript">
		alert("削除を失敗しました");
		  location.href = "<%=urlPage%>rms/admin/hinsithu/commentList_pop.jsp?file_bseq=<%=file_bseq%>&file_kind=<%=file_kind%>&openerPg=<%=openerPg%>";
		</script>	

<%}%>














	