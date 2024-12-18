<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripKesaisho" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>
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
	
//出張決裁書	
	DataMgrTripKesaisho mgrHokoku = DataMgrTripKesaisho.getInstance();				
	List listHokoku=mgrHokoku.listSignTrip(mseq,1); 
	List listHokoku02=mgrHokoku.listSignTrip(mseq,2); 	 		
//出張報告書	
	DataMgrTripHokoku mgrTripHokoku = DataMgrTripHokoku.getInstance();					
	 List listTripHokoku=mgrTripHokoku.listSignBo(mseq,1); 
	 List listTripHokoku02=mgrTripHokoku.listSignBo(mseq,2); 	 			 			 	 

	List listCon ;
	Member memSign;
%>
<c:set var="listHokoku" value="<%= listHokoku %>" />	
<c:set var="listHokoku02" value="<%= listHokoku02 %>" />		
<c:set var="listTripHokoku" value="<%= listTripHokoku %>" />
<c:set var="listTripHokoku02" value="<%= listTripHokoku02 %>" />


<script language="javascript">
function ShowHiddenTrip(MenuName, ShowMenuID,kind){ 
	var menu="";
	for ( i = 1; i <= 100;  i++ ){
		if(kind=="trip1"){
			menu= eval("document.all.item_blockTrip" + i + ".style");	
		}else if(kind=="trip2"){
			menu= eval("document.all.item_blockTrip2" + i + ".style");
		}else if(kind=="trip3"){
			menu= eval("document.all.item_blockTrip3" + i + ".style");
		}else if(kind=="trip4"){
			menu= eval("document.all.item_blockTrip4" + i + ".style");
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


<!--申請書/報告書 > 出張決裁書 begin -->
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>		
		<td align="left" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 出張/休日勤務 > 出張決裁書
		</td>						
	</tr>	
</table>	
<table width="95%" cellspacing=0 cellpadding=0>
	<tr bgcolor=#F1F1F1 align=center >	
	    <td class="title_list_all">出張者所属</td>
	    <td class="title_list_m_r">登録日</td>
	    <td class="title_list_m_r">出張者</td>
	    <td class="title_list_m_r">開始日</td>
	    <td class="title_list_m_r">終了日</td>   
	    <td class="title_list_m_r">出張の目的</td>   
	    <td class="title_list_m_r">承認</td>       
	</tr>
<c:if test="${empty listHokoku && empty listHokoku02}">
	<tr height="23">
		<td class="line_gray_b_l_r" colspan="7">---</td>
	</tr>
</c:if>				
<c:if test="${! empty listHokoku}">	
<%
	int i=1;
	Iterator listiterHokoku=listHokoku.iterator();					
	while (listiterHokoku.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterHokoku.next();		
		String bushoKind=pdb.getBusho();			
		listCon=mgrHokoku.listCon(pdb.getSeq());														
		if(pdb.getSeq()!=0){		
%>	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>[<%=pdb.getTitle01()%>]	
	</td>
	<td align="center" class="line_gray_bottomnright">		
			<%=dateFormat.format(pdb.getRegister())%>		
	</td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenTrip('item_blockTrip','<%=i%>','trip1');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip','<%=i%>','trip1');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_begin()%></font></a></td>	
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip','<%=i%>','trip1');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_end()%></font></a></td>
	<td class="line_gray_bottomnright"><%=pdb.getReason()%></td>
	<td align="center" class="line_gray_bottomnright">																	
		<a  href="#" onclick="popupSeq('<%=pdb.getSeq()%>',1);"   onfocus="this.blur()">					
         	  	<%if(pdb.getSign_ok_yn_boss()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
         	  	<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"><%}%>    
		</a>			
	</td>
</tr>

<tr>
	<td  style="padding: 0px 0px 0px 0px;"  colspan="7" align="center" width="90%" >
		<span id="item_blockTrip<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >		
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px">				
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr>
				<td align="center" bgcolor="#ffffff" colspan="4" class="calendar15" style="padding: 3px 0px 3px 0px">出張決裁書</td>							
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" colspan="4" style="padding: 2px 2px 2px 0px">
						<table width="50%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>
							<td width="30%" align="center" bgcolor="#f7f7f7">出張者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getMseq()); 
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
			<tr >
				<td align="" bgcolor="#f7f7f7" width="15%">社員番号</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdb.getReason()%></td>
				<td align="" bgcolor="#f7f7f7" width="15%">出張者所属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("0")){%>その他<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("4")){%>その他<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
    		</tr>
    		<tr>
				<td align="" bgcolor="#f7f7f7" >出張者氏名</td>
				<td align="" bgcolor="#ffffff" ><%=pdb.getNm()%></td>
				<td align="" bgcolor="#f7f7f7" >グレード</td>
				<td align="" bgcolor="#ffffff" ><%=pdb.getGrade()%></td>
			</tr>
			<tr >
				<td align="" bgcolor="#f7f7f7" >パスポート英字氏名</td>
				<td align="" bgcolor="#ffffff"><%=pdb.getPassportName()%></td>
				<td align="" bgcolor="#f7f7f7">危険度</td>		
				<td bgcolor="#ffffff" ><%=pdb.getDanger()%></td>							
    		</tr>
    		<tr >
				<td align="" bgcolor="#f7f7f7">出張期間</td>
				<td bgcolor="#ffffff"><%=pdb.getDuring_begin()%> ～ <%=pdb.getDuring_end()%></td>
				<td align="" bgcolor="#f7f7f7" >出向先(国または県）</td>		
				<td bgcolor="#ffffff" ><%=pdb.getDestination()%></td>
    		</tr>		
			<tr >
				<td align="" bgcolor="#f7f7f7">出向先の情報<br>&nbsp;&nbsp;(HomePage)</td>
				<td bgcolor="#ffffff"><%=pdb.getDestination_info()%></td>
				<td align="" bgcolor="#f7f7f7">渡航先での自動車<br>&nbsp;&nbsp;運転の有無</td>
				<td bgcolor="#ffffff"><%=pdb.getDrive_yn()%></td>
			</tr>
			<tr >
				<td align="" bgcolor="#f7f7f7">出張の目的</td>
				<td align="left" bgcolor="#ffffff"><%=pdb.getReason()%></td>
				<td align="" bgcolor="#f7f7f7">備考:</td>
				<td align="left" bgcolor="#ffffff"><%=pdb.getComment()%></td>				
			</tr>	
			<tr >
				<td align="" bgcolor="#f7f7f7">出張スケジュール</td>
				<td bgcolor="#ffffff" colspan="3">
					<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr height="20" align="center">
							<td bgcolor="#f7f7f7" width="20%">日付(曜日)</td>							
							<td bgcolor="#f7f7f7" width="80%">摘要</td>
						</tr>
	
	<c:set var="listCon" value="<%=listCon %>" />					
	<c:if test="${!empty listCon}">
				<%	int ii=1;
					Iterator listiter2=listCon.iterator();					
						while (listiter2.hasNext()){
						DataBeanHokoku dbCon=(DataBeanHokoku)listiter2.next();
						int seqq=dbCon.getSeq();
											
				%>					
						<tr>
							<td align="center" bgcolor="#ffffff"><%=dbCon.getSche_date()%></td>							
							<td align="left" bgcolor="#ffffff"><%=dbCon.getSche_comment()%></td>
						</tr>	
				
				<%
				ii++;
				}%>	
			</c:if>
			<c:if test="${empty listCon}">
				--
			</c:if>											
																
					</table>
				</td>								
			</tr>					
		</table>
		</td>								
	</tr>					
	</table>
<!-----content end**************************--------->					
		</span>
	</td>
</tr>
	
<%}
i++;	
}
%>			
</c:if>
<c:if test="${! empty listHokoku02}">	
<%
	int i=1;
	Iterator listiterHokoku2=listHokoku02.iterator();					
	while (listiterHokoku2.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterHokoku2.next();		
		String bushoKind=pdb.getBusho();			
		listCon=mgrHokoku.listCon(pdb.getSeq());														
		if(pdb.getSeq()!=0){		
%>	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>[<%=pdb.getTitle02()%>]	
	</td>
	<td align="center" class="line_gray_bottomnright">		
			<%=dateFormat.format(pdb.getRegister())%>		
	</td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenTrip('item_blockTrip2','<%=i%>','trip2');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip2','<%=i%>','trip2');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_begin()%></font></a></td>	
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip2','<%=i%>','trip2');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_end()%></font></a></td>
	<td class="line_gray_bottomnright"><%=pdb.getReason()%></td>
	<td align="center" class="line_gray_bottomnright">																	
		<a  href="#" onclick="popupSeq('<%=pdb.getSeq()%>',2);"   onfocus="this.blur()">					
         	  	<%if(pdb.getSign_ok_yn_bucho()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
         	  	<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"><%}%>    
		</a>			
	</td>
</tr>

<tr>
	<td  style="padding: 0px 0px 0px 0px;"  colspan="7" align="center" width="90%" >
		<span id="item_blockTrip2<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >		
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px">				
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr>
				<td align="center" bgcolor="#ffffff" colspan="4" class="calendar15" style="padding: 3px 0px 3px 0px">出張決裁書</td>							
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" colspan="4" style="padding: 2px 2px 2px 0px">
						<table width="50%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>
							<td width="30%" align="center" bgcolor="#f7f7f7">出張者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle"  title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getMseq()); 
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
			<tr >
				<td align="" bgcolor="#f7f7f7" width="15%">社員番号</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdb.getReason()%></td>
				<td align="" bgcolor="#f7f7f7" width="15%">出張者所属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("0")){%>その他<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("4")){%>その他<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
    		</tr>
    		<tr>
				<td align="" bgcolor="#f7f7f7" >出張者氏名</td>
				<td align="" bgcolor="#ffffff" ><%=pdb.getNm()%></td>
				<td align="" bgcolor="#f7f7f7" >グレード</td>
				<td align="" bgcolor="#ffffff" ><%=pdb.getGrade()%></td>
			</tr>
			<tr >
				<td align="" bgcolor="#f7f7f7" >パスポート英字氏名</td>
				<td align="" bgcolor="#ffffff"><%=pdb.getPassportName()%></td>
				<td align="" bgcolor="#f7f7f7">危険度</td>		
				<td bgcolor="#ffffff" ><%=pdb.getDanger()%></td>							
    		</tr>
    		<tr >
				<td align="" bgcolor="#f7f7f7">出張期間</td>
				<td bgcolor="#ffffff"><%=pdb.getDuring_begin()%> ～ <%=pdb.getDuring_end()%></td>
				<td align="" bgcolor="#f7f7f7" >出向先(国または県）</td>		
				<td bgcolor="#ffffff" ><%=pdb.getDestination()%></td>
    		</tr>		
			<tr >
				<td align="" bgcolor="#f7f7f7">出向先の情報<br>&nbsp;&nbsp;(HomePage)</td>
				<td bgcolor="#ffffff"><%=pdb.getDestination_info()%></td>
				<td align="" bgcolor="#f7f7f7">渡航先での自動車<br>&nbsp;&nbsp;運転の有無</td>
				<td bgcolor="#ffffff"><%=pdb.getDrive_yn()%></td>
			</tr>
			<tr >
				<td align="" bgcolor="#f7f7f7">出張の目的</td>
				<td align="left" bgcolor="#ffffff"><%=pdb.getReason()%></td>
				<td align="" bgcolor="#f7f7f7">備考:</td>
				<td align="left" bgcolor="#ffffff"><%=pdb.getComment()%></td>				
			</tr>	
			<tr >
				<td align="" bgcolor="#f7f7f7">出張スケジュール</td>
				<td bgcolor="#ffffff" colspan="3">
					<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr height="20" align="center">
							<td bgcolor="#f7f7f7" width="20%">日付(曜日)</td>							
							<td bgcolor="#f7f7f7" width="80%">摘要</td>
						</tr>
	
	<c:set var="listCon" value="<%=listCon %>" />					
	<c:if test="${!empty listCon}">
				<%	int ii=1;
					Iterator listiter2=listCon.iterator();					
						while (listiter2.hasNext()){
						DataBeanHokoku dbCon=(DataBeanHokoku)listiter2.next();
						int seqq=dbCon.getSeq();
											
				%>					
						<tr>
							<td align="center" bgcolor="#ffffff"><%=dbCon.getSche_date()%></td>							
							<td align="left" bgcolor="#ffffff"><%=dbCon.getSche_comment()%></td>
						</tr>	
				
				<%
				ii++;
				}%>	
			</c:if>
			<c:if test="${empty listCon}">
				--
			</c:if>											
																
					</table>
				</td>								
			</tr>					
		</table>
		</td>								
	</tr>					
	</table>
<!-----content end**************************--------->					
		</span>
	</td>
</tr>
	
<%}
i++;	
}
%>			
</c:if>
</table>
</form>
<div class="clear_margin"></div>	
	
	
<!--申請書/報告書 > 出張報告書 管理 begin -->
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>		
		<td align="left" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 出張/休日勤務 > 出張報告書
		</td>					
	</tr>	
</table>	
<table width="95%" cellspacing=0 cellpadding=0>
<tr bgcolor=#F1F1F1 align=center >	
    <td class="title_list_all">出張者所属</td>
    <td class="title_list_m_r">登録日</td>
    <td class="title_list_m_r">出張者</td>
    <td class="title_list_m_r">開始日</td>
    <td class="title_list_m_r">終了日</td>   
    <td class="title_list_m_r">出張の目的</td>   
    <td class="title_list_m_r">承認</td>       
</tr>

<c:if test="${empty listTripHokoku && empty listTripHokoku02}">
	<tr height="23">
		<td class="line_gray_b_l_r" colspan="7">---</td>
	</tr>
</c:if>				
<c:if test="${! empty listTripHokoku}">	
<%
	int i=1;
	Iterator listiterHokoku3=listTripHokoku.iterator();					
	while (listiterHokoku3.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterHokoku3.next();		
		String bushoKind=pdb.getBusho();			
	//	listCon=mgrHokoku.listCon(pdb.getSeq());														
		if(pdb.getSeq()!=0){		
%>	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>[<%=pdb.getTitle01()%>]	
	</td>
	<td align="center" class="line_gray_bottomnright"><%=dateFormat.format(pdb.getRegister())%></td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenTrip('item_blockTrip3','<%=i%>','trip3');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip02','<%=i%>','trip3');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_begin()%></font></a> </td>	
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip02','<%=i%>','trip3');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_end()%></font></a> </td>
	<td class="line_gray_bottomnright"><%=pdb.getReason()%></td>
	<td align="center" class="line_gray_bottomnright">			
		<a  href="#" onclick="popupSeq02('<%=pdb.getSeq()%>',1);"   onfocus="this.blur()">				
			<%if(pdb.getSign_ok_yn_boss()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
		      	<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"><%}%>		    	
		</a>			
	</td>
</tr>

<tr>
	<td   colspan="7" align="center" width="90%" >
		<span id="item_blockTrip3<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >		
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px">				
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr>
				<td align="center" bgcolor="#ffffff" colspan="4" class="calendar15" style="padding: 3px 0px 3px 0px">出張報告書</td>							
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" colspan="4" style="padding: 2px 2px 2px 0px">
						<table width="50%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>
							<td width="30%" align="center" bgcolor="#f7f7f7">出張者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getMseq()); 
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
			<tr >
				<td align="center" bgcolor="#f7f7f7" width="15%" >出張者氏名</td>
				<td align="" bgcolor="#ffffff" width="45%"><%=pdb.getNm()%></td>
				<td align="center" bgcolor="#f7f7f7" width="15%">所属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("4")){%>その他<%}%>
					<% if(bushoKind.equals("0")){%>経営役員<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
    		</tr>
    		<tr>
				<td align="center" bgcolor="#f7f7f7" >出張先</td>		
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getDestination()%></td>
			</tr>		
    		<tr >
				<td align="center" bgcolor="#f7f7f7">出張期間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getDuring_begin()%> ～ <%=pdb.getDuring_end()%></td>				
    		</tr>			
			<tr >
				<td align="center" bgcolor="#f7f7f7">出張目的</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getReason()%></td>				
			</tr>	
			<tr >
				<td align="left"  bgcolor="#ffffff" colspan="4">実施事項<br>
					<%=pdb.getComment()%>					
				</td>											
			</tr>
		</table>
		</td>								
	</tr>					
	</table>
<!-----content end**************************--------->					
		</span>
	</td>
</tr>
	
<%}
i++;	
}
%>			
</c:if>
<c:if test="${! empty listTripHokoku02}">	
<%
	int i=1;
	Iterator listiterHokoku4=listTripHokoku02.iterator();					
	while (listiterHokoku4.hasNext()){
		DataBeanHokoku pdb=(DataBeanHokoku)listiterHokoku4.next();		
		String bushoKind=pdb.getBusho();			
	//	listCon=mgrHokoku.listCon(pdb.getSeq());														
		if(pdb.getSeq()!=0){		
%>	
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="line_gray_b_l_r">
		<% if(bushoKind.equals("4")){%>その他<%}%>	
		<% if(bushoKind.equals("0")){%>経営役員<%}%>	
		<% if(bushoKind.equals("1")){%>品質管理部<%}%>
		<% if(bushoKind.equals("2")){%>製造部<%}%>
		<% if(bushoKind.equals("3")){%>管理部<%}%>	
		<% if(bushoKind.equals("no data")){%>その他<%}%>[<%=pdb.getTitle02()%>]	
	</td>
	<td align="center" class="line_gray_bottomnright"><%=dateFormat.format(pdb.getRegister())%></td>
	<td align="center" class="line_gray_bottomnright">
		<a href="javascript:ShowHiddenTrip('item_blockTrip4','<%=i%>','trip4');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getNm()%></font>
		</a> 
	</td>
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip4','<%=i%>','trip4');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_begin()%></font></a> </td>	
	<td align="center" class="line_gray_bottomnright"><a href="javascript:ShowHiddenTrip('item_blockTrip4','<%=i%>','trip4');" onFocus="this.blur()"><font color="#009900"><%=pdb.getDuring_end()%></font></a> </td>
	<td class="line_gray_bottomnright"><%=pdb.getReason()%></td>
	<td align="center" class="line_gray_bottomnright">			
		<a  href="#" onclick="popupSeq02('<%=pdb.getSeq()%>',2);"   onfocus="this.blur()">				
			<%if(pdb.getSign_ok_yn_bucho()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"><%}%>
		      	<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle"><%}%>		    	
		</a>			
	</td>
</tr>

<tr>
	<td   colspan="7" align="center" width="90%" >
		<span id="item_blockTrip4<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">	
		<table width="85%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >		
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px">				
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr>
				<td align="center" bgcolor="#ffffff" colspan="4" class="calendar15" style="padding: 3px 0px 3px 0px">出張報告書</td>							
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" colspan="4" style="padding: 2px 2px 2px 0px">
						<table width="50%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>
							<td width="30%" align="center" bgcolor="#f7f7f7">出張者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="差戻し理由(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=manager.getDbMseq(pdb.getMseq()); 
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
			<tr >
				<td align="center" bgcolor="#f7f7f7" width="15%" >出張者氏名</td>
				<td align="" bgcolor="#ffffff" width="45%"><%=pdb.getNm()%></td>
				<td align="center" bgcolor="#f7f7f7" width="15%">所属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoKind.equals("4")){%>その他<%}%>
					<% if(bushoKind.equals("0")){%>経営役員<%}%>		
					<% if(bushoKind.equals("1")){%>品質管理部<%}%>
					<% if(bushoKind.equals("2")){%>製造部<%}%>
					<% if(bushoKind.equals("3")){%>管理部<%}%>	
					<% if(bushoKind.equals("no data")){%>その他<%}%>
				</td>
    		</tr>
    		<tr>
				<td align="center" bgcolor="#f7f7f7" >出張先</td>		
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getDestination()%></td>
			</tr>		
    		<tr >
				<td align="center" bgcolor="#f7f7f7">出張期間</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getDuring_begin()%> ～ <%=pdb.getDuring_end()%></td>				
    		</tr>			
			<tr >
				<td align="center" bgcolor="#f7f7f7">出張目的</td>
				<td align="left" bgcolor="#ffffff" colspan="3"><%=pdb.getReason()%></td>				
			</tr>	
			<tr >
				<td align="left"  bgcolor="#ffffff" colspan="4">実施事項<br>
					<%=pdb.getComment()%>					
				</td>											
			</tr>
		</table>
		</td>								
	</tr>					
	</table>
<!-----content end**************************--------->					
		</span>
	</td>
</tr>
	
<%}
i++;	
}
%>			
</c:if>
</table>

<script language="JavaScript">	
function popupSeq(seq,position){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sign/popup_HokokuView.jsp?seq="+seq+"&position="+position; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}	

function popupSeq02(seq,position){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sign/popup_Hokoku02View.jsp?seq="+seq+"&position="+position; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}	
</script>
	

	
	
	
	
	
	
	
	
	
	
	
	
	
