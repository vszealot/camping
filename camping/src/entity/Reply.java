package entity;

import java.util.Date;

public class Reply {
/*	postNo number not null,
	rNo number not null,
	content varchar2(2000) not null,
	nickName varchar2(30) not null,
	regDate date default sysdate*/
	private int postNo;
	private int rNo;
	private String content;
	private String nickName;
	private Date regDate;
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
}
