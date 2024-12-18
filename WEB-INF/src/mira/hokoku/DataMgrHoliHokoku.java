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

public class DataMgrHoliHokoku {
    private static DataMgrHoliHokoku instance = new DataMgrHoliHokoku();
    
    public static DataMgrHoliHokoku getInstance() {
        return instance;
    }
    
    private DataMgrHoliHokoku() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insert(DataBeanHokoku member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.
            member.setSeq(Sequencer.nextId(conn,"hokoku_holiday"));
            pstmt = conn.prepareStatement( "insert into hokoku_holiday values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getMseq());
			pstmt.setInt(3, member.getSign_ok_yn_boss());
			pstmt.setInt(4, member.getSign_ok_yn_bucho());
			pstmt.setInt(5, member.getSign_ok_yn_bucho2());
			pstmt.setInt(6, member.getSign_ok_yn_kanribu());
			pstmt.setInt(7, member.getSign_ok_mseq_boss());
			pstmt.setInt(8, member.getSign_ok_mseq_bucho());	
			pstmt.setInt(9, member.getSign_ok_mseq_bucho2());
			pstmt.setInt(10, member.getSign_ok_mseq_kanribu());
			pstmt.setTimestamp(11, member.getRegister());
			pstmt.setString(12, member.getTheday());
			pstmt.setCharacterStream(13,  new StringReader(member.getComment()), member.getComment().length());			 		
			pstmt.setCharacterStream(14,  new StringReader(member.getReason()), member.getReason().length());			
			pstmt.setInt(15, member.getRest_begin_hh());				
			pstmt.setInt(16, member.getRest_begin_mm());
			pstmt.setInt(17, member.getRest_end_hh());
			pstmt.setInt(18, member.getRest_end_mm());
			pstmt.setInt(19, member.getPlan_begin_hh());
			pstmt.setInt(20, member.getPlan_begin_mm());
			pstmt.setInt(21, member.getPlan_end_hh());
			pstmt.setInt(22, member.getPlan_end_mm());
			pstmt.setString(23, member.getSign_no_riyu_boss());
			pstmt.setString(24, member.getSign_no_riyu_bucho());
			pstmt.setString(25, member.getSign_no_riyu_bucho2());
			pstmt.setString(26, member.getSign_no_riyu_kanribu());
			pstmt.setString(27, member.getTitle01());
			pstmt.setString(28, member.getTitle02());
			pstmt.setString(29, member.getTitle03());
			pstmt.setString(30, member.getTitle04());
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insert", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}			
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public void insertBogo(DataBeanHokoku member)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 번호를 구한다.  getSeqcnt=== seq_hokoku_holiday대용
            member.setSeq(Sequencer.nextId(conn,"hokoku_holiday_con"));
            pstmt = conn.prepareStatement( "insert into hokoku_holiday_con values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getSeq()); 
			pstmt.setInt(2, member.getSeqcnt());   
			pstmt.setInt(3, member.getSign_ok_yn_boss());
			pstmt.setInt(4, member.getSign_ok_yn_bucho());
			pstmt.setInt(5, member.getSign_ok_yn_bucho2());
			pstmt.setInt(6, member.getSign_ok_yn_kanribu());
			pstmt.setInt(7, member.getSign_ok_mseq_boss());
			pstmt.setInt(8, member.getSign_ok_mseq_bucho());	
			pstmt.setInt(9, member.getSign_ok_mseq_bucho2());
			pstmt.setInt(10, member.getSign_ok_mseq_kanribu());
			pstmt.setTimestamp(11, member.getRegister());
			pstmt.setString(12, member.getTheday());
			pstmt.setCharacterStream(13,  new StringReader(member.getComment()), member.getComment().length());			 		
			pstmt.setCharacterStream(14,  new StringReader(member.getReason()), member.getReason().length());			
			pstmt.setInt(15, member.getRest_begin_hh());				
			pstmt.setInt(16, member.getRest_begin_mm());
			pstmt.setInt(17, member.getRest_end_hh());
			pstmt.setInt(18, member.getRest_end_mm());
			pstmt.setInt(19, member.getPlan_begin_hh());
			pstmt.setInt(20, member.getPlan_begin_mm());
			pstmt.setInt(21, member.getPlan_end_hh());
			pstmt.setInt(22, member.getPlan_end_mm());
			pstmt.setString(23, member.getSign_no_riyu_boss());
			pstmt.setString(24, member.getSign_no_riyu_bucho());
			pstmt.setString(25, member.getSign_no_riyu_bucho2());
			pstmt.setString(26, member.getSign_no_riyu_kanribu());
			pstmt.setString(27, member.getTitle01());
			pstmt.setString(28, member.getTitle02());
			pstmt.setString(29, member.getTitle03());
			pstmt.setString(30, member.getTitle04());
            pstmt.executeUpdate();

        } catch(SQLException ex) {
            throw new MgrException("insertBogo", ex);
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
				"update hokoku_holiday set sign_ok_yn_boss=?,sign_ok_yn_bucho=?,sign_ok_yn_bucho2=?,sign_ok_yn_kanribu=?, "+
				"sign_ok_mseq_boss=?,sign_ok_mseq_bucho=?,sign_ok_mseq_bucho2=?,sign_ok_mseq_kanribu=?, "+
				"theday=?,comment=?,reason=?,rest_begin_hh=?,rest_begin_mm=?,rest_end_hh=?,rest_end_mm=?, "+
				"plan_begin_hh=?,plan_begin_mm=?,plan_end_hh=?,plan_end_mm=?, "+
				"sign_no_riyu_boss=?,sign_no_riyu_bucho=?,sign_no_riyu_bucho2=?,sign_no_riyu_kanribu=?, "+
				"title01=?,title02=?,title03=?,title04=? where seq=? "); 			

			pstmtUpdate.setInt(1, member.getSign_ok_yn_boss());
			pstmtUpdate.setInt(2, member.getSign_ok_yn_bucho());
			pstmtUpdate.setInt(3, member.getSign_ok_yn_bucho2());
			pstmtUpdate.setInt(4, member.getSign_ok_yn_kanribu());
			pstmtUpdate.setInt(5, member.getSign_ok_mseq_boss());
			pstmtUpdate.setInt(6, member.getSign_ok_mseq_bucho());	
			pstmtUpdate.setInt(7, member.getSign_ok_mseq_bucho2());		
			pstmtUpdate.setInt(8, member.getSign_ok_mseq_kanribu());		
			pstmtUpdate.setString(9, member.getTheday());
			pstmtUpdate.setCharacterStream(10,  new StringReader(member.getComment()), member.getComment().length());			 		
			pstmtUpdate.setCharacterStream(11,  new StringReader(member.getReason()), member.getReason().length());			
			pstmtUpdate.setInt(12, member.getRest_begin_hh());				
			pstmtUpdate.setInt(13, member.getRest_begin_mm());
			pstmtUpdate.setInt(14, member.getRest_end_hh());
			pstmtUpdate.setInt(15, member.getRest_end_mm());
			pstmtUpdate.setInt(16, member.getPlan_begin_hh());
			pstmtUpdate.setInt(17, member.getPlan_begin_mm());
			pstmtUpdate.setInt(18, member.getPlan_end_hh());
			pstmtUpdate.setInt(19, member.getPlan_end_mm());
			pstmtUpdate.setString(20, member.getSign_no_riyu_boss());
			pstmtUpdate.setString(21, member.getSign_no_riyu_bucho());
			pstmtUpdate.setString(22, member.getSign_no_riyu_bucho2());
			pstmtUpdate.setString(23, member.getSign_no_riyu_kanribu());
			pstmtUpdate.setString(24, member.getTitle01());
			pstmtUpdate.setString(25, member.getTitle02());
			pstmtUpdate.setString(26, member.getTitle03());
			pstmtUpdate.setString(27, member.getTitle04());
			pstmtUpdate.setInt(28, member.getSeq());


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
public void updateBogo(DataBeanHokoku  member) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmtUpdate = null;        
        
        try {
            conn = DBUtil.getConnection(POOLNAME);        
            conn.setAutoCommit(false);
            pstmtUpdate = conn.prepareStatement( 
				"update hokoku_holiday_con set sign_ok_yn_boss=?,sign_ok_yn_bucho=?,sign_ok_yn_bucho2=?,sign_ok_yn_kanribu=?, "+
				"sign_ok_mseq_boss=?,sign_ok_mseq_bucho=?,sign_ok_mseq_bucho2=?,sign_ok_mseq_kanribu=?, "+
				"theday=?,comment=?,reason=?,rest_begin_hh=?,rest_begin_mm=?,rest_end_hh=?,rest_end_mm=?, "+
				"plan_begin_hh=?,plan_begin_mm=?,plan_end_hh=?,plan_end_mm=?, "+
				"sign_no_riyu_boss=?,sign_no_riyu_bucho=?,sign_no_riyu_bucho2=?,sign_no_riyu_kanribu=?, "+
				"title01=?,title02=?,title03=?,title04=? where seq_hokoku_holiday=? "); 			

			pstmtUpdate.setInt(1, member.getSign_ok_yn_boss());
			pstmtUpdate.setInt(2, member.getSign_ok_yn_bucho());
			pstmtUpdate.setInt(3, member.getSign_ok_yn_bucho2());
			pstmtUpdate.setInt(4, member.getSign_ok_yn_kanribu());
			pstmtUpdate.setInt(5, member.getSign_ok_mseq_boss());
			pstmtUpdate.setInt(6, member.getSign_ok_mseq_bucho());	
			pstmtUpdate.setInt(7, member.getSign_ok_mseq_bucho2());		
			pstmtUpdate.setInt(8, member.getSign_ok_mseq_kanribu());		
			pstmtUpdate.setString(9, member.getTheday());
			pstmtUpdate.setCharacterStream(10,  new StringReader(member.getComment()), member.getComment().length());			 		
			pstmtUpdate.setCharacterStream(11,  new StringReader(member.getReason()), member.getReason().length());			
			pstmtUpdate.setInt(12, member.getRest_begin_hh());				
			pstmtUpdate.setInt(13, member.getRest_begin_mm());
			pstmtUpdate.setInt(14, member.getRest_end_hh());
			pstmtUpdate.setInt(15, member.getRest_end_mm());
			pstmtUpdate.setInt(16, member.getPlan_begin_hh());
			pstmtUpdate.setInt(17, member.getPlan_begin_mm());
			pstmtUpdate.setInt(18, member.getPlan_end_hh());
			pstmtUpdate.setInt(19, member.getPlan_end_mm());
			pstmtUpdate.setString(20, member.getSign_no_riyu_boss());
			pstmtUpdate.setString(21, member.getSign_no_riyu_bucho());
			pstmtUpdate.setString(22, member.getSign_no_riyu_bucho2());
			pstmtUpdate.setString(23, member.getSign_no_riyu_kanribu());
			pstmtUpdate.setString(24, member.getTitle01());
			pstmtUpdate.setString(25, member.getTitle02());
			pstmtUpdate.setString(26, member.getTitle03());
			pstmtUpdate.setString(27, member.getTitle04());
			pstmtUpdate.setInt(28, member.getSeq());


            pstmtUpdate.executeUpdate();	    
            conn.commit();    
        } catch(SQLException ex) { 
			try {conn.rollback();} catch(SQLException ex1) {} 
            throw new MgrException("updateBogo", ex);
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
				"DELETE FROM schedule where hokoku_holiday_seq=? ");
            pstmt.setInt(1, seq);
            
            int result = pstmt.executeUpdate();  
           
        } catch(SQLException ex) {
            throw new MgrException("deleteRelated", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}
 // 결재완료 완료후 수정시 관련되는 테이블 삭제 .
public void deleteBogo(int seq)   throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"DELETE FROM hokoku_holiday_con where seq_hokoku_holiday=? ");
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
            pstmt = conn.prepareStatement("select * from hokoku_holiday where seq = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
				member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));		
				member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
				member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
				member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
				member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
				member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
				member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
				member.setRegister(rs.getTimestamp("register"));
				member.setTheday(rs.getString("theday"));				
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
							
