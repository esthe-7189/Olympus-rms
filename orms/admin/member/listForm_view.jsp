<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
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
if(kind!=null && ! kind.equals("home")){
%>			
	<jsp:forward page="/orms/template/tempMain.jsp">		    
		<jsp:param name="CSSPAGE1" value="/orms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	if(level!=1){
%>			
	<jsp:forward page="/orms/template/tempMain.jsp">		    
		<jsp:param name="CSSPAGE1" value="/orms/home/home.jsp" />	
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
				whereCond.add("name1  LIKE '%"+searchKey+"%'");				
				searchCondMid=true;		
			}else if (searchCond[i].equals("add")){
				whereCond.add("kuni LIKE '%"+searchKey+"%'");				
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

<center>
<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">			
	<tr>		
    		<td align="left" width="100%"  style="padding-left:10px"  class="calendar15">
    				<img src="<%=urlPage%>orms/images/common/ArrowNews.gif" >
				<img src="<%=urlPage%>orms/images/common/ArrowNews.gif" style="filter:Alpha(Opacity=60);">全会員リスト
    		</td>    		
	</tr>	
	<tr>		
    		<td width="100%" bgcolor="#e2e2e2" height="1"></td>    		
	</tr>	
</table>	
<p>	
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
<table border="0" cellpadding="0" cellspacing="0" class=c width="100%"  bgcolor="#F7F5EF">				
		<tr>
			<td  style="padding-top:20px;" >						
				<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
					<tr>
					<td style="padding: 2 0 2 0">
<table width="95%" border='0' cellpadding='0' cellspacing='1'>
	<form name="search"  action="<%=urlPage%>orms/admin/member/listForm.jsp" method="post">	
	<tr>			
		<td valign="middle" width="17%">			
			<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="select_type2" onKeyPress="return doSubmitOnEnter()">
				  	 <option name="search_cond" VALUE="" >::::::::::::Search::::::::::::::::</OPTION>	
			            	<option name="search_cond" VALUE="mid"  >氏名</option>			
					<option name="search_cond" VALUE="add"  >住所</option>						
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="20%" align="left">
		 	<input type=text  name="search_key" size="30"  class="input02" >
		 </td>
		 <td valign="middle" width="10%" align="left">		 			  
		 	<input type="submit" name="" value="検索"  id="Search" title="SEARCH!" class="button buttonBright" />
		 </td>
		 <td valign="middle" width="53%" align="right">
		 	<input type="button" name="" value="全体目録" onclick="location.href='<%=urlPage%>orms/admin/member/listForm.jsp'" id="LIST!"  title="LIST!" class="button buttonGeneral" />		  
		 </td>		 	
	</tr>
	</form>	
</table>
<table width="95%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>	
	<tr bgcolor="" align=center height=26>	
			<td>登録日</td>
			<td><font  color="#FF0FFF">Level</font></td>
			<td>氏名</td>			
			<td>ID</td>
			<td>pw</td>
			<td>email</td>			
			<td>国籍</td>			
			<td>取り消し</td>		
	</tr>			
	<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td colspan="8">登録された内容がありません。</td></tr>
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
						String kuni=member.getKuni();							
						String memId=member.getMail_address();						
	%>
		<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
		<form name="frm" > 
		<input type="hidden" name="mseq" value="<%=member.getMseq()%>">							
					<td><%=register%></td>
					<td align="center"><%=member.getLevel()%></td>	
					<td align="left">
						<a href="javascript:ShowHidden('itemData_block','<%=i%>');"  onFocus="this.blur()">
							<font  color="#009999"><%=member.getName1()%></font>(<%=member.getName2()%>)</a>
					</td>								
					<td align="left"><%=member.getMail_address()%>		
	(<%if(sex.equals("1")){%>
			男
		<%}else{%>
			女
		<%}%>/<%=member.getAge()%>歳)
	
					</td>
					<td><%=member.getPassword()%></td>
					<td align="left"><a href="mailto:<%=member.getMail_address()%>?subject=olympus-rms!!"><%=member.getMail_address()%></a></td>					
					<td align="left">
						<% if(kuni.equals("北海道")){%>北海道<%}%>						
						<% if(kuni.equals("岩手県")){%>岩手県<%}%>
						<% if(kuni.equals("宮城県")){%>宮城県<%}%>
						<% if(kuni.equals("秋田県")){%>秋田県<%}%>
						<% if(kuni.equals("山形県")){%>山形県<%}%>
						<% if(kuni.equals("福島県")){%>福島県<%}%>
						<% if(kuni.equals("茨城県")){%>茨城県<%}%>
						<% if(kuni.equals("栃木県")){%>栃木県<%}%>
						<% if(kuni.equals("群馬県")){%>群馬県<%}%>
						<% if(kuni.equals("埼玉県")){%>埼玉県<%}%>
						<% if(kuni.equals("千葉県")){%>千葉県<%}%>
						<% if(kuni.equals("東京都")){%>東京都<%}%>
						<% if(kuni.equals("神奈川県")){%>神奈川県<%}%>
						<% if(kuni.equals("新潟県")){%>新潟県<%}%>
						<% if(kuni.equals("富山県")){%>富山県<%}%>
						<% if(kuni.equals("石川県")){%>石川県<%}%>
						<% if(kuni.equals("福井県")){%>福井県<%}%>
						<% if(kuni.equals("山梨県")){%>山梨県<%}%>
						<% if(kuni.equals("長野県")){%>長野県<%}%>
						<% if(kuni.equals("岐阜県")){%>岐阜県<%}%>
						<% if(kuni.equals("静岡県")){%>静岡県<%}%>
						<% if(kuni.equals("愛知県")){%>愛知県<%}%>
						<% if(kuni.equals("三重県")){%>三重県<%}%>
						<% if(kuni.equals("滋賀県")){%>滋賀県<%}%>
						<% if(kuni.equals("京都府")){%>京都府<%}%>
						<% if(kuni.equals("大阪府")){%>大阪府<%}%>
						<% if(kuni.equals("兵庫県")){%>兵庫県<%}%>
						<% if(kuni.equals("奈良県")){%>奈良県<%}%>
						<% if(kuni.equals("和歌山県")){%>和歌山県<%}%>
						<% if(kuni.equals("鳥取県")){%>鳥取県<%}%>
						<% if(kuni.equals("島根県")){%>島根県<%}%>
						<% if(kuni.equals("岡山県")){%>岡山県<%}%>
						<% if(kuni.equals("広島県")){%>広島県<%}%>
						<% if(kuni.equals("山口県")){%>山口県<%}%>
						<% if(kuni.equals("徳島県")){%>徳島県<%}%>
						<% if(kuni.equals("香川県")){%>香川県<%}%>
						<% if(kuni.equals("愛媛県")){%>愛媛県<%}%>
						<% if(kuni.equals("高知県")){%>高知県<%}%>
						<% if(kuni.equals("福岡県")){%>福岡県<%}%>
						<% if(kuni.equals("佐賀県")){%>佐賀県<%}%>
						<% if(kuni.equals("長崎県")){%>長崎県<%}%>
						<% if(kuni.equals("熊本県")){%>熊本県<%}%>
						<% if(kuni.equals("大分県")){%>大分県<%}%>
						<% if(kuni.equals("宮崎県")){%>宮崎県<%}%>
						<% if(kuni.equals("鹿児島県")){%>鹿児島県<%}%>
						<% if(kuni.equals("沖繩県")){%>沖繩県<%}%>
						<% if(kuni.equals("海外・ヨーロッパ（ロシア含む）地域")){%>海外・ヨーロッパ（ロシア含む）地域<%}%>
						<% if(kuni.equals("海外・中近東地域")){%>海外・中近東地域<%}%>
						<% if(kuni.equals("海外・アフリカ地域")){%>海外・アフリカ地域<%}%>
						<% if(kuni.equals("海外・北米地域")){%>海外・北米地域<%}%>
						<% if(kuni.equals("海外・中南米地域")){%>海外・中南米地域<%}%>
						<% if(kuni.equals("海外・アジア地域")){%>海外・アジア地域<%}%>
						<% if(kuni.equals("海外・オセアニア地域")){%>海外・オセアニア地域<%}%>
						<% if(kuni.equals("海外・上記以外")){%>海外・上記以外<%}%>						
						<% if(kuni.equals("青森県")){%>青森県<%}%>
						.
					</td>													
					<td align="center">						
						<a href="<%=urlPage%>orms/admin/member/delete.jsp?member_id=<%=memId%>&mseq=<%=member.getMseq()%>"  onfocus="this.blur()">
						<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle" alt="取り消し"></a>
					</td>
			</tr>	
			<tr>
				<td  style="padding-top: 0px;" colspan="8" align="center" width="90%" valign="top">
					<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand">								
									<table width=80% border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2 >																									　　　　　　　　　								
										<tr>	
											<td style="padding: 5 5 5 5" bgcolor=#F1F1F1 width="20%" align="center">ip番号:</td>							
											<td style="padding: 5 5 5 5" bgcolor=#FFFFFF width="80%">						
												<%=member.getIp_info()%>	
											</td>
										</tr>											
										<tr>
											<td style="padding: 5 5 5 5" bgcolor=#F1F1F1 width="20%" align="center">Level変更:</td>							
											<td style="padding: 5 5 5 5" bgcolor=#FFFFFF width="80%">	
								<% if(memId.equals("admin")){%>
													adminは変更できません！！
								<%}else{%>
											<% if(member.getLevel()==1){%>
												<input type="radio" name="levelVal_<%=mseq%>"  value="1" checked  onfocus="this.blur();" ><font  color="#FF6600">管理者</font>
												<input type="radio" name="levelVal_<%=mseq%>"  value="2"  onfocus="this.blur();" >社員
												<input type="radio" name="levelVal_<%=mseq%>"  value="3"  onfocus="this.blur();" >一般会員
											<%}%>
											<% if(member.getLevel()==2){%>
												<input type="radio" name="levelVal_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">管理者</font>
												<input type="radio" name="levelVal_<%=mseq%>"  value="2"  checked onfocus="this.blur();" >社員
												<input type="radio" name="levelVal_<%=mseq%>"  value="3"  onfocus="this.blur();" >一般会員
											<%}%>
											<% if(member.getLevel()==3){%>
												<input type="radio" name="levelVal_<%=mseq%>"  value="1"   onfocus="this.blur();" ><font  color="#FF6600">管理者</font>
												<input type="radio" name="levelVal_<%=mseq%>"  value="2"   onfocus="this.blur();" >社員
												<input type="radio" name="levelVal_<%=mseq%>"  value="3"  checked onfocus="this.blur();" >一般会員
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
</table>						
</form>
<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>orms/admin/member/listForm.jsp";
    document.move.page.value = pageNo;
    document.move.submit();
}
function goModiView(member_id) {
    document.move.action = "<%=urlPage%>orms/admin/member/updateForm_admin.jsp";    
    document.move.member_id.value = member_id;
    document.move.submit();
}

function goLevelView(mseq) {		
//	var jinoValue="levelVal_"+mseq; 
//	var valueMseq=document.frm.jinoValue.value;		
	alert("準備中");
//	document.move.action = "<%=urlPage%>orms/admin/member/member_level.jsp";
//	document.move.mseq2.value = mseq;
//	document.move.okYn.value = valueMseq;
//	document.move.submit();
}
</script>
<p>
<!-- *****************************page No start******************************-->		
<c:set var="count" value="<%= Integer.toString(count) %>" />
<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
		
<table cellpadding=0 cellspacing=0 border=0 height=20 align="center" width="45%">
	<tr>
<c:if test="${count > 0}">
    <c:set var="pageCount" value="${count / PAGE_SIZE + (count % PAGE_SIZE == 0 ? 0 : 1)}" />
    <c:set var="startPage" value="${currentPage - (currentPage % 10) + 1}" />
    <c:set var="endPage" value="${startPage + 10}" />
    
    
    <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}" />
    </c:if>
    			
	<c:if test="${startPage > 10}">
        	<td  style="padding-right:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>orms/images/admin/LeftBox.gif"></a>
		</td>
    	</c:if>    	
        	<td  style="padding-right:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<img src="<%=urlPage%>orms/images/admin/LeftBox.gif" style="filter:Alpha(Opacity=40);">
		</td>  
		<td align=center valign=absmiddle width="70%">
			<table cellpadding=0 cellspacing=0 border=0 style='table-layout:fixed;'>
				<tr><td width="" align="center">
	<c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
        	<c:if test="${currentPage == pageNo}">
					<b><font class="red"></c:if>
						<a href="javascript:goPage(${pageNo})" onfocus="this.blur()" class="paging">${pageNo}</a>						
		<c:if test="${currentPage == pageNo}"></font></b></c:if>
    	</c:forEach>
    					</td>
				</tr>
			</table>
		</td>
	<c:if test="${endPage < pageCount}">
        	<td width="" style="padding-left:8" valign=absmiddle style="padding-top:4px;">
			<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>orms/images/admin/RightBox.gif"></a>
		</td>
    	</c:if>
		<td  style="padding-left:8" valign=absmiddle style="padding-top:4px;">			
			<img src="<%=urlPage%>orms/images/admin/RightBox.gif" style="filter:Alpha(Opacity=40);">
		</td>			
</c:if>
		
		<c:if test="<%= count >= 0 %>">
		<td   width="50" style="padding-left:8" style="padding-top:4px;">			
			total:<font color="#807265">(<%= count %>)</font>		
		</td>	
		</c:if>
   </tr>
</table>
<!-- *****************************page No end-->					

<td>
</tr>
<tr>
	<td valign="middle" >	
<c:if test="<%= searchCondMid || searchCondAdd %>">
検索条件: [	
	<c:if test="<%= searchCondMid%>">氏名</c:if>	
	<c:if test="<%= searchCondAdd%>">住所</c:if>	
	=<%=searchKey%>	]
</c:if>
		</td> 		
</td>
</table>
