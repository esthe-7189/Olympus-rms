<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "mira.schedule.DataBean" %>
<%@ page import = "mira.schedule.DataMgr" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>

<%! 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>	
<%	
String urlPage=request.getContextPath()+"/";
String urlPage2=request.getContextPath()+"/orms/";	
String kind=(String)session.getAttribute("KIND");
String id=(String)session.getAttribute("ID");
String inDate=dateFormat.format(new java.util.Date());	


if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
}
   String seq = request.getParameter("seq");    
    DataMgr manager = DataMgr.getInstance();	  
    DataBean bean=manager.getHoridayData(Integer.parseInt(seq));
%>
<c:set var="bean" value="<%= bean%>" />

<style type="text/css">	input.calendar { behavior:url(calendar.htc); } </style>
<script language="javascript">

function formSubmit(frmNm){        
	var frm = document.calform;		 
		 	
      if ( confirm("上の内容を登録しますか?") != 1 ) { return; }	
     	frm.action = "<%=urlPage%>rms/admin/schedule/horiUpdate.jsp";	
	frm.submit(); 
   }   


function goInit(seq){
	var frm=document.calform;
	document.calform.reset();
	frm.seq.value=seq;
	frm.action = "<%=urlPage%>rms/admin/schedule/horiUpdateForm.jsp";
	frm.submit();	
}


</script>		
<img src="<%=urlPage%>rms/image/icon_ball.gif" >
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);"><span class="calendar7">日程管理（スケジュール）<font color="#A2A2A2">></font> 祝日・休日設定 修正</span>
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="リスト" onClick="location.href='<%=urlPage%>rms/admin/schedule/listForm.jsp'">
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="カレンダー" onClick="location.href='<%=urlPage%>rms/admin/schedule/monthForm.jsp'">		
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="祝日・休日設定" onClick="location.href='<%=urlPage%>rms/admin/schedule/horiForm.jsp'">		
</div>
<div id="boxCalendar"  >
	<div class="boxCalendar_80">
<c:if test="${!empty bean}"/>	
<table width="800"  height="29" class="tablebox" >			
<form name="calform" method=post  action="<%=urlPage%>rms/admin/schedule/horiUpdate.jsp">	
	<tbody >	
	<input type="hidden" name="seq" value="${bean.seq}">	 		
	<tr>
		<td bgcolor="#f7f7f7" width="10%"><img src="<%=urlPage%>rms/image/icon_s.gif" >祝日・休日</td>
  		<td width="20%" align="left" ><input type="text" size="13%" name="during_begin" class=calendar value="${bean.during_begin}" style="text-align:center"></td>
  		<td bgcolor="#f7f7f7" width="13%"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル(休日名)</td>
  		<td width="57%" align="left" ><input type=text size="40" class="input02"  name="title" value="${bean.title}" maxlength="40"><font color="#807265">(▷春分の日 / 20文字以下)</font></td>		
	</tr>
	</tbody >											
</table>
<div class="clear"></div>		
 <table  align="center" width="820" border="0" cellspacing="0" cellpadding="0">												
	<tr>				
			<td align="center" style="padding-top:20px ;">
				<a href="JavaScript:formSubmit()"><img src="<%=urlPage2%>images/common/btn_off_submit.gif" ></A>
		<!--		<input type="Button" value="DONE" onclick="JavaScript:formSubmit(this.form)">  -->
				&nbsp;
				<a href="javascript:goInit('${bean.seq}');"><img src="<%=urlPage2%>images/common/btn_off_cancel.gif" ></A>
			</td>			
	</tr>	
</form>				
</table>
	</div>
</div>