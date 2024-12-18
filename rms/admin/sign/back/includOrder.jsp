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
	
	List listOrder01=mgrOrder.listSignOrder(mseq,1); 		 	 
	List listOrder02=mgrOrder.listSignOrder(mseq,2); 		 
	List listOrder03=mgrOrder.listSignOrder(mseq,3); 				 			 	 

	List listCon ;
	Member memSign;
%>
	
<c:set var="listOrder01" value="<%= listOrder01 %>" />	
<c:set var="listOrder02" value="<%= listOrder02 %>" />
<c:set var="listOrder03" value="<%= listOrder03 %>" />

<script type="text/javascript">
function popup_LayerHoliCon(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     if(_marginx < 0){main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px"; }
     else{main.style.left = event.clientX + document.body.scrollLeft-5+"px"; }
     //높이 지정
     if(_marginy < 0){ main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";  }  
     else{main.style.top = event.clientY + document.body.scrollTop-5+"px";} 
}  
function popup_LayerHoliCon02(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     if(_marginx < 0){main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px"; }
     else{main.style.left = event.clientX + document.body.scrollLeft-5+"px"; }
     //높이 지정
     if(_marginy < 0){ main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";  }  
     else{main.style.top = event.clientY + document.body.scrollTop-5+"px";} 
} 
function popup_LayerHoliCon03(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     if(_marginx < 0){main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px"; }
     else{main.style.left = event.clientX + document.body.scrollLeft-5+"px"; }
     //높이 지정
     if(_marginy < 0){ main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";  }  
     else{main.style.top = event.clientY + document.body.scrollTop-5+"px";} 
} 

function Layer_popup_OffCon() { 
  var frm=document.frmBogoCon;
  var pay_len = eval(frm.divPass.length);  
  var pay_val=frm.divPass;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) { eval(pay_val[i].value + ".style.display = \"none\"");	}
  }else{eval(pay_val.value + ".style.display = \"none\"");}  
}    
function Layer_popup_OffCon02() { 
  var frm=document.frmBogoCon02;
  var pay_len = eval(frm.divPass.length);  
  var pay_val=frm.divPass;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) { eval(pay_val[i].value + ".style.display = \"none\"");	}
  }else{eval(pay_val.value + ".style.display = \"none\"");}  
}   
function Layer_popup_OffCon03() { 
  var frm=document.frmBogoCon03;  
  var pay_len = eval(frm.divPass.length);    
  var pay_val=frm.divPass;  
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) { eval(pay_val[i].value + ".style.display = \"none\"");	}
  }else{eval(pay_val.value + ".style.display = \"none\"");}  
}   

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

</script>	

<!--Purchase Order begin ---------------------------->
<table width="75%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>		
		<td   valign="bottom"  style="padding:2 0 2 2" ><img src="<%=urlPage%>rms/image/RightBox.gif"> 社内用品発注依頼書</td>			
	</tr>	
</table>	
<table width="75%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>	
<tr bgcolor=#F1F1F1 align=center >	
    <td  align="center" width="12%">日付</td>		
	<td  align="center" width="8%">年/月/日</td>
	<td  align="center" width="20%">タイトル</td>
	<td  align="center" width="15%">発注先</td>
	<td  align="center" width="10%">登録者氏名</td>
	<td  align="center" width="10%">商品種類数</td>
      <td align="center" width="5%">承認</td>       
</tr>	
<!--01******************************************************************************************************-->	
<c:if test="${empty listOrder01 && empty listOrder02 && empty listOrder03}">	
	<tr>
		<td colspan="7">---</td>
	</tr>
</c:if>	
<c:if test="${! empty listOrder01}">	
<form name="frmBogoCon"  method="post" >		
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
	<input type="hidden" name="divPass" value="popupHoliCon_<%=pdb.getSeq()%>">		
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center"><font color="#CC0099">[社長]</font> <%=yymmdd%>	</td>
	<td align="center">
		<a href="javascript:ShowHiddenHoliCon01('item_blockHoliCon','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getHizuke()%></font>
		</a> 
	</td>
	<td align="left"><%if(pdb.getTitle()!=null){%><%=pdb.getTitle()%>&nbsp;<%}else{%>-<%}%></td>
	<td><%if(pdb.getContact_order()!=null){%><%=pdb.getContact_order()%>&nbsp;<%}else{%>-<%}%>   </td>				
	<td>
		<%if(pdb.getMseq()!=0){memSign=manager.getDbMseq(pdb.getMseq());	%>
		<%=memSign.getNm()%>
		<%}else{%>--<%}%>
	</td>
	</td>				
	<td><%=pdb.getQty()%>&nbsp;</td>												
	<td align="center" >			
