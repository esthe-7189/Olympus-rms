<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%  String castleJSPVersionBaseDir = "/rms/hoan-jsp"; %>
<%@ include file = "/rms/hoan-jsp/castle_policy.jsp" %>
<%@ include file = "/rms/hoan-jsp/castle_referee.jsp" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "java.sql.Timestamp" %>

	
<jsp:useBean id="kintai" class="mira.schedule.DataBean">
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
String cntSchedule=request.getParameter("cntSchedule");

int count=0; 

DataMgr manager = DataMgr.getInstance();	
DataBean beanVal;
count = Integer.parseInt(cntSchedule);  
	
	if(count==1){
		String during_begin=request.getParameter("during_begin");
		String title=request.getParameter("title");
			beanVal=manager.getHoriday(during_begin);
			if(beanVal==null){
				kintai.setDuring_begin(during_begin);
				kintai.setTitle(title);				
				manager.insertHori(kintai);	
			}else{
	%>
		<script language="JavaScript">
			alert("<%=during_begin%>の日付は既に (<%=beanVal.getTitle()%>)で登録されておりますので、修正ページにて編集して下さい");
		  	location.href = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";		
		</script>
	<%		
			}		
	}else if(count>1){
		String [] during_begin=request.getParameterValues("during_begin");	
		String [] title=request.getParameterValues("title");	
		for(int nt=0; nt<during_begin.length;nt++){	
			beanVal=manager.getHoriday(during_begin[nt]);
			if(beanVal==null){
				kintai.setDuring_begin(during_begin[nt]);
				kintai.setTitle(title[nt]);								
				manager.insertHori(kintai);	
			}else{
	%>
		<script language="JavaScript">
			alert("<%=during_begin[nt]%>の日付は既に(<%=beanVal.getTitle()%>)で登録されておりますので、修正ページにて編集して下さい");
		  	location.href = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";		
		</script>
	<%		
			}			
		}	
}			
	
							
%>
	<script language="JavaScript">
		alert("登録完了!!");
	  	location.href = "<%=urlPage%>rms/admin/schedule/horiForm.jsp";		
	</script>

	
<script type="text/javascript" src="<%=urlPage%>rms/hoan-jsp/castle.js"></script>

















