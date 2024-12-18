package mira.job;

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

public class JobMgr {
	private static JobMgr instance = new JobMgr();
	
	public static JobMgr getInstance() {		
		return instance;
	}
	
	private JobMgr() {}
	private static String POOLNAME="pool";	
	
	public void insert(JobBean pds)  throws MgrException {		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		
		try {
			conn = DBUtil.getConnection(POOLNAME);	
			conn.setAutoCommit(false);
			 // 새로운 글의 번호를 구한다.
            pds.setSeq(Sequencer.nextId(conn, "job_item"));
			
			// DB에 내용 저장				
			pstmt = conn.prepareStatement("insert into job_item values (?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pds.getSeq());			
			pstmt.setInt(2, pds.getCate_seq());
			pstmt.setInt(3, pds.getCate_L_seq());
			pstmt.setInt(4, pds.getCate_M_seq());			
			pstmt.setString(5, pds.getTitle());
			pstmt.setCharacterStream(6,  new StringReader(pds.getContent()), pds.getContent().length());			
			pstmt.setTimestamp(7, pds.getRegister());
			pstmt.setInt(8, pds.getView_yn());	
			pstmt.setInt(9, pds.getSeq());	//view_seq (user 전시 순서)
					
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
	public void update(JobBean pds) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement("update job_item set title=?,content=?,view_yn=? where seq=?" );
		
		pstmt.setString(1, pds.getTitle());		
		pstmt.setCharacterStream(2,  new StringReader(pds.getContent()), pds.getContent().length());		
		pstmt.setInt(3, pds.getView_yn());		
		pstmt.setInt(4, pds.getSeq());
		pstmt.executeUpdate();
		conn.commit();		
		}catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("update!!!!!", ex);
		}finally{
			if (pstmt !=null) try{pstmt.close();}	catch (SQLException ex){}
			if (conn !=null)	try{conn.setAutoCommit(true); conn.close();} catch(SQLException ex){}
		}	
	}

 public void updateViewSeq(int view_seq, int seq) throws MgrException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
			conn.setAutoCommit(false);
            pstmt = conn.prepareStatement("update job_item set view_seq=? where seq=?");
			pstmt.setInt(1, view_seq);
            pstmt.setInt(2, seq);
            
            pstmt.executeUpdate();
            conn.commit();
		 }catch (SQLException ex){
			try{conn.rollback();}catch (SQLException ex1){} throw  new MgrException("updateViewSeq()", ex);
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
			query.append("select count(*) from job_item ");
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
			query.append("select * from job_item  ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append(" where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
            query.append(" order by view_seq asc limit ?, ?");            
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
				JobBean pds=new JobBean();
				pds.setSeq(rs.getInt("seq"));			
				pds.setCate_seq(rs.getInt("cate_seq"));
				pds.setCate_L_seq(rs.getInt("cate_L_seq"));
				pds.setCate_M_seq(rs.getInt("cate_M_seq"));			
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

				list.add(pds);			
			}while(rs.next());
			return list;
		}else{
			return Collections.EMPTY_LIST;
		}		
	}catch (SQLException ex){
		throw new MgrException("selectList()!!!", ex);
	}finally{
		if(rs !=null) try{rs.close();}catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();}catch(SQLException ex){}
		if(conn !=null) try{conn.close();}catch(SQLException ex){}
	}
}

/*user page 아이템 타이틀 불러오기*/
public List selectItemTitle(int mseq) throws MgrException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
			"select * from job_item where view_yn=1 and cate_M_seq=? order by view_seq asc " );
            pstmt.setInt(1,mseq);			
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    JobBean pds=new JobBean();           
					pds.setSeq(rs.getInt("seq"));			
					pds.setCate_seq(rs.getInt("cate_seq"));
					pds.setCate_L_seq(rs.getInt("cate_L_seq"));
					pds.setCate_M_seq(rs.getInt("cate_M_seq"));			
					pds.setTitle(rs.getString("title"));
					pds.setView_yn(rs.getInt("view_yn"));
					pds.setView_seq(rs.getInt("view_seq"));
					
					list.add(pds);
                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MgrException("select item", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

/**지정한 글 불러오기**/
public JobBean getInfo(int mseq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		JobBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from job_item where cate_M_seq=?");
		pstmt.setInt(1, mseq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new JobBean();

			pds.setSeq(rs.getInt("seq"));			
			pds.setCate_seq(rs.getInt("cate_seq"));
			pds.setCate_L_seq(rs.getInt("cate_L_seq"));
			pds.setCate_M_seq(rs.getInt("cate_M_seq"));			
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

			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new MgrException("getInfo()", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}

/**지정한 글 불러오기**/
public JobBean getJobItem(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	Reader reader = null;        
	try{
		JobBean pds=null;
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("select * from job_item where seq=?");
		pstmt.setInt(1, seq);
		rs=pstmt.executeQuery();
		if (rs.next()){
			pds=new JobBean();

			pds.setSeq(rs.getInt("seq"));			
			pds.setCate_seq(rs.getInt("cate_seq"));
			pds.setCate_L_seq(rs.getInt("cate_L_seq"));
			pds.setCate_M_seq(rs.getInt("cate_M_seq"));			
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

			return pds;
		}else{return null;}		
	}catch (SQLException ex){
		throw new MgrException("getInfo()", ex);
	}finally{
		if(rs !=null) try{rs.close();} catch(SQLException ex){}
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}

public void delete(int seq) throws MgrException{
	Connection conn=null;
	PreparedStatement pstmt=null;	
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement("delete from job_item where seq=?  ");
		pstmt.setInt(1, seq);
		pstmt.executeUpdate();		

	}catch (SQLException ex){
		throw new MgrException("delete()", ex);
	}finally{		
		if(pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}


}
