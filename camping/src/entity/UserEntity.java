package entity;

public class UserEntity {
	private String userId;
	private String userEmail;
	private String nickName;
	private String password;
	private String grade;
	//쪽지 수
	private int noteCnt;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	@Override
	public String toString() {
		return nickName;
	}
	//쪽지 수
	public int getNoteCnt() {
		return noteCnt;
	}
	public void setNoteCnt(int noteCnt) {
		this.noteCnt = noteCnt;
	}
	
	
}
