<%@ page contentType = "text/html; charset=utf8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="mira.bunsho.BunshoBean" %>
<%@ page import="mira.bunsho.BunshoMgr" %>
<%@ page import="mira.bunsho.MgrException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>

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
String bseq=request.getParameter("bseq");
String fileKind=request.getParameter("fileKind");

String pg=request.getParameter("pg");
	String ip_info=(String)request.getRemoteAddr();

	String parentId = request.getParameter("parentId");	
		
	String title = ""; String conRe="";  
    	
    BunshoBean bunsho = null;
    if (parentId != null) {
        BunshoMgr manager = BunshoMgr.getInstance();
        bunsho = manager.select(Integer.parseInt(parentId));
        if (bunsho != null) {
            title = ":"+bunsho.getTitle();                   
            conRe=bunsho.getLevel()+">===================================<br>"
            +bunsho.getContent();            
        }
    }

	
%>
<c:set var="bunsho" value="<%= bunsho %>" />


		
<html>
<head>
<title>rms</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=urlPage%>rms/css/eng_text.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=urlPage%>rms/css/main.css" type="text/css">
<script  src="<%=urlPage%>rms/js/common.js" language="JavaScript"></script>
<script  src="<%=urlPage%>rms/js/Commonjs.js" language="javascript"></script>

<script type="text/javascript">
function goWrite() {
    with (document.memberInput) {
        if (chkSpace(fileNm.value)) {
   	    	alert("ファイルを選択してください.");
            fileNm.focus();
            return false;
         }else if (chkSpace(fname.value)) {
            alert("責任者を書いてください.");
            fname.focus();   return false;
          }else if (chkSpace(fname_digi.value)) {
            alert("責任者/デジタルファイルを書いてください.");
            fname_digi.focus();   return false;
          }else if (chkSpace(fname_bun.value)) {
            alert("責任者/文書ファイルを書いてください");
            fname_bun.focus();   return false;
          }else if (chkSpace(basho.value)) {
            alert("保管場所を書いてください");
            basho.focus();   return false;
          }else if (chkSpace(basho_digi.value)) {
            alert("保管場所/デジタルファイルを書いてください.");
            basho_digi.focus();   return false;
          }else if (chkSpace(basho_bun.value)) {
            alert("保管場所/文書ファイルを書いてください.");
            basho_bun.focus();   return false;
          }  
    }
    
   		 var oEditor=FCKeditorAPI.GetInstance('content');
		 var div=document.createElement("DIV");
		 div.innerHTML=oEditor.GetXHTML();
		
		 if(div.innerText=="" || div.innerText==null){	 	 
		    	document.memberInput.bseq.value="11";		    		    
		  }
		
		if ( confirm("登録しましょうか?") != 1 ) {
			return false;
		}
}

function chkSpace(strValue) {
    var flag=true;
    if (strValue!="") {
        for (var i=0; i < strValue.length; i++) {
            if (strValue.charAt(i) != " ") {
	        	flag=false;
	        	break;
	    	}
        }
    }
    return flag;
}

</script>	
<script type="text/javascript">
function FCKeditor_OnComplete( editorInstance ){
	window.status = editorInstance.Description ;
}
</script>	

</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="" BORDER=0  align="center">
<center>				
<table width="100%" border="0" cellspacing="0" cellpadding="0">		
	<tr>		
		<td width="90%"  height="30" style="padding: 0 0 0 20"  class="calendar7">
    				<img src="<%=urlPage%>rms/image/icon_ball.gif" >
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=60);">
				<img src="<%=urlPage%>rms/image/icon_ball.gif" style="filter:Alpha(Opacity=30);">コメントのリスト...
<c:choose>
	<c:when test="${param.fileKind==1}">			
		      	韓国原文(SW)	
	</c:when>
	<c:when test="${param.fileKind==2}">			
		      	翻訳初本(NH)		
	</c:when>
	<c:when test="${param.fileKind==3}">			
		      	PG完成本(PG)	
	</c:when>
	<c:when test="${param.fileKind==4}">			
		      	ORMS最終本(OR)	
	</c:when>	
	<c:otherwise>
	    		No Data!!
	</c:otherwise>
