package mira.kaigi;

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
import mira.member.Member;

public class DataMgr {
    private static DataMgr instance = new DataMgr();
    
    public static DataMgr getInstance() {
        return instance;
    }
    
    private DataMgr() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insertDbSchedule(DataBean member)  throws MemberManagerException {     
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"kaigi"));
            pstmt = conn.prepareStatement( "insert into kaigi values (?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());
			pstmt.setInt(3, member.getBasho());
			pstmt.setString(4, member.getDuring_begin());
			pstmt.setString(5, member.getDuring_end());
			pstmt.setString(6, member.getJikan_begin());
			pstmt.setString(7, member.getJikan_end());
			pstmt.setString(8, member.getBun_begin());
			pstmt.setString(9, member.getBun_end());			
			pstmt.setString(10, member.getTitle());					
            	pstmt.setTimestamp(11, member.getRegister()); 
            	pstmt.setInt(12, member.getView_seq());
            	
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MemberManagerException("insertDbkaigi", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

		     
    public DataBean getDb(int seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from kaigi a inner join member b on a.mseq=b.mseq where a.seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBean member = new DataBean();
                
  				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));              
   				member.setDuring_begin(rs.getString("during_begin"));
				member.setDuring_end(rs.getString("during_end"));                   
                		member.setJikan_begin(rs.getString("jikan_begin"));
				member.setJikan_end(rs.getString("jikan_end"));           
				member.setBun_begin(rs.getString("bun_begin"));
				member.setBun_end(rs.getString("bun_end"));                           
				member.setTitle(rs.getString("title"));				
				member.setRegister(rs.getTimestamp("register"));				
				member.setMember_id(rs.getString("member_id"));
				member.setPassword(rs.getString("password"));				
				member.setNm(rs.getString("nm"));				
				member.setBasho(rs.getInt("basho"));
				member.setView_seq(rs.getInt("view_seq"));
				
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getDb", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
//수정
	public void update(DataBean member)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( 	
			"update kaigi set basho=?,during_begin=?,during_end=?,jikan_begin=?,jikan_end=?,bun_begin=?,bun_end=?,title=? where seq=?");            
			
			pstmt.setInt(1, member.getBasho());
			pstmt.setString(2, member.getDuring_begin());
			pstmt.setString(3, member.getDuring_end());
			pstmt.setString(4, member.getJikan_begin());
			pstmt.setString(5, member.getJikan_end());
			pstmt.setString(6, member.getBun_begin());
			pstmt.setString(7, member.getBun_end());			
			pstmt.setString(8, member.getTitle());			
			pstmt.setInt(9, member.getSeq());
			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("update", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
/*수정 kintai
	public void updateKintai(DataBean member)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( 
				"update schedule set during_begin=?,during_end=?,title=?,"+
				"ichinichi_begin=?,ichinichi_end=?,basho=?,basho_detail=? where kintai_seq=? ");           
			
			pstmt.setString(1, member.getDuring_begin());	
			pstmt.setString(2, member.getDuring_end());	
			pstmt.setString(3, member.getTitle());
			pstmt.setString(4, member.getIchinichi_begin());
			pstmt.setString(5, member.getIchinichi_end());
			pstmt.setString(6, member.getBasho());
			pstmt.setString(7, member.getBasho_detail());
			pstmt.setInt(8, member.getSeq());
			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("update", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
//수정시 사인 취소
	public void updateSignOkCancel(int seq)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( 
				"update schedule_signup set sign_ok=1 where schedule_seq=? ");           
			pstmt.setInt(1, seq);			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("updateSignOkCancel", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}*/
public void deleteSch(int seq)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
 				"DELETE kaigi, kaigi_fellow "+
				"From kaigi "+								
				"LEFT JOIN kaigi_fellow ON kaigi.seq=kaigi_fellow.kaigi_seq "+
				"where kaigi.seq=? ");           	
            	
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない Dataです. schedule");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteSch", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
/*
	public void deleteSchSignup(int seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"delete from schedule_signup where	schedule_seq=?");
            pstmt.setInt(1, seq);
            pstmt.executeUpdate();
            
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteSchSignup", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
*/
public void deleteSchFellow(int seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"delete from kaigi_fellow where kaigi_seq=?");
            pstmt.setInt(1, seq);
            pstmt.executeUpdate();
            
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteKaigiFellow", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
/*
public void deleteSchKintak(int seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"delete from schedule where	kintai_seq=?");
            pstmt.setInt(1, seq);
            pstmt.executeUpdate();
            
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteSchKintak", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
*/
// 등록된 글의 개수를 구한다.    
	public int count(List whereCond, Map valueMap) throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from  kaigi ");
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
            throw new MemberManagerException("count", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

   /** * 목록을 읽어온다.  */     
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null;
		Reader reader=null;
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from kaigi ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
              
			query.append(" order by jikan_begin asc  limit ?, ?");
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
					member.setBasho(rs.getInt("basho"));					
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setJikan_begin(rs.getString("jikan_begin"));
					member.setJikan_end(rs.getString("jikan_end"));
					member.setBun_begin(rs.getString("bun_begin"));
					member.setBun_end(rs.getString("bun_end"));					
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));					
                    
                    list.add(member);
                } while(rs.next());
                
                return list;
                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally { 
			if (rs != null)
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }




