package mira.contract;

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

public class ContractMgr {
    private static ContractMgr instance = new ContractMgr();
    
    public static ContractMgr getInstance() {
        return instance;
    }
    
    private ContractMgr() {}
    private static String POOLNAME = "pool";
         
    
	public void insertContract(ContractBeen  board)  throws BoardMgrException {
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
				rsGroup = stmtGroup.executeQuery("select max(GROUP_ID) from contract");                
					int maxGroupId = 0;                
					if (rsGroup.next()) {
                    maxGroupId = rsGroup.getInt(1); 
				}
                maxGroupId++;
                
                board.setGroupId(maxGroupId);
                board.setOrderNo(0);
            } else {
               
                
				pstmtOrder = conn.prepareStatement( "select max(ORDER_NO) from contract "
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
					"update contract set ORDER_NO = ORDER_NO + 1 "	+
					"where GROUP_ID = ? and ORDER_NO >= ?");
                pstmtOrderUpdate.setInt(1, board.getGroupId());                 
				pstmtOrderUpdate.setInt(2, board.getOrderNo());                
				pstmtOrderUpdate.executeUpdate();
            }
           
            board.setBseq(Sequencer.nextId(conn,"contract"));	
            pstmtInsertMessage = conn.prepareStatement( "insert into contract values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pstmtInsertMessage.setInt(1, board.getBseq());
            pstmtInsertMessage.setInt(2, board.getGroupId());
            pstmtInsertMessage.setInt(3, board.getOrderNo());
            pstmtInsertMessage.setInt(4, board.getLevel());             
			pstmtInsertMessage.setInt(5, board.getParentId());
            pstmtInsertMessage.setTimestamp(6, board.getRegister());
            pstmtInsertMessage.setInt(7, board.getMseq());  
            pstmtInsertMessage.setString(8, board.getKubun());	         
            pstmtInsertMessage.setString(9, board.getKanri_no()); 	         					            
			pstmtInsertMessage.setString(10, board.getContract_kind());	
			pstmtInsertMessage.setString(11, board.getContent());	
			pstmtInsertMessage.setString(12, board.getContact());
			pstmtInsertMessage.setString(13, board.getTitle());				
			pstmtInsertMessage.setString(14, board.getSekining_nm());			
			pstmtInsertMessage.setInt(15, board.getSekining_mseq());
			pstmtInsertMessage.setString(16, board.getHizuke());						
			pstmtInsertMessage.setString(17, board.getDate_begin());	
			pstmtInsertMessage.setString(18, board.getDate_end());
			pstmtInsertMessage.setString(19, board.getRenewal());			
			pstmtInsertMessage.setInt(20, board.getRenewal_yn());			
			pstmtInsertMessage.setString(21, board.getComment());
			pstmtInsertMessage.setString(22, board.getFile_nm());
			        
			pstmtInsertMessage.executeUpdate();
			
			conn.commit();
        } catch(SQLException ex) { try {conn.rollback();} catch(SQLException ex1) {}
            throw new BoardMgrException("contract Insert", ex);
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

public ContractBeen select(int id) throws BoardMgrException {
        Connection conn = null; 
       
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
		PreparedStatement pstmtContent = null;
        ResultSet rsContent = null; 
 
		      
        try {
            ContractBeen board = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmtMessage = conn.prepareStatement(
                "select * from contract "+
                "where BSEQ = ? ");
            pstmtMessage.setInt(1, id); 
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new ContractBeen();					
                    board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                    
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));
                    board.setRegister(rsMessage.getTimestamp("REGISTER"));
					board.setMseq(rsMessage.getInt("mseq"));
					board.setKubun(rsMessage.getString("kubun"));
                    board.setKanri_no(rsMessage.getString("kanri_no"));					
					board.setContract_kind(rsMessage.getString("contract_kind"));  
					board.setContent(rsMessage.getString("content"));
					board.setContact(rsMessage.getString("contact"));
					board.setTitle(rsMessage.getString("title"));
					board.setSekining_nm(rsMessage.getString("sekining_nm"));	
					board.setSekining_mseq(rsMessage.getInt("sekining_mseq"));
					board.setHizuke(rsMessage.getString("hizuke"));
					board.setDate_begin(rsMessage.getString("date_begin"));
					board.setDate_end(rsMessage.getString("date_end"));
					board.setRenewal(rsMessage.getString("renewal"));					
					board.setRenewal_yn(rsMessage.getInt("renewal_yn"));					
					board.setComment(rsMessage.getString("comment"));
					board.setFile_nm(rsMessage.getString("file_nm"));
               
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
                "select kanri_no from contract  where kanri_no = ?");
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
                "select count(BSEQ) as cnt from contract where kanri_no = ? ");
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
                "select count(BSEQ) as cnt from contract where kanri_no = ? and BSEQ=?");
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
public void update1(ContractBeen board) throws BoardMgrException {
        Connection conn = null; 
        
		PreparedStatement pstmtInsertMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtInsertMessage = conn.prepareStatement( 
				"update contract set kanri_no=?,contract_kind=?,content=?,contact=?,title=?,sekining_nm=?, "+
				"sekining_mseq=?,hizuke=?,date_begin=?,date_end=?,renewal=?,renewal_yn=?,comment=? ,file_nm=?  "+
				"where BSEQ=?");  
            pstmtInsertMessage.setString(1, board.getKanri_no()); 	         					            
			pstmtInsertMessage.setString(2, board.getContract_kind());	
			pstmtInsertMessage.setString(3, board.getContent());	
			pstmtInsertMessage.setString(4, board.getContact());
			pstmtInsertMessage.setString(5, board.getTitle());				
			pstmtInsertMessage.setString(6, board.getSekining_nm());			
			pstmtInsertMessage.setInt(7, board.getSekining_mseq());
			pstmtInsertMessage.setString(8, board.getHizuke());						
			pstmtInsertMessage.setString(9, board.getDate_begin());	
			pstmtInsertMessage.setString(10, board.getDate_end());
			pstmtInsertMessage.setString(11, board.getRenewal());			
			pstmtInsertMessage.setInt(12, board.getRenewal_yn());			
			pstmtInsertMessage.setString(13, board.getComment());
			pstmtInsertMessage.setString(14, board.getFile_nm());
			pstmtInsertMessage.setInt(15, board.getBseq());
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

public void update2(ContractBeen board) throws BoardMgrException {
        Connection conn = null; 
        
		PreparedStatement pstmtInsertMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtInsertMessage = conn.prepareStatement( 
				"update contract set kanri_no=?,contract_kind=?,content=?,contact=?,title=?,sekining_nm=?, "+
				"sekining_mseq=?,hizuke=?,date_begin=?,date_end=?,renewal=?,renewal_yn=?,comment=? "+
				"where BSEQ=?");
            
            pstmtInsertMessage.setString(1, board.getKanri_no()); 	         					            
			pstmtInsertMessage.setString(2, board.getContract_kind());	
			pstmtInsertMessage.setString(3, board.getContent());	
			pstmtInsertMessage.setString(4, board.getContact());
			pstmtInsertMessage.setString(5, board.getTitle());				
			pstmtInsertMessage.setString(6, board.getSekining_nm());			
			pstmtInsertMessage.setInt(7, board.getSekining_mseq());
			pstmtInsertMessage.setString(8, board.getHizuke());						
			pstmtInsertMessage.setString(9, board.getDate_begin());	
			pstmtInsertMessage.setString(10, board.getDate_end());
			pstmtInsertMessage.setString(11, board.getRenewal());			
			pstmtInsertMessage.setInt(12, board.getRenewal_yn());			
			pstmtInsertMessage.setString(13, board.getComment());			
			pstmtInsertMessage.setInt(14, board.getBseq());
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
            
			query.append("select count(*) from contract ");
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
            
			query.append("select * from contract ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i)); 
                    
						if (i < whereCond.size() -1 ) { 
                        
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by cast(substring_index( kanri_no,'-',-1 ) as unsigned) asc limit ?, ?");
            
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
                    ContractBeen board = new ContractBeen();
                    board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                    
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));
                    board.setRegister(rsMessage.getTimestamp("REGISTER"));
					board.setMseq(rsMessage.getInt("mseq"));
					board.setKubun(rsMessage.getString("kubun"));
                    board.setKanri_no(rsMessage.getString("kanri_no"));					
					board.setContract_kind(rsMessage.getString("contract_kind"));  
					board.setContent(rsMessage.getString("content"));
					board.setContact(rsMessage.getString("contact"));
					board.setTitle(rsMessage.getString("title"));
					board.setSekining_nm(rsMessage.getString("sekining_nm"));	
					board.setSekining_mseq(rsMessage.getInt("sekining_mseq"));
					board.setHizuke(rsMessage.getString("hizuke"));
					board.setDate_begin(rsMessage.getString("date_begin"));
					board.setDate_end(rsMessage.getString("date_end"));
					board.setRenewal(rsMessage.getString("renewal"));					
					board.setRenewal_yn(rsMessage.getInt("renewal_yn"));					
					board.setComment(rsMessage.getString("comment"));
					board.setFile_nm(rsMessage.getString("file_nm"));
										
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
public List listConKubun() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract group by kubun order by BSEQ asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setKubun(rs.getString("kubun"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listConKubun", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//갱신형태
public List listKousin() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract group by renewal order by renewal asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setRenewal(rs.getString("renewal"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listKousin", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
 }
//계약형태
public List listKind() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract group by contract_kind order by BSEQ asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setContract_kind(rs.getString("contract_kind"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listKind", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
}
public List listCode2() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(			
			"select * from contract order by cast(kanri_no as unsigned) asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
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
            throw new BoardMgrException("listCode", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listCode() throws BoardMgrException {
        Connection conn = null; 
		PreparedStatement pstmtCode = null;
        ResultSet rsCode = null;   
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(			
			"select * from contract order by cast(substring_index( kanri_no,'-',-1 ) as unsigned) asc " ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
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
            throw new BoardMgrException("listCode", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
}
public ContractBeen getCodeLimit()   throws BoardMgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * from contract order by cast(substring_index( kanri_no,'-',-1 ) as unsigned) desc limit 0,1 ");            			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                ContractBeen  board = new  ContractBeen();          
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
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

public List listContractKind() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract group by contract_kind order by contract_kind asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setContract_kind(rs.getString("contract_kind"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listContractKind", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listRenewal() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract group by renewal order by renewal asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setRenewal(rs.getString("renewal"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listRenewal", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
	public List listContact() throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract group by contact order by contact asc" ); 			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    ContractBeen  board = new  ContractBeen(); 					
					
					board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
					board.setContact(rs.getString("contact"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listContact", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
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
                "delete from contract where BSEQ = ? ");
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


//main
public List listDate_end(String beginDay, String endDay ) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract "+ 
				"WHERE (date_end between ? and ? ) "+
				"And (renewal_yn=1) order by date_end asc" ); 
			pstmt.setString(1,beginDay);
			pstmt.setString(2,endDay);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                   ContractBeen board = new ContractBeen();
                    board.setBseq(rs.getInt("BSEQ"));
                    board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));
                    board.setRegister(rs.getTimestamp("REGISTER"));
					board.setMseq(rs.getInt("mseq"));
					board.setKubun(rs.getString("kubun"));
                    board.setKanri_no(rs.getString("kanri_no"));					
					board.setContract_kind(rs.getString("contract_kind"));  
					board.setContent(rs.getString("content"));
					board.setContact(rs.getString("contact"));
					board.setTitle(rs.getString("title"));
					board.setSekining_nm(rs.getString("sekining_nm"));	
					board.setSekining_mseq(rs.getInt("sekining_mseq"));
					board.setHizuke(rs.getString("hizuke"));
					board.setDate_begin(rs.getString("date_begin"));
					board.setDate_end(rs.getString("date_end"));
					board.setRenewal(rs.getString("renewal"));					
					board.setRenewal_yn(rs.getInt("renewal_yn"));					
					board.setComment(rs.getString("comment"));
					board.setFile_nm(rs.getString("file_nm"));

					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("listDate_end", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public void dateView(int seq, int renewal_yn, int mseq) throws BoardMgrException {
        Connection conn = null;
		PreparedStatement pstmtUpdateMessage = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
       
            pstmtUpdateMessage = conn.prepareStatement( 
				"update contract set sekining_mseq=?, renewal_yn=? where BSEQ=?");            
	
			pstmtUpdateMessage.setInt(1,mseq);
			pstmtUpdateMessage.setInt(2,renewal_yn);
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












}