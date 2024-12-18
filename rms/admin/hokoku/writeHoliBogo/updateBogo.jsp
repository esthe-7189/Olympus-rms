<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
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

	DataMgrHoliHokoku manager = DataMgrHoliHokoku.getInstance();
		kintai.setSign_ok_yn_boss(kintai.getSign_ok_yn_boss());
		kintai.setSign_ok_yn_bucho(kintai.getSign_ok_yn_bucho());	
		kintai.setSign_ok_yn_bucho2(kintai.getSign_ok_yn_bucho2());	
		kintai.setSign_ok_yn_kanribu(kintai.getSign_ok_yn_kanribu());	
		kintai.setSign_ok_mseq_boss(kintai.getSign_ok_mseq_boss());
		kintai.setSign_ok_mseq_bucho(kintai.getSign_ok_mseq_bucho());
		kintai.setSign_ok_mseq_bucho2(kintai.getSign_ok_mseq_bucho2());
		kintai.setSign_ok_mseq_kanribu(kintai.getSign_ok_mseq_kanribu());
		kintai.setTheday(kintai.getTheday());
		kintai.setComment(kintai.getComment());				
		kintai.setReason(reason);			
		kintai.setRest_begin_hh(kintai.getRest_begin_hh());
		kintai.setRest_begin_mm(kintai.getRest_begin_mm());
		kintai.setRest_end_hh(kintai.getRest_end_hh());
		kintai.setRest_end_mm(kintai.getRest_end_mm());
		kintai.setPlan_begin_hh(kintai.getPlan_begin_hh());
		kintai.setPlan_begin_mm(kintai.getPlan_begin_mm());
		kintai.setPlan_end_hh(kintai.getPlan_end_hh());
		kintai.setPlan_end_mm(kintai.getPlan_end_mm());		
		kintai.setSign_no_riyu_boss(kintai.getSign_no_riyu_boss());
		kintai.setSign_no_riyu_bucho(kintai.getSign_no_riyu_bucho());
		kintai.setSign_no_riyu_bucho2(kintai.getSign_no_riyu_bucho2());
		kintai.setSign_no_riyu_kanribu(kintai.getSign_no_riyu_kanribu());
		kintai.setSeq(Integer.parseInt(seq));							
	manager.updateBogo(kintai);		
		
%>
	<script language="JavaScript">
		alert("修正完了!!");
	  	location.href = "<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp";		
	</script>

	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>