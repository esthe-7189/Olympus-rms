<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import = "java.util.List,java.io.*,javax.servlet.*,javax.servlet.http.*,java.text.*,java.sql.*" %>
<%@ page import = "mira.shokudata.Category" %>
<%@ page import = "mira.shokudata.CateMgr" %>
<%@ page import=  "mira.shokudata.MgrException" %>
	
<jsp:useBean id="category" class="mira.shokudata.Category">
    <jsp:setProperty name="category" property="*" />
</jsp:useBean>

<%
String urlPage=request.getContextPath()+"/";
int lengthcnt=0;
CateMgr manager = CateMgr.getInstance();
int memCnt=manager.memCnt();

//지난 데이터 삭제
	if(memCnt !=0){
		manager.deleteMem();
	}
	

if(request.getParameterValues("chkBoxName") !=null){			
String valcnt [] =request.getParameterValues("chkBoxName");

	if(valcnt.length==1){
		String val []=request.getParameter("chkBoxName").split(","); 		
		
		  category.setMseq(Integer.parseInt(val[0]));
		  category.setCate_cnt(Integer.parseInt(val[1]));
		  category.setOk_yn(1);
		  category.setRegister(new Timestamp(System.currentTimeMillis()));	 
	     manager.insertMem(category);	
	}else{
		String[] val=request.getParameterValues("chkBoxName");
		for(int i=0; i< valcnt.length; i++){
			String mmm []=val[i].split(","); 	
			
		   category.setMseq(Integer.parseInt(mmm[0]));		  
		   category.setCate_cnt(Integer.parseInt(mmm[1]));
		   category.setOk_yn(1);
		   category.setRegister(new Timestamp(System.currentTimeMillis()));	 		 
	 	manager.insertMem(category);
		}
	}
}



%>
	<script language="JavaScript">
	alert("登録しました");
	location.href = "<%=urlPage%>rms/admin/shokuData/viewMgr.jsp";	
	</script>


<%%>


