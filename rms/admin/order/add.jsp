<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="order" class="mira.order.BeanOrderBunsho">
    <jsp:setProperty name="order" property="*" />
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

MgrOrderBunsho manager = MgrOrderBunsho.getInstance();

	order.setRegister(new Timestamp(System.currentTimeMillis()));			
	order.setHizuke(order.getHizuke().substring(0,10));	
	manager.insert(order);	

int parent_id=manager.getIdSeq("purchase_order");

String [] product_nm=request.getParameterValues("product_nm");	
if(product_nm.length==1){
	String  order_no=request.getParameter("order_no");	
	String  product_qty=request.getParameter("product_qty");	
	String  unit_price=request.getParameter("unit_price");	
	String  client_nm=request.getParameter("client_nm");	
	
	order.setParent_seq(parent_id);
	order.setProduct_nm(product_nm[0]);
	order.setOrder_no(order_no);
	order.setProduct_qty(Integer.parseInt(product_qty));
	order.setUnit_price(Integer.parseInt(unit_price));
	order.setClient_nm(Integer.parseInt(client_nm));
	order.setDel_yn_item(1);
	manager.insert_item(order);
		
}else if(product_nm.length >1){
	String [] order_no=request.getParameterValues("order_no");	
	String [] product_qty=request.getParameterValues("product_qty");	
	String [] unit_price=request.getParameterValues("unit_price");	
	String [] client_nm=request.getParameterValues("client_nm");	
	
	for(int i=0; i < product_nm.length;i++){
		order.setParent_seq(parent_id);
		order.setProduct_nm(product_nm[i]);
		order.setOrder_no(order_no[i]);
		order.setProduct_qty(Integer.parseInt(product_qty[i]));
		order.setUnit_price(Integer.parseInt(unit_price[i]));
		order.setClient_nm(Integer.parseInt(client_nm[i]));
		order.setDel_yn_item(1);
		manager.insert_item(order);
	}	
}

							
%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	location.href = "<%=urlPage%>rms/admin/order/listForm.jsp";		
	</script>

	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
