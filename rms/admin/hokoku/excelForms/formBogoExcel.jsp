<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>

<%

String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");

String title= ""; String name=""; String mailadd=""; 
String pass=""; String position=""; String busho="";
int mseq=0; int level=0; int dbPosiLevel=0; 
	

	MemberManager mem = MemberManager.getInstance();	
	Member member=mem.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();
		 mailadd=member.getMail_address();
		 pass=member.getPassword();
		 mseq=member.getMseq();
		 position=member.getPosition();
		 busho=member.getBusho();
		 dbPosiLevel=member.getPosition_level();
	}	

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
    response.setHeader("Content-Disposition", "attachment; filename=olympus-rms.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data"); 


   String urlPage=request.getContextPath()+"/";
	String seq=request.getParameter("fno");
	
	DataMgrTripHokoku manager = DataMgrTripHokoku.getInstance();	
	DataBeanHokoku pdb=manager.getDbPrint(Integer.parseInt(seq));

	Member memSign;
%>
<c:set var="member" value="<%=member%>"/>
<c:set var="pdb" value="<%=pdb%>"/>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 12">
<link rel=File-List href="출장보고서.files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="출장보고서_8980_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font08980
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.font58980
	{color:windowtext;
	font-size:6.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;}
.font68980
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.font78980
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.xl158980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl638980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl648980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl658980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl668980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl678980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl688980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl698980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl708980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl718980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl728980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl738980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl748980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl758980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl768980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl778980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl788980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl798980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl808980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl818980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl828980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl838980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl848980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl858980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl868980
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
ruby
	{ruby-align:left;}
rt
	{color:windowtext;
	font-size:6.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-char-type:katakana;}
.xl6911351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center-across;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7811351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
-->
</style>
</head>

<body>
<div id="출장보고서_8980" align=center x:publishsource="Excel">
<table border=0 cellpadding=0 cellspacing=0 width=648 style='border-collapse: collapse;table-layout:fixed;width:486pt'>
 	<col width=72 span=9 style='width:54pt'> 
 <tr height=23 style='height:17.25pt'>
  	<td height=23 class=xl6911351 align=center width=674 style='height:37.5pt;width:506pt' colspan="9" >出張報告書</td>
 </tr>
 <tr height=28 style='height:28pt'>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl7811351 width=72 style='width:54pt;height:28pt' colspan="3" >オリンパスＲＭＳ株式&#20250;社 </td>
	  
 </tr>	  
<tr height=32 style='height:16.5pt'>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl688980 width=72 style='width:54pt' align="center" height=32 style='height:32pt'><%=pdb.getTitle01()%></td>
	  <td class=xl668980 width=72 style='width:54pt' align="center" height=32 style='border-left:none'><%=pdb.getTitle02()%></td>
	  <td class=xl668980 width=72 style='width:54pt' align="center" height=32 style='border-right:1.0pt solid black; border-left:none'>出張者</td>
 </tr>	 
 <tr height=45 style='height:45pt'>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl698980 width=72 style='width:54pt' align="center" style='height:45pt;border-bottom:1.0pt solid black'>
	 <%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%>&nbsp;<%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%>返還理由:<br><%=pdb.getSign_no_riyu_boss()%> <%}%> 
	<%}}else{%>&nbsp;<%}%>	
	 </td>
	  <td class=xl698980 width=72 style='width:54pt' align="center" style='height:45pt;border-left:none;border-bottom:1.0pt solid black'>
	 <%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%>&nbsp;<%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%>返還理由:<br><%=pdb.getSign_no_riyu_bucho()%><%}%> 
	<%}}else{%>&nbsp;<%}%>		
	  </td>
	  <td class=xl698980 width=72 style='width:54pt' align="center" style='height:45pt;border-right:1.0pt solid black;border-left:none;border-bottom:1.0pt solid black'>
	 <%
		memSign=mem.getDbMseq(pdb.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>&nbsp;		
	<%}}else{%>&nbsp;<%}%>
	  </td>
 </tr>	 
