package model;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.UserEntity;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionFactory factory;

	public boolean joinUser(UserEntity userEntity) {
		int n=factory.openSession().insert("usernamespace.insertUserEntity", userEntity);
		return (n>0)?true:false;
	}

	public UserEntity loginUser(UserEntity userEntity) {
		
		return factory.openSession().selectOne("usernamespace.loginUserEntity", userEntity);
	}

	public int checkId(String userId) {
		
		return factory.openSession().selectOne("usernamespace.checkId", userId);
	}

	public int checkNickname(String nickName) {
		return factory.openSession().selectOne("usernamespace.checkNickname", nickName);
	}

	public String findId(UserEntity entity) {
		
		return factory.openSession().selectOne("usernamespace.findingId",entity);
	}

	public String findingPassword(UserEntity entity) {

		return factory.openSession().selectOne("usernamespace.findingPassword",entity);
	}

	public boolean updateUser(UserEntity entity) {
		int n=factory.openSession().update("usernamespace.updateUserEntity", entity);
		return (n>0)?true:false;
	}

	// ��й�ȣ ��ġ�ϴ��� üũ
	public int checkPassword(String password) {

		return factory.openSession().selectOne("usernamespace.checkpassword", password);
	}

	//ȸ�� Ż��
	public boolean deleteUser(UserEntity entity) {
		int n=factory.openSession().delete("usernamespace.deleteUserEntity", entity);
		return (n>0)?true:false;
	}


	
}
