/*----------------------------------------------------------------｜
｜ 페이지명   :DataBean.java                            ｜
｜ 내용설명   : Entity 빈즈                              ｜
｜ 관련테이블 : schedule                                   ｜
｜ 작 성 자   :                                        ｜
｜----------------------------------------------------------------*/
package mira.schedule;

import java.sql.Timestamp;

public class DataBean {
   
    private int  seq, sseq, mseq, sign_ok, schedule_seq,kintai_seq,jangyo_seq,view_seq,hokoku_seq,hokoku_trip_seq,hokoku_holiday_seq;	
	private String during_begin,during_end;  
    private String title; 
	private String password, nm,member_id,mimg,ichinichi_begin,ichinichi_end,basho,basho_detail,mail_address;	
	private Timestamp  register;	
    
	

public int  getSeq(){
	return seq;
}
public  void setSeq(int value){
	seq=value;
}

public int  getSseq(){
	return sseq;
}
public  void setSseq(int value){
	sseq=value;
}

public int  getMseq(){
	return mseq;
}
public  void setMseq(int value){
	mseq=value;
}

public int getSign_ok(){
	return sign_ok;
}
public void setSign_ok(int value){
	sign_ok=value;
}

public int getSchedule_seq(){
	return schedule_seq;
}
public void setSchedule_seq(int value){
	schedule_seq=value;
}

public int getKintai_seq(){
	return kintai_seq;
}
public void setKintai_seq(int value){
	kintai_seq=value;
}

public int getJangyo_seq(){
	return jangyo_seq;
}
public void setJangyo_seq(int value){
	jangyo_seq=value;
}
public int getHokoku_seq(){
	return hokoku_seq;
}
public void setHokoku_seq(int value){
	hokoku_seq=value;
}

public int getHokoku_trip_seq(){
	return hokoku_trip_seq;
}
public void setHokoku_trip_seq(int value){
	hokoku_trip_seq=value;
}

public int getHokoku_holiday_seq(){
	return hokoku_holiday_seq;
}
public void setHokoku_holiday_seq(int value){
	hokoku_holiday_seq=value;
}



public int getView_seq(){
	return view_seq;
}
public void setView_seq(int value){
	view_seq=value;
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

public String getMimg() {
        return mimg;
}
public void setMimg(String mimg) {
        this.mimg = mimg;
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

public String getBasho() {
        return basho;
}
public void setBasho(String basho) {
        this.basho = basho;
}  
public String getBasho_detail() {
        return basho_detail;
}
public void setBasho_detail(String basho_detail) {
        this.basho_detail = basho_detail;
}  

public String getMail_address() {
        return mail_address;
}
public void setMail_address(String mail_address) {
        this.mail_address = mail_address;
}  

public Timestamp getRegister(){
	return register;
}
public  void setRegister(Timestamp value){
	register=value;
}


}


