package mira.board;

import java.sql.Timestamp;

public class Board {
    private int bseq;
    private int groupId;
    private int orderNo;
    private int level;
    private int parentId,kind;
    private Timestamp register;
    private String name;
    private String mail_address;    
    private String password;
    private String title;
    private String content,add_ip;
	private int hit_cnt;  
	private int mseq,pw_yn,mail_yn,view_yn;
    
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
    public String getName() {
        return name;
    }
    public int getOrderNo() {
        return orderNo;
    }
    public int getParentId() {
        return parentId;
    }
	public int getKind() {
        return kind;
    }
    public String getPassword() {
        return password;
    }
    public Timestamp getRegister() {
        return register;
    }
    public String getTitle() {
        return title;
    }
    public String getContent() {
        return content;
    }
	public int getHit_cnt() {
        return hit_cnt;
    }
	public int getMseq() {
        return mseq;
    }
	
	public int getPw_yn() {
        return pw_yn;
    }
	public int getView_yn() {
        return view_yn;
    }
	public int getMail_yn() {
        return mail_yn;
    }
	public String getAdd_ip() {
        return add_ip;
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
	public void setKind(int value) {
        kind = value;
    }
    public void setPassword(String value) {
        password = value;
    }
    public void setRegister(Timestamp value) {
        register = value;
    }
    public void setTitle(String value) {
        title = value;
    }
    public void setContent(String value) {
        content = value;
    }	 
	public void setMseq(int value) {
        mseq = value;
    }
	public void setHit_cnt(int value) {
        hit_cnt = value;
    }	
	
	public void setMail_yn(int value) {
        mail_yn = value;
    }
	public void setPw_yn(int value) {
        pw_yn = value;
    }
	public void setView_yn(int value) {
        view_yn = value;
    }
	public void setAdd_ip(String value) {
        add_ip = value;
    }


}