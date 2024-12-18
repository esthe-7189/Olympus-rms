package mira.order;

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

public class MgrOrderBunsho {
    private static MgrOrderBunsho instance = new MgrOrderBunsho();
    
    public static MgrOrderBunsho getInstance() {
        return instance;
    }
    
    private MgrOrderBunsho() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insert(BeanOrderBunsho member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"purchase_order"));
            pstmt = conn.prepareStatement( "insert into purchase_order values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());			
			pstmt.setTimestamp(3, member.getRegister());
			pstmt.setString(4, member.getContact_order());
			pstmt.setInt(5, member.getSign_01());
			pstmt.setInt(6, member.getSign_02());
			pstmt.setInt(7, member.getSign_03());
			pstmt.setInt(8, member.getSign_01_yn());
			pstmt.setInt(9, member.getSign_02_yn());
			pstmt.setInt(10, member.getSign_03_yn());
			pstmt.setInt(11, member.getKind_urgency());
			pstmt.setString(12, member.getComment());
			pstmt.setString(13, member.getHizuke());
			pstmt.setString(14, member.getTitle());
			pstmt.setInt(15, member.getDel_yn());
			pstmt.setInt(16, member.getGet_yn());
			pstmt.setString(17, member.getSign_no_riyu_01());
			pstmt.setString(18, member.getSign_no_riyu_02());
			pstmt.setString(19, member.getSign_no_riyu_03());

            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insert", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public void insert_item(BeanOrderBunsho member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"purchase_order_item"));
            pstmt = conn.prepareStatement( "insert into purchase_order_item values (?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getParent_seq());			
			pstmt.setString(3, member.getProduct_nm());
			pstmt.setString(4, member.getOrder_no());
			pstmt.setInt(5, member.getClient_nm());
			pstmt.setInt(6, member.getProduct_qty());
			pstmt.setInt(7, member.getUnit_price());
			pstmt.setInt(8, member.getDel_yn_item());

            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insert", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

public int getIdSeq(String id)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select seqno from id_seq  where seqnm = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery(); 
			
			int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;

        } catch(SQLException ex) {
            throw new MgrException("getIdSeq", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


public void updatePurchase_order(BeanOrderBunsho  member) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmtUpdate = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);        
            conn.setAutoCommit(false);
            pstmtUpdate = conn.prepareStatement( 
				"update purchase_order set contact_order=?,sign_01=?,sign_02=?,sign_03=?, "+
				"sign_01_yn=1,sign_02_yn=1,sign_03_yn=1,del_yn=1,get_yn=1, "+
				"kind_urgency=?,comment=?,hizuke=?, title=?  where seq=? "); 
			
			pstmtUpdate.setString(1, member.getContact_order());
			pstmtUpdate.setInt(2, member.getSign_01());
			pstmtUpdate.setInt(3, member.getSign_02());
			pstmtUpdate.setInt(4, member.getSign_03());			
			pstmtUpdate.setInt(5, member.getKind_urgency());
			pstmtUpdate.setString(6, member.getComment());
			pstmtUpdate.setString(7, member.getHizuke());
			pstmtUpdate.setString(8, member.getTitle());
			pstmtUpdate.setInt(9, member.getSeq());


            pstmtUpdate.executeUpdate();	    
            conn.commit();    
        } catch(SQLException ex) { 
			try {conn.rollback();} catch(SQLException ex1) {} 
            throw new MgrException("updatePurchase_order", ex);
        } finally {             
			if (pstmtUpdate != null) 
 	try { pstmtUpdate.close(); } catch(SQLException ex) {}            
            if (conn != null)  try {conn.setAutoCommit(true);   conn.close();  } catch(SQLException ex) {} 
        }
    }

	public void updatePurchase_order_item(BeanOrderBunsho  member) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmtUpdate = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);        
            conn.setAutoCommit(false);
            pstmtUpdate = conn.prepareStatement( 
				"update purchase_order_item set product_nm=?,order_no=?,client_nm=?,product_qty=?, unit_price=?  where seq=? "); 
			
			pstmtUpdate.setString(1, member.getProduct_nm());
			pstmtUpdate.setString(2, member.getOrder_no());
			pstmtUpdate.setInt(3, member.getClient_nm());
			pstmtUpdate.setInt(4, member.getProduct_qty());
			pstmtUpdate.setInt(5, member.getUnit_price());
			pstmtUpdate.setInt(6, member.getSeq());


            pstmtUpdate.executeUpdate();	    
            conn.commit();    
        } catch(SQLException ex) { 
			try {conn.rollback();} catch(SQLException ex1) {} 
            throw new MgrException("updatePurchase_order_item", ex);
        } finally {             
			if (pstmtUpdate != null) 
 	try { pstmtUpdate.close(); } catch(SQLException ex) {}            
            if (conn != null)  try {conn.setAutoCommit(true);   conn.close();  } catch(SQLException ex) {} 
        }
    }
 
