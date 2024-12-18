package mira.payment;

import java.sql.Timestamp;

public class Category {
    private int seq,cseq,mseq;       
    private String name,client_nm;	
	private String comment,pay_kikan,pay_day,sinsei_day,post_send_day;
	private Timestamp register;
	private int renewal_yn,client,price,receive_yn_sinsei,receive_yn_ot,receive_yn_tokyo,shori_yn,pay_type,pj_yn;
	


	public int getSeq() { return seq;}
	public void setSeq(int value) {seq = value; }	

	public int getCseq() { return cseq;}
	public void setCseq(int value) {cseq = value; }
	
	public Timestamp getRegister() {return register;}
	public void setRegister(Timestamp value) {register = value;}

	public int getMseq() { return mseq;}
	public void setMseq(int value) {mseq = value; }
	
	public String getName() {return name;}
	public void setName(String value) {name = value;}

	public int getRenewal_yn() { return renewal_yn;}
	public void setRenewal_yn(int value) {renewal_yn = value; }		
	
	public String getComment() {return comment;}
	public void setComment(String value) {comment = value;}	

	public int getClient() { return client;}
	public void setClient(int value) {client = value; }	

	public String getPay_kikan() {return pay_kikan;}
	public void setPay_kikan(String value) {pay_kikan = value;}	
	
	public String getPay_day() {return pay_day;}
	public void setPay_day(String value) {pay_day = value;}	
	
	public String getSinsei_day() {return sinsei_day;}
	public void setSinsei_day(String value) {sinsei_day = value;}	
	
	public String getPost_send_day() {return post_send_day;}
	public void setPost_send_day(String value) {post_send_day = value;}

	public String getClient_nm() {return client_nm;}
	public void setClient_nm(String value) {client_nm = value;}
	
	public int getPrice() { return price;}
	public void setPrice(int value) {price = value; }	

	public int getReceive_yn_sinsei() { return receive_yn_sinsei;}
	public void setReceive_yn_sinsei(int value) {receive_yn_sinsei = value; }	

	public int getReceive_yn_ot() { return receive_yn_ot;}
	public void setReceive_yn_ot(int value) {receive_yn_ot = value; }	

	public int getReceive_yn_tokyo() { return receive_yn_tokyo;}
	public void setReceive_yn_tokyo(int value) {receive_yn_tokyo = value; }

	public int getShori_yn() { return shori_yn;}
	public void setShori_yn(int value) {shori_yn = value; }	

	public int getPay_type() { return pay_type;}
	public void setPay_type(int value) {pay_type = value; }	

	public int getPj_yn() { return pj_yn;}
	public void setPj_yn(int value) {pj_yn = value; }	

	

	

}