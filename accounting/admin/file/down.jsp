<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page language="java" %>
<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,javax.servlet.*"%>
<%@ page import = "mira.memberacc.Member" %>
<%@ page import = "mira.memberacc.MemberManager" %>
<%@ page import="mira.acc.AccBean" %>
<%@ page import="mira.acc.AccDownMgr" %>
<%@ page import="mira.acc.AccMgr" %>
<%@ page import = "java.sql.Timestamp" %>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="pds" class="mira.acc.AccBean" >
	<jsp:setProperty name="pds" property="*"  />
</jsp:useBean>
<%	
String kind=(String)session.getAttribute("KIND");
if(kind!=null && ! kind.equals("acc")){
%>			
	<jsp:forward page="/rms/template/tempMain.jsp">		    
		<jsp:param name="CONTENTPAGE3" value="/rms/home/home.jsp" />	
	</jsp:forward>
<%
	}
	String urlPage=request.getContextPath()+"/";		
	String seq=request.getParameter("seq");		
	String filename =""; 
	
AccMgr manager = AccMgr.getInstance();
if(seq==null){ seq="0";}
AccBean accBean=manager.getAcc(Integer.parseInt(seq));
	if(accBean!=null){
		filename=accBean.getFilename();
	}


// String filename2=java.net.URLEncoder.encode(new String(filename .getBytes("8859_1"), "UTF-8"),"UTF-8");
// String filename3=new String(filename .getBytes("8859_1"), "UTF-8");
String filename4=java.net.URLEncoder.encode(filename,"UTF-8");

 String path = getServletContext().getRealPath("/");
 String other_path="accounting/admin/file/fileList";

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
location.href="<%=urlPage%>accounting/admin/file/listForm.jsp";
</script>




