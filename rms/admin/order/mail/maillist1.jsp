<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="java.util.*,java.io.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,javax.mail.event.*,java.text.*,javax.servlet.http.*" %>
<%@ page import="javax.activation.DataHandler"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.PasswordAuthentication"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.util.ByteArrayDataSource"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.order.BeanOrderBunsho" %>
<%@ page import = "mira.order.MgrOrderBunsho" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<%!
NumberFormat numFormat = NumberFormat.getNumberInstance(); 
class MyAuthenticator extends javax.mail.Authenticator{
    private String userid;
    private String passwd;

    public MyAuthenticator(String userid, String passwd) {
        this.userid = userid;
        this.passwd = passwd;
    }

    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
        return new javax.mail.PasswordAuthentication(userid, passwd);
    }
}
%>

<%
String urlPage=request.getContextPath()+"/";

//http://syh1011.tistory.com/5  참조

String from = "miraesthe@gmail.com";
String fname = "장미라";
//smtp 서버관련
String host = "smtp.gmail.com";
String userid="miraesthe@gmail.com";
String passwd="dptmej7052?yo22";

MgrOrderBunsho mgrOrder=MgrOrderBunsho.getInstance();
BeanOrderBunsho beanOrder=mgrOrder.getDbOrder(Integer.parseInt(seq));
List listCon=mgrOrder.listItem(beanOrder.getSeq());	
Member memSign;
%>
<c:set var="beanOrder" value="<%=beanOrder%>"/>
<%
String mailSubj = "주문 내역입니다.";
String msgText =
"<table width='80%'  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF ><tr><td align='center' bgcolor='#ffffff' style='padding: 5 5 10 5'>"+				
"<table width='98%'  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>"+							
"<table width='100%' border="0" cellpadding=0 cellspacing=0 bordercolor='#000' ><tr><td align='center' bgcolor='#ffffff' style='padding: 10 5 10 5'>"+
"<table width='100%'  border=0 cellpadding=0 cellspacing=0 bordercolor=#FFFFFF ><tr><td align='center' colspan='3' bgcolor='#ffffff'   style='padding: 10 0 3 0;'>"+
"<table width='100%'  border=0 cellpadding=0 cellspacing=0 ><tr><td align='center'  style='padding: 3 0 3 0;'><h3>社内用品発注依頼書</h3></td></tr></table>"+
"</td></tr><tr><td width='26%' align='center' bgcolor='#ffffff' style='padding: 3 0 3 0;'>"+
"<table width='100%' border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2><tr  align=center height=26>"+	
"<td width='50%' ><%if(beanOrder.getKind_urgency()==2){%><font color=#CC6600>◎</font> <%}else{%>&nbsp;<%}%></td>"+
"<td width='50%' >至急</td>	</tr><tr  align=center height=26>	"+
"<td width='50%' ><%if(beanOrder.getKind_urgency()==1){%><font color='#CC6600'>◎</font><%}else{%>&nbsp;<%}%></td>"+
"<td width='50%' '>普通</td></tr></table>	</td><td width='35%' align='center' bgcolor='#ffffff' style='padding: 3 0 3 0;'>&nbsp;</td>"+
	"<td width='39%' align='center' bgcolor='#ffffff' style='padding: 3 0 3 0;'>"+
	"<table width='100%'  border=0 cellpadding=0 cellspacing=0  ><tr><td align='right' style='padding: 3 0 3 0;'>"+
	"<%=beanOrder.getHizuke().substring(0,4)%>年 <%=beanOrder.getHizuke().substring(5,7)%>月 <%=beanOrder.getHizuke().substring(8,10)%>日</td></tr>"+
	"<tr><td align='left' style='padding: 3 0 3 0;'>オリンパスRMS株式会社<br>〒650-0047<br>兵庫県神戸市中央区港島南町1丁目5番2<br>TEL：078-335-5171　FAX：078-335-5172<br></td>"+	
	"</tr></table>	"+					
