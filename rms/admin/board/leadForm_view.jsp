<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>
<%@ page import = "mira.board.Board" %>
<%@ page import = "mira.board.BoardManager" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.NumberFormat " %>
<%@ page import = "java.sql.Timestamp" %>
<%! 	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");	
%>
<%			
MemberManager memmgr = MemberManager.getInstance();
	String memberId=(String)session.getAttribute("ID");	
	Member member2=memmgr.getMember(memberId);
	String kind=(String)session.getAttribute("KIND");
	
if(kind!=null && ! kind.equals("bun")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}	
   
	String inDate=dateFormat.format(new java.util.Date());
	String urlPage=request.getContextPath()+"/rms/";
	String urlPageOrms=request.getContextPath()+"/orms/";
	String pg=request.getParameter("pg");
	String bseq=request.getParameter("bseq");		
	String kindboard = request.getParameter("kindboard");	
	
    String title = ""; String name=""; String mailadd="";  int mseq=0; String mail1=""; String mail2=""; 
  //comment     	
	Member member=null;
	if (memberId !=null)	{	
		MemberManager manager2=MemberManager.getInstance();
		member=manager2.getMember(memberId);
		name=member.getNm();
		mailadd=	member.getMail_address();	
		mseq=member.getMseq();
	}
	 Board board = null;    
        BoardManager manager = BoardManager.getInstance();
        board = manager.select(Integer.parseInt(bseq));          	 
   	 int countCom=manager.commentCnt(Integer.parseInt(bseq));  
 
 //Hit
  	manager.hit(Integer.parseInt(bseq));  
  	
 	
	int countCom2=0; 	

%>
<c:set var="board" value="<%= board %>" />
<c:set var="member" value="<%=member%>"/>


<script type="text/javascript"  src="<%=urlPage%>js/ajax.js"></script>

