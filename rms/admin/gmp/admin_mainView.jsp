<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>	
<%@ page import = "java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.kintai.DataBeanKintai" %>
<%@ page import = "mira.kintai.DataMgrKintai" %>
<%@ page import = "mira.jangyo.DataBeanJangyo" %>
<%@ page import = "mira.jangyo.DataMgrJangyo" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripKesaisho" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>	
<%@ page import = "mira.notice.NewsBean " %>
<%@ page import = "mira.notice.NewsManager" %>
<%@ page import = "mira.board.Board" %>
<%@ page import = "mira.board.BoardManager" %>
<%@ page import = "mira.gmp.GmpBeen" %>
<%@ page import = "mira.gmp.GmpManager" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ page import = "mira.shokudata.FileMgr" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "mira.payment.FileMgrSeikyu" %>
<%@ page import = "mira.payment.Category" %>
<%! 
static int PAGE_SIZE=50; 
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMddHH:mmss");
%>
<%	

String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
String urlPage=request.getContextPath()+"/";
String today=formatter.format(new java.util.Date());

int mseq=0;String usernm="";
	MemberManager manager = MemberManager.getInstance();	
	Member member=manager.getMember(id);
	if(member!=null){		 
		 mseq=member.getMseq();
		 usernm=member.getNm(); 
	}	
//------page권한-------------------------------   
int pageArrow=0; int pageArrowCon=0;
if(id.equals("juc0318") || id.equals("admin")){ pageArrow=1;	}else{pageArrow=2;}	
if(id.equals("juc0318") || id.equals("admin") || id.equals("hamano") || id.equals("funakubo") || id.equals("kubota") || id.equals("kira") || id.equals("saito") || id.equals("sugita"))  { 
pageArrowCon=1;	}else{pageArrowCon=2;}

int nointit=0;
if(id.equals("candy") || id.equals("ohtagaki") || id.equals("kishi") || id.equals("togashi")){ nointit=1;	}else{nointit=2;}
FileMgr manaPg=FileMgr.getInstance();
int countPg=0; int viewPg=0;
if(pageArrow==2){	countPg=manaPg.kindCnt(mseq);}

int nmView=0; 
if( id.equals("juc0318") || id.equals("admin")|| id.equals("hamano") || id.equals("funakubo") || id.equals("lin") || id.equals("biofloc")
	|| id.equals("tachi") || id.equals("akikino") || id.equals("togashi") || id.equals("hazama") || id.equals("kubota") || id.equals("kira") || id.equals("saito") || id.equals("sugita"))
{ nmView=1;	}else{nmView=2;}	
	
//GMP
int GmpModi=0; 
if(id.equals("juc0318") || id.equals("admin") || id.equals("ueno") || id.equals("takeda") || id.equals("shiba")){ GmpModi=1;}else{GmpModi=2;}
//------page권한 end----------------------------
	
	DataMgrKintai mgrKintai = DataMgrKintai.getInstance();
	DataMgrJangyo mgrJangyo = DataMgrJangyo.getInstance();
	NewsManager mgrNotice=NewsManager.getInstance();
	BoardManager mgrBoard=BoardManager.getInstance();
	GmpManager mgrGmp=GmpManager.getInstance();
	MgrOrderBunsho mgrOrder=MgrOrderBunsho.getInstance();
	ContractMgr mgrContract=ContractMgr.getInstance();
	
	DataMgr mgrSch =DataMgr.getInstance();
	DataMgrTripKesaisho mgrKesaiHokoku = DataMgrTripKesaisho.getInstance();
	DataMgrTripHokoku mgrTripHokoku=DataMgrTripHokoku.getInstance();
	DataMgrHoliHokoku mgrHoliHokoku=DataMgrHoliHokoku.getInstance();
	FileMgrSeikyu mgrSeikyu=FileMgrSeikyu.getInstance();
		
	int cntMem=mgrKintai.listMemAllCnt();
	int cntBun=mgrKintai.listBunAllCnt();
	int cntSop=mgrKintai.listSopCnt();	
	int cntKintai=mgrKintai.listSignNewCnt(mseq,1);
	int cntKintai_back=mgrKintai.listSignNewCnt(mseq,3);	
	int cntJangyo=mgrKintai.listSignNewCntJangyo(mseq,1);
	int cntJangyo_back=mgrKintai.listSignNewCntJangyo(mseq,3);	
	int cntSchedule=mgrKintai.listScheduleCnt(mseq,1);
	int cntSchedule_back=mgrKintai.listScheduleCnt(mseq,1);		
	int cntHokoku=mgrKesaiHokoku.listSignNewCnt(mseq,1);	
	int cntHokoku_back=mgrKesaiHokoku.listSignNewCnt(mseq,3);	
	
	int cntTripHokoku=mgrTripHokoku.listSignNewCnt(mseq,1);	
	int cntTripHokoku_back=mgrTripHokoku.listSignNewCnt(mseq,3);	
	
	int cntHoliHokoku=mgrHoliHokoku.listSignNewCnt(mseq,1);	
	int cntHoliHokoku_back=mgrHoliHokoku.listSignNewCnt(mseq,3);
	
	int cntHoliCon=mgrHoliHokoku.listSignNewCntCon(mseq,1);	
	int cntHoliCon_back=mgrHoliHokoku.listSignNewCntCon(mseq,3);
	
//notice		
	List  list=mgrNotice.selectListMain(null, null,0,5);			
	List  listBor=mgrBoard.selectListMain(null, null,0,5,1);	
	List  listSeizoBor=mgrBoard.selectListMain(null, null,0,5,2);
	List  listOtBor=mgrBoard.selectListMain(null, null,0,5,3);		
	
//결재사항 / 출퇴근	
	List listSignKintai=mgrKintai.listSignOk_or_No(id); //미결재,반환출력
//결재사항 / 잔업	
	List listSignJangyo=mgrJangyo.listSignOk_or_No(id); //미결재,반환출력
//결재사항 / 스케줄	
	List listSignSchedule=mgrSch.listSignOk_or_No(id); //미결재,반환출력
	
//결재사항 보고서, 
  //출장결재서	
	DataBeanHokoku beanSignHokokuBoss=mgrKesaiHokoku.getSignYnBoss(id); //사장==미결재,반환출력
	DataBeanHokoku beanSignHokokuBucho=mgrKesaiHokoku.getSignYnBucho(id); //부장==미결재,반환출력
  //출장보고서	
	DataBeanHokoku beanSignTripBoss=mgrTripHokoku.getSignYnBoss(id); //사장==미결재,반환출력
	DataBeanHokoku beanSignTripBucho=mgrTripHokoku.getSignYnBucho(id); //부장==미결재,반환출력
 //휴일근무신청	
	DataBeanHokoku beanSignHoliBoss=mgrHoliHokoku.getSignYnAll(id,1); //사장==미결재,반환출력
	DataBeanHokoku beanSignHoliBucho=mgrHoliHokoku.getSignYnAll(id,2); //부장==미결재,반환출력
	DataBeanHokoku beanSignHoliBucho2=mgrHoliHokoku.getSignYnAll(id,3); //부장==미결재,반환출력
	DataBeanHokoku beanSignHoliKanribu=mgrHoliHokoku.getSignYnAll(id,4); //부장==미결재,반환출력
//휴일출근 보고서	
	DataBeanHokoku beanSignHoliConBoss=mgrHoliHokoku.getSignYnAllCon(id,1); //사장==미결재,반환출력
	DataBeanHokoku beanSignHoliConBucho=mgrHoliHokoku.getSignYnAllCon(id,2); //부장==미결재,반환출력
	DataBeanHokoku beanSignHoliConBucho2=mgrHoliHokoku.getSignYnAllCon(id,3); //부장==미결재,반환출력
	DataBeanHokoku beanSignHoliConKanribu=mgrHoliHokoku.getSignYnAllCon(id,4); //부장==미결재,반환출력	
//사내 용품 발주 의뢰서	
	BeanOrderBunsho beanOrder=mgrOrder.getSignYnOrder(id,1); //구매 담당자
	BeanOrderBunsho beanOrder01=mgrOrder.getSignYnOrder(id,2); //부장
	BeanOrderBunsho beanOrder02=mgrOrder.getSignYnOrder(id,3); //주문자	
	//최종 물품확인
	List listOrderFinal =mgrOrder.listFinalConfirm(id); //주문자			
	
	
//GMP
DecimalFormat df = new DecimalFormat("00");

Calendar calEnd = Calendar.getInstance();       	   								
    calEnd.add(calEnd.DATE, +45);
    String strYearEnd   = Integer.toString(calEnd.get(Calendar.YEAR));
    String strMonthEnd  = df.format(calEnd.get(Calendar.MONTH) + 1);
    String strDayEnd   = df.format(calEnd.get(Calendar.DATE));
    String strDateEnd = strYearEnd+"-"+strMonthEnd+"-"+strDayEnd;	
   