				member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
				member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
				member.setRest_end_hh(rs.getInt("rest_end_hh"));
				member.setRest_end_mm(rs.getInt("rest_end_mm"));
				member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
				member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
				member.setPlan_end_hh(rs.getInt("plan_end_hh"));
				member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
				member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
				member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
				member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
				member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
				member.setTitle01(rs.getString("title01"));
				member.setTitle02(rs.getString("title02"));
				member.setTitle03(rs.getString("title03"));
				member.setTitle04(rs.getString("title04"));
				
				
				
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
public DataBeanHokoku getDbBogoReal(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
		Reader reader2 = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from hokoku_holiday_con where seq = ?");				
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
				member.setSeq(rs.getInt("seq"));
				member.setSeqcnt(rs.getInt("seq_hokoku_holiday"));				
				member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
				member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));		
				member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
				member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
				member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
				member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
				member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
				member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
				member.setRegister(rs.getTimestamp("register"));
				member.setTheday(rs.getString("theday"));				
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
							
				member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
				member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
				member.setRest_end_hh(rs.getInt("rest_end_hh"));
				member.setRest_end_mm(rs.getInt("rest_end_mm"));
				member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
				member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
				member.setPlan_end_hh(rs.getInt("plan_end_hh"));
				member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
				member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
				member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
				member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
				member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
				member.setTitle01(rs.getString("title01"));
				member.setTitle02(rs.getString("title02"));
				member.setTitle03(rs.getString("title03"));
				member.setTitle04(rs.getString("title04"));
				
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
            pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN hokoku_holiday_con b ON a.seq=b.seq_hokoku_holiday "+
				"LEFT JOIN member c ON a.mseq=c.mseq  "+
				"WHERE a.seq=?  ");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
				member.setSeq(rs.getInt("seq"));
				member.setMseq(rs.getInt("mseq"));
				member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
				member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));		
				member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
				member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
				member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
				member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
				member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
				member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
				member.setRegister(rs.getTimestamp("register"));
				member.setTheday(rs.getString("theday"));				
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
							
				member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
				member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
				member.setRest_end_hh(rs.getInt("rest_end_hh"));
				member.setRest_end_mm(rs.getInt("rest_end_mm"));
				member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
				member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
				member.setPlan_end_hh(rs.getInt("plan_end_hh"));
				member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
				member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
				member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
				member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
				member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
				member.setTitle01(rs.getString("title01"));
				member.setTitle02(rs.getString("title02"));
				member.setTitle03(rs.getString("title03"));
				member.setTitle04(rs.getString("title04"));
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
	public DataBeanHokoku getDbBogo02(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
		Reader reader2 = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("select * from hokoku_holiday_con where seq_hokoku_holiday = ?");
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
				member.setSeq(rs.getInt("seq"));
				member.setSeqcnt(rs.getInt("seq_hokoku_holiday"));
				member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
				member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));		
				member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
				member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
				member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
				member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
				member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
				member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
				member.setRegister(rs.getTimestamp("register"));
				member.setTheday(rs.getString("theday"));				
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
							
				member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
				member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
				member.setRest_end_hh(rs.getInt("rest_end_hh"));
				member.setRest_end_mm(rs.getInt("rest_end_mm"));
				member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
				member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
				member.setPlan_end_hh(rs.getInt("plan_end_hh"));
				member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
				member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
				member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
				member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
				member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
				member.setTitle01(rs.getString("title01"));
				member.setTitle02(rs.getString("title02"));
				member.setTitle03(rs.getString("title03"));
				member.setTitle04(rs.getString("title04"));
				
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
	public DataBeanHokoku getDbBogo(int seq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
		Reader reader2 = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"SELECT * from hokoku_holiday_con a  "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE a.seq_hokoku_holiday=?  ");

            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();					
				member.setSeq(rs.getInt("seq"));
				member.setSeqcnt(rs.getInt("seq_hokoku_holiday"));
				member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
				member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));		
				member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
				member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
				member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
				member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
				member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
				member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
				member.setRegister(rs.getTimestamp("register"));
				member.setTheday(rs.getString("theday"));				
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
							
				member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
				member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
				member.setRest_end_hh(rs.getInt("rest_end_hh"));
				member.setRest_end_mm(rs.getInt("rest_end_mm"));
				member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
				member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
				member.setPlan_end_hh(rs.getInt("plan_end_hh"));
				member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
				member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
				member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
				member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
				member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
				member.setSeqcnt(rs.getInt("seq_hokoku_holiday"));
				member.setTitle01(rs.getString("title01"));
				member.setTitle02(rs.getString("title02"));
				member.setTitle03(rs.getString("title03"));
				member.setTitle04(rs.getString("title04"));
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
				"DELETE hokoku_holiday,hokoku_holiday_con, schedule "+
				"From hokoku_holiday "+	
				"LEFT JOIN hokoku_holiday_con ON hokoku_holiday.seq=hokoku_holiday_con.seq_hokoku_holiday "+
				"LEFT JOIN schedule ON  hokoku_holiday.seq=schedule.hokoku_holiday_seq "+
				"where  hokoku_holiday.seq=? ");
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
			query.append(
				"SELECT count(a.seq) from hokoku_holiday a "+
				"LEFT JOIN hokoku_holiday_con b ON a.seq=b.seq_hokoku_holiday "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE c.busho=?  ");			
			
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
			query.append(
			   "SELECT * from hokoku_holiday a "+
				"LEFT JOIN hokoku_holiday_con b ON a.seq=b.seq_hokoku_holiday "+
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"WHERE c.busho=?  ");
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
					member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
					member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
					member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
					member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
					member.setRegister(rs.getTimestamp("register"));
					member.setTheday(rs.getString("theday"));				
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
								
					member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
					member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
					member.setRest_end_hh(rs.getInt("rest_end_hh"));
					member.setRest_end_mm(rs.getInt("rest_end_mm"));
					member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
					member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
					member.setPlan_end_hh(rs.getInt("plan_end_hh"));
					member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
					member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setTitle03(rs.getString("title03"));
					member.setTitle04(rs.getString("title04"));
					member.setSeqcnt(rs.getInt("seq_hokoku_holiday"));
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
            pstmt = conn.prepareStatement("update hokoku_holiday set sign_ok=? where seq=?");
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
 public int  listSignNewCntPgAll(int sign_ok_mseq,int level) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
if(level==1){
            stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_boss=?) AND "+
				"(a.sign_ok_yn_boss=1 or a.sign_ok_yn_boss=3) AND "+
				"(a.sign_ok_yn_bucho=2 or a.sign_ok_mseq_bucho=0 ) order by a.seq desc ");							
			
}else if(level==2){			
			stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_bucho=?)  "+
				"AND (a.sign_ok_yn_bucho=1 or a.sign_ok_yn_bucho=3) "+
				"AND (a.sign_ok_yn_bucho2=2 or a.sign_ok_mseq_bucho2=0) "+
				"ORDER BY a.seq desc ");		
				
}else if(level==3){
			stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_bucho2=?)  "+
				"AND (a.sign_ok_yn_bucho2=1 or a.sign_ok_yn_bucho2=3) "+
				"AND (a.sign_ok_yn_kanribu=2 or a.sign_ok_mseq_kanribu=0) "+
				"ORDER BY a.seq desc ");		
				
}else if(level==4){
			 stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_kanribu=?)  "+
				"AND (a.sign_ok_yn_kanribu=1 or a.sign_ok_yn_kanribu=3) "+				
				"ORDER BY a.seq desc ");
				
} 	
			
			stmt.setInt(1,sign_ok_mseq);			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listSignNewCntPgAll", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public List listSignNewAll(int sign_ok_mseq,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader=null; Reader reader2=null;
        try {            
            conn = DBUtil.getConnection(POOLNAME);   
if(level==1){
             pstmt = conn.prepareStatement(			
				"SELECT * from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_boss=?) AND "+
				"(a.sign_ok_yn_boss=1 or a.sign_ok_yn_boss=3)  "+
				"AND (a.sign_ok_yn_bucho=2 or a.sign_ok_mseq_bucho=0) order by a.seq desc ");			
			
}else if(level==2){
			pstmt = conn.prepareStatement(
				"SELECT * from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_bucho=?) "+
				"AND (a.sign_ok_yn_bucho=1 or a.sign_ok_yn_bucho=3) "+
				"AND (a.sign_ok_yn_bucho2=2 or a.sign_ok_mseq_bucho2=0) "+
				"ORDER BY a.seq desc ");
			
}else if(level==3){
			pstmt = conn.prepareStatement(
				"SELECT * from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_bucho2=?) "+
				"AND (a.sign_ok_yn_bucho2=1 or a.sign_ok_yn_bucho2=3) "+
				"AND (a.sign_ok_yn_kanribu=2 or a.sign_ok_mseq_kanribu=0) "+
				"ORDER BY a.seq desc ");	
			
}else if(level==4){
			pstmt = conn.prepareStatement(
				"SELECT * from hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq=b.mseq "+
				"WHERE (a.sign_ok_mseq_kanribu=?)  "+
				"AND (a.sign_ok_yn_kanribu=1 or a.sign_ok_yn_kanribu=3) "+		
				"ORDER BY a.seq desc ");	
			
}						

			pstmt.setInt(1,sign_ok_mseq);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanHokoku  member = new  DataBeanHokoku();
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mseq"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));		
					member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
					member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
					member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
					member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
					member.setRegister(rs.getTimestamp("register"));
					member.setTheday(rs.getString("theday"));				
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
								
					member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
					member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
					member.setRest_end_hh(rs.getInt("rest_end_hh"));
					member.setRest_end_mm(rs.getInt("rest_end_mm"));
					member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
					member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
					member.setPlan_end_hh(rs.getInt("plan_end_hh"));
					member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
					member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setTitle03(rs.getString("title03"));
					member.setTitle04(rs.getString("title04"));
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
            throw new MgrException("listSignNewAll", ex);
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
				"SELECT COUNT(seq) FROM hokoku_holiday WHERE (mseq=?) and (sign_ok_yn_boss=? or sign_ok_yn_bucho=?) ");
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
            stmt = conn.prepareStatement("select count(seq) from hokoku_holiday where (mseq=?) and (sign_ok_yn_boss=? or sign_ok_yn_bucho=?) ");
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

