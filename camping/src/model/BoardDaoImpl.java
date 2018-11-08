package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import entity.Board;
import entity.ImageFile;
import entity.Page;

@Repository
public class BoardDaoImpl implements BoardDao {
	@Autowired
	private SqlSessionFactory factory;
	@Autowired
	private FileUtils fileUtils;

	// 작성
	@Override
	public void write(Board board, MultipartHttpServletRequest request) throws Exception {
		String sql = "INSERT INTO " + board.getBoardName() + "Board(POSTNO, NICKNAME, TITLE, CONTENT, IMAGE) "
				+ "VALUES (" + board.getBoardName() + "_SEQ.NEXTVAL, '" + board.getNickName() + "', '"
				+ board.getTitle() + "', '" + board.getContent() + "', '" + board.getImage() + "')";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().insert("boardspace.write", map);
		factory.openSession().close();
		
		String sql2 ="select postNo from "+board.getBoardName()+"board where rownum=1 order by postNo desc";
		map.put("sql2", sql2);
		board.setPostNo(factory.openSession().selectOne("boardspace.postNo", map));
		factory.openSession().close();
		
		Map<String, String> map2 = new HashMap<>();
        List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(board, request);
        for(Map<String,Object> i : list){
        	String sql3 = "insert into "+board.getBoardName()+"FILE(idx, postNo, nickname, ORIGINAL_FILE_NAME, STORED_FILE_NAME, FILE_SIZE) "
        			+ "values("+board.getBoardName()+"file_seq.nextval,"+board.getPostNo()+",'"+board.getNickName()+"',"
        			+ "'"+String.valueOf(i.get("ORIGINAL_FILE_NAME"))+"','"+String.valueOf(i.get("STORED_FILE_NAME"))+"',"+String.valueOf(i.get("FILE_SIZE"))+")";
        	map2.put("sql", sql3);
        	factory.openSession().insert("boardspace.insertfile", map2);
        	factory.openSession().close();
        }

	}

	// 조회
	@Override
	public Board read(Board board) throws Exception {
		String sql = "select * from (select postno, nickname, title, content, regdate, click, image, "
				+ "(select count(*) from "+board.getBoardName()+"recommend c where c.postno=a.postno) reccnt from " + board.getBoardName() + "BOARD a) "
				+ "mb where postno = " + board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		Board back = factory.openSession().selectOne("boardspace.read", map);
		factory.openSession().close();
		return back;
	}

	// 수정
	@Override
	public void update(Board board, MultipartHttpServletRequest request, Map<String,ImageFile> mapmap) throws Exception {
		String sql = "update " + board.getBoardName() + "BOARD set title='" + board.getTitle() + "', content='"
				+ board.getContent() + "', image='" + board.getImage() + "' where postno=" + board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().update("boardspace.update", map);
		factory.openSession().close();
		
		String sql2 ="UPDATE "+board.getBoardName()+"FILE SET DEL_GB = 'Y' WHERE postno="+board.getPostNo();
		map.put("sql2", sql2);
		factory.openSession().update("boardspace.deleteFile",map);
		factory.openSession().close();
		
		Map<String, String> map2 = new HashMap<>();
	    List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(board, request, mapmap);
	    Map<String,Object> tempMap = null;
	    
	    for(int i=0, size=list.size(); i<size; i++){
	        tempMap = list.get(i);
	        
	        if(tempMap.get("IS_NEW").equals("Y")){
	        	String sql3 = "insert into "+board.getBoardName()+"FILE(idx, postNo, nickname, ORIGINAL_FILE_NAME, STORED_FILE_NAME, FILE_SIZE) "
	        			+ "values("+board.getBoardName()+"file_seq.nextval,"+board.getPostNo()+",'"+board.getNickName()+"',"
	        			+ "'"+String.valueOf(tempMap.get("ORIGINAL_FILE_NAME"))+"','"+String.valueOf(tempMap.get("STORED_FILE_NAME"))+"',"+String.valueOf(tempMap.get("FILE_SIZE"))+")";
	        	map2.put("sql", sql3);
	        	factory.openSession().insert("boardspace.insertfile", map2);
	        	factory.openSession().close();
	        }
	        if(tempMap.get("IS_NEW").equals("N")){
	        	String sql4 = "UPDATE "+board.getBoardName()+"FILE SET DEL_GB = 'N' WHERE idx=" + String.valueOf(tempMap.get("FILE_IDX"));
	        	map2.put("sql2", sql4);
	        	System.out.println(sql4);
	        	factory.openSession().update("boardspace.updatefile", map2);
	        	factory.openSession().close();
	        }
	    }

	}

