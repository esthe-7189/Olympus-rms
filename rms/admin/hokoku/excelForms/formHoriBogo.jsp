<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrHoliHokoku" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
String id=(String)session.getAttribute("ID");
String kind=(String)session.getAttribute("KIND");

String title= ""; String name=""; String mailadd=""; 
String pass=""; String position=""; String busho="";
int mseq=0; int level=0; int dbPosiLevel=0; 
	

	MemberManager mem = MemberManager.getInstance();	
	Member member=mem.getMember(id);
	if(member!=null){
		 level=member.getLevel(); 
		 name=member.getNm();
		 mailadd=member.getMail_address();
		 pass=member.getPassword();
		 mseq=member.getMseq();
		 position=member.getPosition();
		 busho=member.getBusho();
		 dbPosiLevel=member.getPosition_level();
	}	

if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
/*    response.setHeader("Content-Disposition", "attachment; filename=ormsexcel.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data"); 
*/

   String urlPage=request.getContextPath()+"/";
	String seq=request.getParameter("fno");
	
	DataMgrHoliHokoku manager = DataMgrHoliHokoku.getInstance();	
	DataBeanHokoku pdb=manager.getDbPrint(Integer.parseInt(seq));
	int or_seq=pdb.getSeq();
	int totalHHMM=(pdb.getRest_end_hh()*60+pdb.getRest_end_mm())-(pdb.getRest_begin_hh()*60+pdb.getRest_begin_mm());
	int resultHH=totalHHMM/60;
	int resultMM=totalHHMM%60;	
	int totalHHMM2=(pdb.getPlan_end_hh()*60+pdb.getPlan_end_mm())-(pdb.getPlan_begin_hh()*60+pdb.getPlan_begin_mm());
	int resultHH2=totalHHMM2/60;
	int resultMM2=totalHHMM2%60;						
	String bushoDb=pdb.getBusho();
	
	Member memSign;
%>
<c:set var="member" value="<%=member%>"/>
<c:set var="pdb" value="<%=pdb%>"/>


	
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

function printa(){
	window.print();
}

</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('595','860') ;">
<center>
<c:if test="${empty pdb}">
	<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr>
				<td align="center" bgcolor="#ffffff" colspan="4" class="calendar15" style="padding: 5 0 3 0">休日出勤申請書</td>							
			</tr>		
	</table>
</c:if>
<table width="98%"  border=0 >
			<tr>
				<td align="center" class="calendarLarge" style="padding: 5 0 0 0">休日出勤申請書</td>							
			</tr>		
