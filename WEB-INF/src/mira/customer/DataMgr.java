package mira.customer;

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

public class DataMgr {
    private static DataMgr instance = new DataMgr();
    
    public static DataMgr getInstance() {
        return instance;
    }
    
    private DataMgr() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insertDb(DataBean member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 회원의 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"customer"));		
            pstmt = conn.prepareStatement( "insert into customer values (?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq()); 
			pstmt.setString(3, member.getMail_address());			
			pstmt.setString(4, member.getName1());
			pstmt.setString(5, member.getName2());
			pstmt.setString(6, member.getKuni());
			pstmt.setCharacterStream(7,  new StringReader(member.getComment()), member.getComment().length());	
            pstmt.setTimestamp(8, member.getRegister());
			pstmt.setInt(9, member.getAnswer_yn()); 
            
            pstmt.executeUpdate();
        } catch(SQLException ex) {
            throw new MgrException("insertMember", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    public DataBean getDb(String id)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * from customer where mail_address = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBean member = new DataBean();
				member.setMseq(rs.getInt("mseq"));	
				member.setSeq(rs.getInt("seq"));	
                member.setMail_address(rs.getString("mail_address"));				
				member.setName1(rs.getString("name1"));	
				member.setName2(rs.getString("name2"));
				member.setKuni(rs.getString("kuni"));	
							try{
								reader=rs.getCharacterStream("comment");
								char[] buff=new char[512];
								int len=-1;
								StringBuffer buffer=new StringBuffer(512);
								while((len=reader.read(buff)) != -1){
									buffer.append(buff,0,len);
								}
								member.setComment(buffer.toString());
								}catch (IOException iex){
									throw new MgrException("content select",iex);
								}finally{
									if(reader !=null)try	{reader.close();}
									catch (IOException iex){}
								} 
				member.setRegister(rs.getTimestamp("register"));				
				member.setAnswer_yn(rs.getInt("answer_yn"));				
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getMember", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
    
    
    public void deleteDb(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
            	"delete from customer where	seq=?");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("存在してない Dataです.");
            }
        } catch(SQLException ex) {
            throw new MgrException("deleteDb", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

	 public DataBean  delSelect(int seq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;  
        
        try {
            DataBean  member = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmt = conn.prepareStatement("select * from customer  where seq = ?");
            pstmt.setInt(1, seq); 
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				member= new DataBean();
                member.setSeq(rs.getInt("seq"));
                member.setName1 ( rs.getString("name1"));   
                member.setName2 ( rs.getString("name2"));   
				
				return member;
            } else {  return null;   }
          
        } catch(SQLException ex) {
            throw new MgrException("select", ex);
        } finally {             
			if (rs != null)  try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null)  try { pstmt.close(); } catch(SQLException ex) {}             
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
    

// 등록된 글의 개수를 구한다.    
	public int count(List whereCond, Map valueMap) throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from  customer ");
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
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null;
		Reader reader=null;
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from customer ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
              
			query.append(" order by seq desc  limit ?, ?");
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
                    DataBean  member = new  DataBean();
                    
                    member.setSeq(rs.getInt("seq"));	
					member.setMseq(rs.getInt("mseq"));				
                    member.setMail_address(rs.getString("mail_address"));    				
    				member.setName1(rs.getString("name1"));	
    				member.setName2(rs.getString("name2"));	
					member.setKuni(rs.getString("kuni"));
							try{
								reader=rs.getCharacterStream("comment");
								char[] buff=new char[512];
								int len=-1;
								StringBuffer buffer=new StringBuffer(512);
								while((len=reader.read(buff)) != -1){
									buffer.append(buff,0,len);
								}
								member.setComment(buffer.toString());
								}catch (IOException iex){
									throw new MgrException("content select",iex);
								}finally{
									if(reader !=null)try	{reader.close();}
									catch (IOException iex){}
								} 
    				member.setRegister(rs.getTimestamp("register"));    				
    				member.setAnswer_yn(rs.getInt("answer_yn"));
                    
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
public void changeAnswer(int answer, int seq) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);
            pstmt = conn.prepareStatement("update customer set answer_yn=? where seq=?");
			pstmt.setInt(1, answer);
            pstmt.setInt(2, seq);
            
            pstmt.executeUpdate();
            conn.commit();
		 }catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("updateViewSeq()", ex);
		 }finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
  }
}