<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import="mira.sop.AccDownMgr" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
static int PAGE_SIZE=10; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String kind=(String)session.getAttribute("KIND");
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");

if(id==null || id.equals("candy")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
if(kind!=null && ! kind.equals("bun") ){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
    	
	int level_mem=0; int levelPosition=0;
	MemberManager managermem=MemberManager.getInstance();
	Member member=managermem.getMember(id);
	if(member!=null){
		level_mem=member.getLevel();
		levelPosition=member.getPosition_level();
	}

    String pageNum = request.getParameter("page");	
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);	
    
	String[] searchCond=request.getParameterValues("search_cond");
	String searchKey=request.getParameter("search_key");
	String cate_tab=request.getParameter("cate_tab");
	if(cate_tab==null){cate_tab="0";}
	int seq_tab_int=Integer.parseInt(cate_tab);
		
	List whereCond = null;
	Map whereValue = null;

	boolean searchCondFilename = false; boolean searchCondTitle = false; 

	whereCond = new java.util.ArrayList();
	whereValue = new java.util.HashMap();

	if (searchCond != null && searchCond.length > 0 && searchKey != null){
		for (int i=0;i<searchCond.length ;i++ ){
			if (searchCond[i].equals("filename")){
				whereCond.add(" filename  LIKE '%"+searchKey+"%'");				
				searchCondFilename=true;
			}else if (searchCond[i].equals("title")){
				whereCond.add("title LIKE '%"+searchKey+"%'");
				searchCondTitle = true;
			}			
		}
	}
	
	AccMgr manager = AccMgr.getInstance();	
	AccDownMgr manager2 = AccDownMgr.getInstance();	
	
	int count = 0;
	if(cate_tab.equals("0")){count=manager.count(whereCond, whereValue); }
	else{count=manager.count02(Integer.parseInt(cate_tab),whereCond, whereValue);}	
	
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
	List  list;
	if(cate_tab.equals("0")){list=manager.selectList(whereCond, whereValue,startRow,endRow); }
	else{list=manager.selectList02(Integer.parseInt(cate_tab),whereCond, whereValue,startRow,endRow);}			
		
	List  listDown; 	
	int tab_count=manager.tabCnt();
	List listTab=manager.listTab();
%>

<c:set var="list" value="<%=list %>" />
<c:set var="listTab" value="<%=listTab %>" />

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
function popup_Layer_tab(event,popup_name) {    //팝업레이어 생성
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
function popup_Layer2(event,popup_name) {    //팝업레이어 생성
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

function Layer_popup_Off_tab() { 
  var frm=document.frmtab;
  var pay_len = eval(frm.divPassTab.length);  
  var pay_val=frm.divPassTab;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
} 
 
function Layer_popup_OffCo() { 
  var frm=document.frm;
  var pay_len = eval(frm.divPassCo.length);  
  var pay_val=frm.divPassCo;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
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


function Layer_popup_Off2() { 
  var frm=document.frm;
  var pay_len = eval(frm.divPass2.length);  
  var pay_val=frm.divPass2;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
} 


function Layer_popup_OffMess(seq) { 
  var frm=document.frm;    
  var pay_len = document.getElementById("divPassMess"+seq);
  	
	eval(pay_len.value + ".style.display = \"none\"");   
}

</script> 	
<SCRIPT LANGUAGE="JavaScript">
function premier(n) {
    for(var i = 1; i < <%=tab_count+1%>; i++) {
        obj = document.getElementById('premier'+i);        
        if ( n == i ) {
            obj.style.display = "block";                        
        } else {
            obj.style.display = "none";                       
        }
    }   
}

</SCRIPT>
<div id="overlay"></div>
<div class="con_top_title" onmousedown="dropMenu()">	
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">標準作業手順書(SOP)<font color="#A2A2A2">    >   </font>全体リスト </span> 
</div>
<div class="clear"></div>
<div id="botton_position">	
	<div class="botton_positiontwo_left">
	<form name="search"  action="<%=urlPage%>rms/admin/sop/listForm.jsp" method="post">						
			<select name="search_cond"  style="font-size:12px;color:#7D7D7D">														
				<option name="" VALUE=""  >検索(選択!)</option>
				<option name="search_cond" VALUE="filename"  >ファイル名</option>
				<option name="search_cond" VALUE="title"  >タイトル</option>				
			</select>
				<input type="TEXT" NAME="search_key" VALUE="" SIZE="20" class="input02">
				<input type="submit" class="cc" onfocus="this.blur();" style=cursor:pointer value="   検索   ">
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="全体リスト" onClick="location.href='<%=urlPage%>rms/admin/sop/listForm.jsp'">		
	</form>
	</div>
	<div class="botton_positiontwo_right">	
		<a href="javascript:openScrollWin('<%=urlPage%>rms/admin/sop/tensuNo_pop.jsp','read','상세보기','745','380','');" onfocus="this.blur()">	
		<img src="<%=urlPage%>rms/image/admin/btn_tesun_no.gif" align="absmiddle"></a>
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="新規登録" onClick="location.href='<%=urlPage%>rms/admin/sop/cateAddForm.jsp'">				
	</div>
</div>
<div id="boxCalendar"  >
<table border="0" cellpadding="0" cellspacing="0" width="100%"  bgcolor="#F7F5EF">				
		<tr >
			<td >						
				<table  border="0" cellpadding="2" cellspacing="2" width="100%"	
				<tr height="22">
					<td align="left" style="padding: 0px 0px 2px 0px;">
				<%if(levelPosition==1){%>
			   		<font color="#807265">※タイトルをクリックすると下にダウンロードされた詳しい内容が見えます。</font>      
			      <%}%>
			      	 <br>
			      	 <font color="#E7281F">※ファイル名をクリックし、パスワードを入力するとダウンロードやファイルの変更ができます。</font>
			      	 <br>
			      	 <font color="#807265">※<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle">はファイルをアップロードした方からのお知らせです。</font>
					</td>
				</tr>											
				</table>							
			</td>
			<td  width="20%" align="right">						
				<img src="<%=urlPage%>rms/image/admin/bg_tab.jpg" align="absmiddle">
			</td>
		</tr>
</table>				

<!--****tab begin *****-->
<div class="clear_margin"></div>
<table width="100%" cellpadding="0" cellspacing="0" border="0">		
<form name="frmtab" > 
	<input type="hidden" name="divPassTab" value="popup_tab1">	
	<input type="hidden" name="divPassTab" value="popup_tab2">	
<tr>
	<td align="left" style="padding:5px 0px 2px 0px;">
<!-- *****************************tab add, del, begin-->						
<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" 新しいタブを書く " OnClick="layerTabWrite('<%=tab_count+1%>');">				
<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" タブを書き直す "  OnClick="layerTabModi('${param.cate_tab}',0);">
<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" タブを削除する "  OnClick="layerTabDel();">			
<!-- *****************************tab add, del, end-->	
	</td>
</tr>
<tr>
	<td >
<div id="content">	
	<div id="tabs5">	
	
	<ul>
<c:if test="${! empty listTab}">
	<%int i=1;	
		Iterator listitertab=listTab.iterator();					
		while (listitertab.hasNext()){
			AccBean tab=(AccBean)listitertab.next();
			int seq=tab.getSeq_tab();														
			if(seq!=0){															
	%>
		
			<li><a href="<%=urlPage%>rms/admin/sop/listForm.jsp?cate_tab=<%=seq%>">
				<span OnClick='premier(<%=i%>);'  id='premier_button<%=i%>' OnMouseOver='this.style.cursor="hand";premier(<%=i%>);' OnMouseOut='this.style.cursor="default"'>
				<%if(seq==seq_tab_int){%><font color="#924949"><b><%}%>
				<%=tab.getName_tab()%>
				<%if(seq==seq_tab_int){%></font></b><%}%>
				</span></a>
			</li>			
		
<%} i++; } %>		
</c:if>	
<c:if test="${empty listTab}">
			<li>No Data</li>
</c:if>													

	</ul>									
			</div>	
			<div class="img_txt_list">
				<div id="tablayer">
	<c:if test="${! empty listTab}">
		<c:forEach var="tab" items="${listTab}" varStatus="idx" >
			<c:if test="${idx.index==0}">	
			<span id='premier${idx.index+1}' style='display:;'>
			</c:if>
			<c:if test="${idx.index!=0}">	
			<span id='premier${idx.index+1}' style='display:none;'>
			</c:if>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr><td  bgcolor="#90B93E" height="2"  colspan="2"><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="1" border="0" ></td></tr>						 
				
				</table>
			</span>	
		</c:forEach>
	</c:if>		
			
				</div>			
			</div>						
	</div>
	
    		
    </td>    
</tr>
</form>
</table>						    											
<!--****tab end *****-->						
<table width="100%"   cellpadding="2" cellspacing="2" >
<form name="frm" > 				
<tr bgcolor=#F1F1F1 align=center height=26>	
    <td   width="8%" class="title_list_all">日付</td>    
    <td  width="8%" class="title_list_m_r">手順書番号</td>							
    <td  width="25%" class="title_list_m_r">タイトル</td>
    <td  width="9%" class="title_list_m_r">登録者</td>
    <td  width="25%" class="title_list_m_r">ファイル名</td>
    <td  width="5%" class="title_list_m_r">展示可否</td>    
    <td  width="5%" class="title_list_m_r">ファイル変更</td>
    <td  width="5%" class="title_list_m_r">修正</td>	
    <td  width="5%" class="title_list_m_r">削除</td>
</tr>
<c:if test="${empty list}">
	<tr>
		<td colspan="9">NO DATA</td>
	</tr>
</c:if>
				
<c:if test="${! empty list}">	
<%
	int i=1;int item_seq=0;			
%>
		
	<%
		Iterator listiter=list.iterator();					
		while (listiter.hasNext()){
			AccBean pdb=(AccBean)listiter.next();
			int seq=pdb.getSeq();														
			if(seq!=0){	
				String aadd=dateFormat.format(pdb.getRegister());	
				int view_yn=pdb.getView_yn();
				List listFileItem=manager.listFileItem(seq);
				int cntFile=manager.countFileItem(seq);																		
	%>
<c:set var="listFileItem" value="<%=listFileItem %>" />
<tr height=20 onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
	<td align="center" class="clear_dot"><%=aadd%></td>
	<td align="left" class="clear_dot"><%=pdb.getCate_nm()%></td>
	<td class="clear_dot" align="left">
	<%if(levelPosition==1){%>	
		<a href="javascript:ShowHidden('itemData_block','<%=i%>');"  onFocus="this.blur()">
		<font color="#CC6600"><%=pdb.getTitle()%></font>
		</a> 		
	<%}else{%>
		<%=pdb.getTitle()%>
	<%}%>
	</td>
	<td class="clear_dot" align="left">
		<input type="hidden" name="divPassMess<%=seq%>" id="divPassMess<%=seq%>"  value="popupCoMess_<%=seq%>">				
		<%=pdb.getName()%>
		<%if(! pdb.getContent().equals("no data")){%>				 
	<!-- *****************************comment레이어 start-->
<div id="popupCoMess_<%=seq%>" style="padding:5px 5px 5px 5px ;border:2px solid #FFCC00;position:absolute; left:50%; top:50%; z-index:999;display:none;filter: alpha(opacity=95);" >
	<table border="0" width="250"   bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=5  >	
	     	<tr>
		     	<td ><img src="<%=urlPage%>orms/images/common/layer_title_comment.gif" align="asbmiddle"></td> 
		     	<td align="right"><a onclick="Layer_popup_OffMess('<%=seq%>');"  style="CURSOR: pointer;"><img src="<%=urlPage%>orms/images/common/layer_news_x.gif" ></a></td> 
		  </tr>        
     </table>		
     <table border="0" width="200" bgcolor="#ffffff" class=c  cellspacing=0 cellpadding=0  >	     	
         <tr>
                 	<td valign="top" valign="middle" style="padding:5 0 5 10;" ><%=pdb.getContent()%>
        			</td>
            </tr>            
     </table>
</div>
<!-- ********************************comment레이어 end -->
	<a onclick="popup_LayerCo(event,'popupCoMess_<%=seq%>');" style="CURSOR: pointer;">	
			 	<img src="<%=urlPage%>rms/image/admin/btn_coment_tegami.gif" align="absmiddle" title="<%=pdb.getContent()%>"></a>			
		<%}%>
	</td>		
		
<c:if test="${empty listFileItem}">	
<%if(pdb.getView_yn()==0){%>	
	<td class="clear_dot" align="left">
		<%if(pdb.getFilename().equals("Data")){%>--
		<%}else{%>			
			<a class="fileline" href="#" onclick="popupSeq('<%=seq%>','<%=seq%>','<%=pdb.getFilename()%>','<%=pdb.getSeq_tab()%>','list','<%=pdb.getCate_nm()%>');"   onfocus="this.blur()"><%=pdb.getFilename()%></a>
		<%}%>
		</td>
	<%}else{%>
		<td class="clear_dot"><img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"></td>
	<%}%>		
	</td>
</c:if>	
<c:if test="${! empty listFileItem}">	
	<%if(pdb.getView_yn()==0){%>	
		<td class="clear_dot" align="left">
			<%if(cntFile==1){%>
				<c:forEach var="item" items="${listFileItem}" varStatus="idx">
				<a class="fileline" href="#" onclick="popupSeq('<%=seq%>','${item.seq}','${item.filename}','<%=pdb.getSeq_tab()%>','list','<%=pdb.getCate_nm()%>');"   onfocus="this.blur()">${item.filename}</a>
				</c:forEach>
			<%}else if(cntFile>1){%>
				<!--<a class="fileline" onclick="goPopupFiles('<%=seq%>','<%=pdb.getSeq_tab()%>','<%=pdb.getCate_nm()%>');" style="CURSOR: pointer;">-->
				<a class="fileline" href="#" onclick="popupSeq('<%=seq%>','<%=seq%>','<%=pdb.getFilename()%>','<%=pdb.getSeq_tab()%>','multi','<%=pdb.getCate_nm()%>');"   onfocus="this.blur()">	
				<font color="#CC6600">(<%=cntFile%>)</font>	個のファイルがあります
				</a> 
			<%}%>
		</td>		
	<%}else{%>
		<td class="clear_dot" align="left"><img src="<%=urlPage%>rms/image/admin/icon_eye.gif" align="absmiddle"></td>
	<%}%>	
</c:if>	
	<td align="center" class="clear_dot">
		<%if(pdb.getView_yn()==0){%>		
			YES
		<%}else{%>
			<font color="#0066FF">NO</font>
		<%}%>
				
	</td>
	<td align="center" class="clear_dot">		
	<c:if test="${empty listFileItem}">		
			<input type="button"  class="cc" onClick="openScrollWin('<%=urlPage%>rms/admin/sop/fileUpload_pop.jsp','read','상세보기','720','290',
			'&seq_list=<%=seq%>&filename=<%=pdb.getFilename()%>&goPg=item');" onfocus="this.blur();" style=cursor:pointer value="変更" >
	</c:if>
	<c:if test="${! empty listFileItem}">
			<%if(cntFile==1){%>
				<c:forEach var="item" items="${listFileItem}" varStatus="idx">
					<input type="button"  class="cc" onClick="openScrollWin('<%=urlPage%>rms/admin/sop/fileUpload_pop.jsp','read','상세보기','720','290',
			'&seq_list=${item.seq}&filename=${item.filename}&goPg=multi');" onfocus="this.blur();" style=cursor:pointer value="変更" >					
				</c:forEach>
			<%}else if(cntFile>1){%>
				--
			<%}%>					
	</c:if>			
	</td>
	<td align="center" class="clear_dot">
		<a href="javascript:goModify(<%=seq%>)"  onfocus="this.blur()">		
		<img src="<%=urlPage%>rms/image/admin/btn_cate_pen.gif"  align="absmiddle"></a>
	</td>	
	<td align="center" class="clear_dot">
	<c:if test="${empty listFileItem}">									
		<a href="javascript:goDelete('<%=seq%>','<%=seq%>','<%=pdb.getFilename()%>','sop_item')"  onfocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>
	</c:if>
	<c:if test="${! empty listFileItem}">
			<%if(cntFile==1){%>
				<c:forEach var="item" items="${listFileItem}" varStatus="idx">
					<a href="javascript:goDelete('<%=seq%>','${item.seq}','${item.filename}','sop_item_multi_list')"  onfocus="this.blur()">
					<img src="<%=urlPage%>rms/image/admin/btn_cate_x.gif" align="absmiddle"></a>									
				</c:forEach>
			<%}else if(cntFile>1){%>
				--
			<%}%>		
	</c:if>		
	</td>		
		
</tr>
<tr>
	<td  style="padding: 5px 5px 5px 5px;" colspan="9" align="center" width="90%">
		<span id="itemData_block<%=i%>" style="DISPLAY:none; xCURSOR:hand;background:#eeeeee;padding:5px 0px 5px 0px;">		
			<table width="60%"  class="tablebox_list"  cellspacing=2 cellpadding=2 bgcolor="#ffffff">				
					<tr><td colspan="4">*ダウンロード履歴</td></tr>
					<tr height="23" bgcolor=#F1F1F1 align=center>	
					    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >日付</td>
					    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >お名前</td>
					    <td class="clear_dot" width="20%"  bgcolor=#F1F1F1 >ID</td>
					    <td  class="clear_dot" width="40%"  bgcolor=#F1F1F1 >ipのアドレース</td>							    
					</tr>
					<tr>					
						<%int i2=1;%>
						<% listDown=manager2.selectDownDtail(seq); %>
						<c:set var="listDown" value="<%= listDown %>" />	
						<%Iterator listiter2=listDown.iterator();					
										while (listiter2.hasNext()){
											AccBean pdb2=(AccBean)listiter2.next();
											int seq2=pdb2.getSeq();											
											if(seq2!=0){	
												String aadd2=dateFormat.format(pdb2.getRegister());														
						%>
													<tr>													
														<td class="clear_dot"><%=aadd2%></td>
														<td class="clear_dot"><%=pdb2.getName()%></td>
														<td class="clear_dot"><%=pdb2.getTitle()%></td>
														<td class="clear_dot"><%=pdb2.getIp_add()%></td>
													</tr>
						<%}else{%>
													<tr>													
														<td style="padding: 2 5 2 5" colspan="4">NO DATA</td>
														
													</tr>
						<%}
						i2++;	
						}
						%>			
													
								
			</table>
		</span>
	</td>
</tr>
<%}
i++;	
}
%>		
</c:if>
</table><p>
</form>	
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
<p><p>
<!-- 팝업 start-->				
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->
<form name="move" method="post">
	<input type="hidden" name="goPg">						 
    <input type="hidden" name="stayPg">						
    <input type="hidden" name="cate_tab" >	
    <input type="hidden" name="kubun" >						
    <input type="hidden" name="seq_tab"  >
    <input type="hidden" name="name_tab">
    <input type="hidden" name="junbang">						
    <input type="hidden" name="seq" value="">    
    <input type="hidden" name="seq_list" value="">    
    <input type="hidden" name="seq_item" value="">    
    <input type="hidden" name="filename" value="">     
    <input type="hidden" name="pass" value="">     
    <input type="hidden" name="page" value="${currentPage}">
    <c:if test="<%= searchCondFilename %>">
    <input type="hidden" name="search_cond" value="filename">
    </c:if>
    <c:if test="<%= searchCondTitle %>">
    <input type="hidden" name="search_cond" value="title">
    </c:if>	
    <c:if test="${! empty param.search_key}">
    <input type="hidden" name="search_key" value="${param.search_key}">
    </c:if>
</form>										
		
<script language="JavaScript">
function goPage(pageNo) {    
    	document.move.page.value = pageNo;
	document.move.action = "<%=urlPage%>rms/admin/sop/listForm.jsp?cate_tab=<%=cate_tab%>";
    	document.move.submit();
}
function goDelete(seq_list,seq_item,filename,kubun) {
	document.move.action = "<%=urlPage%>rms/admin/sop/delForm.jsp";
	document.move.seq_list.value=seq_list;	
	document.move.seq_item.value=seq_item;	
	document.move.kubun.value=kubun;	
	document.move.filename.value = filename;
    	document.move.submit();
}
function goModify(seq) {	
    	document.move.action = "<%=urlPage%>rms/admin/sop/modifyForm.jsp";
	document.move.seq.value=seq;	
    	document.move.submit();
}

function popupSeq(seq_list,seq_item,filename,seq_tab,goPg,cate_nm){		
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sop/popup_downView.jsp?&seq_list="+seq_list+"&seq_item="+seq_item+"&filename="+filename+"&goPg="+goPg+"&seq_tab="+seq_tab+"&cate_nm="+cate_nm; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
function goPopupFiles(seq,seq_tab,cate_nm){	
	var param="&seq="+seq+"&seq_tab="+seq_tab+"&cate_nm="+cate_nm;
	openScrollWin("popFile.jsp", "files", "files", "400", "500",param);
}

function layerTabWrite(tab_count){		
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sop/layerTabWrite.jsp?&tab_count="+tab_count; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
function layerTabModi(seq_tab){		
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sop/layerTabModi.jsp?&seq_tab="+seq_tab+"&stayPg=0"; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
function layerTabDel(){		
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/sop/layerTabDel.jsp?stayPg=1"; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}

/*
function goDown(seq,filename,seq_tab) {	
//	var passValue= document.getElementById("passVal_"+seq).value;  		
	document.move.action = "<%=urlPage%>rms/admin/sop/down.jsp";
	document.move.seq.value = seq;
//	document.move.pass.value = passValue; 
	document.move.filename.value = filename;	
	document.move.seq_tab.value = seq_tab; 	
	document.move.goPg.value = "list"; 	
	document.move.submit();
	Layer_popup_Off();
}
function goDownFile(seq,filename,seq_tab,file_seq) {	
	var passValue= document.getElementById("passVal_"+file_seq).value;  			
	document.move.action = "<%=urlPage%>rms/admin/sop/down.jsp";
	document.move.seq.value = seq;
	document.move.pass.value = passValue; 
	document.move.filename.value = filename;	
	document.move.seq_tab.value = seq_tab; 	
	document.move.submit();
	Layer_popup_Off();
}

function goTab() {	
	var nameValue=document.getElementById("name_tabVal").value;     
	var junbangValue=document.getElementById("junbangVal").value;       	
	if(isEmpty(document.frmtab.name_tabVal, "タブ名を入力して下さい。!")) return;
	
	document.move.action = "<%=urlPage%>rms/admin/sop/tabAdd.jsp";	
	document.move.name_tab.value = nameValue; 
	document.move.junbang.value = junbangValue; 
	document.move.submit();
	Layer_popup_Off_tab();
}
function goTabDel() {	
	var seqValue=document.frmtab.seq_tab.options[document.frmtab.seq_tab.selectedIndex].value;   
	if(isEmpty(document.frmtab.seq_tab, "タブを選択して下さい。!")) return;
	if(confirm("本当に削除しますか？")!=1){return;}
	document.move.action = "<%=urlPage%>rms/admin/sop/tabDel.jsp";	
	document.move.seq_tab.value = seqValue; 	
	document.move.stayPg.value="1";
	document.move.submit();
	Layer_popup_Off_tab();
}
*/
</script>








