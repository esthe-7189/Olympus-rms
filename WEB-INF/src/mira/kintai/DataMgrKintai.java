package mira.kintai;

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

public class DataMgrKintai {
    private static DataMgrKintai instance = new DataMgrKintai();
    
    public static DataMgrKintai getInstance() {
        return instance;
    }
    
    private DataMgrKintai() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insertDbSchedule(DataBeanKintai member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"comment_kintai"));
            pstmt = conn.prepareStatement( "insert into comment_kintai values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());
			pstmt.setInt(3, member.getSign_ok());
			pstmt.setString(4, member.getHizuke());
			pstmt.setInt(5, member.getSimya_hh());
			pstmt.setInt(6, member.getSimya_mm());
			pstmt.setInt(7, member.getHoliday_hh());
			pstmt.setInt(8, member.getHoliday_mm());
			pstmt.setString(9, member.getOneday_holi());
			pstmt.setString(10, member.getDaikyu());
			pstmt.setString(11, member.getDaikyu_date());
			pstmt.setInt(12, member.getChikoku_hh());
			pstmt.setInt(13, member.getChikoku_mm());
			pstmt.setInt(14, member.getBegin_hh());
			pstmt.setInt(15, member.getBegin_mm());
			pstmt.setInt(16, member.getEnd_hh());
			pstmt.setInt(17, member.getEnd_mm());
			pstmt.setString(18, member.getRiyu());
			pstmt.setCharacterStream(19,  new StringReader(member.getComment()), member.getComment().length());			
            pstmt.setTimestamp(20, member.getRegister()); 
			pstmt.setInt(21, member.getSign_ok_mseq());
			pstmt.setString(22, member.getSign_no_riyu());
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insertDbSchedule", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

	public void update(DataBeanKintai  member) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmtUpdate = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);        
            conn.setAutoCommit(false);
            pstmtUpdate = conn.prepareStatement( 
				"update comment_kintai set sign_ok=1,hizuke=?,simya_hh=?,simya_mm=?,holiday_hh=?,holiday_mm=?,oneday_holi=?, "+
				" daikyu=?,daikyu_date=?,chikoku_hh=?,chikoku_mm=?,begin_hh=?,begin_mm=?,end_hh=?,end_mm=?, "+
				" riyu=?,comment=?,sign_ok_mseq=? where seq=?"); 

			pstmtUpdate.setString(1, member.getHizuke());
			pstmtUpdate.setInt(2, member.getSimya_hh());
			pstmtUpdate.setInt(3, member.getSimya_mm());
			pstmtUpdate.setInt(4, member.getHoliday_hh());
			pstmtUpdate.setInt(5, member.getHoliday_mm());
			pstmtUpdate.setString(6, member.getOneday_holi());
			pstmtUpdate.setString(7, member.getDaikyu());
			pstmtUpdate.setString(8, member.getDaikyu_date());
			pstmtUpdate.setInt(9, member.getChikoku_hh());
			pstmtUpdate.setInt(10, member.getChikoku_mm());
			pstmtUpdate.setInt(11, member.getBegin_hh());
			pstmtUpdate.setInt(12, member.getBegin_mm());
			pstmtUpdate.setInt(13, member.getEnd_hh());
			pstmtUpdate.setInt(14, member.getEnd_mm());
			pstmtUpdate.setString(15, member.getRiyu());
			pstmtUpdate.setCharacterStream(16,  new StringReader(member.getComment()), member.getComment().length());
			pstmtUpdate.setInt(17, member.getSign_ok_mseq());
			pstmtUpdate.setInt(18, member.getSeq());


            pstmtUpdate.executeUpdate();	    
            conn.commit();    
        } catch(SQLException ex) { 
			try {conn.rollback();} catch(SQLException ex1) {} 
            throw new MgrException("update", ex);
        } finally {             
			if (pstmtUpdate != null) 
 	try { pstmtUpdate.close(); } catch(SQLException ex) {}            
            if (conn != null)  try {conn.setAutoCommit(true);   conn.close();  } catch(SQLException ex) {} 
        }
    }

