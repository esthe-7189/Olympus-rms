package mira.board;

/**
 * ThemeManager가 메소드를 수행하는 도중
 * 문제가 있을 때 발생하는 예외 클래스.
 */
public class BoardMgrException extends Throwable {
    public BoardMgrException(String msg) {
        super(msg);
    }
    public BoardMgrException(String msg, Throwable cause) {
        super(msg, cause);
    }
    
}
