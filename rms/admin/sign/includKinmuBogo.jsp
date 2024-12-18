<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
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
String name=""; String pass=""; int mseq=0; int level=0; 	
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


	
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){		
		 name=member.getNm();
		 level=member.getPosition_level();
		 pass=member.getPassword();
		 mseq=member.getMseq();
	}	
	
	
//休日出勤보고서	
	DataMgrHoliHokoku mgrHoliHokokuCon = DataMgrHoliHokoku.getInstance();		
					 
	int dbCntHoliCon01=mgrHoliHokokuCon.listSignNewCntPgAllCon(mseq,1);
	int dbCntHoliCon02=mgrHoliHokokuCon.listSignNewCntPgAllCon(mseq,2);
	int dbCntHoliCon03=mgrHoliHokokuCon.listSignNewCntPgAllCon(mseq,3);
	int dbCntHoliCon04=mgrHoliHokokuCon.listSignNewCntPgAllCon(mseq,4);
	int totalCntCon=dbCntHoliCon01+dbCntHoliCon02+dbCntHoliCon03+dbCntHoliCon04;	
	 		 
	List listHoliCon01=mgrHoliHokokuCon.listSignNewAllCon(mseq,1); 		 	 
	List listHoliCon02=mgrHoliHokokuCon.listSignNewAllCon(mseq,2); 	 
	List listHoliCon03=mgrHoliHokokuCon.listSignNewAllCon(mseq,3); 	 
	List listHoliCon04=mgrHoliHokokuCon.listSignNewAllCon(mseq,4); 
			 			 	 

	List listCon ;
	Member memSign;
%>
	
<c:set var="listHoliCon01" value="<%= listHoliCon01 %>" />	
<c:set var="listHoliCon02" value="<%= listHoliCon02 %>" />
<c:set var="listHoliCon03" value="<%= listHoliCon03 %>" />
<c:set var="listHoliCon04" value="<%= listHoliCon04 %>" />

<script type="text/javascript">

