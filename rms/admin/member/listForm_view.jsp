<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "java.text.SimpleDateFormat" %>	
<%! 
static int PAGE_SIZE=10; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");	
%>
<%	
int level=0;		
MemberManager manager = MemberManager.getInstance();
	String id=(String)session.getAttribute("ID");	
	Member member2=manager.getMember(id);
	if(member2!=null){ level=member2.getLevel();}	
	String kind=(String)session.getAttribute("KIND");
	
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(level!=1){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String urlPage=request.getContextPath()+"/";	
	
	String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	

	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");

	List whereCond = null;
	Map whereValue = null;

	boolean searchCondMid = false;	
	boolean searchCondAdd = false;	

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();
		
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("mid")){
				whereCond.add("nm  LIKE '%"+searchKey+"%'");				
				searchCondMid=true;		
			}else if (searchCond[i].equals("add")){
				whereCond.add("address LIKE '%"+searchKey+"%'");				
				searchCondAdd = true;		
			}
		}
	}
	
	int count = manager.count(whereCond, whereValue);
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
	List  list=manager.selectList(whereCond, whereValue,startRow,endRow);	
	
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
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script language="javascript" type="text/javascript">
// run the function below once the DOM(Document Object Model) is ready 
$(document).ready(function() {
    // trigger the function when clicking on an assigned element
    $(".toggle").click(function () {
        // check the visibility of the next element in the DOM
        if ($(this).next().is(":hidden")) {
            $(this).next().slideDown("fast"); // slide it down
        } else {
            $(this).next().hide(); // hide it
        }
    });
});
</script>
<script type="text/javascript">	
window.onload = function(){ 
	kubundiv();
}
function kubundiv(){ 
	if(navigator.appName=="Microsoft Internet Explorer"){ 
		document.getElementById('mapControltop').style.display = "none";						
	}else{
		document.getElementById('mapControltop').style.display = "block";		 		
	}	
}
</script>
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">全会員リスト </span>
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="会員登録" onClick="location.href='<%=urlPage%>rms/admin/member/writeForm.jsp'">
</div>	
<div id="boxCalendar"  >
<table width="95%" border='0' cellpadding='0' cellspacing='0'>
<form name="search"  action="<%=urlPage%>rms/admin/member/listForm.jsp" method="post">
	<tr height="29"><td colspan="3" align="left"><img src="<%=urlPage%>rms/image/icon_s.gif" >氏名をクリックするとLevelや承認可否などの変化ができます。　ただし、管理者(admin)は変更できません。 </td></tr>
	<tr>
	<td width="50%" align="left">	
		<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
			<option name="" VALUE=""  >選択して下さい</option>									
			<option name="search_cond" value="mid"  >氏名</option>			
			<option name="search_cond" value="add"  >住所</option>												
		</select>
		<input type=text  name="search_key" size=25 class="input02" maxlength="30">					
		<input type="submit"  style=cursor:pointer align=absmiddle value="  検索  " class="cc" onfocus="this.blur();" >
		<input type="button"   style=cursor:pointer align=absmiddle value="  目録  " class="cc" onfocus="this.blur();"  onClick="location.href='<%=urlPage%>rms/admin/member/listForm.jsp?page=1'">		
	</td>
	<td width="30%"  style="padding: 2 0 2 0;">
		<c:if test="<%= searchCondMid || searchCondAdd %>">
		検索条件: [	
			<c:if test="<%= searchCondMid%>">氏名</c:if>	
			<c:if test="<%= searchCondAdd%>">住所</c:if>	
			=<%=searchKey%>	]
		</c:if>
	</td>								
	<td width="20%"  align='right' >	
			[会員数:<%= count %>]&nbsp;&nbsp;&nbsp;												
	</td>
	</tr>
</form>
</table>	

