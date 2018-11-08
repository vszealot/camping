package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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



	
	
	
	
}
