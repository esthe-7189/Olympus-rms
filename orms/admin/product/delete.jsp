<%@ page contentType = "text/html; charset=utf8"  %>
<%@ page pageEncoding = "utf-8" %>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>

<%
 String urlPage=request.getContextPath()+"/orms/";	
%>
<jsp:useBean id="product" class="mira.product.ProductBean">
	<jsp:setProperty name="product" property="*" />
</jsp:useBean>

<%
    ProductManager manager=ProductManager.getInstance();
	ProductBean oldBean = manager.getProduct(product.getPseq());
	manager.delete(product.getPseq());
%>
<SCRIPT LANGUAGE="JavaScript">
alert("削除しました");
location.href="<%=urlPage%>admin/product/product.jsp";
</SCRIPT>