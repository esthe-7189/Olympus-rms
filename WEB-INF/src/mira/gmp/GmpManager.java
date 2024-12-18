package mira.gmp;

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

public class GmpManager {
    private static GmpManager instance = new GmpManager();
    
    public static GmpManager getInstance() {
        return instance;
    }
    
    private GmpManager() {}
    private static String POOLNAME = "pool";
         
    
	public void insertBoard(GmpBeen  board)  throws BoardMgrException {
        Connection conn = null;  
        Statement stmtGroup = null;         
		ResultSet rsGroup = null;
        
        
        PreparedStatement pstmtOrder = null;
        ResultSet rsOrder = null;
        PreparedStatement pstmtOrderUpdate = null;
        
        
		PreparedStatement pstmtInsertMessage = null;        

	  try {
				 conn = DBUtil.getConnection(POOLNAME);
				 conn.setAutoCommit(false);
         
            if (board.getParentId() ==0) {                 
                stmtGroup = conn.createStatement();                
				rsGroup = stmtGroup.executeQuery("select max(GROUP_ID) from gmpitem");                
					int maxGroupId = 0;                
					if (rsGroup.next()) {
                    maxGroupId = rsGroup.getInt(1); 
				}
                maxGroupId++;
                
                board.setGroupId(maxGroupId);
                board.setOrderNo(0);
            } else {
               
                
				pstmtOrder = conn.prepareStatement( "select max(ORDER_NO) from gmpitem "
				+"where PARENT_ID = ? or BSEQ = ?"); 
                
				pstmtOrder.setInt(1, board.getParentId());
                pstmtOrder.setInt(2, board.getParentId());
                rsOrder = pstmtOrder.executeQuery();
                int maxOrder = 0;
                if (rsOrder.next()) {
                    maxOrder = rsOrder.getInt(1);
                }
                maxOrder ++;
                board.setOrderNo(maxOrder); 	}
            
           
            if (board.getOrderNo() > 0) {
                pstmtOrderUpdate = conn.prepareStatement(
					"update gmpitem set ORDER_NO = ORDER_NO + 1 "	+
					"where GROUP_ID = ? and ORDER_NO >= ?");
                pstmtOrderUpdate.setInt(1, board.getGroupId());                 
				pstmtOrderUpdate.setInt(2, board.getOrderNo());                
				pstmtOrderUpdate.executeUpdate();
            }
           
            board.setBseq(Sequencer.nextId(conn,"gmpitem"));	
            pstmtInsertMessage = conn.prepareStatement( "insert into gmpitem values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pstmtInsertMessage.setInt(1, board.getBseq());
            pstmtInsertMessage.setInt(2, board.getGroupId());
            pstmtInsertMessage.setInt(3, board.getOrderNo());
            pstmtInsertMessage.setInt(4, board.getLevel());             
			pstmtInsertMessage.setInt(5, board.getParentId());
            pstmtInsertMessage.setTimestamp(6, board.getRegister());
            pstmtInsertMessage.setString(7, board.getKanri_no()); 			
			pstmtInsertMessage.setInt(8, board.getEda_no());  
            pstmtInsertMessage.setString(9, board.getGigi_nm());	
			pstmtInsertMessage.setString(10, board.getProduct_nm());	
			pstmtInsertMessage.setString(11, board.getSeizomoto());	
			pstmtInsertMessage.setString(12, board.getKatachi_no());
			pstmtInsertMessage.setString(13, board.getSeizo_no());	
			pstmtInsertMessage.setString(14, board.getPlace());
			pstmtInsertMessage.setString(15, board.getSekining_nm());
			pstmtInsertMessage.setInt(16, board.getMseq());
			pstmtInsertMessage.setInt(17, board.getMseq2());
			pstmtInsertMessage.setInt(18, board.getHindo());				
			pstmtInsertMessage.setString(19, board.getDate01());	
			pstmtInsertMessage.setString(20, board.getDate02());
			pstmtInsertMessage.setString(21, board.getFile_manual());			
			pstmtInsertMessage.setInt(22, board.getDate01_yn());
			pstmtInsertMessage.setInt(23, board.getDate02_yn());	
			pstmtInsertMessage.setString(24, board.getComment());	
			        
			pstmtInsertMessage.executeUpdate();
			
			conn.commit();
        } catch(SQLException ex) { try {conn.rollback();} catch(SQLException ex1) {}
            throw new BoardMgrException("gmpitem Insert", ex);
        } finally {             
			if (rsGroup != null)  try { rsGroup.close(); } catch(SQLException ex) {}             
			if (stmtGroup != null)  try { stmtGroup.close(); } catch(SQLException ex) {} 
            if (rsOrder != null)   try { rsOrder.close(); } catch(SQLException ex) {}              
			if (pstmtOrder != null) 	try { pstmtOrder.close(); } catch(SQLException ex) {} 
            if (pstmtOrderUpdate != null)   try { pstmtOrderUpdate.close(); } catch(SQLException ex) {} 
            if (pstmtInsertMessage!= null)   try { pstmtInsertMessage.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {}         	
       }
	}

  /*** 수정하기*/     
public void update1(GmpBeen board) throws BoardMgrException {
        Connection conn = null; 
        
		PreparedStatement pstmtUpdateMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtUpdateMessage = conn.prepareStatement( 
				"update gmpitem set kanri_no=?,eda_no=?,gigi_nm=?,product_nm=?,seizomoto=?,katachi_no=?, "+
				"seizo_no=?,place=?,sekining_nm=?,hindo=?,date01=?,date02=?,file_manual=? ,date01_yn=?,date02_yn=?,comment=? "+
				"where BSEQ=?");
            
            pstmtUpdateMessage.setString(1, board.getKanri_no());      
			pstmtUpdateMessage.setInt(2, board.getEda_no());      
            pstmtUpdateMessage.setString(3, board.getGigi_nm());
			pstmtUpdateMessage.setString(4, board.getProduct_nm());
			pstmtUpdateMessage.setString(5, board.getSeizomoto());
			pstmtUpdateMessage.setString(6, board.getKatachi_no());
			pstmtUpdateMessage.setString(7, board.getSeizo_no());
			pstmtUpdateMessage.setString(8, board.getPlace());
			pstmtUpdateMessage.setString(9, board.getSekining_nm());
			pstmtUpdateMessage.setInt(10, board.getHindo());
			pstmtUpdateMessage.setString(11, board.getDate01());
			pstmtUpdateMessage.setString(12, board.getDate02());
			pstmtUpdateMessage.setString(13, board.getFile_manual());	
			pstmtUpdateMessage.setInt(14, board.getDate01_yn());
			pstmtUpdateMessage.setInt(15, board.getDate02_yn());
			pstmtUpdateMessage.setString(16, board.getComment());	
            pstmtUpdateMessage.setInt(17, board.getBseq());
            pstmtUpdateMessage.executeUpdate(); 
            
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new BoardMgrException("update1", ex);
        } finally { 
            
			if (pstmtUpdateMessage != null) 
                
			try { pstmtUpdateMessage.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	

public void update2(GmpBeen board) throws BoardMgrException {
        Connection conn = null; 
        
		PreparedStatement pstmtUpdateMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtUpdateMessage = conn.prepareStatement( 
				"update gmpitem set kanri_no=?,eda_no=?,gigi_nm=?,product_nm=?,seizomoto=?,katachi_no=?, "+
				"seizo_no=?,place=?,sekining_nm=?,hindo=?,date01=?,date02=?,date01_yn=?,date02_yn=?, comment=? where BSEQ=?");
            
            pstmtUpdateMessage.setString(1, board.getKanri_no());      
			pstmtUpdateMessage.setInt(2, board.getEda_no());      
            pstmtUpdateMessage.setString(3, board.getGigi_nm());
			pstmtUpdateMessage.setString(4, board.getProduct_nm());
			pstmtUpdateMessage.setString(5, board.getSeizomoto());
			pstmtUpdateMessage.setString(6, board.getKatachi_no());
			pstmtUpdateMessage.setString(7, board.getSeizo_no());
			pstmtUpdateMessage.setString(8, board.getPlace());
			pstmtUpdateMessage.setString(9, board.getSekining_nm());
			pstmtUpdateMessage.setInt(10, board.getHindo());
			pstmtUpdateMessage.setString(11, board.getDate01());
			pstmtUpdateMessage.setString(12, board.getDate02());
			pstmtUpdateMessage.setInt(13, board.getDate01_yn());
			pstmtUpdateMessage.setInt(14, board.getDate02_yn());
			pstmtUpdateMessage.setString(15, board.getComment());	
            pstmtUpdateMessage.setInt(16, board.getBseq());
            pstmtUpdateMessage.executeUpdate(); 
            
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new BoardMgrException("update2", ex);
        } finally { 
            
			if (pstmtUpdateMessage != null) 
                
			try { pstmtUpdateMessage.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	

public void dateView(int seq, int dateKind, int dateYn, int mseq) throws BoardMgrException {
        Connection conn = null;
		PreparedStatement pstmtUpdateMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
    if(dateKind==1){        
            pstmtUpdateMessage = conn.prepareStatement( 
				"update gmpitem set sekining_mseq=?, date01_yn=? where BSEQ=?");            
	}else if(dateKind==2){
			pstmtUpdateMessage = conn.prepareStatement( 
				"update gmpitem set sekining_mseq2=?, date02_yn=? where BSEQ=?");    
	}
			pstmtUpdateMessage.setInt(1,mseq);
			pstmtUpdateMessage.setInt(2,dateYn);
            pstmtUpdateMessage.setInt(3,seq);
            pstmtUpdateMessage.executeUpdate();            
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new BoardMgrException("dateView", ex);
        } finally { 
            
			if (pstmtUpdateMessage != null) 
                
			try { pstmtUpdateMessage.close(); } catch(SQLException ex) {}            
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	
//관리번호 중복 체크
   public int checkKanri(int bseq , String kanri_no)   throws BoardMgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select kanri_no from gmpitem  where BSEQ = ?");
            pstmt.setInt(1, bseq);
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

    /*** 리스트 카운트 */ 
    
	public int count(List whereCond, Map valueMap)   throws BoardMgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;        
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select count(*) from gmpitem ");
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
    
    /**리스트   */ 
    
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws BoardMgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;        
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select * from gmpitem ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i)); 
                    
						if (i < whereCond.size() -1 ) { 
                        
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by kanri_no asc, eda_no asc limit ?, ?");
            
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
                    GmpBeen board = new GmpBeen();
                    board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                    
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));
                    board.setRegister(rsMessage.getTimestamp("REGISTER"));
                    board.setKanri_no(rsMessage.getString("kanri_no"));                    
					board.setEda_no(rsMessage.getInt("eda_no"));  
					board.setGigi_nm(rsMessage.getString("gigi_nm"));
					board.setProduct_nm(rsMessage.getString("product_nm"));
					board.setSeizomoto(rsMessage.getString("seizomoto"));
					board.setKatachi_no(rsMessage.getString("katachi_no"));
					board.setSeizo_no(rsMessage.getString("seizo_no"));
					board.setPlace(rsMessage.getString("place"));
					board.setMseq(rsMessage.getInt("sekining_mseq"));
					board.setSekining_nm(rsMessage.getString("sekining_nm"));					
					board.setHindo(rsMessage.getInt("hindo"));
					board.setDate01(rsMessage.getString("date01")); 
					board.setDate02(rsMessage.getString("date02")); 
					board.setFile_manual(rsMessage.getString("file_manual"));
					board.setDate01_yn(rsMessage.getInt("date01_yn"));
					board.setDate02_yn(rsMessage.getInt("date02_yn"));
					board.setComment(rsMessage.getString("comment"));
					
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
    
        
	public GmpBeen select(int id) throws BoardMgrException {
        Connection conn = null; 
       
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
		PreparedStatement pstmtContent = null;
        ResultSet rsContent = null; 
 
		      
        try {
            GmpBeen board = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmtMessage = conn.prepareStatement(
                "select * from gmpitem "+
                "where BSEQ = ?");
            pstmtMessage.setInt(1, id); 
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new GmpBeen();
					
                    board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                    
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));
                    board.setRegister(rsMessage.getTimestamp("REGISTER"));
                    board.setKanri_no(rsMessage.getString("kanri_no"));                    
					board.setEda_no(rsMessage.getInt("eda_no"));  
					board.setGigi_nm(rsMessage.getString("gigi_nm"));
					board.setProduct_nm(rsMessage.getString("product_nm"));
					board.setSeizomoto(rsMessage.getString("seizomoto"));
					board.setKatachi_no(rsMessage.getString("katachi_no"));
					board.setSeizo_no(rsMessage.getString("seizo_no"));
					board.setPlace(rsMessage.getString("place"));
					board.setMseq(rsMessage.getInt("sekining_mseq"));
					board.setSekining_nm(rsMessage.getString("sekining_nm"));					
					board.setHindo(rsMessage.getInt("hindo"));
					board.setDate01(rsMessage.getString("date01")); 
					board.setDate02(rsMessage.getString("date02")); 
					board.setFile_manual(rsMessage.getString("file_manual"));
					board.setDate01_yn(rsMessage.getInt("date01_yn"));
					board.setDate02_yn(rsMessage.getInt("date02_yn"));
					board.setComment(rsMessage.getString("comment"));
               
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
                "delete from gmpitem where BSEQ = ? ");
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

public List listKanri() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem group by kanri_no order by kanri_no asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setKanri_no(rs.getString("kanri_no"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listKanri", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listEda(String id) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem where kanri_no=? group by eda_no order by eda_no asc" ); 	
			pstmt.setString(1, id);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setEda_no(rs.getInt("eda_no"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listEda", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public List listGigi() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem group by gigi_nm order by kanri_no " );						
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setGigi_nm(rs.getString("gigi_nm"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listGigi", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public List listProductNm() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem group by product_nm order by kanri_no " );					
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setProduct_nm(rs.getString("product_nm"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listProductNm", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listSeizoMoto() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem group by seizomoto order by kanri_no " );					
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setSeizomoto(rs.getString("seizomoto"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listSeizoMoto", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listKatachiNo() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem group by katachi_no order by kanri_no " );					
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setKatachi_no(rs.getString("katachi_no"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listKatachiNo", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listPlace() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem group by place order by kanri_no " );					
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setPlace(rs.getString("place"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listPlace", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public GmpBeen getKanriLimit() throws BoardMgrException {
        Connection conn = null; 
       
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null;
		      
        try {
            GmpBeen board = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmtMessage = conn.prepareStatement(
                "select * from gmpitem group by kanri_no order by kanri_no asc limit 0,1");            
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new GmpBeen();					
                    board.setBseq(rsMessage.getInt("BSEQ"));  
					board.setKanri_no(rsMessage.getString("kanri_no")); 
               
                return board;
            } else {
                return null;
            }
        } catch(SQLException ex) {
            throw new BoardMgrException("getKanriLimit", ex);
        } finally { 
            
			if (rsMessage != null)                
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public List listDate01(String beginDay, String endDay ) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem "+ 
				"WHERE (date01 between ? and ? ) "+
				"And (date01_yn=1) order by date01 asc" ); 
			pstmt.setString(1,beginDay);
			pstmt.setString(2,endDay);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
                    board.setRegister(rs.getTimestamp("REGISTER"));
                    board.setKanri_no(rs.getString("kanri_no"));                    
					board.setEda_no(rs.getInt("eda_no"));  
					board.setGigi_nm(rs.getString("gigi_nm"));
					board.setProduct_nm(rs.getString("product_nm"));
					board.setSeizomoto(rs.getString("seizomoto"));
					board.setKatachi_no(rs.getString("katachi_no"));
					board.setSeizo_no(rs.getString("seizo_no"));
					board.setPlace(rs.getString("place"));
					board.setMseq(rs.getInt("sekining_mseq"));
					board.setSekining_nm(rs.getString("sekining_nm"));					
					board.setHindo(rs.getInt("hindo"));
					board.setDate01(rs.getString("date01")); 
					board.setDate02(rs.getString("date02")); 
					board.setFile_manual(rs.getString("file_manual")); 
					board.setDate01_yn(rs.getInt("date01_yn"));
					board.setDate02_yn(rs.getInt("date02_yn"));
					board.setComment(rs.getString("comment"));

					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listDate01", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public List listDate02(String beginDay, String endDay ) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem "+ 
				"WHERE (date02 between ? and ? ) "+
				"And (date02_yn=1) order by date02 asc" ); 
			pstmt.setString(1,beginDay);
			pstmt.setString(2,endDay);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
                    board.setRegister(rs.getTimestamp("REGISTER"));
                    board.setKanri_no(rs.getString("kanri_no"));                    
					board.setEda_no(rs.getInt("eda_no"));  
					board.setGigi_nm(rs.getString("gigi_nm"));
					board.setProduct_nm(rs.getString("product_nm"));
					board.setSeizomoto(rs.getString("seizomoto"));
					board.setKatachi_no(rs.getString("katachi_no"));
					board.setSeizo_no(rs.getString("seizo_no"));
					board.setPlace(rs.getString("place"));
					board.setMseq(rs.getInt("sekining_mseq"));
					board.setSekining_nm(rs.getString("sekining_nm"));					
					board.setHindo(rs.getInt("hindo"));
					board.setDate01(rs.getString("date01")); 
					board.setDate02(rs.getString("date02")); 
					board.setFile_manual(rs.getString("file_manual")); 
					board.setDate01_yn(rs.getInt("date01_yn"));
					board.setDate02_yn(rs.getInt("date02_yn"));
					board.setComment(rs.getString("comment"));

					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listDate02", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listDatePast01(String beginDay, String endDay ) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem "+ 
				"WHERE (date01 between ? and ? ) "+
				"And (date01_yn=1) order by date01 asc" ); 
			pstmt.setString(1,beginDay);
			pstmt.setString(2,endDay);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
                    board.setRegister(rs.getTimestamp("REGISTER"));
                    board.setKanri_no(rs.getString("kanri_no"));                    
					board.setEda_no(rs.getInt("eda_no"));  
					board.setGigi_nm(rs.getString("gigi_nm"));
					board.setProduct_nm(rs.getString("product_nm"));
					board.setSeizomoto(rs.getString("seizomoto"));
					board.setKatachi_no(rs.getString("katachi_no"));
					board.setSeizo_no(rs.getString("seizo_no"));
					board.setPlace(rs.getString("place"));
					board.setMseq(rs.getInt("sekining_mseq"));
					board.setSekining_nm(rs.getString("sekining_nm"));					
					board.setHindo(rs.getInt("hindo"));
					board.setDate01(rs.getString("date01")); 
					board.setDate02(rs.getString("date02")); 
					board.setFile_manual(rs.getString("file_manual")); 
					board.setDate01_yn(rs.getInt("date01_yn"));
					board.setDate02_yn(rs.getInt("date02_yn"));
					board.setComment(rs.getString("comment"));

					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listDatePast01", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listDatePast02(String beginDay, String endDay ) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem "+ 
				"WHERE (date02 between ? and ? ) "+
				"And (date02_yn=1) order by date02 asc" ); 
			pstmt.setString(1,beginDay);
			pstmt.setString(2,endDay);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
                    board.setRegister(rs.getTimestamp("REGISTER"));
                    board.setKanri_no(rs.getString("kanri_no"));                    
					board.setEda_no(rs.getInt("eda_no"));  
					board.setGigi_nm(rs.getString("gigi_nm"));
					board.setProduct_nm(rs.getString("product_nm"));
					board.setSeizomoto(rs.getString("seizomoto"));
					board.setKatachi_no(rs.getString("katachi_no"));
					board.setSeizo_no(rs.getString("seizo_no"));
					board.setPlace(rs.getString("place"));
					board.setMseq(rs.getInt("sekining_mseq"));
					board.setSekining_nm(rs.getString("sekining_nm"));					
					board.setHindo(rs.getInt("hindo"));
					board.setDate01(rs.getString("date01")); 
					board.setDate02(rs.getString("date02")); 
					board.setFile_manual(rs.getString("file_manual")); 
					board.setDate01_yn(rs.getInt("date01_yn"));
					board.setDate02_yn(rs.getInt("date02_yn"));
					board.setComment(rs.getString("comment"));

					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listDatePast02", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public List listExcel() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from gmpitem order by kanri_no,eda_no asc " ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    GmpBeen  board = new  GmpBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
                    board.setRegister(rs.getTimestamp("REGISTER"));
                    board.setKanri_no(rs.getString("kanri_no"));                    
					board.setEda_no(rs.getInt("eda_no"));  
					board.setGigi_nm(rs.getString("gigi_nm"));
					board.setProduct_nm(rs.getString("product_nm"));
					board.setSeizomoto(rs.getString("seizomoto"));
					board.setKatachi_no(rs.getString("katachi_no"));
					board.setSeizo_no(rs.getString("seizo_no"));
					board.setPlace(rs.getString("place"));
					board.setMseq(rs.getInt("sekining_mseq"));
					board.setSekining_nm(rs.getString("sekining_nm"));					
					board.setHindo(rs.getInt("hindo"));
					board.setDate01(rs.getString("date01")); 
					board.setDate02(rs.getString("date02")); 
					board.setFile_manual(rs.getString("file_manual")); 
					board.setDate01_yn(rs.getInt("date01_yn"));
					board.setDate02_yn(rs.getInt("date02_yn"));
					board.setComment(rs.getString("comment"));

					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listDate01", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
/*
public List listYMD(String yymmVal,String busho) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT distinct(substring(hizuke,1,10)) as hizukedb , a.hizuke "+
				"FROM jangyo a "+
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE (substring(hizuke,1,7)=?) and (b.busho=?) and (b.member_yn=2) order by substring(hizuke,1,10) asc" );  
			pstmt.setString(1,yymmVal);
			pstmt.setString(2,busho);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanJangyo  member = new  DataBeanJangyo();                    
					member.setHizuke(rs.getString("hizukedb"));
					member.setSign_no_riyu(rs.getString("hizuke"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("selectList", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
*/

}