<table width="100%"   cellpadding="2" cellspacing="2" >
<form name="frm" >    	
		﻿  <tr bgcolor=#F1F1F1 align=center height=26>	
    			<td  class="clear_dot">登録日</td>
		    <td  class="clear_dot">社員NO</td>
		    <td  class="clear_dot">権限<br>レベル</td>
		    <td  class="clear_dot">職名<br>レベル</td>
		    <td  class="clear_dot">氏名</td>
		    <td  class="clear_dot">ID</td>
		    <td  class="clear_dot">PW</td>
		    <td  class="clear_dot">Eメール</td>
		    <td  class="clear_dot">電話</td>
		    <td  class="clear_dot">承認<br>可否 </td>
		    <td  class="clear_dot">修正</td>
		    <td  class="clear_dot">削除</td>
		   </tr>
	<c:if test="${empty list}">
		<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" height="25"><td colspan="12">No Data</td></tr>
	</c:if>
	<c:if test="${! empty list}">		
	<%
			int i=1;	
			Iterator listiter=list.iterator();					
				while (listiter.hasNext()){
					Member member=(Member)listiter.next();
					int mseq=member.getMseq();											
					if(mseq!=0){	
						String register=dateFormat.format(member.getRegister());
						String sex=member.getSex();	
						String himi=member.getHimithu_1();	
						String busho=member.getBusho();	
						String memId=member.getMember_id();
						String ingam=member.getMimg();						
	%>		  
	<div id="mapControltop">
		   	<tr>
				<td  align="left" style="padding-top: 0px;" colspan="12" width="90%" valign="top">
		
					<span class="toggle"><a href="#" style="cursor:pointer;" onfocus="this.blur()"><img src="<%=urlPage%>rms/image/icon_show.gif" align="absmiddle"></a></span>
					<div id="hiddenDiv">
<!--list_inner box start----->						
	<div class="innerDivSlice" >
			<div class="hiddenBox" >	
							<table width="100%" border=0 cellpadding=0 cellspacing=1 bordercolor=#FFFFFF bordercolorlight=#A2A2A2 >
										<tr>	
											<td align="center" bgcolor=#F1F1F1 colspan="4" class="title_name">ID : <%=member.getMember_id()%></td>	
										</tr>
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1 width="15%" >住所:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF width="50%" align="left">						
												<font  color="#007AC3">(<%=member.getZip()%>)</font> <%=member.getAddress()%>
											</td>
											<td rowspan="3" style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1 width="15%" align="center">印鑑のイメージ:</td>		
											<td rowspan="3" style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF width="20%" align="left">
				<%if(!ingam.equals("no")){%>
						<img src="<%=urlPage%>rms/image/admin/ingam/<%=member.getMimg()%>_40.jpg" align="absmiddle"><br>
						<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/member/sign_popView.jsp','read','sign','720','190','&member_id=<%=member.getMember_id()%>&mseq=<%=mseq%>&fileKind=modi');" onfocus="this.blur()">						
						<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>	
				<%}else{%>
						用意されたイメージがありません。<br>
						<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/member/sign_popView.jsp','read','sign','720','190','&member_id=<%=member.getMember_id()%>&mseq=<%=mseq%>&fileKind=new');" onfocus="this.blur()">	
						<img src="<%=urlPage%>rms/image/admin/btn_apply.gif"  align="absmiddle"></a>	
				<%}%>
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >お誕生日:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF align="left">						
												<%=member.getBir_day()%>
											</td>
										</tr>	
						　　　　　　　　　<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >職名 Level 変更 :</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF align="left">						
												<%=member.getPosition()%>
													<select name="position2_level_<%=mseq%>" id="position2_level_<%=mseq%>" >
														<option value="1" <%if(member.getPosition_level()==1){%>selected<%}%> >Grade4</option>
														<option value="2" <%if(member.getPosition_level()==2){%>selected<%}%> >Grade3</option>
														<option value="3" <%if(member.getPosition_level()==3){%>selected<%}%> >Grade2</option>
														<option value="4" <%if(member.getPosition_level()==4){%>selected<%}%> >Grade1</option>
														<option value="5" <%if(member.getPosition_level()==5){%>selected<%}%> >その他1 </option>
														<option value="6" <%if(member.getPosition_level()==6){%>selected<%}%> >その他2</option>
														<option value="7" <%if(member.getPosition_level()==7){%>selected<%}%> >その他3</option>
														<option value="8" <%if(member.getPosition_level()==8){%>selected<%}%> >その他4</option>																								
													</select>
													<a href="javascript:goPosiLevelView2(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>													
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >部署名:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">						
												<% if(busho.equals("0")){%>経営役員<%}%>												
												<% if(busho.equals("1")){%>企画部<%}%>
												<% if(busho.equals("2")){%>事業統括部<%}%>
												<% if(busho.equals("3")){%>開発部<%}%>	
												<% if(busho.equals("4")){%>製造部<%}%>	
												<% if(busho.equals("5")){%>品質保証部<%}%>	
												<% if(busho.equals("6")){%>臨床開発部<%}%>	
												<% if(busho.equals("7")){%>安全管理部<%}%>	
												<% if(busho.equals("8")){%>その他<%}%>	
													
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >秘密番号(質問/答え):</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">						
												<% if(himi.equals("1")){%>飼っているペットの名前は？<%}%>
												<% if(himi.equals("2")){%>旅行に行きたい場所は？<%}%>
												<% if(himi.equals("3")){%>子ども時代のヒーローは?<%}%>
												<% if(himi.equals("4")){%>嫌いな食べ物は?<%}%>
												<% if(himi.equals("5")){%>応援しているチームは?<%}%>
												<% if(himi.equals("6")){%>名前を変えるとしたら何？<%}%>
												<% if(himi.equals("7")){%>よくドライブした場所は?<%}%>
												<% if(himi.equals("8")){%> 一番好きな映画は?<%}%>
												<font  color="#007AC3"><%=member.getHimithu_2()%></a>		
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >ip番号:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">						
												<%=member.getIp_info()%>	
											</td>
										</tr>	
										<tr>
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >承認可否変更:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">	
								<% if(memId.equals("admin")){%>
													adminは変更できません！！
								<%}else{%>
														
											<% if(member.getMember_yn()==1){%>
												<input type="radio" name="passVal2_<%=mseq%>" class="passVal2_<%=mseq%>"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">No</font>
												<input type="radio" name="passVal2_<%=mseq%>"  class="passVal2_<%=mseq%>" value="2"  onfocus="this.blur();" >Yes
											<%}%>
											<% if(member.getMember_yn()==2){%>
												<input type="radio" name="passVal2_<%=mseq%>"  class="passVal2_<%=mseq%>" value="1"   onfocus="this.blur();" ><font  color="#FF6600">No</font>
												<input type="radio" name="passVal2_<%=mseq%>"  class="passVal2_<%=mseq%>" value="2"  checked onfocus="this.blur();" >Yes
											<%}%>&nbsp;&nbsp;&nbsp;
												<a href="javascript:goOkView2(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>	
								<%}%>								
											</td>
										</tr>	
										<tr>
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >システム権限 Level変更:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">	
								<% if(memId.equals("admin")){%>
													adminは変更できません！！
								<%}else{%>
														
											<% if(member.getLevel()==1){%>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="2"  onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==2){%>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="2"  checked onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==3){%>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="2"   onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="3"  checked onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==4){%>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="2"   onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="4"  checked onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==5){%>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="2"   onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal2_<%=mseq%>" class="levelVal2_<%=mseq%>"  value="5"  checked onfocus="this.blur();" >Level 5
											<%}%>
											&nbsp;&nbsp;&nbsp;
												<a href="javascript:goLevelView2(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>	
								<%}%>								
											</td>
										</tr>																					
									</table>
			</div>
		</div>						
	<!--list_inner box----->
	</div>
				</td>
			</tr>
	</div><!--<div id="mapControltop"> -->	
		   <tr  align="left" onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" height="25">
			<div class="hidden_div"><input type="hidden" name="mseq<%=mseq%>" id="mseq<%=mseq%>"  value="<%=member.getMseq()%>"></div>
					<td width="8%" class="clear_dot_with_clide"><%=register%></td>
					<td width="5%" class="clear_dot_with_clide" align="center"><%=member.getEm_number()%>(<%=mseq%>)</td>
					<td width="4%" class="clear_dot_with_clide" align="center"><%=member.getLevel()%></td>	
					<td width="4%" class="clear_dot_with_clide" align="center"><%=member.getPosition_level()%></td>	
					<td width="147" class="clear_dot_with_clide" >
						<a href="javascript:ShowHidden('itemData_block','<%=i%>');"  onFocus="this.blur()">
							<font  color="#009999"><%=member.getNm()%></font><br>(<%=member.getHurigana()%>)</a>
					</td>								
					<td width="10%" class="clear_dot_with_clide"><%=member.getMember_id()%>	(<%if(sex.equals("1")){%>男	<%}else{%>女<%}%>)</td>
					<td width="5%" class="clear_dot_with_clide"><%=member.getPassword()%></td>
					<td width="20%" class="clear_dot_with_clide"><a href="mailto:<%=member.getMail_address()%>?subject=olympus-rms!!"><%=member.getMail_address()%></a></td>					
					<td width="10%" class="clear_dot_with_clide"><%=member.getTel()%></td>					
					<td width="5%" class="clear_dot_with_clide" align="center"><%if(member.getMember_yn()==1){%><font  color="#FF6600">No</font><%}%><%if(member.getMember_yn()==2){%> Ok<%}%>
					</td>					
					<td width="5%"  class="clear_dot_with_clide" align="center">						
						<a href="javascript:goModiView('<%=member.getMember_id()%>');" onfocus="this.blur()" style="CURSOR: pointer;">						
						<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle" alt="書き直し"></a>
					</td>										
					<td width="5%"  class="clear_dot_with_clide" align="center">																		
						<!--<a href="<%=urlPage%>rms/admin/member/delete.jsp?member_id=<%=member.getMember_id()%>&mseq=<%=member.getMseq()%>"  onfocus="this.blur()">-->
						<a href="javascript:alert('管理者に問い合わせてください！');" onfocus="this.blur();">
							<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>
					</td>
		   	</tr>
			<tr>
				<td  style="padding-top: 0px;" colspan="12" width="90%" align="center" valign="top">		
	<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand">
		<div class="innerDivSlice" >
			<div class="hiddenBox" >
<!--list_inner box start----->	
							<table width="100%"  bordercolor=#FFFFFF bordercolorlight=#A2A2A2 >
										<tr height="26">	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1 colspan="4" class="title_name">ID : <%=member.getMember_id()%></td>	
										</tr>
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1 width="15%" >住所:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF width="50%" align="left">						
												<font  color="#007AC3">(<%=member.getZip()%>)</font> <%=member.getAddress()%>
											</td>
											<td rowspan="3" style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1 width="15%" align="center">印鑑のイメージ:</td>		
											<td rowspan="3" style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF width="20%" align="left">
				<%if(!ingam.equals("no")){%>
						<img src="<%=urlPage%>rms/image/admin/ingam/<%=member.getMimg()%>_40.jpg" align="absmiddle"><br>
						<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/member/sign_popView.jsp','read','sign','720','190','&member_id=<%=member.getMember_id()%>&mseq=<%=mseq%>&fileKind=modi');" onfocus="this.blur()">						
						<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>	
				<%}else{%>
						用意されたイメージがありません。<br>
						<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/member/sign_popView.jsp','read','sign','720','190','&member_id=<%=member.getMember_id()%>&mseq=<%=mseq%>&fileKind=new');" onfocus="this.blur()">	
						<img src="<%=urlPage%>rms/image/admin/btn_apply.gif"  align="absmiddle"></a>	
				<%}%>
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >お誕生日:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF align="left">						
												<%=member.getBir_day()%>
											</td>
										</tr>	
						　　　　　　　　　<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >職名 Level 変更 :</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF align="left">						
												<%=member.getPosition()%>
													<select name="position_level_<%=mseq%>"  id="position_level_<%=mseq%>">
														<option value="1" <%if(member.getPosition_level()==1){%>selected<%}%> >Grade4</option>
														<option value="2" <%if(member.getPosition_level()==2){%>selected<%}%> >Grade3</option>
														<option value="3" <%if(member.getPosition_level()==3){%>selected<%}%> >Grade2</option>
														<option value="4" <%if(member.getPosition_level()==4){%>selected<%}%> >Grade1</option>
														<option value="5" <%if(member.getPosition_level()==5){%>selected<%}%> >その他1 </option>
														<option value="6" <%if(member.getPosition_level()==6){%>selected<%}%> >その他2</option>
														<option value="7" <%if(member.getPosition_level()==7){%>selected<%}%> >その他3</option>
														<option value="8" <%if(member.getPosition_level()==8){%>selected<%}%> >その他4</option>																								
													</select>
													<a href="javascript:goPosiLevelView(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>													
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >部署名:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">														
												<% if(busho.equals("0")){%>経営役員<%}%>												
												<% if(busho.equals("1")){%>企画部<%}%>
												<% if(busho.equals("2")){%>事業統括部<%}%>
												<% if(busho.equals("3")){%>開発部<%}%>	
												<% if(busho.equals("4")){%>製造部<%}%>	
												<% if(busho.equals("5")){%>品質保証部<%}%>	
												<% if(busho.equals("6")){%>臨床開発部<%}%>	
												<% if(busho.equals("7")){%>安全管理部<%}%>	
												<% if(busho.equals("8")){%>その他<%}%>																									
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >秘密番号(質問/答え):</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">						
												<% if(himi.equals("1")){%>飼っているペットの名前は？<%}%>
												<% if(himi.equals("2")){%>旅行に行きたい場所は？<%}%>
												<% if(himi.equals("3")){%>子ども時代のヒーローは?<%}%>
												<% if(himi.equals("4")){%>嫌いな食べ物は?<%}%>
												<% if(himi.equals("5")){%>応援しているチームは?<%}%>
												<% if(himi.equals("6")){%>名前を変えるとしたら何？<%}%>
												<% if(himi.equals("7")){%>よくドライブした場所は?<%}%>
												<% if(himi.equals("8")){%> 一番好きな映画は?<%}%>
												<font  color="#007AC3"><%=member.getHimithu_2()%></a>		
											</td>
										</tr>	
										<tr>	
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >ip番号:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">						
												<%=member.getIp_info()%>	
											</td>
										</tr>	
										<tr>
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >承認可否変更:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">	
								<% if(memId.equals("admin")){%>
													adminは変更できません！！
								<%}else{%>
														
											<% if(member.getMember_yn()==1){%>
												<input type="radio" name="passVal_<%=mseq%>"  class="passVal_<%=mseq%>" value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">No</font>
												<input type="radio" name="passVal_<%=mseq%>"  class="passVal_<%=mseq%>" value="2"  onfocus="this.blur();" >Yes
											<%}%>
											<% if(member.getMember_yn()==2){%>
												<input type="radio" name="passVal_<%=mseq%>"  class="passVal_<%=mseq%>" value="1"   onfocus="this.blur();" ><font  color="#FF6600">No</font>
												<input type="radio" name="passVal_<%=mseq%>"  class="passVal_<%=mseq%>" value="2"  checked onfocus="this.blur();" >Yes
											<%}%>&nbsp;&nbsp;&nbsp;
												<a href="javascript:goOkView(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>	
								<%}%>								
											</td>
										</tr>	
										<tr>
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#F1F1F1  >システム権限 Level変更:</td>							
											<td style="padding: 3px 3px 3px 5px;" bgcolor=#FFFFFF  colspan="3" align="left">	
								<% if(memId.equals("admin")){%>
													adminは変更できません！！
								<%}else{%>
														
											<% if(member.getLevel()==1){%>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="2"  onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==2){%>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="2"  checked onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==3){%>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="2"   onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="3"  checked onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==4){%>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="2"   onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="4"  checked onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="5"  onfocus="this.blur();" >Level 5
											<%}%>
											<% if(member.getLevel()==5){%>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="2"   onfocus="this.blur();" >Level 2
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="3"  onfocus="this.blur();" >Level 3
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="4"  onfocus="this.blur();" >Level 4
												<input type="radio" name="levelVal_<%=mseq%>"  class="levelVal_<%=mseq%>" value="5"  checked onfocus="this.blur();" >Level 5
											<%}%>
											&nbsp;&nbsp;&nbsp;
												<a href="javascript:goLevelView(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/admin/btn_coment_editor.gif"  align="absmiddle"></a>	
								<%}%>								
											</td>
										</tr>																					
									</table>
<!--list_inner box----->												
												
				
			</div>
		</div>
	</span>
	</td>				
	</tr >		   				
<%	}
i++;	
}
%>		
</c:if>									
</form>			   
	
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
		