//결재ok   kindPosi(1=boss, 2=bucho, 3=bucho2, 4=kanribu)
public void signOk(int seq,int sign_ok,String noRiyu,int kindPosi) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);           
            
if(kindPosi==1){	
	pstmt = conn.prepareStatement("update hokoku_holiday set sign_ok_yn_boss=?,sign_no_riyu_boss=?  where seq=?" );	
}else if (kindPosi==2){
	pstmt = conn.prepareStatement("update hokoku_holiday set sign_ok_yn_bucho=?,sign_no_riyu_bucho=?  where seq=?" );	
}else if (kindPosi==3){
	pstmt = conn.prepareStatement("update hokoku_holiday set sign_ok_yn_bucho2=?,sign_no_riyu_bucho2=?  where seq=?" );	
}else if (kindPosi==4){
	pstmt = conn.prepareStatement("update hokoku_holiday set sign_ok_yn_kanribu=?,sign_no_riyu_kanribu=?  where seq=?" );	
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


//어드민 메인페이지 출력 결재사항 
public DataBeanHokoku getSignYnAll(String id,int level)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME); 
if(level==1){
             pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt  "+
				"FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_boss = b.mseq "+
				"WHERE (sign_ok_yn_boss=1 OR sign_ok_yn_boss=3) "+
				"AND b.member_id=? "+
				"AND a.sign_ok_yn_bucho=2 "+
				"GROUP BY a.sign_ok_mseq_boss " ); 
			
}else if(level==2){
			pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho = b.mseq "+
				"WHERE (sign_ok_yn_bucho =1 OR sign_ok_yn_bucho =3) "+
				"AND b.member_id=? "+
				"AND a.sign_ok_yn_bucho2=2 "+
				"GROUP BY a.sign_ok_mseq_bucho " );			
}else if(level==3){
			pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho2 = b.mseq "+
				"WHERE (sign_ok_yn_bucho2 =1 OR sign_ok_yn_bucho2 =3) "+
				"AND b.member_id=? "+
				"AND a.sign_ok_yn_kanribu=2 "+
				"GROUP BY a.sign_ok_mseq_bucho2 " );			
			
}else if(level==4){
			pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_kanribu = b.mseq "+
				"WHERE (sign_ok_yn_kanribu =1 OR sign_ok_yn_kanribu =3 ) "+
				"AND b.member_id=? "+				
				"GROUP BY a.sign_ok_mseq_kanribu " );	 
			
}	

			pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();	
					member.setSeq(rs.getInt("seq"));
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));
					member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));
					member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));
					member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));
					member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));
					member.setNm(rs.getString("nm"));
					member.setSeqcnt(rs.getInt("cnt"));	
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSignYnAll", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }



