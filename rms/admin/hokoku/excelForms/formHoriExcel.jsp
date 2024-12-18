<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
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
	
	DataMgrHoliHokoku manager = DataMgrHoliHokoku.getInstance();	
	DataBeanHokoku pdb=manager.getDbPrint(Integer.parseInt(seq));
	int or_seq=pdb.getSeq();
	int totalHHMM=(pdb.getRest_end_hh()*60+pdb.getRest_end_mm())-(pdb.getRest_begin_hh()*60+pdb.getRest_begin_mm());
	int resultHH=totalHHMM/60;
	int resultMM=totalHHMM%60;	
	int totalHHMM2=(pdb.getPlan_end_hh()*60+pdb.getPlan_end_mm())-(pdb.getPlan_begin_hh()*60+pdb.getPlan_begin_mm());
	int resultHH2=totalHHMM2/60;
	int resultMM2=totalHHMM2%60;						
	String bushoDb=pdb.getBusho();
	
	Member memSign;
%>
<c:set var="member" value="<%=member%>"/>
<c:set var="pdb" value="<%=pdb%>"/>


	
<html>
<head>
<title>OLYMPUS-RMS</title>
	
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 12">

<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .54in;	mso-header-margin:.3in;	mso-footer-margin:.3in;}
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
	mso-char-type:katakana;
	display:none;}
	
tr
	{mso-height-source:auto;
	mso-ruby-visibility:none;}
col
	{mso-width-source:auto;
	mso-ruby-visibility:none;}
br
	{mso-data-placement:same-cell;}
ruby
	{ruby-align:left;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:표준;
	mso-style-id:0;}
.font0
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.font6
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.font7
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.font8
	{color:black;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl65
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	text-align:center;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}

-->
</style>
<![if !supportTabStrip]><script language="JavaScript">
<!--
function fnUpdateTabs()
 {
  if (parent.window.g_iIEVer>=4) {
   if (parent.document.readyState=="complete"
    && parent.frames['frTabs'].document.readyState=="complete")
   parent.fnSetActiveSheet(0);
  else
   window.setTimeout("fnUpdateTabs();",150);
 }
}

