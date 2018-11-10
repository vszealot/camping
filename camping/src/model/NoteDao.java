package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.Board;
import entity.Note;
import entity.Page;

@Repository
public class NoteDao {
	@Autowired
	private SqlSessionFactory factory;

	public List<Note> noteReceiveView(String name) {
		
		return factory.openSession().selectList("notenamespace.noteReceiveView",name);
	}

	public List<Note> noteSendView(String name) {
		
		return factory.openSession().selectList("notenamespace.noteSendView",name);
	}

	public int sendingNoteFunc(Note note) {
		
		return factory.openSession().insert("notenamespace.sendingNoteFunc",note);
	}

	public boolean deleteRevMsg(String[] str) {
		int n=0;
		
		for(int i=0; i<str.length; i++) {
			// ���� ����� ������ ������(sent_del='N'�̸�) �ٲ�
			n=factory.openSession().update("notenamespace.deleteRevMsg",str[i]);
			
			if(n>0) {
				continue;
			}else {
				// ���� ����� �������� �ƿ� ����
				n=factory.openSession().delete("notenamespace.deleteMsg",str[i]);
			}
		}
		return (n>0)? true:false;
	}

	public boolean deleteSentMsg(String[] str) {
		int n=0;
		
		for(int i=0; i<str.length; i++) {
			// ���� ����� ������ ������(sent_del='N'�̸�) �ٲ�
			n=factory.openSession().update("notenamespace.deleteSentMsg",str[i]);
			
			if(n>0) {
				continue;
			}else {
				// ���� ����� �������� �ƿ� ����
				n=factory.openSession().delete("notenamespace.deleteMsg",str[i]);
			}
		}
		return (n>0)? true:false;
	}

	public boolean readUnread(String str) {
		
		int n=factory.openSession().update("notenamespace.readUnread",str);
		
		return (n>0)? true:false;
	}

	public int cntRecv(String name) {
		
		return factory.openSession().selectOne("notenamespace.cntRecv",name);
	}

	//===============================================================================
	
	//������ ó�� ��� View
	public List<Note> noteReceiveView2(String name, Page page) {
		String sql="select * from (select notenum,recv_name,sent_name,title,note,date_sent,date_read,recv_read,recv_del,sent_del,row_number()"
				+ " over(order by notenum desc) as rNum from notes where recv_name='"+name+"' AND recv_del='N') mb "
						+ "where rNum between "+page.getRowStart()+" and "+page.getRowEnd()+" order by noteNum desc";
		
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		
		List<Note> back = factory.openSession().selectList("notenamespace.noteReceiveView2", map);
		factory.openSession().close();
		return back;
	}

	public int listCount2(String name) {
		String sql="SELECT COUNT(NOTENUM) FROM NOTES WHERE NOTENUM > 0 AND RECV_NAME='"+name+"' AND RECV_DEL='N'";
		
		Map<String, String> map = new HashMap<>();
		map.put("sql", sql);
		int back = factory.openSession().selectOne("notenamespace.listCount", map);
		factory.openSession().close();
		return back;
	}
	
	
	
	
	
	
	
	
	
	
	
}
