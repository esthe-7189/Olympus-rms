/*----------------------------------------------------------------｜
｜ 페이지명   :DataBean.java                            ｜
｜ 내용설명   : Entity 빈즈                              ｜
｜ 관련테이블 : schedule                                   ｜
｜ 작 성 자   :                                        ｜
｜----------------------------------------------------------------*/
package mira.kaigi;

import java.sql.Timestamp;

public class DataBean {
   private int  seq,mseq,kaigi_seq,fellow_seq,view_seq,kintai_seq,basho;   
   private String during_begin,jikan_begin,bun_begin,during_end,jikan_end,bun_end,title;
   private String password, nm,member_id,nm_sanseki,busho,mail_address;	
   private Timestamp  register;
   private String ichinichi_begin,ichinichi_end;

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

public int  getKaigi_seq(){
	return kaigi_seq;
}
public  void setKaigi_seq(int value){
	kaigi_seq=value;
}


public int getFellow_seq(){
	return fellow_seq;
}
public void setFellow_seq(int value){
	fellow_seq=value;
}

public int getView_seq(){
	return view_seq;
}
public void setView_seq(int value){
	view_seq=value;
}

public int getKintai_seq(){
	return kintai_seq;
}
public void setKintai_seq(int value){
	kintai_seq=value;
}

public int getBasho() {
        return basho;
}
public void setBasho(int basho) {
        this.basho = basho;
}  


public String getDuring_begin(){
	return during_begin;
}
public  void setDuring_begin(String value){
	during_begin=value;
}

public String getDuring_end(){
	return during_end;
}
public  void setDuring_end(String value){
	during_end=value;
}

public String getJikan_begin(){
	return jikan_begin;
}
public  void setJikan_begin(String value){
	jikan_begin=value;
}

public String getJikan_end(){
	return jikan_end;
}
public  void setJikan_end(String value){
	jikan_end=value;
}

public String getBun_begin(){
	return bun_begin;
}
public  void setBun_begin(String value){
	bun_begin=value;
}

public String getBun_end(){
	return bun_end;
}
public  void setBun_end(String value){
	bun_end=value;
}

public String getTitle(){
	return title;
}
public  void setTitle(String value){
	title=value;
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

public String getMember_id() {
      return member_id;
}
public void setMember_id(String member_id) {       
    this.member_id = member_id;
 }

public String getNm_sanseki() {
        return nm_sanseki;
 }
public void setNm_sanseki(String nm_sanseki) {
        this.nm_sanseki = nm_sanseki ;
} 

public String getMail_address() {
        return mail_address;
 }
public void setMail_address(String mail_address) {
        this.mail_address = mail_address ;
} 

public String getBusho() {
        return busho;
 }
public void setBusho(String busho) {
        this.busho = busho ;
} 

public Timestamp getRegister(){
	return register;
}
public  void setRegister(Timestamp value){    
	register=value;
}




public String getIchinichi_begin() {
        return ichinichi_begin;
}
public void setIchinichi_begin(String ichinichi_begin) {
        this.ichinichi_begin = ichinichi_begin;
}  

public String getIchinichi_end() {
        return ichinichi_end;
}
public void setIchinichi_end(String ichinichi_end) {
        this.ichinichi_end = ichinichi_end;
}  

}
