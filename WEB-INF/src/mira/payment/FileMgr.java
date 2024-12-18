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

public class FileMgr {
	private static FileMgr instance = new FileMgr();
	
	public static FileMgr getInstance() {		
		return instance;
	}
	
	private FileMgr() {}
	private static String POOLNAME="pool";
	
	public void insertFile(Category pds)  throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;				
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setSeq(Sequencer.nextId(conn, "pay_seikyu"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into pay_seikyu  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pds.getSeq());
			pstmt.setTimestamp(2, pds.getRegister());
			pstmt.setInt(3, pds.getMseq());
			pstmt.setString(4, pds.getComment());
			pstmt.setInt(5, pds.getClient());
			pstmt.setString(6, pds.getPay_kikan());
			pstmt.setString(7, pds.getPay_day());
			pstmt.setInt(8, pds.getPrice());
			pstmt.setString(9, pds.getSinsei_day());
			pstmt.setInt(10, pds.getReceive_yn_sinsei());		
			pstmt.setString(11, pds.getPost_send_day());
			pstmt.setInt(12, pds.getReceive_yn_ot());
			pstmt.setInt(13, pds.getShori_yn());
			pstmt.setInt(14, pds.getReceive_yn_tokyo());
			pstmt.setInt(15, pds.getPj_yn());
					
			pstmt.executeUpdate();
			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insert",ex2);
		} finally {			
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
	}


/**수정하기**/
	public void update(Category pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement(
			"update pay_seikyu set mseq=?, comment=?,client=?,pay_kikan=?,pay_day=?,price=?, " +
			"sinsei_day=?,receive_yn_sinsei=?,post_send_day=?,receive_yn_ot=?,shori_yn=?,receive_yn_tokyo=?,pj_yn=? where seq=?" );
			pstmt.setInt(1, pds.getMseq());
			pstmt.setString(2, pds.getComment());
			pstmt.setInt(3, pds.getClient());
			pstmt.setString(4, pds.getPay_kikan());
			pstmt.setString(5, pds.getPay_day());
			pstmt.setInt(6, pds.getPrice());
			pstmt.setString(7, pds.getSinsei_day());
			pstmt.setInt(8, pds.getReceive_yn_sinsei());		
			pstmt.setString(9, pds.getPost_send_day());
			pstmt.setInt(10, pds.getReceive_yn_ot());
			pstmt.setInt(11, pds.getShori_yn());
			pstmt.setInt(12, pds.getReceive_yn_tokyo());
			pstmt.setInt(13, pds.getPj_yn());
			pstmt.setInt(14, pds.getSeq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}

public Category select(int seq )  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where a.seq=? ");
            pstmt.setInt(1, seq);
			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Category pds = new Category();								             
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
						pds.setShori_yn(rs.getInt("shori_yn"));
						pds.setPay_type(rs.getInt("pay_type"));
						pds.setClient_nm(rs.getString("client_nm"));
						pds.setName(rs.getString("nm"));
				
                return pds;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("selectFile", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
}

public Category selectSeikyu(int cseq )  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where a.client=? ");
            pstmt.setInt(1, cseq);
			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Category pds = new Category();								             
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
				
                return pds;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("selectFile", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
public Category selectMonth(int cseq ,String ymdVal)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where substring(a.sinsei_day,1,7)=? AND a.client=? ");            
			pstmt.setString(1, ymdVal);
			pstmt.setInt(2, cseq);
			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Category pds = new Category();								             
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
				
                return pds;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("selectFile", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
//where substring(a.sinsei_day,1,4)=? AND substring(a.sinsei_day,6,2)=? AND a.client=?
public Category selectMonthYear(int cseq ,String yyVal,String mmVal)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq "+
				"where substring(a.sinsei_day,1,4)=? AND substring(a.sinsei_day,6,2)=? AND a.seq=? ");            
			pstmt.setString(1, yyVal);
			pstmt.setString(2, mmVal);
			pstmt.setInt(3, cseq);
			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Category pds = new Category();								             
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
				
                return pds;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MgrException("selectFile", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
/**등록된 글의 count구하기 **/
public int count(List whereCond, Map valueMap,int pay_type)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP;         
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 

				query.append(
				"select count(*) FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=? "); 

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
            pstmt.setInt(1, pay_type);	
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("count count", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

/**목록 읽기  **/
/**pageArrow 1=관리자  **/
public List selectList(List whereCond, Map valueMap, int startRow, int endRow,int pg) throws MgrException{
	 if (valueMap == null) valueMap = Collections.EMPTY_MAP; 

	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	 try {
            StringBuffer query = new StringBuffer(200); 
	
			query.append(
				"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where b.pay_type=? "	);
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }

            query.append(" order by a.client asc  limit ?, ?");            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(query.toString()); 
				
			Iterator keyIter = valueMap.keySet().iterator();
            while(keyIter.hasNext()) {
                Integer key = (Integer)keyIter.next();
                Object obj = valueMap.get(key);                
					if (obj instanceof String) {
						pstmt.setString(key.intValue(), (String)obj);
						 } else if (obj instanceof Integer) {
						pstmt.setInt(key.intValue(), 
                                        ((Integer)obj).intValue());                
						} else if (obj instanceof Timestamp) {
						pstmt.setTimestamp(key.intValue(),
                                          (Timestamp)obj);
                }
            }

			pstmt.setInt(valueMap.size()+1, pg);
            pstmt.setInt(valueMap.size()+2, startRow);
            pstmt.setInt(valueMap.size()+3, endRow-startRow+1);
	
	
			rs=pstmt.executeQuery();
		if (rs.next()){
			List list=new java.util.ArrayList(endRow-startRow+1);
			Reader reader = null;        
			do{
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
			return Collections.EMPTY_LIST;
		}		
	}catch (SQLException ex){
		throw new MgrException("list select!!!", ex);
	}finally{
		if(rs !=null) try{rs.close();}catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();}catch(SQLException ex){}
		if(conn !=null) try{conn.close();}catch(SQLException ex){}
	}
}


public void delete(int id) throws MgrException {
        Connection conn = null; 
		PreparedStatement pstmtMessage = null;
		
        try {
            conn = DBUtil.getConnection(POOLNAME);
            conn.setAutoCommit(false);
            
				pstmtMessage = conn.prepareStatement(
                "delete from pay_seikyu where seq=? ");
				pstmtMessage.setInt(1, id);			
			pstmtMessage.executeUpdate();	
			
        } catch(SQLException ex) {
            try {
                conn.rollback();
				 } catch(SQLException ex1) {}
            throw new MgrException("delete", ex);
        } finally { 
            
			if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {}
            if (conn != null)
                try {
                    conn.setAutoCommit(true);
                    conn.close(); 
                } catch(SQLException ex) {} 
        }
    }

//카테고리...삭제 요청처리
public void shoriYn(int seq, int shori_yn)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME);		
				stmt = conn.prepareStatement(
                "update pay_seikyu set shori_yn=? where seq=? ");
				stmt.setInt(1, shori_yn);
				stmt.setInt(2, seq);
		
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("delYn exception ",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
}

public void shoriYn2(int seq, int yn,String pgkind)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME);
	if(pgkind.equals("receive_yn_sinsei")){
		stmt = conn.prepareStatement("update pay_seikyu set receive_yn_sinsei=? where seq=? ");		
	}else if(pgkind.equals("receive_yn_tokyo")){
		stmt = conn.prepareStatement("update pay_seikyu set receive_yn_tokyo=? where seq=? ");
	}else if(pgkind.equals("shori_yn")){
		stmt = conn.prepareStatement("update pay_seikyu set shori_yn=? where seq=? ");
	}
				stmt.setInt(1, yn);
				stmt.setInt(2, seq);		
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("shoriYn2 exception ",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
}




public void shoriYnReceive(int seq, String sinsei_day, int receive_yn_sinsei ) throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			stmt = conn.prepareStatement("update pay_seikyu set sinsei_day=?,receive_yn_sinsei=? where seq=? ");				

				stmt.setString(1, sinsei_day);
				stmt.setInt(2, receive_yn_sinsei);
				stmt.setInt(3, seq);		
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("shoriYnReceive exception ",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
}

public void shoriYnPost(int seq, String post_send_day, int receive_yn_ot ) throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			stmt = conn.prepareStatement("update pay_seikyu set post_send_day=?,receive_yn_ot=? where seq=? ");				

				stmt.setString(1, post_send_day);
				stmt.setInt(2, receive_yn_ot);
				stmt.setInt(3, seq);		
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("shoriYnPost exception ",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
}

/*
public void shoriYn3(int seq, String date,String pgkind)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME);
	if(pgkind.equals("post_send_day")){
		stmt = conn.prepareStatement("update pay_seikyu set post_send_day=? where seq=? ");
	}			

				stmt.setString(1, date);
				stmt.setInt(2, seq);		
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("shoriYn3 exception ",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
}
*/


public List listMain() throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * FROM pay_seikyu a "+
				"LEFT JOIN pay_seikyu_client b ON a.client=b.cseq "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where a.shori_yn=1 order by a.seq asc " );  
			
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
}
