package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.Board;
import entity.Reply;

@Repository
public class ReplyDaoImpl implements ReplyDao {
	@Autowired
	private SqlSessionFactory factory;

	// 댓글 조회
	@Override
	public List<Reply> readReply(Board board) throws Exception {
		String sql = "select * from " + board.getBoardName() + "Reply where postNo = " + board.getPostNo() + " ORDER BY rno";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		List<Reply> back = factory.openSession().selectList("replyspace.readReply", map);
		factory.openSession().close();
		return back;
		
		
	}

	// 댓글 작성
	@Override
	public void writeReply(Board board, Reply reply) throws Exception {
		String sql = "insert into " + board.getBoardName() + "reply(postno, rno, content, nickname) values ("
				+ reply.getPostNo() + ","+board.getBoardName()+"R_seq.nextval,'" + reply.getContent() + "','" + reply.getNickName()
				+ "')";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().insert("replyspace.writeReply", map);
	}

	// 댓글 삭제
	@Override
	public void deleteReply(Board board, Reply reply) throws Exception {
		String sql = "delete " + board.getBoardName() + "REPLY where rno=" + reply.getrNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().delete("replyspace.deleteReply", map);
		factory.openSession().close();

	}

	// 게시물 별 댓글 수
	@Override
	public int replyCount(Board board) throws Exception {
		String sql = "select count(postno) from "+board.getBoardName()+"Reply where postno="+ board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		int back = factory.openSession().selectOne("replyspace.replyCount", map);
		factory.openSession().close();
		return back;
	}

	// 추천 수 갱신
	@Override
	public void updateRecommend(Board board) throws Exception {
		try {
			String sql = "insert into "+board.getBoardName()+"Recommend values ("+board.getPostNo()+",'"+board.getNickName()+"')";
			Map<String, String> map = new HashMap<>();
			map.put("sql", sql);
			factory.openSession().insert("replyspace.updateRecommend", map);
			factory.openSession().close();
		}catch (Exception e) {
			String sql2 = "delete "+board.getBoardName()+"RECOMMEND where nickname='" + board.getNickName() + "' and postno=" + board.getPostNo();
			Map<String, String> map = new HashMap<>();
			map.put("sql", sql2);
			factory.openSession().delete("replyspace.deleteRecommend", map);
			factory.openSession().close();
		}
	}

}