public void deleteOrder(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;    
		PreparedStatement pstmt2 = null;    
        try {
            conn = DBUtil.getConnection(POOLNAME);
			
            pstmt = conn.prepareStatement("DELETE FROM purchase_order where seq=? ");
            pstmt.setInt(1, seq);            
            int result = pstmt.executeUpdate(); 

			pstmt2 = conn.prepareStatement("DELETE FROM purchase_order_item where parent_seq=? ");
            pstmt2.setInt(1, seq);            
            int result2 = pstmt2.executeUpdate(); 
			

           
        } catch(SQLException ex) {
            throw new MgrException("delete purchase_order and purchase_order_item", ex);
        } finally {
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}

public void deleteItem(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;    
		PreparedStatement pstmt2 = null;    
        try {
            conn = DBUtil.getConnection(POOLNAME);
			
            pstmt = conn.prepareStatement("DELETE FROM purchase_order_item where parent_seq=? ");
            pstmt.setInt(1, seq);            
            int result = pstmt.executeUpdate();			

           
        } catch(SQLException ex) {
            throw new MgrException("purchase_order_item", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}

 public BeanOrderBunsho getDbOrder(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
		Reader reader2 = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from purchase_order a inner join member b on a.mseq=b.mseq where seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                BeanOrderBunsho member = new BeanOrderBunsho();					
				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setRegister(rs.getTimestamp("register"));
				member.setContact_order(rs.getString("contact_order"));
				member.setSign_01(rs.getInt("sign_01"));
				member.setSign_02(rs.getInt("sign_02"));				
				member.setSign_03(rs.getInt("sign_03"));
				member.setSign_01_yn(rs.getInt("sign_01_yn"));
				member.setSign_02_yn(rs.getInt("sign_02_yn"));
				member.setSign_03_yn(rs.getInt("sign_03_yn"));
				member.setKind_urgency(rs.getInt("kind_urgency"));
				member.setComment(rs.getString("comment"));
				member.setHizuke(rs.getString("hizuke"));
				member.setTitle(rs.getString("title"));
				member.setSign_no_riyu_01(rs.getString("sign_no_riyu_01"));
				member.setSign_no_riyu_02(rs.getString("sign_no_riyu_02"));
				member.setSign_no_riyu_03(rs.getString("sign_no_riyu_03"));
				
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getDb", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

	public BeanOrderBunsho getDbOrderItem(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
		Reader reader2 = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from purchase_order_item where seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                BeanOrderBunsho member = new BeanOrderBunsho();					
				member.setSeq(rs.getInt("seq"));
				member.setParent_seq(rs.getInt("parent_seq"));				
				member.setProduct_nm(rs.getString("product_nm"));
				member.setOrder_no(rs.getString("order_no"));
				member.setClient_nm(rs.getInt("client_nm"));
				member.setProduct_qty(rs.getInt("product_qty"));
				member.setUnit_price(rs.getInt("unit_price"));	
				
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getDb", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
// 등록된 글의 개수를 구한다.    
	public int countOrder(List whereCond, Map valueMap) throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(a.seq) from  purchase_order a inner join member b on a.mseq=b.mseq ");
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
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

   /** * 목록을 읽어온다.  */     
	public List selectListOrder(List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null;
		Reader reader=null;
		Reader reader2=null;
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from  purchase_order a inner join member b on a.mseq=b.mseq   ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }              
			query.append(" order by a.seq desc  limit ?, ?");			
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
            
            rs = pstmtMessage.executeQuery();
            if (rs.next()) {                 
				List list = new java.util.ArrayList(endRow-startRow+1);                 
                do {
                    BeanOrderBunsho  member = new  BeanOrderBunsho();
					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setRegister(rs.getTimestamp("register"));
					member.setContact_order(rs.getString("contact_order"));
					member.setSign_01(rs.getInt("sign_01"));
					member.setSign_02(rs.getInt("sign_02"));				
					member.setSign_03(rs.getInt("sign_03"));
					member.setSign_01_yn(rs.getInt("sign_01_yn"));
					member.setSign_02_yn(rs.getInt("sign_02_yn"));
					member.setSign_03_yn(rs.getInt("sign_03_yn"));
					member.setKind_urgency(rs.getInt("kind_urgency"));
					member.setComment(rs.getString("comment"));
					member.setHizuke(rs.getString("hizuke"));
					member.setTitle(rs.getString("title"));
					member.setDel_yn(rs.getInt("del_yn"));
					member.setGet_yn(rs.getInt("get_yn"));
					member.setSign_no_riyu_01(rs.getString("sign_no_riyu_01"));
					member.setSign_no_riyu_02(rs.getString("sign_no_riyu_02"));
					member.setSign_no_riyu_03(rs.getString("sign_no_riyu_03"));
                    
                    list.add(member);
                } while(rs.next());
                
                return list;
                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MgrException("selectList", ex);
        } finally { 
			if (rs != null)
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
 
//모든 상품
// 등록된 글의 개수를 구한다.    
	public int countOrderAll(List whereCond, Map valueMap) throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append(
				"select count(distinct a.seq) from  purchase_order a "+
				"inner join member b on a.mseq=b.mseq "+
				"inner join purchase_order_item c on a.seq=c.parent_seq ");

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
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

	public List selectListOrderAll(List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null;
		Reader reader=null;
		Reader reader2=null;
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append(
			"select *,c.seq as item_seq,count(c.seq) as qty  "+
			"from  purchase_order a  "+
			"inner join member b on a.mseq=b.mseq "+
			"inner join purchase_order_item c on a.seq=c.parent_seq	");
			
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }              
			query.append(" group by a.seq order by a.seq desc , c.seq asc limit ?, ?");			
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
            
            rs = pstmtMessage.executeQuery();
            if (rs.next()) {                 
				List list = new java.util.ArrayList(endRow-startRow+1);                 
                do {
                    BeanOrderBunsho  member = new  BeanOrderBunsho();
					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setRegister(rs.getTimestamp("register"));
					member.setContact_order(rs.getString("contact_order"));
					member.setSign_01(rs.getInt("sign_01"));
					member.setSign_02(rs.getInt("sign_02"));				
					member.setSign_03(rs.getInt("sign_03"));
					member.setSign_01_yn(rs.getInt("sign_01_yn"));
					member.setSign_02_yn(rs.getInt("sign_02_yn"));
					member.setSign_03_yn(rs.getInt("sign_03_yn"));
					member.setKind_urgency(rs.getInt("kind_urgency"));
					member.setComment(rs.getString("comment"));
					member.setHizuke(rs.getString("hizuke"));
					member.setTitle(rs.getString("title"));
					member.setDel_yn(rs.getInt("del_yn"));
					member.setGet_yn(rs.getInt("get_yn"));
					member.setSign_no_riyu_01(rs.getString("sign_no_riyu_01"));
					member.setSign_no_riyu_02(rs.getString("sign_no_riyu_02"));
					member.setSign_no_riyu_03(rs.getString("sign_no_riyu_03"));

					member.setItem_seq(rs.getInt("item_seq"));
					member.setParent_seq(rs.getInt("parent_seq"));				
					member.setProduct_nm(rs.getString("product_nm"));
					member.setOrder_no(rs.getString("order_no"));
					member.setClient_nm(rs.getInt("client_nm"));
					member.setProduct_qty(rs.getInt("product_qty"));
					member.setUnit_price(rs.getInt("unit_price"));
					member.setDel_yn_item(rs.getInt("del_yn_item"));
					member.setQty(rs.getInt("qty"));
					member.setName(rs.getString("nm"));

                    
                    list.add(member);
                } while(rs.next());
                
                return list;
                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MgrException("selectListAll", ex);
        } finally { 
			if (rs != null)
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }


public void changeSign(int sign_ok, int seq, int kubun, String noRiyu) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
		// kubun=1은 sign_01, 2는 sign_02, 3은 sign_03
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);
if(kubun==1){
		pstmt = conn.prepareStatement("update purchase_order set sign_01_yn=?,sign_no_riyu_01=? where seq=?");
}else if(kubun==2){
		pstmt = conn.prepareStatement("update purchase_order set sign_02_yn=?,sign_no_riyu_02=? where seq=?");
}else if(kubun==3){
		pstmt = conn.prepareStatement("update purchase_order set sign_03_yn=?,sign_no_riyu_03=? where seq=?");
}
			pstmt.setInt(1, sign_ok);
			pstmt.setString(2, noRiyu);
            pstmt.setInt(3, seq);
			
            
            pstmt.executeUpdate();
            conn.commit();
		 }catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("changeSign", ex);
		 }finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
  }

public void changeDelYn(int seq, int del_yn) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
		        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);

			pstmt = conn.prepareStatement("update purchase_order set del_yn=? where seq=?");

			pstmt.setInt(1, del_yn);
            pstmt.setInt(2, seq);			
            
            pstmt.executeUpdate();
            conn.commit();
		 }catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("changeDelYn", ex);
		 }finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
  }

