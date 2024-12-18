package mira.order;

import java.sql.Timestamp;

public class BeanOrderBunsho {
    private int seq,mseq,parent_seq,item_seq, del_yn,get_yn, del_yn_item; 
	private int sign_01, sign_02, sign_03, sign_01_yn, sign_02_yn, sign_03_yn, kind_urgency;
	private String contact_order,comment,hizuke,title; 
    private Timestamp register;	

	private String product_nm, order_no, name,sign_no_riyu_01,sign_no_riyu_02,sign_no_riyu_03; 
	private int product_qty, unit_price, total_price, total_price_all, qty,client_nm;
	
 
public String getSign_no_riyu_01(){return sign_no_riyu_01;}
public void setSign_no_riyu_01(String value){sign_no_riyu_01=value;}

public String getSign_no_riyu_02(){return sign_no_riyu_02;}
public void setSign_no_riyu_02(String value){sign_no_riyu_02=value;}

public String getSign_no_riyu_03(){return sign_no_riyu_03;}
public void setSign_no_riyu_03(String value){sign_no_riyu_03=value;}

public int  getSeq(){
	return seq;
}
public  void setSeq(int value){
	seq=value;
}
public int  getMseq(){
	return mseq;
}
public  void setMseq(int value){
	mseq=value;
}

public int getParent_seq(){
	return parent_seq;
}
public void setParent_seq(int value){
	parent_seq=value;
}

public int getItem_seq(){
	return item_seq;
}
public void setItem_seq(int value){
	item_seq=value;
}

public int  getDel_yn(){
	return del_yn;
}
public  void setDel_yn(int value){
	del_yn=value;
}

public int  getGet_yn(){
	return get_yn;
}
public  void setGet_yn(int value){
	get_yn=value;
}

public int  getDel_yn_item(){
	return del_yn_item;
}
public  void setDel_yn_item(int value){
	del_yn_item=value;
}

public int getSign_01(){
	return sign_01;
}
public void setSign_01(int value){
	sign_01=value;
}

public int getSign_02(){
	return sign_02;
}
public void setSign_02(int value){
	sign_02=value;
}

public int getSign_03(){
	return sign_03;
}
public void setSign_03(int value){
	sign_03=value;
}

public int getSign_01_yn(){
	return sign_01_yn;
}
public void setSign_01_yn(int value){
	sign_01_yn=value;
}

public int getSign_02_yn(){
	return sign_02_yn;
}
public void setSign_02_yn(int value){
	sign_02_yn=value;
}

public int getSign_03_yn(){
	return sign_03_yn;
}
public void setSign_03_yn(int value){
	sign_03_yn=value;
}

public int getKind_urgency(){
	return kind_urgency;
}
public void setKind_urgency(int value){
	kind_urgency=value;
}

public String getContact_order(){
	return contact_order;
}
public  void setContact_order(String value){
	contact_order=value;
}

public String getComment(){
	return comment;
}
public  void setComment(String value){
	comment=value;
}

public String getHizuke(){
	return hizuke;
}
public  void setHizuke(String value){
	hizuke=value;
}

public String getTitle(){
	return title;
}
public  void setTitle(String value){
	title=value;
}

public String getProduct_nm(){
	return product_nm;
}
public void setProduct_nm(String value){
	product_nm=value;
}

public String getOrder_no(){
	return order_no;
}
public void setOrder_no(String value){
	order_no=value;
}

public int getProduct_qty(){
	return product_qty;
}
public void setProduct_qty(int value){
	product_qty=value;
}

public int getUnit_price(){
	return unit_price;
}
public void setUnit_price(int value){
	unit_price=value;
}

public int getTotal_price(){
	return total_price;
}
public void setTotal_price(int value){
	total_price=value;
}

public int getTotal_price_all(){
	return total_price_all;
}
public void setTotal_price_all(int value){
	total_price_all=value;
}


public Timestamp getRegister() {
  return register;
}
 public void setRegister(Timestamp value) {
   register = value;
 }

public int  getQty(){
	return qty;
}
public  void setQty(int value){
	qty=value;
}

public String getName(){
	return name;
}
public void setName(String value){
	name=value;
}
public int getClient_nm(){
	return client_nm;
}
public void setClient_nm(int value){
	client_nm=value;
}






}


