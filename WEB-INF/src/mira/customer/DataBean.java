package mira.customer;

import java.sql.Timestamp;

public class DataBean {
	private int seq, mseq,answer_yn;
    private String mail_address;
	private String password,kuni;    
	private String name1 ,name2;    
    private Timestamp register;	
	private String comment;	
	private String ip_info;
	
	
	public int getMseq() {
        return mseq;
    }
    public void setMseq(int mseq) {
        this.mseq = mseq;
    }    
    
    public int getSeq() {
        return seq;
    }
    public void setSeq(int seq) {
        this.seq = seq;
    }   
    
    public int getAnswer_yn() {
        return answer_yn;
    }
    public void setAnswer_yn(int answer_yn) {
        this.answer_yn = answer_yn;
    }   
    
    public String getMail_address() {
        return mail_address;
    }
    public void setMail_address(String mail_address) {
        this.mail_address = mail_address;
    }
	
	public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }    
    
    public String getKuni() {
        return kuni;
    }
    public void setKuni(String kuni) {
        this.kuni = kuni;
    } 

	public String getName1() {
        return name1;
    }
    public void setName1(String name1) {
        this.name1 = name1 ;
    }  
    
    public String getName2() {
        return name2;
    }
    public void setName2(String name2) {
        this.name2 = name2 ;
    }  
		       
    public Timestamp getRegister() {
        return register;
    }
    public void setRegister(Timestamp register) {
        this.register = register;
    } 
	
	public String getComment(){
		return comment;
	}
	public void setComment(String comment){
		this.comment=comment;
	}

	

		
	public String getIp_info() {
        return ip_info;
    }
    public void setIp_info(String ip_info) {
        this.ip_info = ip_info;
    }    

	
}

