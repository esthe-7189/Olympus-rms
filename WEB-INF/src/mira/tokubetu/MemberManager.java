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
            member.setMseq(Sequencer.nextId(conn,"membertoku"));		
            pstmt = conn.prepareStatement(
            	"insert into membertoku values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getMseq()); 
			pstmt.setString(2, member.getMember_id()); 
            pstmt.setString(3, member.getMail_address());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getPassword());	
			pstmt.setString(6, member.getNm());
			pstmt.setString(7, member.getHurigana());
            pstmt.setTimestamp(8, member.getRegister());
			pstmt.setString(9,member.getZip());
			pstmt.setString(10,member.getAddress());
			pstmt.setString(11,member.getSex());
			pstmt.setString(12,member.getBir_day());
			pstmt.setString(13,member.getPosition());			
			pstmt.setString(14,member.getHimithu_1());
			pstmt.setString(15,member.getHimithu_2());			
			pstmt.setInt(16,member.getMember_yn());  
			pstmt.setString(17,member.getIp_info());
			pstmt.setInt(18,member.getLevel());
			pstmt.setInt(19,member.getPosition_level());
            
            pstmt.executeUpdate();
        } catch(SQLException ex) {
            throw new MemberManagerException("insertmembertoku", ex);
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
            	"select * from membertoku where member_id = ?");
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Member member = new Member();
				member.setMseq(rs.getInt("mseq"));
				member.setMember_id(rs.getString("member_id"));
                member.setMail_address(rs.getString("mail_address"));
				member.setTel(rs.getString("tel"));
				member.setPassword(rs.getString("password"));	
				member.setNm(rs.getString("nm"));	
				member.setHurigana(rs.getString("hurigana"));	
				member.setRegister(rs.getTimestamp("register"));   
				member.setZip(rs.getString("zip"));	
				member.setAddress(rs.getString("address"));	
				member.setSex(rs.getString("sex"));	
				member.setBir_day(rs.getString("bir_day"));	
				member.setPosition(rs.getString("position"));					
				member.setHimithu_1(rs.getString("himithu_1"));	
				member.setHimithu_2(rs.getString("himithu_2"));					
				member.setMember_yn(rs.getInt("member_yn"));
				member.setIp_info(rs.getString("ip_info"));
				member.setLevel(rs.getInt("level"));
				member.setPosition_level(rs.getInt("position_level"));	
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getmembertoku", ex);
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
            "update membertoku set  member_id=?, mail_address=?, tel=?,password=?,nm=?, "+
			"hurigana=?,zip=?,address=? ,sex=?,bir_day=?,position=?, himithu_1=?,himithu_2=?, member_yn=?, ip_info=?,position_level=?  "+			
			"where mseq=?");  
			
            pstmt.setString(1, member.getMember_id());
			pstmt.setString(2, member.getMail_address());
			pstmt.setString(3, member.getTel());
			pstmt.setString(4, member.getPassword());
			pstmt.setString(5, member.getNm());
			pstmt.setString(6, member.getHurigana());
			pstmt.setString(7, member.getZip());
			pstmt.setString(8, member.getAddress());
			pstmt.setString(9, member.getSex());
			pstmt.setString(10, member.getBir_day());
			pstmt.setString(11, member.getPosition());
			pstmt.setString(12, member.getHimithu_1());
			pstmt.setString(13, member.getHimithu_2());	
			pstmt.setInt(14, member.getMember_yn());
			pstmt.setString(15, member.getIp_info());
			pstmt.setInt(16, member.getPosition_level());
			pstmt.setInt(17, member.getMseq());

            
            int result = pstmt.executeUpdate();
            if (result == 0) {
                throw new MemberManagerException("存在してない IDです");
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("updatemembertoku", ex);
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
            	"delete from membertoku where mseq=?");
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
public Member getDbMseq(int mseq)  throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
            	"select * from membertoku where mseq = ?");
            pstmt.setInt(1, mseq);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Member member = new Member();
				 member.setMseq(rs.getInt("mseq"));
					member.setMember_id(rs.getString("member_id"));
					member.setMail_address(rs.getString("mail_address"));
					member.setTel(rs.getString("tel"));
					member.setPassword(rs.getString("password"));	
					member.setNm(rs.getString("nm"));	
					member.setHurigana(rs.getString("hurigana"));	
					member.setRegister(rs.getTimestamp("register"));   
					member.setZip(rs.getString("zip"));	
					member.setAddress(rs.getString("address"));	
					member.setSex(rs.getString("sex"));	
					member.setBir_day(rs.getString("bir_day"));	
					member.setPosition(rs.getString("position"));					
					member.setHimithu_1(rs.getString("himithu_1"));	
					member.setHimithu_2(rs.getString("himithu_2"));					
					member.setMember_yn(rs.getInt("member_yn"));
					member.setIp_info(rs.getString("ip_info"));
					member.setLevel(rs.getInt("level"));
					member.setPosition_level(rs.getInt("position_level"));
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getDbMseq", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
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
            pstmt = conn.prepareStatement("select * from membertoku  where mseq = ?");
            pstmt.setInt(1, mseq); 
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				member= new Member();
                member.setMseq(rs.getInt("mseq"));
                member.setNm ( rs.getString("nm"));                 
				
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
                "select password from membertoku  where member_id = ?");
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
            	"select  member_id  from membertoku  where member_id = ?");
            pstmt.setString(1, member_id);
			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Member member = new Member();                
				member.setMember_id(rs.getString("member_id"));								
                
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

