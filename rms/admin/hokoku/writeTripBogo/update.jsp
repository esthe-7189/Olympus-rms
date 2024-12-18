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
String seq=request.getParameter("fno");
String reason=request.getParameter("reason");
reason=reason.replaceAll("\r\n","<br>");
reason=reason.replaceAll("\u0020","&nbsp;");

	DataMgrTripHokoku manager = DataMgrTripHokoku.getInstance();
		kintai.setSign_ok_yn_boss(1);
		kintai.setSign_ok_yn_bucho(1);	
		kintai.setSign_ok_mseq_boss(kintai.getSign_ok_mseq_boss());
		kintai.setSign_ok_mseq_bucho(kintai.getSign_ok_mseq_bucho());			
		kintai.setReason(reason);
		kintai.setComment(kintai.getComment());		
		kintai.setDuring_begin(kintai.getDuring_begin());
		kintai.setDuring_end(kintai.getDuring_end());	
		kintai.setSign_no_riyu_boss(kintai.getSign_no_riyu_boss());
		kintai.setSign_no_riyu_bucho(kintai.getSign_no_riyu_bucho());
		kintai.setSeq(Integer.parseInt(seq));						
	manager.update(kintai);	
	manager.deleteRelated(Integer.parseInt(seq));
		
%>
	<script language="JavaScript">
		alert("修正完了!!");
	  	location.href = "<%=urlPage%>rms/admin/hokoku/listTripBogoForm.jsp";		
	</script>

	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>