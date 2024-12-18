<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page language="java" %>
<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,javax.servlet.*"%>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "mira.contract.ContractBeen" %>
<%@ page import = "mira.contract.ContractMgr" %>
<%@ page import = "mira.contract.DownMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="pds" class="mira.contract.ContractBeen" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("toku")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String urlPage=request.getContextPath()+"/";			
	String id=(String)session.getAttribute("ID");
	String ip_add=(String)request.getRemoteAddr();
if(id!=null){	
	String password=request.getParameter("pass");	
	String seq=request.getParameter("seq");		
	String filename = request.getParameter("filename"); 
	
	DownMgr mgr = DownMgr.getInstance();
	
	MemberManager manager = MemberManager.getInstance();
	Member mem=manager.getMember(id);	
	int mseq_int=mem.getMseq();	
	int chValue=manager.checkPass(mseq_int,password);	
	if(chValue ==1){				
			pds.setSeq_contract(Integer.parseInt(seq));
			pds.setSeq_mem(mseq_int);
			pds.setRegister(new Timestamp(System.currentTimeMillis()));
			pds.setIp_add(ip_add);
		mgr.insertDown(pds);

	
	
String filename4=java.net.URLEncoder.encode(filename,"UTF-8");

 String path = getServletContext().getRealPath("/");
 String other_path="tokubetu/fileList/contract";

 File file = new File(path+other_path+"/"+filename); 
// response.setContentType("application/x-msdownload"); 
    response.setContentType("application/octet-stream"); 
 byte b[] = new byte[5 * 1024 * 1024];  
 
 String Agent=request.getHeader("USER-AGENT");


 if(Agent.indexOf("MSIE")>=0){
  int i=Agent.indexOf('M',2);
  String IEV=Agent.substring(i+5,i+8);
  if(IEV.equalsIgnoreCase("5.5")){   
   response.setHeader("Content-Disposition", "filename="+ filename4+ ";");
  }else{   
   response.setHeader("Content-Disposition", "attachment;filename="+ filename4+ ";");
  }
 }else{   
   response.setHeader("Content-Disposition", "attachment;filename="+ filename4+ ";");
 }
	        
 
 if (file.isFile()){  
  try { 
   BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));  
   BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());  
   int read = 0;  
   while ((read = fin.read(b)) != -1){  
    outs.write(b,0,read);
   }
   outs.flush();
   outs.close();  
   fin.close(); 
  }catch(Exception e){
  }
 }

%>
<script language="JavaScript">				
	parent.location.href="<%=urlPage%>tokubetu/admin/contract/listForm.jsp";
</script>
<%}else if(chValue ==0){%>		
			<script language=javascript>
				alert("パスワードが正しくありません。");
				parent.history.go(-1);
			</script>
		
	<%}else if(chValue ==-1){%>
			<script language=javascript>
				alert("パスワードに一致するユーザが存在しません。");
				parent.history.go(-1);
			</script>
	<%}
}else{%>
<script language="JavaScript">		
	parent.location.href = "<%=urlPage%>tokubetu/member/loginForm.jsp";
</script>

<%}%>