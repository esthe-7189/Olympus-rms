package mira.hokoku;

import java.sql.Timestamp;

public class DataBeanHokoku {
    private int seq,mseq,hokoku_content_seq,hokoku_seq,sign_ok_yn_boss,sign_ok_yn_bucho,level,position_level;    
    private Timestamp register;	
    private int sign_ok_mseq_boss,sign_ok_mseq_bucho,seqcnt;
	private String during_begin,during_end,nm,member_id,destination_info,destination;
	private String drive_yn,reason,comment,grade,danger,em_number;
	private String sign_no_riyu_boss,sign_no_riyu_bucho,sche_date,sche_comment,busho,mimg,mail_address,passportName;
	private int sign_ok_yn_bucho2,sign_ok_mseq_bucho2,rest_begin_hh,rest_begin_mm,rest_end_hh,rest_end_mm;
	private int plan_begin_hh,plan_begin_mm,plan_end_hh,plan_end_mm;
	private String theday,sign_no_riyu_bucho2,sign_no_riyu_kanribu;
	private int sign_ok_yn_kanribu,sign_ok_mseq_kanribu;
	private int kind_pg,signupline_seq,signup_mseq;
	private String title01,title02,title03,title04;

   

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

public int  getHokoku_content_seq(){
	return hokoku_content_seq;
}
public  void setHokoku_content_seq(int value){
	hokoku_content_seq=value;
}

public int  getHokoku_seq(){
	return hokoku_seq;
}
public  void setHokoku_seq(int value){
	hokoku_seq=value;
}

public int getSign_ok_yn_boss(){
	return sign_ok_yn_boss;
}
public void setSign_ok_yn_boss(int value){
	sign_ok_yn_boss=value;
}

public int getSign_ok_yn_bucho(){
	return sign_ok_yn_bucho;
}
public void setSign_ok_yn_bucho(int value){
	sign_ok_yn_bucho=value;
}

public String getSign_no_riyu_boss(){
	return sign_no_riyu_boss;
}
public  void setSign_no_riyu_boss(String value){
	sign_no_riyu_boss=value;
}

public String getSign_no_riyu_bucho(){
	return sign_no_riyu_bucho;
}
public  void setSign_no_riyu_bucho(String value){
	sign_no_riyu_bucho=value;
}

public int getSign_ok_mseq_boss(){
	return sign_ok_mseq_boss;
}
public void setSign_ok_mseq_boss(int value){
	sign_ok_mseq_boss=value;
}

public int getSign_ok_mseq_bucho(){
	return sign_ok_mseq_bucho;
}
public void setSign_ok_mseq_bucho(int value){
	sign_ok_mseq_bucho=value;
}

public String getComment(){
	return comment;
}
public  void setComment(String value){
	comment=value;
}

public String getDestination_info(){
	return destination_info;
}
public  void setDestination_info(String value){
	destination_info=value;
}

public String getDestination(){
	return destination;
}
public  void setDestination(String value){
	destination=value;
}

public String getDrive_yn(){
	return drive_yn;
}
public  void setDrive_yn(String value){
	drive_yn=value;
}

public String getReason(){
	return reason;
}
public  void setReason(String value){
	reason=value;
}

public String getGrade(){
	return grade;
}
public  void setGrade(String value){
	grade=value;
}

public String getDanger(){
	return danger;
}
public  void setDanger(String value){
	danger=value;
}

public String getEm_number() {
    return em_number;
}
public void setEm_number(String em_number) {
   this.em_number = em_number;
}

public String getSche_date(){
	return sche_date;
}
public  void setSche_date(String value){
	sche_date=value;
}

public String getSche_comment(){
	return sche_comment;
}
public  void setSche_comment(String value){
	sche_comment=value;
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

public String getBusho(){
	return busho;
}
public  void setBusho(String value){
	busho=value;
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

public Timestamp getRegister(){
	return register;
}
public  void setRegister(Timestamp value){
	register=value;
}

public int getSeqcnt(){
	return seqcnt;
}
public  void setSeqcnt(int value){
	seqcnt=value;
}

public String getMimg() {
    return mimg;
}
public void setMimg(String mimg) {
   this.mimg = mimg;
}    

public String getMail_address() {
  return mail_address;
}
public void setMail_address(String mail_address) {
  this.mail_address = mail_address;
}

public String getPassportName() {
  return passportName;
}
public void setPassportName(String passportName) {
  this.passportName = passportName;
}



public int getSign_ok_yn_bucho2(){ return sign_ok_yn_bucho2; }
public void setSign_ok_yn_bucho2(int value){sign_ok_yn_bucho2=value;}

public int getSign_ok_mseq_bucho2(){ return sign_ok_mseq_bucho2; }
public void setSign_ok_mseq_bucho2(int value){sign_ok_mseq_bucho2=value;}

public int getRest_begin_hh(){ return rest_begin_hh; }
public void setRest_begin_hh(int value){rest_begin_hh=value;}

public int getRest_begin_mm(){ return rest_begin_mm; }
public void setRest_begin_mm(int value){rest_begin_mm=value;}

public int getRest_end_hh(){ return rest_end_hh; }
public void setRest_end_hh(int value){rest_end_hh=value;}

public int getRest_end_mm(){ return rest_end_mm; }
public void setRest_end_mm(int value){rest_end_mm=value;}

public int getPlan_begin_hh(){ return plan_begin_hh; }
public void setPlan_begin_hh(int value){plan_begin_hh=value;}

public int getPlan_begin_mm(){ return plan_begin_mm; }
public void setPlan_begin_mm(int value){plan_begin_mm=value;}

public int getPlan_end_hh(){ return plan_end_hh; }
public void setPlan_end_hh(int value){plan_end_hh=value;}

public int getPlan_end_mm(){ return plan_end_mm; }
public void setPlan_end_mm(int value){plan_end_mm=value;}

public String getTheday(){return theday;}
public void setTheday(String value){theday=value;}  

public String getSign_no_riyu_bucho2(){return sign_no_riyu_bucho2;}
public void setSign_no_riyu_bucho2(String value){sign_no_riyu_bucho2=value;} 

public String getSign_no_riyu_kanribu(){return sign_no_riyu_kanribu;}
public void setSign_no_riyu_kanribu(String value){sign_no_riyu_kanribu=value;}  

public int getSign_ok_yn_kanribu(){ return sign_ok_yn_kanribu; }
public void setSign_ok_yn_kanribu(int value){sign_ok_yn_kanribu=value;}

public int getSign_ok_mseq_kanribu(){ return sign_ok_mseq_kanribu; }
public void setSign_ok_mseq_kanribu(int value){sign_ok_mseq_kanribu=value;}

public int getKind_pg(){ return kind_pg; }
public void setKind_pg(int value){kind_pg=value;}

public int getSignupline_seq(){ return signupline_seq; }
public void setSignupline_seq(int value){signupline_seq=value;}

public int getSignup_mseq(){ return signup_mseq; }
public void setSignup_mseq(int value){signup_mseq=value;}


public String getTitle01(){return title01;}
public void setTitle01(String value){title01=value;}  

public String getTitle02(){return title02;}
public void setTitle02(String value){title02=value;}  

public String getTitle03(){return title03;}
public void setTitle03(String value){title03=value;}  

public String getTitle04(){return title04;}
public void setTitle04(String value){title04=value;}  




}


