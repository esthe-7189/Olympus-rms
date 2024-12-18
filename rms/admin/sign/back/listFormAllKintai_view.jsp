<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
static int PAGE_SIZE=15; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>

<%	
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
	String pass=""; 
	int mseq=0; 
	int level=0; 
		
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){		 
		 level=member.getPosition_level();		 
		 mseq=member.getMseq();
	}
	String[] searchCond=request.getParameterValues("search_cond");	
	String sign_ok_mseq =request.getParameter("sign_ok_mseq");	
	if(sign_ok_mseq==null){sign_ok_mseq="1";}
		
	boolean searchCond01 = false;
	boolean searchCond02 = false;	
	boolean searchCond03 = false;
			
	if (searchCond != null && searchCond.length > 0 ){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("1")){
				sign_ok_mseq="1";				
				searchCond01=true;
			}else if (searchCond[i].equals("2")){
				sign_ok_mseq="2";	
				searchCond02 = true;
			}else if (searchCond[i].equals("3")){
				sign_ok_mseq="3";
				searchCond03 = true;
			}		
		}
	}
	int sign_ok_mseqInt=Integer.parseInt(sign_ok_mseq);
	
	String pageNum = request.getParameter("page");
   	 if (pageNum == null) pageNum = "1";
   	 int currentPage = Integer.parseInt(pageNum);		

	List  whereCond = null;
	Map whereValue = null;	

	boolean cateArrayPcategory = false;
	if (sign_ok_mseq !=null ){
		whereCond=new java.util.ArrayList();
		whereValue=new java.util.HashMap();
		
			whereCond.add(" sign_ok=1 and mseq=4 ");
					
			cateArrayPcategory=true;	
	}

	DataMgrKintai mgr = DataMgrKintai.getInstance();	
	int count = mgr.count(whereCond, whereValue);
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
	List  list=mgr.selectList(whereCond, whereValue,startRow,endRow);	
	DataMgr mgrSche = DataMgr.getInstance();		
