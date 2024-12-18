package mira.form;

import java.sql.Timestamp;

public class FormBeen {
    private int bseq, mseq;    
    private Timestamp register;
    private String name;        
	private String filenm,title;
	
    public int getBseq() {
        return bseq;
    } 
	public void setBseq(int value) {
        bseq = value;
    }   


    public String getName() {
        return name;
    }   
	public void setName(String value) {
        name = value;
    }


	public int getMseq() {
        return mseq;
    }  
	public void setMseq(int value) {
        mseq = value;
    }	


	public String getFilenm(){
		return filenm;
	}
	public void setFilenm(String value){
		filenm=value;
	}

	public String getTitle(){
		return title;
	}
	public void setTitle(String value){
		title=value;
	}

	public Timestamp getRegister() {
        return register;
    }
	public void setRegister(Timestamp value) {
        register = value;
    }
}