<tr height=10 style='height:10pt'>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
 </tr>	 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl688980 style='height:18.75pt'>出張者氏名</td>
  <td colspan=3 class=xl668980 style='border-left:none'><%=pdb.getNm()%></td>
  <td class=xl638980 style='border-left:none'>所&#23646;</td>
  <td colspan=3 class=xl668980 style='border-right:1.0pt solid black; border-left:none'>
  	  <% if(pdb.getBusho().equals("4")){%>その他<%}%>
	  <% if(pdb.getBusho().equals("0")){%>経営役員<%}%>		
					<% if(pdb.getBusho().equals("1")){%>品質管理部<%}%>
					<% if(pdb.getBusho().equals("2")){%>製造部<%}%>
					<% if(pdb.getBusho().equals("3")){%>管理部<%}%>	
					<% if(pdb.getBusho().equals("no data")){%>その他<%}%>	
  </td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl698980 style='height:18.75pt'>出張先</td>
  <td colspan=7 class=xl718980 style='border-right:1.0pt solid black;border-left:none'><%=pdb.getDestination()%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl698980 style='height:18.75pt'>出張期間</td>
  <td colspan=3 class=xl848980 style='border-left:none'><%=pdb.getDuring_begin()%><span
  style='mso-spacerun:yes'>&nbsp;</span></td>
  <td class=xl658980 style='border-top:none'>~</td>
  <td colspan=3 class=xl658980 style='border-right:1.0pt solid black'><%=pdb.getDuring_end()%><span
  style='mso-spacerun:yes'>&nbsp;</span></td>
 </tr>
 <tr height=72 style='mso-height-source:userset;height:54.0pt'>
  <td colspan=2 height=72 class=xl838980 style='height:54.0pt'>出張目的</td>
  <td colspan=7 class=xl868980 width=504 style='border-right:1.0pt solid black;border-left:none;width:378pt'>
  	  <font class="font78980"><%=pdb.getReason()%></font>
  </td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:23pt'>
  	<td colspan=9 rowspan=26 height=448 class=xl738980 width=648 style='border-right:1.0pt solid black;height:336.0pt;width:486pt'>&#23455;施事項<br>
	    <font class="font78980"><%=pdb.getComment()%></font>
	    <br>
	    <br>
	    <br>
	    <span style='mso-spacerun:yes'>&nbsp;&nbsp; </span><br>
	    <br>
    </td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=9 rowspan=4 height=88 class=xl768980 width=648 style='border-right:
  1.0pt solid black;height:66.0pt;width:486pt'>　</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
 </tr>
 <tr height=22 style='height:16.5pt'>
 </tr>
 <tr height=22 style='height:16.5pt'>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td colspan=6 height=23 class=xl818980 style='height:17.25pt'>　</td>
  <td class=xl648980>添付：</td>
  <td colspan=2 class=xl798980 style='border-right:1.0pt solid black;
  border-left:none'>　</td>
 </tr>
 <tr height=10 style='height:10pt'>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
 </tr>	  
 <tr height=32 style='height:16.5pt'>  	  
	  <td class=xl688980 width=72 style='width:54pt' align="center" height=32 style='height:32pt'>社長</td>	  
	  <td class=xl668980 width=72 style='width:68pt' align="center" height=32 style='border-right:1.0pt solid black; border-left:none'>事業本部長</td>
	  <td class=xl158980 width=72 style='width:40pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
 </tr>	 
 <tr height=45 style='height:45pt'>  	  
	  <td class=xl698980 width=72 style='width:54pt' align="center" style='height:45pt;border-bottom:1.0pt solid black'>
	  <%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%>&nbsp;<%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%>返還理由:<br><%=pdb.getSign_no_riyu_boss()%> <%}%> 
	<%}}else{%>&nbsp;<%}%>		
	 </td>	  
	  <td class=xl698980 width=72 style='width:54pt' align="center" style='height:45pt;border-right:1.0pt solid black;border-left:none;border-bottom:1.0pt solid black'>
	 <%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%>&nbsp;<%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%>返還理由:<br><%=pdb.getSign_no_riyu_bucho()%><%}%> 
	<%}}else{%>&nbsp;<%}%>		
	  </td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
  	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
	  <td class=xl158980 width=72 style='width:54pt'></td>
 </tr>	 
</table>
</div>
</body>
</html>
																