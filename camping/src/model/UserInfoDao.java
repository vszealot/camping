package model;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.UserEntity;

@Repository
public class UserInfoDao {
	@Autowired
	private SqlSessionFactory factory;

	public List<UserEntity> userInfoView() {
	
		return factory.openSession().selectList("usernamespace.userInfoView");
	}

	public boolean userGradeUpdate(UserEntity userEntity) {
		
		return (factory.openSession().update("usernamespace.userGradeUpdate",userEntity) > 0) ? true:false;
	}

	public boolean userDelete(UserEntity userEntity) {
	
		return (factory.openSession().delete("usernamespace.userDelete",userEntity) > 0) ? true:false;
	}

	
	
	
	
	
}
