<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="mira.seizo.SeizoBean" %>
<%@ page import="mira.seizo.SeizoMgr" %>
<%@ page import = "java.sql.Timestamp" %>

<jsp:useBean id="pds" class="mira.seizo.SeizoBean">
    <jsp:setProperty name="pds" property="*" />
</jsp:useBean>
<%	
String kindpgkubun=(String)session.getAttribute("KIND");
if(kindpgkubun!=null && ! kindpgkubun.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String fno = request.getParameter("fno");
String file_kind = request.getParameter("file_kind");	
String bseq = request.getParameter("bseq");	
String parentId = request.getParameter("parentId");		

   SeizoMgr mgr = SeizoMgr.getInstance();   
   if(file_kind.equals("2")){
   	mgr.deleteLevel2(Integer.parseInt(fno));
   	mgr.updateHenkoLeve_0(Integer.parseInt(fno),0);
   }else if(file_kind.equals("3")){
   	mgr.deleteLevel3(Integer.parseInt(bseq));
   	mgr.updateHenkoLeve_2(Integer.parseInt(parentId),0);
   }else if(file_kind.equals("4")){
   	mgr.deleteLevel4(Integer.parseInt(bseq));   	
   	mgr.updateHenkoLeve_2(Integer.parseInt(parentId),0);
   }
     
%>
<script language="JavaScript">
alert("ファイルが削除されました");
location.href = "<%=urlPage%>rms/admin/seizo/listForm.jsp";
</script>
