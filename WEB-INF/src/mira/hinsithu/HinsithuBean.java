package mira.hinsithu;
import java.sql.Timestamp;

public class HinsithuBean {
	
	private int no,bseq; 
	private int parentId; 
	private int file_kind; 
	private String filename; 
	private String f_title; 
	private String cate_code;
	private String cate_code_det, cate_code_s;
	private String fname;
	private String fname_digi;
	private String fname_bun;
	private String basho;
	private String basho_digi;
	private String basho_bun;
	private String content; 
	private Timestamp register; 
	private int readNo;
	private int kind_yn, view_yn;
	private int parentMoto; 
	private int groupId;
    private int orderNo;
    private int level;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}	
public int getBseq() {return bseq;}
public void setBseq(int value) {bseq = value;}

public int getParentId() {return parentId;}
public void setParentId(int value) {parentId = value;}

public int getParentMoto() {return parentMoto;}
public void setParentMoto(int value) {parentMoto = value;}

public int getView_yn() {return view_yn;}
public void setView_yn(int value) {view_yn = value;}

	public int getFile_kind() {
		return file_kind;
	}
	public void setFile_kind(int file_kind) {
		this.file_kind = file_kind;
	}
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getF_title() {
		return f_title;
	}
	public void setF_title(String f_title) {
		this.f_title = f_title;
	}
	
	public String getCate_code(){
		return cate_code;
	}
	public void setCate_code(String cate_code){
		this.cate_code=cate_code;
	}

	public String getCate_code_det(){
		return cate_code_det;
	}
	public void setCate_code_det(String cate_code_det){
		this.cate_code_det=cate_code_det;
	}

	public String getCate_code_s(){
		return cate_code_s;
	}
	public void setCate_code_s(String cate_code_s){
		this.cate_code_s=cate_code_s;
	}

	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getFname_digi() {
		return fname_digi;
	}
	public void setFname_digi(String fname_digi) {
		this.fname_digi = fname_digi;
	}

	public String getFname_bun() {
		return fname_bun;
	}
	public void setFname_bun(String fname_bun) {
		this.fname_bun = fname_bun;
	}

	public String getBasho() {
		return basho;
	}
	public void setBasho(String basho) {
		this.basho = basho;
	}

	public String getBasho_digi() {
		return basho_digi;
	}
	public void setBasho_digi(String basho_digi) {
		this.basho_digi = basho_digi;
	}

	public String getBasho_bun() {
		return basho_bun;
	}
	public void setBasho_bun(String basho_bun) {
		this.basho_bun = basho_bun;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content= content;
	}


	public Timestamp getRegister() {
		return register;
	}
	public void setRegister(Timestamp register) {
		this.register = register;
	}
	
	public int getReadNo() {
		return readNo;
	}
	public void setReadNo(int readNo) {
		this.readNo = readNo;
	}

	public int getKind_yn() {
		return kind_yn;
	}
	public void setKind_yn(int kind_yn) {
		this.kind_yn = kind_yn;
	}

	 public int getGroupId() {
        return groupId;
    }
    public void setGroupId(int value) {
        groupId = value;
    }
    
    public int getLevel() {
        return level;
    }
    public void setLevel(int value) {
        level = value;
    }

    public int getOrderNo() {
        return orderNo;
    }
	public void setOrderNo(int value) {
        orderNo = value;
    }
}
