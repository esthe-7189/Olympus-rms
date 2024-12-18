package mira.memberuser;

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

public class MemberManager {
    private static MemberManager instance = new MemberManager();
    
    public static MemberManager getInstance() {
        return instance;
    }
    
    private MemberManager() {}    
   private static String POOLNAME = "pool";   

 //*********************user***************************   
    public void insertMember(Member member)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
			 // 새로운 회원의 번호를 구한다.
            member.setMseq(Sequencer.nextId(conn,"member_user"));		
            pstmt = conn.prepareStatement( "insert into member_user values (?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getMseq()); 
			pstmt.setString(2, member.getMail_address());	
			pstmt.setString(3, member.getPassword());	
			pstmt.setString(4, member.getName1());
			pstmt.setString(5, member.getName2());
            pstmt.setTimestamp(6, member.getRegister());
            pstmt.setString(7, member.getKuni());
			pstmt.setString(8,member.getSex());	
			pstmt.setInt(9,member.getAge()); 
			pstmt.setString(10,member.getIp_info());
			pstmt.setInt(11,member.getLevel()); 
			pstmt.setInt(12,member.getNews_yn());
            
            pstmt.executeUpdate();
        } catch(SQLException ex) {
            throw new MemberManagerException("insertMember", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    public Member getMember(String member_id)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * from member_user where mail_address = ?");
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Member member = new Member();
				member.setMseq(rs.getInt("mseq"));				
                member.setMail_address(rs.getString("mail_address"));				
				member.setPassword(rs.getString("password"));	
				member.setName1(rs.getString("name_1"));	
				member.setName2(rs.getString("name_2"));	
				member.setRegister(rs.getTimestamp("register"));   
				member.setKuni(rs.getString("kuni"));				
				member.setSex(rs.getString("sex"));	
				member.setAge(rs.getInt("age"));					
				member.setIp_info(rs.getString("ip_info"));
				member.setLevel(rs.getInt("level"));
				member.setNews_yn(rs.getInt("news_yn"));
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getMember", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }	
    
    public void updateMember(Member member) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
            "update member_user set  mail_address=?, password=?,name_1=?,name_2=?, "+
			"kuni=?, sex=?,age=?, ip_info=?, level=?, news_yn=? where mseq=?");			       
            
			pstmt.setString(1, member.getMail_address());	
			pstmt.setString(2, member.getPassword());	
			pstmt.setString(3, member.getName1());
			pstmt.setString(4, member.getName2());          
            pstmt.setString(5, member.getKuni());
			pstmt.setString(6,member.getSex());	
			pstmt.setInt(7,member.getAge()); 
			pstmt.setString(8,member.getIp_info());
			pstmt.setInt(9,member.getLevel()); 
			pstmt.setInt(10, member.getNews_yn());          
			pstmt.setInt(11, member.getMseq());          
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("updateMember", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    public void deleteMember(int mseq)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
            	"delete from member_user where	mseq=?");
            pstmt.setInt(1, mseq);
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです.");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("deleteMember", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

	 public Member  delSelect(int mseq) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;  
        
        try {
            Member  member = null; 
            
            conn = DBUtil.getConnection(POOLNAME);
            pstmt = conn.prepareStatement("select * from member_user  where mseq = ?");
            pstmt.setInt(1, mseq); 
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				member= new Member();
                member.setMseq(rs.getInt("mseq"));
                member.setName1 ( rs.getString("name_1"));   
                member.setName2 ( rs.getString("name_2"));   
				
				return member;
            } else {  return null;   }
          
        } catch(SQLException ex) {
            throw new MemberManagerException("select", ex);
        } finally {             
			if (rs != null)  try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null)  try { pstmt.close(); } catch(SQLException ex) {}             
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
    public int checkAuth(String member_id, String password)
    throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select password from member_user  where mail_address = ?");
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("password");
                
