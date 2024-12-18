package mira.info;

import java.sql.Timestamp;

public class InfoBean {
    private int seq;
    private int cate_seq;  //item의 category 번호
	private int cate_L_seq;   //대분류 번호
	private int cate_M_seq;   //중분류 번호 
	private String title;
	private String content;
	private Timestamp register;
	private int view_yn, view_seq;
   

    public int getSeq() {
        return seq;
    }
	public void setSeq(int value) {
        seq = value;
    }    

	public int getCate_seq() {
        return cate_seq;
    }
	public void setCate_seq(int value) {
        cate_seq = value;
    }

	public int getCate_L_seq() {
        return cate_L_seq;
    }
	public void setCate_L_seq(int value) {
        cate_L_seq = value;
    }
	
	public int getCate_M_seq() {
        return cate_M_seq;
    }
	public void setCate_M_seq(int value) {
        cate_M_seq = value;
    }

	public String getTitle() {
        return title;
    }
	public void setTitle(String value) {
        title = value;
    }
	
	public String getContent() {
        return content;
    }
	public void setContent(String value) {
        content = value;
    }	

	public Timestamp getRegister() {
        return register;
    }
	 public void setRegister(Timestamp value) {
        register = value;
    }


	public int getView_yn() {
        return view_yn;
    }
	public void setView_yn(int value) {
        view_yn = value;
    }	

	public int getView_seq() {
        return view_seq;
    }
	public void setView_seq(int value) {
        view_seq = value;
    }	


}