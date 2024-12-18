package mira.product;

/**
 * MemberManager의 각 메소드가 처리 과정에서
 * 문제가 있을 때 발생시키는 예외
 */
public class ProductManagerException extends Exception {

    public ProductManagerException(String message) {
        super(message);
    }
    
    public ProductManagerException(String message, Throwable cause) {
        super(message, cause);
    }
}