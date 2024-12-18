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
String urlPage=request.getContextPath()+"/orms/";	
String urlPage2=request.getContextPath()+"/";	
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");
String inDate=dateFormat.format(new java.util.Date());
String seq=request.getParameter("seq");
String src_item=request.getParameter("src_item");

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(src_item==null){src_item="0";}
int cnt_item=Integer.parseInt(src_item);
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
List listContact_order=mgrOrder.listContact_order();

%>
<c:set var="memTop" value="<%=memTop%>"/>	
<c:set var="listFollow" value="<%=listFollow%>"/>	
<c:set var="beanOrder" value="<%=beanOrder%>"/>
<c:set var="listCon" value="<%=listCon%>"/>
<c:set var="listContact_order" value="<%=listContact_order%>"/>
<script language="JavaScript">
function goSubmit() {	
	if ( confirm("処理しますか?") != 1 ) {return;}
    	document.frm.action = "<%=urlPage2%>rms/admin/order/chumong.jsp";	
    	document.frm.submit();
}	
function goInit(){
	location.href = "<%=urlPage2%>rms/admin/order/listForm.jsp";
}
</script>	
<img src="<%=urlPage2%>rms/image/icon_ball.gif" >
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage2%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">社内用品申請 <font color="#A2A2A2">></font> 物品確認する</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage2%>rms/admin/order/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規発注依頼書作成" onClick="location.href='<%=urlPage2%>rms/admin/order/writeForm.jsp'">			
</div>

<c:if test="${! empty beanOrder}" />
<table  width="960" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">								
		<tr>
			<td align="left"  style="padding-left:10px;padding-top:10px" class="calendar16_1">
			<img src="<%=urlPage%>images/common/jirusi.gif" width="9" height="9" align="absmiddle">物品確認する			
			</td>						
		</tr>		
</table>		
<table width="960" class="tablebox" cellspacing="5" cellpadding="5">				
<form id="frm"  name="frm" method="post"  action="<%=urlPage2%>rms/admin/order/chumong.jsp"  >
	<input type='hidden' name="mseq" value="<%=mseq%>">
	<input type='hidden' name="sign" value="2">	
	<input type='hidden' name="seq" value="<%=seq%>">	
	<input type="hidden" name="kubun" value="2">		
	<tr>					
		<td align="center" style="padding:5px 5px 5px 5px;"><span class="titlename">次の物品を受け取りましたか?</span>&nbsp;								 		
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" はい >>" onClick="goSubmit()">&nbsp;		
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" いいえ >>" onClick="goInit();">					
		</td>	
	</tr>										
</table>
<div class="clear_margin"></div>
<div class="clear_dot"></div>				
<div class="clear_margin"></div>
<table  width="960" class="tablebox" cellspacing="5" cellpadding="5">								
	<tr height="30">			
		<td width="8%"  align="center"><span class="titlename">お名前</span></td>
		<td width="24%" align="left"><%=member.getNm()%></td>
		<td width="8%"  align="center"><span class="titlename">タイトル</span></td>
		<td width="32%" align="left">${beanOrder.title}</td>
		<td width="10%"   style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">発注要請</span></td>
		<td width="18%" align="left">
			<%if(beanOrder.getKind_urgency()==1){%> 普通 <%}%> 
			<%if(beanOrder.getKind_urgency()==2){%> <font  color="#FF6600">至急</font> <%}%>
		</td>						
	</tr>	
		<td   align="center"><span class="titlename">注文期間</span></td>
		<td  align="left"><%=dateFormat.format(beanOrder.getRegister())%> ～ <%=beanOrder.getHizuke()%></td>
		<td   align="center"><font color="#CC0000">※</font><span class="titlename">発注先</span></td>
		<td  align="left">${beanOrder.contact_order}</td>
		<td    style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">部長</span></td>
		<td  align="left">			
			<c:if test="${! empty  listFollow}">
				<%	int i=1;
					Iterator listiter=listFollow.iterator();					
					while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
					%>					
							 <%if(mseqOrder2==mem.getMseq()){%><%=mem.getNm()%><%}%> 
				<%i++;}%>	
			</c:if>
			<c:if test="${empty listFollow}">
						--
			</c:if>					
			
		</td>				
	</tr>	
	<tr height="30">			
		<td   align="center"><span class="titlename">備　　考</span> </td>
		<td  align="left" colspan="3">${beanOrder.comment}</td>					
		<td    style="padding:0 0 0 15;"><font color="#CC0000">※</font><span class="titlename">注文者</span></td>
		<td  align="left">
			<c:if test="${! empty  listFollow}">
				<%	int i=1;
					Iterator listiter=listFollow.iterator();					
						while (listiter.hasNext()){
						Member mem=(Member)listiter.next();
				%>					
							<%if(mseqOrder3==mem.getMseq()){%><%=mem.getNm()%><%}%>
				<%i++;}%>	
			</c:if>
			<c:if test="${empty listFollow}">
				--
			</c:if>					
			</select>		
		</td>					
	</tr>	