<form name="move" method="post">
	<input type="hidden" name="member_id" value="">
	<input type="hidden" name="mseq2" value="">
	<input type="hidden" name="okYn" value="">
	<input type="hidden" name="page" value="${currentPage}">
	<c:if test="<%= searchCondMid%>">
	<input type="hidden" name="search_cond" value="mid">
	</c:if>								
	<c:if test="<%= searchCondAdd %>">
	<input type="hidden" name="search_cond" value="add">
	</c:if>								
	<c:if test="${! empty param.search_key}">
	<input type="hidden" name="search_key" value="${param.search_key}">
	</c:if>
</form>		
	



<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/member/listForm.jsp";
    document.move.page.value = pageNo;
    document.move.submit();
}
function goModiView(member_id) {	
    document.move.action = "<%=urlPage%>rms/admin/member/updateForm_admin.jsp";    
    document.move.member_id.value = member_id;
    document.move.submit();
}
//----------------show
function goOkView2(mseq) {		
	var jinoValue=eval("document.frm.passVal2_"+mseq); 	
	var valueMseq=(jinoValue[0].checked==true) ?  "1" : "2";		
	document.move.action = "<%=urlPage%>rms/admin/member/member_yn.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = valueMseq;
	document.move.submit();
}
function goLevelView2(mseq) {	
	var jinoValue=eval("document.frm.levelVal2_"+mseq); 	
	var valueMseq="";
	for(var i=0;i<jinoValue.length;i++){
		if(jinoValue[i].checked==true){
			valueMseq=jinoValue[i].value;
		}
	}	
	document.move.action = "<%=urlPage%>rms/admin/member/member_level.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = valueMseq;
	document.move.submit();
}
function goPosiLevelView2(mseq) {	
	var jinoValue=eval("document.frm.position_level2_"+mseq); 		
	document.move.action = "<%=urlPage%>rms/admin/member/member_posisionLevel.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = jinoValue.value;
	document.move.submit();
}
//----------------hidden
function goOkView(mseq) {		
	var jinoValue=eval("document.frm.passVal_"+mseq); 	
	var valueMseq=(jinoValue[0].checked==true) ?  "1" : "2";		
	document.move.action = "<%=urlPage%>rms/admin/member/member_yn.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = valueMseq;
	document.move.submit();
}
function goLevelView(mseq) {	
	var jinoValue=eval("document.frm.levelVal_"+mseq); 
	
	var valueMseq="";
	for(var i=0;i<jinoValue.length;i++){
		if(jinoValue[i].checked==true){
			valueMseq=jinoValue[i].value;
		}
	}	
	document.move.action = "<%=urlPage%>rms/admin/member/member_level.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = valueMseq;
	document.move.submit();
}
function goPosiLevelView(mseq) {	
	var jinoValue=eval("document.frm.position_level_"+mseq); 	
	
	document.move.action = "<%=urlPage%>rms/admin/member/member_posisionLevel.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = jinoValue.value;
	document.move.submit();
}

</script>