// 결재완료 완료후 수정시 관련되는 테이블 삭제 .
public void deleteRelated(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"DELETE schedule, schedule_signup "+
				"From schedule "+				
				"LEFT JOIN schedule_signup ON schedule.seq=schedule_signup.schedule_seq "+
				"WHERE schedule.kintai_seq=? ");
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
		     
    public DataBeanKintai getDb(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from comment_kintai where seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanKintai member = new DataBeanKintai();					
				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setSign_ok(rs.getInt("sign_ok"));
				member.setHizuke(rs.getString("hizuke"));
				member.setSimya_hh(rs.getInt("simya_hh"));
				member.setSimya_mm(rs.getInt("simya_mm"));
				member.setHoliday_hh(rs.getInt("holiday_hh"));
				member.setHoliday_mm(rs.getInt("holiday_mm"));
				member.setOneday_holi(rs.getString("oneday_holi"));
				member.setDaikyu(rs.getString("daikyu"));
				member.setDaikyu_date(rs.getString("daikyu_date"));
				member.setChikoku_hh(rs.getInt("chikoku_hh"));
				member.setChikoku_mm(rs.getInt("chikoku_mm"));
				member.setBegin_hh(rs.getInt("begin_hh"));
				member.setBegin_mm(rs.getInt("begin_mm"));
				member.setEnd_hh(rs.getInt("end_hh"));
				member.setEnd_mm(rs.getInt("end_mm"));
				member.setRiyu(rs.getString("riyu"));
				member.setComment(rs.getString("comment"));				
				member.setRegister(rs.getTimestamp("register"));	
				member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
				member.setSign_no_riyu(rs.getString("sign_no_riyu"));
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
    public int getYmdVal(int mseq, String ymdVal)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select count(*) from comment_kintai where mseq=? and substring(hizuke,1,10)=? ");
            pstmt.setInt(1, mseq);
			pstmt.setString(2, ymdVal);
            rs = pstmt.executeQuery();
			int count=0;
            if (rs.next()) {
                count=rs.getInt(1);				
			}
                return count;
            
        } catch(SQLException ex) {
            throw new MgrException("getDb", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
 
 /*public void deleteDb(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"DELETE comment_kintai, schedule, schedule_signup "+
				"From comment_kintai "+
				"LEFT JOIN schedule ON comment_kintai.seq=schedule.kintai_seq "+
				"LEFT JOIN schedule_signup ON schedule.seq=schedule_signup.schedule_seq "+
				"where comment_kintai.seq=? ");
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
 */   
    public void deleteDb(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"DELETE comment_kintai, schedule "+
				"From comment_kintai "+
				"LEFT JOIN schedule ON comment_kintai.seq=schedule.kintai_seq "+				
				"where comment_kintai.seq=? ");
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
public void deleteKintai(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"DELETE from comment_kintai where seq=? ");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("存在してない Dataです.");
            }
        } catch(SQLException ex) {
            throw new MgrException("deleteKintai", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
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
			query.append("select count(*) from comment_kintai a inner join member b on a.mseq=b.mseq ");
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
			query.append("select * from comment_kintai a inner join member b on a.mseq=b.mseq where member_yn=2  ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("and ");                
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
                    DataBeanKintai  member = new  DataBeanKintai();

					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));
					member.setSimya_hh(rs.getInt("simya_hh"));
					member.setSimya_mm(rs.getInt("simya_mm"));
					member.setHoliday_hh(rs.getInt("holiday_hh"));
					member.setHoliday_mm(rs.getInt("holiday_mm"));
					member.setOneday_holi(rs.getString("oneday_holi"));
					member.setDaikyu(rs.getString("daikyu"));
					member.setDaikyu_date(rs.getString("daikyu_date"));
					member.setChikoku_hh(rs.getInt("chikoku_hh"));
					member.setChikoku_mm(rs.getInt("chikoku_mm"));
					member.setBegin_hh(rs.getInt("begin_hh"));
					member.setBegin_mm(rs.getInt("begin_mm"));
					member.setEnd_hh(rs.getInt("end_hh"));
					member.setEnd_mm(rs.getInt("end_mm"));
					member.setRiyu(rs.getString("riyu"));
					member.setComment(rs.getString("comment"));				
					member.setRegister(rs.getTimestamp("register"));					
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_no_riyu(rs.getString("sign_no_riyu"));
					member.setNm(rs.getString("nm"));
                    
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
  

public void changeAnswer(int sign_ok, int seq) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);
            pstmt = conn.prepareStatement("update comment_kintai set sign_ok=? where seq=?");
			pstmt.setInt(1, sign_ok);
            pstmt.setInt(2, seq);
            
            pstmt.executeUpdate();
            conn.commit();
		 }catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("changeAnswer", ex);
		 }finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
  }


