package mira.approval;

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

public class ApprovalMgr {
    private static ApprovalMgr instance = new ApprovalMgr();
    
    public static ApprovalMgr getInstance() {
        return instance;
    }
    
    private ApprovalMgr() {}
    private static String POOLNAME = "pool";
         
    
	public void insert(ApprovalBeen board)  throws BoardMgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);			 
            board.setBseq(Sequencer.nextId(conn, "approval"));				
			pstmt = conn.prepareStatement("insert into approval values (?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, board.getBseq());
            pstmt.setInt(2, board.getMseq());
			pstmt.setString(3, board.getCate());
			pstmt.setString(4, board.getKanri_no());
			pstmt.setString(5, board.getTitle());
			pstmt.setInt(6, board.getGenan_mseq());
			pstmt.setInt(7, board.getGian_mseq());
			pstmt.setString(8, board.getDate_submit());
			pstmt.setString(9, board.getDate_sign());
			pstmt.setString(10, board.getComment());
			pstmt.setString(11, board.getFile_nm());
            pstmt.setTimestamp(12, board.getRegister()); 								
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new BoardMgrException("insert",ex2);
		} finally {				
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
}
public ApprovalBeen select(int id) throws BoardMgrException {
        Connection conn = null;       
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        		      
        try {
            ApprovalBeen board = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmtMessage = conn.prepareStatement(
                "select * from approval where bseq = ?");
            pstmtMessage.setInt(1, id); 
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new ApprovalBeen();					
                    board.setBseq(rsMessage.getInt("bseq"));                    
					board.setMseq(rsMessage.getInt("mseq"));
					board.setCate(rsMessage.getString("cate"));
                    board.setKanri_no(rsMessage.getString("kanri_no"));
					board.setTitle(rsMessage.getString("title"));
					board.setGenan_mseq(rsMessage.getInt("genan_mseq"));  
					board.setGian_mseq(rsMessage.getInt("gian_mseq"));
					board.setDate_submit(rsMessage.getString("date_submit"));
					board.setDate_sign(rsMessage.getString("date_sign"));								
					board.setComment(rsMessage.getString("comment"));
					board.setFile_nm(rsMessage.getString("file_nm"));
					board.setRegister(rsMessage.getTimestamp("register"));
               
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
//관리번호 중복 체크
   public int checkKanri(String kanri_no)   throws BoardMgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select kanri_no from approval  where kanri_no = ?");
            pstmt.setString(1, kanri_no);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                String dbKanri_no = rs.getString("kanri_no");                
                if (dbKanri_no.compareTo(kanri_no) == 0) {
                    // 같으면 1을 리턴
                    return 1;
                } else {
                    // 다르면 0을 리턴
                    return 0;
                }
            } else {
                // 존재하지 않음 -1
                return -1;
            }
        } catch(SQLException ex) {
            throw new BoardMgrException("checkKanri", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
//수정시 관리번호 중복 체크
   public int checkKanriUpCnt(String kanri_no)   throws BoardMgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select count(bseq) as cnt from approval where kanri_no = ? ");
            pstmt.setString(1, kanri_no);			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                int cnt= rs.getInt("cnt");			       
                return cnt;              
            } else {                
                return 0;
            }
        } catch(SQLException ex) {
            throw new BoardMgrException("checkKanriUpCnt", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
	public int checkKanriUpBseq(String kanri_no,int seq)   throws BoardMgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select count(bseq) as cnt from approval where kanri_no = ? and bseq=?");
            pstmt.setString(1, kanri_no);
			pstmt.setInt(2, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                int cnt= rs.getInt("cnt");                
               
			   if (cnt == 1) {                    
                    return 1;
                } else {                    
                    return 0;
                }
            } else {                
                return 0;
            }
        } catch(SQLException ex) {
            throw new BoardMgrException("checkKanriUpBseq", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
 /*----------- 수정하기------------*/     
public void update1(ApprovalBeen board) throws BoardMgrException {
        Connection conn = null;         
		PreparedStatement pstmtInsertMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtInsertMessage = conn.prepareStatement( 
				"update approval set cate=?,kanri_no=?,title=?,genan_mseq=?, "+
				"gian_mseq=?,date_submit=?,date_sign=?,comment=? ,file_nm=?  "+
				"where bseq=?");  
            pstmtInsertMessage.setString(1, board.getCate()); 
			pstmtInsertMessage.setString(2, board.getKanri_no());
			pstmtInsertMessage.setString(3, board.getTitle());				
			pstmtInsertMessage.setInt(4, board.getGenan_mseq());			
			pstmtInsertMessage.setInt(5, board.getGian_mseq());							
			pstmtInsertMessage.setString(6, board.getDate_submit());	
			pstmtInsertMessage.setString(7, board.getDate_sign());				
			pstmtInsertMessage.setString(8, board.getComment());
			pstmtInsertMessage.setString(9, board.getFile_nm());
			pstmtInsertMessage.setInt(10, board.getBseq());
            pstmtInsertMessage.executeUpdate(); 
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new BoardMgrException("update1", ex);
        } finally {            
			if (pstmtInsertMessage != null)
			try { pstmtInsertMessage.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	

public void update2(ApprovalBeen board) throws BoardMgrException {
        Connection conn = null;         
		PreparedStatement pstmtInsertMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);            
            pstmtInsertMessage = conn.prepareStatement( 
				"update approval set cate=?,kanri_no=?,title=?,genan_mseq=?, "+
				"gian_mseq=?,date_submit=?,date_sign=?,comment=? where bseq=?");  
            pstmtInsertMessage.setString(1, board.getCate()); 
			pstmtInsertMessage.setString(2, board.getKanri_no());
			pstmtInsertMessage.setString(3, board.getTitle());				
			pstmtInsertMessage.setInt(4, board.getGenan_mseq());			
			pstmtInsertMessage.setInt(5, board.getGian_mseq());							
			pstmtInsertMessage.setString(6, board.getDate_submit());	
			pstmtInsertMessage.setString(7, board.getDate_sign());				
			pstmtInsertMessage.setString(8, board.getComment());		
			pstmtInsertMessage.setInt(9, board.getBseq());
            pstmtInsertMessage.executeUpdate();
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new BoardMgrException("update2", ex);
        } finally { 
            
			if (pstmtInsertMessage != null) 
                
			try { pstmtInsertMessage.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	

 /*---전체 리스트 시작-----*/
	public int count(List whereCond, Map valueMap)   throws BoardMgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;        
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select count(*) from approval ");
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
            
			query.append("select * from approval ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i)); 
                    
						if (i < whereCond.size() -1 ) { 
                        
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by kanri_no asc limit ?, ?");
            
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
                    ApprovalBeen board = new ApprovalBeen();
                    board.setBseq(rsMessage.getInt("bseq"));                    
					board.setMseq(rsMessage.getInt("mseq"));
					board.setCate(rsMessage.getString("cate"));
                    board.setKanri_no(rsMessage.getString("kanri_no"));
					board.setTitle(rsMessage.getString("title"));
					board.setGenan_mseq(rsMessage.getInt("genan_mseq"));  
					board.setGian_mseq(rsMessage.getInt("gian_mseq"));
					board.setDate_submit(rsMessage.getString("date_submit"));
					board.setDate_sign(rsMessage.getString("date_sign"));								
					board.setComment(rsMessage.getString("comment"));
					board.setFile_nm(rsMessage.getString("file_nm"));
					board.setRegister(rsMessage.getTimestamp("register"));
										
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


//참조 리스트들
public List listCode() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(			
			"select * from approval order by kanri_no asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ApprovalBeen  board = new  ApprovalBeen(); 					
					
					board.setBseq(rs.getInt("bseq"));                    
					board.setKanri_no(rs.getString("kanri_no"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listCode", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listCate() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(			
			"select * from approval group by cate order by bseq asc " ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ApprovalBeen  board = new  ApprovalBeen(); 					
					
					board.setBseq(rs.getInt("bseq"));                    
					board.setCate(rs.getString("cate"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listCode", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//"select * from approval order by cast(substring_index( kanri_no,'-',-1 ) as unsigned) desc limit 0,1 ");
public ApprovalBeen getCodeLimit(String yyval )   throws BoardMgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * from approval where substring(kanri_no,2,2)=? order by kanri_no desc limit 0,1 ");
			pstmt.setString(1,yyval);            			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                ApprovalBeen  board = new  ApprovalBeen();          
					board.setBseq(rs.getInt("bseq"));                    
					board.setKanri_no(rs.getString("kanri_no"));                
                return board;
            } else {               
                return null;
            }
        } catch(SQLException ex) {
            throw new BoardMgrException("getCodeLimit", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
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
                "delete from approval where bseq = ? ");
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


public List listExcel() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(			
			"select * from approval order by kanri_no asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ApprovalBeen  board = new  ApprovalBeen(); 					
					
					board.setBseq(rs.getInt("bseq"));                    
					board.setMseq(rs.getInt("mseq"));
					board.setCate(rs.getString("cate"));
                    board.setKanri_no(rs.getString("kanri_no"));
					board.setTitle(rs.getString("title"));
					board.setGenan_mseq(rs.getInt("genan_mseq"));  
					board.setGian_mseq(rs.getInt("gian_mseq"));
					board.setDate_submit(rs.getString("date_submit"));
					board.setDate_sign(rs.getString("date_sign"));								
					board.setComment(rs.getString("comment"));
					board.setFile_nm(rs.getString("file_nm"));
					board.setRegister(rs.getTimestamp("register"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listExcel", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }






}