Calendar calEndBeforeYear = Calendar.getInstance();       	   								
    calEndBeforeYear.add(calEndBeforeYear.YEAR, -1);
    String strYYBefore   = Integer.toString(calEndBeforeYear.get(Calendar.YEAR));
    String strMMBefore  = df.format(calEndBeforeYear.get(Calendar.MONTH) + 1);
    String strDDBefore   = df.format(calEndBeforeYear.get(Calendar.DATE));
    String strDateBefore = strYYBefore+"-"+strMMBefore+"-"+strDDBefore;	

Calendar calNew = Calendar.getInstance();       	   								
    calNew.add(calNew.DATE, -14);
    String strYearSe   = Integer.toString(calNew.get(Calendar.YEAR));
    String strMonthSe  = df.format(calNew.get(Calendar.MONTH) + 1);
    String strDaySe   = df.format(calNew.get(Calendar.DATE));
    String strDateSe = strYearSe+"-"+strMonthSe+"-"+strDaySe;									
									
	List  listGmp=mgrGmp.listDate01(today,strDateEnd);  //1차실시 alert기능
	List  listGmp2=mgrGmp.listDate02(today,strDateEnd); //2차실시 alert기능
	List  listGmp3=mgrGmp.listDatePast01(strDateBefore,today); //  1차실시일이 지나버린 데이터 출력
	List  listGmp4=mgrGmp.listDatePast02(strDateBefore,today); //  2차실시일이 지나버린 데이터 출력	
	//사용불가출력	
	int countCmpNo = mgrGmp.count(null, null);	
	List  listGmpNo=mgrGmp.selectList(null, null,0,countCmpNo);

	List  listContract=mgrContract.listDate_end(today,strDateEnd); // 계약서 리스트 데이터 출력
	List  listSeikyu=mgrSeikyu.listMain(); // 청구서 리스트 데이터 출력
	
/*-----------------------------------(상사로부터 반환)------------------------------*/
//출퇴근	
	List listKintaiReturn=mgrKintai.listSignOkReturn(id); 
//잔업	
	List listJangyoReturn=mgrJangyo.listSignOkReturn(id); //미결재,반환출력
//사내 용품 발주 의뢰서
	List listOrderReturn02=mgrOrder.listSignYnOrderReturn(id,2); 
	List listOrderReturn03=mgrOrder.listSignYnOrderReturn(id,3); 	
//출장결재서		
	List listKesaiReturn01=mgrKesaiHokoku.listKesaiReturn(id,1); //부장(사장으로부터의 반환)
	List listKesaiReturn02=mgrKesaiHokoku.listKesaiReturn(id,2); //담당자(부장으로부터의 반환)
 //출장보고서		
	List listTripReturn01=mgrTripHokoku.listTripReturn(id,1); //부장(사장으로부터의 반환)
	List listTripReturn02=mgrTripHokoku.listTripReturn(id,2); //담당자(부장으로부터의 반환)
//휴일근무신청	
	List listHoSinReturn01=mgrHoliHokoku.listHoReturn(id,1); 
	List listHoSinReturn02=mgrHoliHokoku.listHoReturn(id,2) ;
	List listHoSinReturn03=mgrHoliHokoku.listHoReturn(id,3); 
	List listHoSinReturn04=mgrHoliHokoku.listHoReturn(id,4); //담당자(상사로부터의 반환) listHoHokoReturn
//휴일근무보고	
	List listHoHokoReturn01=mgrHoliHokoku.listHoconReturn(id,1) ;
	List listHoHokoReturn02=mgrHoliHokoku.listHoconReturn(id,2); 
	List listHoHokoReturn03=mgrHoliHokoku.listHoconReturn(id,3); 
	List listHoHokoReturn04=mgrHoliHokoku.listHoconReturn(id,4) ;//담당자(상사로부터의 반환) 
	

%>
<c:set var="listJangyoReturn" value="<%= listJangyoReturn %>" />
<c:set var="listKintaiReturn" value="<%= listKintaiReturn %>" />	
<c:set var="listOrderReturn02" value="<%= listOrderReturn02 %>" />	
<c:set var="listOrderReturn03" value="<%= listOrderReturn03 %>" />	
<c:set var="listKesaiReturn01" value="<%= listKesaiReturn01 %>" />
<c:set var="listKesaiReturn02" value="<%= listKesaiReturn02 %>" />
<c:set var="listTripReturn01" value="<%= listTripReturn01 %>" />
<c:set var="listTripReturn02" value="<%= listTripReturn02 %>" />	
<c:set var="listHoSinReturn01" value="<%= listHoSinReturn01 %>" />
<c:set var="listHoSinReturn02" value="<%= listHoSinReturn02 %>" />
<c:set var="listHoSinReturn03" value="<%= listHoSinReturn03 %>" />
<c:set var="listHoSinReturn04" value="<%= listHoSinReturn04 %>" />
<c:set var="listHoHokoReturn01" value="<%= listHoHokoReturn01 %>" />
<c:set var="listHoHokoReturn02" value="<%= listHoHokoReturn02 %>" />
<c:set var="listHoHokoReturn03" value="<%= listHoHokoReturn03 %>" />
<c:set var="listHoHokoReturn04" value="<%= listHoHokoReturn04 %>" />	
<c:set var="listContract" value="<%= listContract %>" />													
<c:set var="listGmp" value="<%= listGmp %>" />	
<c:set var="listGmp2" value="<%= listGmp2 %>" />	
<c:set var="listGmp3" value="<%= listGmp3 %>" />	
<c:set var="listGmp4" value="<%= listGmp4 %>" />	
<c:set var="listGmpNo" value="<%= listGmpNo %>" />
<c:set var="listSeikyu" value="<%= listSeikyu %>" />		
<c:set var="list" value="<%= list %>" />
<c:set var="listBor" value="<%= listBor %>" />
<c:set var="listSeizoBor" value="<%= listSeizoBor %>" />
<c:set var="listOtBor" value="<%= listOtBor %>" />
<c:set var="listSignKintai" value="<%= listSignKintai %>" />
<c:set var="listSignJangyo" value="<%= listSignJangyo %>" />
<c:set var="listSignSchedule" value="<%= listSignSchedule %>" />
<c:set var="beanSignHokokuBoss" value="<%= beanSignHokokuBoss %>" />
<c:set var="beanSignHokokuBucho" value="<%= beanSignHokokuBucho %>" />
<c:set var="beanSignTripBoss" value="<%= beanSignTripBoss %>" />
<c:set var="beanSignTripBucho" value="<%= beanSignTripBucho %>" />
<c:set var="beanSignHoliBoss" value="<%= beanSignHoliBoss %>" />
<c:set var="beanSignHoliBucho" value="<%= beanSignHoliBucho %>" />
<c:set var="beanSignHoliBucho2" value="<%= beanSignHoliBucho2 %>" />
<c:set var="beanSignHoliKanribu" value="<%= beanSignHoliKanribu %>" />	
<c:set var="beanSignHoliConBoss" value="<%= beanSignHoliConBoss %>" />
<c:set var="beanSignHoliConBucho" value="<%= beanSignHoliConBucho %>" />
<c:set var="beanSignHoliConBucho2" value="<%= beanSignHoliConBucho2 %>" />
<c:set var="beanSignHoliConKanribu" value="<%= beanSignHoliConKanribu %>" />
<c:set var="beanOrder" value="<%= beanOrder %>" />
<c:set var="beanOrder01" value="<%= beanOrder01 %>" />
<c:set var="beanOrder02" value="<%= beanOrder02 %>" />	
<c:set var="listOrderFinal" value="<%= listOrderFinal %>" />
	
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

function goPre(){
	alert("準備中です。");
}
</script>
	
