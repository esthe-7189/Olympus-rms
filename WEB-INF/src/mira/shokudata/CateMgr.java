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

public class CateMgr {
    private static CateMgr instance = new CateMgr();
    
    public static CateMgr getInstance() {
        return instance;
    }
    
    private CateMgr() {}
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
				rsGroup = stmtGroup.executeQuery("select max(GROUP_ID) from shoku_cate");                
					int maxGroupId = 0;                
					if (rsGroup.next()) {
                    maxGroupId = rsGroup.getInt(1); 
				}
                maxGroupId++;
                
                board.setGroupId(maxGroupId);
				board.setCateNo(board.getCateNo());  //전시 순번정하기 (level==1)
                board.setOrderNo(0);
            } else {               
                
				pstmtOrder = conn.prepareStatement( "select max(ORDER_NO) from shoku_cate "
				+"where PARENT_ID = ? or BSEQ = ?"); 
                
				pstmtOrder.setInt(1, board.getParentId());
                pstmtOrder.setInt(2, board.getParentId());
                rsOrder = pstmtOrder.executeQuery();
                int maxOrder = 0;
                if (rsOrder.next()) {
                    maxOrder = rsOrder.getInt(1);
                }
                maxOrder ++;
                board.setOrderNo(maxOrder); 
				board.setCateNo(maxOrder);  //전시 순번정하기 (level==,3)
			}
            
           
            if (board.getOrderNo() > 0) {
                pstmtOrderUpdate = conn.prepareStatement(
					"update shoku_cate set ORDER_NO = ORDER_NO + 1,CATE_NO = CATE_NO + 1 "	+
					"where GROUP_ID = ? and ORDER_NO >= ?");
                pstmtOrderUpdate.setInt(1, board.getGroupId());                 
				pstmtOrderUpdate.setInt(2, board.getOrderNo());                
				pstmtOrderUpdate.executeUpdate();
            }
           
            board.setBseq(Sequencer.nextId(conn,"shoku_cate"));	
            pstmtInsertMessage = conn.prepareStatement( "insert into shoku_cate values (?,?,?,?,?,?,?,?)");
            pstmtInsertMessage.setInt(1, board.getBseq());
            pstmtInsertMessage.setInt(2, board.getGroupId());
            pstmtInsertMessage.setInt(3, board.getOrderNo());
            pstmtInsertMessage.setInt(4, board.getLevel());             
			pstmtInsertMessage.setInt(5, board.getParentId()); 
			pstmtInsertMessage.setCharacterStream(6,  new StringReader( board.getName()),  board.getName().length());		
			pstmtInsertMessage.setInt(7, board.getCateNo());
			pstmtInsertMessage.setInt(8, board.getKind());
			
			pstmtInsertMessage.executeUpdate();
			
			conn.commit();
        } catch(SQLException ex) { try {conn.rollback();} catch(SQLException ex1) {}
            throw new MgrException("cate Insert", ex);
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


//수정하기
public void update(int id, String nm, int  cateno) throws MgrException {
        Connection conn = null; 
		PreparedStatement pstmtMessage = null;
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
			 pstmtMessage = conn.prepareStatement( "update shoku_cate set MENU=?, CATE_NO=?   where BSEQ=?");
			 
			 pstmtMessage.setCharacterStream(1,  new StringReader(nm), nm.length());		
			 pstmtMessage.setInt(2, cateno);
			 pstmtMessage.setInt(3, id);			
			 pstmtMessage.executeUpdate();	
			
        } catch(SQLException ex) {
            try {
                conn.rollback();
				 } catch(SQLException ex1) {}
            throw new MgrException("update", ex);
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
 
    /*** 리스트 카운트 */    
	public int count(List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select count(*) from shoku_cate ");
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
    
    /**리스트   */     
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200); 
            
			query.append("select * from shoku_cate ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by GROUP_ID desc, ORDER_NO asc limit ?, ? ");            
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
					try{
							reader=rsMessage.getCharacterStream("MENU");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							 board.setName(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("category select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
						}
					board.setCateNo(rsMessage.getInt("CATE_NO"));     
					board.setKind(rsMessage.getInt("LGROUP_NO"));     
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
    
      
 public Category select(int id) throws MgrException {
        Connection conn = null; 
       
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null;         
		Reader reader = null;    
 		      
        try {
            Category board = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmtMessage = conn.prepareStatement(
                "select * from shoku_cate  where BSEQ = ?");
            pstmtMessage.setInt(1, id); 
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new Category();
					board.setBseq(rsMessage.getInt("BSEQ"));
                    board.setGroupId(rsMessage.getInt("GROUP_ID"));                    
					board.setOrderNo(rsMessage.getInt("ORDER_NO"));                     
					board.setLevel(rsMessage.getInt("PLEVEL"));
                    board.setParentId(rsMessage.getInt("PARENT_ID"));   
					try{
							reader=rsMessage.getCharacterStream("MENU");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							 board.setName(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("category select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
						}                  
					 board.setCateNo(rsMessage.getInt("CATE_NO"));   
					 board.setKind(rsMessage.getInt("LGROUP_NO"));     
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
   
    public void delete(int id, int level, int groupId) throws MgrException {
        Connection conn = null; 
		PreparedStatement pstmtMessage = null;
		
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
			if(level==1){
				pstmtMessage = conn.prepareStatement(
                "delete from shoku_cate where BSEQ = ? or  GROUP_ID=? ");
				pstmtMessage.setInt(1, id);
				pstmtMessage.setInt(2, groupId);
			}else if(level==2){
				pstmtMessage = conn.prepareStatement(
                "delete from shoku_cate where BSEQ = ? or PARENT_ID=? ");
				pstmtMessage.setInt(1, id);
				pstmtMessage.setInt(2, id);

			}else if(level==3){
				pstmtMessage = conn.prepareStatement(
                "delete from shoku_cate where BSEQ = ? ");
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

/**리스트  **/
 public List selectListAdminLevel(int no, int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader = null;    
        try {            
            conn = DBUtil.getConnection(POOLNAME); 
		if(level==1){
			pstmt = conn.prepareStatement("select * from shoku_cate where LGROUP_NO=?  and PLEVEL=?  order by CATE_NO asc" );
		}else{
			pstmt = conn.prepareStatement("select * from shoku_cate where PARENT_ID=?  and PLEVEL=?  order by CATE_NO asc" );
		}
            
            pstmt.setInt(1, no);		
			pstmt.setInt(2, level);
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category board = new Category();
                    board.setBseq(rs.getInt("BSEQ"));
					board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID")); 
					try{
							reader=rs.getCharacterStream("MENU");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							 board.setName(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("category select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
						}
					board.setCateNo(rs.getInt("CATE_NO"));             
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("select shoku_cate", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
/**현재위치 대분류 리스트  **/
 public List selectStayL( int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;     
		Reader reader = null;    
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from shoku_cate where PLEVEL=?  order by GROUP_ID asc " );            
			pstmt.setInt(1, level);		
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category board = new Category();
                    board.setBseq(rs.getInt("BSEQ"));
					board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID")); 
					try{
							reader=rs.getCharacterStream("MENU");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							 board.setName(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("category select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
						}

					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("select selectStayL", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

/**현재위치 중소분류 리스트::   GROUP_ID=원부모번호 ,   level=(중분류는 2,소분류는 3)  **/
 public List selectStayMS(int parent_id, int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;   
		Reader reader = null;    
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from shoku_cate  where GROUP_ID=?  and PLEVEL=?  order by  ORDER_NO asc" );
            pstmt.setInt(1, parent_id);		
			pstmt.setInt(2, level);		
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category board = new Category();
                    board.setBseq(rs.getInt("BSEQ"));
					board.setGroupId(rs.getInt("GROUP_ID"));                    
					board.setOrderNo(rs.getInt("ORDER_NO"));                    
					board.setLevel(rs.getInt("PLEVEL"));
                    board.setParentId(rs.getInt("PARENT_ID"));                    
                    try{
							reader=rs.getCharacterStream("MENU");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							 board.setName(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("category select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
						}            
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("selectStayMS", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
/****************카테고리 아이템 카운트********************/

 public int  cateCnt(int  id, int level) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from shoku_cate where PARENT_ID=?  and PLEVEL=?");
			stmt.setInt(1, id);	
			stmt.setInt(2, level);	
			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("getCount  cate", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

/****************대분류 가테고리 직원 선택********************/

public void insertMem(Category  board)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
		
        
        try {
            conn = DBUtil.getConnection(POOLNAME);			
            
			 // 새로운 고유번호를 구한다.
            board.setBseq(Sequencer.nextId(conn,"shoku_mem"));		
            pstmt = conn.prepareStatement( "insert into shoku_mem values (?,?,?,?,?)");
			pstmt.setInt(1, board.getBseq()); 
			pstmt.setInt(2, board.getMseq()); 
			pstmt.setInt(3, board.getCate_cnt());
			pstmt.setInt(4, board.getOk_yn());
			pstmt.setTimestamp(5, board.getRegister());
            
            pstmt.executeUpdate();
        } catch(SQLException ex) {
            throw new MgrException("insertMem", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public Category getMem(int mseq, int cate_cnt )  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * from shoku_mem where mseq=? and cate_cnt=?");
            pstmt.setInt(1, mseq);
			pstmt.setInt(2, cate_cnt);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Category member = new Category();
				member.setBseq(rs.getInt("bseq"));
				member.setMseq(rs.getInt("mseq"));
				member.setMseq(rs.getInt("cate_cnt"));				
				member.setRegister(rs.getTimestamp("register"));   
				
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getMem", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public int memCnt()   throws MgrException {        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try	{
			conn=DBUtil.getConnection(POOLNAME);
			pstmt = conn.prepareStatement("select count(*) from shoku_mem ");            	    
            
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("count memCnt", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//수정하기
/*public void updateMem(int seq, int ok_yn) throws MgrException {
        Connection conn = null; 
		PreparedStatement pstmtMessage = null;
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
			 pstmtMessage = conn.prepareStatement( "update shoku_mem set ok_yn=? where bseq=?");			 
			 pstmtMessage.setInt(1, ok_yn);
			 pstmtMessage.setInt(2, seq);			
			 pstmtMessage.executeUpdate();	
			
        } catch(SQLException ex) {
            try {
                conn.rollback();
				 } catch(SQLException ex1) {}
            throw new MgrException("updateMem", ex);
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
public void deleteMem()   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement("delete from shoku_mem where ok_yn=1 ");            
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("存在してないDataです.");
            }
        } catch(SQLException ex) {
            throw new MgrException("deleteMem", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


}