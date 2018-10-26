package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.CampInfo;
import entity.Page;

@Repository
public class CampDao {

	@Autowired
	private SqlSessionFactory factory;

	// Ä·ÇÁ¸®½ºÆ® =================================================================
	public List<CampInfo> campList() {
		return factory.openSession().selectList("campspace.campList");
	}

	// Ä·ÇÁ¸®½ºÆ® + ÆäÀÌÂ¡ =========================================================
	public List<CampInfo> campListPage(Page page) {
		return factory.openSession().selectList("campspace.campListPage", page);
	}

	// Ä·ÇÁ¸®½ºÆ® ÃÑ °¹¼ö ==========================================================
	public int campListCount() {
		return factory.openSession().selectOne("campspace.campListCount");
	}

	// °Ë»ö¸®½ºÆ® ÃÑ °¹¼ö ==========================================================
	public int searchListCount(Page page) {
		String sql = "select count(campname) from CAMPING_TEST where campname like '%" + page.getSearchWord()
				+ "%' or addr1 like '%" + page.getSearchWord() + "%' or addr2 like '%" + page.getSearchWord() + "%'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.searchListCount", map);
	}

	// °Ë»ö¸®½ºÆ® + ÆäÀÌÂ¡ ==========================================================
	public List<CampInfo> searchListPage(Page page) {

		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (SELECT *FROM CAMPING_TEST WHERE CAMPNAME like '%"
				+ page.getSearchWord() + "%' OR ADDR1 like '%" + page.getSearchWord() + "%' OR ADDR2 like '%"
				+ page.getSearchWord() + "%')AA)WHERE RN>=" + page.getRowStart() + "AND RN<=" + page.getRowEnd();
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.searchListPage", map);
	}

	public List<CampInfo> searchListMap(Page page) {
		String sql = "select * from CAMPING_TEST where campname like '%" + page.getSearchWord()
		+ "%' or addr1 like '%" + page.getSearchWord() + "%' or addr2 like '%" + page.getSearchWord() + "%'";
		
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.searchListMap", map);
	}

}