<div id="overlay"></div>	
<%if(!id.equals("candy")){%>
<div id="conten_top"  onmousedown="dropMenu()"> 
	<img src="<%=urlPage%>rms/image/admin/main/admin_main_menu03.gif" align="absmiddle" border="0" usemap="#main">
	<map name="main">
		<area shape="rect" coords="12,5,113,35" href="<%=urlPage%>rms/admin/sop/listForm.jsp" onfocus="this.blur()"  alt="標準作業手順書" title="標準作業手順書">
		<area shape="rect" coords="136,8,244,34" href="<%=urlPage%>rms/admin/gmp/listForm.jsp" onfocus="this.blur()" alt="校正対象設備等一覧 " title="校正対象設備等一覧 ">
<%if(pageArrow==1 || countPg !=0){%><area shape="rect" coords="263,8,373,37" href="<%=urlPage%>rms/admin/shokuData/mainForm.jsp" onfocus="this.blur()" alt="開発会議/QMS" title="開発会議/QMS"><%}%>	
		<area shape="rect" coords="417,9,526,35" href="<%=urlPage%>rms/admin/order/listForm.jsp" onfocus="this.blur()" alt="社内用品申請" title="社内用品申請">
		<area shape="rect" coords="543,8,655,38" href="<%=urlPage%>rms/admin/form/listForm.jsp" onfocus="this.blur()" alt="各種文書フォーム" title="各種文書フォーム">			
		<area shape="rect" coords="701,9,802,33"   href="<%=urlPage%>rms/admin/kintai/listForm.jsp" onfocus="this.blur()" alt="出勤管理" title="出勤管理">
		<area shape="rect" coords="830,10,933,35" href="<%=urlPage%>rms/admin/jangyo/listForm.jsp" onfocus="this.blur()" alt="残業申請" title="残業申請">			
		<area shape="rect" coords="8,55,116,84" href="<%=urlPage%>rms/admin/seizo/listForm.jsp"  onfocus="this.blur()" alt="製造記録書QA" title="製造記録書QA">
		<area shape="rect" coords="138,57,244,85" href="<%=urlPage%>rms/admin/hinsithu/listForm.jsp"  onfocus="this.blur()" alt="品質試験書QA" title="品質試験書QA">

	<%if(id.equals("akikino") || id.equals("biofloc") || id.equals("juc0318") || id.equals("admin")){%>
			<area shape="rect" coords="266,57,367,82" href="<%=urlPage%>rms/admin/bunsho/listForm.jsp" onfocus="this.blur()" alt="CHONDRON文書" title="CHONDRON文書">
	<%}else{%>
			<area shape="rect" coords="266,57,367,82" href="#"  onclick="goPre();" onfocus="this.blur()" alt="CHONDRON文書" title="CHONDRON文書">
	<%}%>			
		<area shape="rect" coords="417,55,527,83" href="<%=urlPage%>rms/admin/approval/listForm.jsp"  onfocus="this.blur()" alt="決裁書リスト管理" title="決裁書リスト管理">
			
<%if(pageArrowCon==1){%>			
		<area shape="rect" coords="546,56,644,82"  href="<%=urlPage%>rms/admin/contract/listForm.jsp"  onfocus="this.blur()" alt="契約書リスト管理"  title="契約書リスト管理">
<%}else{%>
		<area shape="rect" coords="546,56,644,82"  href="#"  onclick="goPre();"  onfocus="this.blur()" alt="契約書リスト管理"  title="契約書リスト管理">	
<%}%>
		<area shape="rect" coords="700,55,808,83" href="<%=urlPage%>rms/admin/kintai/listFormAll.jsp" onfocus="this.blur()" alt="部署出勤リスト" title="部署出勤リスト">
		<area shape="rect" coords="831,57,933,81" href="<%=urlPage%>rms/admin/jangyo/listFormAll.jsp" onfocus="this.blur()" alt="部署残業リスト" title="部署残業リスト">		
		<area shape="rect" coords="417,9,526,35" href="<%=urlPage%>rms/admin/order/listForm.jsp" onfocus="this.blur()" alt="社内用品申請" title="社内用品申請">
		<area shape="rect" coords="543,8,655,38" href="<%=urlPage%>rms/admin/form/listForm.jsp" onfocus="this.blur()" alt="各種文書フォーム" title="各種文書フォーム">			
		<area shape="rect" coords="701,9,802,33"   href="<%=urlPage%>rms/admin/kintai/listForm.jsp" onfocus="this.blur()" alt="出勤管理" title="出勤管理">
		<area shape="rect" coords="830,10,933,35" href="<%=urlPage%>rms/admin/jangyo/listForm.jsp" onfocus="this.blur()" alt="残業申請" title="残業申請">				

	</map>
</div>
<%}%>		
<div id="conten_middle" >
	<div class="conten_middle01">
<%if(!id.equals("candy")){%>
		<div class="conten_middle01_left">
<!--제조/품질 게시판 begin*************************** -->				
		<a href="<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=2" onFocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/main/qtboardTitle.gif" align="absmiddle" ></a>
	<div class="boxTable_eee">		
		<table width="100%"  cellpadding="3" cellspacing="3">
			<tbody>																							
		<c:if test="${empty listSeizoBor}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td>登録された内容がありません。</td></tr>
			</c:if>
			<c:if test="${! empty listSeizoBor}">			
			<%
			int i=1;
			Iterator listiter=listSeizoBor.iterator();
				while (listiter.hasNext()){				
					Board board=(Board)listiter.next();
					int bseq=board.getBseq();
					int levelBor=board.getLevel();
					if(levelBor==1){			
			%>
		<c:set var="title" value="<%=board.getTitle()%>"/>					
					<tr height="20">											
						<td >
							<img src="<%=urlPage%>rms/image/icon_s.gif" >
							<span class="small_day"><%=formatter.format(board.getRegister())%></span>													
							<span class="toggle">
								<a class="topnav" href="#" style="cursor:pointer;" onfocus="this.blur()">				
									<c:if test="${fn:length(title)>=15}"> ${fn:substring(title, 0, 15)}</c:if>
									<c:if test="${fn:length(title)<15}"> ${title}</c:if>	
									<%if(formatter.format(board.getRegister()).equals(today)){%><img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="asbmiddle"> <font color="007AC3">new!!</font><%}%>	
								</a>
							</span>											
							<div id="hiddenDiv">
										
								<div class="innerDivSlice_admin_main" >
									<div class="hiddenBox_admin_main" >
										<%=board.getContent()%>
									</div>
								</div>
							</div>
						</td>
					</tr>			
			<%}i++;}%>	
		</c:if>														
			</tbody>							
		</table>	
	</div>					
<!--제조/품질 게시판  end*************************** -->
<div class="clear"></div>
<!--OT – ORMS 連絡事項 begin*************************** -->															
	<a href="<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=3" onFocus="this.blur()">
	<img src="<%=urlPage%>rms/image/admin/main/otTitle.jpg" align="absmiddle" ></a>
	<div class="boxTable_eee">		
		<table width="100%"  cellpadding="3" cellspacing="3">
			<tbody>																							
			<c:if test="${empty listOtBor}">
			<tr><td>登録された内容がありません。</td></tr>
			</c:if>
			<c:if test="${! empty listOtBor}">			
			<%
			int i=1;
			Iterator listiter=listOtBor.iterator();
				while (listiter.hasNext()){				
					Board board=(Board)listiter.next();
					int bseq=board.getBseq();
					int levelBor=board.getLevel();
					if(levelBor==1){			
			%>
		<c:set var="title" value="<%=board.getTitle()%>"/>						
					<tr height="20">											
						<td >
							<img src="<%=urlPage%>rms/image/icon_s.gif" >
							<span class="small_day"><%=formatter.format(board.getRegister())%></span>													
							<span class="toggle">
								<a class="topnav" href="#" style="cursor:pointer;" onfocus="this.blur()">
									<c:if test="${fn:length(title)>=15}"> ${fn:substring(title, 0, 15)}</c:if>
									<c:if test="${fn:length(title)<15}"> ${title}</c:if>	
									<%if(formatter.format(board.getRegister()).equals(today)){%><img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="asbmiddle"> <font color="007AC3">new!!</font><%}%>	
								</a>
							</span>										
							<div id="hiddenDiv">
									
								<div class="innerDivSlice_admin_main" >
									<div class="hiddenBox_admin_main" >
										<%=board.getContent()%>
									</div>
								</div>
							</div>
						</td>
					</tr>			
			<%}i++;}%>	
		</c:if>																		
			</tbody>							
		</table>	
	</div>
																
<!--OT – ORMS 連絡事項  end*************************** -->
		</div>
<%}%>	
		<div class="conten_middle01_right">	
<!--****schedule start***********************************-->								
		<a class="topnav" href="<%=urlPage%>rms/admin/schedule/monthForm.jsp" onfocus="this.blur();">
		<img src="<%=urlPage%>rms/image/admin/main/todatSchedule.gif" align="absmiddle" ></a>
<div class="boxTable_schedule">				
		<table width="100%"  cellpadding="0" cellspacing="2">
			<thead>	
				<tr height="22" align="center">
					<td  width="17%" class="listBarTitle">お名前</td>				
					<td  width="30%"  class="listBarTitle">内 容</td>
					<td  width="19%"  class="listBarTitle">同行者</td>
					<td  width="17%" class="listBarTitle">開始日</td>
					<td  width="17%"  class="listBarTitle">終了日</td>
				</tr>
			</thead>				
			<tbody width="100%" >																
									
<%List listSch=mgrSch.listSchedule(today);%>
<c:set var="listSch" value="<%= listSch %>" />									
<c:if test="${empty listSch}">
			<tr><td colspan="5" >登録された内容がありません。</td></tr>