//승인받은 회원인지 확인  member_yn=2일경우 승인됨
	public Member adminUse(String member_id)   throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
            	"select  member_yn  from membertoku  where member_id = ?");
            pstmt.setString(1, member_id);
			
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Member member = new Member();                
				member.setMember_yn(rs.getInt("member_yn"));								
                
                return member;
            } else {
                // 존재하지 않으면 null을 리턴한다.
                return null;
            }
        } catch(SQLException ex) {
            throw new MemberManagerException("getMember_yn", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
//id password 찿기
public Member idChk(String nm, String himithu_1,String himithu_2) throws MemberManagerException{
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try{
		conn=DBUtil.getConnection(POOLNAME);
		pstmt=conn.prepareStatement(
			"select member_id,password  from membertoku where nm=? and himithu_1=? and himithu_2=?  ");
		pstmt.setString(1, nm);
		pstmt.setString(2, himithu_1);		
		pstmt.setString(3, himithu_2);		
		rs=pstmt.executeQuery();
		if (rs.next()){
			Member member=new Member();
			member.setMember_id(rs.getString("member_id"));			
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
			query.append("select count(*) from  membertoku ");
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
        ResultSet rsMessage = null; 
        
        try {
            StringBuffer query = new StringBuffer(200);             
			query.append("select * from membertoku ");
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
            
            rsMessage = pstmtMessage.executeQuery();
            if (rsMessage.next()) {                 
				List list = new java.util.ArrayList(endRow-startRow+1);                 
                do {
                    Member  member = new  Member();										
                    member.setMseq(rsMessage.getInt("mseq"));
					member.setMember_id(rsMessage.getString("member_id"));
					member.setMail_address(rsMessage.getString("mail_address"));
					member.setTel(rsMessage.getString("tel"));
					member.setPassword(rsMessage.getString("password"));	
					member.setNm(rsMessage.getString("nm"));	
					member.setHurigana(rsMessage.getString("hurigana"));	
					member.setRegister(rsMessage.getTimestamp("register"));   
					member.setZip(rsMessage.getString("zip"));	
					member.setAddress(rsMessage.getString("address"));	
					member.setSex(rsMessage.getString("sex"));	
					member.setBir_day(rsMessage.getString("bir_day"));	
					member.setPosition(rsMessage.getString("position"));					
					member.setHimithu_1(rsMessage.getString("himithu_1"));	
					member.setHimithu_2(rsMessage.getString("himithu_2"));					
					member.setMember_yn(rsMessage.getInt("member_yn"));
					member.setIp_info(rsMessage.getString("ip_info"));
					member.setLevel(rsMessage.getInt("level"));
					member.setPosition_level(rsMessage.getInt("position_level"));

                    list.add(member);
                } while(rsMessage.next());
                
                return list;
                
            } else {
                return Collections.EMPTY_LIST;
            }
            
        } catch(SQLException ex) {
            throw new MemberManagerException("selectList", ex);
        } finally { 
			if (rsMessage != null)
				try { rsMessage.close(); } catch(SQLException ex) {} 
            if (pstmtMessage != null) 
                try { pstmtMessage.close(); } catch(SQLException ex) {} 
            if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {} 
        }
    }
    
//회원승인
public void memberYn(int mseq, int member_yn) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("update membertoku set member_yn=?  where mseq=?");            
			pstmt.setInt(1, member_yn);
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
//레벨변경
public void levelChange(int mseq, int level) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("update membertoku set level=?  where mseq=?");            
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
//comment 패스워드 체크
   public int checkPass(int mseq, String password) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection(POOLNAME);
            
            pstmt = conn.prepareStatement(
                "select password from membertoku where mseq=?");
            pstmt.setInt(1, mseq);
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
            throw new MemberManagerException("checkPass", ex);
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
//직원 레벨변경
public void levelPosiChange(int mseq, int level) throws MemberManagerException {
        Connection conn = null;
        PreparedStatement pstmt = null;        
        try {
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement("update membertoku set position_level=?  where mseq=?");            
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
public List selectListSchedule(int beginNo, int endNo) throws MemberManagerException {
        Connection conn = null;        
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        try {            
            conn = DBUtil.getConnection(POOLNAME);            
            pstmt = conn.prepareStatement(
				"select * from membertoku where (position_level between ? and ? ) and (member_yn=2) order by position_level asc" ); 
			pstmt.setInt(1, beginNo);
			pstmt.setInt(2, endNo);
			rs = pstmt.executeQuery();
            if (rs.next()) {   
				List list = new java.util.ArrayList();
                do {                   
                    Member  member = new  Member();										
                    member.setMseq(rs.getInt("mseq"));
					member.setMember_id(rs.getString("member_id"));
					member.setMail_address(rs.getString("mail_address"));
					member.setTel(rs.getString("tel"));
					member.setPassword(rs.getString("password"));	
					member.setNm(rs.getString("nm"));	
					member.setHurigana(rs.getString("hurigana"));	
					member.setRegister(rs.getTimestamp("register"));   
					member.setZip(rs.getString("zip"));	
					member.setAddress(rs.getString("address"));	
					member.setSex(rs.getString("sex"));	
					member.setBir_day(rs.getString("bir_day"));	
					member.setPosition(rs.getString("position"));					
					member.setHimithu_1(rs.getString("himithu_1"));	
					member.setHimithu_2(rs.getString("himithu_2"));					
					member.setMember_yn(rs.getInt("member_yn"));
					member.setIp_info(rs.getString("ip_info"));
					member.setLevel(rs.getInt("level"));
					member.setPosition_level(rs.getInt("position_level"));
					list.add(member);

                }while(rs.next());
                return list;                  
			}else{
				 return java.util.Collections.EMPTY_LIST;
			}
        } catch(SQLException ex) {
            throw new MemberManagerException("selectListSchedule", ex);
        } finally {             
			if (rs != null)                  
				try { rs.close(); } catch(SQLException ex) {} 
            if (pstmt != null) 
                try { pstmt.close(); } catch(SQLException ex) {}            
            if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
        }
    }
}