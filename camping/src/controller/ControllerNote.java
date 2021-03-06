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
import entity.Page;
import entity.UserEntity;
import model.NoteDao;

@Controller
public class ControllerNote {
	@Autowired
	NoteDao noteDao;
	
	//받은 쪽지함 View로 이동
	@RequestMapping("/noteReceive.do")
	public String noteReceive(Model model) {
		return "note/noteReceive";
	}
	
	// 받은 쪽지 목록
	@RequestMapping(value = "/noteReceiveView.do")
	public ModelAndView noteReceiveView(@ModelAttribute Note note, Page page, HttpServletRequest request, Model model){
		HttpSession session= request.getSession();
		session.getAttribute("logOK");
		
		String name=session.getAttribute("logOK").toString();
		
//		List<Note> list= noteDao.noteReceiveView(name);
		
		//-----페이지 처리------------------------------------------------------------
		List<Note> list= noteDao.noteReceiveView2(name, page);
		page.setTotalCount(noteDao.listCount2(name));
		model.addAttribute("page", page);
		//-----페이지 처리------------------------------------------------------------
		
		if(!list.isEmpty()) {
//				System.out.println("ok");
			return new ModelAndView("note/noteReceive", "listNote", list);
		}else {
			return new ModelAndView("note/noteReceive", "listNote", list);
		}
	}
	
	//받은 쪽지 삭제하기
	@RequestMapping(value="/deleteRevMsg.do")
	public String deleteRevMsg(@ModelAttribute Note note, HttpServletRequest request) {
		// 받아온 제목들을 ,로 분리해서 배열에 넣기
		String[] str=request.getParameter("data").split(",");
		
		if(noteDao.deleteRevMsg(str)) {
			System.out.println("ok recv del");
		}
		
		return "note/noteReceive";
	}
	
	//받은 쪽지 중 읽은 쪽지 처리
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
	
	/*//받은 쪽지 개수 main.jsp에 출력
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
	
	//보낸 쪽지함 View로 이동
	@RequestMapping("/noteSend.do")
	public String noteSend(Model model) {
		return "note/noteSend";
	}
	
	//보낸 쪽지 목록
	@RequestMapping(value = "/noteSendView.do")
	public ModelAndView noteSendView(@ModelAttribute Note note, HttpServletRequest request, Page page, Model model){
		HttpSession session= request.getSession();
		session.getAttribute("logOK");
		
		String name=session.getAttribute("logOK").toString();
		
		//-----페이지 처리------------------------------------------------------------
		List<Note> list= noteDao.noteSentView2(name, page);
		page.setTotalCount(noteDao.listCount3(name));
		model.addAttribute("page", page);
				//-----페이지 처리------------------------------------------------------------
		if(!list.isEmpty()) {
//				System.out.println("ok");
			return new ModelAndView("note/noteSend", "listNote", list);
		}else {
			return new ModelAndView("note/noteSend", "listNote", list);
		}
	}
	
	//보낸 쪽지 삭제하기
	@RequestMapping(value="/deleteSentMsg.do")
	public String deleteSentMsg(@ModelAttribute Note note, HttpServletRequest request) {
		// 받아온 제목들을 ,로 분리해서 배열에 넣기
		String[] str=request.getParameter("data").split(",");
		
		if(noteDao.deleteSentMsg(str)) {
			System.out.println("ok sent del");
		}
		return "note/noteSend";
	}
	
	//==============================================================================
		
	//쪽지 상세보기 View로 이동
	@RequestMapping("/noteDetail.do")
	public String noteDetail(Model model) {
			return "note/noteDetail";
	}
	
	//==============================================================================
	
	//쪽지 보내기View이동
	@RequestMapping("/sendingNote.do")
	public String sendingNote(Model model) {
			return "note/sendingNote";
	}
	
	//쪽지 보내기
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