public void changeChumong(int seq, int sign, int kubun) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
		        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);
if(sign==2 && kubun==1){
	pstmt = conn.prepareStatement("update purchase_order set sign_03_yn=? where seq=?");
			pstmt.setInt(1, sign);
            pstmt.setInt(2, seq);	

}else if(sign==1 && kubun==1){
	pstmt = conn.prepareStatement("update purchase_order set sign_01_yn=?, sign_02_yn=?,sign_03_yn=? where seq=?");

			pstmt.setInt(1, sign);
			pstmt.setInt(2, sign);
            pstmt.setInt(3, sign);
			pstmt.setInt(4, seq);
}else if(kubun==2){
	pstmt = conn.prepareStatement("update purchase_order set get_yn=? where seq=?");

			pstmt.setInt(1, sign);			
            pstmt.setInt(2, seq);			
}							
            
            pstmt.executeUpdate();
            conn.commit();
		 }catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("changeChumong", ex);
		 }finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
  }
public List listItem(int parent_seq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(			
				"SELECT * from purchase_order_item WHERE parent_seq=?  ORDER BY seq asc ");
			pstmt.setInt(1,parent_seq);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    BeanOrderBunsho  member = new  BeanOrderBunsho();		
					
					member.setSeq(rs.getInt("seq"));
					member.setParent_seq(rs.getInt("parent_seq"));				
					member.setProduct_nm(rs.getString("product_nm"));
					member.setOrder_no(rs.getString("order_no"));
					member.setClient_nm(rs.getInt("client_nm"));
					member.setProduct_qty(rs.getInt("product_qty"));
					member.setUnit_price(rs.getInt("unit_price"));	
					member.setDel_yn_item(rs.getInt("del_yn_item"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listItem", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }


public List listSignOrder(int sign, int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader=null; Reader reader2=null;
        try {            
            conn = DBUtil.getConnection(POOLNAME);  
if(level==1){
				pstmt = conn.prepareStatement(
				"SELECT *,count(c.seq) as qty from purchase_order a "+
				"LEFT JOIN member b ON a.sign_01=b.mseq "+
				"LEFT JOIN purchase_order_item c on a.seq=c.parent_seq "+
				"WHERE (a.sign_01=?) "+
				"AND (a.sign_01_yn=1 OR a.sign_01_yn=3 OR a.del_yn=2) "+
				"AND (a.sign_02_yn=2  )"+
				"AND (a.get_yn=1) "+
				"group by a.seq order by a.seq desc ");

}else if(level==2){
				 pstmt = conn.prepareStatement(
				"SELECT *,count(c.seq) as qty from purchase_order a "+
				"LEFT JOIN member b ON a.sign_01=b.mseq "+
				"LEFT JOIN purchase_order_item c on a.seq=c.parent_seq "+
				"WHERE (a.sign_02=?) "+
				"AND (a.sign_02_yn=1 OR a.sign_02_yn=3 OR a.del_yn=2) "+
				"AND (a.sign_03_yn=2)"+
				"AND (a.get_yn=1) "+
				"group by a.seq order by a.seq desc ");

}else if(level==3){
				 pstmt = conn.prepareStatement(
				"SELECT *,count(c.seq) as qty from purchase_order a "+
				"LEFT JOIN member b ON a.sign_03=b.mseq "+
				"LEFT JOIN purchase_order_item c on a.seq=c.parent_seq "+
				"WHERE (a.sign_03=?) "+				
				"AND (a.sign_03_yn=1  OR a.sign_03_yn=3 OR a.del_yn=2 ) "+
				"AND (a.get_yn=1) "+
				"group by a.seq order by a.seq desc ");
}
			pstmt.setInt(1,sign);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                     BeanOrderBunsho  member = new  BeanOrderBunsho();
					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setRegister(rs.getTimestamp("register"));
					member.setContact_order(rs.getString("contact_order"));
					member.setSign_01(rs.getInt("sign_01"));
					member.setSign_02(rs.getInt("sign_02"));				
					member.setSign_03(rs.getInt("sign_03"));
					member.setSign_01_yn(rs.getInt("sign_01_yn"));
					member.setSign_02_yn(rs.getInt("sign_02_yn"));
					member.setSign_03_yn(rs.getInt("sign_03_yn"));
					member.setKind_urgency(rs.getInt("kind_urgency"));
					member.setComment(rs.getString("comment"));
					member.setHizuke(rs.getString("hizuke"));
					member.setTitle(rs.getString("title"));
					member.setDel_yn(rs.getInt("del_yn"));
					member.setQty(rs.getInt("qty"));
					member.setName(rs.getString("nm"));
					member.setSign_no_riyu_01(rs.getString("sign_no_riyu_01"));
					member.setSign_no_riyu_02(rs.getString("sign_no_riyu_02"));
					member.setSign_no_riyu_03(rs.getString("sign_no_riyu_03"));
                    
                    list.add(member);
                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listSignOrder", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public List listContact_order() throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from purchase_order group by contact_order order by register " );						
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    BeanOrderBunsho  board = new  BeanOrderBunsho(); 					
					
					board.setSeq(rs.getInt("seq"));
					board.setMseq(rs.getInt("mseq"));
					board.setRegister(rs.getTimestamp("register"));
					board.setContact_order(rs.getString("contact_order"));
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listContact_order", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//---------------------------결재ok   kindPosi(1=boss, 2=bucho)-------------------------
public void signOk(int seq,int sign_ok,int kindPosi) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);           
            
if(kindPosi==1){	
	pstmt = conn.prepareStatement("update purchase_order set sign_01_yn=? where seq=? " );	
}else if(kindPosi==2){	
	pstmt = conn.prepareStatement("update purchase_order set sign_02_yn=? where seq=? " );	
}else if(kindPosi==3){	
	pstmt = conn.prepareStatement("update purchase_order set sign_03_yn=? where seq=? " );	
}	
			pstmt.setInt(1, sign_ok);			
			pstmt.setInt(2, seq);			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("signOk !!");
            }
        } catch(SQLException ex) {
            throw new MgrException("signOk !!", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


//어드민 메인페이지 출력 결재사항 (결재 및 본인이 반환한 건)
//------------level 1= First Boss , 2=Second Boss 3=Third-------------------
public BeanOrderBunsho getSignYnOrder(String id , int level)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME); 			
if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt  "+
				"FROM purchase_order a "+
				"LEFT JOIN member b ON a.sign_01 = b.mseq "+
				"WHERE (a.sign_01_yn=1 OR a.sign_01_yn=3 OR del_yn=2) "+
				"AND (b.member_id=?) "+
				"AND (a.get_yn=1) "+
				"AND (a.sign_02_yn=2) "+
				"GROUP BY a.sign_01 " );	

}else if(level==2){
			pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt  "+
				"FROM purchase_order a "+
				"LEFT JOIN member b ON a.sign_02 = b.mseq "+
				"WHERE (a.sign_02_yn=1 OR a.sign_02_yn=3 OR del_yn=2)"+
				"AND (b.member_id=? )"+
				"AND (a.get_yn=1 ) "+
				"AND (a.sign_03_yn=2) "+				
				"GROUP BY a.sign_02 " );
}else if(level==3){
			 pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt  "+
				"FROM purchase_order a "+
				"LEFT JOIN member b ON a.sign_03 = b.mseq "+
				"WHERE (a.sign_03_yn=1 OR a.sign_03_yn=3 OR del_yn=2) "+
				"AND (b.member_id=?) "+
				"AND (a.get_yn=1) "+							
				"GROUP BY a.sign_03 " );	
}
			pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {                
					BeanOrderBunsho  member = new  BeanOrderBunsho();
					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));					
					member.setSign_01(rs.getInt("sign_01"));
					member.setSign_02(rs.getInt("sign_02"));				
					member.setSign_03(rs.getInt("sign_03"));
					member.setSign_01_yn(rs.getInt("sign_01_yn"));
					member.setSign_02_yn(rs.getInt("sign_02_yn"));
					member.setSign_03_yn(rs.getInt("sign_03_yn"));					
					member.setDel_yn(rs.getInt("del_yn"));
					member.setQty(rs.getInt("cnt"));
					member.setName(rs.getString("nm"));
					
                    
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSignYnOrder", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