</c:if>
<c:if test="${! empty listSch}">
	<%
	int i=1;
		Iterator listiter=listSch.iterator();					
				while (listiter.hasNext()){
					DataBean dbbean=(DataBean)listiter.next();
					int seq=dbbean.getSeq();
					List listFellow=mgrSch.listFel_Name(seq);					
					if(seq !=0){	
	%>
	<c:set var="listFellow" value="<%= listFellow %>" />       
				<tr  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">										
				<td class="clear_dot"><font color="#007AC3"><%=dbbean.getNm()%></font> </td>
				<td class="clear_dot">
<a class="topnav" href="<%=urlPage%>rms/admin/schedule/monthForm.jsp?month=<%=dbbean.getDuring_begin().substring(5,7)%>&year=<%=dbbean.getDuring_begin().substring(0,4)%>&action=0" onfocus="this.blur();">
							<%=dbbean.getTitle()%></a>
				</td>
				<td class="clear_dot" >
	<c:if test="${empty listFellow}">--</c:if>
	<c:if test="${! empty listSch}">
		<font color="#999900"><%int ifel=1;Iterator listiterFel=listFellow.iterator();while (listiterFel.hasNext()){DataBean dbb=(DataBean)listiterFel.next();
int mseqint=dbb.getSeq();if(mseqint!=0){%><%if(ifel !=1){%>/<%}%><a href="mailto:${dbb.mail_address}?subject=Hello!!" title="<%=dbb.getNm()%>様にメールを送る"><%=dbb.getNm().substring(0,1)%></a><%}ifel++;}%></font>
	</c:if>						
				</td>
				<td class="clear_dot"><font color="#CC6600"><%=dbbean.getDuring_begin().substring(2,10)%></font></td>
				<td class="clear_dot"><font color="#CC6600"><%=dbbean.getDuring_end().substring(2,10)%></font></td>				
				</tr>											
<%}i++;}%>		
</c:if>
			</tbody>						
		</table>
	</div>	
