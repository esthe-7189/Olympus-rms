package mira.contract;

import java.sql.Timestamp;

public class ContractBeen {
    private int seq,bseq, mseq,sekining_mseq;
    private int groupId;
    private int orderNo;
    private int level;
    private int parentId;
    private Timestamp register;
    private String name,ip_add,nm;
    private String mail_address;    
    private String kanri_no;
	private String sekining_nm,date_begin,date_end,comment,kubun;
	private String contract_kind,content,contact,title,hizuke,renewal,file_nm;
	private int renewal_yn,seq_contract,seq_mem;     


   public int getSeq() {return seq;}
	public void setSeq(int value) {seq = value;}
   
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
	public int getOrderNo() {
        return orderNo;
    }
    public String getName() {
        return name;
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

	
	public int getSekining_mseq() {
        return sekining_mseq;
    }
	public void setSekining_mseq(int value) {
        sekining_mseq = value;
    }					

	public String getSekining_nm() {
        return sekining_nm;
    }
	public void setSekining_nm(String value) {
        sekining_nm = value;
    }

	public String getDate_begin(){
		return date_begin;
	}
	public void setDate_begin(String value){
		date_begin=value;
	}

	public String getDate_end(){
		return date_end;
	}
	public void setDate_end(String value){
		date_end=value;
	}	

	public String getComment(){
		return comment;
	}
	public void setComment(String value){
		comment=value;
	}

	public String getKubun(){
		return kubun;
	}
	public void setKubun(String value){
		kubun=value;
	}

	public int getRenewal_yn(){
		return renewal_yn;
	}
	public void setRenewal_yn(int value){
		renewal_yn=value;
	}

	
	public String getContract_kind(){
		return contract_kind;
	}
	public void setContract_kind(String value){
		contract_kind=value;
	}

	public String getContent(){
		return content;
	}
	public void setContent(String value){
		content=value;
	}

	public String getContact(){
		return contact;
	}
	public void setContact(String value){
		contact=value;
	}

	public String getTitle(){
		return title;
	}
	public void setTitle(String value){
		title=value;
	}

	public String getHizuke(){
		return hizuke;
	}
	public void setHizuke(String value){
		hizuke=value;
	}

	public String getRenewal(){
		return renewal;
	}
	public void setRenewal(String value){
		renewal=value;
	}


	public String getFile_nm(){
		return file_nm;
	}
	public void setFile_nm(String value){
		file_nm=value;
	}



public String getIp_add() { return ip_add;}
public void setIp_add(String ip_add) {this.ip_add = ip_add;}

public int getSeq_contract() {return seq_contract;}
public void setSeq_contract(int value) {seq_contract = value;}

public int getSeq_mem() {return seq_mem;}
public void setSeq_mem(int value) {seq_mem = value;}
}