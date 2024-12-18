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
String urlPage=request.getContextPath()+"/";		
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

int mseq=0;
MemberManager managermem = MemberManager.getInstance();	
Member member=managermem.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();		 
	}
Member memTop=managermem.getMember(id);	
Member memKetsai;		
List listFollow=managermem.selectListSchedule(1,6);
//List listSign=manager.selectJangyo(1,levelKubun,bushoVal); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)

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

	
<html>
<head>
<title>OLYMPUS-RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<%=urlPage%>rms/css/mainAdmin.css" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<style type="text/css">
.tFont {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:12px; color: #000000; text-decoration:none; }
.tFontM {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:14px; color: #000000; text-decoration:none; }
.tFontB {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:18px; font-weight: bold; color: #000000; text-decoration:none; }
.tFontS {font-family:MS PGothic,Gulim,Dotum,Batang,Gungsuh,Arial,Comic Sans MS,Courier New;Tahoma,Times New Roman,Verdan; font-size:11px; color: #000000; text-decoration:none; }
</style>
<script language="javascript">
function resize(width, height){	
	window.resizeTo(width, height);
}

function ieExecWB( intOLEcmd, intOLEparam )
{
//참고로 IE 5.5 이상에서만 동작함
// 웹 브라우저 컨트롤 생성
var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';

// 웹 페이지에 객체 삽입
document.body.insertAdjacentHTML('beforeEnd', WebBrowser);

// if intOLEparam이 정의되어 있지 않으면 디폴트 값 설정
if ( ( ! intOLEparam ) || ( intOLEparam < -1 ) || (intOLEparam > 1 ) )
intOLEparam = 1;

// ExexWB 메쏘드 실행
WebBrowser1.ExecWB( intOLEcmd, intOLEparam );

// 객체 해제
WebBrowser1.outerHTML = "";
}

function printa(){
	window.print();
}

</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('595','780') ;">
<center>

<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<form name="frm">
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 5 5 10 5">				
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>							
			<table width="100%"  border="0" cellpadding=0 cellspacing=0 bordercolor="#000" >			
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10 5 10 5">
				<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
				<tr>
					<td align="center" colspan="3" bgcolor="#ffffff"   style="padding: 10 0 3 0;">
						<table width="100%"  border=0 cellpadding=0 cellspacing=0 >			
						<tr>
							<td align="center" class="tFontB" style="padding: 3 0 3 0;">社内用品発注依頼書</td>
						</tr>
						</table>
					</td>										
				</tr>
				<tr>
					<td width="26%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
							<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
							<tr bgcolor="" align=center height=26>	
								<td width="50%" class="tFontB"><%if(beanOrder.getKind_urgency()==2){%><font color="#CC6600">◎</font> <%}else{%>&nbsp;<%}%></td>
								<td width="50%" class="tFont">至急</td>
							</tr>
							<tr bgcolor="" align=center height=26>	
								<td width="50%" class="tFontB"><%if(beanOrder.getKind_urgency()==1){%><font color="#CC6600">◎</font><%}else{%>&nbsp;<%}%></td>
								<td width="50%" class="tFont">普通</td>
							</tr>
							</table>								
					</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>
					<td width="39%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
							<table width="100%"  border=0 cellpadding=0 cellspacing=0  >			
							<tr>
								<td align="right" style="padding: 3 0 3 0;">
								<%=beanOrder.getHizuke().substring(0,4)%>年 <%=beanOrder.getHizuke().substring(5,7)%>月 <%=beanOrder.getHizuke().substring(8,10)%>日</td>	
							</tr>
							<tr>
								<td align="left" style="padding: 3 0 3 0;">
オリンパスRMS株式会社<br>
〒650-0047<br>
兵庫県神戸市中央区港島南町1丁目5番2<br>
TEL：078-335-5171　FAX：078-335-5172<br>

								
								</td>	
							</tr>
							</table>						
					</td>							
				</tr>
				<tr>
					<td colspan="3" width="30%" align="left"  style="padding: 3 0 3 0;" class="calendar15">
						発注先：  <%=beanOrder.getContact_order()%>						
					</td>							
				</tr>									
				<tr>
					<td colspan="3" align="center" style="padding: 3 0 3 0;">
						<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor=#F1F1F1 align=center height=26>	
							<td class="tFont">品名</td>
							<td class="tFont">発注NO.</td>
							<td class="tFont">発注数</td>
							<td class="tFont">単価 (\)</td>
							<td class="tFont">価格 (\)</td>
							<td class="tFont">依頼者</td>
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
						<tr height=26>	
							<td class="tFont"><%=dbCon.getProduct_nm()%></td>
							<td class="tFont"><%=dbCon.getOrder_no()%></td>
							<td  align="center" class="tFont"><%=dbCon.getProduct_qty()%></td>
							<td  align="right" class="tFont"><%=numFormat.format(dbCon.getUnit_price())%> </td>
							<td  align="right" class="tFont"><%=numFormat.format(pprice)%></td>
							<td align="center" class="tFont">
								<%if(dbCon.getClient_nm()!=0){memSign=managermem.getDbMseq(dbCon.getClient_nm());%><%=memSign.getNm()%><%}else{%>--<%}%>
							</td>
						</tr>					
				<%	ii++;	}%>	
							<tr>								
								<td colspan="6" class="tFont">備　考 :  <%if(beanOrder.getComment()==null){%>&nbsp;  <%}else{%><%=beanOrder.getComment()%> <%}%></td>	
							</tr>
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0 92 0 0;" class="tFontM">合計&nbsp;  :&nbsp;   \&nbsp;   <%=numFormat.format(totalPriceOrder)%></td>	
							</tr>
			</c:if>
			<c:if test="${empty listCon}">
							<tr height=26>	
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
							</tr>
							<tr>								
								<td colspan="6" class="tFont">備　考 : &nbsp; </td>	
							</tr>				
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0 92 0 0;" class="tFontM"><font  color="#669900">合計  :  \  0 </font></td>	
							</tr>
			</c:if>	
													
																	
						</table>																			
					</td>							
				</tr>
				<tr>
					<td colspan="3" width="30%" align="left"  style="padding: 3 0 3 0;" >
							<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
								<tr>
									<td width="75%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>	
									<td width="25%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
											<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
											<tr bgcolor="" align=center height=26 >	
												
												<td width="33%" class="tFont">部長</td>
												<td width="33%" class="tFontS">注文者</td>
											</tr>
											<tr bgcolor="" align=center height=50>													
												<td>
	<%
		memSign=managermem.getDbMseq(beanOrder.getSign_02()); 
		if(memSign!=null){		
		 if(beanOrder.getSign_02_yn() !=0){		
			if(beanOrder.getSign_02_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanOrder.getSign_02_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(beanOrder.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=beanOrder.getSign_no_riyu_02()%>"><%}%> 
	<%}}else{%>--<%}%>										
												</td>
												<td>
	<%
		memSign=managermem.getDbMseq(beanOrder.getSign_03()); 
		if(memSign!=null){		
		 if(beanOrder.getSign_03_yn() !=0){		
			if(beanOrder.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>確認済<%}%>
			<%}%>
			<%if(beanOrder.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(beanOrder.getSign_03_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=beanOrder.getSign_no_riyu_03()%>"><%}%> 
	<%}}else{%>--<%}%>												
												
												</td>
											</tr>
											</table>								
									</td>									
								</tr>
							</table>	
					</td>							
				</tr>	
				</table>				
			</td>
			</tr>
			</table>
		
		<!-----content end**************************--------->					
		
		</td>								
	</tr>
	<tr>
		<td>
			<table width="100%"  border=0 >
				<tr>
					<td align="center" style="padding: 2 0 1 0">
<a href="javascript:window.ieExecWB(7)"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintPreview.gif" align="absmiddle" title="手動的操作：マウスを画面の上に置き、マウスの右をクリックし==>(N)をクリック"></a>	
<a href="javascript:printa();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintBogoForm.gif" align="absmiddle"></a>
<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/xBogoForm.gif" align="absmiddle"></a>
					</td>							
				</tr>		
			</table>
		</td>
	</tr>
</form>																
	</table>
	
</body>
</html>																		