package mira.hokoku;

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

public class DataMgrTripHokoku {
    private static DataMgrTripHokoku instance = new DataMgrTripHokoku();
    
    public static DataMgrTripHokoku getInstance() {
        return instance;
    }
    
    private DataMgrTripHokoku() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insert(DataBeanHokoku member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"hokoku_trip_hokoku"));
            pstmt = conn.prepareStatement( "insert into hokoku_trip_hokoku values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());
			pstmt.setInt(3, member.getSign_ok_yn_boss());
			pstmt.setInt(4, member.getSign_ok_yn_bucho());
			pstmt.setInt(5, member.getSign_ok_mseq_boss());
			pstmt.setInt(6, member.getSign_ok_mseq_bucho());		
			pstmt.setString(7, member.getDestination());
			pstmt.setTimestamp(8, member.getRegister()); 		
			pstmt.setCharacterStream(9,  new StringReader(member.getReason()), member.getReason().length());
			pstmt.setCharacterStream(10,  new StringReader(member.getComment()), member.getComment().length());			
			pstmt.setString(11, member.getDuring_begin());				
			pstmt.setString(12, member.getDuring_end());
			pstmt.setString(13, member.getSign_no_riyu_boss());
			pstmt.setString(14, member.getSign_no_riyu_bucho());
			pstmt.setString(15, member.getTitle01());
			pstmt.setString(16, member.getTitle02());
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insert", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

public int getIdSeq(String hokoku)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select seqno from id_seq  where seqnm = ?");
            pstmt.setString(1, hokoku);
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


public void update(DataBeanHokoku  member) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmtUpdate = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);        
            conn.setAutoCommit(false);
            pstmtUpdate = conn.prepareStatement( 
				"update hokoku_trip_hokoku set sign_ok_yn_boss=?,sign_ok_yn_bucho=?,sign_ok_mseq_boss=?,sign_ok_mseq_bucho=?, "+
				"destination=?,reason=?,comment=?, "+
				"during_begin=?,during_end=?,sign_no_riyu_boss=?, "+
				"sign_no_riyu_bucho=?,title01=?,title02=?  where seq=? "); 
			
			pstmtUpdate.setInt(1, member.getSign_ok_yn_boss());
			pstmtUpdate.setInt(2, member.getSign_ok_yn_bucho());
			pstmtUpdate.setInt(3, member.getSign_ok_mseq_boss());
			pstmtUpdate.setInt(4, member.getSign_ok_mseq_bucho());	
			pstmtUpdate.setString(5, member.getDestination());		
			pstmtUpdate.setCharacterStream(6,  new StringReader(member.getReason()), member.getReason().length());
			pstmtUpdate.setCharacterStream(7,  new StringReader(member.getComment()), member.getComment().length());
			pstmtUpdate.setString(8, member.getDuring_begin());				
			pstmtUpdate.setString(9, member.getDuring_end());		
			pstmtUpdate.setString(10, member.getSign_no_riyu_boss());
			pstmtUpdate.setString(11, member.getSign_no_riyu_bucho());
			pstmtUpdate.setString(12, member.getTitle01());
			pstmtUpdate.setString(13, member.getTitle02());
			pstmtUpdate.setInt(14, member.getSeq());


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
				"DELETE FROM schedule where hokoku_trip_seq=? ");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();  
           
        } catch(SQLException ex) {
            throw new MgrException("deleteRelated", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}
 public DataBeanHokoku getDb(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
		Reader reader2 = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from hokoku_trip_hokoku where seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
				member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));				
				member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
				member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));			
				member.setDestination(rs.getString("destination"));
				member.setRegister(rs.getTimestamp("register"));				
						
				try{
							reader=rs.getCharacterStream("reason");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							member.setReason(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("reason select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
				}
				
				try{
							reader2=rs.getCharacterStream("comment");
							char[] buff2=new char[512];
							int len=-1;
							StringBuffer buffer2=new StringBuffer(512);
							while((len=reader2.read(buff2)) != -1){
								buffer2.append(buff2,0,len);
							}
							member.setComment(buffer2.toString());
							}catch (IOException iex){
								throw new MgrException("comment select",iex);
							}finally{
								if(reader2 !=null)try	{reader2.close();}
								catch (IOException iex){}
				}
							
				member.setDuring_begin(rs.getString("during_begin"));
				member.setDuring_end(rs.getString("during_end"));			
				member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
				member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
				member.setTitle01(rs.getString("title01"));
				member.setTitle02(rs.getString("title02"));
				
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
	 public DataBeanHokoku getDbPrint(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
		Reader reader2 = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from hokoku_trip_hokoku a inner join member b on a.mseq=b.mseq where seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
				member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));				
				member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
				member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));			
				member.setDestination(rs.getString("destination"));
				member.setRegister(rs.getTimestamp("register"));				
						
				try{
							reader=rs.getCharacterStream("reason");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							member.setReason(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("reason select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
				}
				
				try{
							reader2=rs.getCharacterStream("comment");
							char[] buff2=new char[512];
							int len=-1;
							StringBuffer buffer2=new StringBuffer(512);
							while((len=reader2.read(buff2)) != -1){
								buffer2.append(buff2,0,len);
							}
							member.setComment(buffer2.toString());
							}catch (IOException iex){
								throw new MgrException("comment select",iex);
							}finally{
								if(reader2 !=null)try	{reader2.close();}
								catch (IOException iex){}
				}
							
				member.setDuring_begin(rs.getString("during_begin"));
				member.setDuring_end(rs.getString("during_end"));			
				member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
				member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
				member.setTitle01(rs.getString("title01"));
				member.setTitle02(rs.getString("title02"));
				member.setMember_id(rs.getString("member_id"));
				member.setMail_address(rs.getString("mail_address"));
				member.setNm(rs.getString("nm"));					
				member.setLevel(rs.getInt("level"));
				member.setEm_number(rs.getString("em_number"));				
				member.setMimg(rs.getString("mimg"));
				member.setPosition_level(rs.getInt("position_level"));
				member.setBusho(rs.getString("busho"));
				
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getDbPring", ex);
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
				"DELETE hokoku_trip_hokoku, schedule "+
				"From hokoku_trip_hokoku "+				
				"LEFT JOIN schedule ON  hokoku_trip_hokoku.seq=schedule.hokoku_trip_seq "+
				"where  hokoku_trip_hokoku.seq=? ");
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
	public int count(String busho,List whereCond, Map valueMap) throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(a.seq) from  hokoku_trip_hokoku a inner join member b on a.mseq=b.mseq where b.busho=?  ");
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
            pstmt.setString(1,busho);
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
	public List selectList(String busho, List whereCond, Map valueMap, int startRow, int endRow)
    throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null;
		Reader reader=null;
		Reader reader2=null;
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from  hokoku_trip_hokoku a inner join member b on a.mseq=b.mseq where b.busho=?  ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and ");                
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
            pstmtMessage.setString(valueMap.size()+1,busho);
            pstmtMessage.setInt(valueMap.size()+2, startRow);
            pstmtMessage.setInt(valueMap.size()+3, endRow-startRow+1);
            
            rs = pstmtMessage.executeQuery();
            if (rs.next()) {                 
				List list = new java.util.ArrayList(endRow-startRow+1);                 
                do {
                    DataBeanHokoku  member = new  DataBeanHokoku();
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));				
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));			
					member.setDestination(rs.getString("destination"));
					member.setRegister(rs.getTimestamp("register"));				
							
					try{
								reader=rs.getCharacterStream("reason");
								char[] buff=new char[512];
								int len=-1;
								StringBuffer buffer=new StringBuffer(512);
								while((len=reader.read(buff)) != -1){
									buffer.append(buff,0,len);
								}
								member.setReason(buffer.toString());
								}catch (IOException iex){
									throw new MgrException("reason select",iex);
								}finally{
									if(reader !=null)try	{reader.close();}
									catch (IOException iex){}
					}
					
					try{
								reader2=rs.getCharacterStream("comment");
								char[] buff2=new char[512];
								int len=-1;
								StringBuffer buffer2=new StringBuffer(512);
								while((len=reader2.read(buff2)) != -1){
									buffer2.append(buff2,0,len);
								}
								member.setComment(buffer2.toString());
								}catch (IOException iex){
									throw new MgrException("comment select",iex);
								}finally{
									if(reader2 !=null)try	{reader2.close();}
									catch (IOException iex){}
					}
								
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));			
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setMember_id(rs.getString("member_id"));
					member.setMail_address(rs.getString("mail_address"));
					member.setNm(rs.getString("nm"));					
					member.setLevel(rs.getInt("level"));
					member.setEm_number(rs.getString("em_number"));				
					member.setMimg(rs.getString("mimg"));
					member.setPosition_level(rs.getInt("position_level"));
					member.setBusho(rs.getString("busho"));
                    
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
            pstmt = conn.prepareStatement("update hokoku_trip_hokoku set sign_ok=? where seq=?");
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
/*
public List listSchedule(String ymdVal, int mseq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval from "+
				" comment_kintai a inner join member b on a.mseq=b.mseq where substring(a.hizuke,1,7)=? and a.mseq=? order by a.seq asc" );  
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


//*******************************전체페이지 전체직원 년/월/일 표시 begin********************
public List listYMD(String yymmVal) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select distinct(substring(hizuke,1,10)) as hizuke from "+
				"comment_kintai where substring(hizuke,1,7)=? order by substring(hizuke,1,10) asc" );  
			pstmt.setString(1,yymmVal);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanKintai  member = new  DataBeanKintai();                    
					member.setHizuke(rs.getString("hizuke"));					
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
public List listMseq(String ymdVal) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select *, (end_hh*60+end_mm) as endval, (begin_hh*60+begin_mm) as beginval from "+
				"comment_kintai a inner join member b on a.mseq=b.mseq  where "+
				"substring(hizuke,1,10)=? order by position_level asc"	);  
			pstmt.setString(1,ymdVal);
			
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
*/
//*******************************sign 결재처리 Boss********************
 
