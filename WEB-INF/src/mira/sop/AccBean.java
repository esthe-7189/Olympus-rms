/*----------------------------------------------------------------｜
｜ 페이지명   : AccBean.java                            ｜
｜ 내용설명   : 번역 Entity 빈즈                              ｜
｜ 관련테이블 : accounting_file, accounting_down                                   ｜
｜ 작 성 자   :                                        ｜
｜----------------------------------------------------------------*/
package mira.sop;
import java.sql.Timestamp;

public class AccBean {
	
	private int seq,seq_tab,cate_seq,seq_acc,seq_mem;	
	private String filename;
	private int cate_L_seq;   //대분류 번호
	private int cate_M_seq;   //중분류 번호 
	private String title,cate_nm;	
	private String name,ip_add,name_tab;	
	private String content; 
	private Timestamp register; 	
	private int view_yn,hit_cnt,view_seq,junbang;

	
	

public int getSeq() {return seq;}
public void setSeq(int value) {seq = value;}

public int getSeq_tab() {return seq_tab;}
public void setSeq_tab(int value) {seq_tab = value;}

public int getCate_seq() {return cate_seq;}
public void setCate_seq(int value) {cate_seq = value;}

public int getCate_L_seq() {return cate_L_seq;}
public void setCate_L_seq(int value) {cate_L_seq = value;}
	
public int getCate_M_seq() {return cate_M_seq;}
public void setCate_M_seq(int value) {cate_M_seq = value;}

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

public String getName_tab() { return name_tab;}
public void setName_tab(String name_tab) {this.name_tab = name_tab;}

public String getIp_add() { return ip_add;}
public void setIp_add(String ip_add) {this.ip_add = ip_add;}

public String getContent() { return content;}
public void setContent(String content) {this.content = content;}

public Timestamp getRegister(){	return register;}
public void setRegister(Timestamp register){this.register = register;}

public int getView_yn() {return view_yn;}
public void setView_yn(int value) {view_yn = value;}

public int getHit_cnt() {return hit_cnt;}
public void setHit_cnt(int value) {hit_cnt = value;}

public int getView_seq() {return view_seq;}
public void setView_seq(int value) {view_seq = value;}	

public int getJunbang() {return junbang;}
public void setJunbang(int value){junbang=value;}

}
