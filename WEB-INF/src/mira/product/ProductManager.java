package mira.product;

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


public class ProductManager { 
    
    private static ProductManager instance = new ProductManager();
    
    public static ProductManager getInstance() {
        return instance;
    }
    
    private ProductManager() {}
    private static String POOLNAME = "pool";
    
public void insert(ProductBean product) throws  ProductManagerException {
        Connection conn = null; 
        // 새로운 글의 그룹 번호를 구할 때 사용된다.       
        PreparedStatement pstmt = null;		
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);            
           
            // 새로운 글의 번호를 구한다.
            product.setPseq(Sequencer.nextId(conn, "product"));
            // 글을 삽입한다.
            pstmt = conn.prepareStatement( "insert into product values (?,?,?,?,?,?,?,?,?)");
            pstmt.setInt(1, product.getPseq());
            pstmt.setString(2, product.getPimg());
			pstmt.setInt(3, product.getCategory());			
            pstmt.setTimestamp(4, product.getRegister());  
			pstmt.setString(5, product.getPcode());
			pstmt.setString(6, product.getTitle_m());			
			pstmt.setCharacterStream(7,  new StringReader(product.getTitle_s()), product.getTitle_s().length());
			pstmt.setCharacterStream(8,  new StringReader(product.getContent()), product.getContent().length());
			pstmt.setInt(9, product.getView_yn());			 
            pstmt.executeUpdate(); 

            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new ProductManagerException("insert", ex);
        } finally { 
            
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}  
           
			if (pstmt != null)  try { pstmt.close(); } catch(SQLException ex) {} 		    
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch(SQLException ex) {} 
        }
    }
    
    /***update*/ 
    
		 public void update(ProductBean product) throws ProductManagerException {
        Connection conn = null; 
        
		PreparedStatement pstmtUpdateMessage = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtUpdateMessage = conn.prepareStatement( "update product set img=?,cate=?,pcode=?,title_m=?,title_s=?,content=?,view_yn=? where seq=?");             
          			
			pstmtUpdateMessage.setString(1, product.getPimg());
			pstmtUpdateMessage.setInt(2, product.getCategory());            
			pstmtUpdateMessage.setString(3, product.getPcode());
			pstmtUpdateMessage.setString(4, product.getTitle_m());			
			pstmtUpdateMessage.setCharacterStream(5,  new StringReader(product.getTitle_s()), product.getTitle_s().length());
			pstmtUpdateMessage.setCharacterStream(6,  new StringReader(product.getContent()), product.getContent().length());
			pstmtUpdateMessage.setInt(7, product.getView_yn());	
			pstmtUpdateMessage.setInt(8, product.getPseq());
            pstmtUpdateMessage.executeUpdate();
			
            conn.commit();
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            
            throw new ProductManagerException("update", ex);
        } finally { 
            
			if (pstmtUpdateMessage != null) try { pstmtUpdateMessage.close(); } catch(SQLException ex) {} 
            if (conn != null)
                try {
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }	

/***count admin */ 
    
	public int count(List whereCond, Map valueMap) throws ProductManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from product ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" where ");                
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
            throw new ProductManagerException("all list and count", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    } 

 /*** list admin*/ 
    
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws ProductManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from product ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by seq desc limit ?, ?");
            
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
				Reader reader2 = null;
                do {
                    ProductBean product = new ProductBean();

                    product.setPseq(rsMessage.getInt("seq"));                    
					product.setPimg(rsMessage.getString("img"));
					product.setCategory(rsMessage.getInt("cate"));					
					product.setPcode(rsMessage.getString("pcode"));	
					product.setTitle_m(rsMessage.getString("title_m"));					
					try{
							reader=rsMessage.getCharacterStream("title_s");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							product.setTitle_s(buffer.toString());
						}catch (IOException iex){throw new ProductManagerException("title_s select",iex);}
						finally{if(reader !=null)try{reader.close();}catch (IOException iex){}} 


					try{
							reader2=rsMessage.getCharacterStream("content");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader2.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							product.setContent(buffer.toString());
						}catch (IOException iex){throw new ProductManagerException("content select",iex);}
						finally{if(reader2 !=null)try{reader2.close();}catch (IOException iex){}} 


					product.setRegister(rsMessage.getTimestamp("register"));
					product.setView_yn(rsMessage.getInt("view_yn"));						
					
                    list.add(product);
                } while(rsMessage.next());                
                return list;                
            } else {
                return Collections.EMPTY_LIST;
            }            
        } catch(SQLException ex) {
            throw new ProductManagerException("selectList_su", ex);
        } finally { 
			if (rsMessage != null)
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }  


 public ProductBean getProduct(int pseq)  throws ProductManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		        
        try {
			ProductBean product = null;
            conn = DBUtil.getConnection(POOLNAME);
            pstmt = conn.prepareStatement(
            "select * from product  where seq = ?");
            pstmt.setInt(1, pseq);
            rs = pstmt.executeQuery();
			Reader reader = null; 
			Reader reader2 = null;
            if (rs.next()) {
                product = new ProductBean(); 
				
					product.setPseq(rs.getInt("seq"));                    
					product.setPimg(rs.getString("img"));
					product.setCategory(rs.getInt("cate"));					
					product.setPcode(rs.getString("pcode"));	
					product.setTitle_m(rs.getString("title_m"));					
					try{
							reader=rs.getCharacterStream("title_s");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							product.setTitle_s(buffer.toString());
						}catch (IOException iex){throw new ProductManagerException("title_s select",iex);}
						finally{if(reader !=null)try{reader.close();}catch (IOException iex){}} 


					try{
							reader2=rs.getCharacterStream("content");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader2.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							product.setContent(buffer.toString());
						}catch (IOException iex){throw new ProductManagerException("content select",iex);}
						finally{if(reader2 !=null)try{reader2.close();}catch (IOException iex){}} 


					product.setRegister(rs.getTimestamp("register"));
					product.setView_yn(rs.getInt("view_yn"));	



                return product;
            } else {
                return null;    
            }
        } catch(SQLException ex) {
            throw new ProductManagerException("getProduct!!!!!!!!!!", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


  public void delete(int pseq) throws ProductManagerException {
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;       
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
            pstmtMessage = conn.prepareStatement("delete from product where seq = ? "); 
            pstmtMessage.setInt(1, pseq);			
            pstmtMessage.executeUpdate();
            
        } catch(SQLException ex) {
            try {
                conn.rollback();
            } catch(SQLException ex1) {}
            throw new ProductManagerException("delete", ex);
        } finally { 
            
			if (pstmtMessage != null)  try { pstmtMessage.close(); } catch(SQLException ex) {}             
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch(SQLException ex) {} 
        }
    } 


/*** user count */ 
    
	public int countUser(List whereCond, Map valueMap) throws ProductManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from product where view_yn=1 ");
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
            
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new ProductManagerException("count_user", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    } 

 /***list user */ 
    
	public List selectListUser(List whereCond, Map valueMap, int startRow, int endRow)
    throws ProductManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null; 		
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from product where view_yn=1 ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by seq asc limit ?, ?");
            
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
				Reader reader2 = null;
                do {
                    ProductBean product = new ProductBean();

                    product.setPseq(rsMessage.getInt("seq"));                    
					product.setPimg(rsMessage.getString("img"));
					product.setCategory(rsMessage.getInt("cate"));					
					product.setPcode(rsMessage.getString("pcode"));	
					product.setTitle_m(rsMessage.getString("title_m"));					
					try{
							reader=rsMessage.getCharacterStream("title_s");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							product.setTitle_s(buffer.toString());
						}catch (IOException iex){throw new ProductManagerException("title_s select",iex);}
						finally{if(reader !=null)try{reader.close();}catch (IOException iex){}} 


					try{
							reader2=rsMessage.getCharacterStream("content");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader2.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							product.setContent(buffer.toString());
						}catch (IOException iex){throw new ProductManagerException("content select",iex);}
						finally{if(reader2 !=null)try{reader2.close();}catch (IOException iex){}} 


					product.setRegister(rsMessage.getTimestamp("register"));
					product.setView_yn(rsMessage.getInt("view_yn"));	

                    list.add(product);
                } while(rsMessage.next());                
                return list;                
            } else {
                return Collections.EMPTY_LIST;
            }            
        } catch(SQLException ex) {
            throw new ProductManagerException("selectListUser", ex);
        } finally { 
			if (rsMessage != null)
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    } 