function ShowHiddenHoliCon01(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.item_blockHoliCon" + i + ".style");		
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
//****************************02***************************************************************************

function ShowHiddenHoliCon02(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.item_blockHoliCon02" + i + ".style");		
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
//****************************03***************************************************************************

function ShowHiddenHoliCon03(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.item_blockHoliCon03" + i + ".style");		
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
//****************************04***************************************************************************

function ShowHiddenHoliCon04(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.item_blockHoliCon04" + i + ".style");		
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

<!--申請書/報告書 > 休日出勤申請書01 begin -->
	
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>		
		<td align="left" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 出張/休日勤務 > 休日出勤報告書 </td>			
	</tr>	
</table>	
<table width="95%" cellspacing=0 cellpadding=0>
<tr bgcolor=#F1F1F1 align=center >	
    <td class="title_list_all">所属</td>
    <td class="title_list_m_r">登録日</td>
    <td class="title_list_m_r">決裁</td>
    <td class="title_list_m_r">氏名</td>
    <td class="title_list_m_r">月日</td>
    <td class="title_list_m_r">予定時間</td>   
    <td class="title_list_m_r">休憩時間</td>   
    <td class="title_list_m_r">承認</td>       
</tr>	
<!--休日出勤/보고서 01******************************************************************************************************-->	
<c:if test="${empty listHoliCon01 && empty listHoliCon02 && empty listHoliCon03 && empty listHoliCon04}">	
	<tr height="25">
		<td colspan="8" class="line_gray_b_l_r">---</td>
	</tr>
</c:if>	
<c:if test="${! empty listHoliCon01}">	
<form name="frmBogoCon"  method="post" >		
<%
	int i=1;
	Iterator listiterCon=listHoliCon01.iterator();					
	while (listiterCon.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterCon.next();		
		String bushoKind=pdb.getBusho();																
		int or_seq=pdb.getSeq();
			int btotalHHMM=(pdb.getRest_end_hh()*60+pdb.getRest_end_mm())-(pdb.getRest_begin_hh()*60+pdb.getRest_begin_mm());
			int bresultHH=btotalHHMM/60;
			int bresultMM=btotalHHMM%60;	
			int btotalHHMM2=(pdb.getPlan_end_hh()*60+pdb.getPlan_end_mm())-(pdb.getPlan_begin_hh()*60+pdb.getPlan_begin_mm());
			int bresultHH2=btotalHHMM2/60;
			int bresultMM2=btotalHHMM2%60;																															
		if(or_seq!=0){	
		DataBeanHokoku pdbbogo=mgrHoliHokokuCon.getDb(pdb.getMseq());
			int totalHHMM=(pdbbogo.getRest_end_hh()*60+pdbbogo.getRest_end_mm())-(pdbbogo.getRest_begin_hh()*60+pdbbogo.getRest_begin_mm());
			int resultHH=totalHHMM/60;
			int resultMM=totalHHMM%60;	
			int totalHHMM2=(pdbbogo.getPlan_end_hh()*60+pdbbogo.getPlan_end_mm())-(pdbbogo.getPlan_begin_hh()*60+pdbbogo.getPlan_begin_mm());
			int resultHH2=totalHHMM2/60;
			int resultMM2=totalHHMM2%60;			
%>
	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>		
	</td>
	<td align="center" class="line_gray_bottomnright"><%=dateFormat.format(pdb.getRegister())%></td>
	<td align="center" class="line_gray_bottomnright">[<%=pdb.getTitle01()%>]</td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenHoliCon01('item_blockHoliCon','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenHoliCon01('item_blockHoliCon','<%=i%>');" onFocus="this.blur()"><font color="#009900"><%=pdb.getTheday()%></font></a></td>	
	<td align="center" class="line_gray_bottomnright"><%=pdb.getPlan_begin_hh()%> : <%=pdb.getPlan_begin_mm()%> ～ <%=pdb.getPlan_end_hh()%> : <%=pdb.getPlan_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright"><%=pdb.getRest_begin_hh()%> : <%=pdb.getRest_begin_mm()%> ～ <%=pdb.getRest_end_hh()%> : <%=pdb.getRest_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright">			
		<a onclick="popupBogo('<%=pdb.getSeq()%>',1);" style="CURSOR: pointer;">
         	  	<%if(pdb.getSign_ok_yn_boss()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
         	  	<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:<%=pdb.getSign_no_riyu_boss()%>"><%}%>   
		</a>			
	</td>
</tr>
<tr>
	<td  colspan="8" align="center" width="90%" >
		<span id="item_blockHoliCon<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 5px 0px 0px 0px">休日出勤申請書 </td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(pdbbogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			<tr height="29" >			
				<td align="center" bgcolor="#f7f7f7" width="15%" >所 属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("4")){%>その他<%}%>
					<% if(bushoKind.equals("0")){%>経営役員<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
				<td align="center" bgcolor="#f7f7f7" width="15%">氏 名</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdbbogo.getNm()%></td>
    		</tr>
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getTheday()%></td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=pdbbogo.getPlan_begin_hh()%>時<%=pdbbogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getPlan_end_hh()%>時<%=pdbbogo.getPlan_end_mm()%>分
					（<%=resultHH2%>時 <%=resultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=pdbbogo.getRest_begin_hh()%>時<%=pdbbogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getRest_end_hh()%>時<%=pdbbogo.getRest_end_mm()%>分
					（<%=resultHH%>時 <%=resultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>							
						</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">								    							    	
						    	
	<%
	memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho2() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_kanribu() !=0){		
			if(pdbbogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
<!-----休日出勤報告書 end**************************pdb.getMseq()=seq_hokoku_holiday--------->	
<p>
<% 	DataBeanHokoku beanBogo=mgrHoliHokokuCon.getDbBogo(pdb.getMseq()); %>
<c:set var="beanBogo" value="<%=beanBogo%>"/>			
<c:if test="${! empty beanBogo}">		

<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 10px 0px 0px 0px">休日出勤報告書</td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(beanBogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">	
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getTheday()%>	</td>				
			</tr>			
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=beanBogo.getPlan_begin_hh()%>時<%=beanBogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>時<%=beanBogo.getPlan_end_mm()%>分
					（<%=bresultHH2%>時 <%=bresultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=beanBogo.getRest_begin_hh()%>時<%=beanBogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>時<%=beanBogo.getRest_end_mm()%>分
					（<%=bresultHH%>時 <%=bresultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
							<td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>
					</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
			if(beanBogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
			if(beanBogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">	
	    <%	
		if(beanBogo.getMimg()!=null){		
		 if(!beanBogo.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=beanBogo.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
</c:if>		
<!-----content end**************************--------->					
		</span>
	</td>
</tr>

<%}
i++;	
}
%>	
</form>			
</c:if>

<!--休日出勤/보고서 02******************************************************************************************************-->

<c:if test="${! empty listHoliCon02}">	
<form name="frmBogoCon02"  method="post" >	
<%
	int i=1;
	Iterator listiterCon2=listHoliCon02.iterator();					
	while (listiterCon2.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterCon2.next();		
		String bushoKind=pdb.getBusho();																
		int or_seq=pdb.getSeq();
			int btotalHHMM=(pdb.getRest_end_hh()*60+pdb.getRest_end_mm())-(pdb.getRest_begin_hh()*60+pdb.getRest_begin_mm());
			int bresultHH=btotalHHMM/60;
			int bresultMM=btotalHHMM%60;	
			int btotalHHMM2=(pdb.getPlan_end_hh()*60+pdb.getPlan_end_mm())-(pdb.getPlan_begin_hh()*60+pdb.getPlan_begin_mm());
			int bresultHH2=btotalHHMM2/60;
			int bresultMM2=btotalHHMM2%60;																															
		if(or_seq!=0){	
		DataBeanHokoku pdbbogo=mgrHoliHokokuCon.getDb(pdb.getMseq());
			int totalHHMM=(pdbbogo.getRest_end_hh()*60+pdbbogo.getRest_end_mm())-(pdbbogo.getRest_begin_hh()*60+pdbbogo.getRest_begin_mm());
			int resultHH=totalHHMM/60;
			int resultMM=totalHHMM%60;	
			int totalHHMM2=(pdbbogo.getPlan_end_hh()*60+pdbbogo.getPlan_end_mm())-(pdbbogo.getPlan_begin_hh()*60+pdbbogo.getPlan_begin_mm());
			int resultHH2=totalHHMM2/60;
			int resultMM2=totalHHMM2%60;			
%>
	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>		
	</td>
	<td align="center" class="line_gray_bottomnright"><%=dateFormat.format(pdb.getRegister())%></td>
	<td align="center" class="line_gray_bottomnright">[<%=pdb.getTitle02()%>]</td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenHoliCon02('item_blockHoliCon02','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>	
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenHoliCon02('item_blockHoliCon02','<%=i%>');" onFocus="this.blur()"><font color="#009900"><%=pdb.getTheday()%></font></a></td>	
	<td align="center" class="line_gray_bottomnright"><%=pdb.getPlan_begin_hh()%> : <%=pdb.getPlan_begin_mm()%> ～ <%=pdb.getPlan_end_hh()%> : <%=pdb.getPlan_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright"><%=pdb.getRest_begin_hh()%> : <%=pdb.getRest_begin_mm()%> ～ <%=pdb.getRest_end_hh()%> : <%=pdb.getRest_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright">			
		<a onclick="popupBogo('<%=pdb.getSeq()%>',2);" style="CURSOR: pointer;">
         	  	<%if(pdb.getSign_ok_yn_bucho()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
         	  	<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:<%=pdb.getSign_no_riyu_bucho()%>"><%}%>  
		</a>			
	</td>
</tr>
<tr>
	<td  colspan="8" align="center" width="90%" >
		<span id="item_blockHoliCon02<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 5px 0px 0px 0px">休日出勤申請書 </td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(pdbbogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			<tr height="29" >			
				<td align="center" bgcolor="#f7f7f7" width="15%" >所 属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("4")){%>その他<%}%>
					<% if(bushoKind.equals("0")){%>経営役員<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
				<td align="center" bgcolor="#f7f7f7" width="15%">氏 名</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdbbogo.getNm()%></td>
    		</tr>
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getTheday()%></td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=pdbbogo.getPlan_begin_hh()%>時<%=pdbbogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getPlan_end_hh()%>時<%=pdbbogo.getPlan_end_mm()%>分
					（<%=resultHH2%>時 <%=resultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=pdbbogo.getRest_begin_hh()%>時<%=pdbbogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getRest_end_hh()%>時<%=pdbbogo.getRest_end_mm()%>分
					（<%=resultHH%>時 <%=resultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>							
						</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">								    							    	
						    	
	<%
	memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho2() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_kanribu() !=0){		
			if(pdbbogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
<!-----休日出勤報告書 end**************************pdb.getMseq()=seq_hokoku_holiday--------->	
<p>
<% 	DataBeanHokoku beanBogo=mgrHoliHokokuCon.getDbBogo(pdb.getMseq()); %>
<c:set var="beanBogo" value="<%=beanBogo%>"/>			
<c:if test="${! empty beanBogo}">		

<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 10px 0px 0px 0px">休日出勤報告書</td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(beanBogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">	
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getTheday()%>	</td>				
			</tr>			
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=beanBogo.getPlan_begin_hh()%>時<%=beanBogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>時<%=beanBogo.getPlan_end_mm()%>分
					（<%=bresultHH2%>時 <%=bresultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=beanBogo.getRest_begin_hh()%>時<%=beanBogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>時<%=beanBogo.getRest_end_mm()%>分
					（<%=bresultHH%>時 <%=bresultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
							<td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>
					</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
			if(beanBogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
			if(beanBogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">	
	    <%	
		if(beanBogo.getMimg()!=null){		
		 if(!beanBogo.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=beanBogo.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
</c:if>		
<!-----content end**************************--------->					
		</span>
	</td>
</tr>

<%}
i++;	
}
%>	
</form>			
</c:if>	
	
<!--休日出勤/보고서 03******************************************************************************************************-->			
<c:if test="${! empty listHoliCon03}">	
<form name="frmBogoCon03"  method="post" >	
<%
	int i=1;
	Iterator listiterCon3=listHoliCon03.iterator();					
	while (listiterCon3.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterCon3.next();		
		String bushoKind=pdb.getBusho();																
		int or_seq=pdb.getSeq();
			int btotalHHMM=(pdb.getRest_end_hh()*60+pdb.getRest_end_mm())-(pdb.getRest_begin_hh()*60+pdb.getRest_begin_mm());
			int bresultHH=btotalHHMM/60;
			int bresultMM=btotalHHMM%60;	
			int btotalHHMM2=(pdb.getPlan_end_hh()*60+pdb.getPlan_end_mm())-(pdb.getPlan_begin_hh()*60+pdb.getPlan_begin_mm());
			int bresultHH2=btotalHHMM2/60;
			int bresultMM2=btotalHHMM2%60;																															
		if(or_seq!=0){	
		DataBeanHokoku pdbbogo=mgrHoliHokokuCon.getDb(pdb.getMseq());
			int totalHHMM=(pdbbogo.getRest_end_hh()*60+pdbbogo.getRest_end_mm())-(pdbbogo.getRest_begin_hh()*60+pdbbogo.getRest_begin_mm());
			int resultHH=totalHHMM/60;
			int resultMM=totalHHMM%60;	
			int totalHHMM2=(pdbbogo.getPlan_end_hh()*60+pdbbogo.getPlan_end_mm())-(pdbbogo.getPlan_begin_hh()*60+pdbbogo.getPlan_begin_mm());
			int resultHH2=totalHHMM2/60;
			int resultMM2=totalHHMM2%60;				
%>
	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>		
	</td>
	<td align="center" class="line_gray_bottomnright"><%=dateFormat.format(pdb.getRegister())%></td>
	<td align="center" class="line_gray_bottomnright">[<%=pdb.getTitle03()%>]</td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenHoliCon03('item_blockHoliCon03','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>	
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenHoliCon03('item_blockHoliCon03','<%=i%>');" onFocus="this.blur()"><font color="#009900"><%=pdb.getTheday()%></font></a></td>
	<td align="center" class="line_gray_bottomnright"><%=pdb.getPlan_begin_hh()%> : <%=pdb.getPlan_begin_mm()%> ～ <%=pdb.getPlan_end_hh()%> : <%=pdb.getPlan_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright"><%=pdb.getRest_begin_hh()%> : <%=pdb.getRest_begin_mm()%> ～ <%=pdb.getRest_end_hh()%> : <%=pdb.getRest_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright">			
		<a onclick="popupBogo('<%=pdb.getSeq()%>',3);" style="CURSOR: pointer;">	
         	  	<%if(pdb.getSign_ok_yn_bucho2()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
         	  	<%if(pdb.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"  title="差戻し理由:<%=pdb.getSign_no_riyu_bucho2()%>"><%}%>    
		</a>			
	</td>
</tr>
<tr>
	<td  colspan="8" align="center" width="90%" >
		<span id="item_blockHoliCon03<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 5px 0px 0px 0px">休日出勤申請書 </td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(pdbbogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			<tr height="29" >			
				<td align="center" bgcolor="#f7f7f7" width="15%" >所 属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("4")){%>その他<%}%>
					<% if(bushoKind.equals("0")){%>経営役員<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
				<td align="center" bgcolor="#f7f7f7" width="15%">氏 名</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdbbogo.getNm()%></td>
    		</tr>
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getTheday()%></td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=pdbbogo.getPlan_begin_hh()%>時<%=pdbbogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getPlan_end_hh()%>時<%=pdbbogo.getPlan_end_mm()%>分
					（<%=resultHH2%>時 <%=resultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=pdbbogo.getRest_begin_hh()%>時<%=pdbbogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getRest_end_hh()%>時<%=pdbbogo.getRest_end_mm()%>分
					（<%=resultHH%>時 <%=resultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>							
						</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">								    							    	
						    	
	<%
	memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho2() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_kanribu() !=0){		
			if(pdbbogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
<!-----休日出勤報告書 end**************************pdb.getMseq()=seq_hokoku_holiday--------->	
<p>
<% 	DataBeanHokoku beanBogo=mgrHoliHokokuCon.getDbBogo(pdb.getMseq()); %>
<c:set var="beanBogo" value="<%=beanBogo%>"/>			
<c:if test="${! empty beanBogo}">		

<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 10px 0px 0px 0px">休日出勤報告書</td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(beanBogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">	
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getTheday()%>	</td>				
			</tr>			
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=beanBogo.getPlan_begin_hh()%>時<%=beanBogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>時<%=beanBogo.getPlan_end_mm()%>分
					（<%=bresultHH2%>時 <%=bresultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=beanBogo.getRest_begin_hh()%>時<%=beanBogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>時<%=beanBogo.getRest_end_mm()%>分
					（<%=bresultHH%>時 <%=bresultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
							<td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>
					</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
			if(beanBogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
			if(beanBogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">	
	    <%	
		if(beanBogo.getMimg()!=null){		
		 if(!beanBogo.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=beanBogo.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
</c:if>		
<!-----content end**************************--------->					
		</span>
	</td>
</tr>

<%}
i++;	
}
%>	
</form>			
</c:if>		
	
	
<!--休日出勤/보고서 04******************************************************************************************************-->

<c:if test="${! empty listHoliCon04}">	
<form name="frmBogoCon04"  method="post" >		
<%
	int i=1;
	Iterator listiterCon4=listHoliCon04.iterator();					
	while (listiterCon4.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterCon4.next();		
		String bushoKind=pdb.getBusho();
		int or_seq=pdb.getSeq();
			int btotalHHMM=(pdb.getRest_end_hh()*60+pdb.getRest_end_mm())-(pdb.getRest_begin_hh()*60+pdb.getRest_begin_mm());
			int bresultHH=btotalHHMM/60;
			int bresultMM=btotalHHMM%60;	
			int btotalHHMM2=(pdb.getPlan_end_hh()*60+pdb.getPlan_end_mm())-(pdb.getPlan_begin_hh()*60+pdb.getPlan_begin_mm());
			int bresultHH2=btotalHHMM2/60;
			int bresultMM2=btotalHHMM2%60;																															
		if(or_seq!=0){	
		DataBeanHokoku pdbbogo=mgrHoliHokokuCon.getDb(pdb.getMseq());
			int totalHHMM=(pdbbogo.getRest_end_hh()*60+pdbbogo.getRest_end_mm())-(pdbbogo.getRest_begin_hh()*60+pdbbogo.getRest_begin_mm());
			int resultHH=totalHHMM/60;
			int resultMM=totalHHMM%60;	
			int totalHHMM2=(pdbbogo.getPlan_end_hh()*60+pdbbogo.getPlan_end_mm())-(pdbbogo.getPlan_begin_hh()*60+pdbbogo.getPlan_begin_mm());
			int resultHH2=totalHHMM2/60;
			int resultMM2=totalHHMM2%60;																	
%>
	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center"  class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>		
	</td>
	<td align="center" class="line_gray_bottomnright"><%=dateFormat.format(pdb.getRegister())%></td>
	<td align="center" class="line_gray_bottomnright">[<%=pdb.getTitle04()%>]</td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenHoliCon04('item_blockHoliCon04','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>	
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenHoliCon04('item_blockHoliCon04','<%=i%>');" onFocus="this.blur()"><font color="#009900"><%=pdb.getTheday()%></font></a></td>
	<td align="center" class="line_gray_bottomnright"><%=pdb.getPlan_begin_hh()%> : <%=pdb.getPlan_begin_mm()%> ～ <%=pdb.getPlan_end_hh()%> : <%=pdb.getPlan_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright"><%=pdb.getRest_begin_hh()%> : <%=pdb.getRest_begin_mm()%> ～ <%=pdb.getRest_end_hh()%> : <%=pdb.getRest_end_mm()%></td>
	<td align="center" class="line_gray_bottomnright">			

		<a onclick="popupBogo('<%=pdb.getSeq()%>',4);" style="CURSOR: pointer;">	
         	  	<%if(pdb.getSign_ok_yn_kanribu()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
         	  	<%if(pdb.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"  title="差戻し理由:<%=pdb.getSign_no_riyu_kanribu()%>"><%}%> 
		</a>			
	</td>
</tr>
<tr>
	<td   colspan="8" align="center" width="90%" >
		<span id="item_blockHoliCon04<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 5px 0px 0px 0px">休日出勤申請書 </td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(pdbbogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			<tr height="29" >			
				<td align="center" bgcolor="#f7f7f7" width="15%" >所 属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("4")){%>その他<%}%>
					<% if(bushoKind.equals("0")){%>経営役員<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
				<td align="center" bgcolor="#f7f7f7" width="15%">氏 名</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdbbogo.getNm()%></td>
    		</tr>
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getTheday()%></td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=pdbbogo.getPlan_begin_hh()%>時<%=pdbbogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getPlan_end_hh()%>時<%=pdbbogo.getPlan_end_mm()%>分
					（<%=resultHH2%>時 <%=resultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=pdbbogo.getRest_begin_hh()%>時<%=pdbbogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=pdbbogo.getRest_end_hh()%>時<%=pdbbogo.getRest_end_mm()%>分
					（<%=resultHH%>時 <%=resultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdbbogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>							
						</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdbbogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">								    							    	
						    	
	<%
	memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_boss() !=0){		
			if(pdbbogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_bucho2() !=0){		
			if(pdbbogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(pdbbogo.getSign_ok_yn_kanribu() !=0){		
			if(pdbbogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdbbogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdbbogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdbbogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdbbogo.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
<!-----休日出勤報告書 end**************************pdb.getMseq()=seq_hokoku_holiday--------->	
<p>
<% 	DataBeanHokoku beanBogo=mgrHoliHokokuCon.getDbBogo(pdb.getMseq()); %>
<c:set var="beanBogo" value="<%=beanBogo%>"/>			
<c:if test="${! empty beanBogo}">		

<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendar15" style="padding: 10px 0px 0px 0px">休日出勤報告書</td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2px 15px 0px 0px"><%=dateFormat.format(beanBogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2px 5px 10px 5px">	
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2px 0px 2px 10px">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getTheday()%>	</td>				
			</tr>			
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3">
					<%=beanBogo.getPlan_begin_hh()%>時<%=beanBogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>時<%=beanBogo.getPlan_end_mm()%>分
					（<%=bresultHH2%>時 <%=bresultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"> 				
					<%=beanBogo.getRest_begin_hh()%>時<%=beanBogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>時<%=beanBogo.getRest_end_mm()%>分
					（<%=bresultHH%>時 <%=bresultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=beanBogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
							<td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>
					</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2px 2px 2px 0px">
						<table width="80%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
			if(beanBogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
			if(beanBogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">	
	    <%	
		if(beanBogo.getMimg()!=null){		
		 if(!beanBogo.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=beanBogo.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
</c:if>		
		
		
<!-----content end**************************--------->					
		</span>
	</td>
</tr>

<%}
i++;	
}
%>	
</form>			
</c:if>			
	
</table>
<p>

<script language="JavaScript">	
function popupBogo(seq,position){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sign/popup_KinmuBogo.jsp?seq="+seq+"&position="+position; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}	
	
	
</script>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
