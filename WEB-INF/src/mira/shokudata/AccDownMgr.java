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

import mira.DBUtil;
import mira.sequence.Sequencer; 

public class AccDownMgr {
	private static AccDownMgr instance = new AccDownMgr();
	
	public static AccDownMgr getInstance() {		
		return instance;
	}
	
	private AccDownMgr() {}
	private static String POOLNAME="pool";	
	
	public void insertAccDown(Category pds)  throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		PreparedStatement pstmt2 = null;		
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setBseq(Sequencer.nextId(conn, "shoku_down"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into shoku_down  values (?,?,?,?,?)");
			pstmt.setInt(1, pds.getBseq());
			pstmt.setInt(2, pds.getFile_bseq());
			pstmt.setInt(3, pds.getMseq());
			pstmt.setTimestamp(4, pds.getRegister());			
			pstmt.setString(5, pds.getAdd_ip());
			pstmt.executeUpdate();	
			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insertDown",ex2);
		} finally {	
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex1) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
	}


/**지정한 글 불러오기**/
public Category getDown(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		Category pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from shoku_down where seq=?");
		pstmt.setInt(1, seq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new Category();
				pds.setBseq(rs.getInt("seq"));
				pds.setFile_bseq(rs.getInt("seq_acc"));
				pds.setMseq(rs.getInt("seq_mem"));
				pds.setRegister(rs.getTimestamp("register"));					
				pds.setAdd_ip(rs.getString("ip_add"));
				
			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new MgrException("get getDown", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}

/*accountig_file에 딸린 내역*/
	 public List selectDownDtail(int seq_acc) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rsMessage = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from shoku_down a inner join member b on a.seq_mem=b.mseq where seq_acc=? order by seq desc;" );
            pstmt.setInt(1,seq_acc);			
			rsMessage = pstmt.executeQuery();
            if (rsMessage.next()) {                 
				List list = new java.util.ArrayList();
				Reader reader = null; 				
                do {
                    Category pds = new Category();
                    pds.setBseq(rsMessage.getInt("seq"));
					pds.setFile_bseq(rsMessage.getInt("seq_acc"));
					pds.setMseq(rsMessage.getInt("seq_mem"));
					pds.setRegister(rsMessage.getTimestamp("register"));					
					pds.setAdd_ip(rsMessage.getString("ip_add"));
					pds.setTitle(rsMessage.getString("member_id"));
					pds.setName(rsMessage.getString("nm"));

				list.add(pds);	
                }while(rsMessage.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("selectDownDtail", ex);
        } finally {             
			if (rsMessage != null)                  
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }





}