//*******************************개인페이지 년/월표시 begin********************
//문자-->숫자 cast('1' as unsigned) as test
//숫자-->문자 cast(2 as char(1)) as test
public List listSchedule(String ymdVal, int mseq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval from "+
				" comment_kintai a inner join member b on a.mseq=b.mseq where (substring(a.hizuke,1,7)=?) "+
				" and (b.member_yn=2) and (a.mseq=?) order by substring(a.hizuke,1,10) asc" );  
			pstmt.setString(1,ymdVal);
			pstmt.setInt(2, mseq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanKintai  member = new  DataBeanKintai();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));
					member.setSimya_hh(rs.getInt("simya_hh"));
					member.setSimya_mm(rs.getInt("simya_mm"));
					member.setHoliday_hh(rs.getInt("holiday_hh"));
					member.setHoliday_mm(rs.getInt("holiday_mm"));
					member.setOneday_holi(rs.getString("oneday_holi"));
					member.setDaikyu(rs.getString("daikyu"));
					member.setDaikyu_date(rs.getString("daikyu_date"));
					member.setChikoku_hh(rs.getInt("chikoku_hh"));
					member.setChikoku_mm(rs.getInt("chikoku_mm"));
					member.setBegin_hh(rs.getInt("begin_hh"));
					member.setBegin_mm(rs.getInt("begin_mm"));
					member.setEnd_hh(rs.getInt("end_hh"));
					member.setEnd_mm(rs.getInt("end_mm"));
					member.setRiyu(rs.getString("riyu"));
					member.setComment(rs.getString("comment"));				
					member.setRegister(rs.getTimestamp("register"));
					member.setEndval(rs.getInt("endval"));
					member.setBeginval(rs.getInt("beginval"));
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_no_riyu(rs.getString("sign_no_riyu"));
					member.setNm(rs.getString("nm"));
					member.setMember_id(rs.getString("member_id"));
					list.add(member);

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
public DataBeanKintai getKintaiDate(String ymdVal, int mseq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval from "+
				" comment_kintai a inner join member b on a.mseq=b.mseq where (substring(a.hizuke,1,10)=?) "+
				" and (b.member_yn=2) and (a.mseq=?) " ); 
            pstmt.setString(1,ymdVal);
			pstmt.setInt(2, mseq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanKintai member = new DataBeanKintai();
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));
					member.setSimya_hh(rs.getInt("simya_hh"));
					member.setSimya_mm(rs.getInt("simya_mm"));
					member.setHoliday_hh(rs.getInt("holiday_hh"));
					member.setHoliday_mm(rs.getInt("holiday_mm"));
					member.setOneday_holi(rs.getString("oneday_holi"));
					member.setDaikyu(rs.getString("daikyu"));
					member.setDaikyu_date(rs.getString("daikyu_date"));
					member.setChikoku_hh(rs.getInt("chikoku_hh"));
					member.setChikoku_mm(rs.getInt("chikoku_mm"));
					member.setBegin_hh(rs.getInt("begin_hh"));
					member.setBegin_mm(rs.getInt("begin_mm"));
					member.setEnd_hh(rs.getInt("end_hh"));
					member.setEnd_mm(rs.getInt("end_mm"));
					member.setRiyu(rs.getString("riyu"));
					member.setComment(rs.getString("comment"));				
					member.setRegister(rs.getTimestamp("register"));
					member.setEndval(rs.getInt("endval"));
					member.setBeginval(rs.getInt("beginval"));
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_no_riyu(rs.getString("sign_no_riyu"));
					member.setNm(rs.getString("nm"));
					member.setMember_id(rs.getString("member_id"));
							
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSum", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
public DataBeanKintai getSum(String ymdVal, int mseq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select sum(end_hh*60+end_mm) as endval, sum(begin_hh*60+begin_mm) as beginval,count(*) as seqcnt from "+ 
				" comment_kintai where substring(hizuke,1,7)=? and mseq=? ");
            pstmt.setString(1,ymdVal);
			pstmt.setInt(2, mseq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanKintai member = new DataBeanKintai();					
				member.setEndval(rs.getInt("endval"));
				member.setBeginval(rs.getInt("beginval"));
				member.setSeqcnt(rs.getInt("seqcnt"));
							
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSum", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
//인쇄폼, 결재자 
public DataBeanKintai getSignMseq(String ymdVal, int mseq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from comment_kintai a inner join member b on a.mseq=b.mseq "+
				"where (substring(a.hizuke,1,7)=?) and (a.mseq=?) group by a.sign_ok_mseq desc limit 0, 1 " ); 
            pstmt.setString(1,ymdVal);
			pstmt.setInt(2, mseq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanKintai member = new DataBeanKintai();					
					member.setMseq(rs.getInt("sign_ok_mseq"));											
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSignMseq", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
//*******************************전체페이지 전체직원 년/월/일 표시 begin********************
public List listYMD(String yymmVal, int sign_mseq, int pageArrow) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME); 
	if(pageArrow==1){
			pstmt = conn.prepareStatement(
				"select distinct(substring(hizuke,1,10)) as hizukeVal, hizuke  from "+
				"comment_kintai where substring(hizuke,1,7)=? order by substring(hizuke,1,10) asc" );  
			pstmt.setString(1,yymmVal);	
	
	}else if(pageArrow==2){
			pstmt = conn.prepareStatement(
				"select distinct(substring(hizuke,1,10)) as hizukeVal, hizuke  from "+
				"comment_kintai where substring(hizuke,1,7)=? and sign_ok_mseq=? order by substring(hizuke,1,10) asc" );  
			pstmt.setString(1,yymmVal);	
			pstmt.setInt(2,sign_mseq);
	
	}		
            
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanKintai  member = new  DataBeanKintai();                    
					member.setHizuke(rs.getString("hizukeVal"));
					member.setDaikyu(rs.getString("hizuke"));
					list.add(member);

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
//*******************************전체페이지 년/월/일에 따른 직원리스트 표시 begin********************
public List listMseq(String ymdVal, int sign_mseq, int pageArrow ) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);    
			
	if(pageArrow==1){
			pstmt = conn.prepareStatement(
				"select *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval from "+
				"comment_kintai a inner join member b on a.mseq=b.mseq  where "+
				"(substring(a.hizuke,1,10)=?) and (b.member_yn=2) order by b.position_level asc"	);  
			pstmt.setString(1,ymdVal);
	
	}else if(pageArrow==2){
			pstmt = conn.prepareStatement(
				"select *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval from "+
				"comment_kintai a inner join member b on a.mseq=b.mseq  where "+
				"(substring(a.hizuke,1,10)=?) and (b.member_yn=2) and (sign_ok_mseq=?) order by b.position_level asc"	);  
			pstmt.setString(1,ymdVal);
			pstmt.setInt(2,sign_mseq);
	
	}		            
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanKintai  member = new  DataBeanKintai();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));
					member.setSimya_hh(rs.getInt("simya_hh"));
					member.setSimya_mm(rs.getInt("simya_mm"));
					member.setHoliday_hh(rs.getInt("holiday_hh"));
					member.setHoliday_mm(rs.getInt("holiday_mm"));
					member.setOneday_holi(rs.getString("oneday_holi"));
					member.setDaikyu(rs.getString("daikyu"));
					member.setDaikyu_date(rs.getString("daikyu_date"));
					member.setChikoku_hh(rs.getInt("chikoku_hh"));
					member.setChikoku_mm(rs.getInt("chikoku_mm"));
					member.setBegin_hh(rs.getInt("begin_hh"));
					member.setBegin_mm(rs.getInt("begin_mm"));
					member.setEnd_hh(rs.getInt("end_hh"));
					member.setEnd_mm(rs.getInt("end_mm"));
					member.setRiyu(rs.getString("riyu"));
					member.setComment(rs.getString("comment"));				
					member.setRegister(rs.getTimestamp("register"));
					member.setEndval(rs.getInt("endval"));
					member.setBeginval(rs.getInt("beginval"));
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_no_riyu(rs.getString("sign_no_riyu"));
					member.setNm(rs.getString("nm"));
					member.setMember_id(rs.getString("member_id"));
					member.setEm_number(rs.getString("em_number"));
					list.add(member);

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
//*******************************sign 결재처리 begin********************
/*
"select * from comment_kintai a inner join member b on a.mseq=b.mseq "+
"where (a.sign_ok_mseq=?) and (a.sign_ok=1 or a.sign_ok=3) and (b.member_yn=2) and not (daikyu='0') order by a.seq desc ");
*/
public List listSignNew(int sign_ok_mseq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(			
				"select * from comment_kintai a inner join member b on a.mseq=b.mseq "+
				"where (a.sign_ok_mseq=?) and (a.sign_ok=1 or a.sign_ok=3) and (b.member_yn=2) order by a.seq desc ");
			pstmt.setInt(1,sign_ok_mseq);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanKintai  member = new  DataBeanKintai();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));
					member.setSimya_hh(rs.getInt("simya_hh"));
					member.setSimya_mm(rs.getInt("simya_mm"));
					member.setHoliday_hh(rs.getInt("holiday_hh"));
					member.setHoliday_mm(rs.getInt("holiday_mm"));
					member.setOneday_holi(rs.getString("oneday_holi"));
					member.setDaikyu(rs.getString("daikyu"));
					member.setDaikyu_date(rs.getString("daikyu_date"));
					member.setChikoku_hh(rs.getInt("chikoku_hh"));
					member.setChikoku_mm(rs.getInt("chikoku_mm"));
					member.setBegin_hh(rs.getInt("begin_hh"));
					member.setBegin_mm(rs.getInt("begin_mm"));
					member.setEnd_hh(rs.getInt("end_hh"));
					member.setEnd_mm(rs.getInt("end_mm"));
					member.setRiyu(rs.getString("riyu"));
					member.setComment(rs.getString("comment"));				
					member.setRegister(rs.getTimestamp("register"));					
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_no_riyu(rs.getString("sign_no_riyu"));
					member.setNm(rs.getString("nm"));
					list.add(member);

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
/****************sign 카운트********************/

 public int  listSignNewCnt(int mseq, int sign_ok) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from comment_kintai where (mseq=?) and (sign_ok=?) and not (daikyu='0') ");
			stmt.setInt(1,mseq);
			stmt.setInt(2,sign_ok);
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listSignNewCnt test", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
 public int  listSignNewCnt(int mseq) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from comment_kintai where (sign_ok_mseq=?) and (sign_ok=1 or sign_ok=3) and not (daikyu='0') ");
			stmt.setInt(1,mseq);			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listSignNewCnt test", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
