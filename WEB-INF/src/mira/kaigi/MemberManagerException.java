package mira.kaigi;

/**
 * MemberManager�� �� �޼ҵ尡 ó�� ��������
 * ������ ���� �� �߻���Ű�� ����
 */
public class MemberManagerException extends Exception {

    public MemberManagerException(String message) {
        super(message);
    }
    
    public MemberManagerException(String message, Throwable cause) {
        super(message, cause);
    }
}