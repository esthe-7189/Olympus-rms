<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="kintai" class="mira.hokoku.DataBeanHokoku">
    <jsp:setProperty name="kintai" property="*" />
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
String reason=request.getParameter("reason");
reason=reason.replaceAll("\r\n","<br>");
reason=reason.replaceAll("\u0020","&nbsp;");

int sign_ok_mseq_boss=0; 
int sign_ok_mseq_bucho=0;
String title01="";
String title02="";

	String [] sign_ok_mseq=request.getParameterValues("sign_ok_mseq");	
	sign_ok_mseq_boss=Integer.parseInt(sign_ok_mseq[0]);
	sign_ok_mseq_bucho=Integer.parseInt(sign_ok_mseq[1]);
	
	String [] title=request.getParameterValues("title");	
	title01=title[0];
	title02=title[1];


DataMgrTripHokoku manager = DataMgrTripHokoku.getInstance();	
	kintai.setRegister(new Timestamp(System.currentTimeMillis()) );
	kintai.setSign_ok_mseq_boss(sign_ok_mseq_boss);	
	kintai.setSign_ok_mseq_bucho(sign_ok_mseq_bucho);
	kintai.setReason(reason);
	kintai.setTitle01(title01);
	kintai.setTitle02(title02);
	manager.insert(kintai);	

		
							
%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	location.href = "<%=urlPage%>rms/admin/hokoku/listTripBogoForm.jsp";		
	</script>

	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

















