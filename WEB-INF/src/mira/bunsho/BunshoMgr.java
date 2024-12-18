package mira.bunsho;

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

public class BunshoMgr {
	private static BunshoMgr instance = new BunshoMgr();
	
	public static BunshoMgr getInstance() {		
		return instance;
	}
	
	private BunshoMgr() {}
	private static String POOLNAME="pool";
	
	// level 1 인서트
	public void insertLevel_1(BunshoBean pds)  throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		PreparedStatement pstmt2 = null;		
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setNo(Sequencer.nextId(conn, "bunsho"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into bunsho  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pds.getNo());		
			pstmt.setInt(2, pds.getFile_kind());		
			pstmt.setString(3, pds.getFilename());
			pstmt.setString(4, pds.getCate_code());
			pstmt.setString(5, pds.getCate_code_det());
			pstmt.setString(6, pds.getFname());
			pstmt.setString(7, pds.getFname_digi());
			pstmt.setString(8, pds.getFname_bun());
			pstmt.setString(9, pds.getBasho());
			pstmt.setString(10, pds.getBasho_digi());
			pstmt.setString(11, pds.getBasho_bun());
			pstmt.setCharacterStream(12,  new StringReader(pds.getContent()), pds.getContent().length());			
			pstmt.setTimestamp(13, pds.getRegister());
			pstmt.setInt(14, pds.getView_yn());		
			pstmt.setString(15, pds.getF_title());
			pstmt.setInt(16, pds.getKind_yn());
			pstmt.setString(17, pds.getCate_code_s());
		
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("upload",ex2);
		} finally {	
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex1) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
	}
// level 2~4 인서트
public void insertLevel_2(BunshoBean pds)  throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		PreparedStatement pstmt2 = null;		
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setBseq(Sequencer.nextId(conn, "bun_kind"));
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into bun_kind  values (?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pds.getBseq());		
			pstmt.setInt(2, pds.getNo());		
			pstmt.setInt(3, pds.getFile_kind());		
			pstmt.setString(4, pds.getFilename());
			pstmt.setInt(5, pds.getParentId());	
			pstmt.setInt(6, pds.getKind_yn());			
			pstmt.setTimestamp(7, pds.getRegister());
			pstmt.setInt(8, pds.getView_yn());		
		
			
		
			pstmt.executeUpdate();		

			conn.commit();		
		} catch(SQLException ex2) { try{conn.rollback();} catch(SQLException ex){}
			throw new MgrException("upload",ex2);
		} finally {	
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex1) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex1){}
		}
	}

	/**leve 1 **/
public void updateHenkoLeve_1(int no, int  kind_yn) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("update bunsho set  kind_yn=?   where  fno=? ");
		pstmt.setInt(1, kind_yn);		
		pstmt.setInt(2, no);		
		pstmt.executeUpdate();		
	}catch (SQLException ex){
		throw new MgrException("update", ex);
	}finally{
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**leve 3~4 **/
public void updateHenkoLeve_2(int no,  int  kind_yn) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("update bun_kind set  kind_yn=?   where  bseq=? ");
		pstmt.setInt(1, kind_yn);		
		pstmt.setInt(2, no);		
		pstmt.executeUpdate();		
	}catch (SQLException ex){
		throw new MgrException("update", ex);
	}finally{
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**leve 2-->1로  **/
public void updateHenkoLeve_0(int no,  int  kind_yn) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("update bunsho set  kind_yn=?   where  fno=? ");
		pstmt.setInt(1, kind_yn);		
		pstmt.setInt(2, no);		
		pstmt.executeUpdate();		
	}catch (SQLException ex){
		throw new MgrException("update", ex);
	}finally{
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**수정하기**/
	public void update(BunshoBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update bunsho set  file_kind=?,filename=?,cate_code=?,cate_code_det=?,fname=?, "+
			"fname_digi=?,fname_bun=?,basho=?,basho_digi=?,basho_bun=?,fcomment=?,view_yn=?,f_title=?,cate_code_s=?   where  fno=?" );
		pstmt.setInt(1, pds.getFile_kind());
		pstmt.setString(2, pds.getFilename());
		pstmt.setString(3, pds.getCate_code());
		pstmt.setString(4, pds.getCate_code_det());
		pstmt.setString(5, pds.getFname());
		pstmt.setString(6, pds.getFname_digi());
		pstmt.setString(7, pds.getFname_bun());
		pstmt.setString(8, pds.getBasho());
		pstmt.setString(9, pds.getBasho_digi());
		pstmt.setString(10, pds.getBasho_bun());
		pstmt.setCharacterStream(11,  new StringReader(pds.getContent()), pds.getContent().length());		
		pstmt.setInt(12, pds.getView_yn());		
		pstmt.setString(13, pds.getF_title());	
		pstmt.setString(14, pds.getCate_code_s());
		pstmt.setInt(15, pds.getNo());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}
