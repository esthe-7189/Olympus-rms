package mira.product;

/**
 * MemberManager�� �� �޼ҵ尡 ó�� ��������
 * ������ ���� �� �߻���Ű�� ����
 */
public class ProductManagerException extends Exception {

    public ProductManagerException(String message) {
        super(message);
    }
    
    public ProductManagerException(String message, Throwable cause) {
        super(message, cause);
    }
}