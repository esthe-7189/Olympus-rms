package mira.form;

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

public class FormManager {
    private static FormManager instance = new FormManager();
    
    public static FormManager getInstance() {
        return instance;
    }
    
    private FormManager() {}
    private static String POOLNAME = "pool";


public void insertBoard(FormBeen board)  throws BoardMgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);			 
            board.setBseq(Sequencer.nextId(conn, "forms"));				
			pstmt = conn.prepareStatement("insert into forms values (?,?,?,?,?)");
			pstmt.setInt(1, board.getBseq());
            pstmt.setInt(2, board.getMseq());            
            pstmt.setTimestamp(3, board.getRegister());            
			pstmt.setString(4, board.getTitle());			
			pstmt.setString(5, board.getFilenm());		
					
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new BoardMgrException("insertBoard",ex2);
		} finally {				
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
}

public void update1(FormBeen board) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt= null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmt = conn.prepareStatement( 
				"update forms set title=?,filenm=? where bseq=?");
            
            pstmt.setString(1, board.getTitle());			
            pstmt.setString(2, board.getFilenm());			
            pstmt.setInt(3, board.getBseq());
            pstmt.executeUpdate(); 
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new BoardMgrException("update01", ex);
        } finally {            
			if (pstmt != null)                
			try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	

public void update2(FormBeen board) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt= null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmt = conn.prepareStatement( 
				"update forms set title=? where bseq=?");
            
            pstmt.setString(1, board.getTitle());           
            pstmt.setInt(3, board.getBseq());
            pstmt.executeUpdate(); 
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new BoardMgrException("update02", ex);
        } finally {            
			if (pstmt != null)                
			try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	


    /*** 리스트 카운트 */    
	public int count(List whereCond, Map valueMap)   throws BoardMgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;        
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select count(*) from forms ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where "); 
               
					for (int i = 0 ; i < whereCond.size() ; i++) {
							query.append(whereCond.get(i)); 
                    
							if (i < whereCond.size() -1 ) { 
                        
							query.append(" or ");
                    }
                }
            }
            pstmt = conn.prepareStatement(query.toString());
            
            Iterator keyIter = valueMap.keySet().iterator();
            while(keyIter.hasNext()) {
                Integer key = (Integer)keyIter.next();
                Object obj = valueMap.get(key); 
                
					if (obj instanceof String) {
                    pstmt.setString(key.intValue(), (String)obj);
					} else if (obj instanceof Integer) {
						pstmt.setInt(key.intValue(), ((Integer)obj).intValue());
					} else if (obj instanceof Timestamp) {
						pstmt.setTimestamp(key.intValue(), (Timestamp)obj);
					}
            }
            
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new BoardMgrException("count", ex);
        } finally { 
            if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
  
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws BoardMgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;        
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select * from forms ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i)); 
                    
						if (i < whereCond.size() -1 ) { 
                        
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by bseq desc limit ?, ?");
            
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmtMessage = conn.prepareStatement(query.toString()); 
           
			Iterator keyIter = valueMap.keySet().iterator();
            while(keyIter.hasNext()) {
                Integer key = (Integer)keyIter.next();
                Object obj = valueMap.get(key); 
               
					if (obj instanceof String) {
						pstmtMessage.setString(key.intValue(), (String)obj);
						 } else if (obj instanceof Integer) {
						pstmtMessage.setInt(key.intValue(), 
                                        ((Integer)obj).intValue()); 
               
						} else if (obj instanceof Timestamp) {
						pstmtMessage.setTimestamp(key.intValue(),
                                          (Timestamp)obj);
                }
            }
            
            pstmtMessage.setInt(valueMap.size()+1, startRow);
            pstmtMessage.setInt(valueMap.size()+2, endRow-startRow+1);
            
            rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
                
				List list = new java.util.ArrayList(endRow-startRow+1); 
 
				Reader reader = null;              
                do {
                    FormBeen board = new FormBeen();
                    board.setBseq(rsMessage.getInt("bseq"));   
					board.setMseq(rsMessage.getInt("mseq")); 
					board.setTitle(rsMessage.getString("title"));
					board.setRegister(rsMessage.getTimestamp("register"));					
					board.setFilenm(rsMessage.getString("filenm"));					
					
                    list.add(board);
                } while(rsMessage.next());                
                return list;                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new BoardMgrException("selectList", ex);
        } finally { 
			if (rsMessage != null)
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
        
	public FormBeen select(int id) throws BoardMgrException {
        Connection conn = null;       
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
		      
        try {
            FormBeen board = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmtMessage = conn.prepareStatement(
                "select * from forms where bseq = ?");
            pstmtMessage.setInt(1, id); 
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new FormBeen();				
                
                    board.setBseq(rsMessage.getInt("bseq"));   
					board.setMseq(rsMessage.getInt("mseq")); 
					board.setTitle(rsMessage.getString("title"));
					board.setRegister(rsMessage.getTimestamp("register"));					
					board.setFilenm(rsMessage.getString("filenm"));				
               
                return board;
            } else {
                return null;
            }
        } catch(SQLException ex) {
            throw new BoardMgrException("select", ex);
        } finally { 
            
			if (rsMessage != null)  
                
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
   
    public void delete(int id) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmtMessage = null;   
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);            
			
			pstmtMessage = conn.prepareStatement(
                "delete from forms where bseq = ? ");
			pstmtMessage.setInt(1, id);			
			pstmtMessage.executeUpdate();			

        } catch(SQLException ex) {
            try {
                conn.rollback();
				 } catch(SQLException ex1) {}
            throw new BoardMgrException("delete", ex);
        } finally { 
            
			if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {}
            if (conn != null)
                try {
                    conn.setAutoCommit(true);
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }


}