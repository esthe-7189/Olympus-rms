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
static int PAGE_SIZE=10; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
NumberFormat numFormat = NumberFormat.getNumberInstance(); 

%>

<%	
String title = ""; String name=""; String mailadd=""; String pass=""; 
int mseq=0; int level=0; int posiLevel=0; String busho=""; 


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
	MemberManager mem = MemberManager.getInstance();	
	Member member=mem.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();		 
		 mseq=member.getMseq();		
		 busho=member.getBusho();		
	}	
String pageNum = request.getParameter("page");	

MgrOrderBunsho manager = MgrOrderBunsho.getInstance();


    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	

	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");
	
	List whereCond = null;
	Map whereValue = null;
	
	boolean searchCondTitle = false;		
	boolean searchCondCateM=false;

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("title")){
				whereCond.add(" title LIKE '%"+searchKey+"%'");		
				searchCondTitle = true;
			}else if (searchCond[i].equals("filename")){
				whereCond.add(" contact_order LIKE '%"+searchKey+"%'");			
				searchCondCateM = true;
			}
		}
	}

      int count = manager.countOrderAll(whereCond, whereValue);
	int totalPageCount = 0; //전체 페이지 개수를 저장
	int startRow=0, endRow=0;
	if (count>0){
		totalPageCount=count/PAGE_SIZE;
		if (count % PAGE_SIZE > 0)totalPageCount++;
		
		startRow=(currentPage-1)*PAGE_SIZE+1;
		endRow=currentPage*PAGE_SIZE;
		if(endRow > count) endRow = count;
	}
	if(count<=0){
		startRow=startRow-0;
		endRow=endRow-0;
	}else if(count>0){
		startRow=startRow-1;
		endRow=endRow-1;
	}

	List  list=manager.selectListOrderAll(whereCond, whereValue,startRow,endRow);
	List listCon ;
	Member memSign;
%>
<c:set var="list" value="<%= list %>" />

