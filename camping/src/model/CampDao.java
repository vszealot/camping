package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.CampInfo;
import entity.Page;
import entity.tour;
import entity.weather;

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

	public List<CampInfo> selectedListPage(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (SELECT *FROM CAMPING_TEST WHERE addr1 like '%"
				+ page.getSearchWord() + "%' or campname like '%" + page.getSearchWord() + "%' or addr2 like '%"
				+ page.getSearchWord() + "%')AA)WHERE RN>=" + page.getRowStart() + " AND RN<=" + page.getRowEnd();
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.selectedListPage", map);
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
		String sql = "select * from CAMPING_TEST where campname like '%" + page.getSearchWord() + "%' or addr1 like '%"
				+ page.getSearchWord() + "%' or addr2 like '%" + page.getSearchWord() + "%'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.searchListMap", map);
	}

	public weather campWeather(List weatherAddr) {

		// System.out.println(weatherAddr.get(0).toString());
		String sql = "select grid_x, grid_y from weather where stage_1='" + weatherAddr.get(0).toString()
				+ "' and stage_2='" + weatherAddr.get(1).toString() + "' and stage_3= '" + weatherAddr.get(2).toString()
				+ "'";
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.weatherMap", map);
	}

	public List<weather> campWeather2(List weatherAddr) {

		// System.out.println(weatherAddr.get(0).toString());
		String sql = "select grid_x, grid_y from weather where stage_1='" + weatherAddr.get(0).toString()
				+ "' and stage_2='" + weatherAddr.get(1).toString() + "'";
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.weatherMap", map);
	}

	public tour tourCategory(tour tour) {
		String sql = "select cat1, cat2, cat3 from tourDB where catcode1='" + tour.getCatcode1() + "'and catcode2='"
				+ tour.getCatcode2() + "'and catcode3='" + tour.getCatcode3() + "'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);

		return factory.openSession().selectOne("campspace.tourMap", map);

	}

	public void inquiryUp(String addr) {
		String sql = "update camping_test set searchcount = searchcount+1 where addr1='" + addr + "'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		factory.openSession().update("campspace.inquiry", map);
		factory.openSession().close();
	}

	public List<CampInfo> inquirySeq(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (select * from camping_TEST order by searchcount desc)AA)WHERE RN>=" + page.getRowStart() + " AND RN<=" + page.getRowEnd();
				
				System.out.println(sql);
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.inquiryseq", map);

	}

	public int inqiryCount() {
		String sql = "select count(campname) from CAMPING_TEST order by searchcount desc";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.inquiryCount", map);
	}

	public  CampInfo campinfo(String addr1) {
		String sql = "select * from CAMPING_TEST where addr1='"+addr1+"'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.campinfo", map);
		
	}

}