<!--****schedule end***********************************-->	
<div class="clear"></div>
<!--****sign start***********************************-->	
		<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">
		<img src="<%=urlPage%>rms/image/admin/main/ketsai.gif" align="absmiddle" ></a>							
		<c:if test="${!empty listSignKintai || !empty listSignJangyo || !empty listSignSchedule  || !empty beanSignHokokuBoss || 
			!empty beanSignHokokuBucho || !empty beanSignTripBoss || !empty beanSignTripBucho ||
			!empty beanSignHoliBucho2 || !empty beanSignHoliKanribu || !empty beanSignHoliConBoss || 
			!empty beanSignHoliConBucho || !empty beanSignHoliConBucho2 || !empty beanSignHoliConKanribu || 
			!empty beanOrder  || !empty beanOrder01 || !empty beanOrder02 || 			
			!empty listJangyoReturn || !empty listKintaiReturn || !empty listOrderReturn02 || !empty listOrderReturn03 || !empty listKesaiReturn01 || !empty listKesaiReturn02 ||
			!empty listTripReturn01 || !empty listTripReturn02 || !empty listHoSinReturn01 || !empty listHoSinReturn02 || !empty listHoSinReturn03 || !empty listHoSinReturn04 || 
			!empty listHoHokoReturn01 || !empty listHoHokoReturn02 || !empty listHoHokoReturn03 || !empty listHoHokoReturn04 || !empty listOrderFinal }">
				<span class="blue"><img src="<%=urlPage%>rms/image/admin/icon_adminMain.gif" align="absmiddle" >皆さんが承認者の決裁を待っております。</span>
		</c:if>				
											
		<div class="boxTable">								
		<table width="100%"  cellpadding="0" cellspacing="2">
			<thead>	
				<tr height="22" align="center">
					<td  width="45%" class="listBarTitle">区分</td>
					<td  width="25%" class="listBarTitle">承認者/担当者</td>				
					<td  width="30%" class="listBarTitle">未決/差戻し/削除</td>
				</tr>
			</thead>				
			<tbody width="100%" >						
			<c:if test="${empty listSignKintai && empty listSignJangyo && empty listSignSchedule  && empty beanSignHokokuBoss && 
			empty beanSignHokokuBucho && empty beanSignTripBoss && empty beanSignTripBucho &&
			empty beanSignHoliBucho2 && empty beanSignHoliKanribu && empty beanSignHoliConBoss && 
			empty beanSignHoliConBucho && empty beanSignHoliConBucho2 && empty beanSignHoliConKanribu && 
			empty beanOrder  && empty beanOrder01 && empty beanOrder02 &&
			empty listJangyoReturn && empty listKintaiReturn && empty listOrderReturn02 && empty listOrderReturn03 && empty listKesaiReturn01 && empty listKesaiReturn02 &&
			empty listTripReturn01 && empty listTripReturn02 && empty listHoSinReturn01 && empty listHoSinReturn02 && empty listHoSinReturn03 && empty listHoSinReturn04 && 
			empty listHoHokoReturn01 && empty listHoHokoReturn02 && empty listHoHokoReturn03 && empty listHoHokoReturn04 && empty listOrderFinal }">
							<tr><td style="padding: 0 0 0 10;"  colspan="3">---</td>	</tr>							
			</c:if>						
					</tr>					
															
					<!----***********잔업 시작***********---------->									
										<c:if test="${! empty listSignJangyo}">
											<c:forEach var="news" items="${listSignJangyo}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#339900">残業申請</font>
												<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${news.nm}</a></td>												
												<td align="center"><font color="red">${news.seqcnt}</font></td>		
											</tr>																	
											</c:forEach>
									</c:if>											
									</tr>
					<!----***********출퇴근 시작***********---------->									
										<c:if test="${! empty listSignKintai}">
											<c:forEach var="news" items="${listSignKintai}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#007ac3">出退勤</font>
												<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${news.nm}</a></a></td>												
												<td align="center" ><font color="red">${news.simya_hh}</font></td>		
											</tr>																	
											</c:forEach>
									</c:if>
												
					<!----***********사내 용품 발주 의뢰서***********---------->	
									<c:if test="${! empty beanOrder}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td>
												<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();"><font color="#807265">社内用品発注依頼書</font></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(担) ${beanOrder.name}</a></td>												
												<td align="center">
													<font color="red">${beanOrder.qty}</font>
													<c:if test="${beanOrder.del_yn==2}">=><font color="#CC0099">削除要請中</font></c:if>													
												</td>		
											</tr>											
									</c:if>										
									<c:if test="${! empty beanOrder01}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td>
												<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();"><font color="#807265">社内用品発注依頼書</font></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanOrder01.name}</a></td>												
												<td align="center">
													<font color="red">${beanOrder01.qty}</font>
													<c:if test="${beanOrder01.del_yn==2}">=><font color="#CC0099">削除要請中</font></c:if>													
												</td>		
											</tr>											
									</c:if>																			
									<c:if test="${! empty beanOrder02}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><a href="<%=urlPage%>rms/admin/order/listForm.jsp" onfocus="this.blur();"><font color="#807265">社内用品発注依頼書</font></a>[参照]</td>					
												<td><a href="<%=urlPage%>rms/admin/order/listForm.jsp" onfocus="this.blur();">(承) ${beanOrder02.name}</a></td>												
												<td align="center" >
													<font color="red">${beanOrder02.qty}</font>
													<c:if test="${beanOrder02.del_yn==1}">=> <font color="#CC0099">注文中</font></c:if>
													<c:if test="${beanOrder02.del_yn==2}">=> <font color="#CC0099">削除要請中</font></c:if>
												</td>		
											</tr>											
									</c:if>																												
									<c:if test="${! empty listOrderFinal}">
											<c:forEach var="pdb" items="${listOrderFinal}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><a href="<%=urlPage%>rms/admin/order/finalForm.jsp?seq=${pdb.seq}" onfocus="this.blur();">
													<font color="#CC6600">社内用品</font><font color="#FF00CC">(物品確認)</font></a></td>					
												<td>	<a href="<%=urlPage%>rms/admin/order/finalForm.jsp?seq=${pdb.seq}" onfocus="this.blur();">${pdb.name}</a></td>												
												<td><a href="<%=urlPage%>rms/admin/order/finalForm.jsp?seq=${pdb.seq}" onfocus="this.blur();">${pdb.title}</a></td>
											</tr>																	
											</c:forEach>
									</c:if>
													
					<!----***********보고서(출장 결재서) ***********---------->										
										<c:if test="${! empty beanSignHokokuBoss}">															
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">																				
												<td>	<font color="#807265">出張決裁書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a>	</td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHokokuBoss.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignHokokuBoss.seqcnt}</font></td>										
											</tr>											
										</c:if>													
										<c:if test="${! empty beanSignHokokuBucho}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#807265">出張決裁書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHokokuBucho.nm}</a></td>											
												<td align="center" ><font color="red">${beanSignHokokuBucho.seqcnt}</font></td>
														
											</tr>											
										</c:if>
					<!----***********보고서(출장 보고서) 시작 사장***********---------->										
										<c:if test="${! empty beanSignTripBoss}">															
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">																
												<td><font color="#807265">出張報告書</font>	<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignTripBoss.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignTripBoss.seqcnt}</font></td>														
											</tr>											
										</c:if>															
										<c:if test="${! empty beanSignTripBucho}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#807265">出張報告書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignTripBucho.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignTripBucho.seqcnt}</font></td>	
											</tr>											
									</c:if>	
					<!----***********보고서(휴일근무 신청서) ***********---------->										
										<c:if test="${! empty beanSignHoliBoss}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td ><font color="#807265">休日出勤申請書</font>	<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td ><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliBoss.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignHoliBoss.seqcnt}</font></td>										
											</tr>											
										</c:if>														
										<c:if test="${! empty beanSignHoliBucho}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#807265">休日出勤申請書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliBucho.nm}</a></td>												
												<td align="center"  ><font color="red">${beanSignHoliBucho.seqcnt}</font></td>											
											</tr>											
										</c:if>																					
										<c:if test="${! empty beanSignHoliBucho2}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#807265">休日出勤申請書</font>	<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td> <a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliBucho2.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignHoliBucho2.seqcnt}</font></td>											
											</tr>											
										</c:if>																				
										<c:if test="${! empty beanSignHoliKanribu}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td  ><font color="#807265">休日出勤申請書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td  ><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliKanribu.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignHoliKanribu.seqcnt}</font></td>										
											</tr>											
									</c:if>	
												
												
					<!----***********보고서(휴일근무 보고서) ***********---------->										
										<c:if test="${! empty beanSignHoliConBoss}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#807265">休日出勤報告書</font>	<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliConBoss.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignHoliConBoss.seqcnt}</font></td>											
											</tr>											
										</c:if>														
										<c:if test="${! empty beanSignHoliConBucho}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#807265">休日出勤報告書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td   ><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliConBucho.nm}</a></td>												
												<td align="center"  ><font color="red">${beanSignHoliConBucho.seqcnt}</font></td>											
											</tr>											
										</c:if>													
										<c:if test="${! empty beanSignHoliConBucho2}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#807265">休日出勤報告書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliConBucho2.nm}</a></td>												
												<td align="center"  ><font color="red">${beanSignHoliConBucho2.seqcnt}</font></td>													
											</tr>											
										</c:if>													
										<c:if test="${! empty beanSignHoliConKanribu}">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">													
												<td><font color="#807265">休日出勤報告書</font><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td><a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${beanSignHoliConKanribu.nm}</a></td>												
												<td align="center" ><font color="red">${beanSignHoliConKanribu.seqcnt}</font></td>											
											</tr>											
									</c:if>																							
					<!----***********스케줄 시작***********---------->									
										<c:if test="${! empty listSignSchedule}">
											<c:forEach var="news" items="${listSignSchedule}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">
												<td><font color="#CC6600">日程管理</font>
												<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">==></a></td>					
												<td>
												<a href="<%=urlPage%>rms/admin/sign/listForm.jsp" onfocus="this.blur();">(承) ${news.nm}</td>												
												<td align="center"  ><font color="red">${news.jangyo_seq}</font></td>											
											</tr>																	
											</c:forEach>
									</c:if>
																							
	<!----***********상사로부터 반환 시작***********-------------------------------------------------------------------------------------------------->									
					<!----***********출퇴근***********---------->							
									<c:if test="${! empty listKintaiReturn}">
											<c:forEach var="pdb" items="${listKintaiReturn}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">出退勤</font>
	<a href="<%=urlPage%>rms/admin/kintai/listForm.jsp?seq=${pdb.seq}&yyVal=${fn:substring(pdb.hizuke,0,4)}&mmVal=${fn:substring(pdb.hizuke,5,7)}" onfocus="this.blur();"> [${pdb.hizuke}]</a></td>					
												<td>
	<a href="<%=urlPage%>rms/admin/kintai/listForm.jsp?seq=${pdb.seq}&yyVal=${fn:substring(pdb.hizuke,0,4)}&mmVal=${fn:substring(pdb.hizuke,5,7)}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.sign_no_riyu}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
					<!----***********잔업***********---------->							
									<c:if test="${! empty listJangyoReturn}">
											<c:forEach var="pdb" items="${listJangyoReturn}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">残業申請</font>
	<a href="<%=urlPage%>rms/admin/jangyo/listForm.jsp?seq=${pdb.seq}&yyVal=${fn:substring(pdb.hizuke,0,4)}&mmVal=${fn:substring(pdb.hizuke,5,7)}" onfocus="this.blur();"> [${pdb.hizuke}]</a></td>					
												<td>
	<a href="<%=urlPage%>rms/admin/jangyo/listForm.jsp?seq=${pdb.seq}&yyVal=${fn:substring(pdb.hizuke,0,4)}&mmVal=${fn:substring(pdb.hizuke,5,7)}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.sign_no_riyu}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
					
					<!----***********사내 용품 발주 의뢰서***********---------->							
									<c:if test="${! empty listOrderReturn02}">
											<c:forEach var="pdb" items="${listOrderReturn02}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">社内用品発注依頼書</font>
												<a href="<%=urlPage%>rms/admin/order/updateForm.jsp?seq=${pdb.seq}" onfocus="this.blur();">==></a></td>					
												<td>
												<a href="<%=urlPage%>rms/admin/order/updateForm.jsp?seq=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.sign_no_riyu_01}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
									<c:if test="${! empty listOrderReturn03}">
											<c:forEach var="pdb" items="${listOrderReturn03}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">社内用品発注依頼書</font>
												<a href="<%=urlPage%>rms/admin/order/updateForm.jsp?seq=${pdb.seq}" onfocus="this.blur();">==></a></td>					
												<td>
												<a href="<%=urlPage%>rms/admin/order/updateForm.jsp?seq=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.sign_no_riyu_02}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
					<!----***********出張決裁書***********---------->							
									<c:if test="${! empty listKesaiReturn01}">
											<c:forEach var="pdb" items="${listKesaiReturn01}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">出張決裁書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/write/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/write/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title01}::${pdb.sign_no_riyu_boss}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
									<c:if test="${! empty listKesaiReturn02}">
											<c:forEach var="pdb" items="${listKesaiReturn02}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">出張決裁書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/write/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/write/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title02}::${pdb.sign_no_riyu_bucho}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
					<!----***********出張報告書***********---------->							
									<c:if test="${! empty listTripReturn01}">
											<c:forEach var="pdb" items="${listTripReturn01}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">出張報告書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeTripBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeTripBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title01}::${pdb.sign_no_riyu_boss}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
									<c:if test="${! empty listTripReturn02}">
											<c:forEach var="pdb" items="${listTripReturn02}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">出張報告書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeTripBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeTripBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title02}::${pdb.sign_no_riyu_bucho}"></td>
											</tr>																	
											</c:forEach>
									</c:if>
					<!----***********보고서(휴일근무 신청서) ***********---------->																																
										<c:if test="${! empty listHoSinReturn01}">
											<c:forEach var="pdb" items="${listHoSinReturn01}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤申請書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title01}::${pdb.sign_no_riyu_boss}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
										<c:if test="${! empty listHoSinReturn02}">
											<c:forEach var="pdb" items="${listHoSinReturn02}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤申請書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title02}::${pdb.sign_no_riyu_bucho}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
										<c:if test="${! empty listHoSinReturn03}">
											<c:forEach var="pdb" items="${listHoSinReturn03}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤申請書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title03}::${pdb.sign_no_riyu_bucho2}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
										<c:if test="${! empty listHoSinReturn04}">
											<c:forEach var="pdb" items="${listHoSinReturn04}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤申請書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateForm.jsp?fno=${pdb.seq}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title04}::${pdb.sign_no_riyu_kanribu}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
					<!----***********보고서(휴일근무 보고서) ***********---------->																																
										<c:if test="${! empty listHoHokoReturn01}">
											<c:forEach var="pdb" items="${listHoHokoReturn01}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤報告書</font>${pdb.level},,${pdb.seq}
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title01}::${pdb.sign_no_riyu_boss}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
										<c:if test="${! empty listHoHokoReturn02}">
											<c:forEach var="pdb" items="${listHoHokoReturn02}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤報告書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title02}::${pdb.sign_no_riyu_bucho}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
										<c:if test="${! empty listHoHokoReturn03}">
											<c:forEach var="pdb" items="${listHoHokoReturn03}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤報告書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title03}::${pdb.sign_no_riyu_bucho2}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
										<c:if test="${! empty listHoHokoReturn04}">
											<c:forEach var="pdb" items="${listHoHokoReturn04}" varStatus="idx">														
											<tr height="15"  onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">	
												<td><font color="#CC6600">休日出勤報告書</font>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"> [<fmt:formatDate value="${pdb.register}" type="date" pattern="yy-MM-dd"/>]</a></td>					
												<td>
				<a href="<%=urlPage%>rms/admin/hokoku/writeHoliBogo/updateBogoForm.jsp?fno=${pdb.level}" onfocus="this.blur();"><font color="#FF00CC">再検討要請</font></td>												
												<td align="center"><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="${pdb.title04}::${pdb.sign_no_riyu_kanribu}"></td>
											</tr>																	
											</c:forEach>
										</c:if>
					

	<!----***********상사로부터 반환 끝***********-------------------------------------------------------------------------------------------------->																						
									</tr>
								</tbody>							
								</table>
							</div>													

