/*----------------------------------------------------------------��
�� ��������   : Product_bean.java                            ��
�� ���뼳��   : ��ǰ���� Entity ����                              ��
�� �������̺� : tproduct                                   ��
�� �� �� ��   :                                        ��
��----------------------------------------------------------------*/
package mira.product;
import java.sql.Timestamp;

public class ProductBean {

    // Instance Variable
    private int  pseq,id;	
    private String pimg,pcode,title_m,title_s,content;   
	private Timestamp  register;	
	private int view_yn,category;


public int  getPseq(){return pseq;}
public  void setPseq(int value){pseq=value;}

public int  getId(){return id;}
public  void setId(int value){id=value;}

public String getPimg(){return pimg;}
public  void setPimg(String value){pimg=value;}

public int getCategory(){return category;}
public  void setCategory(int value){category=value;}

public String getPcode(){return pcode;}
public  void setPcode(String value){	pcode=value;}

public String getTitle_m(){return title_m;}
public  void setTitle_m(String value){title_m=value;}

public String getTitle_s(){return title_s;}
public  void setTitle_s(String value){title_s=value;}

public String getContent(){	return content;}
public  void setContent(String value){content=value;}

public Timestamp getRegister(){return register;}
public  void setRegister(Timestamp value){register=value;}

public int getView_yn(){return view_yn;}
public  void setView_yn(int  value){view_yn=value;}





}


