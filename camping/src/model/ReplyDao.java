package model;

import java.util.List;

import entity.Board;
import entity.Reply;

public interface ReplyDao {
	
	// 댓글 조회
	public List<Reply> readReply(Board board) throws Exception;
	
	// 댓글 작성
	public void writeReply(Board board, Reply reply) throws Exception;
	
	// 댓글 삭제
	public void deleteReply(Board board, Reply reply) throws Exception;
	
	// 게시물 별 댓글 수
	public int replyCount(Board board) throws Exception;

	// 추천 수 갱신
	public void updateRecommend(Board board) throws Exception;
	
}
