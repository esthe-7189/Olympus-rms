<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page errorPage="/rms/error/error-common.jsp"%>
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
if(kind!=null && ! kind.equals("toku")){
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
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">会員管理 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="会員登録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/member/writeForm.jsp'">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体目録 >>" onClick="location.href='<%=urlPage%>tokubetu/admin/member/listForm.jsp'">		
</div>
<div id="boxNoLineBig"  >		
	<table width="960">
 	<form name="search"  action="<%=urlPage%>tokubetu/admin/member/listForm.jsp" method="post">				
	<tr height="29">
		<td colspan="2">				
   				<font color="#807265">※氏名をクリックするとLevelや承認可否などの変更ができます。　ただし、管理者(admin)は変更できません。 </font>            				
		</td>
	</tr>
	<tr>
		<td width="90%">	
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">
				<select name="search_cond" class="select_type3" >								
					<option name="" VALUE=""  >選択して下さい</option>									
					<option name="search_cond" VALUE="mid"  >氏名</option>			
					<option name="search_cond" VALUE="add"  >住所</option>											
				</select>
			</div>
			<input type=text  name="search_key" size=25  class="logbox" >
			<input type="submit"  align=absmiddle value="  検索 >> " style=cursor:pointer  class="cc" onfocus="this.blur();" >
			<input type="button"  align=absmiddle value="  目録  >>"  style=cursor:pointer class="cc" onfocus="this.blur();"  onClick="location.href='<%=urlPage%>tokubetu/admin/member/listForm.jsp'">		
		</td>
		<td width="90%" align="right">	
			<font  color="#FF6600">(<%=count%>個)</font>	
		</td>		
	</tr>
	</form>					 		
</table>	
	
<table width="100%"  class="tablebox_list" cellpadding="0" cellspacing="0" >			
	<form name="frm" >	
		<tr height=30 bgcolor=#F1F1F1 align=center>				
			<td class="title_list_all">登録日</td>
			<td class="title_list_m"><font  color="#FF0FFF">System</font>Level</td>
			<td class="title_list_m"><font  color="#FF0FFF">社員</font>Level</td>
			<td class="title_list_m">氏名</td>			
			<td class="title_list_m">ID</td>
			<td class="title_list_m">pw</td>
			<td class="title_list_m">email</td>			
			<td class="title_list_m">電話</td>	
			<td class="title_list_m"><font  color="#FF0FFF">承認可否</font></td>			
			<td class="title_list_m">修正</td>
			<td class="title_list_m">取り消し</td>
		</tr>		
	<c:if test="${empty list}">
		<tr><td colspan="11">No Data</td></tr>
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
						String memId=member.getMember_id();						
	%>	
		<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
		<input type="hidden" name="mseq" value="<%=member.getMseq()%>">							
					<td><%=register%></td>
					<td align="center"><%=member.getLevel()%></td>	
					<td align="center"><%=member.getPosition_level()%></td>	
					<td>
						<a href="javascript:ShowHidden('itemData_block','<%=i%>');"  onFocus="this.blur()">
							<font  color="#009999"><%=member.getNm()%></font>(<%=member.getHurigana()%>)</a>
					</td>								
					<td><%=member.getMember_id()%>		
	(<%if(sex.equals("1")){%>
			男
		<%}else{%>
			女
		<%}%>)
	
					</td>
					<td><%=member.getPassword()%></td>
					<td><a href="mailto:<%=member.getMail_address()%>?subject=olympus-rms!!"><%=member.getMail_address()%></a></td>					
					<td><%=member.getTel()%></td>					
					<td>
			<%if(member.getMember_yn()==1){%> 				
				<font  color="#FF6600">No</font>				
			<%}%>
			<%if(member.getMember_yn()==2){%> 
				Ok
			<%}%>
					</td>
					<td width="5%"  align="center">						
						<a href="javascript:goModiView(<%=member.getMember_id()%>);" onfocus="this.blur()" style="CURSOR: pointer;">
						<a href="<%=urlPage%>tokubetu/admin/member/updateForm_admin.jsp?member_id=<%=member.getMember_id()%>"  onfocus="this.blur()">
						<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle" alt="書き直し"></a>
					</td>										
					<td width="5%"  align="center">						
						<a href="<%=urlPage%>tokubetu/admin/member/delete.jsp?member_id=<%=member.getMember_id()%>&mseq=<%=member.getMseq()%>"  onfocus="this.blur()">
						<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>
					</td>
			</tr>	
			<tr>
				<td  style="padding: 5px 5px 5px 5px;"  colspan="11" align="center" width="90%" >
					<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#EBEBD8;padding:7px 0px 7px 0px;">												
									<table width="70%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
										<tr>	
											<td bgcolor="#ffffff" style="padding: 5px 5px 5px 5px"  width="20%" align="center">住所:</td>							
											<td bgcolor="#ffffff" width="80%" align="left">						
												<font  color="#6699CC">(<%=member.getZip()%>)</font>) <%=member.getAddress()%>
											</td>
										</tr>	
										<tr>	
											<td bgcolor="#ffffff" style="padding: 5px 5px 5px 5px"  width="20%" align="center">お誕生日:</td>							
											<td bgcolor="#ffffff" width="80%" align="left">						
												<%=member.getBir_day()%>
											</td>
										</tr>	
						　　　　　　　　　<tr>	
											<td bgcolor="#ffffff"style="padding: 5px 5px 5px 5px"  width="20%" align="center">職名:</td>							
											<td bgcolor="#ffffff"  width="80%" align="left">						
												<%=member.getPosition()%>
											</td>
										</tr>
										<tr>
											<td bgcolor="#ffffff"style="padding: 5px 5px 5px 5px"  width="20%" align="center">職責レベル変更:</td>							
											<td bgcolor="#ffffff"  width="80%" align="left">													
													<select name="positionLlevel_<%=mseq%>" id="positionLlevel_<%=mseq%>" >
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
											<td bgcolor="#ffffff" style="padding: 5px 5px 5px 5px"  width="20%" align="center">秘密番号(質問/答え):</td>							
											<td bgcolor="#ffffff"  width="80%" align="left">						
												<% if(himi.equals("1")){%>飼っているペットの名前は？<%}%>
												<% if(himi.equals("2")){%>旅行に行きたい場所は？<%}%>
												<% if(himi.equals("3")){%>子ども時代のヒーローは?<%}%>
												<% if(himi.equals("4")){%>嫌いな食べ物は?<%}%>
												<% if(himi.equals("5")){%>応援しているチームは?<%}%>
												<% if(himi.equals("6")){%>名前を変えるとしたら何？<%}%>
												<% if(himi.equals("7")){%>よくドライブした場所は?<%}%>
												<% if(himi.equals("8")){%> 一番好きな映画は?<%}%>
												<font  color="##9900FF"><%=member.getHimithu_2()%></a>		
											</td>
										</tr>	
										<tr>	
											<td bgcolor="#ffffff" style="padding: 5px 5px 5px 5px"  width="20%" align="center">ip番号:</td>							
											<td bgcolor="#ffffff"  width="80%" align="left">						
												<%=member.getIp_info()%>	
											</td>
										</tr>	
										<tr>
											<td bgcolor="#ffffff" style="padding: 5px 5px 5px 5px"  width="20%" align="center">承認可否変更:</td>							
											<td bgcolor="#ffffff"  width="80%" align="left">	
								<% if(memId.equals("admin")){%>
													adminは変更できません！！
								<%}else{%>
														
											<% if(member.getMember_yn()==1){%>
												<input type="radio" name="passVal_<%=mseq%>"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">No</font>
												<input type="radio" name="passVal_<%=mseq%>"  value="2"  onfocus="this.blur();" >Yes
											<%}%>
											<% if(member.getMember_yn()==2){%>
												<input type="radio" name="passVal_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">No</font>
												<input type="radio" name="passVal_<%=mseq%>"  value="2"  checked onfocus="this.blur();" >Yes
											<%}%>&nbsp;&nbsp;&nbsp;
												<a href="javascript:goOkView(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/ic_go.gif"  align="bottom"></a>	
								<%}%>								
											</td>
										</tr>	
										<tr>
											<td bgcolor="#ffffff" style="padding: 5px 5px 5px 5px"  width="20%" align="center">システムレベル変更:</td>							
											<td bgcolor="#ffffff"  width="80%" align="left">	
								<% if(memId.equals("admin")){%>
													adminは変更できません！！
								<%}else{%>
														
											<% if(member.getLevel()==1){%>
												<input type="radio" name="levelVal_<%=mseq%>"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal_<%=mseq%>"  value="2"  onfocus="this.blur();" >Level 2
											<%}%>
											<% if(member.getLevel()==2){%>
												<input type="radio" name="levelVal_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">Level 1</font>
												<input type="radio" name="levelVal_<%=mseq%>"  value="2"  checked onfocus="this.blur();" >Level 2
											<%}%>&nbsp;&nbsp;&nbsp;
												<a href="javascript:goLevelView(<%=mseq%>);" onfocus="this.blur()" style="CURSOR: pointer;">
													<img src="<%=urlPage%>rms/image/ic_go.gif"  align="bottom"></a>	
								<%}%>								
											</td>
										</tr>																				
									</table>
								
					</span>
				</td>
			</tr>		
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
    document.move.action = "<%=urlPage%>tokubetu/admin/member/listForm.jsp";
    document.move.page.value = pageNo;
    document.move.submit();
}
function goModiView(member_id) {
    document.move.action = "<%=urlPage%>tokubetu/admin/member/updateForm_admin.jsp";    
    document.move.member_id.value = member_id;
    document.move.submit();
}

function goOkView(mseq) {		
	var jinoValue=eval("document.frm.passVal_"+mseq); 
	var valueMseq=(jinoValue[0].checked==true) ?  "1" : "2";		
	document.move.action = "<%=urlPage%>tokubetu/admin/member/member_yn.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = valueMseq;
	document.move.submit();
}
function goLevelView(mseq) {		
	var jinoValue=eval("document.frm.levelVal_"+mseq); 
	var valueMseq=(jinoValue[0].checked==true) ?  "1" : "2";		
	document.move.action = "<%=urlPage%>tokubetu/admin/member/member_level.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = valueMseq;
	document.move.submit();
}
function goPosiLevelView2(mseq) {
	var jinoValue=eval("document.frm.positionLlevel_"+mseq); 			
	
	alert(jinoValue.value+"---"+mseq);
	document.move.action = "<%=urlPage%>tokubetu/admin/member/member_posisionLevel.jsp";
	document.move.mseq2.value = mseq;
	document.move.okYn.value = jinoValue.value;
	document.move.submit();
}
</script>


