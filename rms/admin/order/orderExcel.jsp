<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>

<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
NumberFormat numFormat = NumberFormat.getNumberInstance(); 
%>

<%
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String inDate=dateFormat.format(new java.util.Date());
String seq=request.getParameter("seq");

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
 	response.setHeader("Content-Disposition", "attachment; filename=olympus-rms.xls"); 
      response.setHeader("Content-Description", "JSP Generated Data"); 
int mseq=0;
MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}
Member memTop=managermem.getMember(id);	
Member memKetsai;		
List listFollow=managermem.selectListSchedule(1,6);

MgrOrderBunsho mgrOrder=MgrOrderBunsho.getInstance();
BeanOrderBunsho beanOrder=mgrOrder.getDbOrder(Integer.parseInt(seq));
int mseqOrder1=beanOrder.getSign_01();
int mseqOrder2=beanOrder.getSign_02();
int mseqOrder3=beanOrder.getSign_03();
List listCon=mgrOrder.listItem(beanOrder.getSeq());	
Member memSign;

%>
<c:set var="memTop" value="<%=memTop%>"/>	
<c:set var="listFollow" value="<%=listFollow%>"/>	
<c:set var="beanOrder" value="<%=beanOrder%>"/>
<c:set var="listCon" value="<%=listCon%>"/>


<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 12">
<link rel=File-List href="purchase.files/filelist.xml">
<style id="aaa_4725_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font54725
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.xl634725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl644725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl654725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl664725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl674725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl684725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl694725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl704725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl714725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"yyyy\0022年\0022m\0022月\0022d\0022日\0022\;\@";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl724725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl734725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl744725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl754725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl764725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\\￥\@";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl774725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\\￥\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl784725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl794725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"yyyy\0022年\0022m\0022月\0022d\0022日\0022\;\@";
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl804725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"yyyy\0022年\0022m\0022月\0022d\0022日\0022\;\@";
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl814725
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
ruby
	{ruby-align:left;}
rt
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-char-type:none;}
-->
</style>
</head>

<body>


<div id="aaa_4725" align=center x:publishsource="Excel">

<table border=0 cellpadding=0 cellspacing=0 width=687 class=xl634725
 style='border-collapse:collapse;table-layout:fixed;width:515pt'>
 <col class=xl634725 width=7 style='mso-width-source:userset;mso-width-alt:
 224;width:5pt'>
 <col class=xl634725 width=53 style='mso-width-source:userset;mso-width-alt:
 1696;width:40pt'>
 <col class=xl634725 width=55 style='mso-width-source:userset;mso-width-alt:
 1760;width:41pt'>
 <col class=xl634725 width=33 style='mso-width-source:userset;mso-width-alt:
 1056;width:25pt'>
 <col class=xl634725 width=63 span=2 style='mso-width-source:userset;
 mso-width-alt:2016;width:47pt'>
 <col class=xl634725 width=62 style='mso-width-source:userset;mso-width-alt:
 1984;width:47pt'>
 <col class=xl634725 width=32 style='mso-width-source:userset;mso-width-alt:
 1024;width:24pt'>
 <col class=xl634725 width=51 style='mso-width-source:userset;mso-width-alt:
 1632;width:38pt'>
 <col class=xl634725 width=68 style='mso-width-source:userset;mso-width-alt:
 2176;width:51pt'>
 <col class=xl634725 width=67 style='mso-width-source:userset;mso-width-alt:
 2144;width:50pt'>
 <col class=xl634725 width=74 style='mso-width-source:userset;mso-width-alt:
 2368;width:56pt'>
 <col class=xl634725 width=59 style='mso-width-source:userset;mso-width-alt:
 1888;width:44pt'>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 width=7 style='height:13.5pt;width:5pt'></td>
  <td class=xl634725 width=53 style='width:40pt'></td>
  <td class=xl634725 width=55 style='width:41pt'></td>
  <td class=xl634725 width=33 style='width:25pt'></td>
  <td class=xl634725 width=63 style='width:47pt'></td>
  <td class=xl634725 width=63 style='width:47pt'></td>
  <td class=xl634725 width=62 style='width:47pt'></td>
  <td class=xl634725 width=32 style='width:24pt'></td>
  <td class=xl634725 width=51 style='width:38pt'></td>
  <td class=xl634725 width=68 style='width:51pt'></td>
  <td class=xl634725 width=67 style='width:50pt'></td>
  <td class=xl634725 width=74 style='width:56pt'></td>
  <td class=xl634725 width=59 style='width:44pt'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl634725 style='height:24.0pt'></td>
  <td colspan=11 rowspan=2 class=xl704725>社内用品発注依頼書</td>
  <td class=xl634725></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl634725 style='height:24.0pt'></td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl704725></td>
  <td class=xl704725></td>
  <td class=xl704725></td>
  <td class=xl704725></td>
  <td class=xl704725></td>
  <td class=xl704725></td>
  <td class=xl704725></td>
  <td class=xl704725></td>
  <td colspan=3 class=xl794725><%=beanOrder.getHizuke().substring(0,4)%>年 <%=beanOrder.getHizuke().substring(5,7)%>月 <%=beanOrder.getHizuke().substring(8,10)%>日</td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl714725></td>
  <td class=xl714725></td>
  <td class=xl714725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl634725 style='height:15.75pt'></td>
  <td rowspan=2 class=xl734725><%if(beanOrder.getKind_urgency()==2){%><font color="#CC6600">◎</font> <%}else{%>&nbsp;<%}%></td>
  <td rowspan=2 class=xl734725>至急</td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td colspan=5 class=xl814725 width=292 style='width:219pt'>オリンパスRMS株式会社</td>
  <td class=xl634725></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl634725 style='height:15.75pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td colspan=5 class=xl814725 width=292 style='width:219pt'>〒650-0047</td>
  <td class=xl634725></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl634725 style='height:15.75pt'></td>
  <td rowspan=2 class=xl734725 style='border-top:none'><%if(beanOrder.getKind_urgency()==1){%><font color="#CC6600">◎</font><%}else{%>&nbsp;<%}%></td>
  <td rowspan=2 class=xl734725 style='border-top:none'>普通</td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td colspan=5 class=xl814725 width=292 style='width:219pt'>兵庫県神戸市中央区港島南町1丁目5番2</td>
  <td class=xl634725></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl634725 style='height:15.75pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td colspan=5 class=xl814725 width=292 style='width:219pt'>TEL：078-335-5171　FAX：078-335-5172</td>
  <td class=xl634725></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl634725 style='height:15.75pt'></td>
  <td class=xl684725></td>
  <td class=xl684725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl694725 width=32 style='width:24pt'></td>
  <td class=xl694725 width=51 style='width:38pt'></td>
  <td class=xl694725 width=68 style='width:51pt'></td>
  <td class=xl694725 width=67 style='width:50pt'></td>
  <td class=xl694725 width=74 style='width:56pt'></td>
  <td class=xl634725></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl634725 style='height:16.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl634725 style='height:24.0pt'></td>
  <td colspan=7 class=xl784725><span style='mso-spacerun:yes'>&nbsp;</span>発注先 :  <%=beanOrder.getContact_order()%><span  style='mso-spacerun:yes'>   </span></td>
  <td class=xl654725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl634725 style='height:23.25pt'></td>
  <td colspan=3 class=xl734725>品名</td>
  <td class=xl734725 style='border-left:none'>発注NO.</td>
  <td class=xl734725 style='border-left:none'>発注数</td>
  <td colspan=2 class=xl734725 style='border-left:none'>単価 (\)</td>
  <td colspan=2 class=xl734725 style='border-left:none'>価格 (\)</td>
  <td colspan=2 class=xl734725 style='border-left:none'>依頼者</td>
  <td class=xl634725></td>
 </tr>
  <c:set var="listCon" value="<%=listCon %>" />					
