package mira.seizo;

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

public class CommentMgr {
    private static CommentMgr instance = new CommentMgr();
    
    public static CommentMgr getInstance() {
        return instance;
    }
    
    private CommentMgr() {}
    private static String POOLNAME = "pool";
         
    
		  public void insertBoard(Category  board)  throws MgrException {
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
				rsGroup = stmtGroup.executeQuery("select max(GROUP_ID) from seizo_comment");                
					int maxGroupId = 0;                
					if (rsGroup.next()) {
                    maxGroupId = rsGroup.getInt(1); 
				}
                maxGroupId++;
                
                board.setGroupId(maxGroupId);
                board.setOrderNo(0);
            } else {
               
                
				pstmtOrder = conn.prepareStatement( "select max(ORDER_NO) from seizo_comment "
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
					"update seizo_comment set ORDER_NO = ORDER_NO + 1 "	+
					"where GROUP_ID = ? and ORDER_NO >= ?");
                pstmtOrderUpdate.setInt(1, board.getGroupId());                 
				pstmtOrderUpdate.setInt(2, board.getOrderNo());                
				pstmtOrderUpdate.executeUpdate();
            }
           
            board.setBseq(Sequencer.nextId(conn,"seizo_comment"));	
            pstmtInsertMessage = conn.prepareStatement( "insert into seizo_comment  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pstmtInsertMessage.setInt(1, board.getBseq());
            pstmtInsertMessage.setInt(2, board.getGroupId());
            pstmtInsertMessage.setInt(3, board.getOrderNo());
            pstmtInsertMessage.setInt(4, board.getLevel());             
			pstmtInsertMessage.setInt(5, board.getParentId());
            pstmtInsertMessage.setTimestamp(6, board.getRegister());
            pstmtInsertMessage.setString(7, board.getName());  
			pstmtInsertMessage.setString(8, board.getMail_address());  
            pstmtInsertMessage.setString(9, board.getTitle());			
			pstmtInsertMessage.setCharacterStream(10,  new StringReader(board.getContent()), board.getContent().length());
			pstmtInsertMessage.setInt(11, board.getHit_cnt());			
			pstmtInsertMessage.setInt(12, board.getHenji_yn());
			pstmtInsertMessage.setInt(13, board.getOk_yn());	    
			pstmtInsertMessage.setString(14, board.getAdd_ip());  
			pstmtInsertMessage.setInt(15, board.getFile_bseq());	   
			pstmtInsertMessage.setInt(16, board.getFile_kind());	   
			pstmtInsertMessage.setString(17, board.getPassword());	   
			pstmtInsertMessage.executeUpdate();
			
			conn.commit();
        } catch(SQLException ex) { try {conn.rollback();} catch(SQLException ex1) {}
            throw new MgrException("seizo_comment Insert", ex);
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
    
		 public void update(Category board) throws MgrException {
        Connection conn = null;         
		PreparedStatement pstmtUpdateMessage = null;       
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtUpdateMessage = conn.prepareStatement( 
				"update seizo_comment set NM=?,MAIL_ADD=?, TITLE=?,CONTENT=?,HENJI_YN=?,OK_YN=?,IP_ADD=?   "+
				"where BSEQ=?");
            
            pstmtUpdateMessage.setString(1, board.getName());      
			pstmtUpdateMessage.setString(2, board.getMail_address());      
            pstmtUpdateMessage.setString(3, board.getTitle());
			pstmtUpdateMessage.setCharacterStream(4, new StringReader(board.getContent()), board.getContent().length());
			pstmtUpdateMessage.setInt(5, board.getHenji_yn());
			pstmtUpdateMessage.setInt(6, board.getOk_yn());
			pstmtUpdateMessage.setString(7, board.getAdd_ip());      
            pstmtUpdateMessage.setInt(8, board.getBseq());
            pstmtUpdateMessage.executeUpdate(); 
            
           
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new MgrException("update", ex);
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


    /***모든 리스트 카운트 */     
	public int count(List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select count(*) from seizo_comment ");
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
            throw new MgrException("count", ex);
        } finally { 
            if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
    /**모든 리스트   */     
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null; 
        
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select * from seizo_comment ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i)); 
                    
						if (i < whereCond.size() -1 ) { 
                        
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by GROUP_ID desc, ORDER_NO asc limit ?, ?");
            
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
                    Category board = new Category();
                    board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                    
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));
                    board.setRegister(rsMessage.getTimestamp("REGISTER"));
                    board.setName(rsMessage.getString("NM"));                    
					board.setMail_address(rsMessage.getString("MAIL_ADD"));  
					board.setTitle(rsMessage.getString("TITLE"));
					try{
							reader=rsMessage.getCharacterStream("CONTENT");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							board.setContent(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("content select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
							} 

					board.setHit_cnt(rsMessage.getInt("HIT_CNT"));					
					board.setHenji_yn(rsMessage.getInt("HENJI_YN"));
					board.setOk_yn(rsMessage.getInt("OK_YN"));
					board.setAdd_ip(rsMessage.getString("IP_ADD")); 
					board.setFile_bseq(rsMessage.getInt("FILE_BSEQ"));
					board.setFile_kind(rsMessage.getInt("FILE_KIND"));
                   
                    list.add(board);
                } while(rsMessage.next());                
                return list;                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MgrException("selectList", ex);
        } finally { 
			if (rsMessage != null)
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    /** 개별 코멘트 불러오기 카운트 */ 
	public int count(int fileBseq, int fileKind, List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select count(*) from seizo_comment  where FILE_BSEQ=? and FILE_KIND=? ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
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
            pstmt.setInt(1,fileBseq);
			pstmt.setInt(2,fileKind);
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("count", ex);
        } finally { 
            if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    } 
    /** 개별 코멘트 불러오기 리스트 */ 
   public List selectList_item(int fileBseq, int fileKind, List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select * from seizo_comment  where FILE_BSEQ=? and FILE_KIND=? ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and  "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i)); 
                    
						if (i < whereCond.size() -1 ) { 
                        
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by GROUP_ID desc, ORDER_NO asc limit ?, ?");
            
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
            pstmtMessage.setInt(valueMap.size()+1,fileBseq);
			pstmtMessage.setInt(valueMap.size()+2,fileKind);
            pstmtMessage.setInt(valueMap.size()+3, startRow);
            pstmtMessage.setInt(valueMap.size()+4, endRow-startRow+1);
            
            rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
                
				List list = new java.util.ArrayList(endRow-startRow+1); 
 
				Reader reader = null;              
                do {
                    Category board = new Category();
                    board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                    
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));
                    board.setRegister(rsMessage.getTimestamp("REGISTER"));
                    board.setName(rsMessage.getString("NM"));                    
					board.setMail_address(rsMessage.getString("MAIL_ADD"));  
					board.setTitle(rsMessage.getString("TITLE"));
					try{
							reader=rsMessage.getCharacterStream("CONTENT");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							board.setContent(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("content select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
							} 

					board.setHit_cnt(rsMessage.getInt("HIT_CNT"));					
					board.setHenji_yn(rsMessage.getInt("HENJI_YN"));
					board.setOk_yn(rsMessage.getInt("OK_YN"));
					board.setAdd_ip(rsMessage.getString("IP_ADD")); 
					board.setFile_bseq(rsMessage.getInt("FILE_BSEQ"));
					board.setFile_kind(rsMessage.getInt("FILE_KIND"));
                   
                    list.add(board);
                } while(rsMessage.next());                
                return list;                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MgrException("selectList", ex);
        } finally { 
			if (rsMessage != null)
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }

 	/****************코멘트 henji_yn 카운트********************/
 public int  HenjiCnt(int bseq, int fileKind) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from seizo_comment  where FILE_BSEQ=? and FILE_KIND=? and  OK_YN=0");
			stmt.setInt(1, bseq);	
			stmt.setInt(2, fileKind);	
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("getCount Henji_yn", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
 public Category select(int id) throws MgrException {
        Connection conn = null; 
       
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
		PreparedStatement pstmtContent = null;
        ResultSet rsContent = null; 
 
		      
        try {
            Category board = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmtMessage = conn.prepareStatement(
                "select * from seizo_comment "+
                "where BSEQ = ?");
            pstmtMessage.setInt(1, id); 
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new Category();
					board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                     
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));
                    board.setRegister(rsMessage.getTimestamp("REGISTER"));
                    board.setName(rsMessage.getString("NM"));                   
					board.setMail_address(rsMessage.getString("MAIL_ADD"));  
					board.setTitle(rsMessage.getString("TITLE"));

					Reader reader = null;
					try{
							reader=rsMessage.getCharacterStream("CONTENT");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							board.setContent(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("content select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
							} 

					board.setHit_cnt(rsMessage.getInt("HIT_CNT"));					
					board.setHenji_yn(rsMessage.getInt("HENJI_YN"));
					board.setOk_yn(rsMessage.getInt("OK_YN"));
					board.setAdd_ip(rsMessage.getString("IP_ADD")); 
					board.setFile_bseq(rsMessage.getInt("FILE_BSEQ"));
					board.setFile_kind(rsMessage.getInt("FILE_KIND"));
               
                return board;
            } else {
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("select", ex);
        } finally { 
            
			if (rsMessage != null)  
                
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
   
   

/*** 조회하기.*/     
		 public void hit(int id) throws MgrException {
        Connection conn = null;         
		PreparedStatement pstmtUpdateMessage = null;
        PreparedStatement pstmtUpdateContent = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtUpdateMessage = conn.prepareStatement( 
				"update seizo_comment set HIT_CNT=HIT_CNT+1 where BSEQ=?");           
            pstmtUpdateMessage.setInt(1, id);
            pstmtUpdateMessage.executeUpdate();            
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new MgrException("update hit", ex);
        } finally {             
			if (pstmtUpdateMessage != null)                 
			try { pstmtUpdateMessage.close(); } catch(SQLException ex) {} 
            if (pstmtUpdateContent != null)                 
				try { pstmtUpdateContent.close(); } catch(SQLException ex) {} 
            if (conn != null)
                try { conn.setAutoCommit(true);  conn.close(); } catch(SQLException ex) {} 
        }
    }	
//comment 패스워드 체크
   public int checkPass(int bseq , String password)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select PASSNO from seizo_comment  where BSEQ = ?");
            pstmt.setInt(1, bseq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("PASSNO");
                
                if (dbPassword.compareTo(password) == 0) {
                    // 암호가 같으면 1을 리턴
                    return 1;
                } else {
                    // 암호가 다르면 0을 리턴
                    return 0;
                }
            } else {
                // 아이디 존재하지 않음 -1
                return -1;
            }
        } catch(SQLException ex) {
            throw new MgrException("checkPass", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

 public void delete(int id, int level, int groupId) throws MgrException {
        Connection conn = null; 
		PreparedStatement pstmtMessage = null;
		
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
			if(level==1){
				pstmtMessage = conn.prepareStatement(
                "delete from seizo_comment  where BSEQ = ? or  GROUP_ID=? ");
				pstmtMessage.setInt(1, id);
				pstmtMessage.setInt(2, groupId);
			}else if(level==2){
				pstmtMessage = conn.prepareStatement(
                "delete from seizo_comment  where BSEQ = ? or PARENT_ID=? ");
				pstmtMessage.setInt(1, id);
				pstmtMessage.setInt(2, id);

			}else if(level==3){
				pstmtMessage = conn.prepareStatement(
                "delete from seizo_comment  where BSEQ = ? ");
				pstmtMessage.setInt(1, id);
			}  
			pstmtMessage.executeUpdate();	
			
        } catch(SQLException ex) {
            try {
                conn.rollback();
				 } catch(SQLException ex1) {}
            throw new MgrException("delete", ex);
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
public static String readClobData(Reader reader) throws IOException {
        StringBuffer data = new StringBuffer();
        char[] buf = new char[1024];
        int cnt = 0;
        if (null != reader) {
            while ( (cnt = reader.read(buf)) != -1) {
                data.append(buf, 0, cnt);
            }
        }
        return data.toString();
    }

/*
 public void delete(int id, int level) throws MgrException {
        Connection conn = null; 
        
		PreparedStatement pstmtMessage = null;        
		PreparedStatement pstmtCom = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
			if(level==1){
				pstmtMessage = conn.prepareStatement(
                "delete from seizo_comment where BSEQ = ? or PARENT_ID=? ");
				pstmtMessage.setInt(1, id);
				pstmtMessage.setInt(2, id);
			}else{
				pstmtMessage = conn.prepareStatement(
                "delete from seizo_comment where BSEQ = ? ");
				pstmtMessage.setInt(1, id);
			}  
			pstmtMessage.executeUpdate();			

			pstmtCom=conn.prepareStatement(
                "delete from seizo_comment  where BSEQ = ?");
            pstmtCom.setInt(1, id);
            pstmtCom.executeUpdate();
        } catch(SQLException ex) {
            try {
                conn.rollback();
				 } catch(SQLException ex1) {}
            throw new MgrException("delete", ex);
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
*/

}