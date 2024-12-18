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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import mira.DBUtil;
import mira.sequence.Sequencer; 

public class FileMgrSeikyu {
	private static FileMgrSeikyu instance = new FileMgrSeikyu();
	
	public static FileMgrSeikyu getInstance() {		
		return instance;
	}
	
	private FileMgrSeikyu() {}
	private static String POOLNAME="pool";
	


public List listMain() throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where a.shori_yn=1 order by a.sinsei_day desc " );  
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category pds=new Category();
					pds.setSeq(rs.getInt("seq"));
					pds.setRegister(rs.getTimestamp("register"));
					pds.setMseq(rs.getInt("mseq"));
					pds.setComment(rs.getString("comment"));
					pds.setClient(rs.getInt("client"));
					pds.setPay_kikan(rs.getString("pay_kikan"));
					pds.setPay_day(rs.getString("pay_day"));
					pds.setPrice(rs.getInt("price"));
					pds.setSinsei_day(rs.getString("sinsei_day"));
					pds.setReceive_yn_sinsei(rs.getInt("receive_yn_sinsei"));
					pds.setPost_send_day(rs.getString("post_send_day"));
					pds.setReceive_yn_ot(rs.getInt("receive_yn_ot"));	
					pds.setShori_yn(rs.getInt("shori_yn"));
					pds.setReceive_yn_tokyo(rs.getInt("receive_yn_tokyo"));
					pds.setPj_yn(rs.getInt("pj_yn"));
					pds.setPay_type(rs.getInt("pay_type"));
					pds.setClient_nm(rs.getString("client_nm"));
					pds.setName(rs.getString("nm"));
					list.add(pds);		

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listMain", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
 }

	public int  newKubun(String dday, String dbday, int seq) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement(
				"select * from pay_seikyu "+ 
				"WHERE (sinsei_day between ? and ? ) "+
				"And (shori_yn=1) "+ 
			    "And (seq=?) ");
			stmt.setString(1, dday);
			stmt.setString(2, dbday);
			stmt.setInt(3, seq);
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("newKubun", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }




}