//*******************************sign 결재처리 Boss********************
 public int  listSignNewCntPgAllCon(int sign_ok_mseq,int level) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
if(level==1){
            stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_boss=?) AND "+
				"(a.sign_ok_yn_boss=1 or a.sign_ok_yn_boss=3) AND "+
				"(a.sign_ok_yn_bucho=2 or a.sign_ok_mseq_bucho=0 ) order by a.seq desc ");						
			
}else if(level==2){
			stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_bucho=?)  "+
				"AND (a.sign_ok_yn_bucho=1 or a.sign_ok_yn_bucho=3) "+
				"AND (a.sign_ok_yn_bucho2=2 or a.sign_ok_mseq_bucho2=0) "+
				"ORDER BY a.seq desc ");
				
}else if(level==3){
			stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_bucho2=?)  "+
				"AND (a.sign_ok_yn_bucho2=1 or a.sign_ok_yn_bucho2=3) "+
				"AND (a.sign_ok_yn_kanribu=2 or a.sign_ok_mseq_kanribu=0) "+
				"ORDER BY a.seq desc ");			
				
}else if(level==4){
			 stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_kanribu=?)  "+
				"AND (a.sign_ok_yn_kanribu=1 or a.sign_ok_yn_kanribu=3) "+				
				"ORDER BY a.seq desc ");				
				
}
            stmt.setInt(1,sign_ok_mseq);
			rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("listSignNewCntPgCon", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}

