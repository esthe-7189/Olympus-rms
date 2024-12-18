<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hinsithu.Category" %>
<%@ page import = "mira.hinsithu.CateMgr" %>
	
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
String nm=request.getParameter("name"); 

if(nm==null){
	nm="no data";
}
category.setName(nm);	
category.setLevel(1);	
category.setKind(0);	
	CateMgr manager = CateMgr.getInstance();
	manager.insertBoard(category);
%>

<script language="JavaScript">
  location.href = "<%=urlPage%>rms/admin/hinsithu/cate_pop.jsp";
</script>


<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>




