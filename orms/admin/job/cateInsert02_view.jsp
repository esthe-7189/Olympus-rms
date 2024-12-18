<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.job.Category" %>
<%@ page import = "mira.job.CateMgr" %>
<%@ page import=  "mira.job.MgrException" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>

	
<jsp:useBean id="category" class="mira.job.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/orms/";
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
category.setLevel(2);
category.setKind(0);		
	
	manager.insertBoard(category);

%>

<script language="JavaScript">
  location.href = "<%=urlPage%>admin/job/Mgroup.jsp?lgroup=<%=parentId%>&groupId=<%=groupId%>";
</script>