if (window.name!="frSheet")
 window.location.replace("../휴가보고서.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]>
</head>

<body link=blue vlink=purple>

<table border=0 cellpadding=0 cellspacing=0 width=630 style='border-collapse: collapse;table-layout:fixed;width:474pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
	 <col width=20 style='mso-width-source:userset;mso-width-alt:800;width:15pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
	 <col width=80 style='mso-width-source:userset;mso-width-alt:2600;width:58pt'>
 <tr height=22 style='height:16.5pt'>
  <td height=22 width=84 style='height:16.5pt;width:63pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=28 style='width:19pt'></td>
  <td width=36 style='width:25pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=9 height=36 class=xl71 width=630 style='height:27.0pt;width:474pt'><font
  class="font8">休日出勤申請書</font><font class="font0"><br>
    </font></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 colspan=7 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 width=248 style='width:186pt'><%=dateFormat.format(pdb.getRegister())%><br></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl81 style='height:23.1pt'>所　&#23646;</td>
  <td colspan=4 class=xl78 style='border-right:.5pt solid black'><font class="font7">
  	  				<% if(bushoDb.equals("4")){%>その他<%}%>
					<% if(bushoDb.equals("0")){%>経営役員<%}%>		
					<% if(bushoDb.equals("1")){%>品質管理部<%}%>
					<% if(bushoDb.equals("2")){%>製造部<%}%>
					<% if(bushoDb.equals("3")){%>管理部<%}%>	
					<% if(bushoDb.equals("no data")){%>その他<%}%></font>
  </td>
  <td class=xl67 style='border-left:none'>氏　名</td>
  <td colspan=3 class=xl78 style='border-right:1.0pt solid black;border-left:
  none'><%=pdb.getNm()%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=9 height=30 class=xl74 style='border-right:1.0pt solid black;
  height:23.1pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>下記の通り休日出勤の申請をします。</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl73 style='height:23.1pt;border-top:none'>月  日</td>
  <td colspan=8 class=xl68 style='border-right:1.0pt solid black'><%=pdb.getTheday()%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl73 style='height:23.1pt;border-top:none'>予定 時間 </td>
  <td colspan=8 class=xl68 style='border-right:1.0pt solid black'>
  	  <%=pdb.getPlan_begin_hh()%>時<%=pdb.getPlan_begin_mm()%>分<font color="#009900">～</font><%=pdb.getPlan_end_hh()%>時<%=pdb.getPlan_end_mm()%>分
					（<%=resultHH2%>時 <%=resultMM2%>分）	
</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl73 style='height:23.1pt;border-top:none'>休憩 時間 </td>
  <td colspan=8 class=xl68 style='border-right:1.0pt solid black'>
  	  <%=pdb.getRest_begin_hh()%>時<%=pdb.getRest_begin_mm()%>分<font color="#009900">～</font><%=pdb.getRest_end_hh()%>時<%=pdb.getRest_end_mm()%>分
					（<%=resultHH%>時 <%=resultMM%>分）	
  	 </td>
 </tr>
 <tr height=72 style='mso-height-source:userset;height:54.0pt'>
  <td height=72 class=xl88 style='height:54.0pt;border-top:none'>業務 内容</td>
  <td colspan=8 class=xl85 width=546 style='border-right:1.0pt solid black;border-left:none;width:411pt'>
  	  <font class="font6"><%=pdb.getComment()%>   </font>
  </td>
 </tr>
 <tr height=72 style='mso-height-source:userset;height:54.0pt'>
  <td height=72 class=xl65 style='height:54.0pt'>申請 理由</td>
  <td colspan=8 class=xl82 width=546 style='border-right:1.0pt solid black;width:411pt'>
  	  <font class="font7"><%=pdb.getReason()%>  </font>
  </td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl94 style='height:8.25pt'>　</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td class=xl95>　</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl66 style='height:16.5pt'>社長</td>
  <td class=xl99 style='border-left:none'>事業本部長</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl66 style='width:411pt'><%=pdb.getTitle01()%></td>
  <td class=xl67 style='border-left:none'><%=pdb.getTitle02()%></td>	  
  <td class=xl67 style='border-left:none'><%=pdb.getTitle03()%></td>
  <td class=xl67 style='border-left:none'><%=pdb.getTitle04()%></td>
  <td class=xl99 style='border-left:none'>申請者</td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl89 style='height:33.75pt;border-top:none'>
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
  <td class=xl90 style='border-top:none;border-left:none'>
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
  <td colspan=2 style='mso-ignore:colspan'></td>  
  <td class=xl89 style='border-top:none'>
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
  <td class=xl92 style='border-top:none;border-left:none'>
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
  	  
  <td class=xl92 style='border-top:none;border-left:none'>
  	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho2() !=0){		
			if(pdb.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho2()==1 ){%>&nbsp;<%}%> 
			<%if(pdb.getSign_ok_yn_bucho2()==3 ){%>返還理由:<br><%=pdb.getSign_no_riyu_bucho2()%><%}%> 
	<%}}else{%>&nbsp;<%}%>	
  </td>
  <td class=xl92 style='border-top:none;border-left:none'>
  	  <%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_kanribu() !=0){		
			if(pdb.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_kanribu()==1 ){%>&nbsp;<%}%> 
			<%if(pdb.getSign_ok_yn_kanribu()==3 ){%>返還理由:<br><%=pdb.getSign_no_riyu_kanribu()%><%}%> 
	<%}}else{%>&nbsp;<%}%>	
  
  </td>
  <td class=xl90 style='border-top:none;border-left:none'>
  	  <%
		memSign=mem.getDbMseq(pdb.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>&nbsp;		
		<%}}else{%>&nbsp;<%}%>	  
  </td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl94 style='height:12.0pt'>　</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td class=xl95>　</td>
 </tr>
 <!-----content end**************************--------->		
