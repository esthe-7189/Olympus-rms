<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.tokubetu.Member" %>
<%@ page import = "mira.tokubetu.MemberManager" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "mira.contract.DownMgr" %>
<%@ page import = "mira.contract.Category" %>
<%@ page import = "mira.contract.CateMgr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "org.apache.poi.*" %>

<%! 
//static int PAGE_SIZE=20; 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%	
String kind=(String)session.getAttribute("KIND");
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");

if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
        
	int level_mem=0;int mseq=0;
	MemberManager managermem=MemberManager.getInstance();
	Member member=managermem.getMember(id);
	if(member!=null){
		level_mem=member.getLevel();
		mseq=member.getMseq();
	}

	String today=dateFormat.format(new java.util.Date());	
	ContractMgr manager=ContractMgr.getInstance();			
	List  list=manager.listExcel();		
	Member memseq=null;   
	int pageArrowCon=0;
	if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin") || id.equals("hamano") || id.equals("funakubo")){ pageArrowCon=1;	}else{pageArrowCon=2;}
	
%>
<c:set var="list" value="<%= list %>" />	
<c:set var="pageArrowCon" value="<%= pageArrowCon %>" />
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
function printExplain(){		
	openNoScrollWin("<%=urlPage%>tokubetu/admin/printExplain_pop.jsp", "print", "print", "730", "585","");
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center"  onLoad="javascript:resize('730','600') ;">
<center>

	<table width="100%"  border="0" cellpadding=1 cellspacing=0 >
			<tr>
				<td align="center"  class="calendar15" style="padding: 10px 0px 0px 0px">契約書一覧</td>							
			</tr>		
	</table>
<table width="98%"  border=0 >
	<tr>
		<td align="right" >
<input type="button" class="cc" onClick="printExplain();" onfocus="this.blur();" style=cursor:pointer value=" 印刷方法 >>">
<input type="button" class="cc" onClick="printa();" onfocus="this.blur();" style=cursor:pointer value=" 印刷 >>">
<input type="button" class="cc" onClick="window.close();" onfocus="this.blur();" style=cursor:pointer value=" 閉じる >>">
		</td>							
	</tr>		
</table>
<table width="98%"  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#000000>
	<tr bgcolor=#F1F1F1 align=center height=29>	
	    <td width="7%">管理No.</td>	    
	　 <td width="6%">契約形態</td>		    
	    <td  width="12%">契約内容</td>
	    <td  width="12%">タイトル</td>
	    <td  width="16%">契約先</td>
	    <td  width="8%">契約日</td>
	    <td  width="18%">
		<table width=100% 　cellpadding="0" cellspacing="0" >
			<tr bgcolor=#F1F1F1 align=center height=14>	
				<td  align="center" colspan="2" >契約期間</td>				
			</tr>
			<tr bgcolor=#F1F1F1 align=center height=15>	
				<td >開始</td>
				<td >終了</td>
			</tr>		
		</table>	
		</td>    
	    <td  width="7%">更新</td>	
	    <td  width="7%">担当者</td>		   		
  	    <td  width="8%">契約書</td>						
	</tr>	
	</tr>
<c:if test="${empty list}">
				<td colspan="10" >---</td>			
</c:if>
<c:if test="${! empty list}">
<%
int i=1; String conCode=""; int conCodeInt=0; int kubunVal=0;
Iterator listiter=list.iterator();
	while (listiter.hasNext()){				
		ContractBeen db=(ContractBeen)listiter.next();
		int seq=db.getBseq();
		String aadd=dateFormat.format(db.getRegister());
		int mseqDb=db.getMseq();
		int getLevel=db.getLevel();		
		conCode=db.getKanri_no();       
		kubunVal=db.getKubun_bseq(); 								
		
		if(pageArrowCon==1){	   
%>				
	<tr>	    
	    <td><%=conCode%> </td>
	    <td><%=db.getContract_kind()%></td>	    	     
	    <td><%=db.getContent()%></td>
	    <td><%if(db.getTitle()!=null){%><%=db.getTitle()%><%}else{%>-<%}%></td>
	    <td><%=db.getContact()%></td>
	    <td  align="center" ><%=db.getHizuke()%></td>
	    <td>
	    		<table width=100% cellpadding="0" cellspacing="0">
			<tr height=24 bgcolor=#F1F1F1 align=center >	
				<td  align="center" ><font color="#007AC3"><%=db.getDate_begin()%></font></td>
				<td  align="center" ><%=db.getDate_end()%></td>				
			</tr>			
			</table>	
	    </td>    
	    <td><%=db.getRenewal()%></td>	
	    <td><%if(db.getSekining_nm()!=null){%><%=db.getSekining_nm()%><%}else{%>&nbsp;<%}%>  </td>		    
	    <td><%if(db.getFile_nm().equals("")){%>-<%}else{%><%=db.getFile_nm()%><%}%></td></tr>
<%}%>								
<% if(pageArrowCon==2){%>								
	<% if(kubunVal!=1){%>				
	<tr>	    
	    <td><%=conCode%></td>
	    <td>	<%=db.getContract_kind()%>  </td>	    	     
	    <td><%=db.getContent()%></td>
	    <td><%if(db.getTitle()!=null){%><%=db.getTitle()%><%}else{%>-<%}%>   </td>
	    <td><%=db.getContact()%></td>
	    <td  align="center" ><%=db.getHizuke()%></td>
	    <td>
	    		<table width=100% cellpadding="0" cellspacing="0">
			<tr height=24 bgcolor=#F1F1F1 align=center >	
				<td  align="center" ><font color="#007AC3"><%=db.getDate_begin()%></font></td>
				<td  align="center" ><%=db.getDate_end()%></td>				
			</tr>			
			</table>	
	    </td>    
	    <td><%=db.getRenewal()%></td>	
	    <td><%if(db.getSekining_nm()!=null){%><%=db.getSekining_nm()%><%}else{%>&nbsp;<%}%>   </td>		    	    	    	    
	    <td><%if(db.getFile_nm().equals("")){%>-<%}else{%><%=db.getFile_nm()%><%}%> </td>	    	    
	</tr>			
<% }}
i++;	
}
%>				
</c:if>
</table>
<table width="100%"  border=0 >
	<tr>
		<td align="right" >
<!--*******>
<a href="javascript:printExplain();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintPreview.gif" align="absmiddle" title="手動的操作：マウスを画面の上に置き、マウスの右をクリックし==>(N)をクリック"></a>	
<a href="javascript:printa();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/pintBogoForm.gif" align="absmiddle"></a>
<a href="javascript:window.close();"  onfocus="this.blur()"><img src="<%=urlPage%>rms/image/admin/xBogoForm.gif" align="absmiddle"></a>
<********-->	
<input type="button" class="cc" onClick="printExplain();" onfocus="this.blur();" style=cursor:pointer value=" 印刷方法 >>">
<input type="button" class="cc" onClick="printa();" onfocus="this.blur();" style=cursor:pointer value=" 印刷 >>">
<input type="button" class="cc" onClick="window.close();" onfocus="this.blur();" style=cursor:pointer value=" 閉じる >>">
		</td>							
	</tr>		
</table>
			
<script language="javascript">
/*
function ieExecWB( intOLEcmd, intOLEparam )
{var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
if ( ( ! intOLEparam ) || ( intOLEparam < -1 ) || (intOLEparam > 1 ) )
intOLEparam = 1;
WebBrowser1.ExecWB( intOLEcmd, intOLEparam );
WebBrowser1.outerHTML = "";
}
*/
</script>				
</body>
</html>													