package mira.kintai;

import java.sql.Timestamp;

public class DataBeanKintai {
    private int seq,mseq,sign_ok,sign_ok_mseq;    
    private Timestamp register;
    private String hizuke,sign_no_riyu;
	private int simya_hh, simya_mm;
    private int holiday_hh,holiday_mm;    
    private String oneday_holi,daikyu,daikyu_date;
	private int chikoku_hh, chikoku_mm;
    private int begin_hh, begin_mm, end_hh, end_mm,sum_hhmm,endval,beginval,seqcnt;
	private String riyu, comment, nm,member_id,em_number;

//	private int endvalS,beginvalS,seqcntS;
   
  
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

public int getSign_ok(){
	return sign_ok;
}
public void setSign_ok(int value){
	sign_ok=value;
}

public String getSign_no_riyu(){
	return sign_no_riyu;
}
public  void setSign_no_riyu(String value){
	sign_no_riyu=value;
}

public int getSign_ok_mseq(){
	return sign_ok_mseq;
}
public void setSign_ok_mseq(int value){
	sign_ok_mseq=value;
}

public String getHizuke(){
	return hizuke;
}
public  void setHizuke(String value){
	hizuke=value;
}

public int getSimya_hh(){
	return simya_hh;
}
public  void setSimya_hh(int value){
	simya_hh=value;
}

public int getSimya_mm(){
	return simya_mm;
}
public  void setSimya_mm(int value){
	simya_mm=value;
}

public int getHoliday_hh(){
	return holiday_hh;
}
public  void setHoliday_hh(int value){
	holiday_hh=value;
}

public int getHoliday_mm(){
	return holiday_mm;
}
public  void setHoliday_mm(int value){
	holiday_mm=value;
}

public String getOneday_holi(){
	return oneday_holi;
}
public  void setOneday_holi(String value){
	oneday_holi=value;
}

public String getDaikyu(){
	return daikyu;
}
public  void setDaikyu(String value){
	daikyu=value;
}

public String getDaikyu_date(){
	return daikyu_date;
}
public  void setDaikyu_date(String value){
	daikyu_date=value;
}

public int getChikoku_hh(){
	return chikoku_hh;
}
public  void setChikoku_hh(int value){
	chikoku_hh=value;
}

public int getChikoku_mm(){
	return chikoku_mm;
}
public  void setChikoku_mm(int value){
	chikoku_mm=value;
}

public int getBegin_hh(){
	return begin_hh;
}
public  void setBegin_hh(int value){
	begin_hh=value;
}

public int getBegin_mm(){
	return begin_mm;
}
public void setBegin_mm(int value){
	begin_mm=value;
}

public int getEnd_hh(){
	return end_hh;
}
public  void setEnd_hh(int value){
	end_hh=value;
}

public int getEnd_mm(){
	return end_mm;
}
public  void setEnd_mm(int value){
	end_mm=value;
}

public String getRiyu(){
	return riyu;
}
public  void setRiyu(String value){
	riyu=value;
}

public String getComment(){
	return comment;
}
public  void setComment(String value){
	comment=value;
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
	
public String getEm_number() {
        return em_number;
    }
public void setEm_number(String em_number) {
        this.em_number = em_number;
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


//*****리스트 day 잔여시간(분)
public int getSum_hhmm(){
	return sum_hhmm;
}
public  void setSum_hhmm(int value){
	sum_hhmm=value;
}

//*****리스트 총 잔여시간(분)
public int getEndval(){
	return endval;
}
public  void setEndval(int value){
	endval=value;
}

public int getBeginval(){
	return beginval;
}
public  void setBeginval(int value){
	beginval=value;
}



}