public List listSignBo(int mseq,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader=null; Reader reader2=null;
        try {            
            conn = DBUtil.getConnection(POOLNAME);
	if(level==1){
			pstmt = conn.prepareStatement(		
			"SELECT * from hokoku_trip_hokoku a "+
			"LEFT JOIN member b ON a.mseq=b.mseq "+
			"WHERE (a.sign_ok_mseq_boss=?) "+ 
			"AND (a.sign_ok_yn_boss=1 OR a.sign_ok_yn_boss=3)  "+
			"AND (sign_ok_yn_bucho=2) "+
			"ORDER BY a.seq desc ");
	}else if(level==2){	
			pstmt = conn.prepareStatement(		
			"SELECT * from hokoku_trip_hokoku a "+
			"LEFT JOIN member b ON a.mseq=b.mseq "+
			"WHERE (a.sign_ok_mseq_bucho=?) "+
			"AND (a.sign_ok_yn_bucho=1 OR a.sign_ok_yn_bucho=3) "+
			"ORDER BY a.seq desc ");
	}      		
			
			pstmt.setInt(1,mseq);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanHokoku  member = new  DataBeanHokoku();
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));				
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));			
					member.setDestination(rs.getString("destination"));
					member.setRegister(rs.getTimestamp("register"));				
							
					try{
								reader=rs.getCharacterStream("reason");
								char[] buff=new char[512];
								int len=-1;
								StringBuffer buffer=new StringBuffer(512);
								while((len=reader.read(buff)) != -1){
									buffer.append(buff,0,len);
								}
								member.setReason(buffer.toString());
								}catch (IOException iex){
									throw new MgrException("reason select",iex);
								}finally{
									if(reader !=null)try	{reader.close();}
									catch (IOException iex){}
					}
					
					try{
								reader2=rs.getCharacterStream("comment");
								char[] buff2=new char[512];
								int len=-1;
								StringBuffer buffer2=new StringBuffer(512);
								while((len=reader2.read(buff2)) != -1){
									buffer2.append(buff2,0,len);
								}
								member.setComment(buffer2.toString());
								}catch (IOException iex){
									throw new MgrException("comment select",iex);
								}finally{
									if(reader2 !=null)try	{reader2.close();}
									catch (IOException iex){}
					}
								
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));			
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setMember_id(rs.getString("member_id"));
					member.setMail_address(rs.getString("mail_address"));
					member.setNm(rs.getString("nm"));					
					member.setLevel(rs.getInt("level"));
					member.setEm_number(rs.getString("em_number"));				
					member.setMimg(rs.getString("mimg"));
					member.setPosition_level(rs.getInt("position_level"));
					member.setBusho(rs.getString("busho"));					

					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listSignBo", ex);
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
            stmt = conn.prepareStatement(
				"SELECT COUNT(seq) FROM hokoku_trip_hokoku WHERE (mseq=?) and (sign_ok_yn_boss=? or sign_ok_yn_bucho=?) ");
			stmt.setInt(1,mseq);
			stmt.setInt(2,sign_ok);
			stmt.setInt(3,sign_ok);
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

