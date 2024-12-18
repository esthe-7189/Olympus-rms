<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.kaigi.DataBean" %>
<%@ page import = "mira.kaigi.DataMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>
	
<jsp:useBean id="schedule" class="mira.kaigi.DataBean">
    <jsp:setProperty name="schedule" property="*" />
</jsp:useBean>

<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("kaigi")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
MemberManager member=MemberManager.getInstance();
String urlPage=request.getContextPath()+"/";
String fellow_yn=request.getParameter("fellow_yn");
String fellow2_yn=request.getParameter("fellow2_yn");
String pg=request.getParameter("pg");
String monthVal=request.getParameter("monthVal");
String yearVal=request.getParameter("yearVal");
int count=0; int cnt=0; int cnt2=0;
DataMgr manager = DataMgr.getInstance();	
schedule.setRegister(new Timestamp(System.currentTimeMillis()) );
manager.insertDbSchedule(schedule);	
	
if(fellow_yn.equals("1")){
	if (request.getParameter("sansekisha1") != null){	
		String sansekisha1[]=request.getParameterValues("sansekisha1"); 
		cnt=sansekisha1.length;	
		count=manager.getIdSeq("kaigi");
		for(int i=0; i<cnt;i++){		
			Member memTop=member.getDbMseq(Integer.parseInt(sansekisha1[i]));		
			schedule.setKaigi_seq(count);
			schedule.setMseq(Integer.parseInt(sansekisha1[i]));
			schedule.setNm_sanseki(memTop.getNm());
			manager.insertDbFellow(schedule);
		}
	}	
}
if(fellow2_yn.equals("1")){
	if (request.getParameter("sansekisha2") != null){		
		String sansekisha2=request.getParameter("sansekisha2"); 
		count=manager.getIdSeq("kaigi");
			schedule.setKaigi_seq(count);
			schedule.setMseq(0);
			schedule.setNm_sanseki(sansekisha2);
			manager.insertDbFellow(schedule);
		
		
	/*	
		String sansekisha2[]=request.getParameterValues("sansekisha2"); 	
		cnt2=sansekisha2.length;			
		count=manager.getIdSeq("kaigi");
		for(int i=0; i<cnt2;i++){
			schedule.setKaigi_seq(count);
			schedule.setMseq(0);
			schedule.setNm_sanseki(sansekisha2[i]);
			manager.insertDbFellow(schedule);
		}
	*/	
			
	}
}

if(pg.equals("list")){
%>
<script language="JavaScript">
	alert("書き済みました。");
  	parent.document.location.href = "<%=urlPage%>kaigi/admin/schedule/listForm.jsp?month=<%=monthVal%>&year=<%=yearVal%>&action=0";	
	parent.document.getElementById('qPop').style.display = 'none';
</script>

<%}else if(pg.equals("cal")){%>
	<script language="JavaScript">
		alert("書き済みました。<%=cnt2%>");
	  	parent.document.location.href = "<%=urlPage%>kaigi/admin/schedule/monthForm.jsp?month=<%=monthVal%>&year=<%=yearVal%>&action=0";	
		parent.document.getElementById('qPop').style.display = 'none';
	</script>
<%}%>
	
















