package model;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.CampInfo;

@Repository
public class CampDao {

	@Autowired
	private SqlSessionFactory factory;

	public List<CampInfo> campList() {
		return factory.openSession().selectList("campspace.campList");
	}

}
