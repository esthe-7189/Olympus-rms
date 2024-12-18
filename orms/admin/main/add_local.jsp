<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "javax.imageio.ImageIO" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.util.ImageUtil" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "mira.main.Bean" %>
<%@ page import = "mira.main.Mgr" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>


<%
String urlPage=request.getContextPath()+"/orms/";	
    FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(
        request, -1, -1,
        "C:\\dev\\tomcat5\\webapps\\orms\\orms\\temp","utf-8");
    HttpServletRequest tempRequest = request;
    request = requestWrap;
%>
<jsp:useBean id="best" class="mira.main.Bean">
    <jsp:setProperty name="best" property="*" />
</jsp:useBean>
<%
	int pseq;
	Mgr manager = Mgr.getInstance();    	
	Bean pb=manager.selectPseq("main_best_focus");
	if(pb !=null){
	  	pseq=pb.getItem_seq()+1;
	}else{
		pseq=0;
	}	
    FileItem imageFileItem = requestWrap.getFileItem("imageFile");	
	String cate= request.getParameter("navi_kind");
	String item_seq= request.getParameter("item_seq");
	String code= request.getParameter("pcode_pg");
	
	String pcode= cate+"-"+pseq+"-"+code;
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
            "C:\\dev\\tomcat5\\webapps\\orms\\orms\\images\\main\\best",
            pcode+"_big.jpg");
        // 같은 이름의 파일이름 처리
        if (imageFile.exists()) {
            for (int i = 0 ; true ; i++) {
                imageFile = new File(
                    "C:\\dev\\tomcat5\\webapps\\orms\\orms\\images\\main\\best",
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
            "C:\\dev\\tomcat5\\webapps\\orms\\orms\\images\\main\\best",
            pcode+"_sub.jpg");
        ImageUtil.resize(imageFile, destFile, 134, ImageUtil.RATIO);
		
	best.setImg(pcode);
    }
 %>

<%
   best.setRegister(new Timestamp(System.currentTimeMillis()));    
   best.setItem_seq(Integer.parseInt(item_seq));	
   best.setNavi_kind(Integer.parseInt(cate));
   if(best.getContent()==null){
   	best.setContent("contest");
   }
  manager.insert(best);
%>


<SCRIPT LANGUAGE="JavaScript">
alert("登録完了！！！！！");
location.href="<%=urlPage%>admin/main/addForm.jsp";
</SCRIPT>

