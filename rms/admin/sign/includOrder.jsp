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
static int PAGE_SIZE=15; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
NumberFormat numFormat = NumberFormat.getNumberInstance(); 
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
	MgrOrderBunsho mgrOrder = MgrOrderBunsho.getInstance();	
	List listOrder=mgrOrder.listSignOrder(mseq,1); 
	List listOrder01=mgrOrder.listSignOrder(mseq,2); 		 	 
	List listOrder02=mgrOrder.listSignOrder(mseq,3); 		 
			 			 	 
	List listCon ;
	Member memSign;
%>	
<c:set var="listOrder" value="<%= listOrder%>" />
<c:set var="listOrder01" value="<%= listOrder01 %>" />	
<c:set var="listOrder02" value="<%= listOrder02 %>" />



<script language="javascript">
function ShowHidden(MenuName, ShowMenuID,kind){
	var menu="";
	for ( i = 1; i <= 100;  i++ ){
		if(kind=="block_listOrder01"){
			menu= eval("document.all.block_listOrder01" + i + ".style");	
		}else if(kind=="block_listOrder02"){
			menu= eval("document.all.block_listOrder02" + i + ".style");
		}else if(kind=="block_listOrder"){
			menu= eval("document.all.block_listOrder" + i + ".style");
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

<!--Purchase Order begin ---------------------------->
<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>		
		<td align="left" class="calendar16_1">
			<img src="<%=urlPage%>orms/images/common/jirusi.gif" align="absmiddle"> 社内用品発注依頼書</td>			
	</tr>	
</table>	
<table width="95%" cellspacing=0 cellpadding=0>	
<tr height=29 bgcolor=#F1F1F1 align=center >	
    	<td  class="title_list_all" width="12%">日付</td>		
	<td  class="title_list_m_r" width="8%">注文予定日</td>
	<td  class="title_list_m_r" width="20%">タイトル</td>
	<td  class="title_list_m_r" width="15%">発注先</td>
	<td  class="title_list_m_r" width="10%">登録者氏名</td>
	<td  class="title_list_m_r" width="5%">商品種類</td>
      <td class="title_list_m_r" width="10%">承認</td>       
</tr>
<!--담당자******************************************************************************************************-->	
<c:if test="${empty listOrder && empty listOrder01 && empty listOrder02}">	
	<tr height=23>
		<td colspan="7" class="line_gray_b_l_r">---</td>
	</tr>
</c:if>	
<c:if test="${! empty listOrder}">	
<form name="frmOrder01"  method="post" >		
<%	int i=1; 
	Iterator listiter=listOrder.iterator();					
		while (listiter.hasNext()){
			BeanOrderBunsho pdb=(BeanOrderBunsho)listiter.next();
			int seq=pdb.getSeq();											
			if(seq!=0){	
				String yymmdd=dateFormat.format(pdb.getRegister());
				int del_yn=pdb.getDel_yn();  //삭제여부 2는 삭제요청, 1은 기본
				listCon=mgrOrder.listItem(seq);	
							
%>	
	<input type="hidden" name="positionCon<%=pdb.getSeq()%>" value="1">	
<tr  height=23 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td  class="line_gray_b_l_r"><font color="#CC0099">[担当者]</font> <%=yymmdd%>	</td>
	<td align="center" class="line_gray_bottomnright">
		<a class="fileline" href="javascript:ShowHidden('block_listOrder','<%=i%>','block_listOrder');"  onFocus="this.blur()">
			<font color="#007AC3"><%=pdb.getHizuke()%></font>
		</a> 
	</td>
	<td align="left" class="line_gray_bottomnright">
		<%if(pdb.getTitle()!=null){%>
				<a class="fileline" href="javascript:ShowHidden('block_listOrder','<%=i%>','block_listOrder');"  onFocus="this.blur()"><font color="#CC6600"><%=pdb.getTitle()%></font></a>&nbsp;<%}else{%>-<%}%></td>
	<td class="line_gray_bottomnright"><%if(pdb.getContact_order()!=null){%><%=pdb.getContact_order()%>&nbsp;<%}else{%>-<%}%>   </td>				
	<td class="line_gray_bottomnright">
		<%if(pdb.getMseq()!=0){memSign=manager.getDbMseq(pdb.getMseq());	%>
		<%=memSign.getNm()%>
		<%}else{%>--<%}%>
	</td>				
	<td class="line_gray_bottomnright"><%=pdb.getQty()%>&nbsp;</td>												
	<td align="center" class="line_gray_bottomnright">
		<%if(pdb.getDel_yn()==1){%> 					
			<a onclick="popupOrderBox('<%=seq%>',1);" style="CURSOR: pointer;">	
	         	  	<%if(pdb.getSign_01_yn()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle" title="決裁"><%}%>
	         	  	<%if(pdb.getSign_01_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_01()%>"><%}%> 
			</a>		
		<%}%>
		<%if(pdb.getDel_yn()==2){%> 	        	
				削除要請中です。
	      <%}%> 		
	</td>
</tr>
<tr>
	<td   colspan="7" align="center" width="90%" >							
		<span id="block_listOrder<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:5px 0px 5px 0px;">					
<table width="85%"  border="2" cellpadding=0 cellspacing=0 bordercolor="#9D8864" >			
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px;">
				<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
				<tr>
					<td align="center" colspan="3" bgcolor="#ffffff"   style="padding: 10px 0px 3px 0px;">
						<table width="100%"  border=0 cellpadding=0 cellspacing=0 >			
						<tr>
							<td align="center" class="calendar15" style="padding: 3px 0px 3px 0px;">社内用品発注依頼書</td>
						</tr>
						</table>
					</td>										
				</tr>
				<tr>
					<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">
							<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
							<tr bgcolor="" align=center height=26>	
								<td width="50%"><%if(pdb.getKind_urgency()==2){%><font color="#CC6600">◎</font> <%}else{%>&nbsp;<%}%></td>
								<td width="50%">至急</td>
							</tr>
							<tr bgcolor="" align=center height=26>	
								<td width="50%"><%if(pdb.getKind_urgency()==1){%><font color="#CC6600">◎</font><%}else{%>&nbsp;<%}%></td>
								<td width="50%">普通</td>
							</tr>
							</table>								
					</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">&nbsp;</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">
							<table width="100%"  border=0 cellpadding=0 cellspacing=0  >			
							<tr>
								<td align="right" style="padding: 3px 0px 3px 0px;">
								<%=pdb.getHizuke().substring(0,4)%>年 <%=pdb.getHizuke().substring(5,7)%>月 <%=pdb.getHizuke().substring(8,10)%>日</td>	
							</tr>
							<tr>
								<td align="left" style="padding: 3px 0px 3px 0px;">
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
					<td colspan="3" width="30%" align="left"  style="padding: 3px 0px 3px 0px;" class="calendar15">
						発注先：  <%=pdb.getContact_order()%>						
					</td>							
				</tr>									
				<tr>
					<td colspan="3" align="center" style="padding: 3px 0px 3px 0px;">
						<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor=#F1F1F1 align=center height=26>	
							<td >品名</td>
							<td >発注NO.</td>
							<td >発注数</td>
							<td >単価 (\)</td>
							<td >価格 (\)</td>
							<td >依頼者</td>
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
							<td ><%=dbCon.getProduct_nm()%></td>
							<td ><%=dbCon.getOrder_no()%></td>
							<td  align="center"><%=dbCon.getProduct_qty()%></td>
							<td  align="right"><%=numFormat.format(dbCon.getUnit_price())%> </td>
							<td  align="right"><%=numFormat.format(pprice)%></td>
							<td align="center">
					<%if(dbCon.getClient_nm()!=0){
						memSign=manager.getDbMseq(dbCon.getClient_nm());
					%>
						<%=memSign.getNm()%>
					
					<%}else{%>--<%}%></td>
						</tr>					
				<%
				ii++;
				}%>	
							<tr>								
								<td colspan="6" >備　考 :  <%if(pdb.getComment()==null){%>&nbsp;  <%}else{%><%=pdb.getComment()%> <%}%></td>	
							</tr>
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0 50 0 0; font-size:14px" ><font  color="#669900">合計  :   \   <%=numFormat.format(totalPriceOrder)%></font></td>	
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
								<td colspan="6" >備　考 : &nbsp; </td>	
							</tr>				
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0 10 0 0; font-size:14px" ><font  color="#669900">合計  :  \  0 </font></td>	
							</tr>
			</c:if>	
													
																	
						</table>																			
					</td>							
				</tr>
				<tr>
					<td colspan="3" width="30%" align="left"  style="padding: 3 0 3 0;" >
							<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
								<tr>
									<td width="70%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>	
									<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
											<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
											<tr bgcolor="" align=center height=26 >													
												<td width="50%">部長</td>
												<td width="50%">注文者</td>
											</tr>
											<tr bgcolor="" align=center height=50>												
												<td >
	<%
		memSign=manager.getDbMseq(pdb.getSign_02()); 
		if(memSign!=null){		
		 if(pdb.getSign_02_yn() !=0){		
			if(pdb.getSign_02_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_02_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 	
	<%}}else{%>--<%}%>										
												</td>			
												<td>
	<%
		memSign=manager.getDbMseq(pdb.getSign_03()); 
		if(memSign!=null){		
		 if(pdb.getSign_03_yn() !=0){		
			if(pdb.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>確認済<%}%>
			<%}%>
			<%if(pdb.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 	
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
		</span>
	</td>
</tr>

<%}
i++;	
}
%>	
</form>			
</c:if>	
	
<!--01******************************************************************************************************-->	

<c:if test="${! empty listOrder01}">	
<form name="frmOrder02"  method="post" >		
<%	int i=1; 
	Iterator listiter=listOrder01.iterator();					
		while (listiter.hasNext()){
			BeanOrderBunsho pdb=(BeanOrderBunsho)listiter.next();
			int seq=pdb.getSeq();											
			if(seq!=0){	
				String yymmdd=dateFormat.format(pdb.getRegister());
				int del_yn=pdb.getDel_yn();  //삭제여부 2는 삭제요청, 1은 기본
				listCon=mgrOrder.listItem(seq);	
							
%>	
	<input type="hidden" name="positionCon<%=pdb.getSeq()%>" value="1">	
<tr  height=23 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td  class="line_gray_b_l_r"><font color="#CC0099">[部長]</font> <%=yymmdd%>	</td>
	<td align="center" class="line_gray_bottomnright">
		<a class="fileline" href="javascript:ShowHidden('block_listOrder01','<%=i%>','block_listOrder01');"  onFocus="this.blur()">
			<font color="#007AC3"><%=pdb.getHizuke()%></font>
		</a> 
	</td>
	<td align="left" class="line_gray_bottomnright">
		<%if(pdb.getTitle()!=null){%>
				<a class="fileline" href="javascript:ShowHidden('block_listOrder01','<%=i%>','block_listOrder01');"  onFocus="this.blur()"><font color="#CC6600"><%=pdb.getTitle()%></font></a>&nbsp;<%}else{%>-<%}%></td>
	<td class="line_gray_bottomnright"><%if(pdb.getContact_order()!=null){%><%=pdb.getContact_order()%>&nbsp;<%}else{%>-<%}%>   </td>				
	<td class="line_gray_bottomnright">
		<%if(pdb.getMseq()!=0){memSign=manager.getDbMseq(pdb.getMseq());	%>
		<%=memSign.getNm()%>
		<%}else{%>--<%}%>
	</td>				
	<td class="line_gray_bottomnright"><%=pdb.getQty()%>&nbsp;</td>												
	<td align="center" class="line_gray_bottomnright">
		<%if(pdb.getDel_yn()==1){%> 					
			<a onclick="popupOrderBox('<%=seq%>',2);" style="CURSOR: pointer;">	
	         	  	<%if(pdb.getSign_02_yn()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle" title="決裁"><%}%>
	         	  	<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 
			</a>		
		<%}%>		
	        <%if(pdb.getDel_yn()==2){%> 
	        	<a href="javascript:goDelete('<%=seq%>')"  onfocus="this.blur()">	  
				<font color="#CC0099">[削除要請]</font></a>
         	  <%}%> 		
	</td>
</tr>
<tr>
	<td   colspan="7" align="center" width="90%" >							
		<span id="block_listOrder01<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:5px 0px 5px 0px;">					
<table width="85%"  border="2" cellpadding=0 cellspacing=0 bordercolor="#9D8864" >			
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px;">
				<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
				<tr>
					<td align="center" colspan="3" bgcolor="#ffffff"   style="padding: 10px 0px 3px 0px;">
						<table width="100%"  border=0 cellpadding=0 cellspacing=0 >			
						<tr>
							<td align="center" class="calendar15" style="padding: 3px 0px 3px 0px;">社内用品発注依頼書</td>
						</tr>
						</table>
					</td>										
				</tr>
				<tr>
					<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">
							<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
							<tr bgcolor="" align=center height=26>	
								<td width="50%"><%if(pdb.getKind_urgency()==2){%><font color="#CC6600">◎</font> <%}else{%>&nbsp;<%}%></td>
								<td width="50%">至急</td>
							</tr>
							<tr bgcolor="" align=center height=26>	
								<td width="50%"><%if(pdb.getKind_urgency()==1){%><font color="#CC6600">◎</font><%}else{%>&nbsp;<%}%></td>
								<td width="50%">普通</td>
							</tr>
							</table>								
					</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">&nbsp;</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">
							<table width="100%"  border=0 cellpadding=0 cellspacing=0  >			
							<tr>
								<td align="right" style="padding: 3px 0px 3px 0px;">
								<%=pdb.getHizuke().substring(0,4)%>年 <%=pdb.getHizuke().substring(5,7)%>月 <%=pdb.getHizuke().substring(8,10)%>日</td>	
							</tr>
							<tr>
								<td align="left" style="padding: 3px 0px 3px 0px;">
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
					<td colspan="3" width="30%" align="left"  style="padding: 3px 0px 3px 0px;" class="calendar15">
						発注先：  <%=pdb.getContact_order()%>						
					</td>							
				</tr>									
				<tr>
					<td colspan="3" align="center" style="padding: 3px 0px 3px 0px;">
						<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor=#F1F1F1 align=center height=26>	
							<td >品名</td>
							<td >発注NO.</td>
							<td >発注数</td>
							<td >単価 (\)</td>
							<td >価格 (\)</td>
							<td >依頼者</td>
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
							<td ><%=dbCon.getProduct_nm()%></td>
							<td ><%=dbCon.getOrder_no()%></td>
							<td  align="center"><%=dbCon.getProduct_qty()%></td>
							<td  align="right"><%=numFormat.format(dbCon.getUnit_price())%> </td>
							<td  align="right"><%=numFormat.format(pprice)%></td>
							<td align="center">
					<%if(dbCon.getClient_nm()!=0){
						memSign=manager.getDbMseq(dbCon.getClient_nm());
					%>
						<%=memSign.getNm()%>
					
					<%}else{%>--<%}%></td>
						</tr>					
				<%
				ii++;
				}%>	
							<tr>								
								<td colspan="6" >備　考 :  <%if(pdb.getComment()==null){%>&nbsp;  <%}else{%><%=pdb.getComment()%> <%}%></td>	
							</tr>
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0 50 0 0; font-size:14px" ><font  color="#669900">合計  :   \   <%=numFormat.format(totalPriceOrder)%></font></td>	
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
								<td colspan="6" >備　考 : &nbsp; </td>	
							</tr>				
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0 10 0 0; font-size:14px" ><font  color="#669900">合計  :  \  0 </font></td>	
							</tr>
			</c:if>	
													
																	
						</table>																			
					</td>							
				</tr>
				<tr>
					<td colspan="3" width="30%" align="left"  style="padding: 3 0 3 0;" >
							<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
								<tr>
									<td width="70%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>	
									<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
											<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
											<tr bgcolor="" align=center height=26 >													
												<td width="50%">部長</td>
												<td width="50%">注文者</td>
											</tr>
											<tr bgcolor="" align=center height=50>												
												<td >
	<%
		memSign=manager.getDbMseq(pdb.getSign_02()); 
		if(memSign!=null){		
		 if(pdb.getSign_02_yn() !=0){		
			if(pdb.getSign_02_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_02_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 	
	<%}}else{%>--<%}%>										
												</td>			
												<td>
	<%
		memSign=manager.getDbMseq(pdb.getSign_03()); 
		if(memSign!=null){		
		 if(pdb.getSign_03_yn() !=0){		
			if(pdb.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>確認済<%}%>
			<%}%>
			<%if(pdb.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 	
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
		</span>
	</td>
</tr>

<%}
i++;	
}
%>	
</form>			
</c:if>	
	
	
		
<!--02* 시작---------------------------------------------*********-->

<c:if test="${! empty listOrder02}">	
<form name="frmOrder03"  method="post" >	
<%	int i=1; 
	Iterator listiter=listOrder02.iterator();					
		while (listiter.hasNext()){
			BeanOrderBunsho pdb=(BeanOrderBunsho)listiter.next();
			int seq=pdb.getSeq();											
			if(seq!=0){	
				String yymmdd=dateFormat.format(pdb.getRegister());
				int del_yn=pdb.getDel_yn();  //삭제여부 2는 삭제요청, 1은 기본
				listCon=mgrOrder.listItem(seq);							
%>
	<input type="hidden" name="divPass" value="popupHoliCon02_<%=pdb.getSeq()%>">		
<tr height=23 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
	<td align="center" class="line_gray_b_l_r"><font color="#CC0099">[注文者]</font> <%=yymmdd%></td>
	<td align="center" class="line_gray_bottomnright">
		<a class="fileline" href="javascript:ShowHidden('block_listOrder02','<%=i%>','block_listOrder02');"  onFocus="this.blur()">
			<font color="#007AC3"><%=pdb.getHizuke()%></font>
		</a> 
	</td>
	<td align="left" class="line_gray_bottomnright"><%if(pdb.getTitle()!=null){%>
		<a class="fileline" href="javascript:ShowHidden('block_listOrder02','<%=i%>','block_listOrder02');"  onFocus="this.blur()"><font color="#CC6600"><%=pdb.getTitle()%></font></a>&nbsp;<%}else{%>-<%}%></td>
	<td class="line_gray_bottomnright"><%if(pdb.getContact_order()!=null){%><%=pdb.getContact_order()%>&nbsp;<%}else{%>-<%}%>   </td>				
	<td class="line_gray_bottomnright">
		<%if(pdb.getMseq()!=0){memSign=manager.getDbMseq(pdb.getMseq());	%>
		<%=memSign.getNm()%>
		<%}else{%>--<%}%>
	</td>				
	<td class="line_gray_bottomnright"><%=pdb.getQty()%>&nbsp;</td>					
	<td class="line_gray_bottomnright" align="center" >		
		 <%if(pdb.getDel_yn()==1){%> <font color="#CC0099">[注文中]</font>										
		 	 <a onclick="popupOrderBox('<%=seq%>',3);" style="CURSOR: pointer;">	
	         	  	<%if(pdb.getSign_03_yn()==1){%><img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle" title="決裁"><%}%>
	         	  	<%if(pdb.getSign_03_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_03()%>"><%}%> 
			</a>		 	          	  		
         	  <%}%>         	  		
	        <%if(pdb.getDel_yn()==2){%> 	        	
				削除要請中です。
	      	  <%}%> 
		</a>			
	</td>
</tr>
<tr>
	<td  colspan="7" align="center" width="90%">
		<span id="block_listOrder02<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#eeeeee;padding:5px 0px 5px 0px;">			
		<table width="85%"  border="2" cellpadding=0 cellspacing=0 bordercolor="#EBEBD8" >			
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px">
				<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
				<tr>
					<td align="center" colspan="3" bgcolor="#ffffff"   style="padding: 10px 0px 3px 0px;">
						<table width="100%"  border=0 cellpadding=0 cellspacing=0 >			
						<tr>
							<td align="center" class="calendar15" style="padding: 3px 0px 3px 0px;">社内用品発注依頼書</td>
						</tr>
						</table>
					</td>										
				</tr>
				<tr>
					<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">
							<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
							<tr bgcolor="" align=center height=26>	
								<td width="50%"><%if(pdb.getKind_urgency()==2){%><font color="#CC6600">◎</font> <%}else{%>&nbsp;<%}%></td>
								<td width="50%">至急</td>
							</tr>
							<tr bgcolor="" align=center height=26>	
								<td width="50%"><%if(pdb.getKind_urgency()==1){%><font color="#CC6600">◎</font><%}else{%>&nbsp;<%}%></td>
								<td width="50%">普通</td>
							</tr>
							</table>								
					</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">&nbsp;</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">
							<table width="100%"  border=0 cellpadding=0 cellspacing=0  >			
							<tr>
								<td align="right" style="padding: 3px 0px 3px 0px;">
								<%=pdb.getHizuke().substring(0,4)%>年 <%=pdb.getHizuke().substring(5,7)%>月 <%=pdb.getHizuke().substring(8,10)%>日</td>	
							</tr>
							<tr>
								<td align="left" style="padding: 3px 0px 3px 0px;">
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
					<td colspan="3" width="30%" align="left"  style="padding: 3px 0px 3px 0px;" class="calendar15">
						発注先：  <%=pdb.getContact_order()%>						
					</td>							
				</tr>									
				<tr>
					<td colspan="3" align="center" style="padding: 3px 0px 3px 0px;">
						<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor=#F1F1F1 align=center height=26>	
							<td >品名</td>
							<td >発注NO.</td>
							<td >発注数</td>
							<td >単価 (\)</td>
							<td >価格 (\)</td>
							<td >依頼者</td>
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
							<td ><%=dbCon.getProduct_nm()%></td>
							<td ><%=dbCon.getOrder_no()%></td>
							<td  align="center"><%=dbCon.getProduct_qty()%></td>
							<td  align="right"><%=numFormat.format(dbCon.getUnit_price())%> </td>
							<td  align="right"><%=numFormat.format(pprice)%></td>
							<td align="center">
					<%if(dbCon.getClient_nm()!=0){
						memSign=manager.getDbMseq(dbCon.getClient_nm());
					%>
						<%=memSign.getNm()%>
					
					<%}else{%>--<%}%></td>
						</tr>					
				<%
				ii++;
				}%>	
							<tr>								
								<td colspan="6" >備　考 :  <%if(pdb.getComment()==null){%>&nbsp;  <%}else{%><%=pdb.getComment()%> <%}%></td>	
							</tr>
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0px 50px 0px 0px; font-size:14px" ><font  color="#669900">合計  :   \   <%=numFormat.format(totalPriceOrder)%></font></td>	
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
								<td colspan="6" >備　考 : &nbsp; </td>	
							</tr>				
							<tr height=26>	
								<td colspan="6" align="right" style="padding: 0px 10px 0px 0px; font-size:14px" ><font  color="#669900">合計  :  \  0 </font></td>	
							</tr>
			</c:if>	
													
																	
						</table>																			
					</td>							
				</tr>
				<tr>
					<td colspan="3" width="30%" align="left"  style="padding: 3px 0px 3px 0px;" >
							<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
								<tr>
									<td width="70%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">&nbsp;</td>	
									<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3px 0px 3px 0px;">
											<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
											<tr bgcolor="" align=center height=26 >													
												<td width="50%">部長</td>
												<td width="50%">注文者</td>
											</tr>
											<tr bgcolor="" align=center height=50>												
												<td >
	<%
		memSign=manager.getDbMseq(pdb.getSign_02()); 
		if(memSign!=null){		
		 if(pdb.getSign_02_yn() !=0){		
			if(pdb.getSign_02_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_02_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 	
	<%}}else{%>--<%}%>										
												</td>			
												<td>
	<%
		memSign=manager.getDbMseq(pdb.getSign_03()); 
		if(memSign!=null){		
		 if(pdb.getSign_03_yn() !=0){		
			if(pdb.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>確認済<%}%>
			<%}%>
			<%if(pdb.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
			<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 	
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
<div class="clear_margin"></div>
<form name="move2" method="post">
    <input type="hidden" name="seq" value="">
    <input type="hidden" name="sign_ok" value="">     
    <input type="hidden" name="position" value="">  
    <input type="hidden" name="ymd" value="">       
 </form>
<script language="JavaScript">	
function popupOrderBox(seq,position){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sign/popup_order.jsp?seq="+seq+"&position="+position; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}

	
	
function goSignHoliCon(seq,sign_ok,position,ymd) {			 		
	
	if ( confirm("承認しますか?") != 1 ) {return;}
	
	document.move2.action =  "<%=urlPage%>rms/admin/order/signOk.jsp";
	document.move2.seq.value = seq;	
	document.move2.sign_ok.value = sign_ok;		
	document.move2.position.value = position;
	document.move2.ymd.value = ymd;
	document.move2.submit();
}
function goSignHoliConTantosya(seq,sign_ok,position,ymd) {			 		
	
	if ( confirm("処理しますか?") != 1 ) {return;}
	
	document.move2.action =  "<%=urlPage%>rms/admin/order/signOk.jsp";
	document.move2.seq.value = seq;	
	document.move2.sign_ok.value = sign_ok;		
	document.move2.position.value = position;
	document.move2.ymd.value = ymd;
	document.move2.submit();
}

function goDelete(seq) {
	document.move.seq.value=seq;		
	if ( confirm("削除依頼がありました。本内容を削除しますか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>rms/admin/order/delete_boss.jsp";	
    	document.move.submit();
}
</script>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
