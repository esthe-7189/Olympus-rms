<%@ page contentType = "text/html; charset=utf8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>


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
String urlPagemain=request.getContextPath()+"/";
String seq_holiBogo=request.getParameter("seq_holiBogo");
String gotopage=request.getParameter("gotopage");
if(gotopage==null){gotopage="1";}	

String kind_pg_write=request.getParameter("kind_pg_write");
if(kind_pg_write==null){kind_pg_write="0";}

int level=0; 
String name=""; 
int mseq=0; 
String position=""; 
String busho="";
int dbPosiLevel=0;

MemberManager mem = MemberManager.getInstance();	
Member member=mem.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();		 
		 mseq=member.getMseq();
		 position=member.getPosition();
		 busho=member.getBusho();
		 dbPosiLevel=member.getPosition_level();
	}	

int lineCnt=0;
String lineCntVal=request.getParameter("lineCntVal");
if(lineCntVal==null){lineCnt=2;}
if(lineCntVal!=null){lineCnt=Integer.parseInt(lineCntVal);}
String bushopg=request.getParameter("bushopg");
if(bushopg==null){bushopg="1";}

String bushoVal="";
	 if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){	
		 bushoVal=bushopg;	
	}else{
		bushoVal=busho;
	}	
int levelKubun=0;
if(dbPosiLevel!=1){levelKubun=dbPosiLevel-1;}
List listSign=mem.selectJangyo(1,5); //position level 1~4, 부서(1=品質管理部,2=製造部 ,3=管理部)
Member memSign;	

%>
<c:set var="member" value="<%=member%>"/>
<c:set var="listSign" value="<%= listSign %>" />	

<html>
<head>
<title>OLYMPUS-RMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<script language="javascript">

function resize(width, height){	
	window.resizeTo(width, height);
}
function goWrite(){	
var frm= document.frm;
var cnt = document.getElementsByName("signupTile").length; 
  
  if(cnt==2){
  var value = document.getElementsByName("signupTile")[0].value;  
  var value2 = document.getElementsByName("signupTile")[1].value;  
  	if( value == "" || value2 == ""){ 	
  		alert("職名(階級)を書いて下さい"); return;	
  	}  	
  }
  if(cnt==4){
  	var  value1 = document.getElementsByName("signupTile")[0].value;  
  	var  value2 = document.getElementsByName("signupTile")[1].value;  
  	var  value3 = document.getElementsByName("signupTile")[2].value;  
  	var  value4 = document.getElementsByName("signupTile")[3].value;  
  	if( value1 == "" || value2 == "" || value3 == "" || value4 == ""){ 	
  		alert("職名(階級)を書いて下さい"); return;		
  	}  	
  }
  
  
if ( confirm("登録しますか?") != 1 ) {	return;}
frm.action = "<%=urlPage%>rms/admin/hokoku/signupLine/insert.jsp";	
frm.submit();
}

function emailserv(){ 	
  var frm = document.frm;
  var cnt = document.getElementsByName("signupTile").length; 
  
  if(cnt==2){
  var value = document.getElementsByName("signupTile")[0].value;  
  var value2 = document.getElementsByName("signupTile")[1].value;  
  	if( value != ""){ 	
  		document.getElementById("show_1").style.display=''; 
  		document.getElementsByName("signup_position")[0].value=value;  	
  	}
  	if( value2 != ""){ 
  		document.getElementById("show_2").style.display=''; 
  		document.getElementsByName("signup_position")[1].value=value2; 
  	}  
  }
  if(cnt==4){
  	 var value1 = document.getElementsByName("signupTile")[0].value;  
  	 var value2 = document.getElementsByName("signupTile")[1].value;  
  	 var value3 = document.getElementsByName("signupTile")[2].value;  
  	 var value4 = document.getElementsByName("signupTile")[3].value;  
  	if( value1 != ""){ 	
  		document.getElementById("show_1").style.display=''; 
  		document.getElementsByName("signup_position")[0].value=value1;  	
  	}
  	if( value2 != ""){ 
  		document.getElementById("show_2").style.display=''; 
  		document.getElementsByName("signup_position")[1].value=value2; 
  	}  
  	if( value3 != ""){ 
  		document.getElementById("show_3").style.display=''; 
  		document.getElementsByName("signup_position")[2].value=value3; 
  	}  
  	if( value4 != ""){ 
  		document.getElementById("show_4").style.display=''; 
  		document.getElementsByName("signup_position")[3].value=value4; 
  	}  
  }
  return;
}

