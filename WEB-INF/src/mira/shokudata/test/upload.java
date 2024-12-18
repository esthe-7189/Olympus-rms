package mira.shokudata;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class upload extends HttpServlet{

public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException {

	doPost(request, response);
}

public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	RequestDispatcher rd = null;
	String fileName = "";
	String fileLength = "";
	File file = null;
	String savePath = "C:/HarimPMS/workspace/my/saveFile";
	String count = "";
	int maxSize = 5 * 1024 * 1024; // 최대 업로드 파일 크기 5MB(메가)로 제한
	
	try {
	MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "euc-kr", new DefaultFileRenamePolicy());
	count = multi.getParameter("count");
	Enumeration efiles = multi.getFileNames();
	int i = 0;
		while(efiles.hasMoreElements()){
			String name = (String)efiles.nextElement(); 
			file = multi.getFile(name); 
			String str = file.getName();
			i++;
			fileName += "&fileName"+i+"="+str;
			fileLength += "&fileLength"+i+"="+file.length();
		}
	}catch (Exception e) {
	System.out.print("예외 발생 : " + e);
	}
	rd = getServletContext().getRequestDispatcher("/uploadfileview.jsp?count="+count+fileName+fileLength);
	rd.forward(request, response);
	}
}
