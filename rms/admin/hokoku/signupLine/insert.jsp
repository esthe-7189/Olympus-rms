<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.hokoku.DataBeanHokoku" %>
<%@ page import = "mira.hokoku.DataMgrSignup" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="kintai" class="mira.hokoku.DataBeanHokoku">
    <jsp:setProperty name="kintai" property="*" />
</jsp:useBean>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	
String urlPage=request.getContextPath()+"/";
String lineCnt=request.getParameter("lineCntVal");  
if(lineCnt==null){lineCnt="0";}

String kind_pg=request.getParameter("kind_pg");
if(kind_pg==null){kind_pg="0";}

String kind_pg_write=request.getParameter("kind_pg_write");
if(kind_pg_write==null){kind_pg_write="0";}

String mseq=request.getParameter("mseq");
if(mseq==null){mseq="0";}

String seq_holiBogo=request.getParameter("seq_holiBogo");  
if(seq_holiBogo==null){seq_holiBogo="0";}

int count=0; int seqHokoku=0;

DataMgrSignup manager = DataMgrSignup.getInstance();	
count = Integer.parseInt(lineCnt); 

	//insert전 중복 데이터 삭제	
	int dubleCnt=manager.getDubleSeq(Integer.parseInt(kind_pg),Integer.parseInt(mseq));
if(dubleCnt!=0){
	manager.delBeforeInsert(Integer.parseInt(kind_pg),Integer.parseInt(mseq));
}
	kintai.setRegister(new Timestamp(System.currentTimeMillis()) );	
	manager.insert(kintai);	
	
	seqHokoku=manager.getIdSeq("hokoku_signup_line");
	if(count==1){
		String signup_position=request.getParameter("signup_position");
		String signup_mseq=request.getParameter("signup_mseq");
		
		kintai.setSignupline_seq(seqHokoku);
		kintai.setDestination(signup_position);
		kintai.setSignup_mseq(Integer.parseInt(signup_mseq));
		kintai.setPosition_level(1);					
		manager.insertCon(kintai);	
		
	}else if(count>1){
		String [] signup_position=request.getParameterValues("signup_position");
		String [] signup_mseq=request.getParameterValues("signup_mseq");	
		for(int nt=0; nt<signup_mseq.length;nt++){
			kintai.setSignupline_seq(seqHokoku);
			kintai.setDestination(signup_position[nt]);
			kintai.setSignup_mseq(Integer.parseInt(signup_mseq[nt]));	
			kintai.setPosition_level(nt+1);								
			manager.insertCon(kintai);	
		}	
	}			
		
if(Integer.parseInt(kind_pg)==1 && Integer.parseInt(kind_pg_write)==0){							
%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/listForm.jsp";		
	  	window.close();
	</script>
<%}else if(Integer.parseInt(kind_pg)==2 && Integer.parseInt(kind_pg_write)==0){%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/listTripBogoForm.jsp";		
	  	window.close();
	</script>
<%}else if(Integer.parseInt(kind_pg)==3 && Integer.parseInt(kind_pg_write)==0){%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/listHoliBogoForm.jsp";		
	  	window.close();
	</script>
<%}else if(Integer.parseInt(kind_pg_write)==4){%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/write/writeTripForm.jsp";		
	  	window.close();
	</script>
<%}else if(Integer.parseInt(kind_pg_write)==5){%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/writeTripBogo/writeTripForm.jsp";		
	  	window.close();
	</script>
<%}else if(Integer.parseInt(kind_pg_write)==6){%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/writeTripForm.jsp";		
	  	window.close();
	</script>
<%}else if(Integer.parseInt(kind_pg_write)==7){%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/writeHoliBogo/bogoForm.jsp?fno=<%=seq_holiBogo%>";		
	  	window.close();
	</script>
<%}else if(Integer.parseInt(kind_pg)==0 || Integer.parseInt(kind_pg_write)==0){%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	opener.location.href = "<%=urlPage%>rms/admin/hokoku/listForm.jsp";		
	  	window.close();
	</script>
<%}%>
	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>
















