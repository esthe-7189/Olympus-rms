package mira.jangyo;

import java.sql.Timestamp;

public class DataBeanJangyo {
    private int seq,mseq,sign_ok,sign_ok_mseq;    
    private Timestamp register;
    private String hizuke,busho;
	private String riyu,sign_no_riyu, comment, nm,member_id;

    private int begin_hh, begin_mm, end_hh, end_mm,sum_hhmm,endval,beginval,seqcnt;
   
  
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

public String getSign_no_riyu(){
	return sign_no_riyu;
}
public  void setSign_no_riyu(String value){
	sign_no_riyu=value;
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

public String getBusho() {
        return busho;
    }
    public void setBusho(String busho) {
        this.busho = busho;
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