"</td></tr><tr><td colspan='3' width='30%' align='left'  style='padding: 3 0 3 0;' >発注先：  <%=beanOrder.getContact_order()%></td></tr>"+			
	"<tr><td colspan='3' align='center' style='padding: 3 0 3 0;'>"+
	"<table width='100%'  border=1 cellpadding=1 cellspacing=0 bordercolor=#FFFFFF bordercolorlight=#A2A2A2>"+
	"<tr bgcolor=#F1F1F1 align=center height=26><td>品名</td><td >発注NO.</td><td >発注数</td><td >単価 (\)</td><td>価格 (\)</td><td>依頼者</td>"+
	"</tr><c:set var='listCon' value='<%=listCon %>' /><c:if test='${!empty listCon}'>"+
	"<%	int ii=1; 	int totalPriceOrder=0;Iterator listiter2=listCon.iterator();	while (listiter2.hasNext()){BeanOrderBunsho dbCon=(BeanOrderBunsho)listiter2.next();	int seqq=dbCon.getSeq();int pprice=dbCon.getProduct_qty()*dbCon.getUnit_price();"+
	"totalPriceOrder +=pprice;%>	"+			
		"<tr height=26><td ><%=dbCon.getProduct_nm()%></td><td ><%=dbCon.getOrder_no()%></td>"+
		"<td  align='center' ><%=dbCon.getProduct_qty()%></td><td  align='right' ><%=numFormat.format(dbCon.getUnit_price())%> </td>"+
		"<td  align='right' ><%=numFormat.format(pprice)%></td><td align='center' ><%if(dbCon.getClient_nm()!=0){memSign=managermem.getDbMseq(dbCon.getClient_nm());%><%=memSign.getNm()%><%}else{%>--<%}%>"+
		"</td></tr><%	ii++;	}%>	<tr><td colspan='6' >備　考 :  <%if(beanOrder.getComment()==null){%>&nbsp;  <%}else{%><%=beanOrder.getComment()%> <%}%></td>"+
		"</tr><tr height=26><td colspan='6' align='right' style='padding: 0 92 0 0;' >合計&nbsp;  :&nbsp;   \&nbsp;   <%=numFormat.format(totalPriceOrder)%></td>"+	
		"</tr></c:if><c:if test='${empty listCon}'><tr height=26><td>-</td>	<td>-</td><td>-</td><td>-</td>	<td>-</td><td>-</td></tr><tr>	"+							
		"<td colspan='6' >備　考 : &nbsp; </td></tr><tr height=26><td colspan='6' align='right' style='padding: 0 92 0 0;' ><font  color=/#669900/>合計  :  \  0 </font></td>	"+
		"</tr></c:if></table></td></tr><tr></tr></table>	</td></tr></table></td>	</tr></table>"
	
    
// 프로퍼티 값 인스턴스 생성과 기본세션(SMTP 서버 호스트 지정) 
Properties props = new Properties();
//props.put("mail.smtp.host", host);
//props.put("mail.smtp.auth", "true");

     props.put("mail.smtp.starttls.enable","true");
     //보내는 메일 프로토콜을 smtp로 설정
     props.put("mail.transport.protocol","smtp" );
     //[표1-1]에 있는 smtp 서버를 설정하는 부분
     props.put("mail.smtp.host",host );
     //메일을 보낼때 SSL를 사용하기 때문에 설정하는 부분
     props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
     //[표1-1]에 있는 포트를 설정하는 부분
     props.put("mail.smtp.port","465");
     //메일을 보낼때 인증을 설정하는 부분
     props.put("mail.smtp.auth","true");
 
MyAuthenticator auth = new MyAuthenticator(userid,passwd);
Session sess = Session.getInstance(props, auth);
//Message msg = null;
MimeMessage msg=new MimeMessage(sess);

// csv 파일 읽어들이기
FileReader testRead;
testRead = new FileReader ("/home/user/orms/public_html/rms/admin/order/mail/maillist.csv");
//testRead = new FileReader ("c:/dev/tomcat5/webapps/orms/rms/admin/order/mail/maillist.csv");
int tempChar;
StringBuffer sbuf = new StringBuffer();
String tmp = "", tname = "", to = "";
int i = 0;

// StringBuffer sbuf 에 저장
do {
	tempChar = testRead.read();
	if (tempChar == -1) break;
	sbuf.append((char)tempChar);
} while(true);

// StringBuffer 를 한줄씩 끊어 읽고 ',' 구분해서 순차적으로 메일보내기
StringTokenizer sto = new StringTokenizer(sbuf.toString(),"\n");
%>

<table width="300" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class=c>
		<tr>
			<td >보낸 리스트입니다	</td>
		</tr>		
		<tr>
			<td>
<%
while(sto.hasMoreElements()) {
	tmp = sto.nextElement().toString();
	i = tmp.indexOf(",");
	tname = tmp.substring(0,i);
	to = tmp.substring(i+1);
	out.println(to+"<br>");

// 메일 보내기
	try {
// create a message
    InternetAddress[] address = {new InternetAddress(to)};
    InternetAddress fadd = new InternetAddress();
    fadd.setAddress(from); // 보내는 사람 email
    fadd.setPersonal(fname,"UTF-8"); // 보내는 사람 이름

	msg = new MimeMessage(sess);
       msg.setFrom(fadd);
	msg.setRecipients(Message.RecipientType.TO, address);
	msg.setSubject(MimeUtility.encodeText(mailSubj,"UTF-8","B"));
	msg.setSentDate(new java.util.Date());
	msg.setContent(msgText,"text/html;charset=UTF-8"); // HTML 형식
	
	//Transport.send(msg);	
	Transport  transport = sess.getTransport("smtp");
	transport.connect(host, userid, passwd);
	transport.sendMessage(msg, msg.getAllRecipients());
	transport.close();

	
	} catch (MessagingException mex) {
	out.println(mex.getMessage());
	out.println(host+"(전송실패)\n");
	}  // end try

} // end while

%>
			</td>		
		</tr>
	</table>

