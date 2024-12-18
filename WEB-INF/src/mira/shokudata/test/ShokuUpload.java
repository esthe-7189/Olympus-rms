package mira.shokudata;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.SQLException;
import org.json.simple.JSONObject;
import com.oreilly.servlet.*;
import java.util.*;
import java.io.*;
import java.sql.*;


import mira.DBUtil;
import mira.sequence.Sequencer; 


public class ShokuUpload{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	           throws ServletException, IOException {    
	request.setCharacterEncoding("UTF-8");    
	response.setCharacterEncoding("UTF-8");     
	MultipartRequest mRequest = new MultipartRequest(                                    
		               request, "D:/", 10 * 1024 * 1024, "UTF-8");             
	// 값 추출    
	System.out.println("이름 : " + mRequest.getParameter("name"));    
	System.out.println("data : " + mRequest.getParameter("data"));             
	JSONObject result = new JSONObject();    
	result.put("result", "오케이");     
	PrintWriter out = response.getWriter();    
	out.write(result.toString());    
	out.flush();    
	out.close();}

}