<!--****sign end**********************************-->														
		</div>
	</div>

	<div class="conten_middle02">
<!--osirase begin*************************** -->														
		<a href="<%=urlPage%>rms/admin/notice/listForm.jsp" onFocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/main/osirase.gif" align="absmiddle" ></a>				
		<div class="boxTable_eee">								
			<table width="100%"  cellpadding="2" cellspacing="2">
			<tbody>																		
			<c:if test="${empty list}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td>登録された内容がありません。</td></tr>
			</c:if>
			<c:if test="${! empty list}">
				<%
					int i=1;
					Iterator listiter=list.iterator();
						while (listiter.hasNext()){				
							NewsBean board=(NewsBean)listiter.next();
							int bseq=board.getSeq();
																				
				%>
										
					<tr height="20">											
						<td >
							<img src="<%=urlPage%>rms/image/icon_s.gif" >
							<span class="small_day"><%=formatter.format(board.getRegister())%></span>													
							<span class="toggle">
								<a class="topnav" href="#" style="cursor:pointer;" onfocus="this.blur()"><%=board.getTitle()%></a>
							</span>															
								<%if(formatter.format(board.getRegister()).equals(today)){%><img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="asbmiddle"> <font color="007AC3">new!!</font><%}%>		
							<div id="hiddenDiv">
				<!--list_inner box start----->						
								<div class="innerDivSlice_admin_main" >
									<div class="hiddenBox_admin_main" >
										<%if(board.getContent()==null || board.getContent().equals("No Data")){%>---<%}else{%><%=board.getContent()%><%}%> 
									</div>
								</div>
							</div>
						</td>
					</tr>			
			<%i++;}%>	
		</c:if>															
			</tbody>							
		</table>
	</div>			
<!--osirase end*************************** -->
<div class="clear"></div>
<!--사내 게시판 begin*************************** -->	
		<a  href="<%=urlPage%>rms/admin/board/listForm.jsp?kindboard=1" onFocus="this.blur()">
		<img src="<%=urlPage%>rms/image/admin/main/saneboardTitle.gif" align="absmiddle" ></a>
	<div class="boxTable_eee">		
		<table width="100%"  cellpadding="2" cellspacing="2">
			<tbody>																		
			<c:if test="${empty listBor}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor=""><td>登録された内容がありません。</td></tr>
			</c:if>
			<c:if test="${! empty listBor}">			
			<%
			int i=1;
			Iterator listiter=listBor.iterator();
				while (listiter.hasNext()){				
					Board board=(Board)listiter.next();
					int bseq=board.getBseq();
					int levelBor=board.getLevel();
					if(levelBor==1){			
			%>
<c:set var="title" value="<%=board.getTitle()%>"/>					
					<tr height="20">											
						<td >
							<img src="<%=urlPage%>rms/image/icon_s.gif" >
							<span class="small_day"><%=formatter.format(board.getRegister())%></span>													
							<span class="toggle">
								<a class="topnav" href="#" style="cursor:pointer;" onfocus="this.blur()">
										<c:if test="${fn:length(title)>=18}"> ${fn:substring(title, 0, 18)}</c:if>
										<c:if test="${fn:length(title)<18}"> ${title}</c:if>	
										<%if(formatter.format(board.getRegister()).equals(today)){%><img src="<%=urlPage%>rms/image/admin/memo_s.gif" align="asbmiddle"> <font color="007AC3">new!!</font><%}%>	
								</a>
							</span>																							
							<div id="hiddenDiv">
				<!--list_inner box start----->						
								<div class="innerDivSlice_admin_main" >
									<div class="hiddenBox_admin_main" >
									<%if(board.getContent()==null || board.getContent().equals("No Data")){%>---<%}else{%><%=board.getContent()%><%}%>
									</div>
								</div>
							</div>
						</td>
					</tr>			
			<%}i++;}%>	
		</c:if>															
			</tbody>							
		</table>	
	</div>
	<div class="clear"></div>
			
<script language="javascript" type="text/javascript">  
var maxAmount = 200; 
function textCounter(textField, showCountField) { 
    if (textField.value.length > maxAmount) { textField.value = textField.value.substring(0, maxAmount); } else {  showCountField.value = maxAmount - textField.value.length; } 
/*
var fill = document.getElementById("comentSpecial");	
var NotPermitChar = "<>\"&|'\\%";  
	   for (var i = 0; i < textField.value.length; i++) {
		      for (var j = 0; j < NotPermitChar.length; j++) {
			         if(textField.value.charAt(i) == NotPermitChar.charAt(j)) {			        
			         	//textField.value ="";				         	
			         	fill.innerHTML="특수문자는 피해 주세요!!";			         
			         }
		      }
	   }   
*/	   
}

function goWrite(){
	var frm = document.inputVal;	
	frm.content.value=frm.ta.value;		
if ( confirm("登録しますか?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>rms/admin/hitokoto/add.jsp";	
frm.submit();		
}	
</script>		
	<div class="boxTable_messege">	
		
		<form name="inputVal" method="post">	 
			<input type="hidden" name="view_yn" value="2">
			<input type="hidden" name="nm" value="<%=usernm%>">
			<input type="hidden" name="content" value="">
			<input type="hidden" name="gopage" value="main">	    
		    	<input type="hidden" name="title" value="バグやエラーなどの不具合について">  	            
		    	<input type="hidden" name="mseq" value="<%=mseq%>"> 
		    	
				<textarea class="textarea_main"  id="ta" name="ta" rows="4" style="width:217px;" onKeyDown="textCounter(this.form.ta,this.form.countDisplay);" onKeyUp="textCounter(this.form.ta,this.form.countDisplay);" value="バグやエラーなどの不具合についてご記入下さい。" 	onfocus="if(this.value=='バグやエラーなどの不具合についてご記入下さい。'){this.value=''}" onblur="if(this.value==''){this.value='バグやエラーなどの不具合についてご記入下さい。'}">バグやエラーなどの不具合についてご記入下さい。</textarea> 			
				<img src="<%=urlPage%>rms/image/admin/neko.gif" name="imgTemp01"  	onMouseOver="imgTemp01.src='<%=urlPage%>rms/image/admin/neko_on.gif';" onMouseOut="imgTemp01.src='<%=urlPage%>rms/image/admin/neko.gif';"  style="cursor:pointer;" onClick="goWrite();" alt="転送" title="転送"/><input class="input_nosolid" readonly type="text" name="countDisplay" id="countDisplay" size="1" maxlength="3" value="">  	 
			
		</form>			
		
	</div><!--boxTable_messege -->								
<!--사내 게시판  end*************************** -->	
	</div><!--conten_middle02 -->	
<div class="clear"></div>			
<div class="clear_line"></div>			
<%if(!id.equals("candy")){%>		
	
	<div id="conten_bottom"  >		
		<div class="conten_bottom_L">
<!--GMP管理機器*************************** -->
<script type="text/javascript">
window.onload = function() {
		cdtd(); 
		cdtd2();	
	}
			
function cdtd() {	
	var inputs=document.getElementsByTagName("input");	
		for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].name == "gmpdate" ) {	 	     			     				      			   		
	      			var myArray = inputs[i].value.split("-"); 
				var monthVal="";
				
				if(myArray[1]=="01"){monthVal="January";}	if(myArray[1]=="02"){monthVal="February";}if(myArray[1]=="03"){monthVal="March";}if(myArray[1]=="04"){monthVal="April";}
				if(myArray[1]=="05"){monthVal="May";}if(myArray[1]=="06"){monthVal="June";}if(myArray[1]=="07"){monthVal="July";}if(myArray[1]=="08"){monthVal="August";}	
				if(myArray[1]=="09"){monthVal="September";}if(myArray[1]=="10"){monthVal="October";}if(myArray[1]=="11"){monthVal="November";}
				if(myArray[1]=="12"){monthVal="December";}
				
				 var todayVal = new Date(monthVal+" "+myArray[2]+" , "+myArray[0]+" 00:01:00");
				 var now = new Date();
				 var timeDiff = todayVal.getTime() - now.getTime();
				 var menu= "daysBox-"+myArray[3]+"-"+myArray[4];	
				 if (timeDiff <= 0) { document.getElementById(menu).innerHTML = timeDiff+1;}				 	
				 var seconds = Math.floor(timeDiff / 1000);
				 var minutes = Math.floor(seconds / 60);
				 var hours = Math.floor(minutes / 60);
				 var days = Math.floor(hours / 24);		 
				 	hours %= 24;
				    	minutes %= 60;
				    	seconds %= 60;
				 document.getElementById(menu).innerHTML = days+1;	 
			//	 var timer = setTimeout('cdtd()',1000);	      				      			
	       		}
    		}
  		
}
</script>
	<a href="<%=urlPage%>rms/admin/gmp/listForm.jsp" onfocus="this.blur();">
	<img src="<%=urlPage%>rms/image/admin/main/gmpTitle.gif" align="absmiddle" ></a>	
	<div class="boxTable">	
	<table width="100%"  cellpadding="0" cellspacing="1">	
			<thead>	
				<tr height="22" align="center">										
					<td class="listBarTitle" width="20%">実施期限</td>
					<td  class="listBarTitle">管理番号</td>											      
					<td  class="listBarTitle">設備等名称</td>							
					<td   class="listBarTitle">導入部門</td>										
					<td  class="listBarTitle">ステータス</td>
				</tr>
			</thead>				
			<tbody width="100%" >	
				</tr>
	<c:if test="${empty listGmp && empty listGmp2 && empty listGmpNo}">		
				<tr height="20"><td colspan="5" >---</td></tr>
	</c:if>