public List listSignNewAllCon(int sign_ok_mseq,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader=null; Reader reader2=null;
        try {            
            conn = DBUtil.getConnection(POOLNAME);
if(level==1){
             pstmt = conn.prepareStatement(			
				"SELECT * from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_boss=?) AND "+
				"(a.sign_ok_yn_boss=1 or a.sign_ok_yn_boss=3)  "+
				"AND (a.sign_ok_yn_bucho=2 or a.sign_ok_mseq_bucho=0) order by a.seq desc ");				
			
}else if(level==2){
			pstmt = conn.prepareStatement(
				"SELECT * from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_bucho=?) "+
				"AND (a.sign_ok_yn_bucho=1 or a.sign_ok_yn_bucho=3) "+
				"AND (a.sign_ok_yn_bucho2=2 or a.sign_ok_mseq_bucho2=0) "+
				"ORDER BY a.seq desc ");
			
}else if(level==3){
			pstmt = conn.prepareStatement(
				"SELECT * from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_bucho2=?) "+
				"AND (a.sign_ok_yn_bucho2=1 or a.sign_ok_yn_bucho2=3) "+
				"AND (a.sign_ok_yn_kanribu=2 or a.sign_ok_mseq_kanribu=0) "+
				"ORDER BY a.seq desc ");		
			
}else if(level==4){
			pstmt = conn.prepareStatement(
				"SELECT * from hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq=c.mseq  "+
				"WHERE (a.sign_ok_mseq_kanribu=?)  "+
				"AND (a.sign_ok_yn_kanribu=1 or a.sign_ok_yn_kanribu=3) "+		
				"ORDER BY a.seq desc ");			
			
}			
		
			pstmt.setInt(1,sign_ok_mseq);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanHokoku  member = new  DataBeanHokoku();
					member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("seq_hokoku_holiday"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));		
					member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));	
					member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));	
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));	
					member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));	
					member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));	
					member.setRegister(rs.getTimestamp("register"));
					member.setTheday(rs.getString("theday"));				
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
								
					member.setRest_begin_hh(rs.getInt("rest_begin_hh"));
					member.setRest_begin_mm(rs.getInt("rest_begin_mm"));
					member.setRest_end_hh(rs.getInt("rest_end_hh"));
					member.setRest_end_mm(rs.getInt("rest_end_mm"));
					member.setPlan_begin_hh(rs.getInt("plan_begin_hh"));
					member.setPlan_begin_mm(rs.getInt("plan_begin_mm"));
					member.setPlan_end_hh(rs.getInt("plan_end_hh"));
					member.setPlan_end_mm(rs.getInt("plan_end_mm"));				
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
					member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setTitle03(rs.getString("title03"));
					member.setTitle04(rs.getString("title04"));
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
            throw new MgrException("listSignNewAllCon", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }




