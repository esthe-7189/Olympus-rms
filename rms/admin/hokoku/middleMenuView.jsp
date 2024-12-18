<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>

<%	
String urlPage=request.getContextPath()+"/";
String id=(String)session.getAttribute("ID");

String title= ""; String name=""; String mailadd=""; String pass=""; String position=""; String busho="";
int mseq=0; int level=0; int dbPosiLevel=0; int lineCnt=0; 

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
//부서별 출력
String bushopg=request.getParameter("bushopg");
if(bushopg==null){bushopg="1";}
String bushoVal="";
	 if(id.equals("moriyama") || id.equals("juc0318") || id.equals("admin")){	
		 bushoVal=bushopg;	
	}else{
		bushoVal=busho;
	}	
%>
<script type="text/javascript">
// 카테고리 코드 가져오기
function checkCode(seq){		
	openNoScrollWin("<%=urlPage%>rms/admin/hokoku/signupLine/signAdd_pop.jsp", "signAdd", "signAdd", "500", "350","");
}
					    	
</script>		
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="出張決裁書" onClick="javascript:goJump('<%=bushoVal%>');">	
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="出張報告書" onClick="javascript:goJumpTripBogo('<%=bushoVal%>');">
	<% if(busho.equals("0") || busho.equals("1") || busho.equals("2") || busho.equals("4")){%>
		<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="休日出勤申請書/報告書" onClick="javascript:goJumpHoliBogo('<%=bushoVal%>');">
	<%}%>	
			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="決裁ライン" onClick="javascript:checkCode('<%=bushoVal%>');">	
    	