<!---GMP 사용불가만 출력 begin-->	
	<c:if test="${! empty listGmpNo}">
<%            
			int i=0;	String date01=""; 						
			Iterator listiter=listGmpNo.iterator();
				while (listiter.hasNext()){				
					GmpBeen db_item2=(GmpBeen)listiter.next();
					int bseq=db_item2.getBseq();	
					String date02=db_item2.getDate02();
					String kanri_no=db_item2.getKanri_no();
					String seizomoto=db_item2.getSeizomoto();
					String gigi_nm=db_item2.getGigi_nm();
						
			      	if(db_item2.getEda_no()==2  && db_item2.getDate02_yn()==1){
			/**		
				if(db_item2.getDate01()!=null){
					if(db_item2.getDate01().length()>10){
						date01=db_item2.getDate01().substring(0,10);
					}else if(db_item2.getDate01().length()==10){
						date01=db_item2.getDate01();
					}				
				}else{
					date01="0000-00-00";
				}
			**/																	
		%>
							
			<input type="hidden" name="gmpdate" id="gmpdate" value="<%=date01%>-<%=bseq%>-1">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">			
				<td ><font color="#CC0000"><%=date02.substring(0,10)%></font><img src="<%=urlPage%>rms/image/admin/main/attentionGmpNo.gif" align="asbmiddle" width="33" height="13"></td>
				<td align="center" >--
				</td>		
			</tr>	
				
				
	<%}
	i++;
	}												  													  
	%>	
	</c:if>	
<!---보류 end-->										
	<c:if test="${! empty listGmp2}">
<%        
			int i=1;	String date02Val="";						
			Iterator listiter=listGmp2.iterator();
				while (listiter.hasNext()){				
					GmpBeen db_item=(GmpBeen)listiter.next();
					int bseq=db_item.getBseq();	
					
					if(db_item.getDate02()!=null && db_item.getDate02_yn()==1){
						if(db_item.getDate02().length()>10){
							date02Val=db_item.getDate02().substring(0,10);
						}else if(db_item.getDate02().length()==10){
							date02Val=db_item.getDate02();
						}				
					}else{						
	%>
				<tr height="20"><td colspan="5" >---</td></tr>	
			<%date02Val="0000-00-00";
		}			
	if(db_item.getDate02_yn()==1){							
	%>						
		<input type="hidden" name="gmpdate" id="gmpdate" value="<%=date02Val%>-<%=bseq%>-2">						
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="">			
				<td ><font color="#CC0000"><%=db_item.getDate02().substring(0,10)%></font><img src="<%=urlPage%>rms/image/admin/main/attentionGmp.gif" align="asbmiddle" width="33" height="13"></td>
				<td align="center" ><font color="#CC0000"><%=db_item.getKanri_no()%></font></td>																		
				<td ><a class="fileline" href="javascript:goRead(<%=bseq%>)"  onfocus="this.blur()"><%if(db_item.getGigi_nm()!=null){%><%=db_item.getGigi_nm()%><%}else{%>&nbsp;<%}%>&nbsp;</a> </td>											
		
			       <td ><%if(db_item.getSeizomoto()!=null){%><%=db_item.getSeizomoto()%><%}else{%>&nbsp;<%}%>			       	   
			      </td>							
				<td align="center">
      			<%if(db_item.getEda_no()==1 ){%> [未実施] <%}else{ %>[使用不可] <%}%> 
      				   
      			<%if(GmpModi==1){%>
      				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="OFF" onClick="goModifyGmp('<%=bseq%>','2','2')"  title="アラート機能 OFF" >
				<%}else{%>	 	
				<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="OFF" onClick="javascript:alert('担当者のみ処理出来ます。');"  title="アラート機能 OFF" >	
				<%}%>					
					 	
				</td>		
			</tr>	
	<%}%>
	<%
	i++;
	}												  													  
	%>	
	</c:if>	</tbody>
			</table>						
									
	</div><!--boxTable----GMP管理機器 end*************************** -->	
</div>		

		
<div class="conten_bottom_R">
<!--契約書【アラーと】機能 start*************************** -->
<script type="text/javascript">			
function cdtd2() {	
	var inputs=document.getElementsByTagName("input");	
		for(var i = 0; i < inputs.length; i++) {
	     		if(inputs[i].name == "contractdate" ) {	 	     			     				      			   		
	      			var myArray = inputs[i].value.split("-"); 
				var monthVal="";
				
				if(myArray[1]=="01"){monthVal="January";}	if(myArray[1]=="02"){monthVal="February";}if(myArray[1]=="03"){monthVal="March";}if(myArray[1]=="04"){monthVal="April";}
				if(myArray[1]=="05"){monthVal="May";}if(myArray[1]=="06"){monthVal="June";}if(myArray[1]=="07"){monthVal="July";}if(myArray[1]=="08"){monthVal="August";}	
				if(myArray[1]=="09"){monthVal="September";}if(myArray[1]=="10"){monthVal="October";}if(myArray[1]=="11"){monthVal="November";}
				if(myArray[1]=="12"){monthVal="December";}
				
				 var todayVal = new Date(monthVal+" "+myArray[2]+" , "+myArray[0]+" 00:01:00");
				 var now = new Date();
				 var timeDiff = todayVal.getTime() - now.getTime();
				 var menu= "daysBoxCon-"+myArray[3]+"-"+myArray[4];	
				 if (timeDiff <= 0) { document.getElementById(menu).innerHTML = timeDiff+1;}				 	
				 var seconds = Math.floor(timeDiff / 1000);
				 var minutes = Math.floor(seconds / 60);
				 var hours = Math.floor(minutes / 60);
				 var days = Math.floor(hours / 24);		 
				 	hours %= 24;
				    	minutes %= 60;
				    	seconds %= 60;
				 document.getElementById(menu).innerHTML = days+1;	 
			//	 var timer = setTimeout('cdtd()',1000);	      				      			
	       		}
    		}
  		
}
</script>
	<a href="<%=urlPage%>rms/admin/contract/listForm.jsp" onfocus="this.blur();">
	<img src="<%=urlPage%>rms/image/admin/main/contractTitle.jpg" align="absmiddle" ></a>	
		<img src="<%=urlPage%>rms/image/icon_s.gif" ><span class="fontR4">日数--> 終了迄の日数</span>
	<div class="boxTable">	
	<table width="100%"  cellpadding="0" cellspacing="0">
			<thead>	
				<tr height="22" align="center" bgcolor="#eeeeee">										
					<td  class="title_list_s_r">契約終了日</td>
					<td  class="title_list_s_r">日数</td>		
					<td  class="title_list_s_r">管理No</td>	
					<td  class="title_list_s_r">契約先</td>	
					<td  class="title_list_s_r">契約内容</td>		
					<td  class="title_list_s_r">契約日</td>
					<td  class="title_list_s_r">担当者</td>								
					<td  class="title_list">アラート<br>変更</td>
				</tr>
			</thead>				
			<tbody width="100%" >					
		<!--prepare -------------------------->
