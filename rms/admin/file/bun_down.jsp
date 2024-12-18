<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page language="java" %>
<%@ page import="java.io.*, java.util.*" %>
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

String clips = request.getParameter("filename"); 
String filename = clips; //파일 이름을 받기. 

 String path = getServletContext().getRealPath("/");
 String other_path="rms/admin/file/fileList";

 File file = new File(path+other_path+"/"+filename); // 절대경로.
 response.setContentType("application/octet-stream"); 
 
 String Agent=request.getHeader("USER-AGENT");
 //response.setContentType("application/unknown");  //화일형태

 if(Agent.indexOf("MSIE")>=0){
  int i=Agent.indexOf('M',2);//두번째 'M'자가 있는 위치
  String IEV=Agent.substring(i+5,i+8);
  if(IEV.equalsIgnoreCase("5.5")){
   response.setHeader("Content-Disposition", "filename="+new String(filename.getBytes("ISO-8859-1"),"UTF-8"));
  }else{
   response.setHeader("Content-Disposition", "attachment;filename="+new String(filename.getBytes("ISO-8859-1"),"UTF-8"));
  }
 }else{
   response.setHeader("Content-Disposition", "attachment;filename="+new String(filename.getBytes("ISO-8859-1"),"UTF-8"));
 }

 byte b[] = new byte[5 * 1024 * 1024];  //5M byte까지 업로드가 가능하므로 크기를 이렇게 잡아주었음.
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
  }catch(Exception e){}
 }


%>




