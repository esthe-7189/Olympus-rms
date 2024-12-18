package mira.kaigi;

/**
 * MemberManager의 각 메소드가 처리 과정에서
 * 문제가 있을 때 발생시키는 예외
 */
public class MemberManagerException extends Exception {

    public MemberManagerException(String message) {
        super(message);
    }
    
    public MemberManagerException(String message, Throwable cause) {
        super(message, cause);
    }
}