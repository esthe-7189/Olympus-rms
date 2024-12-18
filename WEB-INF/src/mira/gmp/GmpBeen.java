package mira.gmp;

import java.sql.Timestamp;

public class GmpBeen {
    private int bseq, mseq,mseq2;
    private int groupId;
    private int orderNo;
    private int level;
    private int parentId;
    private Timestamp register;
    private String name;
    private String mail_address;    
    private String kanri_no,gigi_nm,product_nm,seizomoto,katachi_no,seizo_no;
	private String place,sekining_nm,date01,date02,file_manual,comment;
	private int eda_no,hindo,date01_yn,date02_yn;

        
   public String getMail_address() {
        return mail_address;
    }
    public int getGroupId() {
        return groupId;
    }
    public int getBseq() {
        return bseq;
    }
    
    public int getLevel() {
        return level;
    }
    public String getName() {
        return name;
    }
    public int getOrderNo() {
        return orderNo;
    }
    public int getParentId() {
        return parentId;
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
	public int getMseq2() {
        return mseq2;
    }

    
	public void setMail_address(String value) {
        mail_address = value;
    }
    public void setGroupId(int value) {
        groupId = value;
    }
    public void setBseq(int value) {
        bseq = value;
    }
   
    public void setLevel(int value) {
        level = value;
    }
    public void setName(String value) {
        name = value;
    }
    public void setOrderNo(int value) {
        orderNo = value;
    }
    public void setParentId(int value) {
        parentId = value;
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
	public void setMseq2(int value) {
        mseq2 = value;
    }


	public String getGigi_nm() {
        return gigi_nm;
    }
	public void setGigi_nm(String value) {
        gigi_nm = value;
    }

	public String getProduct_nm() {
        return product_nm;
    }
	public void setProduct_nm(String value) {
        product_nm = value;
    }

	public String getSeizomoto() {
        return seizomoto;
    }
	public void setSeizomoto(String value) {
        seizomoto = value;
    }

	public String getKatachi_no() {
        return katachi_no;
    }
	public void setKatachi_no(String value) {
        katachi_no = value;
    }

	public String getSeizo_no() {
        return seizo_no;
    }
	public void setSeizo_no(String value) {
        seizo_no = value;
    }

	public String getPlace() {
        return place;
    }
	public void setPlace(String value) {
        place = value;
    }


	public String getSekining_nm() {
        return sekining_nm;
    }
	public void setSekining_nm(String value) {
        sekining_nm = value;
    }

	public String getDate01(){
		return date01;
	}
	public void setDate01(String value){
		date01=value;
	}

	public String getDate02(){
		return date02;
	}
	public void setDate02(String value){
		date02=value;
	}

	public String getFile_manual(){
		return file_manual;
	}
	public void setFile_manual(String value){
		file_manual=value;
	}

	public String getComment(){
		return comment;
	}
	public void setComment(String value){
		comment=value;
	}

	public int getEda_no(){
		return eda_no;
	}
	public void setEda_no(int value){
		eda_no=value;
	}

	public int getHindo(){
		return hindo;
	}
	public void setHindo(int value){
		hindo=value;
	}

	public int getDate01_yn(){
		return date01_yn;
	}
	public void setDate01_yn(int value){
		date01_yn=value;
	}

	public int getDate02_yn(){
		return date02_yn;
	}
	public void setDate02_yn(int value){
		date02_yn=value;
	}





}