<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrTripHokoku" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>

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
	
	DataMgrTripHokoku manager = DataMgrTripHokoku.getInstance();	
	DataBeanHokoku pdb=manager.getDbPrint(Integer.parseInt(seq));
//	List listCon=manager.listCon(Integer.parseInt(seq));
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
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('595','700') ;">
<center>
<c:if test="${empty pdb}">
	<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
			<tr>
				<td align="center" bgcolor="#ffffff" colspan="4" class="calendarLarge" style="padding: 3 0 3 0">出張報告書</td>							
			</tr>		
	</table>
</c:if>
<table width="98%"  border=0 >
			<tr>
				<td align="center" class="calendarLarge" style="padding: 10 0 3 0">出張報告書</td>							
			</tr>		
</table>
<p>		
<table width="98%"  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF >
	<form name="frm">
			<tr>
				<td align="center" bgcolor="#ffffff" style="padding: 5 5 10 5">				
<!-----content start--------->			
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>			
			<tr>
				<td align="right" bgcolor="#ffffff" colspan="4" style="padding: 2 2 2 0">
						<table width="45%"  border=0 >
								<tr>
									<td align="center" class="calendar15" style="padding: 2 0 1 0">オリンパスＲＭＳ株式会社</td>							
								</tr>		
						</table>
						<table width="45%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle01()%></td>
							<td width="35%" align="center" bgcolor="#f7f7f7"><%=pdb.getTitle02()%></td>
							<td width="30%" align="center" bgcolor="#f7f7f7">出張者</td>
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
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="(<%=memSign.getNm()%>):返還理由:<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
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
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="(<%=memSign.getNm()%>):返還理由:<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
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
    	<tr  height="29">
				<td align="center" bgcolor="#f7f7f7" width="15%" >出張者氏名</td>
				<td align="" bgcolor="#ffffff" width="35%"><%=pdb.getNm()%></td>
				<td align="center" bgcolor="#f7f7f7" width="15%">所属</td>		
				<td bgcolor="#ffffff" width="35%">
					<% if(pdb.getBusho().equals("4")){%>その他<%}%>
					<% if(pdb.getBusho().equals("0")){%>経営役員<%}%>		
					<% if(pdb.getBusho().equals("1")){%>品質管理部<%}%>
					<% if(pdb.getBusho().equals("2")){%>製造部<%}%>
					<% if(pdb.getBusho().equals("3")){%>管理部<%}%>	
					<% if(pdb.getBusho().equals("no data")){%>その他<%}%>					
				</td>
    		</tr>
    		<tr  height="29">
				<td align="center" bgcolor="#f7f7f7" >出張先</td>		
				<td bgcolor="#ffffff" colspan="3"><%=pdb.getDestination()%></td>
			</tr>		
    		<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">出張期間</td>
				<td bgcolor="#ffffff" colspan="3"><%=pdb.getDuring_begin()%> ～ <%=pdb.getDuring_end()%></td>				
    		</tr>			
			<tr  height="29">
				<td align="center" bgcolor="#f7f7f7">出張目的</td>
				<td bgcolor="#ffffff" colspan="3"><%=pdb.getReason()%></td>				
			</tr>	
			<tr >
				<td align="" bgcolor="#ffffff" colspan="4">実施事項<br>
					<%=pdb.getComment()%>					
				</td>											
			</tr>									
			<tr>
				<td align="left" bgcolor="#ffffff" colspan="4" style="padding: 2 2 2 0">
						<table width="25%" border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>
						<tr bgcolor="" align=center height="">	
						    <td width="35%" align="center" bgcolor="#f7f7f7">社長</td>
							<td width="35%" align="center" bgcolor="#f7f7f7">事業本部長</td>							
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
			<%if(pdb.getSign_ok_yn_boss()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="(<%=memSign.getNm()%>):返還理由:<%=pdb.getSign_no_riyu_boss()%>"><%}%> 
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
			<%if(pdb.getSign_ok_yn_bucho()==3 ){%><img src="<%=urlPage%>rms/image/admin/btn_singHenkan.gif" align="absmiddle" title="(<%=memSign.getNm()%>):返還理由:<%=pdb.getSign_no_riyu_bucho()%>"><%}%> 
	<%}}else{%>--<%}%>							
							</td>							
						</tr>							
						</table>
				</td>				
			</tr>											
		</table>
		</td>								
	</tr>
	<tr>
		<td>
			<table width="100%"  border=0 >
				<tr>
					<td align="center" style="padding: 2 0 1 0">
						<a href="javascript:printa();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintBogoForm.gif" align="absmiddle"></a>
						<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/xBogoForm.gif" align="absmiddle"></a>
					</td>							
				</tr>		
			</table>
		</td>
	</tr>
</form>																
	</table>
	
</body>
</html>																		