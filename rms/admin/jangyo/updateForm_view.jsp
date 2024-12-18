<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.jangyo.DataBeanJangyo" %>
<%@ page import = "mira.jangyo.DataMgrJangyo" %>
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
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String name=""; String pass=""; int mseq=0; int level=0; String busho=""; int dbPosiLevel=0;
	
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();		 
		 mseq=member.getMseq();
		 busho=member.getBusho();
		 dbPosiLevel=member.getPosition_level();
	}		
//달력보기 시작
  String inDate=dateFormat.format(new java.util.Date());
  String format="yyyy-MM-dd"; int changeDate =1;
  String m_week="";   

  Calendar calen=Calendar.getInstance();   
   Date date02 =calen.getTime();    
   Calendar cal = new GregorianCalendar(); 
   cal.setTime(date02);   
 
   int day_of_week = cal.get ( calen.DAY_OF_WEEK );
   switch(day_of_week){
		case 1:
			m_week="日";
			break;
		case 2:
			m_week="月";
			break;
		case 3:
			m_week="火";
			break;
		case 4:
			m_week="水";
			break;
		case 5:
			m_week="木";
			break;
		case 6:
			m_week="金";
			break;
		case 7:
			m_week="土";
			break;
		default:
			m_week=" ";
	}			
	
	
		
	
String seq=request.getParameter("seq");
String hhh=request.getParameter("hhh");
String mmm=request.getParameter("mmm");
DataMgrJangyo mgrKin=DataMgrJangyo.getInstance();
DataBeanJangyo mem=mgrKin.getDb(Integer.parseInt(seq));
int sign_ok_mseq=mem.getSign_ok_mseq();

int levelKubun=0;
if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
List list=manager.selectJangyo(1,levelKubun,busho); //position, level, 1~4, 부서
%>
	
<c:set var="list" value="<%= list %>" />		
<c:set var="mem" value="<%=mem%>" />
<c:set var="sign_ok_mseq" value="<%=sign_ok_mseq%>" />

	
<script type="text/javascript">
	window.onload = function() {
	//	StartTime(); 
	//	EndTime();
	}
	function StartTime() {
	  	now=new Date();
		h=document.getElementById("day_of_week").value;	
		m=now.getMinutes();	
	if(h==1||h==7){
		document.getElementById("begin_hh").value =9 ;
		document.getElementById("begin_mm").value =00 ;
	}else{
		document.getElementById("begin_hh").value =17 ;
		document.getElementById("begin_mm").value =45 ;
	}			
	}
	function EndTime() {
	  	now=new Date();
		h=now.getHours();	
		m=now.getMinutes();	
		document.getElementById("end_hh").value =h ;
		document.getElementById("end_mm").value =m ;
	}
	

function goWrite(){	
var frm=document.frm;
if(isNotNumber(frm.begin_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.begin_mm, "mm形式で入力して下さい。!")) return;
if(isNotNumber(frm.end_hh, "hh形式で入力して下さい。!")) return;
if(isNotNumber(frm.end_mm, "mm形式で入力して下さい。!")) return;

if(frm.riyu.value ==""){frm.riyu.value=".";}
if(frm.comment.value ==""){frm.comment.value=".";}
if(frm.hizuke.value.length >10){frm.hizuke.value=frm.hizuke.value.substring(0,10);}

if ( confirm("修正しますか?") != 1 ) {	return;}
	
frm.action = "<%=urlPage%>rms/admin/jangyo/update.jsp";	
frm.submit();
}
</script>
<link href="<%=urlPage%>rms/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=urlPage%>rms/js/jquery.min.js"></script>
<script src="<%=urlPage%>rms/js/jquery-ui.min.js"></script>	
<script>
$(function() {
   $("#hizuke").datepicker({monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],dayNamesMin: ['日','月','火','水','木','金','土'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd', 
    autoSize: false, changeMonth: true,changeYear: true, showMonthAfterYear: true, buttonImageOnly: true, buttonImage: '<%=urlPage%>rms/image/icon_cal.gif', showOn: "both", yearRange: 'c-10:c+10' ,showAnim: "slide"}); });

