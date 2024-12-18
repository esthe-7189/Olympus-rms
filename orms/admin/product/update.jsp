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
ProductManager manager=ProductManager.getInstance();
ProductBean oldProduct=manager.getProduct(product.getPseq());

if (product.getPcode() !=null )
{
    FileItem imageFileItem = requestWrap.getFileItem("imageFile");	
       String category_db=request.getParameter("category_db");
	String cate= request.getParameter("category");
	String code= request.getParameter("pcode_pg");
	String pseq= request.getParameter("pseq");
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
	if(category_db==cate){
		product.setPcode(oldProduct.getPcode());
	}else{	
		product.setPcode(pcode);		
	}
	
	if (pimg.equals(""))	{
		product.setPimg(oldProduct.getPimg());
	}else{ 
		product.setPimg(pcode);
	}
	
	if(product.getContent()==null){
   	product.setContent("content");
   	}
	
	manager.update(product);
%>



<script language="JavaScript">
alert("修正完了！！");
location.href = "<%=urlPage%>admin/product/product.jsp";
</script>

<%
    } else {
%>
<script>
alert("もう一度処理してください ");
history.go(-1);
</script>
<%
    }
%>