public List listSignYnOrderReturn(String id , int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		
        try {            
            conn = DBUtil.getConnection(POOLNAME); 				
if(level==2){
			pstmt = conn.prepareStatement(
				"SELECT * FROM purchase_order a "+
				"LEFT JOIN member b ON a.sign_03 = b.mseq "+
				"WHERE (a.sign_01_yn=3)"+
				"AND (b.member_id=? )"+
				"AND (a.get_yn=1) "+
				"AND (a.sign_03_yn=2) " );
}else if(level==3){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM purchase_order a "+
				"LEFT JOIN member b ON a.sign_03 = b.mseq "+
				"WHERE (a.sign_02_yn=3 ) "+
				"AND (b.member_id=?) "+
				"AND (a.get_yn=1) " );	
}
			pstmt.setString(1, id);		
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    BeanOrderBunsho  member = new  BeanOrderBunsho();		
					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));					
					member.setSign_01(rs.getInt("sign_01"));
					member.setSign_02(rs.getInt("sign_02"));				
					member.setSign_03(rs.getInt("sign_03"));
					member.setSign_01_yn(rs.getInt("sign_01_yn"));
					member.setSign_02_yn(rs.getInt("sign_02_yn"));
					member.setSign_03_yn(rs.getInt("sign_03_yn"));
					member.setKind_urgency(rs.getInt("kind_urgency"));
					member.setComment(rs.getString("comment"));
					member.setHizuke(rs.getString("hizuke"));
					member.setTitle(rs.getString("title"));
					member.setDel_yn(rs.getInt("del_yn"));
					member.setGet_yn(rs.getInt("get_yn"));
					member.setSign_no_riyu_01(rs.getString("sign_no_riyu_01"));
					member.setSign_no_riyu_02(rs.getString("sign_no_riyu_02"));
					member.setSign_no_riyu_03(rs.getString("sign_no_riyu_03"));
					member.setName(rs.getString("nm"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listSignYnOrderReturn", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//최종 주문자 물품확인
public List listFinalConfirm(String id) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		
        try {            
            conn = DBUtil.getConnection(POOLNAME);
			pstmt = conn.prepareStatement(
				"SELECT * FROM purchase_order a "+
				"LEFT JOIN member b ON a.sign_03 = b.mseq "+
				"WHERE (a.sign_01_yn=2) "+
				"AND (b.member_id=?) "+
				"AND (a.get_yn=1) "+
				"AND (a.del_yn=1)  " );

			pstmt.setString(1, id);		
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    BeanOrderBunsho  member = new  BeanOrderBunsho();		
					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));					
					member.setSign_01(rs.getInt("sign_01"));
					member.setSign_02(rs.getInt("sign_02"));				
					member.setSign_03(rs.getInt("sign_03"));
					member.setSign_01_yn(rs.getInt("sign_01_yn"));
					member.setSign_02_yn(rs.getInt("sign_02_yn"));
					member.setSign_03_yn(rs.getInt("sign_03_yn"));
					member.setKind_urgency(rs.getInt("kind_urgency"));
					member.setComment(rs.getString("comment"));
					member.setHizuke(rs.getString("hizuke"));
					member.setTitle(rs.getString("title"));
					member.setDel_yn(rs.getInt("del_yn"));
					member.setGet_yn(rs.getInt("get_yn"));
					member.setSign_no_riyu_01(rs.getString("sign_no_riyu_01"));
					member.setSign_no_riyu_02(rs.getString("sign_no_riyu_02"));
					member.setSign_no_riyu_03(rs.getString("sign_no_riyu_03"));
					member.setName(rs.getString("nm"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listFinalConfirm", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

}