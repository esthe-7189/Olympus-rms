package mira.customer;

/**
 *Manager�� �޼ҵ带 �����ϴ� ����
 * ������ ���� �� �߻��ϴ� ���� Ŭ����.
 */
public class MgrException extends Throwable {
    public MgrException(String msg) {
        super(msg);
    }
    public MgrException(String msg, Throwable cause) {
        super(msg, cause);
    }
    
}