<!-- *****************************sign begin-->
<div id="popupHoliCon_<%=pdb.getSeq()%>" style="border:2px solid #FFCC00;position:absolute; left:0px; top:0px; z-index:999;display:none;filter: alpha(opacity=95);" >
	<table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td class="calendar5_03">決裁処理</td> 
		     	<td align="right"><a onclick="Layer_popup_OffCon();"  style="CURSOR: pointer;"><img src="<%=urlPage%>orms/images/common/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
      <table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	
         	<tr>          	  
                 <td valign="middle" style="padding:2 0 2 2;" ><img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">承認==>
              		<a href="javascript:goSignHoliCon('<%=pdb.getSeq()%>',2,1);" onfocus="this.blur()" style="CURSOR: pointer;">
    					<img src="<%=urlPage%>rms/image/admin/btn_kesai_ok.gif"  align="absmiddle"></a>
    		   </td>
    		</tr>
            <tr><td background="<%=urlPage%>rms/image/dot_line_all.gif" ></td></tr>
                 <input type="hidden" name="positionCon<%=pdb.getSeq()%>" value="1">                                       
     </table>
</div>
<!-- ********************************comment레이어 end -->
		<a onclick="popup_LayerHoliCon(event,'popupHoliCon_<%=pdb.getSeq()%>');" style="CURSOR: pointer;">	
         	  	<img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle">  	  	 
		</a>			
	</td>
</tr>
<tr>
	<td  style="padding: 5 5 5 5" colspan="11" align="center" width="90%" bgcolor="#EBEBD8">
		<span id="item_blockHoliCon<%=i%>" style="DISPLAY:none; xCURSOR:hand">					
