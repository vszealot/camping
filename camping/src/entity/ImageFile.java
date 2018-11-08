package entity;

import java.util.Date;
import java.util.List;

public class ImageFile {
	private int IDX;
	private int postNo;
	private String nickName;
	private String ORIGINAL_FILE_NAME;
	private String STORED_FILE_NAME;
	private int FILE_SIZE;
	private Date regDate;
	private String DEL_GB;
	private List<ImageFile> list;

	public int getIDX() {
		return IDX;
	}

	public void setIDX(int iDX) {
		IDX = iDX;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getORIGINAL_FILE_NAME() {
		return ORIGINAL_FILE_NAME;
	}

	public void setORIGINAL_FILE_NAME(String oRIGINAL_FILE_NAME) {
		ORIGINAL_FILE_NAME = oRIGINAL_FILE_NAME;
	}

	public String getSTORED_FILE_NAME() {
		return STORED_FILE_NAME;
	}

	public void setSTORED_FILE_NAME(String sTORED_FILE_NAME) {
		STORED_FILE_NAME = sTORED_FILE_NAME;
	}

	public int getFILE_SIZE() {
		return FILE_SIZE;
	}

	public void setFILE_SIZE(int fILE_SIZE) {
		FILE_SIZE = fILE_SIZE;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getDEL_GB() {
		return DEL_GB;
	}

	public void setDEL_GB(String dEL_GB) {
		DEL_GB = dEL_GB;
	}

	public List<ImageFile> getList() {
		return list;
	}

	public void setList(List<ImageFile> list) {
		this.list = list;
	}

}