/****************sign 카운트********************/

 public int  listSignNewCntCon(int mseq, int sign_ok) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement(
				"SELECT COUNT(a.seq) FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b "+
				"ON a.seq_hokoku_holiday=b.seq "+
				"WHERE (b.mseq=?) and (a.sign_ok_yn_boss=? or a.sign_ok_yn_bucho=?) ");
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
            throw new MgrException("listSignNewCntCon", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


/****************어드민 메인 /sign 카운트 잔업********************/
/*
 public int  listSignNewCntHokokuCon(int mseq, int sign_ok) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(seq) from hokoku_holiday_con where (mseq=?) and (sign_ok_yn_boss=? or sign_ok_yn_bucho=?) ");
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
            throw new MgrException("listSignNewCntHokokuCon", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
*/	

//결재ok   kindPosi(1=boss, 2=bucho, 3=bucho2, 4=kanribu)
public void signOkCon(int seq,int sign_ok,String noRiyu,int kindPosi) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);           
            
if(kindPosi==1){	
	pstmt = conn.prepareStatement("update hokoku_holiday_con set sign_ok_yn_boss=?,sign_no_riyu_boss=?  where seq=?" );	
}else if (kindPosi==2){
	pstmt = conn.prepareStatement("update hokoku_holiday_con set sign_ok_yn_bucho=?,sign_no_riyu_bucho=?  where seq=?" );	
}else if (kindPosi==3){
	pstmt = conn.prepareStatement("update hokoku_holiday_con set sign_ok_yn_bucho2=?,sign_no_riyu_bucho2=?  where seq=?" );	
}else if (kindPosi==4){
	pstmt = conn.prepareStatement("update hokoku_holiday_con set sign_ok_yn_kanribu=?,sign_no_riyu_kanribu=?  where seq=?" );	
}		
			pstmt.setInt(1, sign_ok);
			pstmt.setString(2, noRiyu);
			pstmt.setInt(3, seq);			
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MgrException("signOkCon !!");
            }
        } catch(SQLException ex) {
            throw new MgrException("signOkCon !!", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


//어드민 메인페이지 출력 결재사항 
public DataBeanHokoku getSignYnAllCon(String id, int level)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		Reader reader = null;    
        
        try {
            conn = DBUtil.getConnection(POOLNAME);  
			
if(level==1){
             pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt  "+
				"FROM hokoku_holiday_con a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_boss = b.mseq "+
				"WHERE (sign_ok_yn_boss=1 OR sign_ok_yn_boss=3) "+
				"AND b.member_id=? "+
				"AND a.sign_ok_yn_bucho=2 "+
				"GROUP BY a.sign_ok_mseq_boss " );	 
			
}else if(level==2){
				pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM hokoku_holiday_con a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho = b.mseq "+
				"WHERE (sign_ok_yn_bucho =1 OR sign_ok_yn_bucho =3) "+
				"AND b.member_id=? "+
				"AND a.sign_ok_yn_bucho2=2 "+
				"GROUP BY a.sign_ok_mseq_bucho " );	 
			
}else if(level==3){
				pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM hokoku_holiday_con a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_bucho2 = b.mseq "+
				"WHERE (sign_ok_yn_bucho2 =1 OR sign_ok_yn_bucho2 =3) "+
				"AND b.member_id=? "+
				"AND a.sign_ok_yn_kanribu=2 "+
				"GROUP BY a.sign_ok_mseq_bucho2 " );	 
			
			
}else if(level==4){
				pstmt = conn.prepareStatement(
				"SELECT * , count(a.seq) AS cnt "+
				"FROM hokoku_holiday_con a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_kanribu = b.mseq "+
				"WHERE (sign_ok_yn_kanribu =1 OR sign_ok_yn_kanribu =3) "+
				"AND b.member_id=? "+				
				"GROUP BY a.sign_ok_mseq_kanribu " );	 
			
			
}	     
			pstmt.setString(1, id);         
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DataBeanHokoku member = new DataBeanHokoku();	
					member.setSeq(rs.getInt("seq"));
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));
					member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));
					member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));
					member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));
					member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));
					member.setNm(rs.getString("nm"));
					member.setSeqcnt(rs.getInt("cnt"));	
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("getSignYnAllCon", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
//어드민 메인페이지 상사로부터의 반환  
public List listHoReturn(String id,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
   if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_bucho=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==3){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_bucho2=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==4){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_kanribu=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}						 
	
/*
	
	if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.sign_ok_yn_bucho2 = b.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.sign_ok_yn_bucho = b.mseq "+
				"WHERE (a.sign_ok_yn_bucho=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==3){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.sign_ok_mseq_kanribu = b.mseq "+
				"WHERE (a.sign_ok_yn_bucho2=3 ) "+
				"AND (b.member_yn=2) "+
				"AND (b.member_id=?) " );
	}else if(level==4){
			 pstmt = conn.prepareStatement(
				"SELECT * FROM hokoku_holiday a "+
				"LEFT JOIN member b ON a.mseq = b.mseq "+
				"WHERE (a.sign_ok_yn_kanribu=3 ) "+
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
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));
					member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));
					member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));
					member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));
					member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
					member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
					member.setRegister(rs.getTimestamp("register"));					
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setTitle03(rs.getString("title03"));
					member.setTitle04(rs.getString("title04"));
					member.setNm(rs.getString("nm"));								
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listHoReturn", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//어드민 메인페이지 상사로부터의 반환  
public List listHoconReturn(String id,int level) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
    if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq = c.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq = c.mseq "+				
				"WHERE (a.sign_ok_yn_bucho=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}else if(level==3){
			 pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq = c.mseq "+
				"WHERE (a.sign_ok_yn_bucho2=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}else if(level==4){
			 pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq = c.mseq "+
				"WHERE (a.sign_ok_yn_kanribu=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}	

	/*
	if(level==1){
			pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON a.sign_ok_yn_bucho2 = c.mseq "+
				"WHERE (a.sign_ok_yn_boss=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}else if(level==2){
			 pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON a.sign_ok_yn_bucho = c.mseq "+				
				"WHERE (a.sign_ok_yn_bucho=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}else if(level==3){
			 pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON a.sign_ok_mseq_kanribu = c.mseq "+
				"WHERE (a.sign_ok_yn_bucho2=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}else if(level==4){
			 pstmt = conn.prepareStatement(
				"SELECT *,b.mseq as mmm FROM hokoku_holiday_con a "+
				"LEFT JOIN hokoku_holiday b ON a.seq_hokoku_holiday=b.seq "+
				"LEFT JOIN member c ON b.mseq = c.mseq "+
				"WHERE (a.sign_ok_yn_kanribu=3 ) "+
				"AND (c.member_yn=2) "+
				"AND (c.member_id=?) " );
	}						
*/

			pstmt.setString(1, id);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    DataBeanHokoku  member = new  DataBeanHokoku();										
                    member.setSeq(rs.getInt("seq"));
					member.setMseq(rs.getInt("mmm"));
					member.setLevel(rs.getInt("seq_hokoku_holiday"));
					member.setSign_ok_mseq_boss(rs.getInt("sign_ok_mseq_boss"));
					member.setSign_ok_yn_boss(rs.getInt("sign_ok_yn_boss"));
					member.setSign_ok_mseq_bucho(rs.getInt("sign_ok_mseq_bucho"));
					member.setSign_ok_yn_bucho(rs.getInt("sign_ok_yn_bucho"));
					member.setSign_ok_mseq_bucho2(rs.getInt("sign_ok_mseq_bucho2"));
					member.setSign_ok_yn_bucho2(rs.getInt("sign_ok_yn_bucho2"));
					member.setSign_ok_mseq_kanribu(rs.getInt("sign_ok_mseq_kanribu"));
					member.setSign_ok_yn_kanribu(rs.getInt("sign_ok_yn_kanribu"));
					member.setSign_no_riyu_boss(rs.getString("sign_no_riyu_boss"));
					member.setSign_no_riyu_bucho(rs.getString("sign_no_riyu_bucho"));
					member.setSign_no_riyu_bucho2(rs.getString("sign_no_riyu_bucho2"));
					member.setSign_no_riyu_kanribu(rs.getString("sign_no_riyu_kanribu"));
					member.setRegister(rs.getTimestamp("register"));					
					member.setTitle01(rs.getString("title01"));
					member.setTitle02(rs.getString("title02"));
					member.setTitle03(rs.getString("title03"));
					member.setTitle04(rs.getString("title04"));
					member.setNm(rs.getString("nm"));								
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listHoconReturn", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
}