<!-----休日出勤報告書 end**************************--------->	
<% 	DataBeanHokoku beanBogo=manager.getDbBogo(Integer.parseInt(seq)); %>
<c:set var="beanBogo" value="<%=beanBogo%>"/>			
<c:if test="${! empty beanBogo}">		
<%	int btotalHHMM=(beanBogo.getRest_end_hh()*60+beanBogo.getRest_end_mm())-(beanBogo.getRest_begin_hh()*60+beanBogo.getRest_begin_mm());
	int bresultHH=btotalHHMM/60;
	int bresultMM=btotalHHMM%60;	
	int btotalHHMM2=(beanBogo.getPlan_end_hh()*60+beanBogo.getPlan_end_mm())-(beanBogo.getPlan_begin_hh()*60+beanBogo.getPlan_begin_mm());
	int bresultHH2=btotalHHMM2/60;
	int bresultMM2=btotalHHMM2%60;

%>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=9 height=39 class=xl96 width=630 style='border-right:1.0pt solid black; height:29.25pt;width:474pt'><font class="font8">休日出勤報告書</font><font
  class="font0"><br>
    </font></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl94 style='height:23.1pt'>　</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 width=248 style='border-right:1.0pt solid black;width:186pt'><%=dateFormat.format(beanBogo.getRegister())%><br></td>
  	 
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=9 height=30 class=xl74 style='border-right:1.0pt solid black;
  height:23.1pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>下記の通り休日出勤の<font class="font7">&#23455;</font><font class="font0">績を報告します。</font></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl93 style='height:23.1pt;border-top:none'>&#23455;績 時間</td>
  <td colspan=8 class=xl68 style='border-right:1.0pt solid black'><%=beanBogo.getPlan_begin_hh()%>時<%=beanBogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>時<%=beanBogo.getPlan_end_mm()%>分
					（<%=bresultHH2%>時 <%=bresultMM2%>分）
  </td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl73 style='height:23.1pt;border-top:none'>休憩 時間</td>
  <td colspan=8 class=xl68 style='border-right:1.0pt solid black'>
  	  <%=beanBogo.getRest_begin_hh()%>時<%=beanBogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>時<%=beanBogo.getRest_end_mm()%>分
					（<%=bresultHH%>時 <%=bresultMM%>分）
  </td>
 </tr>
 <tr height=72 style='mso-height-source:userset;height:54.0pt'>
  <td height=72 class=xl88 style='height:54.0pt;border-top:none'><ruby>業務 &#20869;容</td>
  <td colspan=8 class=xl85 width=546 style='border-right:1.0pt solid black;border-left:none;width:411pt'>
  	  <font class="font6"><%=beanBogo.getComment()%></font></td>
 </tr>
 <tr height=72 style='mso-height-source:userset;height:54.0pt'>
  <td height=72 class=xl65 style='height:54.0pt'>申請 理由</td>
  <td colspan=8 class=xl82 width=546 style='border-right:1.0pt solid black;width:411pt'>
  	  <font class="font7"><%=beanBogo.getReason()%></font></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl94 style='height:8.25pt'>　</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td class=xl95>　</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl66 style='height:16.5pt'>社長</td>
  <td class=xl99 style='border-left:none'>事業本部長</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td width=100 class=xl66 ><%=beanBogo.getTitle01()%></td>
  <td class=xl67 style='border-left:none'><%=beanBogo.getTitle02()%></td>	  
  <td class=xl67 style='border-left:none'><%=beanBogo.getTitle03()%></td>
  <td class=xl67 style='border-left:none'><%=beanBogo.getTitle04()%></td>
  <td class=xl99 style='border-left:none'>申請者</td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl89 style='height:33.75pt;border-top:none'>
  	 <%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%>&nbsp;<%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%>返還理由:<br><%=beanBogo.getSign_no_riyu_boss()%> <%}%> 
	<%}}else{%>&nbsp;<%}%>	
  </td>
  <td class=xl90 style='border-top:none;border-left:none'>
  	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%>&nbsp;<%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%>返還理由:<br><%=beanBogo.getSign_no_riyu_bucho()%><%}%> 
	<%}}else{%>&nbsp;<%}%>	
  </td>  
  <td colspan=2 style='mso-ignore:colspan'></td>  
  <td class=xl89 style='border-top:none'>
  	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%>&nbsp;<%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%>返還理由:<br><%=beanBogo.getSign_no_riyu_boss()%> <%}%> 
	<%}}else{%>&nbsp;<%}%>  
  </td>
  <td class=xl92 style='border-top:none;border-left:none'>
  	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%>&nbsp;<%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%>返還理由:<br><%=beanBogo.getSign_no_riyu_bucho()%><%}%> 
	<%}}else{%>&nbsp;<%}%>	
  </td>
  	  
  <td class=xl92 style='border-top:none;border-left:none'>
  	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
			if(beanBogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho2()==1 ){%>&nbsp;<%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%>返還理由:<br><%=beanBogo.getSign_no_riyu_bucho2()%><%}%> 
	<%}}else{%>&nbsp;<%}%>	
  </td>
  <td class=xl92 style='border-top:none;border-left:none'>
  	  <%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
			if(beanBogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_kanribu()==1 ){%>&nbsp;<%}%> 
			<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%>返還理由:<br><%=beanBogo.getSign_no_riyu_kanribu()%><%}%> 
	<%}}else{%>&nbsp;<%}%>	
  
  </td>
  <td class=xl90 style='border-top:none;border-left:none'>
  	  <%
		memSign=mem.getDbMseq(beanBogo.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>&nbsp;		
		<%}}else{%>&nbsp;<%}%>	  
  </td>
 </tr>  
