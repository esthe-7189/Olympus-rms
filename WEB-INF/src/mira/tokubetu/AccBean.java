/*----------------------------------------------------------------｜
｜ 페이지명   : AccBean.java                            ｜
｜ 내용설명   : 번역 Entity 빈즈                              ｜
｜ 관련테이블 : accounting_file, accounting_down                                   ｜
｜ 작 성 자   :                                        ｜
｜----------------------------------------------------------------*/
package mira.tokubetu;
import java.sql.Timestamp;

public class AccBean {
	
	private int seq,cate_seq,seq_acc,seq_mem;	
	private String filename; 
	private String title,cate_nm;	
	private String name,ip_add;	
	private String comment,sekining_nm; 
	private Timestamp register; 	
	private int view_yn,hit_cnt,sekining_mseq;
	
	

public int getSeq() {return seq;}
public void setSeq(int value) {seq = value;}

public int getCate_seq() {return cate_seq;}
public void setCate_seq(int value) {cate_seq = value;}

public int getSeq_acc() {return seq_acc;}
public void setSeq_acc(int value) {seq_acc = value;}

public int getSeq_mem() {return seq_mem;}
public void setSeq_mem(int value) {seq_mem = value;}

public String getFilename() { return filename;}
public void setFilename(String filename) {this.filename = filename;}

public String getTitle() { return title;}
public void setTitle(String title) {this.title = title;}

public String getCate_nm() { return cate_nm;}
public void setCate_nm(String cate_nm) {this.cate_nm = cate_nm;}

public String getName() { return name;}
public void setName(String name) {this.name = name;}

public String getIp_add() { return ip_add;}
public void setIp_add(String ip_add) {this.ip_add = ip_add;}

public String getComment() { return comment;}
public void setComment(String comment) {this.comment = comment;}

public Timestamp getRegister(){	return register;}
public void setRegister(Timestamp register){this.register = register;}

public int getView_yn() {return view_yn;}
public void setView_yn(int value) {view_yn = value;}

public int getHit_cnt() {return hit_cnt;}
public void setHit_cnt(int value) {hit_cnt = value;}

public int getSekining_mseq() {return sekining_mseq;}
public void setSekining_mseq(int value) {sekining_mseq = value;}	

public String getSekining_nm() { return sekining_nm;}
public void setSekining_nm(String sekining_nm) {this.sekining_nm = sekining_nm;}
}
