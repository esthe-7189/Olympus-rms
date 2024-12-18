<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<jsp:useBean id="pds" class="mira.contract.ContractBeen" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
	
<%
String urlPage=request.getContextPath()+"/";
ContractMgr mgr=ContractMgr.getInstance();

	//String saveFold="C:\\dev\\tomcat5\\webapps\\orms\\rms\\admin\\contract/";	
	String saveFold="/home/user/orms/public_html/rms/admin/contract/";

	
// csv 파일 읽어들이기
FileReader testRead;
testRead = new FileReader (saveFold+"data03.csv");
int tempChar;
StringBuffer sbuf = new StringBuffer(); 
String tmp = "";

// StringBuffer sbuf 에 저장
do {
	tempChar = testRead.read();
	if (tempChar == -1) break;
	sbuf.append((char)tempChar);
} while(true);

// StringBuffer 를 한줄씩 끊어 읽고 ',' 구분해서 순차적으로 인서트
StringTokenizer sto = new StringTokenizer(sbuf.toString(),"\n");
%>
<table width="780" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td colspan="2">인서트</td>
	</tr>	
</table><p>
<table width="300" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class=c>
		<tr>
			<td >리스트</td>
		</tr>		
		<tr>
			<td>
<%
int i = 196;	
while(sto.hasMoreElements()) {
	tmp = sto.nextElement().toString();
	String [] arr=tmp.split(",");
	  
			pds.setRegister(new Timestamp(System.currentTimeMillis()));
			pds.setFile_nm("");					
			pds.setKubun("総務関連");
		      	pds.setKanri_no("契-"+i);	
		      	pds.setMseq(45);				
			pds.setContract_kind(arr[3]);  
			pds.setTitle(arr[4]);
			pds.setContact(arr[5]);
			pds.setHizuke(arr[6]);
			pds.setDate_begin(arr[7]);
			pds.setDate_end(arr[8]);
			pds.setRenewal(arr[9]);		
			pds.setContent(arr[10]);
			pds.setSekining_nm("舟久保あずさ");	
			pds.setSekining_mseq(64);
			pds.setRenewal_yn(1);					
			pds.setComment("");					
		mgr.insertContract(pds);	
		
	//out.println("契-"+i+"---"+arr[6]+"---"+arr[7]+"<br>");
	
i++;	
} // end while

%>
			</td>
		</tr>
		<tr>
			<td >(<%=i%>)개 데이터 insert ok</td>
		</tr>		
	</table>

