package model;

import java.util.List;

import entity.Board;
import entity.CampInfo;
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

	// ��õ �� ����
	public void updateRecommend(Board board) throws Exception;
	
	// ķ�� ��õ �� ����
	public int reccount(CampInfo campInfo) throws Exception;

	// ķ�� ��õ �� ����
	public void campUpdateRecommend(CampInfo campInfo, Board board) throws Exception;
	
}
