<%@ page contentType = "text/html; charset=utf-8"  import="java.util.*"%>
<%@ page pageEncoding = "utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "mira.board.Board" %>
<%@ page import = "mira.board.BoardManager" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>

<%! SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");	%>
<%
String today=formatter.format(new java.util.Date());	
String urlPage=request.getContextPath()+"/rms/";
String urlPage2=request.getContextPath()+"/";	
String urlPageOrms=request.getContextPath()+"/orms/";
String memberId=(String)session.getAttribute("ID");
String pg=request.getParameter("pg");
String kindboard = request.getParameter("kindboard");	
if(pg==null) pg="cWrite";
String ip_info=(String)request.getRemoteAddr();
String parentId = request.getParameter("parentId");	
String title = ""; String conRe="";  String nameWrot=""; int mailyn=0;

 Member member=null;
	if (memberId !=null)	{	
		MemberManager manager2=MemberManager.getInstance();
		member=manager2.getMember(memberId);
		nameWrot=member.getNm();		
	}
	   	
    Board board = null;
    if (parentId != null) {
        BoardManager manager = BoardManager.getInstance();
        board = manager.select(Integer.parseInt(parentId));    
         
        if (board != null) {
            title = ":"+board.getTitle();  
            mailyn=board.getMail_yn();                    
            conRe="<br><br><br>"+
            	board.getLevel()+">["+board.getName()+"]===================================<br>"
            +board.getContent()+ "<br>";        
        }
 }

	
%>
<c:set var="board" value="<%= board %>" />
<c:set var="member" value="<%=member%>"/>
<script language="JavaScript">
//이메일 직접 입력
function emailserv(){
  var frm = document.memberInput;
  var value = frm.email2.value;
  if( value == "etc")  {
    emailservEtc();
  }
  return;
}

function emailservEtc() {
  var urlname = "<%=urlPage%>admin/board/pop_email.jsp";
  addr_etc = window.open(urlname, "win1","status=no,resizable=no,menubar=no,scrollbars=no,width=430,height=340");
  addr_etc.focus();
}

function goWrite(){	
var frm=document.memberInput;
	if(isEmpty(frm.title, "タイトルを書いて下さい")) return ;
	if(isEmpty(frm.name, "お名前を入力してください")) return ;	 

	if(frm.mail_yn[0].checked == true){		
		if(isEmpty(frm.email1, "ご連絡先Eメールアドレスを入力してください")) return ;
		if(!isVaildMail(frm.email1.value+frm.email2.value)) { window.alert("使えるE-mailを正確に書いて下さい。特殊文字は避けてください");return ;}
		  if(frm.email1.value.substring(frm.email1.value.lastIndexOf("@"))){
		    if (frm.email1.value.substring(frm.email1.value.lastIndexOf("@")).search("@") != -1){alert("'@'を抜いてください"); return ; }
		  }
		  frm.mail_address.value=frm.email1.value+frm.email2.value;	  
	}else{frm.mail_address.value="nodata@nodata";}
	
	if ( confirm("登録しますか?") != 1 ) {
		return;
	}
frm.action = "<%=urlPage%>admin/board/add.jsp";	
frm.submit();	
}

function goInit(){
	var frm = document.memberInput;
	frm.reset();
}	
</script>

<img src="<%=urlPage%>image/icon_ball.gif" >
<img src="<%=urlPage%>image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
<img src="<%=urlPage%>image/icon_ball.gif" style="filter:Alpha(Opacity=30);">
<span class="calendar7">
<%if(kindboard.equals("1")){%>
	5S 掲示板 
<%}else if(kindboard.equals("2")){%>
	製造 掲示板	
<%}else if(kindboard.equals("3")){%>		
	品質 掲示板
<%}%>				
<font color="#A2A2A2">></font>書く</span> 
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<%if(pg.equals("cWrite")){%>
    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="   目録   >>"   onClick="location.href='<%=urlPage%>admin/board/listForm.jsp?kindboard=<%=kindboard%>'">    
    <%}else if(pg.equals("cRe")){%>
    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="   目録   >>" onClick="location.href='<%=urlPage%>admin/board/listForm.jsp?kindboard=<%=kindboard%>'">
    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="   書く   >>" onClick="location.href='<%=urlPage%>admin/board/addForm.jsp?kindboard=<%=kindboard%>'">	
    <%}%>    
</div>
	
	
<!-- 내용 시작 *****************************************************************-->
	
<table width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
	<tr  height=26>
    		<td  class="clear_dot">   
    	 <%if(pg.equals("cWrite")){%>
    			<img src="<%=urlPageOrms%>images/common/jirusi.gif"  align="absmiddle">  書く    
    	<%}else if(pg.equals("cRe")){%>
    			<img src="<%=urlPageOrms%>images/common/jirusi.gif"  align="absmiddle">返事する    	
    	<%}%>
    		</td> 
	</tr>	
</table>

