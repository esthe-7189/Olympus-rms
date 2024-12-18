<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml; charset=utf-8" %>
<%@ page import = "java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "mira.sequence.Sequencer" %>
<%@ page import = "mira.DBUtil;" %>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	String bseq = request.getParameter("bseq");
	String inDate=request.getParameter("inDate");	
	String memberId=request.getParameter("memberId");
	
	String POOLNAME = "pool";   
	Connection conn = null;
	Statement stmtIdSelect = null;
	ResultSet rsIdSelect = null;
	PreparedStatement pstmtIdUpdate = null;
	PreparedStatement pstmtCommentInsert = null;
	
	try {
		int nextId = 0;
		
		conn = DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		
		stmtIdSelect = conn.createStatement();
		rsIdSelect = stmtIdSelect.executeQuery(
			"select seqno from id_seq where seqnm='comment_board'");
		if (rsIdSelect.next()) {
			nextId = rsIdSelect.getInt("seqno");
		}
		nextId ++;
		
		pstmtIdUpdate = conn.prepareStatement(
			"update id_seq set seqno = ? where seqnm='comment_board'");
		pstmtIdUpdate.setInt(1, nextId);
		pstmtIdUpdate.executeUpdate();
		
		pstmtCommentInsert = conn.prepareStatement(
			"insert into comment_board values (?,?,?,?,?,?)");
		pstmtCommentInsert.setInt(1, nextId);
		pstmtCommentInsert.setString(2, name);
		pstmtCommentInsert.setCharacterStream(3, new StringReader(content), content.length());			
		pstmtCommentInsert.setInt(4, Integer.parseInt(bseq));
		pstmtCommentInsert.setString(5, inDate);	
		pstmtCommentInsert.setString(6, memberId);
		
		pstmtCommentInsert.executeUpdate();		
		conn.commit();
%>
<result>
	<code>success</code>
	<data><![CDATA[
	{
		id: <%= nextId %>,
		name: '<%= name%>',
		inDate: '<%= inDate%>',
		content: '<%= content%>',		
		memberId: '<%= memberId%>'
	}
	]]></data>
</result>
<%
	} catch(Throwable e) {
		try { conn.rollback(); } catch(SQLException ex) {}
%>
<result>
	<code>error</code>
	<message><![CDATA[<%= e.getMessage() %>]]></message>
</result>
<%
	} finally {
		if (rsIdSelect != null) 
			try { rsIdSelect.close(); } catch(SQLException ex) {}
		if (stmtIdSelect != null) 
			try { stmtIdSelect.close(); } catch(SQLException ex) {}
		if (pstmtIdUpdate != null) 
			try { pstmtIdUpdate.close(); } catch(SQLException ex) {}
		if (pstmtCommentInsert != null) 
			try { pstmtCommentInsert.close(); } catch(SQLException ex) {}
		if (conn != null) try {
			conn.setAutoCommit(true);
			conn.close();
		} catch(SQLException ex) {}
	}
%>