</table>			
<table width="98%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<form name="frm">
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 5 5 2 5">				
<!-----content start--------->			
<table width="98%"  border="0" >			
			<tr>
				<td align="right" bgcolor="#ffffff" colspan="4" style="padding: 2 2 2 0">
						<table width="45%"  border=0 >
								<tr>
									<td align="right" class="calendar15" style="padding:2 15 0 0">オリンパスＲＭＳ株式会社</td>							
								</tr>
								<tr>
									<td align="right" bgcolor="#ffffff" style="padding:2 15 0 0"><%=dateFormat.format(pdb.getRegister())%></td>	
								</tr>		
						</table>						
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" >
		<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			<tr height="29" >			
				<td align="center" bgcolor="#f7f7f7" width="15%" >所 属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(bushoDb.equals("4")){%>その他<%}%>
					<% if(bushoDb.equals("0")){%>経営役員<%}%>		
					<% if(bushoDb.equals("1")){%>品質管理部<%}%>
					<% if(bushoDb.equals("2")){%>製造部<%}%>
					<% if(bushoDb.equals("3")){%>管理部<%}%>	
					<% if(bushoDb.equals("no data")){%>その他<%}%>
				</td>
				<td align="center" bgcolor="#f7f7f7" width="15%">氏 名</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdb.getNm()%></td>
    		</tr>
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2 0 2 10">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">月 日</td>
				<td bgcolor="#ffffff" colspan="3"><%=pdb.getTheday()%></td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">予定時間</td>
				<td bgcolor="#ffffff" colspan="3">
					<%=pdb.getPlan_begin_hh()%>時<%=pdb.getPlan_begin_mm()%>分<font color="#009900">～</font><%=pdb.getPlan_end_hh()%>時<%=pdb.getPlan_end_mm()%>分
					（<%=resultHH2%>時 <%=resultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td bgcolor="#ffffff" colspan="3"> 				
					<%=pdb.getRest_begin_hh()%>時<%=pdb.getRest_begin_mm()%>分<font color="#009900">～</font><%=pdb.getRest_end_hh()%>時<%=pdb.getRest_end_mm()%>分
					（<%=resultHH%>時 <%=resultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td bgcolor="#ffffff" colspan="3"><%=pdb.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td bgcolor="#ffffff" colspan="3"><%=pdb.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2 2 2 0">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>							
						</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2 2 2 0">
						<table width="90%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_boss() !=0){		
			if(pdb.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho() !=0){		
			if(pdb.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_bucho2() !=0){		
			if(pdb.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(pdb.getSign_ok_yn_kanribu() !=0){		
			if(pdb.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(pdb.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(pdb.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=pdb.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(pdb.getMseq()); 
		if(memSign!=null){		
		 if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
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
<!-----content end**************************--------->		
<!-----休日出勤報告書 end**************************--------->	
<p>
<% 	DataBeanHokoku beanBogo=manager.getDbBogo(Integer.parseInt(seq)); %>
<c:set var="beanBogo" value="<%=beanBogo%>"/>			
<c:if test="${! empty beanBogo}">		
<%	int btotalHHMM=(beanBogo.getRest_end_hh()*60+beanBogo.getRest_end_mm())-(beanBogo.getRest_begin_hh()*60+beanBogo.getRest_begin_mm());
	int bresultHH=btotalHHMM/60;
	int bresultMM=btotalHHMM%60;	
	int btotalHHMM2=(beanBogo.getPlan_end_hh()*60+beanBogo.getPlan_end_mm())-(beanBogo.getPlan_begin_hh()*60+beanBogo.getPlan_begin_mm());
	int bresultHH2=btotalHHMM2/60;
	int bresultMM2=btotalHHMM2%60;

%>
<table width="100%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
			<tr>
				<td align="center" bgcolor="#ffffff"  class="calendarLarge" style="padding: 10 0 0 0">休日出勤報告書</td>
			</tr>
			<tr>
				<td align="right" bgcolor="#ffffff" style="padding:2 15 0 0"><%=dateFormat.format(beanBogo.getRegister())%></td>	
			</tr>
	        <tr>
				<td align="center" bgcolor="#ffffff" style="padding: 2 5 10 5">	
<table width="100%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			
    		<tr  height="29">				
				<td align="" bgcolor="#ffffff" colspan="4" style="padding:2 0 2 10">下記の通り休日出勤の申請をします。</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7" width="15%">月 日</td>
				<td bgcolor="#ffffff" colspan="3" width="85%"><%=beanBogo.getTheday()%>	</td>				
			</tr>			
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">実績時間</td>
				<td bgcolor="#ffffff" colspan="3">
					<%=beanBogo.getPlan_begin_hh()%>時<%=beanBogo.getPlan_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getPlan_end_hh()%>時<%=beanBogo.getPlan_end_mm()%>分
					（<%=bresultHH2%>時 <%=bresultMM2%>分）					
				</td>				
			</tr>
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">休憩時間</td>
				<td bgcolor="#ffffff" colspan="3"> 				
					<%=beanBogo.getRest_begin_hh()%>時<%=beanBogo.getRest_begin_mm()%>分<font color="#009900">～</font><%=beanBogo.getRest_end_hh()%>時<%=beanBogo.getRest_end_mm()%>分
					（<%=bresultHH%>時 <%=bresultMM%>分）				
				</td>	
			</tr>					
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">業務内容</td>
				<td bgcolor="#ffffff" colspan="3"><%=beanBogo.getComment()%></td>				
			</tr >		
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">申請理由</td>
				<td bgcolor="#ffffff" colspan="3"><%=beanBogo.getReason()%></td>				
			</tr >				
			<tr  height="29">
				<td align="" bgcolor="#ffffff" colspan="4" >
<table width="100%" border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<tr>	
			<td width="30%" align="" bgcolor="#ffffff" style="padding: 2 2 2 0">
						<table width="65%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>							
						</tr>
						<tr bgcolor="" align=center height="">	
							<td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
						</tr>
					</table>
				</td>				
				<td width="70%" align="right" bgcolor="#ffffff" style="padding: 2 2 2 0">
						<table width="90%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle01()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle02()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle03()%></td>
							<td width="20%" align="center" bgcolor="#f7f7f7"><%=beanBogo.getTitle04()%></td>
							<td width="10%" align="center" bgcolor="#f7f7f7">申請者</td>
						</tr>
						<tr bgcolor="" align=center height="">	
						    <td  align="center" bgcolor="#ffffff">		
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_boss()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_boss() !=0){		
			if(beanBogo.getSign_ok_yn_boss()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_boss()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_boss()%>"><%}%> 
	<%}}else{%>--<%}%>	
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho() !=0){		
			if(beanBogo.getSign_ok_yn_bucho()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_bucho2()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_bucho2() !=0){		
			if(beanBogo.getSign_ok_yn_bucho2()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_bucho2()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_bucho2()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_bucho2()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">
	<%
		memSign=mem.getDbMseq(beanBogo.getSign_ok_mseq_kanribu()); 
		if(memSign!=null){		
		 if(beanBogo.getSign_ok_yn_kanribu() !=0){		
			if(beanBogo.getSign_ok_yn_kanribu()==2 ){%>
				<%if(!memSign.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=memSign.getMimg()%>_40.jpg" align="absmiddle">
				<%}else{%>決裁済<%}%>
			<%}%>
			<%if(beanBogo.getSign_ok_yn_kanribu()==1 ){%><img src="<%=urlPage%>rms/image/admin/icon_miketu.gif"  align="absmiddle" title="(<%=memSign.getNm()%>):決裁中"><%}%> 
			<%if(beanBogo.getSign_ok_yn_kanribu()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="返還理由:(<%=memSign.getNm()%>):<%=beanBogo.getSign_no_riyu_kanribu()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>
							<td  align="center" bgcolor="#ffffff">	
	    <%	
		if(beanBogo.getMimg()!=null){		
		 if(!beanBogo.getMimg().equals("no")){%>
					<img src="<%=urlPage%>rms/image/admin/ingam/<%=beanBogo.getMimg()%>_40.jpg" align="absmiddle">				
			<%}else{%>--		
		<%}}else{%>--<%}%>						
							</td>
						</tr>							
						</table>		
							</td>							
						</tr>							
						</table>
</c:if>	
			
				
		</td>									
	</tr>															
	</table>
	<table width="100%"  border=0 >
				<tr>
					<td align="center" style="padding: 5 0 1 0">
						<a href="javascript:printa();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintBogoForm.gif" align="absmiddle"></a>
						<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/xBogoForm.gif" align="absmiddle"></a>
					</td>							
				</tr>		
	</table>
</form>		
</body>
</html>																		