//상품등록시 pseq 가져오기
	 public ProductBean selectPseq(String seqnm) throws ProductManagerException {
        Connection conn = null;        
		PreparedStatement pstmtMessage = null;
        ResultSet rsMessage = null;        
        try {
            ProductBean product = null; 
            conn = DBUtil.getConnection(POOLNAME);            
            pstmtMessage = conn.prepareStatement("select * from id_seq  where seqnm = ?" );
            pstmtMessage.setString(1,seqnm);
			
			rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) {   
				product = new ProductBean();    
                
				product.setId(rsMessage.getInt("seqno"));               
                }
                return product;                  
        } catch(SQLException ex) {
            throw new ProductManagerException("selectPseq", ex);
        } finally {             
			if (rsMessage != null)                  
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }



/*main special menu*/
	 public List selectMainSpecial(int cate, int pgcound ) throws ProductManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rsMessage = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from product where view_yn=1 and cate=? order by seq asc limit 0, ?" );
            pstmt.setInt(1,cate);
			pstmt.setInt(2,pgcound);
			rsMessage = pstmt.executeQuery();
            if (rsMessage.next()) {                 
				List list = new java.util.ArrayList();
				Reader reader = null; 				
                do {
                    ProductBean product = new ProductBean();

                    product.setPseq(rsMessage.getInt("seq"));                    
					product.setPimg(rsMessage.getString("img"));
					product.setCategory(rsMessage.getInt("cate"));					
					product.setPcode(rsMessage.getString("pcode"));	
					product.setTitle_m(rsMessage.getString("title_m"));					
					try{
							reader=rsMessage.getCharacterStream("title_s");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							product.setTitle_s(buffer.toString());
						}catch (IOException iex){throw new ProductManagerException("title_s select",iex);}
						finally{if(reader !=null)try{reader.close();}catch (IOException iex){}} 


				list.add(product);	
                }while(rsMessage.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new ProductManagerException("selectEmp", ex);
        } finally {             
			if (rsMessage != null)                  
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }



}