</table>	

<!-- item begin *****************************************************************-->				  
<div class="clear_margin"></div>				
<table width="960"  cellpadding="3" cellspacing="0" >	
	<tr bgcolor=#F1F1F1 align=center height=29>		    
	    	<td  width="29%" class="title_list_all"><span class="titlename">品名</span></td>	
		<td  width="12%" class="title_list_m_r"><span class="titlename">発注NO.</span></td>
		<td  width="12%" class="title_list_m_r"><span class="titlename">発注数</span></td>
		<td  width="16%" class="title_list_m_r"><span class="titlename">単価(\)</span></td>
		<td  width="17%" class="title_list_m_r"><span class="titlename">価格(\)</span></td>
		<td  width="11%" class="title_list_m_r"><span class="titlename">依頼者</span></td>
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
			<tr height="25">					
				<td align="left" class="line_gray_b_l_r"><%=dbCon.getProduct_nm()%></td>
				<td align="center" class="line_gray_bottomnright"><%=dbCon.getOrder_no()%></td>
				<td align="center" class="line_gray_bottomnright"><%=dbCon.getProduct_qty()%></td>
				<td align="right" class="line_gray_bottomnright"><%=numFormat.format(dbCon.getUnit_price())%></td>
				<td align="right" class="line_gray_bottomnright"><%=numFormat.format(pprice)%></td>							
				<td align="center" class="line_gray_bottomnright">						
				<%	int i=1;
					Iterator listiter=listFollow.iterator();					
						while (listiter.hasNext()){
						Member mem2=(Member)listiter.next();	
						if(mem2!=null){										
										
				%>					
						<%if(dbCon.getClient_nm()==mem2.getMseq()){%><%=mem2.getNm()%><%}%>
				<%}	i++;}%>						
							 
			</tr>
<%ii++;}%>									
													
</table>
<table  width="960" align="center" border=0 >				
			<tr height="35">								
				<td  align="right"  style="padding: 0px 150px 0px 0px; font-size:14px ;font-weight: bold;">
					合   計&nbsp;&nbsp;&nbsp; \ <%=numFormat.format(totalPriceOrder)%>											
				</td>
			</tr>					
</table>
</c:if>	
</form>				
						
<!-- item end *****************************************************************-->				
<form name="move"  method="post">
	<input type="hidden" name="nameval" value="">
	<input type="hidden" name="groupIdval" value="">
	<input type="hidden" name="parentIdval"  value="">	
</form>			
				
<script language="javascript">
function doCnt(){
	var frm=document.frm;
	frm.src_item.value=frm.src_itemSel.value;	
	frm.action = "<%=urlPage2%>rms/admin/order/updateForm.jsp";	
	frm.submit();
}
</script>	 