<script language="javascript">
// 한줄쓰기 토글 함수
function ShowHidden(MenuName, ShowMenuID){
	for ( i = 1; i <= 30;  i++ ){
		menu	= eval("document.all.itemData_block" + i + ".style");		
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
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">社内用品申請</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 全体目録 " onClick="location.href='<%=urlPage%>rms/admin/order/listForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新規発注依頼書作成" onClick="location.href='<%=urlPage%>rms/admin/order/writeForm.jsp'">			
</div>
<div id="boxNoLine"  >

<table width="975" border="0" class="searchBox_all" cellpadding="3" cellspacing="3" >				
		<tr align="left" height="20">
				<td  style="padding:3px 0px 3px 0px;">						
				
	<font color="#807265">※ </font><font color="#339900">処理過程 : </font>発注依頼書作成 <font color="#CC6600">--></font> 全体目録で <font color="#339900">[書く] </font>: 重ねて注文する<font color="#CC6600">--></font>
	<b>処理</b>で <font color="#339900">[完了する]</font><font color="#CC6600">--></font> 部長決裁<font color="#CC6600">--></font> 担当者発注<font color="#CC6600">--></font>
					<font color="#339900">[物品確認する] </font>			
					</td>
				</tr>
				<tr align="left" >
					<td style="padding:3px 0px 3px 0px;">				
	<font color="#807265">※ </font><font color="#339900">注文期間 : </font> 最初に登録した日から注文予定日までのことで、注文書作成期間。
					</td>
				</tr>
				<tr align="left">
					<td style="padding:2px 0px 2px 0px;">				
	<font color="#807265">※ </font><font color="#339900">発注先指定 : </font> 発注先が異なる場合、<font color="#CC6600">新規発注依頼書</font>を作成して下さい。 登録されてない発注先以外の注文依頼に発注先を直接記入し、
部長承認をえてネット注文か売店購入して<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
従業員精算して下さい。(例．切手、ヤマダ電機、楽天など)
					</td>
				</tr>
				<tr align="left">
					<td style="padding:3px 0px 3px 0px;">					   			      
	<font color="#807265">※ </font><font color="#339900">注文方法 : </font> <b>注文状態</b>で <font color="#FF0000">[ 注文中 ]</font> のみ、重ねて注文が出来ますが、
					<font color="#996600">[注文完了] </font>でも 	<b>処理</b>で<font color="#339900">[キャンセル]</font> すると注文ができます。
					</td>
				</tr>
				<tr align="left">
					<td style="padding:3px 0px 3px 0px;">	
	<font color="#807265">※ </font><font color="#339900">注文完了 : </font><b>処理</b>で<font color="#339900">[完了する]</font>をクリック。もし、完了したのをキャンセルしたい場合は<font color="#339900">[キャンセル]</font> をクリック！。
					</td>
				</tr>				
				<tr align="left">
					<td style="padding:3px 0px 3px 0px;">				
	<font color="#807265">※ </font><font color="#339900">削除 : </font> 担当者発注確認以前まで出来ます。また、決裁後に削除するには決裁者の許可が要ります。
					</td>
				</tr>	
				<tr align="left">
					<td style="padding:3px 0px 3px 0px;">	
	<font color="#807265">※ </font><font color="#339900">修正 : </font> 決裁以前まで出来ます。	
					</td>
				</tr>
				<tr align="left">
					<td style="padding:3px 0px 3px 0px;">	
	<font color="#807265">※ </font><font color="#339900">Excelのダウンロード方法 : </font> <input type="submit" class="cc" onClick="excelExplain();" onfocus="this.blur();" style=cursor:pointer value="方法を見る  >>">			
					</td>
				</tr>
				<tr align="left">
					<td style="padding:5px 0px 3px 0px;">	
<font color="#339900">[ 社内用品発注申請の記入期間 ]</font>
					</td>
				</tr>
				<tr align="left">
					<td style="padding:3px 0px 3px 0px;">	
毎週、<font color="#CC6600">水曜日</font>に発注します。 (例、普通の場合2012年11月28日(水)～12月4日(火)１週間に社内用品依頼発注書に記入、部長の承認をえて12月5日(水)にまとめて
					</td>
				</tr>
				<tr align="left">
					<td style="padding:3px 0px 3px 0px;">	
舟久保さんにて外部に注文します。<font color="#CC0000">*</font>至急の場合は新規発注依頼書を記入し、部長の承認をえて素早く進めます。(舟久保さんに別途メールでお知らせする。)	
					</td>
				</tr>	
		</tr>	
</table>
<div class="clear_margin"></div>
<table width="975" border="0" cellpadding="0" cellspacing="0"   bgcolor="">									
<form name="move" method="post">
    <input type="hidden" name="seq" value="">              
    <input type="hidden" name="sign" value="">
    <input type="hidden" name="kubun" value=""> 
    <input type="hidden" name="page" value="${currentPage}">            
    <c:if test="<%= searchCondCateM%>">
    <input type="hidden" name="search_cond" value="filename">
    </c:if>	
    <c:if test="<%= searchCondTitle%>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>    
</form>
	<tr>
	<form name="search"  action="<%=urlPage%>rms/admin/order/listForm.jsp" method="post">		
		<td valign="middle" width="13%">			
			<div  class="" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="" >
				  	 <option name="search_cond" VALUE="" >:::::::Search:::::::</OPTION>				            	
			          	<option name="search_cond" VALUE="filename" >発注先</OPTION>			          	
					<option name="search_cond" VALUE="title"  >タイトル</OPTION>		
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="19%" align="left">
		 	<input type=text  name="search_key" size="30"  class="input02" >
		 </td>
		 <td valign="middle" width="9%" align="center">		 			  
		 	<input type="submit" name="" value="    検索   "   class="cc" id="Search" title="SEARCH!" class="button buttonBright" />
		 </td>	    			
		 <td width="59%"  valign="bottom"  align="right" style="padding:5 0 5 15">&nbsp;</td>				
	</tr>
	</form>
</table>
<table width="975"  cellpadding="2" cellspacing="2" class="tablebox_list">
			<tr bgcolor=#F1F1F1 align=center height=26>					    	
				    <td  class="clear_dot" width="16%">注文期間</td>
				    <td  class="clear_dot" width="8%">注文状態</td>					   
				    <td  class="clear_dot" width="16%">タイトル</td>
				    <td  class="clear_dot" width="8%">発注先</td>
				    <td  class="clear_dot" width="9%">注文者<br><font color="#807265">(登録者)</font></td>
				    <td  class="clear_dot" width="4%">品数</td>			
				    <td  class="clear_dot" width="6%">部長承認</td>
					<td  class="clear_dot" width="6%">用品書く</td>
				    <td  class="clear_dot" width="9%">処理</td>
				    <td  class="clear_dot" width="6%">修正/削除</td>
				    <td  class="clear_dot" width="6%">印刷</td> <!--결재후에는 삭제시 요청해야 함.--->													
			</tr>			
	<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td colspan="11">登録された内容がありません。</td></tr>
	</c:if>
	<c:if test="${! empty list}">				
<%	int i=1; 
	int groupId=0; //삭제시 구룹id	
	Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			BeanOrderBunsho pdb=(BeanOrderBunsho)listiter.next();
			int seq=pdb.getSeq();											
			if(seq!=0){	
%>
<c:set var="pdb" value="<%= pdb %>" />
<%
				String yymmdd=dateFormat.format(pdb.getRegister());
				int del_yn=pdb.getDel_yn();  //삭제여부 2는 삭제요청, 1은 기본
				listCon=manager.listItem(seq);	
							
	%>
			 <tr  height="20" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">				 				 
			       <td class="clear_dot">
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');" onFocus="this.blur()">
		<%=yymmdd%> ～ 	<font color="#CC6600"><%=pdb.getHizuke().substring(5,10)%></font>  日まで </a>				
			       </td>
				<td align="center" class="clear_dot">
	<%if(pdb.getSign_01_yn()==2 && pdb.getSign_02_yn()==2 && pdb.getSign_03_yn()==2 && pdb.getGet_yn()==2){%>物品確認完了
	<%}else if(pdb.getSign_01_yn()==2 && pdb.getSign_02_yn()==2 && pdb.getSign_03_yn()==2 && pdb.getGet_yn()==1){%><font color="#CC6600">物品受取中</font>
	<%}else if(pdb.getSign_01_yn()==1 && pdb.getSign_02_yn()==2 && pdb.getSign_03_yn()==2 && pdb.getGet_yn()==1){%><font color="#996600">注文完了</font>
	<%}else if(pdb.getSign_01_yn()==1 && pdb.getSign_02_yn()==2 && pdb.getSign_03_yn()==2){%><font color="#CC33FF">申請完了</font>	
	<%}else if(pdb.getSign_01_yn()==1 && pdb.getSign_02_yn()==1 && pdb.getSign_03_yn()==2){%><font color="#009900">決裁中</font>		
	<%}else if(pdb.getSign_01_yn()==1 && pdb.getSign_02_yn()==1 && pdb.getSign_03_yn()==1){%><font color="#FF0000">注文中</font>									
	<%}else if(pdb.getSign_01_yn()==3 || pdb.getSign_02_yn()==3 ||  pdb.getSign_03_yn()==3){%>
				<%if(pdb.getSign_01_yn()==3){%>[担当者]<br><font color="#FF00CC">差戻し中</font>	<%}%>
				<%if(pdb.getSign_02_yn()==3){%>[部長]<br><font color="#FF00CC">差戻し中</font>	<%}%>
				<%if(pdb.getSign_03_yn()==3){%>[注文者]<font color="#FF00CC"><br>差戻し中</font>	<%}%>	
					
	<%}else{%>--<%}%>											
				</td>					       							 
				 <td align="left" class="clear_dot"><a href="javascript:ShowHidden('itemData_block','<%=i%>');" onFocus="this.blur()"><c:out value="${pdb.title}" default="-" /></a> </td>
				<td class="clear_dot"><c:out value="${pdb.contact_order}" default="-" /> </td>				
				<td align="left" class="clear_dot"><%Member mem03=mem.getDbMseq(pdb.getSign_03());%><%=mem03.getNm()%><br><font color="#807265">(${pdb.name})</font> &nbsp;</td>				
				<td align="center" class="clear_dot">${pdb.qty} &nbsp;</td>															
	<td align="center" class="clear_dot">
		<%
			memSign=mem.getDbMseq(pdb.getSign_02()); 
			if(memSign!=null){		
			 if(pdb.getSign_02_yn() !=0){		
				if(pdb.getSign_02_yn()==2 && pdb.getSign_01_yn()!=3 && pdb.getSign_02_yn()!=3 && pdb.getSign_03_yn()!=3){%><img src="<%=urlPage%>rms/image/admin/icon_signOk.gif"  align="absmiddle" title="決裁済"><%}%>			
				<%if(pdb.getSign_02_yn()==1 && pdb.getSign_01_yn()!=3 && pdb.getSign_02_yn()!=3 && pdb.getSign_03_yn()!=3){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
				<%if(pdb.getSign_01_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_01()%>"><%}%> 
				<%if(pdb.getSign_02_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_02()%>"><%}%> 
				<%if(pdb.getSign_03_yn()==3){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_03()%>"><%}%>																	
		<%}}else{%>--<%}%>
	</td>
	<td align="center" class="clear_dot">
		<%if(pdb.getSign_03_yn()==2 ){%>--<%}%>			
		<%if(pdb.getSign_03_yn()==1){%><a href="javascript:goAdd(<%=seq%>);" onfocus="this.blur()"><font color="#339900">[書く]</font></a> <%}%> 						
	</td>	
	<td align="center" class="clear_dot">
		<%if(pdb.getSign_01_yn()==2 && pdb.getSign_02_yn()==2 && pdb.getSign_03_yn()==2 && pdb.getGet_yn()==1){%>
			<a  href="javascript:goSubmit('<%=seq%>',2,2);" onfocus="this.blur()"><font color="#339900">[物品確認する]</font></a>
		<%}else if(pdb.getSign_03_yn()==2 && pdb.getSign_02_yn()==1 && pdb.getSign_01_yn()==1 && pdb.getGet_yn()==1){%>
			<a  href="javascript:goSubmit('<%=seq%>',1,1);" onfocus="this.blur()"><font color="#339900">[キャンセル]</font></a>
		<%}else if(pdb.getSign_03_yn()==1 && pdb.getSign_02_yn()==1 && pdb.getSign_01_yn()==1 && pdb.getGet_yn()==1){%>
			<a  href="javascript:goSubmit('<%=seq%>',2,1);" onfocus="this.blur()"><font color="#339900">[完了する]</font></a>	
		<%}else if(pdb.getSign_01_yn()==3 || pdb.getSign_02_yn()==3 || pdb.getSign_03_yn()==3 && pdb.getGet_yn()==1){%>
			<a href="javascript:goModify(<%=seq%>);" onfocus="this.blur()"><font color="#339900">[処理する]</font></a>		
		<%}else{%>--<%}%>					
	</td>										
	<td align="center" class="clear_dot">	
<%if(id.equals("juc0318") || id.equals("moriyama")){%>		
	<%if(pdb.getDel_yn()==1){%>					
				<a href="javascript:goModify(<%=seq%>);" onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>&nbsp;
				<a href="javascript:goDelete(<%=seq%>);"  onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>			
	<%}%>
<%}else{%>
	<%if(pdb.getDel_yn()==1){%>
			<%if(pdb.getSign_02_yn()==1 && pdb.getGet_yn()==1 && pdb.getSign_01_yn()!=3 && pdb.getSign_02_yn()!=3 && pdb.getSign_03_yn()!=3){%>				
				<a href="javascript:goModify(<%=seq%>);" onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>&nbsp;
				<a href="javascript:goDelete(<%=seq%>);"  onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
			<%}else if(pdb.getSign_02_yn()==2 && pdb.getGet_yn()==1 && pdb.getSign_01_yn()!=3 && pdb.getSign_02_yn()!=3 && pdb.getSign_03_yn()!=3){%>							
				<a href="javascript:goDelete(<%=seq%>);"  onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
			<%}else if(pdb.getSign_01_yn()==3 || pdb.getSign_02_yn()==3 ||  pdb.getSign_03_yn()==3){%>							
				<a href="javascript:goModify(<%=seq%>);" onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>&nbsp;
				<a href="javascript:goDelete(<%=seq%>);"  onfocus="this.blur()">
				<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
			<%}else{%>--	<%}%>
	<%}%>
<%}%>	
			
	<%if(pdb.getDel_yn()==2){%>							
		<%if(id.equals("juc0318") || id.equals("moriyama")  || id.equals("admin")){%>	
			<font color="#CC0099">削除要請中</font>	<a href="javascript:goDelete(<%=seq%>);"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>	
		<%}else{%>
			<font color="#CC0099">削除要請中</font>	
		<%}%>
	<%}%>
	</td>
	<td align="center" class="clear_dot">
		<a href="javascript:goExcel('<%=seq%>')" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btnExcel.gif" align="absmiddle" ></a>&nbsp;
		<a href="javascript:popPrint('<%=seq%>')" onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/printSmall.gif" align="absmiddle" ></a>
	</td>			
</tr>
<tr>
	<td  style="padding: 5px 5px 5px 5px;" colspan="11" align="center" width="70%" >
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand">							
			<table width="70%"  border="2" cellpadding="0" cellspacing="0" bordercolor="#9D8864" >			
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 10px 5px 10px 5px;">
				<table width="98%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >			
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
								<td align="right" style="padding: 3 0 3 0;">
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
							<td width="40%">品名</td>
							<td width="10%">発注NO.</td>
							<td width="10%">発注数</td>
							<td width="15%">単価 (\)</td>
							<td width="15%">価格 (\)</td>
							<td width="10%">依頼者</td>
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
							<td align="left"><%=dbCon.getProduct_nm()%></td>
							<td ><%=dbCon.getOrder_no()%></td>
							<td  align="center"><%=dbCon.getProduct_qty()%></td>
							<td  align="right"><%=numFormat.format(dbCon.getUnit_price())%> </td>
							<td  align="right"><%=numFormat.format(pprice)%></td>
							<td align="center">
					<%if(dbCon.getClient_nm()!=0){
						memSign=mem.getDbMseq(dbCon.getClient_nm());
					%>
						<%=memSign.getNm()%>
					
					<%}else{%>--<%}%></td>
						</tr>					
				<%
				ii++;
				}%>	
							<tr height=23>								
								<td colspan="6" align="left">備　考 :  <%if(pdb.getComment()==null){%>&nbsp;  <%}else{%><%=pdb.getComment()%> <%}%></td>	
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
								<td colspan="6" height="20">備　考 : &nbsp; </td>	
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
												<td>
	
	<%
		memSign=mem.getDbMseq(pdb.getSign_02()); 
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
												<td >
	<%
		memSign=mem.getDbMseq(pdb.getSign_03()); 
		if(memSign!=null){		
		 if(pdb.getSign_03_yn() !=0){		
			if(pdb.getSign_03_yn()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>確認済<%}%>
			<%}%>
			<%if(pdb.getSign_03_yn()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_03_yn()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="<%=pdb.getSign_no_riyu_03()%>"><%}%> 			
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
}%>
	</c:if>
</table>

<!-- *****************************page No begin******************************-->			
		<div class="paging_topbg"><p class="mb60  mt7"><div class="pagingHolder module ">				
			<c:set var="count" value="<%= Integer.toString(count) %>" />
			<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
			<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
				<span class="defaultbold ml20">      Page No : </span>				
				<span >
			<c:if test="${count > 0}">
			    <c:set var="pageCount" value="${count / PAGE_SIZE + (count % PAGE_SIZE == 0 ? 0 : 1)}" />
			    <c:set var="startPage" value="${currentPage - (currentPage % 10) + 1}" />
			    <c:set var="endPage" value="${startPage + 10}" />    
			    <c:if test="${endPage > pageCount}">
			        <c:set var="endPage" value="${pageCount}" />
			    </c:if>    			
				<c:if test="${startPage > 10}">        	
						<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" ><<</a>		
			    	</c:if>  		
				<c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
			        	<c:if test="${currentPage == pageNo}"><span class="active">${pageNo}</span></c:if>
			        	<c:if test="${currentPage != pageNo}"><a href="javascript:goPage(${pageNo})" onfocus="this.blur()" >${pageNo}</a></c:if>        		
			    	</c:forEach>
			    					
				<c:if test="${endPage < pageCount}">        	
						<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" >>></a>		
			    	</c:if>				
			</c:if>			
				</span>				
			</div><p class="mb20"></div>			
<!-- ************************page No end***********************************-->									 
</div>	
		

<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/order/listForm.jsp";
    document.move.page.value = pageNo;    
    document.move.submit();
}
function goModify(seq) {	
	document.move.action = "<%=urlPage%>rms/admin/order/updateForm.jsp";
	document.move.seq.value=seq;
    	document.move.submit();    
}
function goAdd(seq) {	
	document.move.action = "<%=urlPage%>rms/admin/order/addItemForm.jsp";
	document.move.seq.value=seq;
    	document.move.submit();    
}
function goDelete(seq) {
	document.move.seq.value=seq;		
	if ( confirm("本内容を削除しますか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>rms/admin/order/delete.jsp";	
    	document.move.submit();
}

//seq, sign(1=초기화, 2=확인완료) , kubun(1=sign03 , 2=get_yn)
function goSubmit(seq,sign,kubun) {
	document.move.seq.value=seq;		
	document.move.sign.value=sign;
	document.move.kubun.value=kubun;
	if(sign==2 && kubun==1){
		if ( confirm("注文書を完了しますか?") != 1 ) {return;}
	}else if(sign==1 && kubun==1){
		if ( confirm("完了したのをキャンセルしますか?") != 1 ) {return;}
	}else if(kubun==2){
		if ( confirm("物品受取を確認しますか?") != 1 ) {return;}
	}

    	document.move.action = "<%=urlPage%>rms/admin/order/chumong.jsp";	
    	document.move.submit();
}

function goExcel(seq) {		
    document.move.action = "<%=urlPage%>rms/admin/order/orderExcel.jsp";
	document.move.seq.value=seq;	
    document.move.submit();    
}
function popPrint(seq){	
	var param="&seq="+seq;
	openScrollWin("<%=urlPage%>rms/admin/order/printFormOrder.jsp", "signAdd", "signAdd", "500", "700",param);
}
function excelExplain(){		
	openNoScrollWin("<%=urlPage%>rms/admin/hokoku/excelDown_pop.jsp", "ExcelDown", "signAdd", "500", "350","");
}
</script>		