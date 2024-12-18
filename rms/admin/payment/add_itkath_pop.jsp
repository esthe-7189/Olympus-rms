<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.payment.Category" %>
<%@ page import = "mira.payment.CateMgr" %>
<%@ page import = "mira.payment.FileMgr" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="pds" class="mira.payment.Category" >
	<jsp:setProperty name="pds" property="*"  />
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
//String seqList=request.getParameter("seqList");
String pgkind=request.getParameter("pgkind");
String docontact=request.getParameter("docontact");
String btn=request.getParameter("btn");
String ymd=pds.getSinsei_day();
String yyVal=ymd.substring(0,4);
String mmVal=ymd.substring(5,7);
String pagenm=request.getParameter("pagenm"); 
String submit_yn=request.getParameter("submit_yn");
		
	FileMgr mgr=FileMgr.getInstance();	
	
if(request.getParameterValues("seq")!=null){
	String[] seq=request.getParameterValues("seq");
	String[] pay_kikan=request.getParameterValues("pay_kikan");	
	String[] receive_yn_sinsei=request.getParameterValues("receive_yn_sinsei");
	String[] mseq=request.getParameterValues("mseq");
	String[] comment=request.getParameterValues("comment");
	String[] price=request.getParameterValues("price");
	String[] pj_yn=request.getParameterValues("pj_yn");
	String pay_day=request.getParameter("pay_day");
	String sinsei_day=request.getParameter("sinsei_day");

		if(seq.length==1){
			if(price[0]==""){price[0]="0";}
			
			pds.setRegister(new Timestamp(System.currentTimeMillis()));
			pds.setMseq(Integer.parseInt(mseq[0]));
			pds.setComment(comment[0]);
			pds.setClient(Integer.parseInt(seq[0]));
			pds.setPay_kikan(pay_kikan[0]);
			pds.setPay_day(pay_day);
			pds.setPrice(Integer.parseInt(price[0]));
			pds.setSinsei_day(sinsei_day);
			pds.setReceive_yn_sinsei(2);
			pds.setPost_send_day(null);
			pds.setReceive_yn_ot(1);
			pds.setShori_yn(1);
			pds.setReceive_yn_tokyo(1);
			pds.setPj_yn(Integer.parseInt(pj_yn[0]));			
			mgr.insertFile(pds); 	 				  				
		}else{
			for(int i=0; i< seq.length; i++){
				if(price[i]==""){price[i]="0";}
				
				pds.setRegister(new Timestamp(System.currentTimeMillis()));
				pds.setMseq(Integer.parseInt(mseq[i]));
				pds.setComment(comment[i]);
				pds.setClient(Integer.parseInt(seq[i]));
				pds.setPay_kikan(pay_kikan[i]);
				pds.setPay_day(pay_day);
				pds.setPrice(Integer.parseInt(price[i]));
				pds.setSinsei_day(sinsei_day);
				pds.setReceive_yn_sinsei(2);
				pds.setPost_send_day(null);
				pds.setReceive_yn_ot(1);
				pds.setShori_yn(1);
				pds.setReceive_yn_tokyo(1);
				pds.setPj_yn(Integer.parseInt(pj_yn[i]));				
				mgr.insertFile(pds); 	 			
			}
		} 	 
}
	
	
%>

	<script language="JavaScript">
		alert("処理しました");
		opener.location.href="<%=urlPage%>rms/admin/payment/listForm.jsp?docontact=<%=docontact%>&btn=<%=btn%>&yyVal=<%=yyVal%>&mmVal=<%=mmVal%>&page=<%=pagenm%>&submit_yn=<%=submit_yn%>";				
		self.close();
	</script>