%>
<c:set var="list" value="<%= list %>" />
	
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
function popup_LayerCo(event,popup_name) {    //팝업레이어 생성
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
  var frm=document.frm02;
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
function Layer_popup_Off03() { 
  var frm=document.frm03;
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
<table width="960" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">  	

	<tr>
		<td width="50%"  height="30" style="padding: 0 0 0 0"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">自己管理処理済み 
    		</td>    	
    		<td width="50%" height="31" valign="bottom"  align="right" style="padding:5 0 5 15">
    				
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="未処理" onClick="location.href='<%=urlPage%>rms/admin/sign/listForm.jsp'">		
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="自己管理処理済み" onClick="location.href='<%=urlPage%>rms/admin/sign/listFormAllKintai.jsp'">
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="日程管理処理済み" onClick="location.href='<%=urlPage%>rms/admin/sign/listForm.jsp'">	
</td>	
	</tr>		
</table>
<!--社員管理(出・退社) begin -->
<table width="55%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >	
	<tr>
		<td width="10%"  valign="bottom"  style="padding:2 0 2 2" class="calendar5_01">自己管理(出・退社)</td>				
	</tr>	
</table>	
<p>
<table width="80%" border='0' cellpadding='0' cellspacing='1'>
<form name="move" method="post">
	<input type="hidden" name="sign_ok_mseq" value="<%=sign_ok_mseq%>">
	<input type="hidden" name="member_id" value="">
	<input type="hidden" name="mseq2" value="">
	<input type="hidden" name="page" value="${currentPage}">
	    <c:if test="<%= searchCond01 %>">
	    <input type="hidden" name="search_cond" value="1">
	    </c:if>
	    <c:if test="<%= searchCond02 %>">
	    <input type="hidden" name="search_cond" value="2">
	    </c:if>	
	    <c:if test="<%= searchCond03 %>">
	    <input type="hidden" name="search_cond" value="3">
	    </c:if>
	    <input type="hidden" name="seq" value="">
	    <input type="hidden" name="sign_ok" value="">  
	    <input type="hidden" name="pgKind" value="sign">  	
</form>
<form name="search"  action="<%=urlPage%>rms/admin/sign/listFormAllKintai.jsp" method="post">
	<tr>
		<td width="50%" >
		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 2px 0 0;">
				  <select name="search_cond" class="select_type2" onKeyPress="return doSubmitOnEnter()">
			            	<option name="search_cond" VALUE="1" >미처리</option>
					<option name="search_cond" VALUE="2">처리완료</option>
					<option name="search_cond" VALUE="3">반환</option>
				  </select>
		        </div>
		</td>		        					
		 <td valign="middle" width="28%">				
		<input type=text  name="search_key" size="20"  class="input02" >				
			<input type="submit" style='border:0' align=absmiddle class="cc" onfocus="this.blur();"  style=cursor:pointer value="검색">
			<input type="button"  style='border:0' align=absmiddle class="cc" onfocus="this.blur();"  style=cursor:pointer value="전체list"  onClick="location.href='<%=urlPage%>rms/admin/sign/listFormAllKintai.jsp?'">		
		</td>
		<td width="30%"  style="padding: 2 0 2 0;">

<c:if test="<%= searchCond01 || searchCond02 ||  searchCond03%>">
検索条件: [	
	<c:if test="<%= searchCond01%>">미처리</c:if>	
	<c:if test="<%= searchCond02%>">처리완료</c:if>	
	<c:if test="<%= searchCond03%>">반환</c:if>
	]
</c:if>
		</td>			
	</tr>
</form>
</table>		
<table width="55%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
<form name="frm02" action="" method="post" >
	 <input type="hidden" name="mseq" value="<%=mseq%>">	
	 <input type="hidden" name="sign_ok" value="1">  <!--*** 1=사인전, 2=사인ok  -->
<tr bgcolor=#F1F1F1 align=center >	
    <td>日付</td>
    <td>氏名</td>
    <td>始業時間</td>
    <td>終業時間</td>   
    <td>理由</td>   
    <td>処理</td>       
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="6">NO DATA</td>
	</tr>
</c:if>				
<c:if test="${! empty list}">	
<%
	int i=1;
	Iterator listiter=list.iterator();					
	while (listiter.hasNext()){
		DataBeanKintai dbb=(DataBeanKintai)listiter.next();
		int seq=dbb.getSeq();											
		if(seq!=0){		
%>
<input type="hidden" name="divPass" value="popupCo_<%=seq%>">
<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center"><%=dbb.getHizuke()%></td>
	<td align="center"><%=dbb.getNm()%></td>	
	<td align="center"><%=dbb.getBegin_hh()%>:<%=dbb.getBegin_mm()%></td>	
	<td align="center"><%=dbb.getEnd_hh()%>:<%=dbb.getEnd_mm()%></td>	
	<td align="center">
<%if(dbb.getRiyu()==null){%>-
<%}else{%><%=dbb.getRiyu()%>
<%}%>
	</td>	
	<td align="center" >			
<!-- *****************************sign begin-->
<div id="popupCo_<%=seq%>" style="border:2px solid #FFCC00;position:absolute; left:0px; top:0px; z-index:999;display:none;filter: alpha(opacity=95);" >
	<table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td class="calendar5_03">決裁処理</td> 
		     	<td align="right"><a onclick="Layer_popup_Off();"  style="CURSOR: pointer;"><img src="<%=urlPage%>orms/images/common/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="150" height="20" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	
         	<tr>
                 <td align="center" valign="middle" style="padding:2 0 2 0;" >
    <a href="javascript:goSign('<%=dbb.getSeq()%>',2);" onfocus="this.blur()" style="CURSOR: pointer;">
    <img src="<%=urlPage%>rms/image/admin/btn_kesai_ok.gif"  align="absmiddle"></a>    
    		   
    <a href="javascript:goSign('<%=dbb.getSeq()%>',3);" onfocus="this.blur()" style="CURSOR: pointer;">
    <img src="<%=urlPage%>rms/image/admin/btn_kesai_no.gif"  align="absmiddle"></a>    
                </td>
            	</tr>            
     </table>
</div>
<!-- ********************************comment레이어 end -->
		<a onclick="popup_LayerCo(event,'popupCo_<%=seq%>');" style="CURSOR: pointer;">		
		<img src="<%=urlPage%>rms/image/admin/btn_kesai.gif"  align="absmiddle"></a>			
	</td>
</tr>
	
<%}
i++;	
}
%>			
</c:if>
</table>
</form>
<!--社員管理(出・退社) end -->


	
<form name="move" method="post">
    
 </form>
<script language="JavaScript">
function goPage(pageNo) {
    document.move.action = "<%=urlPage%>rms/admin/sign/listFormAllKintai.jsp"; 
    document.move.page.value = pageNo;    
    document.move.submit();
}

function goSign(seq,sign_ok) {
	if ( confirm("承認しますか?") != 1 ) {return;}		
	document.move.action = "<%=urlPage%>rms/admin/kintai/signOk.jsp";
	document.move.seq.value = seq;	
	document.move.sign_ok.value = sign_ok;
	document.move.pgKind.value = document.move.pgKind.value;	
	document.move.submit();
}

function goSignSche(sseq,sign_ok) {	
	if(sign_ok=="2"){
		if ( confirm("承認しますか?") != 1 ) {return;}
	}else{
		if ( confirm("返還しますか?") != 1 ) {return;}
	}	
	document.move.action = "<%=urlPage%>rms/admin/sign/signSheOk.jsp";
	document.move.seq.value = sseq;	
	document.move.sign_ok.value = sign_ok;	
	document.move.pgKind.value = document.move.pgKind.value;	
	document.move.submit();
}
</script>
<p>
<!-- *****************************page No start******************************-->		
<c:set var="count" value="<%= Integer.toString(count) %>" />
<c:set var="PAGE_SIZE" value="<%= Integer.toString(PAGE_SIZE) %>" />
<c:set var="currentPage" value="<%= Integer.toString(currentPage) %>" />
		
<table cellpadding=0 cellspacing=0 border=0 height=20 align="center" width="40%">
	<tr>
<c:if test="${count > 0}">
    <c:set var="pageCount" value="${count / PAGE_SIZE + (count % PAGE_SIZE == 0 ? 0 : 1)}" />
    <c:set var="startPage" value="${currentPage - (currentPage % 10) + 1}" />
    <c:set var="endPage" value="${startPage + 10}" />
    
    
    <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}" />
    </c:if>
    			
	<c:if test="${startPage > 10}">
        	<td  width="5%" style="padding-left:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;" >
			<a href="javascript:goPage(${startPage - 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>rms/image/LeftBox.gif"></a>
		</td>
    	</c:if>    	
    	<c:if test="${startPage <= 10}">
        	<td  width="5%" style="padding-left:8" valign=absmiddle style='table-layout:fixed;'  style="padding-top:4px;">
			<img src="<%=urlPage%>rms/image/LeftBox.gif" style="filter:Alpha(Opacity=40);">
		</td>  
	</c:if>
		<td width="60%" align=center valign=absmiddle>
			<table cellpadding=0 cellspacing=0 border=0 style='table-layout:fixed;'>
				<tr><td width="" align="center">
	<c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
        	<c:if test="${currentPage == pageNo}">
					<b><font class="red"></c:if>
						<a href="javascript:goPage(${pageNo})" onfocus="this.blur()" class="paging">[${pageNo}]</a>
		<c:if test="${currentPage == pageNo}"></font></b></c:if>
    	</c:forEach>
    					</td>
				</tr>
			</table>
		</td>
	<c:if test="${endPage < pageCount}">
        	<td width="5" style="padding-right:8" valign=absmiddle style="padding-top:4px;">
			<a href="javascript:goPage(${startPage + 10})" onfocus="this.blur()" class="paging"><img src="<%=urlPage%>rms/image/RightBox.gif"></a>
		</td>
    	</c:if>
    	<c:if test="${endPage >= pageCount}">
		<td  width="5%" style="padding-right:8" valign=absmiddle style="padding-top:4px;">			
			<img src="<%=urlPage%>rms/image/RightBox.gif" style="filter:Alpha(Opacity=40);">
		</td>
	</c:if>			
</c:if>
		<td width="30%">[件数:<%= count %>]</td>
   </tr>
</table>
<!-- *****************************page No end-->		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
