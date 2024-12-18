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

String nm=request.getParameter("nameval"); 
String parentId=request.getParameter("parentIdval");
int groupId=0;

CateMgr manager = CateMgr.getInstance();
Category cate = manager.select(Integer.parseInt(parentId));
	if(cate !=null){
		groupId=cate.getGroupId();
	}	

category.setName(nm);	
category.setGroupId(groupId);	
category.setParentId(Integer.parseInt(parentId));	
category.setLevel(3);
category.setKind(0);	
	manager.insertBoard(category);

%>

<script language="JavaScript">
  location.href = "<%=urlPage%>rms/admin/hinsithu/Sgroup_pop.jsp?mgroup=<%=parentId%>&lgroup=<%=groupId%>&selectmg=<%=parentId%>&parentId=<%=parentId%>";
</script>

<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