<script type="text/javascript">
	window.onload = function() {
		loadCommentList();
	}
	function loadCommentList() {
		var fseq = document.addForm.bseq.value;			
		var params = "fseq="+encodeURIComponent(fseq);
		new ajax.xhr.Request('commentlist.jsp', params, loadCommentResult, 'POST');
		
	}
	function loadCommentResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var xmlDoc = req.responseXML;
				var code = xmlDoc.getElementsByTagName('code').item(0)
				                 .firstChild.nodeValue;
				if (code == 'success') {
					var commentList = eval( "(" +
					    xmlDoc.getElementsByTagName('data').item(0)
					          .firstChild.nodeValue +
					")" );
					var listDiv = document.getElementById('commentList');
					for (var i = 0 ; i < commentList.length ; i++) {
						var commentDiv = makeCommentView(commentList[i]);
						listDiv.appendChild(commentDiv);
					}
				} else if (code == 'error') {
					var message = xmlDoc.getElementsByTagName('message')
					                    .item(0).firstChild.nodeValue;
					alert("Error 発生:"+message);
				}
			} else {
				alert("コメント失敗"+req.status);
			}
		}
	}
	function makeCommentView(comment) {
		var commentDiv = document.createElement('div');
		commentDiv.setAttribute('id', 'c'+comment.id);
		var html="";		
		var memberIdd=document.addForm.memberId.value;
if(memberIdd!="null"  && comment.memberId==memberIdd){	
		 html = '<table border=\"0\"  cellspacing=\"0\" cellpadding=\"0\" width=\"600\"><tr>'+
			'<td width=\"85%\" height=\"22\" style=\"padding: 0 0 0 10\" bgcolor=\"f4f4f4\" >'+
			'<strong>'+comment.name+'</strong></td>'+
			'<td width=\"15%\" bgcolor=\"f4f4f4\"  class=\"msmall\">['+comment.inDate+']</td></tr><td style=\"padding: 0 0 5 2\">'+
			comment.content.replace(/\n/g, '\n<br/>')+'<br/></td><td align=\"right\" >'+
			'<a href=\"javascript:viewUpdateForm('+comment.id+')\" onfocus=\"this.blur()\"/>'+ 
			'<img src=\"<%=urlPage %>image/admin/btn_cate_pen.gif\"></a>&nbsp;'+
			'<a href=\"javascript:confirmDeletion('+comment.id+')\" onfocus=\"this.blur()\"/>'+ 
			'<img src=\"<%=urlPage%>image/admin/btn_cate_x.gif\"></a></td></tr></table>';
}else{		
			html = '<table border=\"0\"  cellspacing=\"0\" cellpadding=\"0\" width=\"600\"><tr>'+
			'<td width=\"85%\" height=\"22\" style=\"padding: 0 0 0 10\" bgcolor=\"f4f4f4\" >'+
			'<strong>'+comment.name+'</strong></td>'+
			'<td width=\"15%\" bgcolor=\"f4f4f4\"  class=\"msmall\">['+comment.inDate+']</td></tr><td style=\"padding: 0 0 5 2\">'+
			comment.content.replace(/\n/g, '\n<br/>')+'<br/></td></tr></table>';
	}
		commentDiv.innerHTML = html;
		commentDiv.comment = comment;
		commentDiv.className = "comment";
		return commentDiv;
	}
	function addComment() {
		var bseq = document.addForm.bseq.value;		
		var memberId = document.addForm.memberId.value;
		var inDate = document.addForm.inDate.value;
		var name = document.addForm.name.value;
		var content = document.addForm.content.value;
		var params="";
	if(memberId=="null"){		
		if(isEmpty(document.addForm.name, "お名前を書いて下さい")) return ;
		if(isEmpty(document.addForm.content, "コメントを入力してください")) return ;				
		params = "bseq="+encodeURIComponent(bseq)+"&"+			
			"memberId="+encodeURIComponent(memberId)+"&"+
			"inDate="+encodeURIComponent(inDate)+"&"+
			"name="+encodeURIComponent(name)+"&"+
		             "content="+encodeURIComponent(content);
		new ajax.xhr.Request('commentadd.jsp', params, addResult, 'POST');
	}else{					
		if(isEmpty(document.addForm.name, "お名前を書いて下さい")) return  ;
		if(isEmpty(document.addForm.content, "コメントを入力してください")) return  ;			
		params = "bseq="+encodeURIComponent(bseq)+"&"+			
			"memberId="+encodeURIComponent(memberId)+"&"+
			"inDate="+encodeURIComponent(inDate)+"&"+
			"name="+encodeURIComponent(name)+"&"+
		             "content="+encodeURIComponent(content);
		new ajax.xhr.Request('commentadd.jsp', params, addResult, 'POST');
	
	}			
			
			
}
	function addResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var xmlDoc = req.responseXML;
				var code = xmlDoc.getElementsByTagName('code').item(0)
				                 .firstChild.nodeValue;
				if (code == 'success') {
					var comment = eval( "(" +
					    xmlDoc.getElementsByTagName('data').item(0)
					          .firstChild.nodeValue +
					")" );
					var listDiv = document.getElementById('commentList');
					var commentDiv = makeCommentView(comment);
					listDiv.appendChild(commentDiv);
					
					document.addForm.name.value = '';
					document.addForm.content.value = '';
				//	alert("등록했습니다!");
				} else if (code == 'fail') {
					var message = xmlDoc.getElementsByTagName('message')
					                    .item(0).firstChild.nodeValue;
					alert("Error 発生:"+message);
				}
			} else {
				alert("サーバ エラー 発生: " + req.status);
			}
		}
	}
	function viewUpdateForm(commentId) {
		var commentDiv = document.getElementById('c'+commentId);
		var updateFormDiv = document.getElementById('commentUpdate');
		if (updateFormDiv.parentNode != commentDiv) {
			updateFormDiv.parentNode.removeChild(updateFormDiv);
			commentDiv.appendChild(updateFormDiv);
		}
		var comment = commentDiv.comment;
		document.updateForm.id.value = comment.id;
		document.updateForm.name.value = comment.name;
		document.updateForm.content.value = comment.content;
		updateFormDiv.style.display = '';
	}
	function cancelUpdate() {
		hideUpdateForm();
	}
	function hideUpdateForm() {
		var updateFormDiv = document.getElementById('commentUpdate');
		updateFormDiv.style.display = 'none';
		updateFormDiv.parentNode.removeChild(updateFormDiv);
		document.documentElement.appendChild(updateFormDiv);
	}
	function updateComment() {
		var id = document.updateForm.id.value;
		var name = document.updateForm.name.value;
		var content = document.updateForm.content.value;
		var params = "id="+encodeURIComponent(id)+"&"+
		             "name="+encodeURIComponent(name)+"&"+
		             "content="+encodeURIComponent(content);
		new ajax.xhr.Request('commentupdate.jsp', params, updateResult, 'POST');
	}
	function updateResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var xmlDoc = req.responseXML;
				var code = xmlDoc.getElementsByTagName('code')
				                 .item(0).firstChild.nodeValue;
				if (code == 'success') {
					hideUpdateForm();
					var comment = eval( "(" +
					    xmlDoc.getElementsByTagName('data').item(0)
					          .firstChild.nodeValue +
					")" );
					var listDiv = document.getElementById('commentList');
					var newCommentDiv = makeCommentView(comment);
					var oldCommentDiv = 
					        document.getElementById('c'+comment.id);
					listDiv.replaceChild(newCommentDiv, oldCommentDiv);
				//	alert("수정했습니다!");
					window.location.reload(); 
				} else if (code == 'fail') {
					var message = xmlDoc.getElementsByTagName('message')
					                    .item(0).firstChild.nodeValue;
					alert("エラー発生:"+message);
				}
			} else {
				alert("サーバエラー発生: " + req.status);
			}
		}
	}
	function confirmDeletion(commentId) {
		if (confirm("削除しますか?")) {
			var params = "id="+commentId;
			new ajax.xhr.Request(
				'commentdelete.jsp', params, removeResult, 'POST');
		}
	}
	function removeResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var xmlDoc = req.responseXML;
				var code = xmlDoc.getElementsByTagName('code').item(0)
				                 .firstChild.nodeValue;
				if (code == 'success') {
					var deletedId = 
						xmlDoc.getElementsByTagName('id').item(0)
						      .firstChild.nodeValue;
					var commentDiv = document.getElementById("c"+deletedId);
					commentDiv.parentNode.removeChild(commentDiv);
					
				//	alert("삭제했습니다");
				} else if (code == 'fail') {
					var message = xmlDoc.getElementsByTagName('message')
					                    .item(0).firstChild.nodeValue;
					alert("エラー発生:"+message);
				}
			} else {
				alert("サーバエラー発生: " + req.status);
			}
		}
	}
