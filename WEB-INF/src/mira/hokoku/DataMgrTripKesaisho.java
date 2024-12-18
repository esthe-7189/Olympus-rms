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

public class DataMgrTripKesaisho {
    private static DataMgrTripKesaisho instance = new DataMgrTripKesaisho();
    
    public static DataMgrTripKesaisho getInstance() {
        return instance;
    }
    
    private DataMgrTripKesaisho() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insert(DataBeanHokoku member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"hokoku_trip_keisai"));
            pstmt = conn.prepareStatement( "insert into hokoku_trip_keisai values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());
			pstmt.setInt(3, member.getSign_ok_yn_boss());
			pstmt.setInt(4, member.getSign_ok_yn_bucho());
			pstmt.setInt(5, member.getSign_ok_mseq_boss());
			pstmt.setInt(6, member.getSign_ok_mseq_bucho());
			pstmt.setString(7, member.getDestination_info());
			pstmt.setString(8, member.getDestination());
			pstmt.setTimestamp(9, member.getRegister()); 
			pstmt.setString(10, member.getDrive_yn());			
			pstmt.setCharacterStream(11,  new StringReader(member.getReason()), member.getReason().length());
			pstmt.setString(12, member.getComment());
			pstmt.setString(13, member.getGrade());
			pstmt.setString(14, member.getDanger());				
			pstmt.setString(15, member.getDuring_begin());				
			pstmt.setString(16, member.getDuring_end());
			pstmt.setString(17, member.getPassportName());
			pstmt.setString(18, member.getSign_no_riyu_boss());
			pstmt.setString(19, member.getSign_no_riyu_bucho());
			pstmt.setString(20, member.getTitle01());
			pstmt.setString(21, member.getTitle02());
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insert", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public void insertContent(DataBeanHokoku member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"hokoku_trip_keisai_con"));
            pstmt = conn.prepareStatement( "insert into hokoku_trip_keisai_con values (?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());
			pstmt.setInt(3, member.getHokoku_seq());
			pstmt.setString(4, member.getSche_date());		
			pstmt.setString(5, member.getSche_comment());					
			
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insertContent", ex);
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
				"update hokoku_trip_keisai set sign_ok_yn_boss=?,sign_ok_yn_bucho=?,sign_ok_mseq_boss=?,sign_ok_mseq_bucho=?, "+
				"destination_info=?,destination=?,drive_yn=?, reason=?,comment=?,grade=?,danger=?, "+
				"during_begin=?,during_end=?,passportName=?,sign_no_riyu_boss=?, "+
				"sign_no_riyu_bucho=?,title01=?,title02=?  where seq=? "); 
			
			pstmtUpdate.setInt(1, member.getSign_ok_yn_boss());
			pstmtUpdate.setInt(2, member.getSign_ok_yn_bucho());
			pstmtUpdate.setInt(3, member.getSign_ok_mseq_boss());
			pstmtUpdate.setInt(4, member.getSign_ok_mseq_bucho());
			pstmtUpdate.setString(5, member.getDestination_info());
			pstmtUpdate.setString(6, member.getDestination());			
			pstmtUpdate.setString(7, member.getDrive_yn());			
			pstmtUpdate.setCharacterStream(8,  new StringReader(member.getReason()), member.getReason().length());
			pstmtUpdate.setString(9, member.getComment());
			pstmtUpdate.setString(10, member.getGrade());
			pstmtUpdate.setString(11, member.getDanger());					
			pstmtUpdate.setString(12, member.getDuring_begin());				
			pstmtUpdate.setString(13, member.getDuring_end());	
			pstmtUpdate.setString(14, member.getPassportName());
			pstmtUpdate.setString(15, member.getSign_no_riyu_boss());
			pstmtUpdate.setString(16, member.getSign_no_riyu_bucho());
			pstmtUpdate.setString(17, member.getTitle01());
			pstmtUpdate.setString(18, member.getTitle02());
			pstmtUpdate.setInt(19, member.getSeq());


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

 public DataBeanHokoku getDb(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from hokoku_trip_keisai where seq = ?");
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
				member.setDestination_info(rs.getString("destination_info"));
				member.setDestination(rs.getString("destination"));
				member.setRegister(rs.getTimestamp("register"));				
				member.setDrive_yn(rs.getString("drive_yn"));				
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

				member.setComment(rs.getString("comment"));
				member.setGrade(rs.getString("grade"));
				member.setDanger(rs.getString("danger"));							
				member.setDuring_begin(rs.getString("during_begin"));
				member.setDuring_end(rs.getString("during_end"));				
				member.setPassportName(rs.getString("passportName"));
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

	public DataBeanHokoku getDbExcel(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from hokoku_trip_keisai a inner join member b on a.mseq=b.mseq where seq = ?");
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
				member.setDestination_info(rs.getString("destination_info"));
				member.setDestination(rs.getString("destination"));
				member.setRegister(rs.getTimestamp("register"));				
				member.setDrive_yn(rs.getString("drive_yn"));				
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

				member.setComment(rs.getString("comment"));
				member.setGrade(rs.getString("grade"));
				member.setDanger(rs.getString("danger"));							
				member.setDuring_begin(rs.getString("during_begin"));
				member.setDuring_end(rs.getString("during_end"));				
				member.setPassportName(rs.getString("passportName"));
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
				"DELETE hokoku_trip_keisai, hokoku_trip_keisai_con, schedule "+
				"From hokoku_trip_keisai "+
				"LEFT JOIN hokoku_trip_keisai_con ON hokoku_trip_keisai.seq=hokoku_trip_keisai_con.hokoku_seq "+
				"LEFT JOIN schedule ON hokoku_trip_keisai.seq=schedule.hokoku_seq "+
				"where hokoku_trip_keisai.seq=? ");
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

public DataBeanHokoku getSeqCon(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select seq,hokoku_seq from hokoku_trip_keisai_con where hokoku_seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
					member.setSeq(rs.getInt("seq"));
					member.setHokoku_seq(rs.getInt("hokoku_seq"));		
					member.setSche_date(rs.getString("sche_date"));		
					member.setSche_comment(rs.getString("sche_comment"));
				
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSeqCon", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public void delContentSchedule(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"DELETE hokoku_trip_keisai_con, schedule "+
				"From hokoku_trip_keisai_con "+
				"LEFT JOIN schedule ON hokoku_trip_keisai_con.hokoku_seq=schedule.hokoku_seq "+				
				"where hokoku_trip_keisai_con.hokoku_seq=? ");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("delContentSchedule..0");
            }
        } catch(SQLException ex) {
            throw new MgrException("delContentSchedule", ex);
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
			query.append("select count(a.seq) from hokoku_trip_keisai a inner join member b on a.mseq=b.mseq where b.busho=?  ");
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
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from hokoku_trip_keisai a inner join member b on a.mseq=b.mseq where b.busho=?  ");
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
					member.setDestination_info(rs.getString("destination_info"));
					member.setDestination(rs.getString("destination"));
					member.setRegister(rs.getTimestamp("register"));				
					member.setDrive_yn(rs.getString("drive_yn"));					
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

					member.setComment(rs.getString("comment"));
					member.setGrade(rs.getString("grade"));
					member.setDanger(rs.getString("danger"));								
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setPassportName(rs.getString("passportName"));
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
  
public List listCon(int seq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from hokoku_trip_keisai a inner join hokoku_trip_keisai_con b on a.seq=b.hokoku_seq where a.seq=? order by a.seq " );  
			pstmt.setInt(1,seq);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanHokoku  member = new  DataBeanHokoku();                    
					member.setHokoku_seq(rs.getInt("hokoku_seq"));		
					member.setSche_date(rs.getString("sche_date"));		
					member.setSche_comment(rs.getString("sche_comment"));		
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listCon", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
}

public void changeAnswer(int sign_ok, int seq) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);
            pstmt = conn.prepareStatement("update hokoku_trip_keisai set sign_ok=? where seq=?");
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

