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

	// 캠프리스트 =================================================================
	public List<CampInfo> campList() {
		return factory.openSession().selectList("campspace.campList");
	}
	
	// 카라반리스트 =================================================================
		public List<CampInfo> carvanList() {
			return factory.openSession().selectList("campspace.carvanList");
		}

	// 캠프리스트 + 페이징 =========================================================
	public List<CampInfo> campListPage(Page page) {
		return factory.openSession().selectList("campspace.campListPage", page);
	}

	// 카라반리스트 + 페이징 =========================================================
	public List<CampInfo> carvanListPage(Page page) {
		return factory.openSession().selectList("campspace.carvanListPage", page);
	}

	// 캠프리스트 총 갯수 ==========================================================
	public int campListCount() {
		return factory.openSession().selectOne("campspace.campListCount");
	}

	// 카라반리스트 총 갯수 ==========================================================
	public int carvanListCount() {
		return factory.openSession().selectOne("campspace.carvanListCount");
	}

	public List<CampInfo> selectedListPage(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (SELECT *FROM CAMPING_TEST WHERE addr1 like '%"
				+ page.getSearchWord() + "%' or campname like '%" + page.getSearchWord() + "%' or addr2 like '%"
				+ page.getSearchWord() + "%')AA)WHERE RN>=" + page.getRowStart() + " AND RN<=" + page.getRowEnd();
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.selectedListPage", map);
	}
	
	
	public List<CampInfo> selected_carvanListPage(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (SELECT *FROM (select * from CAMPING_TEST where camptype='자동차야영장') WHERE addr1 like '%"
				+ page.getSearchWord() + "%' or campname like '%" + page.getSearchWord() + "%' or addr2 like '%"
				+ page.getSearchWord() + "%')AA)WHERE RN>=" + page.getRowStart() + " AND RN<=" + page.getRowEnd();
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.selected_carvanListPage", map);
	}

	// 검색리스트 총 갯수 ==========================================================
	public int searchListCount(Page page) {
		String sql = "select count(campname) from CAMPING_TEST where campname like '%" + page.getSearchWord()
				+ "%' or addr1 like '%" + page.getSearchWord() + "%' or addr2 like '%" + page.getSearchWord() + "%'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.searchListCount", map);
	}
	
	// 카라반 검색리스트 총 갯수 ==========================================================
		public int search_carvanListCount(Page page) {
			String sql = "select count(campname) from (select * from CAMPING_TEST where camptype='자동차야영장') where campname like '%" + page.getSearchWord()
					+ "%' or addr1 like '%" + page.getSearchWord() + "%' or addr2 like '%" + page.getSearchWord() + "%'";

			Map<String, String> map = new HashMap<>();

			map.put("sql", sql);
			return factory.openSession().selectOne("campspace.search_carvanListCount", map);
		}
	
	
	
	// 검색리스트 + 페이징 ==========================================================
	public List<CampInfo> searchListPage(Page page) {

		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (SELECT *FROM CAMPING_TEST WHERE CAMPNAME like '%"
				+ page.getSearchWord() + "%' OR ADDR1 like '%" + page.getSearchWord() + "%' OR ADDR2 like '%"
				+ page.getSearchWord() + "%')AA)WHERE RN>=" + page.getRowStart() + "AND RN<=" + page.getRowEnd();
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.searchListPage", map);
	}
	
	
	// 카라반 검색리스트 + 페이징 ==========================================================
		public List<CampInfo> search_carvanListPage(Page page) {

			String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (SELECT *FROM (select * from CAMPING_TEST where camptype='자동차야영장')  WHERE CAMPNAME like '%"
					+ page.getSearchWord() + "%' OR ADDR1 like '%" + page.getSearchWord() + "%' OR ADDR2 like '%"
					+ page.getSearchWord() + "%')AA)WHERE RN>=" + page.getRowStart() + "AND RN<=" + page.getRowEnd();
			Map<String, String> map = new HashMap<>();

			map.put("sql", sql);
			return factory.openSession().selectList("campspace.search_carvanListPage", map);
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
		System.out.println(addr);
		String sql = "update camping_test set searchcount = searchcount+1 where addr1='" + addr + "'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		factory.openSession().update("campspace.inquiry", map);
		factory.openSession().close();
	}

	public List<CampInfo> inquirySeq(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (select * from camping_TEST order by searchcount desc)AA)WHERE RN>="
				+ page.getRowStart() + " AND RN<=" + page.getRowEnd();

		System.out.println(sql);
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.inquiryseq", map);

	}
	
	//카라반 조회순
	public List<CampInfo> inquiry_carvanSeq(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (select * from (select * from camping_TEST where camptype='자동차야영장') order by searchcount desc)AA)WHERE RN>="
				+ page.getRowStart() + " AND RN<=" + page.getRowEnd();

		System.out.println(sql);
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.inquiry_carvanseq", map);

	}

	public int inqiryCount() {
		String sql = "select count(campname) from camping_TEST order by searchcount desc";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.inquiryCount", map);
	}
	
	public int inqiry_carvanCount() {
		String sql = "select count(campname) from (select * from camping_TEST where camptype='자동차야영장') order by searchcount desc";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.inquiry_carvanCount", map);
	}


	public CampInfo campinfo(String addr1) {
		String sql = "select * from CAMPING_TEST where addr1='" + addr1 + "'";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.campinfo", map);

	}
	
	
	public int campinsert(CampInfo campInfo) {
		String sql = "insert into camping_TEST (campName,campType,x,y,addr1,phone,siteNum,conv,useTime,usePee,image,searchcount,recommendcount) "
				+ "values('"+campInfo.getCampName()+"','"+campInfo.getCampType()+"',"+campInfo.getX()+","+campInfo.getY()+",'"+campInfo.getAddr1()+"','"+campInfo.getPhone()+"',"+campInfo.getSiteNum()+",'"+campInfo.getConv()+"','"+campInfo.getUseTime()+"','"+campInfo.getUsePee()+"','"+campInfo.getImage()+"',"+campInfo.getSearchcount()+","+campInfo.getRecommendcount()+")";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().insert("campspace.insertcamp", map);
	}

	public int recommendCount() {
		String sql = "select count(campname) from camping_TEST order by recommendcount desc";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.recommendCount", map);
	}

	public List<CampInfo> recommendSeq(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (select * from camping_TEST order by recommendcount desc)AA)WHERE RN>="
				+ page.getRowStart() + " AND RN<=" + page.getRowEnd();

		System.out.println(sql);
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.recommendseq", map);
	}

	public int recommendcarvanCount() {
		String sql = "select count(campname) from (select * from camping_TEST where camptype='자동차야영장') order by recommendcount desc";

		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectOne("campspace.recommendcarvanCount", map);
	}

	public List<CampInfo> recommendcarvanSeq(Page page) {
		String sql = "SELECT * FROM (SELECT ROWNUM RN, AA.* FROM (select * from (select * from camping_TEST where camptype='자동차야영장') order by recommendcount desc)AA)WHERE RN>="
				+ page.getRowStart() + " AND RN<=" + page.getRowEnd();

		System.out.println(sql);
		Map<String, String> map = new HashMap<>();

		map.put("sql", sql);
		return factory.openSession().selectList("campspace.recommendcarvanseq", map);
	}

}
