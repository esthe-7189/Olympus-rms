package mira.shokudata;

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
            pds.setBseq(Sequencer.nextId(conn, "shoku_file"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into shoku_file  values (?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pds.getBseq());
			pstmt.setInt(2, pds.getCateNo());
			pstmt.setInt(3, pds.getCate_cnt());
			pstmt.setInt(4, pds.getMseq());
			pstmt.setCharacterStream(5,  new StringReader(pds.getTitle()),  pds.getTitle().length());   
			pstmt.setString(6, pds.getFile());
			pstmt.setTimestamp(7, pds.getRegister());			
			pstmt.setInt(8, pds.getOk_yn());			
					
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insertFile",ex2);
		} finally {			
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
	}

public void insertFileMulti(int cateNo, int cate_cnt, int mseq, String title, String file, int ok_yn, int cate_group )
		throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;
		Timestamp register=new Timestamp(System.currentTimeMillis());
		int seq=0;
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            seq=Sequencer.nextId(conn, "shoku_file");

			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into shoku_file values (?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, seq);
			pstmt.setInt(2, cateNo);
			pstmt.setInt(3, cate_cnt);
			pstmt.setInt(4, cate_group);	
			pstmt.setInt(5, mseq);
			pstmt.setCharacterStream(6,  new StringReader(title),  title.length());
			pstmt.setString(7, file);
			pstmt.setTimestamp(8, register);			
			pstmt.setInt(9, ok_yn);				
			
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("insertFile Multi",ex2);
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
		pstmt=conn.prepareStatement("update shoku_file set LGROUP_NO=?, cate_bseq=?,title=?,filename=?,del_yn=? where seq=?" );
		pstmt.setInt(1, pds.getCateNo());
		pstmt.setInt(2, pds.getCate_cnt());
		pstmt.setCharacterStream(3,  new StringReader(pds.getTitle()),  pds.getTitle().length());	
		pstmt.setString(4, pds.getFile());			
		pstmt.setInt(5, pds.getOk_yn());
		pstmt.setInt(6, pds.getBseq());
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
	public void update2(Category pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update shoku_file set LGROUP_NO=?, cate_seq=?,title=?,del_yn=? where seq=?" );
		pstmt.setInt(1, pds.getCateNo());
		pstmt.setInt(2, pds.getCate_cnt());
		pstmt.setCharacterStream(3,  new StringReader(pds.getTitle()),  pds.getTitle().length());						
		pstmt.setInt(4, pds.getOk_yn());
		pstmt.setInt(5, pds.getBseq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}
/*카테고리 삭제시 관련 파일 존재 확인  미완성*/ 
/*
public int checkFile(int seq, int level, int groupId) throws MgrException {
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try	{
		conn=DBUtil.getConnection(POOLNAME);
if(level==1){
	pstmt = conn.prepareStatement("select cate_bseq from shoku_file where cate_bseq=? or cate_group=?");
            pstmt.setInt(1, seq);
			pstmt.setInt(2, groupId);	
}else if(level==2){
	pstmt = conn.prepareStatement("select cate_bseq from shoku_file where cate_bseq=? ");
            pstmt.setInt(1, seq);			
}else if(level==0){
	pstmt = conn.prepareStatement("select cate_bseq from shoku_file where LGROUP_NO=? ");
            pstmt.setInt(1, seq);		
}				
            rs = pstmt.executeQuery();
            if (rs.next()) {                             
				
				int dbbseq=rs.getInt("seq");				
				if(dbbseq!=0){
					return dbbseq;
				}else{
				
					return 0;}                
                
            } else {
                // 존재하지 않으면 -1을 리턴한다.
                return -1;
            }
        } catch(SQLException ex) {
            throw new MgrException("checkFile", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

*/
/**등록된 글의 count구하기**/
public int countAll(List whereCond, Map valueMap)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP;         
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) FROM shoku_file ");
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
public List selectListAll(List whereCond, Map valueMap, int startRow, int endRow) throws MgrException{
	 if (valueMap == null) valueMap = Collections.EMPTY_MAP; 

	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	 try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * FROM shoku_file ");
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
				Category pds=new Category();				
                pds.setBseq(rs.getInt("seq"));
				pds.setKind(rs.getInt("LGROUP_NO"));
				pds.setCate_cnt(rs.getInt("cate_bseq"));
				pds.setGroupId(rs.getInt("cate_group"));
				pds.setMseq(rs.getInt("mseq"));       			
					try{
							reader=rs.getCharacterStream("title");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							pds.setTitle(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("comment select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
							}	
				
				pds.setFile(rs.getString("filename"));
				pds.setRegister(rs.getTimestamp("register"));
				pds.setOk_yn(rs.getInt("del_yn"));

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
/**등록된 글의 count구하기 **/
public int count(List whereCond, Map valueMap,int pg)   throws MgrException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP;         
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200); 

				query.append(
				"select count(*) FROM shoku_file a "+
				"LEFT JOIN shoku_cate b ON a.cate_bseq=b.BSEQ "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where a.LGROUP_NO=? "); 

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
            pstmt.setInt(1, pg);	
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
				"select * FROM shoku_file a "+
				"LEFT JOIN shoku_cate b ON a.cate_bseq=b.BSEQ "+ 
				"LEFT JOIN member c ON a.mseq=c.mseq where a.LGROUP_NO=? "	);
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
				pds.setBseq(rs.getInt("BSEQ"));
                pds.setGroupId(rs.getInt("GROUP_ID"));                    
				pds.setOrderNo(rs.getInt("ORDER_NO"));                    
				pds.setLevel(rs.getInt("PLEVEL"));
                pds.setParentId(rs.getInt("PARENT_ID"));                			
					try{
							reader=rs.getCharacterStream("Menu");
							char[] buff=new char[512];
							int len=-1;
							StringBuffer buffer=new StringBuffer(512);
							while((len=reader.read(buff)) != -1){
								buffer.append(buff,0,len);
							}
							pds.setContent(buffer.toString());
							}catch (IOException iex){
								throw new MgrException("comment select",iex);
							}finally{
								if(reader !=null)try	{reader.close();}
								catch (IOException iex){}
							}	
				pds.setCateNo(rs.getInt("CATE_NO"));				
				pds.setFile_bseq(rs.getInt("seq"));
				pds.setKind(rs.getInt("LGROUP_NO"));
				pds.setCate_cnt(rs.getInt("cate_bseq"));
				pds.setHenji_yn(rs.getInt("cate_group"));
				pds.setMseq(rs.getInt("mseq"));
				pds.setTitle(rs.getString("title"));
				pds.setFile(rs.getString("filename"));
				pds.setRegister(rs.getTimestamp("register"));
				pds.setOk_yn(rs.getInt("del_yn"));							
				pds.setName(rs.getString("nm"));
				pds.setKind_yn(rs.getInt("position_level"));

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
/*
public Category getFile(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		Category pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from shoku_file where seq=? ");
		pstmt.setInt(1, seq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new Category();
				pds.setSeq(rs.getInt("seq"));
				pds.setTitle(rs.getString("title"));
				pds.setName(rs.getString("name"));
				pds.setFile(rs.getString("filename"));
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
				pds.setCate_nm(rs.getString("MENU"));

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
*/
/**delete**/

public void deleteByCate(int id, int level, int groupId) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;	
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		if(level==1){
				pstmt = conn.prepareStatement(
                "delete from shoku_file where cate_bseq = ? or  cate_group=? ");
				pstmt.setInt(1, id);
				pstmt.setInt(2, groupId);
		}else if(level==2){
				pstmt = conn.prepareStatement(
                "delete from shoku_file where cate_bseq = ? ");
				pstmt.setInt(1, id);				

		}else if(level==0){
				pstmt = conn.prepareStatement(
                "delete from shoku_file where LGROUP_NO = ? ");
				pstmt.setInt(1, id);
		}
		pstmt.executeUpdate();
		
	}catch (SQLException ex){
		throw new MgrException("delete all", ex);
	}finally{
		
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.setAutoCommit(true);conn.close();} catch(SQLException ex){}
	}
}
public void delete(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;	
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);		
				pstmt = conn.prepareStatement("delete from shoku_file where seq = ? ");
				pstmt.setInt(1, seq);				
		
		pstmt.executeUpdate();
		
	}catch (SQLException ex){
		throw new MgrException("delete", ex);
	}finally{		
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.setAutoCommit(true);conn.close();} catch(SQLException ex){}
	}
}

