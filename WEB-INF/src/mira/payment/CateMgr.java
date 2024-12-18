package mira.payment;

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

public void insertBoard(Category  pds)  throws MgrException {
		Connection conn = null;
		PreparedStatement pstmt = null;				
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 
            pds.setCseq(Sequencer.nextId(conn, "pay_seikyu_client"));
					
			pstmt = conn.prepareStatement("insert into pay_seikyu_client values (?,?,?)");
			pstmt.setInt(1, pds.getCseq());
			pstmt.setInt(2, pds.getPay_type());			
			pstmt.setString(3, pds.getClient_nm());					
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insert",ex2);
		} finally {			
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
}



//수정하기
public void update(Category pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update pay_seikyu_client set pay_type=?, client_nm=? where cseq=?" );
		pstmt.setInt(1, pds.getPay_type());		
		pstmt.setString(2, pds.getClient_nm());			
		pstmt.setInt(3, pds.getCseq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}
 
    /*** 리스트 카운트 */    
	public int count(int kubun,String ymdVal,int pay_item, List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
	if(kubun==1){         
			query.append(
				"select count(*) FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=? and substring(a.sinsei_day,1,7)=? "	);
	}else if(kubun==2){
			query.append(
				"select count(*) FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=?  "	);	
	}
			
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
    if(kubun==1){         
			pstmt.setInt(1, pay_item);	
			pstmt.setString(2, ymdVal);
	}else if(kubun==2){
			pstmt.setInt(1, pay_item);
			
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
public List selectList(int kubun, String ymdVal, int pay_item, List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200); 
   if(kubun==1){         
			query.append(
				"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=? and substring(a.sinsei_day,1,7)=? "	);	
   }else if(kubun==2){
			query.append(
				"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=?  "	);	
   }
			
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by b.cseq asc, a.seq asc limit ?, ? ");            
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
            
    if(kubun==1){         
			pstmtMessage.setInt(valueMap.size()+1, pay_item);
			pstmtMessage.setString(valueMap.size()+2, ymdVal);
			pstmtMessage.setInt(valueMap.size()+3, startRow);
            pstmtMessage.setInt(valueMap.size()+4, endRow-startRow+1);
	}else if(kubun==2){
			pstmtMessage.setInt(valueMap.size()+1, pay_item);			
			pstmtMessage.setInt(valueMap.size()+2, startRow);
            pstmtMessage.setInt(valueMap.size()+3, endRow-startRow+1);
			
	}       
            
            rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
                
				List list = new java.util.ArrayList(endRow-startRow+1);  
				Reader reader = null;              
                do {
                    Category board = new Category();
                    board.setCseq(rsMessage.getInt("cseq"));
					board.setPay_type(rsMessage.getInt("pay_type"));
					board.setClient_nm(rsMessage.getString("client_nm"));					
					board.setSeq(rsMessage.getInt("seq"));
					board.setRegister(rsMessage.getTimestamp("register"));
					board.setMseq(rsMessage.getInt("mseq"));
					board.setComment(rsMessage.getString("comment"));
					board.setClient(rsMessage.getInt("client"));
					board.setPay_kikan(rsMessage.getString("pay_kikan"));
					board.setPay_day(rsMessage.getString("pay_day"));
					board.setPrice(rsMessage.getInt("price"));
					board.setSinsei_day(rsMessage.getString("sinsei_day"));
					board.setReceive_yn_sinsei(rsMessage.getInt("receive_yn_sinsei"));
					board.setPost_send_day(rsMessage.getString("post_send_day"));
					board.setReceive_yn_ot(rsMessage.getInt("receive_yn_ot"));	
					board.setShori_yn(rsMessage.getInt("shori_yn"));
					board.setReceive_yn_tokyo(rsMessage.getInt("receive_yn_tokyo"));
					board.setPj_yn(rsMessage.getInt("pj_yn"));
					board.setName(rsMessage.getString("nm"));
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
/*
select *
from (select seq, client,sinsei_day,  count(seq) as tot_cnt,
      sum(case when sinsei_day > "2013-01-01" and sinsei_day < "2013-12-20" then 1 else 0 end) as cur_cnt
    from pay_seikyu
    group by client) a
LEFT JOIN pay_seikyu_client b ON b.cseq=a.client 
LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=1 and a.tot_cnt = a.cur_cnt
*/
public int countt(int submit_yn, int kikanval,String ymdVal,int pay_item, List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);
	 
	if(submit_yn==1 && kikanval==1){         
			query.append(
				"select count(*) FROM (select * from pay_seikyu where substring(sinsei_day,1,7)=? ) a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE b.pay_type=?  "	);
			if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
					for (int i = 0 ; i < whereCond.size() ; i++) {
							query.append(whereCond.get(i)); 
                    
							if (i < whereCond.size() -1 ) { 
                        
							query.append(" or ");
                    }
                }
            }
   }else if(submit_yn==1 && kikanval==2){
			query.append(
				"select count(*) FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=?  "	);	
			 if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
					for (int i = 0 ; i < whereCond.size() ; i++) {
							query.append(whereCond.get(i)); 
                    
							if (i < whereCond.size() -1 ) { 
                        
							query.append(" or ");
                    }
                }
            }
   }else if(submit_yn==2 && kikanval==1){
			query.append(
				"select count(*) FROM (select * from pay_seikyu where substring(sinsei_day,1,7)=? ) a "+
				"RIGHT JOIN pay_seikyu_client b ON b.cseq=a.client "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE b.pay_type=? and a.client is null   "	);	
			 
			 if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
					for (int i = 0 ; i < whereCond.size() ; i++) {
							query.append(whereCond.get(i)); 
                    
							if (i < whereCond.size() -1 ) { 
                        
							query.append(" or ");
                    }
                }
            }
   }else if(submit_yn==2 && kikanval==2){
			query.append(
				"select count(*) FROM (select * from pay_seikyu  ");	

	         if (whereCond != null && whereCond.size() > 0) {
                query.append(" WHERE "); 
               
					for (int i = 0 ; i < whereCond.size() ; i++) {
							query.append(whereCond.get(i)); 
                    
							if (i < whereCond.size() -1 ) { 
                        
							query.append(" or ");
                    }
                }
            }
			query.append(" ) a RIGHT JOIN pay_seikyu_client b ON b.cseq=a.client "+
						"LEFT JOIN member c ON a.mseq=c.mseq "+
						"WHERE b.pay_type=? and a.client is null  ");			
   }else{
			query.append(
				"select count(*) FROM (select * from pay_seikyu where substring(sinsei_day,1,7)=? ) a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE b.pay_type=?  "	);
	         if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
					for (int i = 0 ; i < whereCond.size() ; i++) {
							query.append(whereCond.get(i)); 
                    
							if (i < whereCond.size() -1 ) { 
                        
							query.append(" or ");
                    }
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
    if(kikanval==1){ 
			pstmt.setString(1, ymdVal);
			pstmt.setInt(2, pay_item);	
			
	}else if(kikanval==2){
			pstmt.setInt(1, pay_item);			
	}else{
			pstmt.setString(1, ymdVal);
			pstmt.setInt(2, pay_item);	
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

public List selectListt(int submit_yn,int kikanval, String ymdVal, int pay_item, List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200);        
	if(submit_yn==1 && kikanval==1){         
			query.append(
				"select * FROM (select * from pay_seikyu where substring(sinsei_day,1,7)=? ) a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE b.pay_type=?  "	);	
			if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by b.cseq asc, a.seq asc limit ?, ? ");

   }else if(submit_yn==1 && kikanval==2){
			query.append(
				"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=?  "	);
			
			if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by a.sinsei_day asc, a.seq asc limit ?, ? ");

   }else if(submit_yn==2 && kikanval==1){
			query.append(
				"select * FROM (select * from pay_seikyu where substring(sinsei_day,1,7)=? ) a "+
				"RIGHT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE b.pay_type=? and a.client is null   "	);	

			if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by b.cseq asc, a.seq asc limit ?, ? ");

   }else if(submit_yn==2 && kikanval==2){
			query.append(
				"select * FROM (select * from pay_seikyu  "); 					

			if (whereCond != null && whereCond.size() > 0) {
                query.append(" where "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(
				") a RIGHT JOIN pay_seikyu_client b ON b.cseq=a.client "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE b.pay_type=? and a.client is null  "+
				"order by a.sinsei_day asc, a.seq asc limit ?, ? ");

   }else{
			query.append(
				"select * FROM (select * from pay_seikyu where substring(sinsei_day,1,7)=? ) a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE b.pay_type=?  "	);
			
			if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by b.cseq asc, a.seq asc limit ?, ? ");
   }
   
            			

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
            
    	
	if(kikanval==1){  
			pstmtMessage.setString(valueMap.size()+1, ymdVal);
			pstmtMessage.setInt(valueMap.size()+2, pay_item);			
			pstmtMessage.setInt(valueMap.size()+3, startRow);
            pstmtMessage.setInt(valueMap.size()+4, endRow-startRow+1);
	}else if(kikanval==2){
			pstmtMessage.setInt(valueMap.size()+1, pay_item);			
			pstmtMessage.setInt(valueMap.size()+2, startRow);
            pstmtMessage.setInt(valueMap.size()+3, endRow-startRow+1);			
	}else{
			pstmtMessage.setString(valueMap.size()+1, ymdVal);
			pstmtMessage.setInt(valueMap.size()+2, pay_item);			
			pstmtMessage.setInt(valueMap.size()+3, startRow);
            pstmtMessage.setInt(valueMap.size()+4, endRow-startRow+1);
	}
	
            rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
                
				List list = new java.util.ArrayList(endRow-startRow+1);  
				Reader reader = null;              
                do {
                    Category board = new Category();
                    board.setCseq(rsMessage.getInt("cseq"));
					board.setPay_type(rsMessage.getInt("pay_type"));
					board.setClient_nm(rsMessage.getString("client_nm"));					
					board.setSeq(rsMessage.getInt("seq"));
					board.setRegister(rsMessage.getTimestamp("register"));
					board.setMseq(rsMessage.getInt("mseq"));
					board.setComment(rsMessage.getString("comment"));
					board.setClient(rsMessage.getInt("client"));
					board.setPay_kikan(rsMessage.getString("pay_kikan"));
					board.setPay_day(rsMessage.getString("pay_day"));
					board.setPrice(rsMessage.getInt("price"));
					board.setSinsei_day(rsMessage.getString("sinsei_day"));
					board.setReceive_yn_sinsei(rsMessage.getInt("receive_yn_sinsei"));
					board.setPost_send_day(rsMessage.getString("post_send_day"));
					board.setReceive_yn_ot(rsMessage.getInt("receive_yn_ot"));	
					board.setShori_yn(rsMessage.getInt("shori_yn"));
					board.setReceive_yn_tokyo(rsMessage.getInt("receive_yn_tokyo"));
					board.setPj_yn(rsMessage.getInt("pj_yn"));
					board.setName(rsMessage.getString("nm"));
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
public int countYear(int pay_item, List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
                 
			query.append(
				"select count(*) FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=? "	);
	
			
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
			pstmt.setInt(1, pay_item);		
	
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("countYear", ex);
        } finally { 
            if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
/**리스트   */     
	public List selectListYear(int pay_item, List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200);   
			query.append(
				"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=?  "	);	   
			
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by b.cseq asc, a.seq asc limit ?, ? ");            
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

			pstmtMessage.setInt(valueMap.size()+1, pay_item);			
			pstmtMessage.setInt(valueMap.size()+2, startRow);
            pstmtMessage.setInt(valueMap.size()+3, endRow-startRow+1);			
     
            
            rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
                
				List list = new java.util.ArrayList(endRow-startRow+1);  
				Reader reader = null;              
                do {
                    Category board = new Category();
                    board.setCseq(rsMessage.getInt("cseq"));
					board.setPay_type(rsMessage.getInt("pay_type"));
					board.setClient_nm(rsMessage.getString("client_nm"));					
					board.setSeq(rsMessage.getInt("seq"));
					board.setRegister(rsMessage.getTimestamp("register"));
					board.setMseq(rsMessage.getInt("mseq"));
					board.setComment(rsMessage.getString("comment"));
					board.setClient(rsMessage.getInt("client"));
					board.setPay_kikan(rsMessage.getString("pay_kikan"));
					board.setPay_day(rsMessage.getString("pay_day"));
					board.setPrice(rsMessage.getInt("price"));
					board.setSinsei_day(rsMessage.getString("sinsei_day"));
					board.setReceive_yn_sinsei(rsMessage.getInt("receive_yn_sinsei"));
					board.setPost_send_day(rsMessage.getString("post_send_day"));
					board.setReceive_yn_ot(rsMessage.getInt("receive_yn_ot"));	
					board.setShori_yn(rsMessage.getInt("shori_yn"));
					board.setReceive_yn_tokyo(rsMessage.getInt("receive_yn_tokyo"));
					board.setPj_yn(rsMessage.getInt("pj_yn"));
					board.setName(rsMessage.getString("nm"));
                    list.add(board);
                } while(rsMessage.next());                
                return list;                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MgrException("selectListYear", ex);
        } finally { 
			if (rsMessage != null)
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public int countAdd(int pay_item, List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 
            
			query.append(
				"select count(*) FROM pay_seikyu_client where pay_type=? "	);	
			
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
            pstmt.setInt(1, pay_item);	
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
	public List listAdd(int pay_item, List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200); 
            
			query.append(
				"select * FROM pay_seikyu_client where pay_type=? "	);			
			
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and "); 
               
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by cseq asc limit ?, ? ");            
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
            
            pstmtMessage.setInt(valueMap.size()+1, pay_item);
			pstmtMessage.setInt(valueMap.size()+2, startRow);
            pstmtMessage.setInt(valueMap.size()+3, endRow-startRow+1);
            
            rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
                
				List list = new java.util.ArrayList(endRow-startRow+1);  
				Reader reader = null;              
                do {
                    Category board = new Category();
                    board.setCseq(rsMessage.getInt("cseq"));
					board.setPay_type(rsMessage.getInt("pay_type"));
					board.setClient_nm(rsMessage.getString("client_nm"));				
					
                    list.add(board);
                } while(rsMessage.next());                
                return list;                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MgrException("selectList add", ex);
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
                "select * from pay_seikyu_client  where cseq = ?");
            pstmtMessage.setInt(1, id); 
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) { 
  
				board = new Category();
					board.setCseq(rsMessage.getInt("cseq"));
					board.setPay_type(rsMessage.getInt("pay_type"));
					board.setClient_nm(rsMessage.getString("client_nm"));       
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
   
    public void delete(int id) throws MgrException {
        Connection conn = null; 
		PreparedStatement pstmtMessage = null;
		
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
				pstmtMessage = conn.prepareStatement(
                "delete from pay_seikyu_client where cseq=? ");
				pstmtMessage.setInt(1, id);			
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
public void delete_client(int id) throws MgrException {
        Connection conn = null; 
		PreparedStatement pstmtMessage = null;
		
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
				pstmtMessage = conn.prepareStatement(
                "delete from pay_seikyu where client=? ");
				pstmtMessage.setInt(1, id);			
			pstmtMessage.executeUpdate();	
			
        } catch(SQLException ex) {
            try {
                conn.rollback();
				 } catch(SQLException ex1) {}
            throw new MgrException("delete_client", ex);
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

public List listClient(int kind) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from pay_seikyu_client where pay_type=?  order by cseq asc" ); 			
			pstmt.setInt(1, kind);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category board = new Category();
                    board.setCseq(rs.getInt("cseq"));
					board.setPay_type(rs.getInt("pay_type"));
					board.setClient_nm(rs.getString("client_nm"));  
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("selectList", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

}