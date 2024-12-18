package mira.sop;

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
            pds.setSeq(Sequencer.nextId(conn, "sop_item"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into sop_item  values (?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pds.getSeq());			
			pstmt.setString(2, pds.getCate_nm());				
			pstmt.setString(3, pds.getTitle());
			pstmt.setCharacterStream(4,  new StringReader(pds.getContent()), pds.getContent().length());
			pstmt.setTimestamp(5, pds.getRegister());
			pstmt.setInt(6, pds.getView_yn());	
			pstmt.setInt(7, pds.getSeq());	//view_seq (user 전시 순서)
			pstmt.setString(8, pds.getName());
			pstmt.setString(9, pds.getFilename());			
			pstmt.setString(10, pds.getIp_add());
			pstmt.setInt(11, pds.getHit_cnt());	
			pstmt.setInt(12, pds.getSeq_tab());	
		
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
public void insertFileMulti(int item_seq,String filename) throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		int seq=0;
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            seq=Sequencer.nextId(conn, "sop_item_multi");

			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into sop_item_multi  values (?,?,?)");
			pstmt.setInt(1, seq);			
			pstmt.setInt(2, item_seq);			
			pstmt.setString(3, filename);			
						
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insertFileMulti",ex2);
		} finally {			
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
}
public int getIdSeq(String idseq)  throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select seqno from id_seq  where seqnm = ?");
            pstmt.setString(1, idseq);
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
public void insertItemMulti(String cate_nm, String title, String content,int view_yn,String name,String filename,String ip_add,int seq_tab )
		throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;
		Timestamp register=new Timestamp(System.currentTimeMillis());
		int seq=0;
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            seq=Sequencer.nextId(conn, "sop_item");

			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into sop_item  values (?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, seq);			
			pstmt.setString(2, cate_nm);				
			pstmt.setString(3, title);
			pstmt.setCharacterStream(4,  new StringReader(content), content.length());
			pstmt.setTimestamp(5, register);
			pstmt.setInt(6, view_yn);	
			pstmt.setInt(7, seq);	//view_seq (user 전시 순서)
			pstmt.setString(8, name);
			pstmt.setString(9, filename);			
			pstmt.setString(10, ip_add);
			pstmt.setInt(11, 0);	
			pstmt.setInt(12, seq_tab);	
			
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insertItemMulti",ex2);
		} finally {			
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
}
public List listFileItem(int item_seq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rsMessage = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from sop_item_multi where item_seq=?  order by seq asc" ); 
			pstmt.setInt(1,item_seq );
			rsMessage = pstmt.executeQuery();
            if (rsMessage.next()) {                 
				List list = new java.util.ArrayList();
				Reader reader = null; 				
                do {
                    AccBean acc = new AccBean();
                    acc.setSeq(rsMessage.getInt("seq"));                    
					acc.setView_seq(rsMessage.getInt("item_seq"));
					acc.setFilename(rsMessage.getString("filename"));	

				list.add(acc);	
                }while(rsMessage.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listFileItem", ex);
        } finally {             
			if (rsMessage != null)                  
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
}
public int  countFileItem(int item_seq) throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from sop_item_multi where item_seq=?");			
			stmt.setInt(1,item_seq );
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("countFileItem", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


public void insertTab(AccBean pds)  throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		PreparedStatement pstmt2 = null;		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setSeq_tab(Sequencer.nextId(conn, "sop_tab"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into sop_tab  values (?,?,?)");
			pstmt.setInt(1, pds.getSeq_tab());			
			pstmt.setString(2, pds.getName_tab());			
			pstmt.setInt(3, pds.getJunbang());			
		
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insertTab",ex2);
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
		pstmt=conn.prepareStatement(
		"update sop_item set  cate_nm=?,title=?,content=?,view_yn=?,name=?,filename=?,seq_tab=? where seq=?" );		
		pstmt.setString(1,pds.getCate_nm());		
		pstmt.setString(2, pds.getTitle());
		pstmt.setCharacterStream(3,  new StringReader(pds.getContent()), pds.getContent().length());		
		pstmt.setInt(4, pds.getView_yn());
		pstmt.setString(5, pds.getName());
		pstmt.setString(6, pds.getFilename());
		pstmt.setInt(7, pds.getSeq_tab());
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
		pstmt=conn.prepareStatement(
		"update sop_item set cate_nm=?,title=?,content=?,view_yn=?,name=?,seq_tab=?  where seq=?");		
		pstmt.setString(1,pds.getCate_nm());		
		pstmt.setString(2, pds.getTitle());
		pstmt.setCharacterStream(3,  new StringReader(pds.getContent()), pds.getContent().length());		
		pstmt.setInt(4, pds.getView_yn());
		pstmt.setString(5, pds.getName());
		pstmt.setInt(6, pds.getSeq_tab());		
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
public void updateFile_item(AccBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement(
		"update sop_item set filename=? where seq=?" );		
		
		pstmt.setString(1, pds.getFilename());		
		pstmt.setInt(2, pds.getSeq());

		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("updateFile_item!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}
public void updateFile_multi(AccBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement(
		"update sop_item_multi set filename=? where seq=?" );		
		
		pstmt.setString(1, pds.getFilename());		
		pstmt.setInt(2, pds.getSeq());

		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("updateFile_multi!", ex);
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
			query.append("select count(*) from sop_item  ");
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
            throw new MgrException("count file", ex);
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
			query.append("select * from sop_item  ");
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
				pds.setCate_nm(rs.getString("cate_nm"));					
				pds.setTitle(rs.getString("title"));			
						try{
								reader=rs.getCharacterStream("content");
								char[] buff=new char[512];
								int len=-1;
								StringBuffer buffer=new StringBuffer(512);
								while((len=reader.read(buff)) != -1){
									buffer.append(buff,0,len);
								}
								pds.setContent(buffer.toString());
								}catch (IOException iex){
									throw new MgrException("content select",iex);
								}finally{
									if(reader !=null)try	{reader.close();}
									catch (IOException iex){}
								} 
					pds.setRegister(rs.getTimestamp("register"));
					pds.setView_yn(rs.getInt("view_yn"));
					pds.setView_seq(rs.getInt("view_seq"));
				    pds.setName(rs.getString("name"));
				    pds.setFilename(rs.getString("filename"));				
					pds.setIp_add(rs.getString("ip_add"));
					pds.setHit_cnt(rs.getInt("hit_cnt"));
					pds.setSeq_tab(rs.getInt("seq_tab"));
									
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

/**등록된 글의 count구하기**/
public int count02(int seq_tab,List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP;         
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from sop_item  where seq_tab=?");
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

            pstmt.setInt(valueMap.size()+1, seq_tab);
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("count file", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

/**목록 읽기**/
public List selectList02(int seq_tab,List whereCond, Map valueMap, int startRow, int endRow) throws MgrException{
	 if (valueMap == null) valueMap = Collections.EMPTY_MAP; 

	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	 try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from sop_item  where seq_tab=?");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and ");                
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
            pstmt.setInt(valueMap.size()+1, seq_tab);
            pstmt.setInt(valueMap.size()+2, startRow);
            pstmt.setInt(valueMap.size()+3, endRow-startRow+1);

		rs=pstmt.executeQuery();
		if (rs.next()){
			List list=new java.util.ArrayList(endRow-startRow+1);
			Reader reader = null;        
			do{
				AccBean pds=new AccBean();
				pds.setSeq(rs.getInt("seq"));				
				pds.setCate_nm(rs.getString("cate_nm"));				
				pds.setTitle(rs.getString("title"));			
						try{
								reader=rs.getCharacterStream("content");
								char[] buff=new char[512];
								int len=-1;
								StringBuffer buffer=new StringBuffer(512);
								while((len=reader.read(buff)) != -1){
									buffer.append(buff,0,len);
								}
								pds.setContent(buffer.toString());
								}catch (IOException iex){
									throw new MgrException("content select",iex);
								}finally{
									if(reader !=null)try	{reader.close();}
									catch (IOException iex){}
								} 
					pds.setRegister(rs.getTimestamp("register"));
					pds.setView_yn(rs.getInt("view_yn"));
					pds.setView_seq(rs.getInt("view_seq"));
				    pds.setName(rs.getString("name"));
				    pds.setFilename(rs.getString("filename"));				
					pds.setIp_add(rs.getString("ip_add"));
					pds.setHit_cnt(rs.getInt("hit_cnt"));
					pds.setSeq_tab(rs.getInt("seq_tab"));
									
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
		pstmt=conn.prepareStatement("select * from sop_item  where seq=? ");
		pstmt.setInt(1, seq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new AccBean();
				pds.setSeq(rs.getInt("seq"));				
				pds.setCate_nm(rs.getString("cate_nm"));				
				pds.setTitle(rs.getString("title"));			
						try{
								reader=rs.getCharacterStream("content");
								char[] buff=new char[512];
								int len=-1;
								StringBuffer buffer=new StringBuffer(512);
								while((len=reader.read(buff)) != -1){
									buffer.append(buff,0,len);
								}
								pds.setContent(buffer.toString());
								}catch (IOException iex){
									throw new MgrException("content select",iex);
								}finally{
									if(reader !=null)try	{reader.close();}
									catch (IOException iex){}
								} 
					pds.setRegister(rs.getTimestamp("register"));
					pds.setView_yn(rs.getInt("view_yn"));
					pds.setView_seq(rs.getInt("view_seq"));
				    pds.setName(rs.getString("name"));
				    pds.setFilename(rs.getString("filename"));				
					pds.setIp_add(rs.getString("ip_add"));
					pds.setHit_cnt(rs.getInt("hit_cnt"));	
					pds.setSeq_tab(rs.getInt("seq_tab"));	

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
		pstmt=conn.prepareStatement("delete from sop_item where seq=?  ");
		pstmt.setInt(1, seq);
		pstmt.executeUpdate();		

		pstmtKind=conn.prepareStatement("delete from sop_down  where seq_acc=?  ");
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
public void deleteFileFollow(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;	
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from sop_item_multi where seq=?  ");
		pstmt.setInt(1, seq);
		pstmt.executeUpdate();
		
	}catch (SQLException ex){
		throw new MgrException("deleteFileFollow", ex);
	}finally{		
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**cate delete with item and down**/
public void deleteCate(int cate_seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	PreparedStatement pstmtKind=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from sop_item where cate_seq=?  ");
		pstmt.setInt(1, cate_seq);
		pstmt.executeUpdate();		

		pstmtKind=conn.prepareStatement("delete from sop_down where cate_seq=?  ");
		pstmtKind.setInt(1, cate_seq);
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
			stmt = conn.prepareStatement("update sop_item set hit_cnt = hit_cnt+1 where seq=?");			
			stmt.setInt(1,seq);
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("sop_item Down Load qty",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
	}

/****************tab count********************/
 public int  tabCnt() throws MgrException {
        Connection conn = null;
        PreparedStatement  stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            stmt = conn.prepareStatement("select count(*) from sop_tab ");			
			
            rs = stmt.executeQuery();
			
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("tabCnt", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

public List listTab() throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rsMessage = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from sop_tab order by junbang asc" );            
			rsMessage = pstmt.executeQuery();
            if (rsMessage.next()) {                 
				List list = new java.util.ArrayList();
				Reader reader = null; 				
                do {
                    AccBean acc = new AccBean();
                    acc.setSeq_tab(rsMessage.getInt("seq_tab"));                    
					acc.setName_tab(rsMessage.getString("name_tab"));
					acc.setJunbang(rsMessage.getInt("junbang"));	

				list.add(acc);	
                }while(rsMessage.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("listTab", ex);
        } finally {             
			if (rsMessage != null)                  
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

/**TAB delete**/
public void deleteTab(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	PreparedStatement pstmtItem=null;
	PreparedStatement pstmtKind=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from sop_tab where seq_tab=?  ");
		pstmt.setInt(1, seq);
		pstmt.executeUpdate();		

		pstmtItem=conn.prepareStatement("delete from sop_item where seq_tab=?  ");
		pstmtItem.setInt(1, seq);
		pstmtItem.executeUpdate();		

		pstmtKind=conn.prepareStatement("delete from sop_down  where seq_tab=?  ");
		pstmtKind.setInt(1, seq);
		pstmtKind.executeUpdate();
		
	}catch (SQLException ex){
		throw new MgrException("delete all", ex);
	}finally{
		if(pstmtKind !=null) try{pstmtKind.close();} catch(SQLException ex){}
		if(pstmtItem !=null) try{pstmt.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**tab modify**/
	public void updatetab(AccBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement(
		"update sop_tab set name_tab=?,junbang=? where seq_tab=?" );		
		pstmt.setString(1, pds.getName_tab());		
		pstmt.setInt(2, pds.getJunbang());
		pstmt.setInt(3, pds.getSeq_tab());

		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}

/**지정한 글 불러오기**/
public AccBean getTab(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		AccBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from sop_tab  where seq_tab=? ");
		pstmt.setInt(1, seq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new AccBean();
				pds.setSeq_tab(rs.getInt("seq_tab"));                    
				pds.setName_tab(rs.getString("name_tab"));
				pds.setJunbang(rs.getInt("junbang"));

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

}
