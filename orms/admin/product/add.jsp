<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "javax.imageio.ImageIO" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "mira.util.ImageUtil" %>
<%@ page import = "mira.fileupload.FileUploadRequestWrapper" %>
<%@ page import = "mira.product.ProductBean" %>
<%@ page import = "mira.product.ProductManager" %>
<%@ page import = "mira.product.ProductManagerException" %>
<%@ page import = "java.util.Hashtable"%>
<%@ page errorPage="/orms/error/errorAdmin.jsp"%>

<%
String urlPage=request.getContextPath()+"/orms/";	
    FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(
        request, -1, -1,
        "/home/user/orms/public_html/orms/temp","utf-8");
    HttpServletRequest tempRequest = request;
    request = requestWrap;
%>
<jsp:useBean id="product" class="mira.product.ProductBean">
    <jsp:setProperty name="product" property="*" />
</jsp:useBean>
<%
	int pseq;
	ProductManager manager = ProductManager.getInstance();    	
	ProductBean pb=manager.selectPseq("product");
	if(pb !=null){
	  	pseq=pb.getId()+1;
	}else{
		pseq=0;
	}	
    FileItem imageFileItem = requestWrap.getFileItem("imageFile");	
	String cate= request.getParameter("category");
	String code= request.getParameter("pcode_pg");
	
	String pcode= cate+"-"+pseq+"-"+code;
    	String pimg = "";
	
    if (imageFileItem.getSize() > 0) {
    	product.setPimg(pcode);
        int idx = imageFileItem.getName().lastIndexOf("\\");
        if (idx == -1) {
            idx = imageFileItem.getName().lastIndexOf("/");
        }
        pimg = imageFileItem.getName().substring(idx + 1);
        
        // 이미지를 지정한 경로에 저장
		pimg=pcode+"_big.jpg";
        File imageFile = new File(
            "/home/user/orms/public_html/orms/images/product",
            pcode+"_big.jpg");
        // 같은 이름의 파일이름 처리
        if (imageFile.exists()) {
            for (int i = 0 ; true ; i++) {
                imageFile = new File(
                    "/home/user/orms/public_html/orms/images/product",
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
            "/home/user/orms/public_html/orms/images/product",
            pcode+"_sub.jpg");
        ImageUtil.resize(imageFile, destFile, 134, ImageUtil.RATIO);
        
		 
    }
 %>

<%
   product.setRegister(new Timestamp(System.currentTimeMillis())); 
   product.setPcode(pcode);
   
   if(product.getContent()==null){
   	product.setContent("content");
   }
  manager.insert(product);
%>

<SCRIPT LANGUAGE="JavaScript">
alert("登録完了！！！！！");
location.href="<%=urlPage%>admin/product/product.jsp";
</SCRIPT>