/*
 public int  listSignNewCnt(int mseq) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from hokoku where (sign_ok_mseq=?) and (sign_ok=1 or sign_ok=3) ");
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
*/
/****************어드민 메인 /sign 카운트 잔업********************/

 public int  listSignNewCntHokoku(int mseq, int sign_ok) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(seq) from hokoku_trip_hokoku where (mseq=?) and (sign_ok_yn_boss=? or sign_ok_yn_bucho=?) ");
			stmt.setInt(1,mseq);
			stmt.setInt(2,sign_ok);
			stmt.setInt(3,sign_ok);
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listSignNewCntHokoku", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

//결재ok   kindPosi(1=boss, 2=bucho)
public void signOk(int seq,int sign_ok,String noRiyu,int kindPosi) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);           
            
if(kindPosi==1){	
	pstmt = conn.prepareStatement("update hokoku_trip_hokoku set sign_ok_yn_boss=?,sign_no_riyu_boss=?  where seq=?" );	
}else{
	pstmt = conn.prepareStatement("update hokoku_trip_hokoku set sign_ok_yn_bucho=?,sign_no_riyu_bucho=?  where seq=?" );	
}	
			pstmt.setInt(1, sign_ok);
			pstmt.setString(2, noRiyu);
			pstmt.setInt(3, seq);			
            
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