/**수정하기2**/
	public void update2(BunshoBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update bunsho set  file_kind=?,cate_code=?,cate_code_det=?,fname=?, "+
			"fname_digi=?,fname_bun=?,basho=?,basho_digi=?,basho_bun=?,fcomment=?,view_yn=?,f_title=?,cate_code_s=?  where  fno=?" );
		pstmt.setInt(1, pds.getFile_kind());
		pstmt.setString(2, pds.getCate_code());
		pstmt.setString(3, pds.getCate_code_det());
		pstmt.setString(4, pds.getFname());
		pstmt.setString(5, pds.getFname_digi());
		pstmt.setString(6, pds.getFname_bun());
		pstmt.setString(7, pds.getBasho());
		pstmt.setString(8, pds.getBasho_digi());
		pstmt.setString(9, pds.getBasho_bun());
		pstmt.setCharacterStream(10,  new StringReader(pds.getContent()), pds.getContent().length());
		pstmt.setInt(11, pds.getView_yn());		
		pstmt.setString(12, pds.getF_title());	
		pstmt.setString(13, pds.getCate_code_s());
		pstmt.setInt(14, pds.getNo());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}
/**수정하기pop**/
	public void updateLevelall(BunshoBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update bun_kind set  filename=?,view_yn=?   where  bseq=?" );
		pstmt.setString(1, pds.getFilename());
		pstmt.setInt(2, pds.getView_yn());	
		pstmt.setInt(3, pds.getBseq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("updatepop!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}
/**수정하기pop02**/
	public void updateLevel(BunshoBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update bun_kind set  view_yn=?   where  bseq=?" );		
		pstmt.setInt(1, pds.getView_yn());	
		pstmt.setInt(2, pds.getBseq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("updatepop!!!!!", ex);
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
			query.append("select count(*) from bunsho  where  file_kind=1 ");
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

/**목록 읽기**/
public List selectList(List whereCond, Map valueMap, int startRow, int endRow) throws MgrException{
	 if (valueMap == null) valueMap = Collections.EMPTY_MAP; 

	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	 try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from bunsho  where  file_kind=1 ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" and ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by fno desc  limit ?, ?");            
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
				BunshoBean pds=new BunshoBean();
				pds.setNo(rs.getInt("fno"));
				pds.setFile_kind(rs.getInt("file_kind"));
				pds.setFilename(rs.getString("filename"));
				pds.setCate_code(rs.getString("cate_code"));
				pds.setCate_code_det(rs.getString("cate_code_det"));
				pds.setFname(rs.getString("fname"));
				pds.setFname_digi(rs.getString("fname_digi"));
				pds.setFname_bun(rs.getString("fname_bun"));
				pds.setBasho(rs.getString("basho"));
				pds.setBasho_digi(rs.getString("basho_digi"));
				pds.setBasho_bun(rs.getString("basho_bun"));				
					try{
							reader=rs.getCharacterStream("fcomment");
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
				pds.setF_title(rs.getString("f_title"));
				pds.setKind_yn(rs.getInt("kind_yn"));
				pds.setCate_code_s(rs.getString("cate_code_s"));
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
public List selectListAll() throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null; 
		Reader reader = null;    
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from bunsho where  file_kind=1 order by fno desc " );
           	rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    BunshoBean pds=new BunshoBean();
					pds.setNo(rs.getInt("fno"));
					pds.setFile_kind(rs.getInt("file_kind"));
					pds.setFilename(rs.getString("filename"));
					pds.setCate_code(rs.getString("cate_code"));
					pds.setCate_code_det(rs.getString("cate_code_det"));
					pds.setFname(rs.getString("fname"));
					pds.setFname_digi(rs.getString("fname_digi"));
					pds.setFname_bun(rs.getString("fname_bun"));
					pds.setBasho(rs.getString("basho"));
					pds.setBasho_digi(rs.getString("basho_digi"));
					pds.setBasho_bun(rs.getString("basho_bun"));				
						try{
								reader=rs.getCharacterStream("fcomment");
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
					pds.setF_title(rs.getString("f_title"));
					pds.setKind_yn(rs.getInt("kind_yn"));
					pds.setCate_code_s(rs.getString("cate_code_s"));
					list.add(pds);			

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("select bunsho", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
/**지정한 글 불러오기**/
public BunshoBean getBunsho(int no) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		BunshoBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from bunsho where fno=?");
		pstmt.setInt(1, no);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new BunshoBean();
				pds.setNo(rs.getInt("fno"));
				pds.setFile_kind(rs.getInt("file_kind"));
				pds.setFilename(rs.getString("filename"));
				pds.setCate_code(rs.getString("cate_code"));
				pds.setCate_code_det(rs.getString("cate_code_det"));
				pds.setFname(rs.getString("fname"));
				pds.setFname_digi(rs.getString("fname_digi"));
				pds.setFname_bun(rs.getString("fname_bun"));
				pds.setBasho(rs.getString("basho"));
				pds.setBasho_digi(rs.getString("basho_digi"));
				pds.setBasho_bun(rs.getString("basho_bun"));
				
					try{
							reader=rs.getCharacterStream("fcomment");
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
				pds.setF_title(rs.getString("f_title"));
				pds.setKind_yn(rs.getInt("kind_yn"));
				pds.setCate_code_s(rs.getString("cate_code_s"));

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
//level 2이상 파일
public BunshoBean getFile(int bseq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		BunshoBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from bun_kind where bseq=?");
		pstmt.setInt(1, bseq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new BunshoBean();
				pds.setBseq(rs.getInt("bseq"));
				pds.setNo(rs.getInt("fno"));
				pds.setFile_kind(rs.getInt("file_kind"));
				pds.setFilename(rs.getString("filename"));
				pds.setParentId(rs.getInt("parent_id"));
				pds.setKind_yn(rs.getInt("kind_yn"));				
				pds.setRegister(rs.getTimestamp("register"));
				pds.setView_yn(rs.getInt("view_yn"));

			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new MgrException("get getFile", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**지정한 단계 불러오기**/
public BunshoBean getKind2( int no, int  kind) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try{
		BunshoBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from bun_kind  where fno =? and  file_kind =? ");
		pstmt.setInt(1, no);
		pstmt.setInt(2, kind);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new BunshoBean();
			    pds.setBseq(rs.getInt("bseq"));
				pds.setNo(rs.getInt("fno"));
				pds.setFile_kind(rs.getInt("file_kind"));
				pds.setFilename(rs.getString("filename"));
				pds.setParentId(rs.getInt("parent_id"));
				pds.setKind_yn(rs.getInt("kind_yn"));				
				pds.setRegister(rs.getTimestamp("register"));
				pds.setView_yn(rs.getInt("view_yn"));		

			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new MgrException("kind select", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}

/**지정한 Level 불러오기**/
public BunshoBean getLevel( int no) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try{
		BunshoBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from bun_kind  where bseq =?  ");
		pstmt.setInt(1, no);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new BunshoBean();
			    pds.setBseq(rs.getInt("bseq"));
				pds.setNo(rs.getInt("fno"));
				pds.setFile_kind(rs.getInt("file_kind"));
				pds.setFilename(rs.getString("filename"));
				pds.setParentId(rs.getInt("parent_id"));
				pds.setKind_yn(rs.getInt("kind_yn"));				
				pds.setRegister(rs.getTimestamp("register"));
				pds.setView_yn(rs.getInt("view_yn"));		

			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new MgrException("kind select", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**(원문삭제 LEVEL1)**/
public void deleteLevel1(int no) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	PreparedStatement pstmtKind=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from bunsho where fno=?  ");
		pstmt.setInt(1, no);
		pstmt.executeUpdate();		

		pstmtKind=conn.prepareStatement("delete from bun_kind  where fno=?  ");
		pstmtKind.setInt(1, no);
		pstmtKind.executeUpdate();	
	}catch (SQLException ex){
		throw new MgrException("delete LEVEL1", ex);
	}finally{
		if(pstmtKind !=null) try{pstmtKind.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**(원문이하 삭제 LEVEL2)**/
public void deleteLevel2(int no) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from bun_kind where   fno=? ");
		pstmt.setInt(1, no);
		pstmt.executeUpdate();		

	}catch (SQLException ex){
		throw new MgrException("delete LEVEL2", ex);
	}finally{		
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}

/**(원문이하 삭제 LEVEL3)**/
public void deleteLevel3(int no) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from bun_kind where bseq=?  or  parent_id =? ");
		pstmt.setInt(1, no);
		pstmt.setInt(2, no);
		pstmt.executeUpdate();		

	}catch (SQLException ex){
		throw new MgrException("delete LEVEL3", ex);
	}finally{		
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}
/**(원문이하 삭제 LEVEL4)**/
public void deleteLevel4(int no) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from bun_kind where bseq=?   ");
		pstmt.setInt(1, no);
		pstmt.executeUpdate();		

	}catch (SQLException ex){
		throw new MgrException("delete LEVEL4", ex);
	}finally{		
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}


/*
public void upDown(int no)	throws MgrException {		
		Connection conn = null;
		PreparedStatement stmt = null;			
		
		try {
			conn = DBUtil.getConnection(POOLNAME); 			
			stmt = conn.prepareStatement("update bunsho set read_no = read_no+1 where fno=?");			
			stmt.setInt(1,no);
			stmt.executeUpdate();
			
		} catch(SQLException ex) {
			throw new MgrException("bunsho upDown",ex);
		}  finally {			
			if (stmt != null) try { stmt.close(); } catch(SQLException ex1) {}
			if (conn != null) try{conn.close();} catch(SQLException ex1){}
		}		
	}

*/

}
