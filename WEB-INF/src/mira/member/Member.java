package mira.member;

import java.sql.Timestamp;

/**
 * 회원 정보를 저장할 때 사용되는 자바빈
 */
public class Member {
	private int mseq,member_yn,level,position_level;
    private String mail_address,tel, member_id,em_number;
	private String password;    
	private String nm,hurigana;    
    private Timestamp register;
	private String zip;
	private String address;
	private String sex;
	private String bir_day;
	private String position,busho;	
	private String himithu_1;
	private String himithu_2, ip_info,mcode,mimg;
	
	
	public int getMseq() {
        return mseq;
    }
    public void setMseq(int mseq) {
        this.mseq = mseq;
    }    
    public String getMail_address() {
        return mail_address;
    }
    public void setMail_address(String mail_address) {
        this.mail_address = mail_address;
    }
	public String getTel() {
        return tel;
    }
    public void setTel(String tel) {
        this.tel = tel;
    }

	public String getMember_id() {
        return member_id;
    }
    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

	public String getEm_number() {
        return em_number;
    }
    public void setEm_number(String em_number) {
        this.em_number = em_number;
    }

	public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }    

	public String getNm() {
        return nm;
    }
    public void setNm(String nm) {
        this.nm = nm ;
    }  
	
	public String getHurigana() {
        return hurigana;
    }
    public void setHurigana(String hurigana) {
        this.hurigana = hurigana ;
    }   
       
    public Timestamp getRegister() {
        return register;
    }
    public void setRegister(Timestamp register) {
        this.register = register;
    } 
	
	public String getZip(){
		return zip;
	}
	public void setZip(String zip){
		this.zip=zip;
	}

	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address=address;
	}

	public String getSex(){
		return sex;
	}
	public void setSex(String sex){
		this.sex=sex;
	}

	public String getBir_day(){
		return bir_day;
	}
	public void setBir_day(String bir_day){
		this.bir_day=bir_day;
	}

	public String getPosition(){
		return position;
	}
	public void setPosition(String position){
		this.position=position;
	}

	public String getHimithu_1(){
		return himithu_1;
	}
	public void setHimithu_1(String himithu_1){
		this.himithu_1=himithu_1;
	}

	public String getHimithu_2(){
		return himithu_2;
	}
	public void setHimithu_2(String himithu_2){
		this.himithu_2=himithu_2;
	}
    
	public int getMember_yn() {
        return member_yn;
    }
    public void setMember_yn(int member_yn) {
        this.member_yn = member_yn;
    }    

	public int getLevel() {
        return level;
    }
    public void setLevel(int level) {
        this.level = level;
    }   

	public int getPosition_level() {
        return position_level;
    }
    public void setPosition_level(int position_level) {
        this.position_level = position_level;
    }  
	
	public String getBusho() {
        return busho;
    }
    public void setBusho(String busho) {
        this.busho = busho;
    }    
	
	public String getIp_info() {
        return ip_info;
    }
    public void setIp_info(String ip_info) {
        this.ip_info = ip_info;
    }    

	public String getMcode() {
        return mcode;
    }
    public void setMcode(String mcode) {
        this.mcode = mcode;
    }    

	public String getMimg() {
        return mimg;
    }
    public void setMimg(String mimg) {
        this.mimg = mimg;
    }    

	
}

