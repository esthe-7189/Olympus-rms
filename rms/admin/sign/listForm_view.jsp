<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "mira.jangyo.DataBeanJangyo" %>
<%@ page import = "mira.jangyo.DataMgrJangyo" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripKesaisho" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>

<%	
String title = ""; String name=""; String mailadd=""; String pass=""; int mseq=0; int level=0; 
String inDate=dateFormat.format(new java.util.Date());		
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

	
	//달력보기 시작
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
	
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){		
		 name=member.getNm();
		 level=member.getPosition_level();
		 pass=member.getPassword();
		 mseq=member.getMseq();
	}	
//残業申請管理
	DataMgrJangyo mgrJan = DataMgrJangyo.getInstance();			
	List listJan=mgrJan.listSignNew(mseq);  //미결제,반환 출력
	int cntDbJan=mgrJan.listSignNewCnt(mseq);		
	
//出・退社	
	DataMgrKintai mgr = DataMgrKintai.getInstance();			
	List list=mgr.listSignNew(mseq);
	int cntDb=mgr.listSignNewCnt(mseq);	
//日程管理	
	DataMgr mgrSche = DataMgr.getInstance();		
	List list2=mgrSche.listScheduleNew(mseq); 
	int dbCntSchedule=mgrSche.listScheduleNewCnt(mseq);		 
	 			 	 

	List listCon ;
	Member memSign;
%>
<c:set var="listJan" value="<%= listJan %>" />	
<c:set var="list" value="<%= list %>" />

<script language="javascript">
function ShowHiddenpg(MenuName, ShowMenuID,kind){ 
	var menu="";
	for ( i = 1; i <= 100;  i++ ){
		if(kind=="listJan"){
			menu= eval("document.all.listJan" + i + ".style");	
		}else if(kind=="sendKintai"){
			menu= eval("document.all.sendKintai" + i + ".style");
		}else if(kind=="schedule"){
			menu= eval("document.all.schedule" + i + ".style");
		}
				
		if ( i == ShowMenuID ){
			if ( menu.display == "block" )
				menu.display	= "none";
			else 
				menu.display	= "block";
		} 
		else 
			menu.display	= "none";
	}
	frame_init();
} 
</script>		
<div id="overlay"></div>
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">決裁管理(未処理)</span> 
<div class="clear_line_gray"></div>
<p>
<div id="boxNoLine"  >
<table width="100%" border="0" cellpadding="0" cellspacing="0">  	
	<tr>
		<td height="30" align="center"  >
<!--残業申請管理 begin -->
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>
		<td align="left"  class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 残業申請管理</td>
		<td align="right" ><font color="#CC6600">(<%= cntDbJan %>)</font></td>				
	</tr>	
</table>	
	
<table width="95%" cellspacing=0 cellpadding=0>
<form name="frm01"  method="post" >
	 <input type="hidden" name="mseq" value="<%=mseq%>">	
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
<tr height=29 bgcolor=#F1F1F1 align=center >	
    <td class="title_list_all">日付(残業日)</td>
    <td class="title_list_m_r">登録日</td>
    <td class="title_list_m_r">氏名</td>
    <td class="title_list_m_r">始業時間</td>
    <td class="title_list_m_r">終業時間</td>   
    <td class="title_list_m_r">理由</td>   
    <td class="title_list_m_r">承認</td>       
</tr>
<c:if test="${empty listJan}">
	<tr height=23>
		<td colspan="7" class="line_gray_b_l_r">---</td>
	</tr>
