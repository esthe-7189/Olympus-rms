<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripKesaisho" %>
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
	
	DataMgrTripKesaisho manager = DataMgrTripKesaisho.getInstance();	
	DataBeanHokoku pdb=manager.getDbExcel(Integer.parseInt(seq));
	List listCon=manager.listCon(Integer.parseInt(seq));
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
<link rel=File-List href="출장결재서.files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="출장결재서_11351_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font011351
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;}
.font511351
	{color:windowtext;
	font-size:6.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;}
.font611351
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;}
.xl1511351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6511351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center-across;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6611351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6711351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6811351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
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
.xl7011351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7111351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:"yyyy\/mm\/dd";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7211351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7311351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:"yyyy\/mm\/dd";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7411351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7511351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7611351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:"yyyy\/mm\/dd";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7711351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:"yyyy\/mm\/dd";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
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
.xl7911351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8011351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8111351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8211351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl8311351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:128;
	mso-number-format:"yyyy\/mm\/dd";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8411351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS PGothic", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8511351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8611351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8711351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8811351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8911351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl9011351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9111351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9211351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9311351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9411351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9511351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9611351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt hairline windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9711351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9811351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9911351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:"yyyy\/mm\/dd";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10011351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:"yyyy\/mm\/dd";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10111351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10211351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10311351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10411351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10511351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10611351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10711351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10811351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10911351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11011351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11111351
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11211351
	{padding:0px;
	mso-ignore:padding;
	color:blue;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"ＭＳ Ｐゴシック", sans-serif;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
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
-->
</style>
</head>

<body>

<div id="출장결재서_11351" align=center x:publishsource="Excel">

<table border=0 cellpadding=0 cellspacing=0 width=707 style='border-collapse:  collapse;table-layout:fixed;width:531pt'>
	 <col width=148 style='mso-width-source:userset;mso-width-alt:4736;width:111pt'>
	 <col width=33  style='mso-width-source:userset;mso-width-alt:1056;width:25pt'>
	 <col width=97 style='mso-width-source:userset;mso-width-alt:3000;width:33pt'>
	 <col width=133 style='mso-width-source:userset;mso-width-alt:4256;width:100pt'>
	 <col width=135 style='mso-width-source:userset;mso-width-alt:4304;width:148pt'>
	 <col width=100 style='mso-width-source:userset;mso-width-alt:4000;width:114pt'>
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 colspan=6 class=xl6911351 align=center width=674 style='height:37.5pt;width:506pt' >出張決裁書</td>
  
 </tr>
 <tr height=32 style='height:24.0pt'>
  <td height=32 class=xl6511351 style='height:24.0pt'></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl7811351 colspan="2">オリンパスＲＭＳ株式&#20250;社</td>  
 </tr>	  
 	  
 <tr height=32 style='height:24.0pt'>
  <td height=32 class=xl6511351 style='height:24.0pt'></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl7211351 colspan="2"><%=pdb.getTitle01()%>&nbsp;  |  &nbsp;<%=pdb.getTitle02()%>&nbsp;  |  &nbsp;出張者 </td>  
 </tr>
 <tr height=45 style='mso-height-source:userset;height:45pt'>
  <td height=45 class=xl6511351 style='height:24.0pt'></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>  
  <td height=45 class=xl7211351 style='height:45pt;border-top:none' colspan="2">
  	  <br>
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
	
		
	<%
		memSign=mem.getDbMseq(pdb.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="http://olympus-rms.com/rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>&nbsp;		
	<%}}else{%>&nbsp;<%}%>	  	  
   </td>  
 </tr>
 
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl6511351 style='height:7.5pt'></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl7211351 style='border-right:1.0pt solid black'>社員番&#21495;</td>
  <td colspan=2 class=xl11011351 style='border-right:1.0pt solid black'><%=pdb.getEm_number()%></td>
  <td class=xl7211351>出張者所&#23646;</td>
  <td colspan=2 class=xl8811351 style='border-right:1.0pt solid black'>
  	  <% if(pdb.getBusho().equals("4")){%>その他<%}%>
					<% if(pdb.getBusho().equals("0")){%>経営役員<%}%>		
					<% if(pdb.getBusho().equals("1")){%>品質管理部<%}%>
					<% if(pdb.getBusho().equals("2")){%>製造部<%}%>
					<% if(pdb.getBusho().equals("3")){%>管理部<%}%>	
					<% if(pdb.getBusho().equals("no data")){%>その他<%}%>
  	  
  	  </td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl7211351 style='border-right:1.0pt solid black'>出張者氏名</td>
  <td colspan=2 class=xl8711351 style='border-right:1.0pt solid black;
  border-left:none'><font class="font611351"><%=pdb.getNm()%></font></td>
  <td class=xl7211351 style='border-top:none;border-left:none'>グレ&#12540;ド</td>
  <td colspan=2 class=xl8811351 style='border-right:1.0pt solid black'><%=pdb.getGrade()%></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl7211351 style='border-right:1.0pt solid black'>パスポ&#12540;ト英字氏名</td>
  <td colspan=2 class=xl8711351 style='border-right:1.0pt solid black;
  border-left:none'><%=pdb.getPassportName()%></td>
  <td class=xl7211351 style='border-top:none;border-left:none'>出向先(&#22269;または&#30476;）</td>
  <td colspan=2 class=xl8811351 style='border-right:1.0pt solid black'><%=pdb.getDestination()%></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl7211351 style='border-right:1.0pt solid black'>出張期間</td>
  <td colspan=5 class=xl10011351 style='border-right:1.0pt solid black; border-left:none'><%=pdb.getDuring_begin()%>  ～  <%=pdb.getDuring_end()%></td> 
 </tr>
 
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl7211351 style='border-right:1.0pt solid black'>出向先の情報</td>
  <td colspan=5 class=xl8711351 style='border-right:1.0pt solid black; border-left:none'><%=pdb.getDestination_info()%></td>
  
 </tr> 
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl8211351 width=148 style='border-right:1.0pt solid black'>渡航先での自動車運&#36578;の有無</td>
  <td colspan=2 class=xl8711351 style='border-right:1.0pt solid black; border-left:none'><%=pdb.getDrive_yn()%></td>
  <td class=xl6611351 style='border-top:none;border-left:none'>危&#38522;度</td>
  <td colspan=2 class=xl8811351 style='border-right:1.0pt solid black'><%=pdb.getDanger()%></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:35pt'>
  <td height=35 class=xl7211351 style='height:35pt;border-top:none'>出張の目的</td>
  <td colspan=5 class=xl8911351 width=559 style='border-right:1.0pt solid black; width:420pt'><%=pdb.getReason()%>   </td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:25pt'>
  <td  aling="center" height=25 class=xl7211351 style='border-right:1.0pt solid black; width:420pt' colspan="6">[出張スケジュ&#12540;ル]</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td class=xl7611351 style='height:35pt;border-left:1.0pt solid black'>日付</td>
  <td class=xl7711351>曜日</td>
  <td colspan=4 class=xl9011351 style='border-right:1.0pt solid black'>摘要</td>
 </tr>
 <c:set var="listCon" value="<%=listCon %>" />					
	<c:if test="${!empty listCon}">
				<%	int ii=1;
					Iterator listiter2=listCon.iterator();					
						while (listiter2.hasNext()){
						DataBeanHokoku dbCon=(DataBeanHokoku)listiter2.next();
						int seqq=dbCon.getSeq();
											
				%>					
					<tr height=35 style='mso-height-source:userset;height:35pt'>
					  <td height=35 class=xl7111351 style='height:35pt;border-left:1.0pt solid black'><%=dbCon.getSche_date().substring(0,10)%></td>
					  <td class=xl8311351 style='border-top:none'><%=dbCon.getSche_date().substring(10,13)%></td>
					  <td colspan=4 class=xl9311351 style='border-right:1.0pt solid black'><%=dbCon.getSche_comment()%></td>
					 </tr>								
				<%
				ii++;
				}%>	
</c:if>
<c:if test="${empty listCon}">
			--
</c:if>	
 
  
 <tr height=35 style='mso-height-source:userset;height:35pt'>
  <td height=35 class=xl7111351 style='height:35pt;border-left:1.0pt solid black'></td>
  <td class=xl7311351 style='border-top:none'></td>
  <td colspan=4 class=xl10111351 width=363 style='border-right:1.0pt solid black; '></td>
 </tr>
 
 <tr height=35 style='mso-height-source:userset;height:35pt'>
  <td height=35 class=xl7211351 style='border-right:1.0pt solid black'>備考</td>
  <td colspan=5 class=xl8511351 style='border-right:1.0pt solid black'>　</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl6511351 style='height:7.5pt'></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
  <td class=xl6511351></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:24.0pt'>
  <td height=24 class=xl7211351 >社長 &nbsp;  |  &nbsp;事業本部長</td>
  <td colspan=5 class=xl6511351 >　</td>
 </tr>	
 <tr height=38 style='mso-height-source:userset;height:38pt'>
  <td height=38 class=xl7211351 style='height:38pt;border-top:none'>
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
  <td colspan=5 class=xl6511351 ></td>
 </tr>		  
 	  
</table>
</div>
</body>

</html>
													