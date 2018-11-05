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

	// ��� ��ȸ
	@Override
	public List<Reply> readReply(Board board) throws Exception {
		String sql = "select * from " + board.getBoardName() + "Reply where postNo = " + board.getPostNo() + " ORDER BY rno";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		return factory.openSession().selectList("replyspace.readReply", map);
	}

	// ��� �ۼ�
	@Override
	public void writeReply(Board board, Reply reply) throws Exception {
		String sql = "insert into " + board.getBoardName() + "reply(postno, rno, content, nickname) values ("
				+ reply.getPostNo() + ",marketR_seq.nextval,'" + reply.getContent() + "','" + reply.getNickName()
				+ "')";
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().insert("replyspace.writeReply", map);
	}

	// ��� ����
	@Override
	public void deleteReply(Board board, Reply reply) throws Exception {
		String sql = "delete " + board.getBoardName() + "REPLY where rno=" + reply.getrNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		factory.openSession().delete("replyspace.deleteReply", map);

	}

	// �Խù� �� ��� ��
	@Override
	public int replyCount(Board board) throws Exception {
		String sql = "select count(postno) from "+board.getBoardName()+"Reply where postno="+ board.getPostNo();
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		return factory.openSession().selectOne("replyspace.replyCount", map);
	}

}