//*****************************************schedule_signup************************
/*
 public void insertDbSign(DataBean member)  throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmtsignup = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
                    
			member.setSseq(Sequencer.nextId(conn,"schedule_signup"));
			pstmtsignup = conn.prepareStatement( "insert into schedule_signup values (?,?,?,?)");
			pstmtsignup.setInt(1, member.getSseq());
			pstmtsignup.setInt(2, member.getSchedule_seq());
			pstmtsignup.setInt(3, member.getMseq());
			pstmtsignup.setInt(4, member.getSign_ok());			          
            pstmtsignup.executeUpdate();		

        } catch(SQLException ex) {
            throw new MemberManagerException("insertDbSign", ex);
        } finally {            
			if (pstmtsignup != null) try { pstmtsignup.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    public DataBean getDbSign(int sseq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * from schedule_signup where sseq = ?");
            pstmt.setInt(1, sseq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBean member = new DataBean();	
				member.setSseq(rs.getInt("sseq"));
				member.setSchedule_seq(rs.getInt("schedule_seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setSign_ok(rs.getInt("sign_ok"));
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getDbSign", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
*/	
//************kaigi_fellow************************
 public void insertDbFellow(DataBean member)  throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmtsignup = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
                    
			member.setFellow_seq(Sequencer.nextId(conn,"kaigi_fellow"));
			pstmtsignup = conn.prepareStatement( "insert into kaigi_fellow values (?,?,?,?)");
			pstmtsignup.setInt(1, member.getFellow_seq());
			pstmtsignup.setInt(2, member.getKaigi_seq());
			pstmtsignup.setInt(3, member.getMseq());
			pstmtsignup.setString(4, member.getNm_sanseki());					          
            pstmtsignup.executeUpdate();		

        } catch(SQLException ex) {
            throw new MemberManagerException("insertDbfellow", ex);
        } finally {            
			if (pstmtsignup != null) try { pstmtsignup.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
  public List listFellow_seq(int kaigi_seq) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from kaigi_fellow where kaigi_seq = ?" );  
			pstmt.setInt(1, kaigi_seq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();										
                    		member.setSeq(rs.getInt("seq"));
					member.setKaigi_seq(rs.getInt("kaigi_seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setNm_sanseki(rs.getString("nm_sanseki"));					
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("listFellow_seq", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }


public void deleteFellowUpdate(int seq)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"delete from kaigi_fellow where kaigi_seq=?");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("No Data.");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteFellowUpdate", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

/****************회의 참석자 카운트********************/
 public int  fellowCnt(int  seq) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from kaigi_fellow where kaigi_seq=?");
			stmt.setInt(1, seq);			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MemberManagerException("getCount", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
   
   public List listFel_Name(int kaigi_seq) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * "+
				"FROM kaigi_fellow a  "+
				"LEFT JOIN member b on a.mseq=b.mseq  "+
				"WHERE (kaigi_seq =? ) AND (b.member_yn=2) "+
				"ORDER BY a.seq asc" );  
			pstmt.setInt(1, kaigi_seq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();										
                    		member.setSeq(rs.getInt("seq"));
					member.setKaigi_seq(rs.getInt("kaigi_seq"));
					member.setMseq(rs.getInt("mseq"));	
					member.setMail_address(rs.getString("mail_address"));
					member.setNm(rs.getString("nm"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("listFellowName", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
 
   
    
// 등록된 글의 개수를 구한다.    
/*
	public int countSign(List whereCond, Map valueMap) throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from  schedule_signup ");
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
            throw new MemberManagerException("count", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

   /** * 목록을 읽어온다.  */     
   /*
	public List selectListSign(List whereCond, Map valueMap, int startRow, int endRow)
    throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null;
		Reader reader=null;
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from schedule_signup ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
              
			query.append(" order by sseq desc  limit ?, ?");
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

					member.setSseq(rs.getInt("sseq"));
					member.setSchedule_seq(rs.getInt("schedule_seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
                    list.add(member);
                } while(rs.next());
                
                return list;
                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MemberManagerException("selectListSign", ex);
        } finally { 
			if (rs != null)
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
*/
/*
public void changeAnswer(int sign_ok, int sseq) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);
            pstmt = conn.prepareStatement("update schedule_signup set sign_ok=? where sseq=?");
			pstmt.setInt(1, sign_ok);
            pstmt.setInt(2, sseq);
            
            pstmt.executeUpdate();
            conn.commit();
		 }catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MemberManagerException("changeAnswer", ex);
		 }finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
  }
*/
  public int getIdSeq(String kaigi)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select seqno from id_seq  where seqnm = ?");
            pstmt.setString(1, kaigi);
            rs = pstmt.executeQuery(); 
			
			int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;

        } catch(SQLException ex) {
            throw new MemberManagerException("getIdSeq", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

public List listSchedule(String ymdVal) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * "+ 
				"FROM  kaigi a "+  
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE date_format(?, '%Y-%m-%d')>=date_format(during_begin, '%Y-%m-%d') "+  
				"AND (date_format(?, '%Y-%m-%d')<=date_format(during_end, '%Y-%m-%d')) "+ 
				"AND (b.member_yn=2) ORDER BY a.view_seq asc" );  
			pstmt.setString(1,ymdVal);
			pstmt.setString(2,ymdVal);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();										
                    		member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setBasho(rs.getInt("basho"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setJikan_begin(rs.getString("jikan_begin"));
					member.setJikan_end(rs.getString("jikan_end"));					
					member.setBun_begin(rs.getString("bun_begin"));
					member.setBun_end(rs.getString("bun_end"));												
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));					
					member.setPassword(rs.getString("password"));
					member.setNm(rs.getString("nm"));									
					member.setBusho(rs.getString("busho"));					

					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

public List listScheduleEnd(String ymdVal) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * "+
				"FROM kaigi a  "+
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE (a.during_end=?) AND (b.member_yn=2) "+ 
				"ORDER BY a.during_begin asc" );  
			pstmt.setString(1,ymdVal);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();
                    
                                member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setBasho(rs.getInt("basho"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setJikan_begin(rs.getString("jikan_begin"));
					member.setJikan_end(rs.getString("jikan_end"));					
					member.setBun_begin(rs.getString("bun_begin"));
					member.setBun_end(rs.getString("bun_end"));												
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));					
					member.setPassword(rs.getString("password"));
					member.setNm(rs.getString("nm"));									
					member.setBusho(rs.getString("busho"));					
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listScheduleBeginEnd(String ymdVal) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * "+
				"FROM kaigi a "+
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE (a.during_begin=? or a.during_end=?) and (b.member_yn=2) "+
				"ORDER BY a.during_begin asc" );  
			pstmt.setString(1,ymdVal);
			pstmt.setString(2,ymdVal);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();
                    		member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setBasho(rs.getInt("basho"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setJikan_begin(rs.getString("jikan_begin"));
					member.setJikan_end(rs.getString("jikan_end"));					
					member.setBun_begin(rs.getString("bun_begin"));
					member.setBun_end(rs.getString("bun_end"));												
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));					
					member.setPassword(rs.getString("password"));
					member.setNm(rs.getString("nm"));									
					member.setBusho(rs.getString("busho"));					
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
public List listScheduleBeginEndAll(String ymdVal) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * "+
				"FROM kaigi a "+
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE (a.during_begin=? or a.during_end=?) and (b.member_yn=2) "+ 
				"OR (date_format(?, '%Y-%m-%d')>=date_format(during_begin, '%Y-%m-%d') "+ 
				"AND date_format(?, '%Y-%m-%d')<=date_format(during_end, '%Y-%m-%d')) "+
				"ORDER BY a.during_begin asc" );  
			pstmt.setString(1,ymdVal);
			pstmt.setString(2,ymdVal);
			pstmt.setString(3,ymdVal);
			pstmt.setString(4,ymdVal);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();
                                member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setBasho(rs.getInt("basho"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setJikan_begin(rs.getString("jikan_begin"));
					member.setJikan_end(rs.getString("jikan_end"));					
					member.setBun_begin(rs.getString("bun_begin"));
					member.setBun_end(rs.getString("bun_end"));												
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));					
					member.setPassword(rs.getString("password"));
					member.setNm(rs.getString("nm"));									
					member.setBusho(rs.getString("busho"));
					member.setView_seq(rs.getInt("view_seq"));					
                    		list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("listScheduleBeginEndAll", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

//달력 휴일 

public DataBean getHoriday(String ymd)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from schedule_hori where ymd=? ");
            pstmt.setString(1, ymd);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBean member = new DataBean();					
					member.setSeq(rs.getInt("seq"));					
					member.setDuring_begin(rs.getString("ymd"));					
					member.setTitle(rs.getString("title"));					
					
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getHoriday", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
public DataBean getHoridayData(int seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from schedule_hori where seq=? ");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBean member = new DataBean();					
					member.setSeq(rs.getInt("seq"));					
					member.setDuring_begin(rs.getString("ymd"));					
					member.setTitle(rs.getString("title"));					
					
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getHoridayData", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}	

public int countHori(List whereCond, Map valueMap) throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from  schedule_hori ");
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
            throw new MemberManagerException("count", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }


//스케줄 그래프에 사용, 시작일과 마지막날간의 날짜
public List getDateDuring(String todayYmd,int view_seq) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
		"select * from kaigi a "+ 
		"LEFT JOIN member b on a.mseq=b.mseq "+	
		"where date_format(?, '%Y-%m-%d')>=date_format(during_begin, '%Y-%m-%d') "+ 
		"AND date_format(?, '%Y-%m-%d')<=date_format(during_end, '%Y-%m-%d') "+
		"AND view_seq=? "+
		"ORDER BY a.during_begin,b.position_level asc");
            	pstmt.setString(1, todayYmd);
			pstmt.setString(2, todayYmd);
			pstmt.setInt(3, view_seq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();	
                    	      member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setBasho(rs.getInt("basho"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setJikan_begin(rs.getString("jikan_begin"));
					member.setJikan_end(rs.getString("jikan_end"));					
					member.setBun_begin(rs.getString("bun_begin"));
					member.setBun_end(rs.getString("bun_end"));												
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));					
					member.setPassword(rs.getString("password"));
					member.setNm(rs.getString("nm"));									
					member.setBusho(rs.getString("busho"));				                    
					member.setMember_id(rs.getString("member_id"));
					member.setMail_address(rs.getString("mail_address"));					
					member.setNm(rs.getString("nm"));	
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("getDateDuring", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
/*
    public List listSchedule_seq(int kaigi_seq) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT *  "+
				"FROM schedule_signup a  "+
				"LEFT JOIN member b on a.mseq=b.mseq  "+
				"WHERE schedule_seq=? AND (b.member_yn=2) "+
				"ORDER BY a.sseq asc " );  
			pstmt.setInt(1, schedule_seq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();										
                    member.setSseq(rs.getInt("sseq"));
					member.setSchedule_seq(rs.getInt("schedule_seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setNm(rs.getString("nm"));
					member.setMimg(rs.getString("mimg"));					

					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("listSchedule_seq", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
    public void deleteDbSign(int sseq)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"delete from schedule_signup where	sseq=?");
            pstmt.setInt(1, sseq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("No Data.");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteDbSign", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public void deleteSignUpdate(int seq)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"delete from schedule_signup where	schedule_seq=?");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("No Data.");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteDbSign", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
*/
 //리스트 결재표시
/*
public List listScheduleSignStay(int schedule_seq) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * "+
				"FROM schedule_signup a "+
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE (a.schedule_seq=?) and (b.member_yn=2) "+
				"ORDER BY a.sseq asc" );  
			pstmt.setInt(1,schedule_seq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();										
                    member.setSseq(rs.getInt("sseq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setNm(rs.getString("nm"));
					member.setMimg(rs.getString("mimg"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//출퇴근장 삭제시 함께 삭제
/* public void deleteDbKintai(int kintai_seq)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( "delete from schedule where	kintai_seq=?");
            pstmt.setInt(1, kintai_seq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("No Data.");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteDbKintai", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
*/
//출퇴근장 수정시 수정사항 있으면 함께 수정
/*
 public void updateDbSchedule(DataBean member)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( 
				"update schedule set during_begin=?,during_end=?,title=?,"+
				"ichinichi_begin=?,ichinichi_end=?,basho=?,basho_detail=? where kintai_seq=? ");           
			
			pstmt.setString(1, member.getDuring_begin());	
			pstmt.setString(2, member.getDuring_end());	
			pstmt.setString(3, member.getTitle());
			pstmt.setString(4, member.getIchinichi_begin());
			pstmt.setString(5, member.getIchinichi_end());
			pstmt.setString(6, member.getBasho());
			pstmt.setString(7, member.getBasho_detail());
			pstmt.setInt(8, member.getKintai_seq());
			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteDbKintai", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
 
 
//잔업 수정시 수정사항 있으면 함께 수정
 public void updateDbScheduleJangyo(DataBean member)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( 
				"update schedule set during_begin=?,during_end=?,title=? where jangyo_seq=? ");           
			
			pstmt.setString(1, member.getDuring_begin());	
			pstmt.setString(2, member.getDuring_end());	
			pstmt.setString(3, member.getTitle());			
			pstmt.setInt(4, member.getJangyo_seq());			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteDbJangyo", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
 */ 
 //*******************************전체페이지 년/월/일에 따른 직원리스트 표시 begin********************
 /*
public int  listScheduleNewCnt(int mseq) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) "+
				"FROM kaigi a "+
				"LEFT JOIN schedule_signup b on a.seq=b.schedule_seq "+
				"WHERE (b.mseq=?) and (b.sign_ok=1 or b.sign_ok=3) "+
				"ORDER BY a.seq asc" );		
			
			stmt.setInt(1,mseq);			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MemberManagerException("listSignNewCnt test", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

public List listScheduleNew(int mseq) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * "+
				"FROM schedule a "+
				"LEFT JOIN schedule_signup b on a.seq=b.schedule_seq "+
				"WHERE (b.mseq=?) and (b.sign_ok=1 or b.sign_ok=3) "+
				"ORDER BY a.seq asc" );
			pstmt.setInt(1,mseq);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();										
                   			member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));
					member.setKintai_seq(rs.getInt("kintai_seq"));
					member.setSseq(rs.getInt("sseq"));
					member.setSchedule_seq(rs.getInt("schedule_seq"));					
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setIchinichi_begin(rs.getString("ichinichi_begin"));
					member.setIchinichi_end(rs.getString("ichinichi_end"));
					member.setBasho(rs.getString("basho"));
					member.setBasho_detail(rs.getString("basho_detail"));
					member.setJangyo_seq(rs.getInt("jangyo_seq"));
					member.setView_seq(rs.getInt("view_seq"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
  
  //결재ok
public void signSheOk(int sseq,int sign_ok) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("update schedule_signup set sign_ok=?  where sseq=?");			
			pstmt.setInt(1, sign_ok);	
			pstmt.setInt(2, sseq);	
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("ID was not in DB !!");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("ID was not in DB !!", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

public DataBean getKintaiSeq(int kintai_seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from schedule where kintai_seq = ?");
            pstmt.setInt(1, kintai_seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBean member = new DataBean();					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));
					member.setKintai_seq(rs.getInt("kintai_seq"));					
					member.setIchinichi_begin(rs.getString("ichinichi_begin"));
					member.setIchinichi_end(rs.getString("ichinichi_end"));
					member.setBasho(rs.getString("basho"));
					member.setBasho_detail(rs.getString("basho_detail"));
					member.setJangyo_seq(rs.getInt("jangyo_seq"));
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getKintaiSeq", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	

public DataBean getJangyoSeq(int jangyo_seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from schedule where jangyo_seq = ?");
            pstmt.setInt(1, jangyo_seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBean member = new DataBean();					
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setTitle(rs.getString("title"));					
					member.setRegister(rs.getTimestamp("register"));
					member.setKintai_seq(rs.getInt("kintai_seq"));					
					member.setIchinichi_begin(rs.getString("ichinichi_begin"));
					member.setIchinichi_end(rs.getString("ichinichi_end"));
					member.setBasho(rs.getString("basho"));
					member.setBasho_detail(rs.getString("basho_detail"));
					member.setJangyo_seq(rs.getInt("jangyo_seq"));
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getJangyoSeq", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	

//어드민 메인페이지 출력 결재사항  schedule
public List listSignOk_or_No(String id) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT *, a.mseq as sign_ok_mseq, COUNT(b.seq) as cnt "+
				"FROM schedule_signup as a "+
				"LEFT JOIN schedule as b on a.schedule_seq=b.seq "+
				"LEFT JOIN member c  on a.mseq=c.mseq "+
				"WHERE (a.sign_ok=1 or a.sign_ok=3) and (c.member_yn=2) and c.member_id=? "+
				"GROUP BY a.mseq  "+
				"ORDER BY c.position_level asc" );	
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBean  member = new  DataBean();										
                    member.setSeq(rs.getInt("seq"));
					member.setView_seq(rs.getInt("sign_ok_mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setNm(rs.getString("nm"));
					member.setJangyo_seq(rs.getInt("cnt"));					
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("listSignOk_or_No_Schedule", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    */
/*
public void insertHori(DataBean member)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"schedule_hori"));
            pstmt = conn.prepareStatement( "insert into schedule_hori values (?,?,?)");
			pstmt.setInt(1, member.getSeq());			
			pstmt.setString(2, member.getDuring_begin());			
			pstmt.setString(3, member.getTitle());					
            
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MemberManagerException("insertHori", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public void updateHori(DataBean member)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( 
				"update schedule_hori set ymd=?,title=? where seq=? ");           
			
			pstmt.setString(1, member.getDuring_begin());			
			pstmt.setString(2, member.getTitle());			
			pstmt.setInt(3, member.getSeq());			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("updateHori", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}
public void deleteHori(int seq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement( "delete from schedule_hori where seq=?");
            pstmt.setInt(1, seq);
            pstmt.executeUpdate();
            
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteHori", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    */
   /** * 목록을 읽어온다.  */     
 /*
	public List listHori(List whereCond, Map valueMap, int startRow, int endRow) throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null;
		Reader reader=null;
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from schedule_hori ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
              
			query.append(" order by ymd desc  limit ?, ?");
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
					member.setDuring_begin(rs.getString("ymd"));			
					member.setTitle(rs.getString("title"));

                    list.add(member);
                } while(rs.next());
                
                return list;
                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MemberManagerException("listHori", ex);
        } finally { 
			if (rs != null)
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
*/




}