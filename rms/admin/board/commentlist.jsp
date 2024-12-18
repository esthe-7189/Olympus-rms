<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml; charset=utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "mira.board.Board" %>
<%@ page import = "mira.board.BoardManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "mira.DBUtil;" %>
<%
	request.setCharacterEncoding("utf-8");
	BoardManager manager=BoardManager.getInstance();

	String fseq = request.getParameter("fseq");
	
	String POOLNAME = "pool";   
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;	
	
	
	try {		
		conn = DBUtil.getConnection(POOLNAME);
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from comment_board where BSEQ="+fseq+" order by ID");
		
%>
<result>
	<code>success</code>
	<data><![CDATA[
	[
<%
		if (rs.next()) {
			do {
				if (rs.getRow() > 1) { %>
		,
<%
				}
%>
		{
			id: <%= rs.getInt("ID") %>,
			name: '<%= rs.getString("NAME") %>',
			content: '<%=manager.readClobData(rs.getCharacterStream("CONTENT"))%>',
			inDate: '<%= rs.getString("CDATE") %>',			
			memberId: '<%= rs.getString("MEMBERID") %>'					
		}
<%
			} while(rs.next());
		}
%>
	]
	]]></data>
</result>
<%	} catch(Throwable e) {
		out.clearBuffer();
 %>
<result>
	<code>error</code>
	<message><![CDATA[<%= e.getMessage() %>]]></message>
</result>
<%	} finally {
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
