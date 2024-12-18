<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccDownMgr" %>
<%@ page import = "java.sql.Timestamp" %>

<jsp:useBean id="pds" class="mira.sop.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
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
	String id=(String)session.getAttribute("ID");
	String ip_add=(String)request.getRemoteAddr();
if(id!=null){	
	String password=request.getParameter("pass");	
	String seq=request.getParameter("seq");		
	String filename=request.getParameter("filename");	
	
	AccDownMgr mgrAcc = AccDownMgr.getInstance();
	
	MemberManager manager = MemberManager.getInstance();
	Member mem=manager.getMember(id);	
	int mseq_int=mem.getMseq();	
	int chValue=manager.checkPass(mseq_int,password);	
	if(chValue ==1){				
			pds.setSeq_acc(Integer.parseInt(seq));
			pds.setSeq_mem(mseq_int);
			pds.setRegister(new Timestamp(System.currentTimeMillis()));
			pds.setIp_add(ip_add);
		mgrAcc.insertAccDown(pds);
	%>
		<script language="JavaScript">		
		document.move.action = "<%=urlPage%>rms/admin/sop/down.jsp";		
		document.move.filename.value = <%=filename%>;
		document.move.submit();
		
		</script>

	<%}else if(chValue ==0){%>		
			<script language=javascript>
				alert("パスワードが正しくないです。");
				history.go(-1);
			</script>
		
	<%}else if(chValue ==-1){%>
			<script language=javascript>
				alert("パスワードが存在してないです。");
				history.go(-1);
			</script>
	<%}
}else{%>
<script language="JavaScript">		
	location.href = "<%=urlPage%>rms/member/loginForm.jsp";
</script>

<%}%>
	

<form name="move" method="post">   
    <input type="hidden" name="filename" value="">    
</form>