	// 삭제
	@Override
	public void delete(Board board) throws Exception {
		String sql = "DELETE FROM " + board.getBoardName() + "BOARD WHERE POSTNO=" + board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().delete("boardspace.delete", map);
		factory.openSession().close();
	}

	// 목록
	@Override
	public List<Board> list(Board board) throws Exception {
		String sql = "SELECT * FROM " + board.getBoardName() + "BOARD ORDER BY POSTNO DESC";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		List<Board> back = factory.openSession().selectList("boardspace.list", map);
		factory.openSession().close();
		return back;
	}

	// 목록 + 페이징
	@Override
	public List<Board> list(Board board, Page page) throws Exception {
		String sql = "select * from (select postno, nickname, title, content, regdate, click, recommend, image, row_number() over(order by postno desc) "
				+ "as rNum from " + board.getBoardName() + "BOARD) mb where rNum between " + page.getRowStart()
				+ " and " + page.getRowEnd() + " order by postno desc";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		
		List<Board> back = factory.openSession().selectList("boardspace.listPage", map);
		factory.openSession().close();
		return back;
	}

	// 게시물 총 갯수
	@Override
	public int listCount(Board board) throws Exception {
		String sql = "select count(postno) from " + board.getBoardName() + "board where postno > 0";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		int back = factory.openSession().selectOne("boardspace.listCount", map);
		factory.openSession().close();
		return back;
	}

	// 목록 + 페이징 + 검색
	@Override
	public List<Board> listSearch(Board board, Page page) throws Exception {
		String sql = "select * from (select postno, nickname, title, content, regdate, click, recommend, image, "
				+ "(select count(*) from "+board.getBoardName()+"recommend c where c.postno=a.postno) reccnt, "
				+ "(select count(*) from "+board.getBoardName()+"REPLY b where b.postno=a.postno) repcnt,row_number() over(order by postno desc) "
				+ "as rNum from " + board.getBoardName() + "BOARD a ";
		sql += check(page);
		sql += ") mb where rNum between " + page.getRowStart() + " and " + page.getRowEnd()
				+ " order by postno desc";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		List<Board> back = factory.openSession().selectList("boardspace.listSearch", map);
		factory.openSession().close();
		return back;
	}

	// 검색 게시물 총 갯수
	@Override
	public int countSearch(Board board, Page page) throws Exception {
		String sql = "select count(postno) from " + board.getBoardName() + "Board ";
		sql += check(page);
		if (check(page).equals("")) {
			sql += "where postno > 0";
		} else {
			sql += " and postno > 0";
		}
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		int back = factory.openSession().selectOne("boardspace.countSearch", map);
		factory.openSession().close();
		return back;
	}

	// 검색타입 체크
	public String check(Page page) {
		switch (page.getSearchType()) {
		case "t":
			return "where title like '%' || '" + page.getKeyword() + "' || '%'";
		case "c":
			return "where content like '%' || '" + page.getKeyword() + "' || '%'";
		case "n":
			return "where nickName like '%' || '" + page.getKeyword() + "' || '%'";
		case "tc":
			return "where (title like '%' || '" + page.getKeyword() + "' || '%') or (content like '%' || '"
					+ page.getKeyword() + "' || '%')";
		default:
			return "";
		}
	}

	// 조회수
	@Override
	public void updateClick(Board board) throws Exception {
		String sql = "update "+board.getBoardName()+"board set click="+board.getClick()+" where postno="+board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().update("boardspace.updateClick", map);
		factory.openSession().close();
	}

	// 이미지 주소 조회
	@Override
	public List<ImageFile> readImage(Board board) throws Exception {
		String sql = "select * from "+board.getBoardName()+"file where postNo=" + board.getPostNo() + "AND DEL_GB = 'N'";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		List<ImageFile> image = factory.openSession().selectList("boardspace.readImage", map);
		factory.openSession().close();
		return image;
	}

}
