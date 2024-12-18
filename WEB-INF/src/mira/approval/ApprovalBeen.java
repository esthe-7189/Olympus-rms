package mira.approval;

import java.sql.Timestamp;

public class ApprovalBeen {
    private int bseq, mseq,genan_mseq,gian_mseq;    
    private Timestamp register;
    private String name,cate;
    private String mail_address;    
    private String kanri_no;
	private String date_submit,date_sign,comment;
	private String title,file_nm;
	


   public String getMail_address() {
        return mail_address;
    }    
    public int getBseq() {
        return bseq;
    }   
    
    public String getName() {
        return name;
    }   
    
    public String getKanri_no() {
        return kanri_no;
    }
    public Timestamp getRegister() {
        return register;
    }    
	public int getMseq() {
        return mseq;
    }
	
    
	public void setMail_address(String value) {
        mail_address = value;
    }
    
    public void setBseq(int value) {
        bseq = value;
    }
       
    public void setName(String value) {
        name = value;
    }
    
    public void setKanri_no(String value) {
        kanri_no = value;
    }
    public void setRegister(Timestamp value) {
        register = value;
    }   
	public void setMseq(int value) {
        mseq = value;
    }

	
	public int getGenan_mseq() {
        return genan_mseq;
    }
	public void setGenan_mseq(int value) {
        genan_mseq = value;
    }	
	public int getGian_mseq() {
        return gian_mseq;
    }
	public void setGian_mseq(int value) {
        gian_mseq = value;
    }

	public String getDate_submit(){
		return date_submit;
	}
	public void setDate_submit(String value){
		date_submit=value;
	}

	public String getDate_sign(){
		return date_sign;
	}
	public void setDate_sign(String value){
		date_sign=value;
	}	

	public String getComment(){
		return comment;
	}
	public void setComment(String value){
		comment=value;
	}

	public String getCate(){
		return cate;
	}
	public void setCate(String value){
		cate=value;
	}

	
	public String getTitle(){
		return title;
	}
	public void setTitle(String value){
		title=value;
	}

	
	public String getFile_nm(){
		return file_nm;
	}
	public void setFile_nm(String value){
		file_nm=value;
	}

}