<%if(pageArrowCon==1){%>
<c:if test="${empty listContract }">		
				<tr height="20"><td colspan="8" >---</td></tr>
</c:if>
<c:if test="${! empty listContract}">
<%        
    String conCode=""; 
    String date02="";     
			int i=0;							
			Iterator listiter=listContract.iterator();
				while (listiter.hasNext()){				
					ContractBeen db_item=(ContractBeen)listiter.next();
					int bseq=db_item.getBseq();	
					
				if(db_item.getDate_end()!=null){
					if(db_item.getDate_end().length()>10){
						date02=db_item.getDate_end().substring(0,10);
					}else if(db_item.getDate_end().length()==10){
						date02=db_item.getDate_end();
					}				
				}else{
					date02="0000-00-00";
				}										
					conCode=db_item.getKanri_no();             									
		%>
							
			<input type="hidden" name="contractdate" id="contractdate" value="<%=date02%>-<%=bseq%>-1">									
			<tr>				
				<td class="line_gray_bottomnright"><font color="#CC0000"><%=db_item.getDate_end()%></font><img src="<%=urlPage%>rms/image/admin/main/attentionGmp.gif" width="30" height="14" align="asbmiddle"></td>
				<td class="line_gray_bottomnright" align="center" ><font color="#CC0000"><div id="daysBoxCon-<%=bseq%>-1"></div></font></td>
				<td class="line_gray_bottomnright" align="center" ><a class="fileline" href="javascript:goReadCon(<%=bseq%>)"  onfocus="this.blur()"><%=conCode%></a></td>	
				<td class="line_gray_bottomnright"><a class="fileline" href="javascript:goReadCon(<%=bseq%>)"  onfocus="this.blur()"><%=db_item.getContact()%></a></td>
				<td class="line_gray_bottomnright"><a class="fileline" href="javascript:goReadCon(<%=bseq%>)"  onfocus="this.blur()"><%=db_item.getContent()%></a></td>															
				<td class="line_gray_bottomnright"><%=db_item.getHizuke()%></td>				
				<td class="line_gray_bottomnright"><%if(db_item.getSekining_nm()!=null){%><%=db_item.getSekining_nm()%><%}else{%>&nbsp;<%}%>  </td>			       
				<td class="line_gray_bottom" align="center">
				<%if(db_item.getSekining_mseq()==mseq || id.equals("funakubo") || id.equals("juc0318") || id.equals("admin")){%>		   	   
					   	<%if(db_item.getRenewal_yn()==1 ){%>			   		   			
								<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" ON " onClick="popupOnOff('<%=bseq%>');">			
					   	<%}else{%>
					   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF " onClick="popupOnOff('<%=bseq%>');"> 
					   	<%}%>		
				<%}else{%>	
						<%if(db_item.getRenewal_yn()==1 ){%>			   		   			
								<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" ON "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
					   	<%}else{%>
					   			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value=" OFF "  onClick="javascript:alert('担当者のみ処理出来ます。');">	
					   	<%}%>	
				<%}%>										
				</td>	
			</tr>			
	<%
	i++;
	}												  													  
	%>	
</c:if>
<%}else{%>		
		<tr height="20"><td colspan="7" >---</td></tr>
<%}%>								
		</tbody>
		</table>									
	</div><!--<div class="boxTable">--->
<%}%>
	</div><!----conten_bottom_R------>	
<div class="clear"></div>				
		
		
		
<!--決裁書/契約書【アラーと】機能  end*************************** -->	
<!--請求書【アラーと】機能 start************************
<%if(nmView==1){%>

	<div class="conten_bottom_L">
	<a href="<%=urlPage%>rms/admin/payment/listForm.jsp" onfocus="this.blur();">
	<img src="<%=urlPage%>rms/image/admin/main/seikyuTitle.jpg" align="absmiddle" ></a>			
	<div class="boxTable">	
	<table width="100%"  cellpadding="0" cellspacing="0">
			<thead>	
				<tr height="22" align="center" bgcolor="#eeeeee">										
					<td  class="title_list_s_r" width="23%">受領日</td>
					<td  class="title_list_s_r">取引先</td>								
					<td  class="title_list_s_r"><span class="small_day">(ORMS)</span><br>受領</td>
					<td  class="title_list_s_r"><span class="small_day">(東京)</span><br>処理</td>								
					<td  class="title_list">担当者</td>
				</tr>
			</thead>				
			<tbody width="100%" >					
			<c:if test="${empty listSeikyu}">
			<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" colspan="5"><td>登録された内容がありません。</td></tr>
			</c:if>
			<c:if test="${! empty listSeikyu}">
				<%
					int i=1; int dayKubun=0;
					Iterator listiter=listSeikyu.iterator();
						while (listiter.hasNext()){
							Category dbb=(Category)listiter.next();
							int seq=dbb.getSeq();
							String dbday=dbb.getSinsei_day();											
							if(seq!=0){
								dayKubun=mgrSeikyu.newKubun(strDateSe,dbday,seq);
																											
				%>										
					
					<tr onMouseOver=this.style.backgroundColor="#EFF5F9" onMouseOut=this.style.backgroundColor="" height="20">	
						<td >
							<span class="small_day">(<%if(dbb.getPay_type()==1){%>毎月<%}else if(dbb.getPay_type()==2){%>随時<%}%>)</span>
							<%=dbday%><%if(dayKubun!=0){%><img src="<%=urlPage%>rms/image/admin/icon_new_list.gif" align="asbmiddle"><%}%>
						</td>												
						<td><%=dbb.getClient_nm()%></td>
						<td align="center"> 
							<%if(dbb.getReceive_yn_sinsei()==1){%><font color="#CC0000">No</font>	
							<%}else{%><font color="#007AC3">完了</font>	<%}%>
						</td>
						<td align="center"> 
							<%if(dbb.getShori_yn()==1){%><font color="#CC0000">No</font>	
							<%}else{%><font color="#007AC3">完了</font>	<%}%>
						</td>
						<td><%=dbb.getName()%></td>
					</tr>			
			<%}i++;}%>	
		</c:if>		
								
		</tbody>
		</table>									
	</div><!--<div class="boxTable">									
	<div> <!----conten_bottom_L
<%}%>
-->
   </div>		
		
<!-- 팝업 start-->				
		<div id="passpop"  >
		<iframe  name="iframe_inner" class="nobg" width="380" height="300" marginheight="0" marginwidth="0" frameborder="0" framespacing="0" scrolling="no" allowtransparency="true" ></iframe>	
		</div> 
<!-- 팝업 끝-->
</div>
	

<form name="move" method="post">
    <input type="hidden" name="seq" value="">        
    	<input type="hidden" name="dateKind" value="">
    	<input type="hidden" name="dateYn" value="">
    	<input type="hidden" name="mseq" value="<%=mseq%>">
      <input type="hidden" name="read" value="">
   	<input type="hidden" name="renewal_yn" value="">
   	<input type="hidden" name="pgkind" value="">
</form>
<script language="JavaScript">
function goModifyGmp(seq,dateKind,dateYn) {		
	if(confirm("処理しますか？")!=1){return;}
    	document.move.action = "<%=urlPage%>rms/admin/gmp/dateView.jsp";
	document.move.seq.value=seq;
	document.move.dateKind.value=dateKind;
	document.move.dateYn.value=dateYn;		
	document.move.mseq.value="<%=mseq%>";		
    	document.move.submit();
    
}
function goRead(seq) {	
    	document.move.action = "<%=urlPage%>rms/admin/gmp/updateForm.jsp";
	document.move.seq.value=seq;
	document.move.read.value="read";		
    	document.move.submit();
}
function goReadCon(seq) {		
	alert("特別文書システムにて編集して下さい");
	/*
    	document.move.action = "<%=urlPage%>rms/admin/contract/updateForm.jsp";
	document.move.seq.value=seq;
	document.move.read.value="read";		
    	document.move.submit();
    	*/
}
function popupOnOff(seq){	
	var overlay = document.getElementById('overlay');
	//overlay.style.opacity = .8;		
	
	 if(document.getElementById("passpop").style.display == 'none'){
	 	 overlay.style.display = "block";
		document.getElementById("passpop").style.display="block";		
		iframe_inner.location.href = "<%=urlPage%>rms/admin/contract/popup_OnOff.jsp?seq="+seq+"&mseq=<%=mseq%>&pgkind=main"; 
	 } else{
	 	 iframe_inner.location.replace("about:blank");
	 	 overlay.style.display = "none";
	 	document.getElementById("passpop").style.display = "none";
	 }	 	
}
/*
function goModifyCon(seq,renewal_yn) {			
	if(confirm("処理しますか？")!=1){return;}
    	document.move.action = "<%=urlPage%>rms/admin/contract/dateView.jsp";
	document.move.seq.value=seq;	
	document.move.renewal_yn.value=renewal_yn;		
	document.move.mseq.value="<%=mseq%>";	
	document.move.pgkind.value="main";		
    	document.move.submit();    
}
*/
</script>		


