package model;

import java.util.List;

import entity.Board;
import entity.Page;

public interface BoardDao {
	// �ۼ�
	public void write(Board board) throws Exception;

	// ��ȸ
	public Board read(Board board) throws Exception;

	// ����
	public void update(Board board) throws Exception;

	// ����
	public void delete(Board board) throws Exception;

	// ���
	public List<Board> list(Board board) throws Exception;
	
	// ��� + ����¡
	public List<Board> list(Board board,Page page) throws Exception;
	
	// �Խù� �� ����
	public int listCount(Board board) throws Exception;
	
	// ��� + ����¡ + �˻�
	public List<Board> listSearch(Board board, Page page) throws Exception;
	
	// �˻� �Խù� �� ����
	public int countSearch(Board board, Page page) throws Exception;
	
	// ��ȸ�� ����
	public void updateClick(Board board) throws Exception;
}