<table width="85%"  border="2" cellpadding=0 cellspacing=0 bordercolor="#9D8864" >		
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10 5 10 5">
				<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
				<tr>
					<td align="center" colspan="3" bgcolor="#ffffff"   style="padding: 10 0 3 0;">
						<table width="100%"  border=0 cellpadding=0 cellspacing=0 >			
						<tr>
							<td align="center" class="calendar15" style="padding: 3 0 3 0;">社内用品発注依頼書</td>
						</tr>
						</table>
					</td>										
				</tr>
				<tr>
					<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
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
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
							<table width="100%"  border=0 cellpadding=0 cellspacing=0  >			
							<tr>
								<td align="right" style="padding: 3 0 3 0;">
								<%=pdb.getHizuke().substring(0,4)%>年 <%=pdb.getHizuke().substring(5,7)%>月 <%=pdb.getHizuke().substring(8,10)%>日</td>	
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
						発注先：  <%=pdb.getContact_order()%>						
					</td>							
				</tr>									
				<tr>
					<td colspan="3" align="center" style="padding: 3 0 3 0;">
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
									<td width="60%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>	
									<td width="40%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
											<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
											<tr bgcolor="" align=center height=26 >	
												<td width="34%">承認印</td>
												<td width="33%">本部長</td>
												<td width="33%">課長/部長</td>
											</tr>
											<tr bgcolor="" align=center height=50>	
												<td width="34%">
	<%
		memSign=manager.getDbMseq(pdb.getSign_01()); 
		if(memSign!=null){		
		 if(pdb.getSign_01_yn() !=0){		
			if(pdb.getSign_01_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_01_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
	<%}}else{%>--<%}%>												
												
												</td>
												<td width="33%">
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
	<%}}else{%>--<%}%>										
												</td>
												<td width="33%">
	<%
		memSign=manager.getDbMseq(pdb.getSign_03()); 
		if(memSign!=null){		
		 if(pdb.getSign_03_yn() !=0){		
			if(pdb.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
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

<!--休日出勤/보고서 02******************************************************************************************************-->

<c:if test="${! empty listOrder02}">	
<form name="frmBogoCon02"  method="post" >	
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
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
	<td align="center"><font color="#CC0099">[本部長]</font> <%=yymmdd%>	</td>
	<td align="center">
		<a href="javascript:ShowHiddenHoliCon02('item_blockHoliCon02','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getHizuke()%></font>
		</a> 
	</td>
	<td align="left"><%if(pdb.getTitle()!=null){%><%=pdb.getTitle()%>&nbsp;<%}else{%>-<%}%></td>
	<td><%if(pdb.getContact_order()!=null){%><%=pdb.getContact_order()%>&nbsp;<%}else{%>-<%}%>   </td>				
	<td>
		<%if(pdb.getMseq()!=0){memSign=manager.getDbMseq(pdb.getMseq());	%>
		<%=memSign.getNm()%>
		<%}else{%>--<%}%>
	</td>				
	<td><%=pdb.getQty()%>&nbsp;</td>					
	<td align="center" >			
<!-- *****************************sign begin-->
<div id="popupHoliCon02_<%=pdb.getSeq()%>" style="border:2px solid #FFCC00;position:absolute; left:0px; top:0px; z-index:999;display:none;filter: alpha(opacity=95);" >
	<table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td class="calendar5_03">決裁処理</td> 
		     	<td align="right"><a onclick="Layer_popup_OffCon02();"  style="CURSOR: pointer;"><img src="<%=urlPage%>orms/images/common/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	
         	<tr>          	  	
                 <td valign="middle" style="padding:2 0 2 2;" ><img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">承認==>
              		<a href="javascript:goSignHoliCon('<%=pdb.getSeq()%>',2,2);" onfocus="this.blur()" style="CURSOR: pointer;">
    					<img src="<%=urlPage%>rms/image/admin/btn_kesai_ok.gif"  align="absmiddle"></a>
    		   </td>
    		</tr>
            <tr><td background="<%=urlPage%>rms/image/dot_line_all.gif" ></td></tr>                             
                 <input type="hidden" name="positionCon<%=pdb.getSeq()%>" value="2">                                               
     </table>
</div>
<!-- ********************************comment레이어 end -->
		<a onclick="popup_LayerHoliCon02(event,'popupHoliCon02_<%=pdb.getSeq()%>');" style="CURSOR: pointer;">	
         	  	<img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle">	
		</a>			
	</td>
</tr>
<tr>
	<td  style="padding: 5 5 5 5" colspan="11" align="center" width="90%" bgcolor="#EBEBD8">
		<span id="item_blockHoliCon02<%=i%>" style="DISPLAY:none; xCURSOR:hand">					
<table width="85%"  border="2" cellpadding=0 cellspacing=0 bordercolor="#9D8864" >			
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10 5 10 5">
				<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
				<tr>
					<td align="center" colspan="3" bgcolor="#ffffff"   style="padding: 10 0 3 0;">
						<table width="100%"  border=0 cellpadding=0 cellspacing=0 >			
						<tr>
							<td align="center" class="calendar15" style="padding: 3 0 3 0;">社内用品発注依頼書</td>
						</tr>
						</table>
					</td>										
				</tr>
				<tr>
					<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
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
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
							<table width="100%"  border=0 cellpadding=0 cellspacing=0  >			
							<tr>
								<td align="right" style="padding: 3 0 3 0;">
								<%=pdb.getHizuke().substring(0,4)%>年 <%=pdb.getHizuke().substring(5,7)%>月 <%=pdb.getHizuke().substring(8,10)%>日</td>	
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
						発注先：  <%=pdb.getContact_order()%>						
					</td>							
				</tr>									
				<tr>
					<td colspan="3" align="center" style="padding: 3 0 3 0;">
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
									<td width="60%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>	
									<td width="40%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
											<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
											<tr bgcolor="" align=center height=26 >	
												<td width="34%">承認印</td>
												<td width="33%">本部長</td>
												<td width="33%">課長/部長</td>
											</tr>
											<tr bgcolor="" align=center height=50>	
												<td width="34%">
	<%
		memSign=manager.getDbMseq(pdb.getSign_01()); 
		if(memSign!=null){		
		 if(pdb.getSign_01_yn() !=0){		
			if(pdb.getSign_01_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_01_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
	<%}}else{%>--<%}%>												
												
												</td>
												<td width="33%">
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
	<%}}else{%>--<%}%>										
												</td>
												<td width="33%">
	<%
		memSign=manager.getDbMseq(pdb.getSign_03()); 
		if(memSign!=null){		
		 if(pdb.getSign_03_yn() !=0){		
			if(pdb.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
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
<!--休日出勤/보고서 03******************************************************************************************************-->			
<c:if test="${! empty listOrder03}">	
<form name="frmBogoCon03"  method="post" >	
<%	
int i=1; 
Iterator listiter=listOrder03.iterator();					
		while (listiter.hasNext()){
			BeanOrderBunsho pdb=(BeanOrderBunsho)listiter.next();
			int seq=pdb.getSeq();											
			if(seq!=0){	
				String yymmdd=dateFormat.format(pdb.getRegister());
				int del_yn=pdb.getDel_yn();  //삭제여부 2는 삭제요청, 1은 기본
				listCon=mgrOrder.listItem(seq);	
							
%>
	<input type="hidden" name="divPass" value="popupHoliCon03_<%=pdb.getSeq()%>">		
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
	<td align="center"><font color="#CC0099">[課長/部長]</font> <%=yymmdd%>	</td>
	<td align="center">
		<a href="javascript:ShowHiddenHoliCon03('item_blockHoliCon03','<%=i%>');" onFocus="this.blur()">
			<font color="#CC6600"><%=pdb.getHizuke()%></font>
		</a> 
	</td>
	<td align="left"><%if(pdb.getTitle()!=null){%><%=pdb.getTitle()%>&nbsp;<%}else{%>-<%}%></td>
	<td><%if(pdb.getContact_order()!=null){%><%=pdb.getContact_order()%>&nbsp;<%}else{%>-<%}%>   </td>				
	<td><%if(pdb.getMseq()!=0){memSign=manager.getDbMseq(pdb.getMseq());	%><%=memSign.getNm()%><%}else{%>--<%}%></td>				
	<td><%=pdb.getQty()%>&nbsp;</td>			
	<td align="center" >			
<!-- *****************************sign begin-->
<div id="popupHoliCon03_<%=pdb.getSeq()%>" style="border:2px solid #FFCC00;position:absolute; left:0px; top:0px; z-index:999;display:none;filter: alpha(opacity=95);" >
	<table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td class="calendar5_03">決裁処理</td> 
		     	<td align="right"><a onclick="Layer_popup_OffCon03(<%=pdb.getSeq()%>);"  style="CURSOR: pointer;"><img src="<%=urlPage%>orms/images/common/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	
         	<tr>          	  
                 <td valign="middle" style="padding:2 0 2 2;" ><img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">承認==>
              		<a href="javascript:goSignHoliCon('<%=pdb.getSeq()%>',2,3);" onfocus="this.blur()" style="CURSOR: pointer;">
    					<img src="<%=urlPage%>rms/image/admin/btn_kesai_ok.gif"  align="absmiddle"></a>
    			</td>
    		</tr>
            <tr><td background="<%=urlPage%>rms/image/dot_line_all.gif" ></td></tr>            
                 <input type="hidden" name="positionCon<%=pdb.getSeq()%>" value="3">                      
     </table>
</div>
<!-- ********************************comment레이어 end -->
		<a onclick="popup_LayerHoliCon03(event,'popupHoliCon03_<%=pdb.getSeq()%>');" style="CURSOR: pointer;">	
         	  	<img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle">     	  	
		</a>			
	</td>
</tr>
<tr>
		<td  style="padding: 5 5 5 5" colspan="11" align="center" width="90%" bgcolor="#EBEBD8">
		<span id="item_blockHoliCon03<%=i%>" style="DISPLAY:none; xCURSOR:hand">					
<table width="85%"  border="2" cellpadding=0 cellspacing=0 bordercolor="#9D8864" >			
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10 5 10 5">
				<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
				<tr>
					<td align="center" colspan="3" bgcolor="#ffffff"   style="padding: 10 0 3 0;">
						<table width="100%"  border=0 cellpadding=0 cellspacing=0 >			
						<tr>
							<td align="center" class="calendar15" style="padding: 3 0 3 0;">社内用品発注依頼書</td>
						</tr>
						</table>
					</td>										
				</tr>
				<tr>
					<td width="30%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
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
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>
					<td width="35%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
							<table width="100%"  border=0 cellpadding=0 cellspacing=0  >			
							<tr>
								<td align="right" style="padding: 3 0 3 0;">
								<%=pdb.getHizuke().substring(0,4)%>年 <%=pdb.getHizuke().substring(5,7)%>月 <%=pdb.getHizuke().substring(8,10)%>日</td>	
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
						発注先：  <%=pdb.getContact_order()%>						
					</td>							
				</tr>									
				<tr>
					<td colspan="3" align="center" style="padding: 3 0 3 0;">
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
									<td width="60%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">&nbsp;</td>	
									<td width="40%" align="center" bgcolor="#ffffff" style="padding: 3 0 3 0;">
											<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
											<tr bgcolor="" align=center height=26 >	
												<td width="34%">承認印</td>
												<td width="33%">本部長</td>
												<td width="33%">課長/部長</td>
											</tr>
											<tr bgcolor="" align=center height=50>	
												<td width="34%">
	<%
		memSign=manager.getDbMseq(pdb.getSign_01()); 
		if(memSign!=null){		
		 if(pdb.getSign_01_yn() !=0){		
			if(pdb.getSign_01_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_01_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
	<%}}else{%>--<%}%>												
												
												</td>
												<td width="33%">
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
	<%}}else{%>--<%}%>										
												</td>
												<td width="33%">
	<%
		memSign=manager.getDbMseq(pdb.getSign_03()); 
		if(memSign!=null){		
		 if(pdb.getSign_03_yn() !=0){		
			if(pdb.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 			
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

<form name="move2" method="post">
    <input type="hidden" name="seq" value="">
    <input type="hidden" name="sign_ok" value="">     
    <input type="hidden" name="position" value="">        
 </form>
<script language="JavaScript">	
function goSignHoliCon(seq,sign_ok,position) {			 		
	
	if ( confirm("承認しますか?") != 1 ) {return;}
	
	document.move2.action =  "<%=urlPage%>rms/admin/order/signOk.jsp";
	document.move2.seq.value = seq;	
	document.move2.sign_ok.value = sign_ok;		
	document.move2.position.value = position;
	document.move2.submit();
}

</script>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
