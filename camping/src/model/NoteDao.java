package model;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.Note;

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

	

	
	
	
	
}