/**리스트 삭제시 사용 **/
 public List selectListFileDel(int seq, int level, int groupId) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader = null;    
        try {            
            conn = DBUtil.getConnection(POOLNAME); 
		if(level==1){
			pstmt = conn.prepareStatement("select * from shoku_file where cate_bseq=? or cate_group=? ");			         
			pstmt.setInt(1, seq);
			pstmt.setInt(2, groupId);
		
		}else if(level==2){
			pstmt = conn.prepareStatement("select * from shoku_file where cate_bseq=? ");			         
			pstmt.setInt(1, seq);
			
		}else if(level==0){
			pstmt = conn.prepareStatement("select * from shoku_file where LGROUP_NO=? ");			
			pstmt.setInt(1, groupId);
		}
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category board = new Category();
						board.setBseq(rs.getInt("seq"));
						board.setGroupId(rs.getInt("LGROUP_NO"));
						board.setCate_cnt(rs.getInt("cate_bseq"));						
						board.setKind(rs.getInt("cate_group"));
						board.setMseq(rs.getInt("mseq"));						
							try{
									reader=rs.getCharacterStream("title");
									char[] buff=new char[512];
									int len=-1;
									StringBuffer buffer=new StringBuffer(512);
									while((len=reader.read(buff)) != -1){
										buffer.append(buff,0,len);
									}
									board.setContent(buffer.toString());
									}catch (IOException iex){
										throw new MgrException("title select",iex);
									}finally{
										if(reader !=null)try	{reader.close();}
										catch (IOException iex){}
									}
						board.setFile(rs.getString("filename"));
						board.setRegister(rs.getTimestamp("register"));	
						board.setOk_yn(rs.getInt("del_yn"));
						
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("select shoku_file", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }


/**리스트 삭제시 사용 **/
 public List selectList(int seq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader = null;    
        try {            
            conn = DBUtil.getConnection(POOLNAME); 		
			pstmt = conn.prepareStatement("select * from shoku_file a inner join shoku_cate b on a.cate_bseq=b.BSEQ where a.cate_bseq=?");
			         
            pstmt.setInt(1, seq);
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category board = new Category();
						board.setBseq(rs.getInt("seq"));
						board.setGroupId(rs.getInt("LGROUP_NO"));
						board.setCate_cnt(rs.getInt("cate_bseq"));						
						board.setKind(rs.getInt("cate_group"));
						board.setMseq(rs.getInt("mseq"));						
							try{
									reader=rs.getCharacterStream("title");
									char[] buff=new char[512];
									int len=-1;
									StringBuffer buffer=new StringBuffer(512);
									while((len=reader.read(buff)) != -1){
										buffer.append(buff,0,len);
									}
									board.setContent(buffer.toString());
									}catch (IOException iex){
										throw new MgrException("title select",iex);
									}finally{
										if(reader !=null)try	{reader.close();}
										catch (IOException iex){}
									}
						board.setFile(rs.getString("filename"));
						board.setRegister(rs.getTimestamp("register"));	
						board.setOk_yn(rs.getInt("del_yn"));
						
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("select shoku_cate", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

/**페이지 노출 여부 **/
 public List selectPageGo(int mseq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 		
        try {            
            conn = DBUtil.getConnection(POOLNAME); 		
			pstmt = conn.prepareStatement(
				"select * from shoku_mem where mseq=? ");
			         
            pstmt.setInt(1, mseq);
			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Category board = new Category();
						board.setBseq(rs.getInt("bseq"));
						board.setMseq(rs.getInt("mseq"));						
						board.setCate_cnt(rs.getInt("cate_cnt"));					
						
					list.add(board);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("select shoku_mem", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
}


public int kindCnt(int mseq)   throws MgrException {        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try	{
			conn=DBUtil.getConnection(POOLNAME);
			pstmt = conn.prepareStatement("select count(*) from shoku_mem where mseq=? ");
            pstmt.setInt(1, mseq);			    
            
            rs = pstmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch(SQLException ex) {
            throw new MgrException("count kindCnt", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
//카테고리...삭제 요청처리
public void delYn(int id, int level, int groupId)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME);			
			
		if(level==1){
				stmt = conn.prepareStatement(
                "update shoku_file set del_yn=3 where cate_bseq=? or cate_group=? ");
				stmt.setInt(1, id);
				stmt.setInt(2, groupId);
		}else if(level==2){
				stmt = conn.prepareStatement(
                "update shoku_file set del_yn=3 where cate_bseq=? ");
				stmt.setInt(1, id);				

		}else if(level==0){
				stmt = conn.prepareStatement(
                "update shoku_file set del_yn=3 where LGROUP_NO = ? ");
				stmt.setInt(1, id);
		}
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("delYn exception ",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
	}

//전체 리스트 ...삭제 요청처리
public void delYnList(int id, int level, int groupId)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME);			
			
		if(level==1){
				stmt = conn.prepareStatement(
                "update shoku_file set del_yn=2 where seq=? or cate_group=? ");
				stmt.setInt(1, id);
				stmt.setInt(2, groupId);
		}else if(level==2){
				stmt = conn.prepareStatement(
                "update shoku_file set del_yn=2 where seq=? ");
				stmt.setInt(1, id);				

		}else if(level==0){
				stmt = conn.prepareStatement(
                "update shoku_file set del_yn=2 where LGROUP_NO = ? ");
				stmt.setInt(1, id);
		}
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("delYn exception ",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
	}

/*
public void upDown(int seq)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME); 			
			stmt = conn.prepareStatement("update shoku_file set hit_cnt = hit_cnt+1 where seq=?");			
			stmt.setInt(1,seq);
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("acc_file Down Load qty",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
	}
*/
}
