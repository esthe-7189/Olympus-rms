<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page language="java" %>
<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,javax.servlet.*"%>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import="mira.sop.AccBean" %>
<%@ page import="mira.sop.AccMgr" %>
<%@ page import="mira.sop.AccDownMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="pds" class="mira.sop.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
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
	String id=(String)session.getAttribute("ID");
	String ip_add=(String)request.getRemoteAddr();
if(id!=null){	
	String seq=request.getParameter("seq");		
	//String filename = request.getParameter("filename"); 	
	String seq_tab = request.getParameter("seq_tab"); 
	String goPg = request.getParameter("goPg"); 
	
	String filename = ""; 	
	AccMgr mgrdn = AccMgr.getInstance();
	AccBean fnm=mgrdn.getSopMulltiFile(Integer.parseInt(seq));
	if(fnm!=null){
		filename=fnm.getFilename();
	}
	
	AccDownMgr mgrAcc = AccDownMgr.getInstance();

	MemberManager manager = MemberManager.getInstance();
	Member mem=manager.getMember(id);	
	int mseq_int=mem.getMseq();		
			pds.setSeq_acc(Integer.parseInt(seq));
			pds.setSeq_mem(mseq_int);			
			pds.setSeq_tab(Integer.parseInt(seq_tab));
			pds.setRegister(new Timestamp(System.currentTimeMillis()));
			pds.setIp_add(ip_add);
		mgrAcc.insertAccDown(pds);


String filename4=java.net.URLEncoder.encode(filename,"UTF-8");
 String path = getServletContext().getRealPath("/");
 String other_path="rms/admin/sop/fileList";
 File file = new File(path+other_path+"/"+filename); 
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
			 location.href="<%=urlPage%>rms/admin/sop/listForm.jsp";
		</script>	
<%}else{%>	
		<script language="JavaScript">		
			location.href = "<%=urlPage%>rms/member/loginForm.jsp";
		</script>	
<%}%>








