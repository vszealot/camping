package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import entity.Note;
import entity.UserEntity;
import model.NoteDao;

@Controller
public class ControllerNote {
	@Autowired
	NoteDao noteDao;
	
	//���� ������ View�� �̵�
	@RequestMapping("/noteReceive.do")
	public String noteReceive(Model model) {
		return "note/noteReceive";
	}
	
	// ���� ���� ���
	@RequestMapping(value = "/noteReceiveView.do")
	public ModelAndView noteReceiveView(@ModelAttribute Note note, HttpServletRequest request){
		HttpSession session= request.getSession();
		session.getAttribute("logOK");
		
		String name=session.getAttribute("logOK").toString();
		
		List<Note> list= noteDao.noteReceiveView(name);

		if(!list.isEmpty()) {
//				System.out.println("ok");
			return new ModelAndView("note/noteReceive", "listNote", list);
		}else {
			return new ModelAndView("note/noteReceive", "listNote", list);
		}
	}
	
	//���� ���� �����ϱ�
	@RequestMapping(value="/deleteRevMsg.do")
	public String deleteRevMsg(@ModelAttribute Note note, HttpServletRequest request) {
		// �޾ƿ� ������� ,�� �и��ؼ� �迭�� �ֱ�
		String[] str=request.getParameter("data").split(",");
		
		if(noteDao.deleteRevMsg(str)) {
			System.out.println("ok recv del");
		}
		
		return "note/noteReceive";
	}
	
	//���� ���� �� ���� ���� ó��
	@RequestMapping(value="/readUnread.do")
	public String readUnread(@ModelAttribute Note note, @ModelAttribute UserEntity userEntity,HttpServletRequest request) {
		
		String str=request.getParameter("data");

		if(noteDao.readUnread(str)) {
			int n=noteDao.cntRecv(request.getParameter("data2"));
			System.out.println(n);
			
			HttpSession session= request.getSession();
			userEntity=(UserEntity) session.getAttribute("logOK");
//			System.out.println(userEntity.getNickName());
//			System.out.println(userEntity.getNoteCnt());
			userEntity.setNoteCnt(n);
//			System.out.println(userEntity.getNoteCnt());
		}
		return "../main";
	}
	
	/*//���� ���� ���� main.jsp�� ���
	@RequestMapping(value="/cntRecv.do")
	public ModelAndView cntRecv(@ModelAttribute Note note, HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.getAttribute("logOK");
		
		String name=session.getAttribute("logOK").toString();
		
		int cnt=noteDao.cntRecv(name);
		System.out.println(cnt);
		return new ModelAndView("../main", "cntRecv", cnt);
	}*/
	
	
	//==============================================================================
	
	//���� ������ View�� �̵�
	@RequestMapping("/noteSend.do")
	public String noteSend(Model model) {
		return "note/noteSend";
	}
	
	//���� ���� ���
	@RequestMapping(value = "/noteSendView.do")
	public ModelAndView noteSendView(@ModelAttribute Note note, HttpServletRequest request){
		HttpSession session= request.getSession();
		session.getAttribute("logOK");
		
		String name=session.getAttribute("logOK").toString();
		
		List<Note> list= noteDao.noteSendView(name);
		if(!list.isEmpty()) {
//				System.out.println("ok");
			return new ModelAndView("note/noteSend", "listNote", list);
		}else {
			return new ModelAndView("note/noteSend", "listNote", list);
		}
	}
	
	//���� ���� �����ϱ�
	@RequestMapping(value="/deleteSentMsg.do")
	public String deleteSentMsg(@ModelAttribute Note note, HttpServletRequest request) {
		// �޾ƿ� ������� ,�� �и��ؼ� �迭�� �ֱ�
		String[] str=request.getParameter("data").split(",");
		
		if(noteDao.deleteSentMsg(str)) {
			System.out.println("ok sent del");
		}
		return "note/noteSend";
	}
	
	//==============================================================================
		
	//���� �󼼺��� View�� �̵�
	@RequestMapping("/noteDetail.do")
	public String noteDetail(Model model) {
			return "note/noteDetail";
	}
	
	//==============================================================================
	
	//���� ������View�̵�
	@RequestMapping("/sendingNote.do")
	public String sendingNote(Model model) {
			return "note/sendingNote";
	}
	
	//���� ������
	@RequestMapping("/sendingNoteFunc.do")
	public ModelAndView sendingNoteFunc(@ModelAttribute Note note, HttpServletRequest request) {
		if(noteDao.sendingNoteFunc(note)>0) {
			
			HttpSession session= request.getSession();
			session.getAttribute("logOK");
			
			String name=session.getAttribute("logOK").toString();
			
			List<Note> list= noteDao.noteReceiveView(name);
			return new ModelAndView("note/noteReceive", "listNote", list);
		}else {
			return new ModelAndView("note/noteReceive");
		}
		
	}
	
}
