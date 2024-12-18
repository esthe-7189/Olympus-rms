package mira.contract;

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

public class DownMgr {
	private static DownMgr instance = new DownMgr();
	
	public static DownMgr getInstance() {		
		return instance;
	}
	
	private DownMgr() {}
	private static String POOLNAME="pool";	
	
	public void insertDown(ContractBeen pds)  throws BoardMgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		PreparedStatement pstmt2 = null;		
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setSeq(Sequencer.nextId(conn, "contract_down"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into contract_down  values (?,?,?,?,?)");
			pstmt.setInt(1, pds.getSeq());
			pstmt.setInt(2, pds.getSeq_contract());
			pstmt.setInt(3, pds.getSeq_mem());
			pstmt.setTimestamp(4, pds.getRegister());			
			pstmt.setString(5, pds.getIp_add());
			pstmt.executeUpdate();	
			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new BoardMgrException("insertDown",ex2);
		} finally {	
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex1) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
	}


/**지정한 글 불러오기**/
public ContractBeen getDown(int seq) throws BoardMgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		ContractBeen pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from contract_down where seq=?");
		pstmt.setInt(1, seq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new ContractBeen();
				pds.setSeq(rs.getInt("seq"));
				pds.setSeq_contract(rs.getInt("seq_contract"));
				pds.setSeq_mem(rs.getInt("seq_mem"));
				pds.setRegister(rs.getTimestamp("register"));					
				pds.setIp_add(rs.getString("ip_add"));
				
			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new BoardMgrException("get getDown", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}

/*accountig_file에 딸린 내역*/
	 public List selectDownDtail(int seq) throws BoardMgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rsMessage = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from contract_down a inner join member b on a.seq_mem=b.mseq where a.seq_contract=? order by a.seq desc;" );
            pstmt.setInt(1,seq);			
			rsMessage = pstmt.executeQuery();
            if (rsMessage.next()) {                 
				List list = new java.util.ArrayList();
				Reader reader = null; 				
                do {
                    ContractBeen pds = new ContractBeen();
                    pds.setSeq(rsMessage.getInt("seq"));
					pds.setSeq_contract(rsMessage.getInt("seq_contract"));
					pds.setSeq_mem(rsMessage.getInt("seq_mem"));
					pds.setRegister(rsMessage.getTimestamp("register"));					
					pds.setIp_add(rsMessage.getString("ip_add"));
					pds.setTitle(rsMessage.getString("member_id"));
					pds.setName(rsMessage.getString("nm"));

				list.add(pds);	
                }while(rsMessage.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new BoardMgrException("selectDownDtail", ex);
        } finally {             
			if (rsMessage != null)                  
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }





}
