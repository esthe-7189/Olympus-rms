package mira.tokubetu;

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

public class AccMgr {
	private static AccMgr instance = new AccMgr();
	
	public static AccMgr getInstance() {		
		return instance;
	}
	
	private AccMgr() {}
	private static String POOLNAME="pool";
	
	public void insertAcc(AccBean pds)  throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		PreparedStatement pstmt2 = null;		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setSeq(Sequencer.nextId(conn, "toku_file"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into toku_file  values (?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pds.getSeq());
			pstmt.setInt(2, pds.getCate_seq());
			pstmt.setString(3, pds.getTitle());
			pstmt.setString(4, pds.getName());
			pstmt.setString(5, pds.getFilename());
			pstmt.setTimestamp(6, pds.getRegister());
			pstmt.setCharacterStream(7,  new StringReader(pds.getComment()), pds.getComment().length());
			pstmt.setInt(8, pds.getView_yn());		
			pstmt.setString(9, pds.getIp_add());
			pstmt.setInt(10, pds.getHit_cnt());	
			pstmt.setInt(11, pds.getSekining_mseq());	
		
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insertAcc",ex2);
		} finally {	
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex1) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
	}


/**수정하기**/
	public void update(AccBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update toku_file set cate_seq=?,title=?,name=?,filename=?,comment=?,view_yn=?,sekining_mseq=? where seq=?" );
		pstmt.setInt(1, pds.getCate_seq());
		pstmt.setString(2, pds.getTitle());
		pstmt.setString(3, pds.getName());
		pstmt.setString(4, pds.getFilename());		
		pstmt.setCharacterStream(5,  new StringReader(pds.getComment()), pds.getComment().length());		
		pstmt.setInt(6, pds.getView_yn());
		pstmt.setInt(7, pds.getSekining_mseq());
		pstmt.setInt(8, pds.getSeq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}

/**파일제외 수정하기**/
	public void update2(AccBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update toku_file set cate_seq=?,title=?,name=?,comment=?,view_yn=?,sekining_mseq=? where seq=?" );
		pstmt.setInt(1, pds.getCate_seq());
		pstmt.setString(2, pds.getTitle());
		pstmt.setString(3, pds.getName());		
		pstmt.setCharacterStream(4,  new StringReader(pds.getComment()), pds.getComment().length());		
		pstmt.setInt(5, pds.getView_yn());
		pstmt.setInt(6, pds.getSekining_mseq());
		pstmt.setInt(7, pds.getSeq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}

/**등록된 글의 count구하기**/
public int count(List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP;         
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append(
				"select count(*) from toku_file a inner join toku_cate b on a.cate_seq=b.BSEQ "+
				"inner join membertoku c on a.sekining_mseq=c.mseq " );
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" where ");                
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
            throw new MgrException("count acc_file", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

/**목록 읽기**/
public List selectList(List whereCond, Map valueMap, int startRow, int endRow) throws MgrException{
	 if (valueMap == null) valueMap = Collections.EMPTY_MAP; 

	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	 try {
            StringBuffer query = new StringBuffer(200);             
			query.append(
				"select *,c.nm as sekining_nm from toku_file a inner join toku_cate b on a.cate_seq=b.BSEQ "+
				"inner join membertoku c on a.sekining_mseq=c.mseq ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by seq desc  limit ?, ?");            
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
            
            pstmt.setInt(valueMap.size()+1, startRow);
            pstmt.setInt(valueMap.size()+2, endRow-startRow+1);

		rs=pstmt.executeQuery();
		if (rs.next()){
			List list=new java.util.ArrayList(endRow-startRow+1);
			Reader reader = null;        
			do{
				AccBean pds=new AccBean();
				pds.setSeq(rs.getInt("seq"));
				pds.setTitle(rs.getString("title"));
				pds.setName(rs.getString("name"));
				pds.setFilename(rs.getString("filename"));
				pds.setRegister(rs.getTimestamp("register"));	
					try{
							reader=rs.getCharacterStream("comment");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							pds.setComment(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("comment select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
							}				
				pds.setView_yn(rs.getInt("view_yn"));
				pds.setIp_add(rs.getString("ip_add"));
				pds.setHit_cnt(rs.getInt("hit_cnt"));				
				pds.setCate_seq(rs.getInt("cate_seq"));
				pds.setCate_nm(rs.getString("NM"));
				pds.setSekining_mseq(rs.getInt("sekining_mseq"));
				pds.setSekining_nm(rs.getString("sekining_nm"));
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

/**지정한 글 불러오기**/
public AccBean getAcc(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		AccBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement(
			"select *,c.nm as sekining_nm from toku_file a "+
			"inner join toku_cate b on a.cate_seq=b.BSEQ "+
			"inner join membertoku c on a.sekining_mseq=c.mseq "+
			"where seq=? ");
		pstmt.setInt(1, seq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new AccBean();
				pds.setSeq(rs.getInt("seq"));
				pds.setTitle(rs.getString("title"));
				pds.setName(rs.getString("name"));
				pds.setFilename(rs.getString("filename"));
				pds.setRegister(rs.getTimestamp("register"));	
					try{
							reader=rs.getCharacterStream("comment");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							pds.setComment(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("comment select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
							}				
				pds.setView_yn(rs.getInt("view_yn"));
				pds.setIp_add(rs.getString("ip_add"));
				pds.setHit_cnt(rs.getInt("hit_cnt"));	
				pds.setCate_seq(rs.getInt("cate_seq"));
				pds.setCate_nm(rs.getString("NM"));
				pds.setSekining_mseq(rs.getInt("sekining_mseq"));
				pds.setSekining_nm(rs.getString("sekining_nm"));

			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new MgrException("get select", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}


/**delete**/
public void delete(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	PreparedStatement pstmtKind=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from toku_file where seq=?  ");
		pstmt.setInt(1, seq);
		pstmt.executeUpdate();		

		pstmtKind=conn.prepareStatement("delete from toku_down  where seq_acc=?  ");
		pstmtKind.setInt(1, seq);
		pstmtKind.executeUpdate();
		
	}catch (SQLException ex){
		throw new MgrException("delete all", ex);
	}finally{
		if(pstmtKind !=null) try{pstmtKind.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}


public void upDown(int seq)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME); 			
			stmt = conn.prepareStatement("update toku_file set hit_cnt = hit_cnt+1 where seq=?");			
			stmt.setInt(1,seq);
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("acc_file Down Load qty",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
	}

public List listExcel() throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader = null;    
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select *,c.nm as sekining_nm from toku_file a "+
				"inner join toku_cate b on a.cate_seq=b.BSEQ  "+
				"inner join membertoku c on a.sekining_mseq=c.mseq "+
				"order by seq asc" );            
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    AccBean pds=new AccBean();
						pds.setSeq(rs.getInt("seq"));
						pds.setTitle(rs.getString("title"));
						pds.setName(rs.getString("name"));
						pds.setFilename(rs.getString("filename"));
						pds.setRegister(rs.getTimestamp("register"));	
							try{
									reader=rs.getCharacterStream("comment");
									char[] buff=new char[512];
									int len=-1;
									StringBuffer buffer=new StringBuffer(512);
									while((len=reader.read(buff)) != -1){
										buffer.append(buff,0,len);
									}
									pds.setComment(buffer.toString());
									}catch (IOException iex){
										throw new MgrException("comment select",iex);
									}finally{
										if(reader !=null)try	{reader.close();}
										catch (IOException iex){}
									}				
						pds.setView_yn(rs.getInt("view_yn"));
						pds.setIp_add(rs.getString("ip_add"));
						pds.setHit_cnt(rs.getInt("hit_cnt"));						
						pds.setCate_seq(rs.getInt("cate_seq"));
						pds.setCate_nm(rs.getString("NM"));
						pds.setSekining_mseq(rs.getInt("sekining_mseq"));
						pds.setSekining_nm(rs.getString("sekining_nm"));
					list.add(pds);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listExcel", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
}
