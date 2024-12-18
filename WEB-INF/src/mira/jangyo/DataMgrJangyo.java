package mira.jangyo;

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

public class DataMgrJangyo {
    private static DataMgrJangyo instance = new DataMgrJangyo();
    
    public static DataMgrJangyo getInstance() {
        return instance;
    }
    
    private DataMgrJangyo() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insertDb(DataBeanJangyo member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"jangyo"));
            pstmt = conn.prepareStatement( "insert into jangyo values (?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());
			pstmt.setInt(3, member.getSign_ok());
			pstmt.setString(4, member.getHizuke());			
			pstmt.setInt(5, member.getBegin_hh());
			pstmt.setInt(6, member.getBegin_mm());
			pstmt.setInt(7, member.getEnd_hh());
			pstmt.setInt(8, member.getEnd_mm());
			pstmt.setString(9, member.getRiyu());
			pstmt.setString(10, member.getComment());				
            pstmt.setTimestamp(11, member.getRegister()); 
			pstmt.setInt(12, member.getSign_ok_mseq());
			pstmt.setString(13, member.getSign_no_riyu());
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insertDbSchedule", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

	public void update(DataBeanJangyo  member) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmtUpdate = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);        
            conn.setAutoCommit(false);
            pstmtUpdate = conn.prepareStatement( 
				"update jangyo set sign_ok=1,hizuke=?,begin_hh=?,begin_mm=?,end_hh=?,end_mm=?, "+
				" riyu=?,comment=?,sign_ok_mseq=? where seq=?"); 

			pstmtUpdate.setString(1, member.getHizuke());			
			pstmtUpdate.setInt(2, member.getBegin_hh());
			pstmtUpdate.setInt(3, member.getBegin_mm());
			pstmtUpdate.setInt(4, member.getEnd_hh());
			pstmtUpdate.setInt(5, member.getEnd_mm());	
			pstmtUpdate.setString(6, member.getRiyu());
			pstmtUpdate.setString(7, member.getComment());			
			pstmtUpdate.setInt(8, member.getSign_ok_mseq());
			pstmtUpdate.setInt(9, member.getSeq());


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
				"where schedule.jangyo_seq=? ");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();  
           
        } catch(SQLException ex) {
            throw new MgrException("deleteRelated", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
 }
    public DataBeanJangyo getDb(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from jangyo where seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanJangyo member = new DataBeanJangyo();					
				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setSign_ok(rs.getInt("sign_ok"));
				member.setHizuke(rs.getString("hizuke"));				
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
            pstmt = conn.prepareStatement("select count(*) from jangyo where mseq=? and substring(hizuke,1,10)=? ");
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
	
    
    public void deleteDb(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"DELETE jangyo, schedule, schedule_signup "+
				"From jangyo "+
				"LEFT JOIN schedule ON jangyo.seq=schedule.jangyo_seq "+
				"LEFT JOIN schedule_signup ON schedule.seq=schedule_signup.schedule_seq "+
				"where jangyo.seq=? ");
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


// 등록된 글의 개수를 구한다.    
	public int count(List whereCond, Map valueMap) throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("SELECT COUNT(a.seq) FROM jangyo a LEFT JOIN member b on a.mseq=b.mseq WHERE (b.member_yn=2)  ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("and ");                
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
			query.append("SELECT * FROM jangyo a LEFT JOIN member b on a.mseq=b.mseq WHERE (b.member_yn=2)  ");
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
                    DataBeanJangyo  member = new  DataBeanJangyo();

					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));					
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
            pstmt = conn.prepareStatement("update jangyo set sign_ok=? where seq=?");
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
public List listSchedule(String ymdVal, int mseq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval "+
				"FROM jangyo a "+
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE (substring(a.hizuke,1,7)=?) and (a.mseq=?) and (member_yn=2) order by a.seq asc" );  
			pstmt.setString(1,ymdVal);
			pstmt.setInt(2, mseq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanJangyo  member = new  DataBeanJangyo();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));					
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

public DataBeanJangyo getSum(String ymdVal, int mseq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select sum(end_hh*60+end_mm) as endval, sum(begin_hh*60+begin_mm) as beginval,count(*) as seqcnt from "+ 
				" jangyo where substring(hizuke,1,7)=? and mseq=? ");
            pstmt.setString(1,ymdVal);
			pstmt.setInt(2, mseq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanJangyo member = new DataBeanJangyo();					
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


//*******************************전체페이지 전체직원 년/월/일 표시 begin********************
public List listYMD(String yymmVal,String busho) throws MgrException {
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
public List listMseq(String ymdVal,String busho) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval "+
				"FROM jangyo a "+
				"LEFT JOIN member b on a.mseq=b.mseq  "+
				"WHERE (substring(hizuke,1,10)=?) and (b.busho=?) and (b.member_yn=2) order by position_level asc"	);  
			pstmt.setString(1,ymdVal);
			pstmt.setString(2,busho);
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanJangyo  member = new  DataBeanJangyo();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));					
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
					member.setBusho(rs.getString("busho"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("selectList,,,,,", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//*******************************sign 결재처리 begin********************
public List listSignNew(int sign_ok_mseq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(	
			"select * from jangyo a inner join member b on a.mseq=b.mseq "+
			"where (a.sign_ok_mseq=?) and (a.sign_ok=1 or a.sign_ok=3) and (b.member_yn=2) order by a.seq desc ");
			pstmt.setInt(1,sign_ok_mseq);			
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanJangyo  member = new  DataBeanJangyo();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setHizuke(rs.getString("hizuke"));					
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
            throw new MgrException("selectList listSignNew", ex);
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
            stmt = conn.prepareStatement(" select count(*) from jangyo where (sign_ok_mseq=?) and (sign_ok=1 or sign_ok=3) "); 
			
			stmt.setInt(1,mseq);			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listSignNewCnt", ex);
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
            stmt = conn.prepareStatement("select count(mseq) from member ");			
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

//*******************************(소계)전체페이지 년월/일에 따른 직원리스트 잔여시간 계산 표시 begin********************
public DataBeanJangyo getSumYmdMseq(String ymdVal,String busho)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;		  
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT SUM(end_hh*60+end_mm) as endval, SUM(begin_hh*60+begin_mm) as beginval,count(*) as seqcnt "+
				"FROM jangyo a "+
				"LEFT JOIN member b on a.mseq=b.mseq "+
				"WHERE (substring(hizuke,1,10)=?) and (b.member_yn=2) and (b.busho=?) ");
            pstmt.setString(1,ymdVal);
			pstmt.setString(2,busho);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanJangyo member = new DataBeanJangyo();					
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
            pstmt = conn.prepareStatement("update jangyo set sign_ok=?,sign_no_riyu=?  where seq=?");			
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
				"FROM jangyo a "+
				"LEFT JOIN member b ON a.sign_ok_mseq = b.mseq "+
				"WHERE (a.sign_ok =1 OR a.sign_ok =3) and (b.member_yn=2) and b.member_id=? "+
				"GROUP BY a.sign_ok_mseq ORDER BY b.position_level ASC" );	
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanJangyo  member = new  DataBeanJangyo();										
                    member.setSeq(rs.getInt("seq"));
					member.setSign_ok_mseq(rs.getInt("sign_ok_mseq"));
					member.setSign_ok(rs.getInt("sign_ok"));
					member.setNm(rs.getString("nm"));
					member.setSeqcnt(rs.getInt("cnt"));					
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listSignOk_or_No,,,,,", ex);
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
				"SELECT * FROM jangyo a "+
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
                    DataBeanJangyo  member = new  DataBeanJangyo();										
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