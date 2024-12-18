package mira.memberuser;

import java.sql.Timestamp;

/**
 * 회원 정보를 저장할 때 사용되는 자바빈
 */
public class Member {
	private int mseq,level,age,news_yn;
    private String mail_address;
	private String password,kuni;    
	private String name1 ,name2;    
    private Timestamp register;	
	private String sex;	
	private String ip_info;
	
	
	public int getMseq() {
        return mseq;
    }
    public void setMseq(int mseq) {
        this.mseq = mseq;
    }    
    
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }   
    
    public int getNews_yn() {
        return news_yn;
    }
    public void setNews_yn(int news_yn) {
        this.news_yn = news_yn;
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
	
	public String getSex(){
		return sex;
	}
	public void setSex(String sex){
		this.sex=sex;
	}

	
	public int getLevel() {
        return level;
    }
    public void setLevel(int level) {
        this.level = level;
    }   

		
	public String getIp_info() {
        return ip_info;
    }
    public void setIp_info(String ip_info) {
        this.ip_info = ip_info;
    }    

	
}