</script>
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">残業申請管理 <font color="#A2A2A2">></font>  書き直し</span> </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">			
	<% if(busho.equals("0")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(経営役員)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>
	<% if(busho.equals("1")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(企画部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>
	<% if(busho.equals("2")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(事業統括部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>
	<% if(busho.equals("3")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(開発部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>		
	<% if(busho.equals("4")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(製造部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("5")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(品質保証部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("6")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(臨床開発部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("7")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(安全管理部)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>	
	<% if(busho.equals("8")){%><input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="(その他)全体目録" onClick="location.href='<%=urlPage%>rms/admin/jangyo/listFormAll.jsp?bushopg=<%=busho%>'"><%}%>		
											
</div>
<div id="boxNoLineBig"  >			
<table width="920" >
	<tr>
	    <td width="10%" style="padding: 0px 0px 0px 5px;" class="calendar16_1">
		<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle">修正 	    		    	
		</td>
		<td width="50%">
	    		<img src="<%=urlPage%>rms/image/admin/tokei_small.gif" align="absmiddle"><font color="#807265">==></font>今の時間を自動的に入力				    
	    	</td>	
		<td width="40%" align="right" >			
			<input type="radio" name="sign_yn" value="1" onClick="show01()" onfocus="this.blur()" checked><font  color="#FF6600">登録欄を見せる</font>
			<input type="radio" name="sign_yn" value="2" onClick="show02()" onfocus="this.blur()"  ><font  color="#FF6600">登録欄を隠す</font>	
    		</td>    	
	</tr>		
</table>
<table  width="920"  class="tablebox" cellspacing="5" cellpadding="5">		
	<form name="frm" action="<%=urlPage%>rms/admin/jangyo/update.jsp" method="post" >
	 <input type="hidden" name="day_of_week"  id="day_of_week" value="<%=day_of_week%>">	 
	 <input type="hidden" name="simya_hh" id="simya_hh" value="00">
	 <input type="hidden" name="simya_mm" id="simya_mm" value="00">
	 <input type="hidden" name="mseq" value="<%=mseq%>">
	 <input type="hidden" name="seq" value="<%=seq%>">
	 <input type="hidden" name="today_youbi" id="today_youbi" value="(<%=m_week%>)">
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
	 <tr>
		<td colspan="4" class="calendar9" align="right"><%=inDate%>(<%=m_week%>曜日)</td>
	</tr>	
	<tr>
		<td  width="15%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">申請者</span></td>
		<td width="39%"><%=name%> (
								    	<% if(busho.equals("0")){%>その他<%}%>										
										<% if(busho.equals("1")){%>品質管理部<%}%>
										<% if(busho.equals("2")){%>製造部<%}%>
										<% if(busho.equals("3")){%>管理部<%}%>	)
    			</td>
				<td  width="13%"><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">承認者</span></td>
				<td width="37%">
					<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				  						
						<select name="sign_ok_mseq" class="select_type3" >															
					
<c:if test="${!empty sign_ok_mseq}">	
<c:choose>
	<c:when test="${mseq==42 || mseq==6}">
			<option value="40" <c:if test="${sign_ok_mseq==40}">selected</c:if> >森山　剛 </option>
			<option value="45" <c:if test="${sign_ok_mseq==45}">selected</c:if> >張　晶旭 </option>
	</c:when>
	<c:when test="${mseq==1 || mseq==53 || mseq==54}">
			<option value="40" <c:if test="${sign_ok_mseq==40}">selected</c:if> >森山　剛 </option>
			<option value="45" <c:if test="${sign_ok_mseq==45}">selected</c:if> >張　晶旭 </option>
			<option value="42" <c:if test="${sign_ok_mseq==42}">selected</c:if> >李　恩永 </option>
			<option value="6" <c:if test="${sign_ok_mseq==6}">selected</c:if> >林　孔華 </option>
			<option value="71" <c:if test="${sign_ok_mseq==71}">selected</c:if> >小林　佐代子 </option>
			<option value="82" <c:if test="${sign_ok_mseq==82}">selected</c:if> >大野　隆弘 </option>
			
			<option value="59" <c:if test="${sign_ok_mseq==59}">selected</c:if> >田村　知明 </option>
			<option value="60" <c:if test="${sign_ok_mseq==60}">selected</c:if> >堀井　章弘 </option>
			<option value="62" <c:if test="${sign_ok_mseq==62}">selected</c:if> >伊藤　志穂 </option>
			<option value="68" <c:if test="${sign_ok_mseq==68}">selected</c:if> >戸川　祐一 </option>
			<option value="83" <c:if test="${sign_ok_mseq==83}">selected</c:if> >上野　仁士 </option>
			<option value="88" <c:if test="${sign_ok_mseq==88}">selected</c:if> >橋本　弘 </option>					
				
	</c:when>
	<c:otherwise>
	    		<option value="40"  <c:if test="${sign_ok_mseq==40}">selected</c:if> >森山　剛 </option>
			<option value="45"  <c:if test="${sign_ok_mseq==45}">selected</c:if> >張　晶旭 </option>
			<option value="42"  <c:if test="${sign_ok_mseq==42}">selected</c:if> >李　恩永 </option>
			<option value="6"  <c:if test="${sign_ok_mseq==6}">selected</c:if> >林　孔華 </option>			
			<option value="1"  <c:if test="${sign_ok_mseq==1}">selected</c:if> >舘　義人 </option>
			<option value="53" <c:if test="${sign_ok_mseq==53}">selected</c:if> >木下　亜紀 </option>
			<option value="54" <c:if test="${sign_ok_mseq==54}">selected</c:if> >富樫　恭子 </option>			
			<option value="71" <c:if test="${sign_ok_mseq==71}">selected</c:if> >小林　佐代子 </option>
			<option value="82" <c:if test="${sign_ok_mseq==82}">selected</c:if> >大野　隆弘 </option>
			
			<option value="59" <c:if test="${sign_ok_mseq==59}">selected</c:if> >田村　知明 </option>
			<option value="60" <c:if test="${sign_ok_mseq==60}">selected</c:if> >堀井　章弘 </option>
			<option value="62" <c:if test="${sign_ok_mseq==62}">selected</c:if> >伊藤　志穂 </option>
			<option value="68" <c:if test="${sign_ok_mseq==68}">selected</c:if> >戸川　祐一 </option>
			<option value="83" <c:if test="${sign_ok_mseq==83}">selected</c:if> >上野　仁士 </option>
			<option value="88" <c:if test="${sign_ok_mseq==88}">selected</c:if> >橋本　弘 </option>					
				
	</c:otherwise>		
</c:choose>		
</c:if>		
				
<c:if test="${empty sign_ok_mseq}">	
<c:choose>
	<c:when test="${mseq==42 || mseq==6}">
			<option value="40">森山　剛 </option>
			<option value="45">張　晶旭 </option>
	</c:when>
	<c:when test="${mseq==1 || mseq==53 || mseq==54}">
			<option value="40">森山　剛 </option>
			<option value="45">張　晶旭 </option>
			<option value="42">李　恩永 </option>
			<option value="6">林　孔華 </option>
			<option value="71">小林　佐代子 </option>
			<option value="82">大野　隆弘 </option>
			
			<option value="59">田村　知明 </option>
			<option value="60">堀井　章弘 </option>
			<option value="62">伊藤　志穂 </option>
			<option value="68">戸川　祐一 </option>
			<option value="83">上野　仁士 </option>
			<option value="88">橋本　弘 </option>
					
	</c:when>
	<c:otherwise>
	    		<option value="40">森山　剛 </option>
			<option value="45">張　晶旭 </option>
			<option value="42">李　恩永 </option>
			<option value="6">林　孔華 </option>			
			<option value="1">舘　義人 </option>
			<option value="53">木下　亜紀 </option>
			<option value="54">富樫　恭子 </option>			
			<option value="71">小林　佐代子 </option>
			<option value="82">大野　隆弘 </option>
				
			<option value="59">田村　知明 </option>
			<option value="60">堀井　章弘 </option>
			<option value="62">伊藤　志穂 </option>
			<option value="68">戸川　祐一 </option>
			<option value="83">上野　仁士 </option>
			<option value="88">橋本　弘 </option>
										
	</c:otherwise>		
</c:choose>		
</c:if>			
		

		
<!--		
		<c:if test="${empty list}">
			<option value="0">NO DATA</option>							
		</c:if>				
		<c:if test="${!empty list}">																															
					<%
								int i=1;	int mseqdbval=0;
								Iterator listiter=list.iterator();					
									while (listiter.hasNext()){
										Member mem02=(Member)listiter.next();
										 mseqdbval=mem02.getMseq();											
										if(mseqdbval!=0 && mseq!=mem02.getMseq()){	
					%>	
										<option value="<%=mseqdbval%>" <%if(mseqdbval==mem.getSign_ok_mseq()){%>selected<%}%>><%=mem02.getNm()%></option>	
					<%	}
					i++;	
					}
					%>																									 
		</c:if>	
-->							 
					</select>
				</div>				
				</td>
			</tr>
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">日付(残業日)</span></td>
				<td><input type="text" size="12%" name="hizuke" id="hizuke" value="<%=mem.getHizuke()%>" style="text-align:center"></td>
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">残業申請時間</span> </td>
				<td>
					<input type="text" size="2" name="begin_hh" id='begin_hh'  value="<%=mem.getBegin_hh()%>" class="input02" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="begin_mm" id="begin_mm"  value="<%=mem.getBegin_mm()%>" class="input02" maxlength="2" style="width:25px">分から
					<a onclick="EndTime();" style="CURSOR: pointer;">	
					<img src="<%=urlPage%>rms/image/admin/tokei.gif" align="absmiddle" alt="自動入力"></a>
					<input type="text" size="2" name="end_hh" id="end_hh"  value="<%=mem.getEnd_hh()%>" class="input02" maxlength="2" style="width:25px">時
					<input type="text" size="2" name="end_mm"  id="end_mm"  value="<%=mem.getEnd_mm()%>" class="input02" maxlength="2" style="width:25px">分まで
				</td>
			</tr>
			<tr >
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">残業理由及び内容</span></td>
				<td><input type="text" size="2" name='riyu'  value="<%=mem.getRiyu()%>" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>								
				<td ><img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="titlename">備考</span></td>
				<td><input type="text" size="2" name='comment'  value="<%=mem.getComment()%>" class="input02" maxlength="200" style="width:180px"> <font color="#807265">(▷200文字以下)</font></td>
			</tr>					
	</table>
<div class="clear_margin"></div>		
<table width="920" >
		<tr>			
			<td colspan="2" align="center"style="padding: 0 0 7 0" >
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="　修正する　" onClick="goWrite();" alt="submit" title="submit">
				
		</tr>					
	</table>	
</form>	
</div>
	
	
	
	
	
	