</c:if>				
<c:if test="${! empty listJan}">	
<%
	int i=1;
	Iterator listiterJan=listJan.iterator();					
	while (listiterJan.hasNext()){
		DataBeanJangyo dbb=(DataBeanJangyo)listiterJan.next();
		int seq=dbb.getSeq();													
		if(seq!=0){		
%>
<input type="hidden" name="divPass" value="popupJan_<%=dbb.getSeq()%>">
<input type="hidden" name="hizukeg_<%=dbb.getSeq()%>" value="<%=dbb.getHizuke().substring(0,10)%>">
<input type="hidden" name="mseqg_<%=dbb.getSeq()%>" value="<%=dbb.getMseq()%>">
<input type="hidden" name="begin_hhg_<%=dbb.getSeq()%>" value="<%=dbb.getBegin_hh()%>">
<input type="hidden" name="begin_mmg_<%=dbb.getSeq()%>" value="<%=dbb.getBegin_mm()%>">
<input type="hidden" name="end_hhg_<%=dbb.getSeq()%>" value="<%=dbb.getEnd_hh()%>">
<input type="hidden" name="end_mmg_<%=dbb.getSeq()%>" value="<%=dbb.getEnd_mm()%>">
<input type="hidden" name="sign_ok_mseq_jan<%=dbb.getSeq()%>" value="<%=dbb.getSign_ok_mseq()%>">
<tr height=23 align="center" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td class="line_gray_b_l_r"><%=dbb.getHizuke()%></td>
	<td class="line_gray_bottomnright"><%=dateFormat.format(dbb.getRegister())%></td>
	<td class="line_gray_bottomnright"><%=dbb.getNm()%></td>	
	<td class="line_gray_bottomnright"><%=dbb.getBegin_hh()%>:<%=dbb.getBegin_mm()%></td>	
	<td class="line_gray_bottomnright"><%=dbb.getEnd_hh()%>:<%=dbb.getEnd_mm()%></td>	
	<td class="line_gray_bottomnright">
<%if(dbb.getRiyu()==null){%>-
<%}else{%><%=dbb.getRiyu()%>
<%}%>
	</td>	
	<td align="center" class="line_gray_bottomnright">
		<a onclick="popupJanBox(<%=seq%>);" style="CURSOR: pointer;">	
         	  	<%if(dbb.getSign_ok()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle" title="決裁"><%}%>
         	  	<%if(dbb.getSign_ok()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:<%=dbb.getSign_no_riyu()%>"><%}%> 
		</a>			
	</td>
</tr>			
<%}
i++;	
}
%>			
</c:if>
</form>
</table>
<!--残業申請管理 end -->
<div class="clear_margin"></div>

<!--社員管理(出・退社) begin -->
<!--*** 1=사인전, 2=사인ok  -->
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>
		<td align="left"  valign="bottom"   class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 社員出退勤</td>					
	</tr>	
</table>	
		
<table width="95%" cellspacing=0 cellpadding=0>
<form name="frmKintai" action="<%=urlPage%>rms/admin/kintai/signOk.jsp" method="post" >
	 <input type="hidden" name="mseq" value="<%=mseq%>">	
	 <input type="hidden" name="sign_ok" value="1">  	
<tr height=29 bgcolor=#F1F1F1 align=center >	
    <td rowspan="2" class="title_list_all"><input type="checkbox" name="chkAll[]" value="chkBoxName01" onFocus="this.blur();" onClick="javascript:allchked(1);"></td>
    <td rowspan="2" class="title_list_m_r">日付(出勤日)</td>
    <td rowspan="2" class="title_list_m_r">登録日</td>
    <td rowspan="2" class="title_list_m_r">氏名</td>  
    <td class="title_list_t_r">始業時間</td>
    <td class="title_list_t_r">終業時間</td>   
    <td rowspan="2" class="title_list_m_r">休暇</td>     
    <td rowspan="2" class="title_list_m_r">代休取得</td>         
    <td rowspan="2" class="title_list_m_r">遅刻・早退・<br>外出時間</td>
    <td rowspan="2" class="title_list_m_r">備考</td>     
    <td rowspan="2" class="title_list_m_r">承認</td>       
</tr>
<tr height=23 bgcolor=#F1F1F1 align=center>
	<td colspan="2" class="title_list_m_r">理由</td> 
</tr>
<c:if test="${empty list}">
	<tr height=23>
		<td colspan="11" class="line_gray_b_l_r">---</td>
	</tr>
</c:if>				
<c:if test="${! empty list}">	
<%
	int i=1;
	Iterator listiter=list.iterator();					
	while (listiter.hasNext()){
		DataBeanKintai dbb=(DataBeanKintai)listiter.next();
		int seq=dbb.getSeq();											
		if(seq!=0){		
%>

<tr height=23  align="center" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td rowspan="2" class="line_gray_b_l_r"><input type="checkbox" name="chkBoxName01[]" value="<%=dbb.getSeq()%>" onFocus="this.blur();" ></td>
	<td  rowspan="2" class="line_gray_bottomnright"><%=dbb.getHizuke()%></td>
	<td  rowspan="2" class="line_gray_bottomnright"><%=dateFormat.format(dbb.getRegister())%></td>
	<td  rowspan="2" class="line_gray_bottomnright"><%=dbb.getNm()%></td>
	<td  class="line_gray_bottomnright"><%=dbb.getBegin_hh()%>:<%=dbb.getBegin_mm()%></td>
	<td  class="line_gray_bottomnright"><%=dbb.getEnd_hh()%>:<%=dbb.getEnd_mm()%></td>
	<td  rowspan="2" class="line_gray_bottomnright">
		<%if(!dbb.getOneday_holi().equals("0")){%>
			<%=dbb.getOneday_holi()%>					
		<%}else{%>
			 &nbsp;		 
		<%}%>	
	</td>	
	<td rowspan="2" class="line_gray_bottomnright">
		<%if(dbb.getDaikyu().equals("0")){%>&nbsp;
		<%}else{%><%=dbb.getDaikyu_date()%>(<%=dbb.getDaikyu()%>)
		<%}%>
	</td>
	<td class="line_gray_bottomnright" rowspan="2">
		<%if(dbb.getChikoku_hh()==0 && dbb.getChikoku_mm()==0){%>
				&nbsp;			
		<%}else if(dbb.getChikoku_hh()!=0 && dbb.getChikoku_mm()==0){%>
			<%=dbb.getChikoku_hh()%>:<%=dbb.getChikoku_mm()%>0		 
		<%}else if(dbb.getChikoku_hh()==0 && dbb.getChikoku_mm()!=0){%>
			<%=dbb.getChikoku_hh()%>:<%=dbb.getChikoku_mm()%>		 
		<%}else if(dbb.getChikoku_hh()!=0 && dbb.getChikoku_mm()!=0){%>
			<%=dbb.getChikoku_hh()%>:<%=dbb.getChikoku_mm()%>		 
		<%}else{%>		
				&nbsp;
		<%}%>				
	</td>
	<td class="line_gray_bottomnright" rowspan="2">
		<%=dbb.getComment()%>
	</td>			
	<td class="line_gray_bottomnright" rowspan="2">			
		<a onclick="popupKintaiBox(<%=seq%>);" style="CURSOR: pointer;">	
         	  	<%if(dbb.getSign_ok()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle" title="決裁"><%}%>
         	  	<%if(dbb.getSign_ok()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"  title="差戻し理由:<%=dbb.getSign_no_riyu()%>"><%}%> 
		</a>						
	</td>
</tr>
<tr >
	<td class="line_gray_bottomnright" colspan="2">
		<%if(dbb.getRiyu()==null){%>&nbsp;
		<%}else{%><%=dbb.getRiyu()%>
		<%}%>
	</td>		
</tr>
<%}
i++;	
}
%>			
  <tr>
    <td  class="line_gray_b_l_r" colspan="11" align="right">チェックされた全てのデータを処理する:     
	<a href="javascript:goSignAll();" onfocus="this.blur()" style="CURSOR: pointer;">
    					<img src="<%=urlPage%>rms/image/admin/btn_kesai_ok.gif"  align="absmiddle"></a>
    	</td>
   </tr>						   							   							   							
</c:if>
</form>							
</table>



<jsp:include page="/rms/admin/sign/includOrder.jsp" flush="false"/>
<jsp:include page="/rms/admin/sign/includTrip.jsp" flush="false"/>
<jsp:include page="/rms/admin/sign/includKinmuSinsei.jsp" flush="false"/> 
<jsp:include page="/rms/admin/sign/includKinmuBogo.jsp" flush="false"/>
<div class="clear_margin"></div>
<!--日程管理 begin --------------------------------->
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>
		<td align="left" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 日程管理</td>
		<td align="right"  style="padding:2 0 2 2" ><font color="#CC6600">(<%= dbCntSchedule %>)</font></td>				
	</tr>		
</table>	
<table width="95%" cellspacing=0 cellpadding=0>
<form name="frm03" action="<%=urlPage%>rms/admin/kintai/insert.jsp" method="post" >	 	
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
		<tr  height="29" bgcolor=#F1F1F1 align=center >	
		    <td class="title_list_all">日付</td>
		    <td class="title_list_m_r">氏名</td>    
		    <td class="title_list_m_r">開始日</td>    
		    <td class="title_list_m_r">終了日</td>  
		    <td class="title_list_m_r">タイトル</td>    
		    <td class="title_list_m_r">承認</td>       
		</tr>

<c:set var="list2" value="<%= list2 %>" />
<c:if test="${empty list2}">
	<tr height="23">
		<td class="line_gray_b_l_r" colspan="6">---</td>
	</tr>
</c:if>				
<c:if test="${! empty list2}">		
<%
	int ii=1;
	Iterator listiter2=list2.iterator();					
	while (listiter2.hasNext()){
		DataBean data=(DataBean)listiter2.next();
		int seq2=data.getSeq();											
		if(seq2!=0){		
%>
<input type="hidden" name="divPass" value="popup_<%=seq2%>">
<tr height="23" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td class="line_gray_b_l_r" align="center"><%=dateFormat.format(data.getRegister())%></td>
	<td class="line_gray_bottomnright" align="center">
		<%Member mmm=manager.getDbMseq(data.getMseq());
		if(mmm!=null){%> <%=mmm.getNm()%> <%}%>	
	</td>	
	<td class="line_gray_bottomnright"><%=data.getDuring_begin()%></td>
	<td class="line_gray_bottomnright"><%=data.getDuring_end()%></td>
	<td class="line_gray_bottomnright"><%=data.getTitle()%></td>
	<td class="line_gray_bottomnright" align="center">
		<%if(data.getSign_ok()==1){%>				
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="決裁" onClick="ShowHiddenpg('schedule','<%=ii%>','schedule');" title="決裁">
		<%}%>	
		<%if(data.getSign_ok()==3){%>				
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="差戻し" onClick="ShowHiddenpg('schedule','<%=ii%>','schedule');" title="差戻し">
		<%}%>			
		</a>	
	</td>
</tr>
<tr>
	<td  colspan="6" align="center" width="90%">
		<span id="schedule<%=ii%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:5px 0px 5px 600px;">		
			<table border="0" width="280" class="tablebox_list"  cellspacing=5 cellpadding=5  bgcolor="#ffffff">	
			     	<tr>
				     	<td width="90%" class="calendar5_03">決裁処理</td> 									
					<td width="10%">						
						<a href="javascript:ShowHiddenpg('schedule','<%=ii%>','schedule');"  onFocus="this.blur()">(X)</a>
					</td>				     	
				</tr> 
			<tr>
                 <td align="center" valign="middle" style="padding:2 0 2 0;" >                            
			    <a href="javascript:goSignSche('<%=data.getSseq()%>',2);" onfocus="this.blur()" style="CURSOR: pointer;">
			    <img src="<%=urlPage%>rms/image/admin/btn_kesai_ok.gif"  align="absmiddle"></a>    			    		   
			    <a href="javascript:goSignSche('<%=data.getSseq()%>',3);" onfocus="this.blur()" style="CURSOR: pointer;">
			    <img src="<%=urlPage%>rms/image/admin/btn_kesai_no.gif"  align="absmiddle"></a>    
                </td>    
            	</tr>                       
		     </table>		
    		</span>
</tr>			
<%}
ii++;	
}
%>			
</c:if>
</form>
</table>
<!--社員管理(出・退社) end -->
</td></tr></table>
<!-- 팝업 start-->				
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->	
</div>
	
<form name="move" method="post">
    <input type="hidden" name="seq" value="">
    <input type="hidden" name="sign_ok" value="">  
    <input type="hidden" name="pgKind" value="sign">  
    <input type="hidden" name="noRiyumo" value="">  
    <input type="hidden" name="hizuke" value="">
    <input type="hidden" name="mseq" value="">
    <input type="hidden" name="begin_hh" value="">
    <input type="hidden" name="begin_mm" value="">
    <input type="hidden" name="end_hh" value="">
    <input type="hidden" name="end_mm" value="">    
    <input type="hidden" name="plan_begin_hh" value="">
    <input type="hidden" name="plan_begin_mm" value="">
    <input type="hidden" name="plan_end_hh" value="">
    <input type="hidden" name="plan_end_mm" value="">
    <input type="hidden" name="reasonHoli" value="">
    <input type="hidden" name="theday" value="">
    <input type="hidden" name="position" value="">    
    <input type="hidden" name="daikyu_date" value="">
    <input type="hidden" name="daikyu" value="">
    <input type="hidden" name="sign_ok_mseq" value="">  
 </form>
<script language="JavaScript"> 
function popupJanBox(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sign/popup_jangyo.jsp?seq="+seq; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}	
function popupKintaiBox(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sign/popup_kintai.jsp?seq="+seq; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}	

function goSignAll() {	
	var frm=document.frmKintai;	
	var checkboxSmall = document.getElementsByName('chkBoxName01[]'); 	
	var count=0;
	
	for(var i=0;i<checkboxSmall.length;i++){
		if(checkboxSmall[i].checked==true){
			count++;
		}
	}
	if(count==0){alert("データを一個以上チェックしてください。"); return;}	
	if ( confirm("("+count+")個のデータを承認しますか?") != 1 ) {return;}	
	document.frmKintai.action = "<%=urlPage%>rms/admin/kintai/signOkAll.jsp";	
	document.frmKintai.submit();
}

function allchked(cnt){
	var frm=document.frmKintai;	
	var checkboxList = document.getElementsByName('chkAll[]'); 
	var chkBoxName = document.getElementsByName('chkAll[]'); 
	var cntint= eval(cnt)-1;	
	
	 for(var i=0; i<checkboxList.length; i++) { 
	  if(checkboxList[i].checked==true && cntint==i) { 	  	  	  	 
	  	  allcheck(chkBoxName[i].value); 		  	  
	  }else if(checkboxList[i].checked==false && cntint==i){	  	  
	  	  allclear(chkBoxName[i].value);
	  }
	 }
}

function allcheck(chkBoxName){	
	var checkboxSmall = document.getElementsByName(chkBoxName+'[]'); 
	var chcount=0;
	var i=0;
	
	for(i=0; i< checkboxSmall.length;i++){
		chcount++;
	}

	if(chcount==0){
		checkboxSmall.checked=true;
	}else{
		for(i=0; i<checkboxSmall.length;i++){
			checkboxSmall[i].checked=true;
		}
	}
}	
function allclear(chkBoxName){		
		var checkboxSmall = document.getElementsByName(chkBoxName+'[]'); 
		var chcount=0;
		var i=0;
		for(i=0; i< checkboxSmall.length;i++){
			chcount++;
		}
		if(chcount==0){
			checkboxSmall.checked=false;
		}else{
			for(i=0; i<checkboxSmall.length;i++){
				checkboxSmall[i].checked=false;
			}
		}
	}
	
	
function goSignSche(sseq,sign_ok) {		
	if(sign_ok=="2"){
		if ( confirm("承認しますか?") != 1 ) {return;}
	}else{
		if ( confirm("差戻ししますか?") != 1 ) {return;}
	}	
	document.move.action = "<%=urlPage%>rms/admin/sign/signSheOk.jsp";
	document.move.seq.value = sseq;	
	document.move.sign_ok.value = sign_ok;	
	document.move.pgKind.value = document.move.pgKind.value;	
	document.move.submit();
}
</script>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
