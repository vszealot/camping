package model;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.CampInfo;
import entity.Page;

@Repository
public class CampDao {

	@Autowired
	private SqlSessionFactory factory;

	//		ķ������Ʈ		=================================================================
	public List<CampInfo> campList() {
		return factory.openSession().selectList("campspace.campList");
	}
	
	//		ķ������Ʈ + ����¡	=========================================================
	public List<CampInfo> campListPage(Page page) {
		return factory.openSession().selectList("campspace.campListPage", page);
	}
	
	//		ķ������Ʈ �� ����		==========================================================
	public int campListCount() {
		return factory.openSession().selectOne("campspace.campListCount");
	}

}
