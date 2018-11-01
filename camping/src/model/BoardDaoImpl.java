package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.Board;
import entity.Page;

@Repository
public class BoardDaoImpl implements BoardDao {
	@Autowired
	private SqlSessionFactory factory;

	// �ۼ�
	@Override
	public void write(Board board) throws Exception {
		String sql = "INSERT INTO " + board.getBoardName() + "Board(POSTNO, NICKNAME, TITLE, CONTENT, IMAGE) "
				+ "VALUES (" + board.getBoardName() + "_SEQ.NEXTVAL, '" + board.getNickName() + "', '"
				+ board.getTitle() + "', '" + board.getContent() + "', '" + board.getImage() + "')";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().insert("boardspace.write", map);
	}

	// ��ȸ
	@Override
	public Board read(Board board) throws Exception {
		String sql = "select * from " + board.getBoardName() + "board where postno=" + board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		return factory.openSession().selectOne("boardspace.read", map);
	}

	// ����
	@Override
	public void update(Board board) throws Exception {
		String sql = "update " + board.getBoardName() + "BOARD set title='" + board.getTitle() + "', content='"
				+ board.getContent() + "', image='" + board.getImage() + "' where postno=" + board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().update("boardspace.update", map);
	}

	// ����
	@Override
	public void delete(Board board) throws Exception {
		String sql = "DELETE FROM " + board.getBoardName() + "BOARD WHERE POSTNO=" + board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().delete("boardspace.delete", map);
	}

	// ���
	@Override
	public List<Board> list(Board board) throws Exception {
		String sql = "SELECT * FROM " + board.getBoardName() + "BOARD ORDER BY POSTNO DESC";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		return factory.openSession().selectList("boardspace.list", map);
	}

	// ��� + ����¡
	@Override
	public List<Board> list(Board board, Page page) throws Exception {
		String sql = "select * from (select postno, nickname, title, content, regdate, click, recommend, image, row_number() over(order by postno desc) "
				+ "as rNum from " + board.getBoardName() + "BOARD) mb where rNum between " + page.getRowStart()
				+ " and " + page.getRowEnd() + " order by postno desc";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		return factory.openSession().selectList("boardspace.listPage", map);
	}

	// �Խù� �� ����
	@Override
	public int listCount(Board board) throws Exception {
		String sql = "select count(postno) from " + board.getBoardName() + "board where postno > 0";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		return factory.openSession().selectOne("boardspace.listCount", map);
	}

	// ��� + ����¡ + �˻�
	@Override
	public List<Board> listSearch(Board board, Page page) throws Exception {
		String sql = "select * from (select postno, nickname, title, content, regdate, click, recommend, image, row_number() over(order by postno desc) "
				+ "as rNum from " + board.getBoardName() + "BOARD ";
		sql += check(page);
		sql += ") mb where rNum between " + page.getRowStart() + " and " + page.getRowEnd()
				+ " order by postno desc";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		return factory.openSession().selectList("boardspace.listSearch", map);
	}

	// �˻� �Խù� �� ����
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
		return factory.openSession().selectOne("boardspace.countSearch", map);
	}

	// �˻�Ÿ�� üũ
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

	@Override
	public void updateClick(Board board) throws Exception {
		String sql = "update "+board.getBoardName()+"board set click="+board.getClick()+" where postno="+board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().update("boardspace.updateClick", map);
	}

}