/****************어드민 메인 /sign 카운트 잔업********************/

 public int  listSignNewCntJangyo(int mseq, int sign_ok) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from jangyo where mseq=? and sign_ok=? ");
			stmt.setInt(1,mseq);
			stmt.setInt(2,sign_ok);
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listSignNewCntJangyo test", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
/****************member 카운트********************/
 public int  listMemAllCnt() throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from member ");			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listMemAllCnt", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
/****************schedule 카운트********************/
 public int  listScheduleCnt(int mseq,int sign_ok) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(a.seq) from schedule a inner join schedule_signup b "+
				"on a.seq=b.schedule_seq where a.mseq=? and b.sign_ok=?  ");	
			stmt.setInt(1,mseq);
			stmt.setInt(2,sign_ok);
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listScheduleCnt", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

/****************문서 카운트********************/
 public int  listBunAllCnt() throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from bunsho  where  file_kind=1  ");			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listBunAllCnt", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
/****************orms sop 카운트********************/
 public int  listSopCnt() throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from sop_item");			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listBunAllCnt", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
//*******************************(소계)전체페이지 년월/일에 따른 직원리스트 잔여시간 계산 표시 begin********************
public DataBeanKintai getSumYmdMseq(String ymdVal)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select sum(end_hh*60+end_mm) as endval, sum(begin_hh*60+begin_mm) as beginval,count(*) as seqcnt from "+ 
				" comment_kintai where substring(hizuke,1,10)=? ");
            pstmt.setString(1,ymdVal);			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanKintai member = new DataBeanKintai();					
				member.setEndval(rs.getInt("endval"));
				member.setBeginval(rs.getInt("beginval"));
				member.setSeqcnt(rs.getInt("seqcnt"));
							
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSum", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
//결재ok
public void signOk(int seq,int sign_ok,String noRiyu) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("update comment_kintai set sign_ok=?,sign_no_riyu=?  where seq=?");				
			pstmt.setInt(1, sign_ok);
			pstmt.setString(2, noRiyu);
			pstmt.setInt(3, seq);	
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("ID was not in DB !!");
            }
        } catch(SQLException ex) {
            throw new MgrException("ID was not in DB !!", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

//어드민 메인페이지 출력 결재사항  comment_kintai
public List listSignOk_or_No(String id) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM comment_kintai a "+
				"LEFT JOIN member b ON a.sign_ok_mseq = b.mseq "+
				"WHERE (a.sign_ok =1 OR a.sign_ok =3) and (b.member_yn=2) and b.member_id=? "+
				"GROUP BY a.sign_ok_mseq ORDER BY b.position_level ASC" );	
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanKintai  member = new  DataBeanKintai();										
                    member.setSeq(rs.getInt("seq"));
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setNm(rs.getString("nm"));
					member.setSimya_hh(rs.getInt("cnt"));					
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listSignOk_or_No", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

//어드민 메인페이지 상사로부터의 반환  comment_kintai
public List listSignOkReturn(String id) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * FROM comment_kintai a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok =3) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) "+
				"ORDER BY b.position_level ASC" );	
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanKintai  member = new  DataBeanKintai();										
                    member.setSeq(rs.getInt("seq"));
					member.setHizuke(rs.getString("hizuke"));
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setSign_no_riyu(rs.getString("sign_no_riyu"));
					member.setNm(rs.getString("nm"));										
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listSignOkReturn", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
}