                if (dbPassword.compareTo(password) == 0) {
                    // 암호가 같으면 1을 리턴
                    return 1;
                } else {
                    // 암호가 다르면 0을 리턴
                    return 0;
                }
            } else {
                // 아이디 존재하지 않음 -1
                return -1;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getMember", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

	public Member idCh(String member_id)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
            	"select  mail_address from member_user where mail_address = ?");
            pstmt.setString(1, member_id);
			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Member member = new Member();                
				member.setMail_address(rs.getString("mail_address"));								
                
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getMemberId", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }


//id password 찿기
public Member idChk(String mail_address) throws MemberManagerException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement(
			"select mail_address,password  from member_user where mail_address=? ");
		pstmt.setString(1, mail_address);
		
		rs=pstmt.executeQuery();
		if (rs.next()){
			Member member=new Member();
			member.setMail_address(rs.getString("mail_address"));			
			member.setPassword(rs.getString("password"));
			return member;
		}else{return null;}
	}catch (SQLException ex){
		throw new MemberManagerException("id search",ex);
	}finally{
		if (rs !=null) try{rs.close();} catch(SQLException ex){}
		if (pstmt !=null) try{pstmt.close();} catch(SQLException ex){}
		if (conn !=null) try{conn.close();} catch(SQLException ex){}
	}
}


// 등록된 글의 개수를 구한다.    
	public int count(List whereCond, Map valueMap) throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmt = null;         
		ResultSet rs = null;
        
        try {
             conn = DBUtil.getConnection(POOLNAME);
            StringBuffer query = new StringBuffer(200);             
			query.append("select count(*) from  member_user ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
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
            throw new MemberManagerException("count", ex);
        } finally { if (rs != null) try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {} 
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }

   /** * 목록을 읽어온다.  */     
	public List selectList(List whereCond, Map valueMap, int startRow, int endRow)
    throws MemberManagerException {
        if (valueMap == null) valueMap = Collections.EMPTY_MAP; 
        
        Connection conn = null;         
		PreparedStatement pstmtMessage = null;
        ResultSet rs = null; 
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from member_user ");
            if (whereCond != null && whereCond.size() > 0) {
                query.append("where ");                
				for (int i = 0 ; i < whereCond.size() ; i++) {
                       query.append(whereCond.get(i));                     
						if (i < whereCond.size() -1 ) {                         
						   query.append(" or ");
                    }
                }
            }
              
			query.append(" order by mseq desc  limit ?, ?");
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
            
            pstmtMessage.setInt(valueMap.size()+1, startRow);
            pstmtMessage.setInt(valueMap.size()+2, endRow-startRow+1);
            
            rs = pstmtMessage.executeQuery();
            if (rs.next()) {                 
				List list = new java.util.ArrayList(endRow-startRow+1);                 
                do {
                    Member  member = new  Member();
                    
                    member.setMseq(rs.getInt("mseq"));				
                    member.setMail_address(rs.getString("mail_address"));				
    				member.setPassword(rs.getString("password"));	
    				member.setName1(rs.getString("name_1"));	
    				member.setName2(rs.getString("name_2"));	
    				member.setRegister(rs.getTimestamp("register"));   
    				member.setKuni(rs.getString("kuni"));				
    				member.setSex(rs.getString("sex"));	
    				member.setAge(rs.getInt("age"));					
    				member.setIp_info(rs.getString("ip_info"));
    				member.setLevel(rs.getInt("level"));
                    
                    list.add(member);
                } while(rs.next());
                
                return list;
                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally { 
			if (rs != null)
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
//직원 어드민 승인 level=1은 관리자, 2=직원, 3=일반회원
//레벨변경
public void levelChange(int mseq, int level) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("update member_user set level=?  where mseq=?");            
			pstmt.setInt(1, level);
			pstmt.setInt(2, mseq);		
            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("ID was not in DB !!");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("ID was not in DB !!", ex);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
}