<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.info.Category" %>
<%@ page import = "mira.info.CateMgr" %>
<%@ page import=  "mira.info.MgrException" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
	
<jsp:useBean id="category" class="mira.info.Category">
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
category.setLevel(3);
category.setKind(0);	
	manager.insertBoard(category);

%>

<script language="JavaScript">
  location.href = "<%=urlPage%>admin/info/Sgroup.jsp?mgroup=<%=parentId%>&lgroup=<%=groupId%>&selectmg=<%=parentId%>&parentId=<%=parentId%>";
</script>



