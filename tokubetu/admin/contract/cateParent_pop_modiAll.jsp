<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.contract.Category" %>
<%@ page import = "mira.contract.CateMgr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.Timestamp" %>

<%
 request.setCharacterEncoding("utf-8");
 String urlPage=request.getContextPath()+"/";	
 %>
 <jsp:useBean id="category" class="mira.contract.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>
<%

	CateMgr manager=CateMgr.getInstance();			
	String orderNo[]=request.getParameterValues("orderNo");	
	
	if(orderNo.length==1 &&  orderNo!=null){		
		String name=request.getParameter("name");	
		String seq=request.getParameter("seq");															
			manager.updateMCate(Integer.parseInt(orderNo[0]), Integer.parseInt(seq), name);
		
	}else if(orderNo.length>1 &&  orderNo!=null){		
		String name[]=request.getParameterValues("name");	
		String seq[]=request.getParameterValues("seq");	
		for(int i=0;i<orderNo.length;i++){						
			manager.updateMCate(Integer.parseInt(orderNo[i]), Integer.parseInt(seq[i]), name[i]);
		}		
	}
	
	
	
 %>
	<script language="JavaScript">
	alert("完了しました");
	location.href="cateParent_pop.jsp";
	</script>		

	
	