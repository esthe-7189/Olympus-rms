/*----------------------------------------------------------------��
�� ��������   :Newsbean.java                            ��
�� ���뼳��   : Entity ����                              ��
�� �������̺� : news                                   ��
�� �� �� ��   :                                        ��
��----------------------------------------------------------------*/
package mira.contact;

import java.sql.Timestamp;

public class NewsBean {
   
    private int  seq;	
    private String title;          
    private String content;    
	private Timestamp  register;
	private int  cnt;	
    private int  view_yn;
    
	
	

public int  getSeq(){
	return seq;
}
public  void setSeq(int value){
	seq=value;
}


public String getTitle(){
	return title;
}
public  void setTitle(String value){
	title=value;
}

public String getContent(){
	return content;
}
public  void setContent(String value){
	content=value;
}

public Timestamp getRegister(){
	return register;
}
public  void setRegister(Timestamp value){
	register=value;
}

public int getCnt(){
	return cnt;
}
public  void setCnt(int  value){
	cnt=value;
}
public  int  getView_yn(){
	return view_yn;
}
public  void setView_yn(int value){
	view_yn=value;
}

}