</c:if>	

<c:if test="${empty beanBogo}">	
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=9 height=39 class=xl96 width=630 style='border-right:1.0pt solid black; height:29.25pt;width:474pt'><font class="font8">休日出勤報告書</font><font
  class="font0"><br>
    </font></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl94 style='height:23.1pt'>　</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 width=248 style='border-right:1.0pt solid black;width:186pt'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=9 height=30 class=xl74 style='border-right:1.0pt solid black;
  height:23.1pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>下記の通り休日出勤の<font class="font7">&#23455;</font><font class="font0">績を報告します。</font></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl93 style='height:23.1pt;border-top:none'>&#23455;績 時間</td>
  <td colspan=8 class=xl68 style='border-right:1.0pt solid black'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl73 style='height:23.1pt;border-top:none'>休憩 時間</td>
  <td colspan=8 class=xl68 style='border-right:1.0pt solid black'></td>
 </tr>
 <tr height=72 style='mso-height-source:userset;height:54.0pt'>
  <td height=72 class=xl88 style='height:54.0pt;border-top:none'><ruby>業務 &#20869;容</td>
  <td colspan=8 class=xl85 width=546 style='border-right:1.0pt solid black;border-left:none;width:411pt'></td>
 </tr>
 <tr height=72 style='mso-height-source:userset;height:54.0pt'>
  <td height=72 class=xl65 style='height:54.0pt'>申請 理由</td>
  <td colspan=8 class=xl82 width=546 style='border-right:1.0pt solid black;width:411pt'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl94 style='height:8.25pt'>　</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td class=xl95>　</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl66 style='height:16.5pt'>社長</td>
  <td class=xl99 style='border-left:none'>事業本部長</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td width=100 class=xl66 ></td>
  <td class=xl67 style='border-left:none'></td>	  
  <td class=xl67 style='border-left:none'></td>
  <td class=xl67 style='border-left:none'></td>
  <td class=xl99 style='border-left:none'>申請者</td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl89 style='height:33.75pt;border-top:none'></td>
  <td class=xl90 style='border-top:none;border-left:none'></td>  
  <td colspan=2 style='mso-ignore:colspan'></td>  
  <td class=xl89 style='border-top:none'></td>
  <td class=xl92 style='border-top:none;border-left:none'></td>
  	  
  <td class=xl92 style='border-top:none;border-left:none'></td>
  <td class=xl92 style='border-top:none;border-left:none'></td>
  <td class=xl90 style='border-top:none;border-left:none'></td>
 </tr> 
 </c:if>
 	 	
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl94 style='height:8.25pt;border-bottom:1.0pt solid black'></td>
  <td colspan=7 style='mso-ignore:colspan;border-bottom:1.0pt solid black'></td>
  <td class=xl95 style='border-bottom:1.0pt solid black'></td>
 </tr>
</table>

</body>

</html>
															