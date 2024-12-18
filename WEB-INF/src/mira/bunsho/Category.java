package mira.bunsho;

import java.sql.Timestamp;

public class Category {
    private int bseq;
    private int groupId;
    private int orderNo;
    private int level,kind;
    private int parentId,cateNo;    
    private String name;
	private String title;
	private String content,add_ip;
	private Timestamp register;
	private int kind_yn;
	private int hit_cnt, henji_yn, ok_yn;  
	private String mail_address;   
	private int file_kind; 
	private int file_bseq; 
	private String password;

   

    public int getGroupId() {
        return groupId;
    }
    public int getBseq() {
        return bseq;
    }
    
    public int getLevel() {
        return level;
    }
	public int getKind() {
        return kind;
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
	public int getCateNo() {
        return cateNo;
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
	 public void setKind(int value) {
        kind = value;
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
	 public void setCateNo(int value) {
        cateNo = value;
    }
   

   /**************/
   public int getKind_yn() {
		return kind_yn;
	}
	public void setKind_yn(int kind_yn) {
		this.kind_yn = kind_yn;
	}

	 public String getTitle() {
        return title;
    }
	public void setTitle(String value) {
        title = value;
    }
	
	 public String getContent() {
        return content;
    }
	public void setContent(String value) {
        content = value;
    }	

	 public Timestamp getRegister() {
        return register;
    }
	 public void setRegister(Timestamp value) {
        register = value;
    }

	public int getHit_cnt() {
        return hit_cnt;
    }
	public void setHit_cnt(int value) {
        hit_cnt = value;
    }	

	 public String getMail_address() {
        return mail_address;
    }
	public void setMail_address(String value) {
        mail_address = value;
    }

	public String getAdd_ip() {
        return add_ip;
    }
	public void setAdd_ip(String value) {
        add_ip = value;
    }

	public int getHenji_yn() {
        return henji_yn;
    }
	public void setHenji_yn(int value) {
        henji_yn = value;
    }

	public int getOk_yn() {
        return ok_yn;
    }
	public void setOk_yn(int value) {
        ok_yn = value;
    }

	public int getFile_bseq() {
		return file_bseq;
	}
	public void setFile_bseq(int file_bseq) {
		this.file_bseq = file_bseq;
	}

	public int getFile_kind() {
		return file_kind;
	}
	public void setFile_kind(int file_kind) {
		this.file_kind = file_kind;
	}

	public String getPassword() {
        return password;
    }
	public void setPassword(String value) {
        password = value;
    }

}