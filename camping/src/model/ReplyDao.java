package model;

import java.util.List;

import entity.Board;
import entity.Reply;

public interface ReplyDao {
	
	// ��� ��ȸ
	public List<Reply> readReply(Board board) throws Exception;
	
	// ��� �ۼ�
	public void writeReply(Board board, Reply reply) throws Exception;
	
	// ��� ����
	public void deleteReply(Board board, Reply reply) throws Exception;
	
	// �Խù� �� ��� ��
	public int replyCount(Board board) throws Exception;
	
}
