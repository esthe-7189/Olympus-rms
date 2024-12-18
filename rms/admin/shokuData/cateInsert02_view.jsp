<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>


	
<jsp:useBean id="category" class="mira.shokudata.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>


<%
String urlPage=request.getContextPath()+"/";
String nm=request.getParameter("nameval"); 
String parentId=request.getParameter("parentIdval");
String lgroup_no=request.getParameter("lgroup_no");
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
category.setKind(Integer.parseInt(lgroup_no));	
	
	manager.insertBoard(category);

%>

<script language="JavaScript">
  location.href = "<%=urlPage%>rms/admin/shokuData/Mgroup.jsp?lgroup=<%=parentId%>&groupId=<%=groupId%>&lgroup_no=<%=lgroup_no%>";
</script>
