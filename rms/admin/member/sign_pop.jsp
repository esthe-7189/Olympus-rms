<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "javax.imageio.ImageIO" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.util.ImageUtil" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "mira.member.Member" %>
<%@ page import = "mira.member.MemberManager" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page errorPage="/rms/error/error.jsp"%>

<%
String urlPage=request.getContextPath()+"/";	
    FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(
        request, -1, -1,
        "/home/user/orms/public_html/rms/temp","utf-8");
    HttpServletRequest tempRequest = request;
    request = requestWrap;
%>
<%

    FileItem imageFileItem = requestWrap.getFileItem("imageFile");		
	String code= request.getParameter("mcode");	
	String mseq=request.getParameter("mseq");
	String fileKind=request.getParameter("fileKind");
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
            "/home/user/orms/public_html/rms/image/admin/ingam",
            pcode+"_big.jpg");
        // 같은 이름의 파일이름 처리
        if (imageFile.exists()) {
            for (int i = 0 ; true ; i++) {
                imageFile = new File(
                    "/home/user/orms/public_html/rms/image/admin/ingam",
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
            "/home/user/orms/public_html/rms/image/admin/ingam",
            pcode+"_40.jpg");
        ImageUtil.resize(imageFile, destFile, 32, ImageUtil.RATIO);
		
    }
 MemberManager manager = MemberManager.getInstance();
 manager.signChange(Integer.parseInt(mseq),pcode);
  	
%>
<SCRIPT LANGUAGE="JavaScript">
alert("完了 !!");
opener.location.href="<%=urlPage%>rms/admin/member/listForm.jsp";
window.close();
</SCRIPT>

	
	
	
	