</c:choose>
    		</td>    
    		<td width="10%"  height="30" style="padding: 0 0 0 0"  align="right">
    			<a href="javascript:close();"  onfocus="this.blur()">
			<img src="<%=urlPage%>rms/image/shop/bon_detail_close.gif" ></a>
    		</td>  		
	</tr>	
</table>
<table width="642"  border="0" cellspacing="0" cellpadding="0" align="center">	
	<tr>
    		<td style="padding: 5 0 0 20" align="right">    
    			<a href="<%=urlPage%>rms/admin/commentList_pop.jsp?fileKind=<%=fileKind%>&bseq=<%=bseq%>" onfocus="this.blur()">
    				<img src="<%=urlPage%>rms/image/admin/btn_coment_list.gif" >	</a>    			
    		</td> 
	</tr>		
	<tr>
    		<td height="34" style="padding: 0 0 0 20" background="<%=urlPage%>image/user/board_titleBar.gif">
    	 <%if(pg.equals("wr")){%>
    			コメントを書く   	
    	<%}else if(pg.equals("re")){%>
    			コメントの返事
    	<%}%>
    		</td> 
	</tr>	
</table>
<table width="632" border="0" cellpadding="0" cellspacing="0" class=c>
<form name="memberInput" action="" method="post"  onSubmit="return goWrite(this)" >
	<c:if test="${! empty bunsho}">
		<input type="hidden" name="bseq" value="${bunsho.bseq}">	
	</c:if>
	<c:if test="${empty bunsho}">
		<input type="hidden" name="bseq" value="0">	
	</c:if>	
	<c:if test="${! empty param.groupId}">
		<input type="hidden" name="groupId" value="${param.groupId}">
	</c:if>
	<c:if test ="${! empty param.parentId}">
		<input type="hidden" name="parentId" value="${param.parentId}">
	</c:if>	
		<input type="hidden" name="mail_address" value="">			
		<input type="hidden" name="fileKind" value="${param.fileKind}">						
		<input type="hidden" name="level" value="${bunsho.level + 1}">
		<input type="hidden" name="okyn" value="">			
			
<tr >
	<td  width="12%" bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >作成者:</td>
	<td  width="88%" style="padding: 3 3 3 3" colspan="3">
			<font color="red">*</font>		
		<input type="text" name="name" value="" size="40" maxlength="50" class="logbox" style="width:150px">
		
	</td>  	
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>			
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >返事要求:</td>
	<td  colspan="3" style="padding: 3 3 3 3" >
		<input type="radio" name="mail_yn" value="1" onClick="show01()" onfocus="this.blur()" ><font  color="#FF6600">はい</font>
		<input type="radio" name="mail_yn" value="2" onClick="show02()" onfocus="this.blur()"  checked><font  color="#FF6600">いいえ</font><br>		 
	</td>   
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td   bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >タイトル:</td>
	<td  colspan="3" style="padding: 3 3 3 3">
		<font color="red">*</font>		
			<input type="text" name="title" value="" size="80" maxlength="100" class="logbox" style="width:350px">		
	</td>   
</tr>
<tr><td colspan="4" background="<%=urlPage%>rms/image/dot_line_all.gif" ><td></tr>
<tr >
	<td  bgcolor="f4f4f4" style="padding: 3 3 3 3"><img src="<%=urlPage%>rms/image/icon_s.gif" >コメント:</td>
	<td  colspan="3" style="padding: 3 3 3 3">
		
			<%
			FCKeditor fck = new FCKeditor( request, "content" ) ;
			fck.setBasePath("/fckeditor/" ) ;
			fck.setToolbarSet("Basic");			
			fck.setValue( conRe );
			out.println( fck.create() ) ;
			%>
	
	</td>
</tr>
</table>
 
<table width="90%" border="0" cellpadding="2" cellspacing="0">
		<tr>
		<td colspan="2" align=center>
			<input type="image"  style=cursor:pointer  src="<%=urlPage%>rms/image/admin/btn_jp_ok.gif" onfocus="this.blur()">			
		</td>
	</tr>
</table>
</center>	
</form>
 
</center>
</body>
</html>
