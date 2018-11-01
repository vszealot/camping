package model;

import java.util.List;

import entity.Board;
import entity.Reply;

public interface ReplyDao {
	
	// ´ñ±Û Á¶È¸
	public List<Reply> readReply(Board board) throws Exception;
	
	// ´ñ±Û ÀÛ¼º
	public void writeReply(Board board, Reply reply) throws Exception;
	
	// ´ñ±Û »èÁ¦
	public void deleteReply(Board board, Reply reply) throws Exception;
	
	// °Ô½Ã¹° º° ´ñ±Û ¼ö
	public int replyCount(Board board) throws Exception;
	
}
