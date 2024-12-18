package mira.sequence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 각 테이블에서 키값으로 사용하는
 * 일련 번호를 구해주는 클래스.
 */
public class Sequencer {
    public synchronized static int nextId(Connection conn, String tableName) 
    throws SQLException {
        PreparedStatement pstmtSelect = null;
        ResultSet rsSelect = null;
        
        PreparedStatement pstmtUpdate = null;
        
        try {
            pstmtSelect = conn.prepareStatement(
            "select seqno from  id_seq  where seqnm = ?");
            pstmtSelect.setString(1, tableName);
            
            rsSelect = pstmtSelect.executeQuery();
            
            if (rsSelect.next()) {
                int id = rsSelect.getInt(1);
                id++;
                
                pstmtUpdate = conn.prepareStatement(
                  "update id_seq  set seqno = ? "+
                  "where seqnm = ?");
                pstmtUpdate.setInt(1, id);
                pstmtUpdate.setString(2, tableName);
                pstmtUpdate.executeUpdate();
                
                return id;
                
            } else {
                pstmtUpdate = conn.prepareStatement(
                "insert into id_seq  values (?, ?)");
                pstmtUpdate.setString(1, tableName);
                pstmtUpdate.setInt(2, 1);
                pstmtUpdate.executeUpdate();
                
                return 1;
            }
        } finally {
            if (rsSelect != null) 
                try { rsSelect.close(); } catch(SQLException ex) {}
            if (pstmtSelect != null) 
                try { pstmtSelect.close(); } catch(SQLException ex) {}
            if (pstmtUpdate != null) 
                try { pstmtUpdate.close(); } catch(SQLException ex) {}
        }
    }
}
