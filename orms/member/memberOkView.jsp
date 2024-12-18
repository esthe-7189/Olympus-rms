<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*" %>
<%@ page import = "java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "mira.memberuser.Member" %>
<%@ page import = "mira.memberuser.MemberManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page errorPage="/orms/error/error.jsp"%>	

<jsp:useBean id="member" class="mira.memberuser.Member" >
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/orms/";
String  mail_address=request.getParameter("mail_address");
String  password=request.getParameter("password");
String  nm=request.getParameter("name1");
String  nm2=request.getParameter("name2");
String  age=request.getParameter("age");
String ip_info=(String)request.getRemoteAddr();
    
    MemberManager manager = MemberManager.getInstance();            
    Member memId=manager.idCh(member.getMail_address());
    
    if(memId==null ){
    	member.setRegister(new Timestamp(System.currentTimeMillis()) );
    	member.setIp_info(ip_info);
    	member.setName1(nm);
    	member.setName2(nm2);
    	member.setMail_address(mail_address);
    	member.setPassword(password);
    	member.setAge(Integer.parseInt(age));
    	
    	member.setLevel(3);  //level(1=관리자, 2=직원, 3=회원)
    	manager.insertMember(member);
%>
<!-- title  begin***************************-->
		<div id="title">
<!-- navi ******************************--> 
			<p id="navi">::: <a href="<%=urlPage%>">Home</a> <img src="<%=urlPage%>images/common/overay.gif"> 会員登録完了　 </p>
			<p id="catetop" class="b fs14 l18 pad_t10 mb20"><img src="<%=urlPage%>images/menu/menu_08_2.gif"></p>
		</div>
		
<!-- title end **********************************-->	
		<div id="content"> 		
			
			<div class="sign_box" style="padding:">
				<p><img src="http://www.koreabrand.net/images/en/util/sign_txt.gif" alt="Registered Users" title="Registered Users"/></p>
				<p class="b mb20 mt5"><font color="#3366CC"><%=nm%></font>様の会員登録が済みました。</p>
				<div class="login_box">
					<ul class="box">
						<img src="<%=urlPage%>images/bg/memberok_myinfo.gif" onClick="javascript:goPage('idName');" style="cursor:pointer;" alt="join ok" title="sign in"/>								
					</ul>				
				</div>
				<div class="register">					
					<div class="reg_txt">
						<img src="<%=urlPage%>images/bg/memberok_mame.gif"  />						
					</div>
				</div>				
			</div>	
			<div class="sign_txt01">
				<ul>
					<li><span>Welcome to OLYMPUS-RMS.com!<br />OLYMPUS-RMS.com allows you to use most of the menus without signing up.</span>
						<dl>
							<dt>But if you sign up, you can enjoy additional services as follows:</dt>
							<dd>- You can participate in online surveys of OLYMPUS-RMS.com, and be rewarded for the participation. </dd>								
							<dd>- You will receive OLYMPUS-RMS.com newsletters by e-mail. </dd>
							<dd>- We will be offering a variety of additional services and benefits to the members.</dd>
							<dd>Thank you.</dd>
						</dl>
					</li>
				</ul>
			</div>			
	</div>
 
<hr /> 
<h2 class="blind">right_area</h2>
<!-- right begin -->
<div class="subPro01">
<div class="subContent1 module">
<jsp:include page="/orms/module/rightEmail.jsp" flush="false"/>
<p class="pad_t5 mb5"><a href=""><img src="<%=urlPage%>images/css_img/picture/biocollagen.jpg" alt="Boi Collagen" /></a></p> 	
</div> <!--subContent1 ***************************** -->	
</div> <!--parentTwoColumn ***************************** -->
<!-- right end -->	
<hr /> 
 <!-- 내용 끝 *****************************************************************-->	
<%}else{%>
	<script language=javascript>			
		alert("もう使われているIDです。再び実行して頂ます。");
			history.go(-1);
	</script>
<%}%>