<table width="80%" class="box_100" cellspacing="2" cellpadding="2" >	
	<form name="memberInput" action="<%=urlPage%>admin/board/add.jsp" method="post"  onSubmit="" >
	<c:if test="${! empty board}">
		<input type="hidden" name="bseq" value="${board.bseq}">	
	</c:if>
	<c:if test="${empty board}">
		<input type="hidden" name="bseq" value="0">	
	</c:if>
	<c:if test="${! empty member}">
		<input type="hidden" name="mseq" value="${member.mseq}">	
	</c:if>
	<c:if test="${empty member}">
		<input type="hidden" name="mseq" value="0">	
	</c:if>
	<c:if test="${! empty param.groupId}">
		<input type="hidden" name="groupId" value="${param.groupId}">
	</c:if>
	<c:if test ="${! empty param.parentId}">
		<input type="hidden" name="parentId" value="${param.parentId}">
	</c:if>	
		<input type="hidden" name="mail_address" value="">			
		<input type="hidden" name="hit_cnt" value="0">						
		<input type="hidden" name="level" value="${board.level + 1}">
		<input type="hidden" name="add_ip" value="<%=ip_info%>">		
		<input type="hidden" name="view_yn" value="1">
		<input type="hidden" name="kindboard" value="<%=kindboard%>">	
		<input type="hidden" name="kind" value="<%=kindboard%>"> <!--1사내게시판, 2제조품질 게시판, 3OT-Orms연락사항 -->
	<tr >
		<td  width="13%" class="cho_06" style="padding: 3 3 3 8">Title</td>
		<td width="1%" class="cho_06" style="padding: 3 3 3 3">:</td>
		<td width="86%" style="padding: 3 3 3 3">
			<input type="text" NAME="title"  VALUE="<%=title%>"  maxlength="120"  class="input02" style="width:400px">
				<font color="#807265">(▷100字まで)</font>		
		</td>	
	</tr>
	<tr><td  background="<%=urlPage%>image/dot_line_all.gif" colspan="3"><td></tr>
	<tr >
		<td  width="13%" class="cho_06" style="padding: 3 3 3 8">Name</td>
		<td width="1%" class="cho_06" style="padding: 3 3 3 3">:</td>
		<td width="86%" style="padding: 3 3 3 3"><input type="text" name="name" value="<%=member.getNm()%>" size="40" maxlength="50" class="input02" style="width:150px"></td>		
	</tr>
	<tr><td  background="<%=urlPage%>image/dot_line_all.gif" colspan="3"><td></tr>
	<tr >
		<td  width="13%" class="cho_06" style="padding: 3 3 3 8">メール返事</td>
		<td width="1%" class="cho_06" style="padding: 3 3 3 3">:</td>
		<td width="86%" style="padding: 3 3 3 3">
<c:if test="${! empty board}">
			<input type="radio" name="mail_yn" value="1" onClick="show01()" onfocus="this.blur()" <c:if test="${board.mail_yn==1}">checked </c:if>><font  color="#FF6600">もらう</font>
			<input type="radio" name="mail_yn" value="2" onClick="show02()" onfocus="this.blur()"  <c:if test="${board.mail_yn==2}">checked </c:if>><font  color="#FF6600">もらわない</font><br>
</c:if>
<c:if test="${empty board}">
			<input type="radio" name="mail_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">もらう</font>
			<input type="radio" name="mail_yn" value="2" onClick="show02()" onfocus="this.blur()" checked ><font  color="#FF6600">もらわない</font><br>
</c:if>
	
	
		 <div id="show" style="display:none;">					
	<%	int cnt=0;
		String [] mailNm={"a","b"};
		String tokenMailNm=member.getMail_address();
		StringTokenizer st = new StringTokenizer(tokenMailNm,"@");
			while (st.hasMoreTokens()) {
					mailNm[cnt]=st.nextToken("@");
					cnt++;
				}
		String mail1=mailNm[0];
		String mail2=mailNm[1];				
	%>	
				<input type="text" name="email1"  value="<%=mail1%>" onChange="emailserv()" maxlength="17" class="input02" style="width:90px;ime-mode:disabled"> @
					<select name="email2" onchange="emailserv()">																																			
						<option value="@ot.olympus.co.jp" <%if(mail2.equals("ot.olympus.co.jp") ){%> selected<%}%>>ot.olympus.co.jp</option>
						<option value="@olympus-rms.co.jp" <%if(mail2.equals("olympus-rms.co.jp")){%> selected<%}%>>olympus-rms.co.jp</option>
						<option value="@swcell.com" <%if(mail2.equals("swcell.com")){%> selected<%}%>>swcell.com</option>
						<option value="@naver.com" <%if(mail2.equals("naver.com")){%> selected<%}%>>naver.com</option>
						<option value="@hotmail.com" <%if(mail2.equals("hotmail.com")){%> selected<%}%>>hotmail.com</option>
						<option value="@yahoo.co.kr" <%if(mail2.equals("yahoo.co.kr")){%> selected<%}%>>yahoo.co.kr</option>						
						<option value="@<%=mail2%>" <%if(mail2.equals(mail2)){%> selected<%}%>><%=mail2%></option>
						<option value="etc">直接入力</option>	
					</select>		
				</div>	
		</td>		
	</tr>
	<tr height="1"><td bgcolor="#99CC00" colspan="3"><td></tr>
	<tr >
		<td  width="100%" style="padding: 20 3 20 15" colspan="6" >
			<textarea id="content" name="content" style="width:100%;height:200px;"></textarea>

<script type="text/javascript">
//<![CDATA[
CKEDITOR.replace( 'content', {
	customConfig : '<%=urlPage2%>ckeditor/config.js',   	
   	width: '100%',
   	height: '300px'
} );
//]]>
</script>							

		</td>	
	</tr>
	<tr height="1"><td bgcolor="#99CC00" colspan="6"><td></tr>	
</table>
 <p>
<table align=center>									   
	<tr align="center">
			<td >	
				<A HREF="JavaScript:goWrite()"><img src="<%=urlPage%>image/admin/btn_apply.gif"></A>	
			</td>			
	</tr>
</form>
</table>			
<script type="text/javascript">
function show01(){	document.getElementById("show").style.display=''; }
function show02(){	document.getElementById("show").style.display='none'; }
</script> 