</script>
<script type="text/javascript">
function FCKeditor_OnComplete( editorInstance )
{
	window.status = editorInstance.Description ;
}
</script>
<script type="text/javascript">
function popup_Layer(event,popup_name) {    //팝업레이어 생성
     var main,_tmpx,_tmpy,_marginx,_marginy;
     main = document.getElementById(popup_name);
     main.style.display = '';//팝업 생성 
     _tmpx = event.clientX+parseInt(main.offsetWidth);
     _tmpy = event.clientY+parseInt(main.offsetHeight);
     _marginx = document.body.clientWidth - _tmpx;
     _marginy = document.body.clientHeight - _tmpy;

     // 좌우 위치 지정
     if(_marginx < 0){
        main.style.left = event.clientX + document.body.scrollLeft + _marginx-2+"px";
     }
     else{
        main.style.left = event.clientX + document.body.scrollLeft-5+"px";
     }
     //높이 지정
     if(_marginy < 0){
        main.style.top = event.clientY + document.body.scrollTop + _marginy-5+"px";
     }  
     else{
        main.style.top = event.clientY + document.body.scrollTop-5+"px";
     } 

}  

function Layer_popup_Off() { 
  var frm=document.frm;
  var pay_len = eval(frm.divPass.length);  
  var pay_val=frm.divPass;
  if (pay_len>1){
	  for (i=0; i<pay_len; i++) {		  
		 eval(pay_val[i].value + ".style.display = \"none\"");		 
	  }
  }else{
	eval(pay_val.value + ".style.display = \"none\"");
  }  
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
	</span> 		
		
<div class="clear_line_gray"></div>
<p>
<div id="botton_position">	
	<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  目録  >>" onClick="location.href='<%=urlPage%>admin/board/listForm.jsp?kindboard=<%=kindboard%>'">
    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  書く >>" onClick="location.href='<%=urlPage%>admin/board/addForm.jsp?kindboard=<%=kindboard%>'">
    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  返事  >>" onClick="javascript:goRWrite()">
<%if(member2.getMseq()==board.getMseq()){%>    
    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  修正  >>" onClick="javascript:goUpdate()">
    			<input type="button"  class="cc" onfocus="this.blur();" style=cursor:pointer value="  削除  >>" onClick="javascript:goDel()">    	
  <%}%>
</div>
	
<div id="boxNoLine_850"  >		
<table width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
	<tr  height=26>
    		<td height="34" style="padding: 0px 0px 0px 0px;" >    	 
    			<img src="<%=urlPageOrms%>images/common/jirusi.gif"  align="absmiddle">  内容        	
    		</td> 
	</tr>	
</table>
	

<table width="80%" class="writeBox" cellspacing="2" cellpadding="2" >					
	<tr >
		<td  width="100%" bgcolor="f4f4f4" style="padding: 5 3 5 5" colspan="6" class="calendar9">
			<img src="<%=urlPage%>image/user/icon_board_title.gif" align="absmiddle">
		<%=board.getTitle()%>
		</td>	
	</tr>
	<tr><td colspan="6" background="<%=urlPage%>image/dot_line_all.gif" ><td></tr>
	<tr >
		<td width="9%" class="cho_06" style="padding: 3 3 3 8">Name</td>
		<td width="1%" class="cho_06" style="padding: 3 3 3 3">:</td>
		<td width="60%" style="padding: 3 3 3 3">
		<%=board.getName()%></td>
		<td  width="20%" style="padding: 3 3 3 3" class="msmall" align="right"><%=dateFormat.format(board.getRegister())%></td>
		<td  width="2%" style="padding: 3 3 3 3" >/</td>
		<td  width="8%" style="padding: 3 3 3 3" class="msmall" ><%=board.getHit_cnt()%></td>
	</tr>	
<c:if test="${board.mail_yn==1}">
	<tr><td colspan="6" background="<%=urlPage%>image/dot_line_all.gif" ><td></tr>
	<tr >
		<td width="9%" class="cho_06" style="padding: 3 3 3 8">メール</td>
		<td width="1%" class="cho_06" style="padding: 3 3 3 3">:</td>
		<td width="60%" style="padding: 3 3 3 3" colspan="4">
	<a href="mailto:${board.mail_address}?subject=Hello!!">${board.mail_address}</a></td>
	</tr>
</c:if>
			
	<tr height="1"><td bgcolor="#99CC00" colspan="6"><td></tr>
	<tr >
		<td  width="100%" style="padding: 20px 3px 20px 15px;" colspan="6" >
		<%=board.getContent()%>
		</td>	
	</tr>
		
</table>
 <div class="clear_margin"></div>
<!-- 대글 시작 -->
<%if(pg.equals("cLead")){%>

<table width="80%"  class="box_100" cellspacing="2" cellpadding="2" >	
	<tr>
    		<td style="padding: 5px 0px 5px 2px;" ><img src="<%=urlPage%>image/admin/location.gif"  align="absmiddle">
    			<font color="#AC913E">コメント</font> 
    		</td> 
    		<td style="padding: 0 0 0 0"  align="right"> コメント数:(<%=countCom%>)
    		</td> 
	</tr>	
	<tr>    		
		<td colspan="2"><div id="commentList" style="display: padding:0 0 8 0;"></div></td>
	</tr>
	 <tr>
	 	<td colspan="2">
	 			<div id="commentAdd">
				 <table width="100%" border="0" cellspacing="0" cellpadding="0" class=c>
				 <form action="" name="addForm" method="post">
				 <input type="hidden" name="bseq" value="<%=bseq%>">				 
				 <input type="hidden" name="inDate" value="<%=inDate%>">
				 <input type="hidden" name="memberId" value="<%=memberId%>"/>
					<tr>
						<td width="8%" style="padding:0 0 0 5;"><img src="<%=urlPage%>image/icon_ball.gif"  align="absmiddle">お名前 </td>
						<td width="1%" style="padding:0 0 0 5;" >:</td>
						<td width="81%" style="padding:0 0 0 5;" >
						<input type="text" name="name" value="<%=name%>" size="20" maxlength="20" class="input02" style="width:100px"></td>
					</tr>
					<tr>
						<td  style="padding:0 0 0 5;"><img src="<%=urlPage%>image/icon_ball.gif"  align="absmiddle">コメント </td>
						<td  style="padding:0 0 0 5;" >:</td>
						<td  style="padding:0 0 0 5;" >	
						<input type="text" name="content" value="" size="200" maxlength="200" class="input02" style="width:500px"></td>							
					</tr>
					<tr>
						<td style="padding:0 0 0 0;" align="center" colspan="3">
						<A HREF="JavaScript:addComment()"><img src="<%=urlPage%>image/admin/btn_apply.gif"></A>		
						</td>
					</tr>
					</form>
				</table>
			</div>
			<div id="commentUpdate" style="display: none;padding:0 0 8 0;">
				<table width="90%" border="0" cellspacing="2" cellpadding="2" bgcolor="#f4f4f4" class="box_solid">
				<form action="" name="updateForm">
					<input type="hidden" name="id" value="">
					<input type="hidden" name="fseq" value="<%=bseq%>">					
					<input type="hidden" name="memberId" value="<%=memberId%>"/>
					<input type="hidden" name="inDate" value="<%=inDate%>"/>					
						<tr>
							<td style="padding:0 0 0 2;">
								お名前 : <input type="text" name="name" size="10" maxlength="20" class="input02" style="width:100px"><br/>
								内    容 : <input type="text" name="content" value="" size="200" maxlength="200" class="input02" style="width:500px"><br/>
							</td>
						</tr>
						<tr>
							<td align="center">
								<input type="button" value="修正" onclick="updateComment()"/>
								<input type="button" value="キャンセル" onclick="cancelUpdate()"/>
							</td>
						</tr>
					</form>
				</table>
		</div>
	 	</td>
	 </tr>
 </table>
 <%}%>
<!-- 댓글 끝 -->
</div>
<form name="move2" method="post">
    <input type="hidden" name="bseq" value="${board.bseq}">    
    <input type="hidden" name="parentId" value="${board.bseq}">
    <input type="hidden" name="groupId" value="${board.groupId}">     
    <input type="hidden" name="level" value="${board.level}"> 
    <input type="hidden" name="kindboard" value="<%=kindboard%>">   	
</form>

			
<script language="JavaScript">

function goRWrite(){
	document.move2.action="<%=urlPage%>admin/board/addForm.jsp?pg=cRe";	
	document.move2.kindboard.value=document.move2.kindboard.value;
	document.move2.submit();
}
function goUpdate(){
	document.move2.action="<%=urlPage%>admin/board/updateForm.jsp";	
	document.move2.kindboard.value=document.move2.kindboard.value;
	document.move2.submit();
}
function goDel(){
	if ( confirm("本内容を削除しますか?") != 1 ) {
		return;
	}
	document.move2.action="<%=urlPage%>admin/board/delete.jsp";	
	document.move2.bseq.value=document.move2.bseq.value;
	document.move2.groupId.value=document.move2.groupId.value;
	document.move2.level.value=document.move2.level.value;
	document.move2.kindboard.value=document.move2.kindboard.value;
	document.move2.submit();
}
</script>