//결재ok BOSS
/*
public void signOkBucho(int seq,int sign_ok,String noRiyu) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("update hokoku set sign_ok_yn_bucho=?,sign_no_riyu_bucho=?  where seq=?");				
			pstmt.setInt(1, sign_ok);
			pstmt.setString(2, noRiyu);
			pstmt.setInt(3, seq);	
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("signOkBucho !!");
            }
        } catch(SQLException ex) {
            throw new MgrException("signOkBucho !!", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
*/
//어드민 메인페이지 출력 결재사항 (사장용)  comment_kintai..
public DataBeanHokoku getSignYnBoss(String id)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt  "+
				"FROM hokoku_trip_hokoku a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_boss = b.mseq "+
				"WHERE (sign_ok_yn_boss=1 OR sign_ok_yn_boss=3) "+
				"AND b.member_id=? "+
				"AND a.sign_ok_yn_bucho=2 "+
				"GROUP BY a.sign_ok_mseq_boss " );	 
			pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();	
					member.setSeq(rs.getInt("seq"));
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setNm(rs.getString("nm"));
					member.setSeqcnt(rs.getInt("cnt"));	
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSignYnBoss", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


//어드민 메인페이지 출력 결재사항 (부장용)  comment_kintai
public DataBeanHokoku getSignYnBucho(String id)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM hokoku_trip_hokoku a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho = b.mseq "+
				"WHERE (sign_ok_yn_bucho =1 OR sign_ok_yn_bucho =3) "+
				"AND b.member_id=? "+
				"GROUP BY a.sign_ok_mseq_bucho " );	 
			pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();	
					member.setSeq(rs.getInt("seq"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));
					member.setNm(rs.getString("nm"));
					member.setSeqcnt(rs.getInt("cnt"));		
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSignYnBucho", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

//어드민 메인페이지 상사로부터의 반환  1==부장, 2==본인
public List listTripReturn(String id,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
    if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_hokoku a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_hokoku a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_bucho=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}		

/*
	if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_hokoku a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho = b.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_hokoku a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_bucho=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}		
*/

			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanHokoku  member = new  DataBeanHokoku();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));
					member.setDestination(rs.getString("destination"));
					member.setRegister(rs.getTimestamp("register"));
					member.setComment(rs.getString("comment"));											
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setNm(rs.getString("nm"));								
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listTripReturn", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }


}