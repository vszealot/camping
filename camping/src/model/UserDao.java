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

	
}