//*******************************sign 결재처리 Boss********************
 
public List listSignTrip(int mseq,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader=null;
        try {            
            conn = DBUtil.getConnection(POOLNAME);   
	if(level==1){
			pstmt = conn.prepareStatement(		
			"SELECT * from hokoku_trip_keisai a "+
			"LEFT JOIN member b ON a.mseq=b.mseq "+
			"WHERE (a.sign_ok_mseq_boss=? ) "+
			"AND (a.sign_ok_yn_boss=1 OR a.sign_ok_yn_boss=3)  "+
			"AND (sign_ok_yn_bucho=2) "+
			"ORDER BY a.seq desc ");
	}else if(level==2){
			pstmt = conn.prepareStatement(		
			"SELECT * from hokoku_trip_keisai a "+
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
					member.setDestination_info(rs.getString("destination_info"));
					member.setDestination(rs.getString("destination"));
					member.setRegister(rs.getTimestamp("register"));				
					member.setDrive_yn(rs.getString("drive_yn"));					
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

					member.setComment(rs.getString("comment"));
					member.setGrade(rs.getString("grade"));
					member.setDanger(rs.getString("danger"));								
					member.setDuring_begin(rs.getString("during_begin"));
					member.setDuring_end(rs.getString("during_end"));
					member.setPassportName(rs.getString("passportName"));
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
            throw new MgrException("listSignTrip", ex);
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
				"SELECT COUNT(seq) FROM hokoku_trip_keisai WHERE (mseq=?) and (sign_ok_yn_boss=? or sign_ok_yn_bucho=?) ");
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


/****************어드민 메인 /sign 카운트 잔업********************/

 public int  listSignNewCntHokoku(int mseq, int sign_ok) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(seq) from hokoku_trip_keisai where (mseq=?) and (sign_ok_yn_boss=? or sign_ok_yn_bucho=?) ");
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
	pstmt = conn.prepareStatement("update hokoku_trip_keisai set sign_ok_yn_boss=?,sign_no_riyu_boss=?  where seq=?" );	
}else{
	pstmt = conn.prepareStatement("update hokoku_trip_keisai set sign_ok_yn_bucho=?,sign_no_riyu_bucho=?  where seq=?" );	
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
				"FROM hokoku_trip_keisai a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_boss = b.mseq "+
				"WHERE (sign_ok_yn_boss=1 OR sign_ok_yn_boss=3) "+
				"AND (b.member_id=?) "+
				"AND (a.sign_ok_yn_bucho=2) "+
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
				"FROM hokoku_trip_keisai a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho = b.mseq "+
				"WHERE (sign_ok_yn_bucho =1 OR sign_ok_yn_bucho =3) "+
				"AND (b.member_id=?) "+
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
public List listKesaiReturn(String id,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
    if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_keisai a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_keisai a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_bucho=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}	

/*
	if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_keisai a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho = b.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_trip_keisai a "+
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
					member.setGrade(rs.getString("grade"));
					member.setDanger(rs.getString("danger"));								
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
            throw new MgrException("listKesaiReturn", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }



}