</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('700','320') ;">
<center>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 6px;"> 
	<form name="frm" action="<%=urlPage%>rms/admin/hokoku/signupLine/insert.jsp" method="post" >	 
	 <input type="hidden" name="mseq" value="<%=mseq%>">	 		
	 <input type="hidden" name="lineCntVal" value="<%=lineCnt%>">
	 <input type="hidden" name="bushopg" value="<%=bushoVal%>">		 	 
	 <input type="hidden" name="kind_pg_write" value="<%=kind_pg_write%>">	 	
	 <input type="hidden" name="gotopage" value="<%=gotopage%>">
	 <input type="hidden" name="seq_holiBogo" value="<%=seq_holiBogo%>">
  <tr>
    <td  width="95%"  style="padding:10 0 3 6" valign="middle">
    	<img src="<%=urlPage%>rms/image/admin/location.gif" align="absmiddle">    
    	<strong> 決裁ライン指定</strong>
    </td>
   </tr>
   <tr>
    <td style="padding:0 0 2 6">    
   　 <img src="<%=urlPage%>rms/image/icon_ball.gif" >	段階 : 
			出張決裁書<font color="#007AC3">(2段階)</font>,
			出張報告書<font color="#007AC3">(2段階)</font>,
			休日出勤申請書/報告書<font color="#007AC3">(4段階)</font>
	</td>
	</tr>
	<tr>
	<td style="padding:0 0 2 6">
   　 <img src="<%=urlPage%>rms/image/icon_ball.gif" >	手順 :
			社長<font color="#007AC3">--></font>
			事業本部長<font color="#007AC3">--></font>
			部長<font color="#007AC3">--></font>
    	
    </td>
  </tr>  
  <tr>
	<td style="padding:0 0 2 6">
   　 <img src="<%=urlPage%>rms/image/icon_ball.gif" >	修正 :
			新たに書くと自動的に修正されます。
    	
    </td>
  </tr>  
  <tr>
    <td  bgcolor="#ff8000" height="2" width="95%"><img src="<%=urlPage%>rms/image/admin/blank.gif" width="1" height="2" border="0"></td>
  </tr>
  <tr>
	    <td width="95%" valign="top" bgcolor="#F7F5EF"> 
	<!-- 대 -->
		    <table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr height=26>							
		        <td height="10" width="17%"><img src="<%=urlPage%>rms/image/icon_s.gif"><b>項目分類</b></td>
		    	<td height="10" width="83%" bgcolor="#ffffff">				
		    		<input type="radio" name="kind_pg"  value="1" onClick="fellowLine()"  onfocus="this.blur()" <%if(gotopage.equals("1")){%>checked<%}%>><font color="#009900">出張</font><font color="#CC6600">決裁書</font> &nbsp;
					<input type="radio" name="kind_pg"  value="2" onClick="fellowLine()"  onfocus="this.blur()" <%if(gotopage.equals("2")){%>checked<%}%>><font color="#009900">出張</font><font color="#CC6600">報告書</font> &nbsp;
					<input type="radio" name="kind_pg"  value="3" onClick="fellowLine()"  onfocus="this.blur()" <%if(gotopage.equals("3")){%>checked<%}%>><font color="#009900">休日出勤</font><font color="#CC6600">申請書</font> &nbsp;
					<input type="radio" name="kind_pg"  value="4" onClick="fellowLine()"  onfocus="this.blur()" <%if(gotopage.equals("4")){%>checked<%}%>><font color="#009900">休日出勤</font><font color="#CC6600">報告書</font>		    
		    	</td>
		      </tr>	 
<!--			<tr height=26>							
		        <td height="10" width="17%"><img src="<%=urlPage%>rms/image/icon_s.gif"><b>段階選択</b></td>
		    	<td height="10" width="83%" bgcolor="#ffffff">
		    		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
						<select name="lineCnt" class="select_type3" onChange="return doSubmitOnEnter();">		
					<%for(int i=1;i<=lineCnt;i++){%>		
							<option value="<%=i%>" <%if(i==lineCnt){%>selected<%}%> ><%=i%>段階</option>
					<%}%>
						</select>
					</div>	
						<font color="#807265">(▷ラインの段階を作る)</font>		    
		    	</td>
		      </tr>	
