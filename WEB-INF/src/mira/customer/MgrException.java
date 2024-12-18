package mira.customer;

/**
 *Manager가 메소드를 수행하는 도중
 * 문제가 있을 때 발생하는 예외 클래스.
 */
public class MgrException extends Throwable {
    public MgrException(String msg) {
        super(msg);
    }
    public MgrException(String msg, Throwable cause) {
        super(msg, cause);
    }
    
}