<c:if test="${!empty listCon}">
				<%	int ii=1; 	int totalPriceOrder=0;
					Iterator listiter2=listCon.iterator();					
						while (listiter2.hasNext()){
						BeanOrderBunsho dbCon=(BeanOrderBunsho)listiter2.next();
						int seqq=dbCon.getSeq();
						int pprice=dbCon.getProduct_qty()*dbCon.getUnit_price();
						totalPriceOrder +=pprice;											
				%>		 	  
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl634725 style='height:20.1pt'></td>
  <td colspan=3 class=xl744725><%=dbCon.getProduct_nm()%></td>
  <td class=xl744725 style='border-top:none;border-left:none'><%=dbCon.getOrder_no()%></td>
  <td class=xl724725 style='border-top:none;border-left:none'><%=dbCon.getProduct_qty()%></td>
  <td colspan=2 class=xl764725 style='border-left:none'><%=numFormat.format(dbCon.getUnit_price())%></td>
  <td colspan=2 class=xl764725 style='border-left:none'><%=numFormat.format(pprice)%></td>
  <td colspan=2 class=xl724725 style='border-left:none'><%if(dbCon.getClient_nm()!=0){memSign=managermem.getDbMseq(dbCon.getClient_nm());%><%=memSign.getNm()%><%}else{%>--<%}%></td>
  <td class=xl634725></td>
 </tr> 	  
 <%	ii++;	}%>	    
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl634725 style='height:20.1pt'></td>
  <td colspan=11 class=xl744725>備　考 :  <%if(beanOrder.getComment()==null){%>&nbsp;  <%}else{%><%=beanOrder.getComment()%> <%}%></td>  
  <td class=xl634725></td>
 </tr> 	  
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl634725 style='height:15.0pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl634725 style='height:24.75pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl664725></td>
  <td colspan=2 class=xl754725>合計</td>
  <td colspan=4 class=xl774725 style='border-left:none'><%=numFormat.format(totalPriceOrder)%></td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 	  </c:if> 
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl674725>部  長</td>
  <td class=xl674725 style='border-left:none'>注文者</td>
  <td class=xl644725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  
  <td rowspan=3 class=xl734725 style='border-top:none'>
  <%
		memSign=managermem.getDbMseq(beanOrder.getSign_02()); 
		if(memSign!=null){		
		 if(beanOrder.getSign_02_yn() !=0){		
			if(beanOrder.getSign_02_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">					
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanOrder.getSign_02_yn()==1 ){%><img src="http://olympus-rms.com/rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
	<%}}else{%>--<%}%>		  
  		  
  		  </td>
  <td rowspan=3 class=xl734725 style='border-top:none'>
  	<%
		memSign=managermem.getDbMseq(beanOrder.getSign_03()); 
		if(memSign!=null){		
		 if(beanOrder.getSign_03_yn() !=0){		
			if(beanOrder.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">					
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanOrder.getSign_03_yn()==1 ){%><img src="http://olympus-rms.com/rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
	<%}}else{%>--<%}%>			  
  			  
  			  </td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl634725 style='height:13.5pt'></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
  <td class=xl634725></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=7 style='width:5pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=59 style='width:44pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--Excel의 웹 페이지 마법사로 게시해서 나온 결과의 끝-->
<!----------------------------->
</body>

</html>
