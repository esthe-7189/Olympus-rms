<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "mira.hitokoto.NewsBean " %>
<%@ page import = "mira.hitokoto.NewsManager" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "java.text.SimpleDateFormat" %>	
<%! 
static int PAGE_SIZE=50; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");	
%>
<%	
		
MemberManager memmgr = MemberManager.getInstance();
	String id=(String)session.getAttribute("ID");	
	Member member2=memmgr.getMember(id);
	String kind=(String)session.getAttribute("KIND");
	
if(kind!=null && ! kind.equals("bun")){
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

	boolean searchCondTitle = false;	
	boolean searchCondView_ok=false;
	boolean searchCondView_no=false;

	if (searchCond != null && searchCond.length > 0 && searchKey != null){	
		whereCond = new java.util.ArrayList();
		whereValue = new java.util.HashMap();

		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("title")){
				whereCond.add("title LIKE '%"+searchKey+"%'");		
				searchCondTitle = true;
			}else if (searchCond[i].equals("view_ok")){
				whereCond.add("view_yn=1");		
				searchCondView_ok = true;
			}else if (searchCond[i].equals("view_no")){
				whereCond.add("view_yn=2");		
				searchCondView_no = true;
			}	
		}
	}

	NewsManager manager = NewsManager.getInstance();	
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
<script type="text/javascript">
function popup_Layer(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     // 좌우 위치 지정
     if(_marginx < 0){
        main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px";
     }
     else{
        main.style.left = event.clientX + document.body.scrollLeft-5+"px";
     }
     //높이 지정
     if(_marginy < 0){
        main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";
     }  
     else{
        main.style.top = event.clientY + document.body.scrollTop-5+"px";
     } 
} 


