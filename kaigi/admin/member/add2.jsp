<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "javax.imageio.ImageIO" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.util.ImageUtil" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "mira.kaigi.Member" %>
<%@ page import = "mira.kaigi.MemberManager" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page errorPage="/rms/error/error.jsp"%>

<%
String urlPage=request.getContextPath()+"/";	
    FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(
        request, -1, -1,
        "C:\\Tomcat5.5\\webapps\\orms\\rms\\temp","utf-8");
    HttpServletRequest tempRequest = request;
    request = requestWrap;
%>
<jsp:useBean id="member" class="mira.kaigi.Member" >
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<%
		
	String ip_info=(String)request.getRemoteAddr();
	
	int mseq;
	MemberManager manager = MemberManager.getInstance();            
    	Member memId=manager.idCh(member.getMember_id());
    
    if(memId==null ){	
	Member pb=manager.selectMseq("member");
	if(pb !=null){
	  	mseq=pb.getMseq()+1;
	}else{
		mseq=0;
	}	
    FileItem imageFileItem = requestWrap.getFileItem("imageFile");	
	
	String code= request.getParameter("mcode");
	
	String pcode= mseq+"-"+code;
    	String pimg = "";
	
    if (imageFileItem.getSize() > 0) {
        int idx = imageFileItem.getName().lastIndexOf("\\");
        if (idx == -1) {
            idx = imageFileItem.getName().lastIndexOf("/");
        }
        pimg = imageFileItem.getName().substring(idx + 1);
        
        // 이미지를 지정한 경로에 저장
		pimg=pcode+"_big.jpg";
        File imageFile = new File(
            "C:\\Tomcat5.5\\webapps\\orms\\rms\\image\\admin\\ingam",
            pcode+"_big.jpg");
        // 같은 이름의 파일이름 처리
        if (imageFile.exists()) {
            for (int i = 0 ; true ; i++) {
                imageFile = new File(
                    "C:\\Tomcat5.5\\webapps\\orms\\rms\\image\\admin\\ingam",
                    "("+i+")"+pcode+"_big.jpg");						
                if (!imageFile.exists()) {
                    pimg = "("+i+")"+pcode+"_big.jpg";					 
                    break;
                }
            }
        }
       imageFileItem.write(imageFile);

        // 썸네일 이미지 생성1
        File destFile = new File(
            "C:\\Tomcat5.5\\webapps\\orms\\rms\\image\\admin\\ingam",
            pcode+"_40.jpg");
        ImageUtil.resize(imageFile, destFile, 32, ImageUtil.RATIO);
		
    }
 %>

<%
	member.setRegister(new Timestamp(System.currentTimeMillis()) );
    	member.setIp_info(ip_info);
    	member.setMcode(pcode);
    	member.setLevel(2);    	
	
	if (imageFileItem.getSize() > 0) {
		member.setMimg(pcode);
	} else{
		member.setMimg("no");
	}  
   
  	manager.insertMember(member);
%>
<SCRIPT LANGUAGE="JavaScript">
alert("登録完了 !!");
location.href="<%=urlPage%>kaigi/admin/member/listForm.jsp";
</SCRIPT>

<%}else{%>
	<SCRIPT LANGUAGE="JavaScript">
		alert("登録失敗 !!");
		location.href="<%=urlPage%>kaigi/admin/member/listForm.jsp";
	</SCRIPT>
<%}%>	
	
	
	
	
	
	
	
	