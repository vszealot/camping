package model;

import java.util.List;

import entity.Board;
import entity.Page;

public interface BoardDao {
	// 작성
	public void write(Board board) throws Exception;

	// 조회
	public Board read(Board board) throws Exception;

	// 수정
	public void update(Board board) throws Exception;

	// 삭제
	public void delete(Board board) throws Exception;

	// 목록
	public List<Board> list(Board board) throws Exception;
	
	// 목록 + 페이징
	public List<Board> list(Board board,Page page) throws Exception;
	
	// 게시물 총 갯수
	public int listCount(Board board) throws Exception;
	
	// 목록 + 페이징 + 검색
	public List<Board> listSearch(Board board, Page page) throws Exception;
	
	// 검색 게시물 총 갯수
	public int countSearch(Board board, Page page) throws Exception;
	
	// 조회수 증가
	public void updateClick(Board board) throws Exception;
}