function Layer_popup_Off() { 
  var frm=document.frm;
  var pay_len = eval(frm.divPass.length);  
  
  var pay_val=frm.divPass;
  if (pay_len>1){
  	  
	  for (i=0; i<pay_len; i++) {		  
	  	 
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
} 

</script> 	
<div id="overlay"></div>
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">管理者に一言 </span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録 >>" onClick="location.href='<%=urlPage%>rms/admin/hitokoto/addForm.jsp'">
</div>

<table  width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
<form name="search"  action="<%=urlPage%>rms/admin/hitokoto/listForm.jsp?page=1" method="post">	
	<tr>
		<td>
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">
			<select name="search_cond" class="select_type3" >								
				<option name="search_cond" VALUE="" >:::Search:::</OPTION>	
				<option name="search_cond" VALUE="view_ok" >展示中</OPTION>	
				<option name="search_cond" VALUE="view_no" >展示してない</OPTION>			          	
				<option name="search_cond" VALUE="title"  >タイトル</OPTION>												
				</select>
		</div>
				<input type=text  name="search_key" size=25  class="input02" >
				<input type="submit"  style=cursor:pointer align=absmiddle value="検索 >>" class="cc" onfocus="this.blur();" >
				<input type="button"   style=cursor:pointer align=absmiddle value="全体目録 >>" class="cc" onfocus="this.blur();"  onClick="location.href='<%=urlPage%>rms/admin/hitokoto/listForm.jsp?page=1'">		
		</td>										
		</tr>
	</form>
</table>
									
			
<table width="80%"  class="box_100" cellspacing="2" cellpadding="2"  >
	<form name="frm"  >	
	<thead >
		<tr bgcolor=#F1F1F1 align=center height=22>									
				<td  width="15%" class="clear_dot">登録日</td>				
				<td  width="45%"  class="clear_dot">タイトル</td>							
				<td   width="10%" class="clear_dot">回答結果</td>				
				<td   width="10%" class="clear_dot">修正</td>
				<td   width="10%" class="clear_dot">削除</td>						
			</tr>
	<thead>
	<tbody>						
			<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td colspan="5" class="clear_dot">登録された内容がありません。</td></tr>
			</c:if>
			<c:if test="${! empty list}">
			<c:forEach var="news" items="${list}" varStatus="idx">
			<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" height="20">				
				<td align="center" class="clear_dot"><fmt:formatDate value="${news.register}" pattern="yyyy-MM-dd" /></td>				
				<td  align="left" class="clear_dot">					
					<a href="javascript:ShowHidden('itemData_block','${idx.index+1}');"  onFocus="this.blur()">
					${news.title}</a>
				</td>
				<td  align="center" class="clear_dot">
<%if(member2.getLevel()==1){%>		
<input type="hidden" name="divPass" value="popup_${news.seq}">		
<!-- *****************************레이어 start-->
<div id="popup_${news.seq}" style="padding:5px 5px 5px 5px;border:2px solid #E5E5E5;position:absolute; left:0px; top:0px; z-index:999;display:none;filter: alpha(opacity=95);" >
	<table border="0" width="200" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td class="calendar7" style="padding:2 0 2 10;">返事可否</td>
		     	<td align="right"><a onclick="Layer_popup_Off();"  style="CURSOR: pointer;"><img src="<%=urlPage%>orms/images/common/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="200" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	        
            <tr>			         
			<td  valign="top" width="80%" valign="middle" style="padding:15 0 5 10;" >		
				<input type="radio" name="passVal_${news.seq}" value="1"  onfocus="this.blur()" <c:if test="${news.view_yn==1}">checked </c:if>><font  color="#FF6600">はい</font>
				<input type="radio" name="passVal_${news.seq}" value="2"  onfocus="this.blur()"  <c:if test="${news.view_yn==2}">checked </c:if>><font  color="#FF6600">いいえ</font><br>
			</td>
			<td valign="top" width="20%" valign="bottom" style="padding:15 0 5 3;" rowspan="2">
				<a href="javascript:goDown(${news.seq});" onfocus="this.blur()">	
				<img src="<%=urlPage%>rms/image/ic_go.gif" align="asbmiddle"></a>
            		</td>
	</tr>	
     </table>
</div>
<!-- ********************************레이어 end -->
	<a onclick="popup_Layer(event,'popup_${news.seq}');" style="CURSOR: pointer;">
													
	<a class="fileline" href="#" onclick="popupHengi(${news.seq});"   onfocus="this.blur()">
				<c:if test="${news.view_yn==1}">はい</c:if>
				<c:if test="${news.view_yn==2}"><font color="#FF6600">いいえ</font></c:if></a>
<%}else{%>
				<c:if test="${news.view_yn==1}">はい</c:if>
				<c:if test="${news.view_yn==2}"><font color="#FF6600">いいえ</font></c:if>
<%}%>
				</td>				
				<td align="center" class="clear_dot">
					<a href="javascript:goModify(${news.seq})" onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif" alt="Modify" >
					</a></td>
				<td align="center" class="clear_dot">
					<a href="javascript:goDelete('${news.seq}')"  onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" alt="Cancel">
					</a></td>
			</tr>
				<td  style="padding-top: 0px;" colspan="5" align="center" width="90%" valign="top" >
					<span id="itemData_block${idx.index+1}" style="DISPLAY:none; xCURSOR:hand">								
						<table width="85%" border="0" cellpadding="2" cellspacing="2" class="box_solid" >
<%if(member2.getLevel()==1){%>		
						<tr>	
							<td style="padding: 3px 3px 3px 5px;" bgcolor="#FAFAFA" width="15%"  align="left">お名前  ：　${news.nm}</td>
						</tr>
<%}%>							
						<tr>	
							<td style="padding: 3px 3px 3px 5px;"  bgcolor="#FAFAFA" width="15%" align="left">${news.content}</td>
						</tr>
						</table>
					</span>
				</td>
			</tr>
								
			</c:forEach>
			</c:if>
			</form>
</table>
<table  width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
		<tr>
			<td >													
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
			</td>
		</tr>
	</table>
<!-- 팝업 start-->				
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->	
<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/hitokoto/listForm.jsp";
    document.move.page.value = pageNo;
    document.move.submit();
}

function goModify(seq) {
	document.move.action = "<%=urlPage%>rms/admin/hitokoto/updateForm.jsp";
	document.move.seq.value=seq;
    	document.move.submit();
}
function goDelete(seq) {
	document.move.seq.value=seq;	
	
	if ( confirm("本内容を削除しますか?") != 1 ) {
		return;
	}
    	document.move.action = "<%=urlPage%>rms/admin/hitokoto/deleteForm.jsp";	
    	document.move.submit();
}
function goDown(seq) {		
	var passValue=eval("document.frm.passVal_"+seq); 	
	var valueView=(passValue[0].checked==true) ?  "1" : "2";		
	document.move.action = "<%=urlPage%>rms/admin/hitokoto/viewUpdate.jsp";	
	document.move.seq.value = seq;
	document.move.view_yn.value = valueView; 
	document.move.submit();
}
function popupHengi(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/hitokoto/popup_hengiView.jsp?seq="+seq; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
</script>

<form name="move" method="post">
    <input type="hidden" name="seq" value="">    
    <input type="hidden" name="view_yn" value="">    
    <input type="hidden" name="page" value="${currentPage}">    
    <c:if test="<%= searchCondView_ok%>">
    <input type="hidden" name="search_cond" value="view_ok">
    </c:if>	
    <c:if test="<%= searchCondView_no%>">
    <input type="hidden" name="search_cond" value="view_no">
    </c:if>	
    <c:if test="<%= searchCondTitle%>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>
</form>