<-->		 		       
		      <tr> 
		        <td height="10" width="17%"><img src="<%=urlPage%>rms/image/icon_s.gif"><b>職名(階級)選択</b></td>
		    	<td height="10" width="83%" bgcolor="#ffffff">		    				
						<table width="100%" border="0" cellspacing="0" cellpadding="0">					
						   <tr> 
					<%for(int i=1;i<=lineCnt;i++){%>
						        <td height="10" width="20%">
						        	<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>						        	
						        	<tr>
						        		<td align="">
						        	<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 5 0;">
										<select name="signupTile" onChange="emailserv()" >									
											<option value="社長" >社長</option>												
											<option value="事業本部長" >事業本部長</option>								
											<option value="部長" >部長</option>
											<option value="管理部長" >管理部長</option>
											<option value="課長" >課長</option>	
											<option value=" " >自分が書く</option>											
										</select>
									</div>
									
									<div id="show_<%=i%>" style="display:none;overflow:hidden ;width:90;" >	
											<input type="text" size="2" name='signup_position' class="box" value=""  maxlength="20" style="width:89px">
									</div>
						        		</td>
						        	</tr>						        	
						        	</table>
						        </td>
					<%}%>
								<td height="10" width="20%">
						        	<table width="100%" border=0 cellpadding=0 cellspacing=0 >						        	
						        	<tr>
						        		<td align="center" style="padding:4 0 4 0">	申請者 </td>
						        	</tr>						        	
						        	</table>
						        </td>
							</tr>	        						
		    			</table>
		    	</td>
		      </tr>	 
		      <tr height=26>							
		        <td height="10" width="17%"><img src="<%=urlPage%>rms/image/icon_s.gif"><b>決裁者選択</b></td>
		        <td height="10" width="83%" bgcolor="#ffffff">
					<table width="100%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>								
									<tr>
					<%for(int i=1;i<=lineCnt;i++){%>
						        		<td align="center" width="20%">
						        		<div  class="f_left" style="padding:2px;background:#EFEBE0;margin:0px 0px 0 0;">				
											<select name="signup_mseq" class=""  >
												<option value="0">...選択...</option>											
								<c:if test="${! empty  listSign}">
									<%	int ii=1;
										Iterator listiter=listSign.iterator();					
											while (listiter.hasNext()){
											Member mem2=(Member)listiter.next();
											String memId=mem2.getMember_id();
																
									%>					
												<option value="<%=mem2.getMseq()%>" <%if(memId.equals("moriyama")){%>selected<%}%> ><%=mem2.getNm()%></option>	
									<%ii++;}%>	
								</c:if>
								<c:if test="${empty listSign}">
									--
								</c:if>		
										</select>
										</div>	
						        		</td>
						 <%}%>       		
						 				<td align="center"width="20%"  style="padding:4 0 4 0"><%=name%></td>
						        	</tr>
						 
					</table>
				</td>
		      </tr>	       
			</table>
		</td>	
	</tr>
	<tr>
	  <td  align="center" style="padding:10 0 0 0">
	  	<a href="javascript:goWrite();"><img src="<%=urlPage%>rms/image/admin/btn_apply.gif" align="absmiddle"></a>
	  	<a href="javascript:cateReset()"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btnKomokuX.gif" align="absmiddle"></a>
	  	<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/btn_pop_close.gif" align="absmiddle"></a>	  	
	  </td>
	</tr>
</form>
</table>
</center>
<script language='JavaScript'>
/*function doSubmitOnEnter(){
	var frm=document.frm;
	
	var kindpg="";
	if(document.getElementsByName("kind_pg")[0].checked == true){
		kindpg="1";
	}else if(document.getElementsByName("kind_pg")[1].checked == true){ 
		kindpg="2";
	}else if(document.getElementsByName("kind_pg")[2].checked == true){ 
		kindpg="3";
	}else if(document.getElementsByName("kind_pg")[3].checked == true){ 
		kindpg="4";
	}
	
	frm.gotopage.value=kindpg;	
	frm.lineCntVal.value=frm.lineCnt.value;	
	frm.seq_holiBogo.value=frm.seq_holiBogo.value;
	frm.kind_pg_write.value=frm.kind_pg_write.value;	
	frm.action = "<%=urlPage%>rms/admin/hokoku/signupLine/signAdd_pop.jsp";	
	frm.submit();
}
*/
function fellowLine(){
	var frm=document.frm;
	var line="";
	var kindpg="";
	if(document.getElementsByName("kind_pg")[0].checked == true){
		line="2";kindpg="1";
	}else if(document.getElementsByName("kind_pg")[1].checked == true){ 
		line="2";kindpg="2";
	}else if(document.getElementsByName("kind_pg")[2].checked == true){ 
		line="4";kindpg="3";
	}else if(document.getElementsByName("kind_pg")[3].checked == true){ 
		line="4";kindpg="4";
	}
	
	frm.gotopage.value=kindpg;	
	frm.lineCntVal.value=line;	
	frm.seq_holiBogo.value=frm.seq_holiBogo.value;
	frm.kind_pg_write.value=frm.kind_pg_write.value;	
	frm.action = "<%=urlPage%>rms/admin/hokoku/signupLine/signAdd_pop.jsp";	
	frm.submit();
 }
 
 


function cateReset() {
  document.formcategory.reset();	 
	
}



</script>
